package ui

import (
	"fmt"
	"strings"
	"time"

	"charm.land/lipgloss/v2"
	"github.com/lapc506/agentic-core/tui/internal/types"
)

type ActivityModel struct {
	activities []types.ToolActivity
	width      int
	expanded   bool
}

func NewActivityModel() ActivityModel {
	return ActivityModel{expanded: true}
}

func (a *ActivityModel) Add(act types.ToolActivity) {
	a.activities = append(a.activities, act)
}

func (a *ActivityModel) Update(update types.ActivityUpdate) {
	for i := range a.activities {
		if a.activities[i].ToolID == update.ToolID {
			a.activities[i].Status = update.Status
			if update.Preview != "" {
				a.activities[i].Preview = update.Preview
			}
			return
		}
	}
	a.Add(types.ToolActivity{
		ToolID:  update.ToolID,
		Name:    update.Name,
		Status:  update.Status,
		Preview: update.Preview,
	})
}

func (a *ActivityModel) Remove(toolID string) {
	for i, act := range a.activities {
		if act.ToolID == toolID {
			a.activities = append(a.activities[:i], a.activities[i+1:]...)
			return
		}
	}
}

func (a *ActivityModel) Clear() {
	a.activities = nil
}

func (a *ActivityModel) Len() int {
	return len(a.activities)
}

func (a *ActivityModel) SetExpanded(v bool) {
	a.expanded = v
}

func (a *ActivityModel) ToggleExpanded() {
	a.expanded = !a.expanded
}

func (a *ActivityModel) SetWidth(w int) {
	a.width = w
}

func (a *ActivityModel) View() string {
	if !a.expanded || len(a.activities) == 0 {
		return ""
	}

	now := time.Now()
	var sb strings.Builder

	sb.WriteString(StyleDim.Render(fmt.Sprintf("  Tools (%d active):", len(a.activities))) + "\n")

	for _, act := range a.activities {
		icon := "\u25d4"
		style := StyleToolRunning
		switch act.Status {
		case "completed", "done":
			icon = "\u2713"
			style = StyleToolDone
		case "failed", "error":
			icon = "\u2717"
			style = StyleToolFailed
		case "pending":
			icon = "\u25cb"
			style = StyleDim
		}

		line := fmt.Sprintf("    %s %s", style.Render(icon), style.Render(act.Name))
		if act.Preview != "" {
			maxLen := a.width - len(line) - 20
			if maxLen > 10 {
				preview := act.Preview
				if len(preview) > maxLen {
					preview = preview[:maxLen-3] + "..."
				}
				line += " " + StyleDim.Render(preview)
			}
		}
		sb.WriteString(line + "\n")
	}

	return lipgloss.NewStyle().
		BorderStyle(lipgloss.RoundedBorder()).
		BorderForeground(ColorBorder).
		BorderTop(true).
		Padding(0, 1).
		Width(a.width - 4).
		Render(strings.TrimSuffix(sb.String(), "\n"))
}
