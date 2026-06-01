package ui

import (
	"fmt"
	"strings"

	"charm.land/lipgloss/v2"
	"github.com/lapc506/agentic-core/tui/internal/types"
)

type StatusIndicator struct {
	State string
}

func (s StatusIndicator) Render() string {
	switch s.State {
	case "connected", "ok":
		return lipgloss.NewStyle().Foreground(ColorSuccess).Render("\u25cf")
	case "connecting":
		return lipgloss.NewStyle().Foreground(ColorWarning).Render("\u25d0")
	case "reconnecting":
		return lipgloss.NewStyle().Foreground(ColorWarning).Render("\u21bb")
	case "disconnected", "offline":
		return lipgloss.NewStyle().Foreground(ColorError).Render("\u25cb")
	case "starting":
		return StyleWarning.Render("\u23f3")
	case "ready":
		return StyleSuccess.Render("\u25cf")
	case "thinking", "running":
		return StyleToolRunning.Render("\u23f3")
	case "interrupted":
		return StyleWarning.Render("\u23e0")
	default:
		return lipgloss.NewStyle().Foreground(ColorTextDim).Render("?")
	}
}

func (s StatusIndicator) Label() string {
	switch s.State {
	case "connected", "ok":
		return StyleSuccess.Render("connected")
	case "connecting":
		return StyleWarning.Render("connecting...")
	case "reconnecting":
		return StyleWarning.Render("reconnecting...")
	case "disconnected", "offline":
		return StyleError.Render("disconnected")
	case "starting":
		return StyleWarning.Render("starting")
	case "ready":
		return StyleSuccess.Render("ready")
	case "thinking":
		return StyleThinking.Render("thinking")
	case "running":
		return StyleToolRunning.Render("running")
	case "interrupted":
		return StyleWarning.Render("interrupted")
	default:
		return lipgloss.NewStyle().Foreground(ColorTextDim).Render("unknown")
	}
}

func RenderAgentState(state types.AgentState) string {
	var style lipgloss.Style
	icon := "?"
	label := string(state)

	switch state {
	case types.AgentStarting:
		style = StyleWarning
		icon = "\u23f3"
	case types.AgentReady:
		style = StyleSuccess
		icon = "\u25cf"
	case types.AgentThinking:
		style = StyleThinking
		icon = "\u23f3"
	case types.AgentRunning:
		style = StyleToolRunning
		icon = "\u25d4"
	case types.AgentInterrupted:
		style = StyleWarning
		icon = "\u23e0"
	case types.AgentIdle:
		style = StyleDim
		icon = "\u25cb"
	}

	return style.Render(fmt.Sprintf("%s %s", icon, label))
}

func RenderRemoteTab(name string, state string, active bool) string {
	indicator := StatusIndicator{State: state}
	nameStyle := StyleInactiveTab
	if active {
		nameStyle = StyleActiveTab
	}
	return indicator.Render() + " " + nameStyle.Render(name)
}

func RenderStateLine(state types.AgentState, elapsed string) string {
	parts := []string{RenderAgentState(state)}
	if elapsed != "" {
		parts = append(parts, StyleDim.Render(fmt.Sprintf("\u23f1 %s", elapsed)))
	}
	return strings.Join(parts, "  ")
}
