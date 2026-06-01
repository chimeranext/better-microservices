package ui

import (
	"fmt"
	"strings"
	"time"

	tea "charm.land/bubbletea/v2"
	"charm.land/bubbles/v2/textarea"
	"charm.land/bubbles/v2/viewport"

	"github.com/lapc506/agentic-core/tui/internal/api"
	"github.com/lapc506/agentic-core/tui/internal/types"
)

type streamChunkMsg string
type streamDoneMsg struct{}
type streamErrMsg struct{ err error }
type toolActivityMsg struct {
	ToolID  string
	Name    string
	Status  string
	Preview string
}
type toolDoneMsg struct {
	ToolID string
	Name   string
}
type statusUpdateMsg struct {
	Kind string
	Text string
}
type slashCmdMsg struct {
	Command string
	Args    string
}
type tickMsg struct{}

type ChatModel struct {
	client     *api.Client
	input      textarea.Model
	viewport   viewport.Model
	messages   []types.ChatMessage
	agent      string
	streaming  bool
	queue      *QueueModel
	activity   *ActivityModel
	state      types.AgentState
	width      int
	height     int
	ready      bool
	inputLocked bool
	startTime  time.Time
	elapsed    time.Duration
	lastMsgSent string
}

func NewChatModel(client *api.Client, agent string, queue *QueueModel, activity *ActivityModel) ChatModel {
	ta := textarea.New()
	ta.Placeholder = "Send a message... (Shift+Enter for newline)"
	ta.SetHeight(3)

	return ChatModel{
		client:   client,
		input:    ta,
		agent:    agent,
		queue:    queue,
		activity: activity,
		state:    types.AgentStarting,
	}
}

func (m ChatModel) Init() tea.Cmd {
	return m.input.Focus()
}

func (m ChatModel) Update(msg tea.Msg) (ChatModel, tea.Cmd) {
	var cmds []tea.Cmd

	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height
		if !m.ready {
			m.viewport = viewport.New(
				viewport.WithWidth(msg.Width-4),
				viewport.WithHeight(msg.Height-14),
			)
			m.ready = true
		} else {
			m.viewport.SetWidth(msg.Width - 4)
			m.viewport.SetHeight(msg.Height - 14)
		}
		m.input.SetWidth(msg.Width - 4)
		m.activity.SetWidth(msg.Width)

	case tea.KeyPressMsg:
		key := msg.String()

		if key == "enter" {
			content := strings.TrimSpace(m.input.Value())
			if content == "" {
				return m, nil
			}

			if strings.HasPrefix(content, "/") {
				parts := strings.SplitN(content[1:], " ", 2)
				cmdName := strings.ToLower(parts[0])
				cmdArgs := ""
				if len(parts) > 1 {
					cmdArgs = parts[1]
				}
				m.input.Reset()
				return m, func() tea.Msg {
					return slashCmdMsg{Command: cmdName, Args: cmdArgs}
				}
			}

			if m.streaming {
				m.queue.Enqueue(content)
				m.input.Reset()
				m.updateViewport()
				return m, nil
			}

			m.messages = append(m.messages, types.ChatMessage{Role: "user", Content: content})
			m.input.Reset()
			m.streaming = true
			m.state = types.AgentThinking
			m.startTime = time.Now()
			m.messages = append(m.messages, types.ChatMessage{Role: "assistant", Content: ""})
			m.updateViewport()
			return m, tea.Batch(m.sendMessage(), m.tickElapsed())
		}

	case streamChunkMsg:
		if len(m.messages) > 0 {
			last := &m.messages[len(m.messages)-1]
			last.Content += string(msg)
			m.updateViewport()
		}

	case streamDoneMsg:
		m.streaming = false
		m.state = types.AgentReady
		m.elapsed = time.Since(m.startTime)

		if m.queue.Len() > 0 {
			if next, ok := m.queue.Dequeue(); ok {
				m.messages = append(m.messages, types.ChatMessage{Role: "user", Content: next})
				m.streaming = true
				m.state = types.AgentThinking
				m.startTime = time.Now()
				m.messages = append(m.messages, types.ChatMessage{Role: "assistant", Content: ""})
				m.updateViewport()
				return m, tea.Batch(m.sendMessage(), m.tickElapsed())
			}
		}
		m.updateViewport()

	case streamErrMsg:
		m.streaming = false
		m.state = types.AgentReady
		errMsg := fmt.Sprintf("Error: %v", msg.err)
		m.messages = append(m.messages, types.ChatMessage{Role: "system", Content: errMsg})
		m.updateViewport()

	case toolActivityMsg:
		m.activity.Update(types.ActivityUpdate{
			ToolID: msg.ToolID, Name: msg.Name,
			Status: msg.Status, Preview: msg.Preview,
		})
		m.updateViewport()

	case toolDoneMsg:
		m.activity.Update(types.ActivityUpdate{
			ToolID: msg.ToolID, Name: msg.Name, Status: "completed",
		})
		m.updateViewport()

	case statusUpdateMsg:
		m.state = types.AgentState(msg.Text)
		m.updateViewport()

	case tickMsg:
		if m.streaming {
			m.elapsed = time.Since(m.startTime)
			cmds = append(cmds, m.tickElapsed())
			m.updateViewport()
		}
	}

	if !m.inputLocked {
		var cmd tea.Cmd
		m.input, cmd = m.input.Update(msg)
		cmds = append(cmds, cmd)
	}

	var vpCmd tea.Cmd
	m.viewport, vpCmd = m.viewport.Update(msg)
	cmds = append(cmds, vpCmd)

	return m, tea.Batch(cmds...)
}

func (m *ChatModel) updateViewport() {
	var sb strings.Builder

	for i, msg := range m.messages {
		switch msg.Role {
		case "user":
			sb.WriteString(StyleUserMsg.Render("  You") + "\n")
			for _, line := range strings.Split(msg.Content, "\n") {
				sb.WriteString("  " + line + "\n")
			}
			sb.WriteString("\n")

		case "assistant":
			sb.WriteString(StyleAssistantMsg.Render("  Agent") + "\n")
			rendered := RenderMarkdown(msg.Content, m.width-6)

			if m.streaming && i == len(m.messages)-1 && rendered == "" {
				sb.WriteString("  " + StyleThinking.Render(fmt.Sprintf("\u23f3 thinking... %s", animatedDots())) + "\n")
			} else if rendered != "" {
				for _, line := range strings.Split(rendered, "\n") {
					sb.WriteString("  " + line + "\n")
				}
			}

			if m.streaming && i == len(m.messages)-1 {
				sb.WriteString(StyleDim.Render("  \u258c") + "\n")
			}
			sb.WriteString("\n")

		case "system":
			sb.WriteString(StyleWarning.Render("  \u26a0 ") + msg.Content + "\n\n")
		case "error":
			sb.WriteString(StyleError.Render("  \u2717 ") + msg.Content + "\n\n")
		}
	}

	activityView := m.activity.View()
	if activityView != "" {
		sb.WriteString(activityView + "\n\n")
	}

	queueView := m.queue.View(m.width)
	if queueView != "" {
		sb.WriteString(queueView + "\n\n")
	}

	if m.streaming {
		sb.WriteString(StyleThinking.Render(fmt.Sprintf("  \u23f3 %s (%s)", string(m.state), formatDuration(m.elapsed))) + "\n")
	}

	m.viewport.SetContent(sb.String())
	m.viewport.GotoBottom()
}

func (m ChatModel) sendMessage() tea.Cmd {
	client := m.client
	agent := m.agent
	msgs := make([]types.ChatMessage, len(m.messages)-1)
	copy(msgs, m.messages[:len(m.messages)-1])

	return func() tea.Msg {
		var collected strings.Builder
		err := client.ChatStream(agent, msgs, func(chunk string) {
			collected.WriteString(chunk)
		})
		if err != nil {
			return streamErrMsg{err: err}
		}
		if collected.Len() > 0 {
			return streamChunkMsg(collected.String())
		}
		return streamDoneMsg{}
	}
}

func (m ChatModel) tickElapsed() tea.Cmd {
	return tea.Tick(time.Second, func(time.Time) tea.Msg {
		return tickMsg{}
	})
}

func animatedDots() string {
	dots := []string{"  ", ". ", "..", " ."}
	idx := (time.Now().UnixMilli() / 300) % 4
	return dots[idx]
}

func formatDuration(d time.Duration) string {
	d = d.Round(time.Second)
	m := int(d.Minutes())
	s := int(d.Seconds()) % 60
	if m > 0 {
		return fmt.Sprintf("%dm %ds", m, s)
	}
	return fmt.Sprintf("%ds", s)
}

func (m ChatModel) View() string {
	if !m.ready {
		return "  Loading..."
	}

	header := StyleTitle.Render(fmt.Sprintf("  Chat - %s", m.agent))

	var stateTag string
	switch m.state {
	case types.AgentStarting:
		stateTag = StyleWarning.Render(" \u23f3 starting agent...")
	case types.AgentReady:
		stateTag = StyleSuccess.Render(" \u25cf ready")
	case types.AgentThinking:
		stateTag = StyleThinking.Render(" \u23f3 thinking...")
	case types.AgentRunning:
		stateTag = StyleToolRunning.Render(" \u25d4 running...")
	case types.AgentInterrupted:
		stateTag = StyleWarning.Render(" \u23e0 interrupted")
	case types.AgentIdle:
		stateTag = StyleDim.Render(" \u25cb idle")
	}

	separator := ""
	if m.width > 2 {
		separator = StyleDim.Render(strings.Repeat("\u2500", m.width-2))
	}

	return fmt.Sprintf(
		"%s%s\n%s\n%s\n%s",
		header, stateTag,
		separator,
		m.viewport.View(),
		m.input.View(),
	)
}
