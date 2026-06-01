package ui

import (
	"fmt"
	"strings"
	"unicode"

	"charm.land/lipgloss/v2"
)

type OverlayType int

const (
	OverlayNone OverlayType = iota
	OverlayHelp
	OverlaySessions
	OverlayModelPicker
	OverlayConfirm
)

type OverlayModel struct {
	active     OverlayType
	items      []string
	rawItems   []string
	allItems   []string // unfiltered display items (model picker)
	allRaw     []string // unfiltered raw values (model picker)
	filter     string   // current filter text (model picker)
	cursor     int
	title      string
	helpText   string
	promptText string
	confirmFn  func(bool)
	width      int
	height     int
}

func NewOverlayModel() OverlayModel {
	return OverlayModel{active: OverlayNone}
}

func (o *OverlayModel) ShowHelp() {
	o.active = OverlayHelp
	o.cursor = 0
	o.title = "Help & Keybindings"
	o.helpText = ""
	o.items = []string{
		"Enter        Send message (or newline with Shift+Enter)",
		"Ctrl+C       Interrupt agent / clear draft / quit",
		"Ctrl+D       Exit TUI",
		"Ctrl+L       New session (same as /clear)",
		"Ctrl+G       Open in $EDITOR",
		"Ctrl+V       Paste text / image",
		"Tab          Complete slash command",
		"Up/Down      Navigate queue / history / completions",
		"Left/Right   Move cursor in input",
		"Home/End     Start/end of line",
		"Ctrl+W       Delete word backwards",
		"Ctrl+U       Delete to start of line",
		"Ctrl+K       Delete to end of line",
		"",
		"Slash Commands:",
		"/help        Show this help",
		"/clear       Start a new session",
		"/new         Start a fresh session",
		"/quit        Exit TUI",
		"/queue       Show queued messages",
		"/retry       Regenerate last response",
		"/undo        Remove last turn",
	}
}

func (o *OverlayModel) ShowSessions(sessions []string) {
	o.active = OverlaySessions
	o.cursor = 0
	o.title = "Sessions"
	o.items = sessions
}

func (o *OverlayModel) ShowModelPicker(displayItems []string) {
	o.active = OverlayModelPicker
	o.cursor = 0
	o.filter = ""
	o.allItems = displayItems
	o.allRaw = make([]string, len(displayItems))
	for i, item := range displayItems {
		if idx := strings.Index(item, " -- "); idx >= 0 {
			o.allRaw[i] = item[:idx]
		} else {
			o.allRaw[i] = item
		}
	}
	o.items = displayItems
	o.rawItems = o.allRaw
}

func (o *OverlayModel) ShowConfirm(prompt string) {
	o.active = OverlayConfirm
	o.cursor = 0
	o.title = "Confirm"
	o.promptText = prompt
	o.items = []string{"Yes", "No"}
}

func (o *OverlayModel) IsActive() bool {
	return o.active != OverlayNone
}

func (o *OverlayModel) Close() {
	o.active = OverlayNone
	o.items = nil
	o.rawItems = nil
	o.allItems = nil
	o.allRaw = nil
	o.filter = ""
	o.cursor = 0
}

func (o *OverlayModel) CursorUp() {
	if o.cursor > 0 {
		o.cursor--
	}
}

func (o *OverlayModel) CursorDown() {
	if o.cursor < len(o.items)-1 {
		o.cursor++
	}
}

func (o *OverlayModel) Cursor() int {
	if o.cursor >= len(o.items) && len(o.items) > 0 {
		return len(o.items) - 1
	}
	return o.cursor
}

func (o *OverlayModel) SelectedRaw() string {
	idx := o.Cursor()
	if idx >= 0 && idx < len(o.rawItems) {
		return o.rawItems[idx]
	}
	return ""
}

func (o *OverlayModel) Type() OverlayType {
	return o.active
}

func (o *OverlayModel) SetWidth(w int) {
	o.width = w
}

func (o *OverlayModel) SetHeight(h int) {
	o.height = h
}

func (o *OverlayModel) AddFilterChar(r rune) {
	if o.active != OverlayModelPicker {
		return
	}
	o.filter += string(r)
	o.applyFilter()
}

func (o *OverlayModel) RemoveFilterChar() {
	if o.active != OverlayModelPicker || len(o.filter) == 0 {
		return
	}
	o.filter = o.filter[:len(o.filter)-1]
	o.applyFilter()
}

func (o *OverlayModel) ClearFilter() {
	if o.active != OverlayModelPicker {
		return
	}
	o.filter = ""
	o.applyFilter()
}

func (o *OverlayModel) Filter() string {
	return o.filter
}

func (o *OverlayModel) applyFilter() {
	if o.filter == "" {
		o.items = make([]string, len(o.allItems))
		o.rawItems = make([]string, len(o.allRaw))
		copy(o.items, o.allItems)
		copy(o.rawItems, o.allRaw)
		o.cursor = 0
		return
	}

	filterLower := strings.ToLower(o.filter)
	var filteredItems, filteredRaw []string
	for i, item := range o.allItems {
		if strings.Contains(strings.ToLower(item), filterLower) {
			filteredItems = append(filteredItems, item)
			filteredRaw = append(filteredRaw, o.allRaw[i])
		}
	}
	o.items = filteredItems
	o.rawItems = filteredRaw
	if o.cursor >= len(o.items) {
		o.cursor = len(o.items) - 1
	}
	if o.cursor < 0 {
		o.cursor = 0
	}
}

func (o *OverlayModel) HandleFilterKey(key string) bool {
	if o.active != OverlayModelPicker {
		return false
	}

	if len(key) == 1 {
		r := []rune(key)[0]
		if unicode.IsPrint(r) {
			o.AddFilterChar(r)
			return true
		}
	}

	switch key {
	case "backspace":
		if o.filter != "" {
			o.RemoveFilterChar()
			return true
		}
	case "ctrl+u":
		if o.filter != "" {
			o.ClearFilter()
			return true
		}
	}

	return false
}

func (o *OverlayModel) View() string {
	if !o.IsActive() {
		return ""
	}

	overlayW := o.width * 3 / 5
	if overlayW < 50 {
		overlayW = 50
	}
	if overlayW > o.width-4 {
		overlayW = o.width - 4
	}

	overlayH := len(o.items) + 6
	if overlayH > o.height-4 {
		overlayH = o.height - 4
	}

	if o.active == OverlayHelp {
		overlayH = len(o.items) + 6
		if overlayH > o.height-4 {
			overlayH = o.height - 4
		}
	}

	var sb strings.Builder

	sb.WriteString(StyleOverlayTitle.Render("  " + o.title) + "\n")
	sb.WriteString(StyleDim.Render(strings.Repeat("\u2500", overlayW-4)) + "\n")

	if o.active == OverlayModelPicker {
		filterDisplay := o.filter
		if filterDisplay == "" {
			filterDisplay = "type to filter..."
		}
		filterStyle := StyleDim
		if o.filter != "" {
			filterStyle = StyleOverlayItemSelected
		}
		countInfo := fmt.Sprintf("  %s  [%d models]",
			filterStyle.Render("\ud83d\udd0d "+filterDisplay),
			len(o.items),
		)
		sb.WriteString(countInfo + "\n")
		sb.WriteString(StyleDim.Render(strings.Repeat("\u2500", overlayW-4)) + "\n")
	}

	if o.promptText != "" {
		sb.WriteString("\n  " + o.promptText + "\n\n")
	}

	displayItems := o.items
	maxVisible := overlayH - 5
	if o.active == OverlayModelPicker {
		maxVisible = overlayH - 7
	}
	if len(displayItems) > maxVisible {
		start := o.cursor - maxVisible/2
		if start < 0 {
			start = 0
		}
		if start+maxVisible > len(displayItems) {
			start = len(displayItems) - maxVisible
		}
		displayItems = displayItems[start : start+maxVisible]

		if start > 0 {
			sb.WriteString(StyleDim.Render("  \u2191 more\n"))
		}
	}

	for i, item := range displayItems {
		if item == "" {
			sb.WriteString("\n")
			continue
		}

		display := item
		if len(display) > overlayW-10 {
			display = display[:overlayW-13] + "..."
		}

		if i == o.cursor && o.active != OverlayHelp {
			sb.WriteString("  " + StyleOverlayItemSelected.Render("\u25b6 "+display) + "\n")
		} else if o.active == OverlayHelp && strings.HasPrefix(item, "Slash") {
			sb.WriteString("\n  " + StyleTitle.Render(display) + "\n")
		} else {
			sb.WriteString("    " + StyleOverlayItem.Render(display) + "\n")
		}
	}

	if o.active == OverlayHelp {
		sb.WriteString("\n" + StyleOverlayHelp.Render("  Press any key to close"))
	}

	return lipgloss.NewStyle().
		BorderStyle(lipgloss.RoundedBorder()).
		BorderForeground(ColorPrimary).
		Padding(0, 1).
		Width(overlayW).
		Render(strings.TrimSuffix(sb.String(), "\n"))
}
