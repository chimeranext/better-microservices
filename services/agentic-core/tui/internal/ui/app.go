package ui

import (
	"fmt"
	"strings"
	"time"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"

	"github.com/lapc506/agentic-core/tui/internal/api"
	"github.com/lapc506/agentic-core/tui/internal/models"
	"github.com/lapc506/agentic-core/tui/internal/types"
)

type Tab int

const (
	TabChat Tab = iota
	TabDashboard
	TabAgents
	TabSettings
	tabCount = 4
)

type connectedMsg struct{ status string }

type AppModel struct {
	client        *api.Client
	baseURL       string
	modelsURL     string
	tab           Tab
	chat          ChatModel
	dashboard     DashboardModel
	agents        AgentsModel
	settings      SettingsModel
	width         int
	height        int
	status        string
	showTree      bool
	treeRoot      *TreeNode
	queue         *QueueModel
	activity      *ActivityModel
	overlays      OverlayModel
	state         types.AgentState
	slash         *SlashHandler
	currentModel  string
	provider      string
	modelRegistry *models.Registry
}

func NewAppModel(baseURL string, model string, provider string, modelsURL ...string) AppModel {
	client := api.NewClient(baseURL)
	client.Provider = provider
	queue := NewQueueModel()
	activity := NewActivityModel()
	slash := NewSlashHandler()
	registryModelsURL := ""
	if len(modelsURL) > 0 {
		registryModelsURL = modelsURL[0]
	}
	modelRegistry := models.NewRegistry(baseURL, "", 0, registryModelsURL)
	models.DefaultRegistry = modelRegistry

	agentName := model
	if idx := strings.Index(model, "/"); idx >= 0 {
		parts := strings.SplitN(model, "/", 2)
		agentName = parts[len(parts)-1]
		if idx2 := strings.Index(agentName, ":"); idx2 >= 0 {
			agentName = agentName[:idx2]
		}
	} else if idx := strings.Index(model, ":"); idx >= 0 {
		agentName = model[:idx]
	}

	sampleTree := &TreeNode{
		ID: "root", Label: "Session", Status: "running", Expanded: true,
		Children: []*TreeNode{
			{ID: "p1", Label: "Planner", Status: "completed", Expanded: false},
			{
				ID: "e1", Label: "Executor", Status: "running", Expanded: true,
				Children: []*TreeNode{
					{ID: "t1", Label: "Tool: read_file", Status: "completed"},
					{ID: "t2", Label: "Tool: write_file", Status: "running"},
				},
			},
		},
	}

	return AppModel{
		client:        client,
		baseURL:       baseURL,
		chat:          NewChatModel(client, agentName, &queue, &activity),
		dashboard:     NewDashboardModel(),
		agents:        NewAgentsModel(client),
		settings:      NewSettingsModel(baseURL),
		status:        "connecting...",
		state:         types.AgentStarting,
		treeRoot:      sampleTree,
		queue:         &queue,
		activity:      &activity,
		slash:         slash,
		currentModel:  model,
		provider:      provider,
		modelRegistry: modelRegistry,
	}
}

func (m AppModel) Init() tea.Cmd {
	client := m.client
	return tea.Batch(
		m.chat.Init(),
		m.agents.Init(),
		func() tea.Msg {
			health, err := client.Health()
			if err != nil {
				return connectedMsg{status: "offline"}
			}
			return connectedMsg{status: health.Status}
		},
	)
}

func (m AppModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	if m.overlays.IsActive() {
		return m.updateOverlay(msg)
	}

	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height
		m.overlays.SetWidth(msg.Width)
		m.overlays.SetHeight(msg.Height)

	case tea.KeyPressMsg:
		return m.handleKey(msg)

	case connectedMsg:
		m.status = msg.status
		if msg.status == "ok" {
			m.state = types.AgentReady
		}

	case DashboardData:
		var cmd tea.Cmd
		m.dashboard, cmd = m.dashboard.Update(msg)
		return m, cmd

	case slashCmdMsg:
		return m.handleSlash(msg)

	case statusUpdateMsg:
		m.state = types.AgentState(msg.Text)

	case streamDoneMsg:
		chat, cmd := m.chat.Update(msg)
		m.chat = chat.(ChatModel)
		chatModel := m.chat
		if !chatModel.streaming && chatModel.queue.Len() > 0 {
			if next, ok := chatModel.queue.Dequeue(); ok {
				chatModel.messages = append(chatModel.messages, types.ChatMessage{Role: "user", Content: next})
				chatModel.streaming = true
				chatModel.state = types.AgentThinking
				chatModel.startTime = time.Now()
				chatModel.messages = append(chatModel.messages, types.ChatMessage{Role: "assistant", Content: ""})
				m.chat = chatModel
				m.chat.updateViewport()
				var cmds []tea.Cmd
				cmds = append(cmds, cmd)
				cmds = append(cmds, m.chat.sendMessage())
				cmds = append(cmds, m.chat.tickElapsed())
				return m, tea.Batch(cmds...)
			}
		}
		return m, cmd

	default:
		var cmd tea.Cmd
		switch m.tab {
		case TabChat:
			m.chat, cmd = m.chat.Update(msg)
		case TabDashboard:
			m.dashboard, cmd = m.dashboard.Update(msg)
		case TabAgents:
			m.agents, cmd = m.agents.Update(msg)
		case TabSettings:
			m.settings, cmd = m.settings.Update(msg)
		}
		return m, cmd
	}

	var cmd tea.Cmd
	switch m.tab {
	case TabChat:
		m.chat, cmd = m.chat.Update(msg)
	case TabDashboard:
		m.dashboard, cmd = m.dashboard.Update(msg)
	case TabAgents:
		m.agents, cmd = m.agents.Update(msg)
	case TabSettings:
		m.settings, cmd = m.settings.Update(msg)
	}
	return m, cmd
}

func (m AppModel) handleSlash(msg slashCmdMsg) (tea.Model, tea.Cmd) {
	switch msg.Command {
	case "help":
		m.overlays.ShowHelp()

	case "clear", "new":
		m.chat.messages = nil
		m.activity.Clear()
		m.queue.Clear()
		m.state = types.AgentReady
		m.chat.state = types.AgentReady
		m.chat.streaming = false

	case "quit", "exit", "q":
		return m, tea.Quit

	case "model":
		items := m.modelRegistry.FormatPickerItems()
		m.overlays.ShowModelPicker(items)

	case "queue":
		if m.queue.Len() == 0 {
			m.chat.messages = append(m.chat.messages, types.ChatMessage{
				Role: "system", Content: "No queued messages.",
			})
		} else {
			items := m.queue.Items()
			var info strings.Builder
			info.WriteString(fmt.Sprintf("Queued messages (%d):", len(items)))
			for i, item := range items {
				info.WriteString(fmt.Sprintf("\n  %d. %s", i+1, item.Content))
			}
			m.chat.messages = append(m.chat.messages, types.ChatMessage{
				Role: "system", Content: info.String(),
			})
		}
		m.chat.updateViewport()

	case "retry":
		if len(m.chat.messages) >= 2 {
			m.chat.messages = m.chat.messages[:len(m.chat.messages)-1]
			lastUserMsg := ""
			for i := len(m.chat.messages) - 1; i >= 0; i-- {
				if m.chat.messages[i].Role == "user" {
					lastUserMsg = m.chat.messages[i].Content
					break
				}
			}
			if lastUserMsg != "" {
				m.chat.streaming = true
				m.chat.state = types.AgentThinking
				m.chat.messages = append(m.chat.messages, types.ChatMessage{Role: "assistant", Content: ""})
				m.chat.updateViewport()
				return m, tea.Batch(m.chat.sendMessage(), m.chat.tickElapsed())
			}
		}

	case "undo":
		if len(m.chat.messages) >= 2 {
			m.chat.messages = m.chat.messages[:len(m.chat.messages)-2]
			if len(m.chat.messages) > 0 && m.chat.messages[len(m.chat.messages)-1].Role == "system" {
				m.chat.messages = m.chat.messages[:len(m.chat.messages)-1]
			}
		}
		m.chat.updateViewport()

	case "refresh":
		go m.modelRegistry.Refresh()
		m.chat.messages = append(m.chat.messages, types.ChatMessage{
			Role: "system", Content: "Refreshing model list from models.dev...",
		})
		m.chat.updateViewport()

	case "details":
		m.activity.ToggleExpanded()

	default:
		m.chat.messages = append(m.chat.messages, types.ChatMessage{
			Role: "system", Content: fmt.Sprintf("Unknown command: /%s. Type /help for available commands.", msg.Command),
		})
		m.chat.updateViewport()
	}

	return m, nil
}

func (m AppModel) updateOverlay(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyPressMsg:
		key := msg.String()
		switch key {
		case "up", "k":
			m.overlays.CursorUp()
		case "down", "j":
			m.overlays.CursorDown()
		case "enter":
			if m.overlays.Type() == OverlayModelPicker {
				selected := m.overlays.SelectedRaw()
				if selected != "" {
					m.switchModel(selected)
				}
			}
			m.overlays.Close()
		case "esc":
			if m.overlays.Type() == OverlayModelPicker && m.overlays.Filter() != "" {
				m.overlays.ClearFilter()
			} else {
				m.overlays.Close()
			}
		case "ctrl+c":
			m.overlays.Close()
		default:
			if m.overlays.Type() == OverlayModelPicker {
				if !m.overlays.HandleFilterKey(key) {
					// alphanumeric not matched by HandleFilterKey, close on any other key
				}
			} else if m.overlays.Type() == OverlayHelp {
				m.overlays.Close()
			}
		}
	}
	return m, nil
}

func (m *AppModel) switchModel(model string) {
	if idx := strings.Index(model, " ("); idx >= 0 {
		model = model[:idx]
	}
	m.currentModel = model

	parts := strings.SplitN(model, "/", 2)
	agentName := model
	if len(parts) > 1 {
		provider := parts[0]
		modelName := parts[1]
		if idx2 := strings.Index(modelName, ":"); idx2 >= 0 {
			agentName = modelName[:idx2]
		} else {
			agentName = modelName
		}
		m.client.Provider = provider
	} else {
		m.client.Provider = ""
	}

	m.chat.agent = agentName
	m.chat.messages = append(m.chat.messages, types.ChatMessage{
		Role: "system", Content: fmt.Sprintf("Switched to model: %s", model),
	})
	m.chat.updateViewport()
}

func (m AppModel) handleKey(msg tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "ctrl+c":
		if m.chat.streaming {
			m.chat.streaming = false
			m.chat.state = types.AgentInterrupted
			m.state = types.AgentInterrupted
			m.chat.updateViewport()
			return m, nil
		}
		draft := strings.TrimSpace(m.chat.input.Value())
		if draft != "" {
			m.chat.input.Reset()
			return m, nil
		}
		return m, tea.Quit

	case "ctrl+d":
		return m, tea.Quit

	case "ctrl+l":
		m.chat.messages = nil
		m.activity.Clear()
		m.queue.Clear()
		m.state = types.AgentReady
		m.chat.state = types.AgentReady
		m.chat.streaming = false
		m.chat.updateViewport()
		return m, nil

	case "esc":
		if m.chat.streaming {
			m.chat.streaming = false
			m.chat.state = types.AgentInterrupted
			m.state = types.AgentInterrupted
			m.chat.updateViewport()
			return m, nil
		}

	case "tab":
		m.tab = (m.tab + 1) % tabCount
	case "shift+tab":
		m.tab = (m.tab + tabCount - 1) % tabCount

	default:
		if !m.inputFocused() {
			switch msg.String() {
			case "q":
				return m, tea.Quit
			case "d":
				m.tab = TabDashboard
			case "c":
				m.tab = TabChat
			case "a":
				m.tab = TabAgents
			case "s":
				m.tab = TabSettings
			case "T":
				m.showTree = !m.showTree
			case "?":
				m.overlays.ShowHelp()
			case "M":
				items := m.modelRegistry.FormatPickerItems()
				m.overlays.ShowModelPicker(items)
			case "p":
				current := m.dashboard.data
				if current.Status == "running" {
					current.Status = "paused"
				} else {
					current.Status = "running"
				}
				m.dashboard, _ = m.dashboard.Update(current)
			}
		} else {
			return m.handleChatInputKey(msg)
		}
	}

	return m, nil
}

func (m AppModel) handleChatInputKey(msg tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "ctrl+x":
		if m.queue.Len() > 0 {
			m.queue.RemoveLast()
			m.chat.updateViewport()
		}
	}
	return m, nil
}

func (m AppModel) inputFocused() bool {
	return m.tab == TabChat
}

func (m AppModel) View() tea.View {
	if m.overlays.IsActive() {
		return m.overlayView()
	}

	tabs := m.renderTabs()
	statusBar := m.renderStatusBar()

	var content string
	switch m.tab {
	case TabChat:
		content = m.chat.View()
	case TabDashboard:
		content = m.dashboard.View()
	case TabAgents:
		content = m.agents.View()
	case TabSettings:
		content = m.settings.View()
	}

	if m.showTree && m.treeRoot != nil {
		content = m.renderWithTree(content)
	}

	body := fmt.Sprintf("%s\n%s\n%s", tabs, content, statusBar)

	v := tea.NewView(body)
	v.AltScreen = true
	v.MouseMode = tea.MouseModeCellMotion
	return v
}

func (m AppModel) overlayView() tea.View {
	tabs := m.renderTabs()
	statusBar := m.renderStatusBar()

	dialog := m.overlays.View()
	overlayLines := strings.Split(dialog, "\n")

	overlayW := 0
	for _, l := range overlayLines {
		if w := len([]rune(l)); w > overlayW {
			overlayW = w
		}
	}
	overlayH := len(overlayLines)

	padTop := (m.height - overlayH) / 3
	if padTop < 0 {
		padTop = 0
	}
	padLeft := (m.width - overlayW) / 2
	if padLeft < 0 {
		padLeft = 0
	}

	centered := make([]string, padTop)
	for i := range centered {
		centered[i] = ""
	}
	centered = append(centered, strings.Repeat(" ", padLeft)+dialog)

	body := fmt.Sprintf("%s\n%s\n%s", tabs, strings.Join(centered, "\n"), statusBar)

	v := tea.NewView(body)
	v.AltScreen = true
	v.MouseMode = tea.MouseModeCellMotion
	return v
}

func (m AppModel) renderWithTree(content string) string {
	treeWidth := 36
	if m.width < treeWidth+20 {
		var sb strings.Builder
		sb.WriteString(content)
		sb.WriteString("\n")
		sb.WriteString(StyleTitle.Render("  Agent Tree") + "\n")
		sb.WriteString(StyleDim.Render(strings.Repeat("\u2500", m.width-2)) + "\n")
		sb.WriteString(RenderTree(m.treeRoot, "", true))
		return sb.String()
	}

	treePanel := StyleTitle.Render("Agent Tree") + "\n" +
		StyleDim.Render(strings.Repeat("\u2500", treeWidth-2)) + "\n" +
		RenderTree(m.treeRoot, "", true)

	mainStyle := lipgloss.NewStyle().Width(m.width - treeWidth - 1)
	treeStyle := lipgloss.NewStyle().
		Width(treeWidth).
		BorderStyle(lipgloss.NormalBorder()).
		BorderLeft(true).
		BorderForeground(ColorBorder).
		Padding(0, 1)

	return lipgloss.JoinHorizontal(lipgloss.Top, mainStyle.Render(content), treeStyle.Render(treePanel))
}

func (m AppModel) renderTabs() string {
	labels := []string{"Chat", "Dashboard", "Agents", "Settings"}
	var rendered []string
	for i, label := range labels {
		if Tab(i) == m.tab {
			rendered = append(rendered, StyleActiveTab.Render(" "+label+" "))
		} else {
			rendered = append(rendered, StyleInactiveTab.Render(" "+label+" "))
		}
	}
	return lipgloss.NewStyle().Padding(0, 1).Render(strings.Join(rendered, " \u2502 "))
}

func (m AppModel) renderStatusBar() string {
	statusColor := ColorSuccess
	statusIcon := "\u25cf"
	switch {
	case m.state == types.AgentStarting:
		statusColor = ColorWarning
		statusIcon = "\u23f3"
	case m.state == types.AgentThinking, m.state == types.AgentRunning:
		statusColor = ColorPrimary
		statusIcon = "\u25d4"
	case m.state == types.AgentInterrupted:
		statusColor = ColorWarning
		statusIcon = "\u23e0"
	case m.state == types.AgentIdle:
		statusColor = ColorTextDim
		statusIcon = "\u25cb"
	case m.status != "ok":
		statusColor = ColorError
		statusIcon = "\u2717"
	}

	modelInfo := ""
	if m.currentModel != "" {
		modelDisplay := m.currentModel
		if len(modelDisplay) > 25 {
			modelDisplay = modelDisplay[:22] + "..."
		}
		modelInfo = fmt.Sprintf(" \u2502 %s", StyleDim.Render(modelDisplay))
	}

	queueInfo := ""
	if m.queue.Len() > 0 {
		queueInfo = fmt.Sprintf(" \u2502 %s", StyleWarning.Render(fmt.Sprintf("\u25a0 queue: %d", m.queue.Len())))
	}

	hints := "Tab:\u2194 ?:help M:model Ctrl+C:interrupt Ctrl+D:quit"
	return lipgloss.NewStyle().
		Foreground(ColorTextDim).
		Padding(0, 1).
		Render(fmt.Sprintf(
			"Agent Studio TUI \u2502 %s %s%s%s \u2502 %s",
			lipgloss.NewStyle().Foreground(statusColor).Render(statusIcon),
			lipgloss.NewStyle().Foreground(statusColor).Render(m.status),
			modelInfo,
			queueInfo,
			hints,
		))
}
