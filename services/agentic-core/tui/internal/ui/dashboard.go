package ui

import (
	"fmt"
	"strings"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

type DashboardData struct {
	Status      string
	Agent       string
	Model       string
	Branch      string
	BranchDirty bool
	Iteration   int
	TotalTasks  int
	DoneTasks   int
	Tokens      int
	Cost        float64
	Phase       string
}

type DashboardModel struct {
	data   DashboardData
	width  int
	height int
}

func NewDashboardModel() DashboardModel {
	return DashboardModel{
		data: DashboardData{
			Status: "idle",
			Agent:  "none",
			Model:  "none",
			Branch: "main",
		},
	}
}

func (m DashboardModel) Init() tea.Cmd { return nil }

func (m DashboardModel) Update(msg tea.Msg) (DashboardModel, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height
	case DashboardData:
		m.data = msg
	}
	return m, nil
}

func (m DashboardModel) View() string {
	d := m.data

	statusColor := ColorSuccess
	statusIcon := "\u25cf"
	switch d.Status {
	case "running":
		statusColor = ColorPrimary
		statusIcon = "\u25cf"
	case "paused":
		statusColor = ColorWarning
		statusIcon = "\u25d0"
	case "failed":
		statusColor = ColorError
		statusIcon = "\u2717"
	case "idle":
		statusColor = ColorTextDim
		statusIcon = "\u25cb"
	}

	header := StyleTitle.Render("  Dashboard")

	branchDirtyMarker := ""
	if d.BranchDirty {
		branchDirtyMarker = StyleError.Render(" *")
	}
	statusLine := fmt.Sprintf("  %s %s  \u2502  Agent: %s  \u2502  Model: %s  \u2502  Branch: %s%s",
		lipgloss.NewStyle().Foreground(statusColor).Render(statusIcon),
		lipgloss.NewStyle().Foreground(statusColor).Render(d.Status),
		StyleAssistantMsg.Render(d.Agent),
		StyleDim.Render(d.Model),
		d.Branch,
		branchDirtyMarker,
	)

	progress := 0.0
	if d.TotalTasks > 0 {
		progress = float64(d.DoneTasks) / float64(d.TotalTasks)
	}
	barWidth := 40
	filled := int(progress * float64(barWidth))
	if filled > barWidth {
		filled = barWidth
	}
	bar := fmt.Sprintf("  [%s%s] %d/%d tasks  \u2502  Iteration: %d  \u2502  Phase: %s",
		lipgloss.NewStyle().Foreground(ColorPrimary).Render(strings.Repeat("\u2588", filled)),
		lipgloss.NewStyle().Foreground(ColorBorder).Render(strings.Repeat("\u2591", barWidth-filled)),
		d.DoneTasks, d.TotalTasks,
		d.Iteration,
		StyleDim.Render(d.Phase),
	)

	costLine := fmt.Sprintf("  Tokens: %s  \u2502  Est. cost: %s",
		StyleAssistantMsg.Render(fmt.Sprintf("%d", d.Tokens)),
		lipgloss.NewStyle().Foreground(ColorWarning).Render(fmt.Sprintf("$%.4f", d.Cost)),
	)

	dividerWidth := m.width - 2
	if dividerWidth < 1 {
		dividerWidth = 1
	}
	divider := lipgloss.NewStyle().Foreground(ColorBorder).Render(strings.Repeat("\u2500", dividerWidth))

	keybindHint := StyleDim.Render("  p: pause/resume  |  s: start task")

	return fmt.Sprintf("%s\n%s\n\n%s\n\n%s\n\n%s\n\n%s", header, divider, statusLine, bar, costLine, keybindHint)
}
