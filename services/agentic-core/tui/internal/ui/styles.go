package ui

import "charm.land/lipgloss/v2"

var (
	ColorRail    = lipgloss.Color("#080810")
	ColorPanel   = lipgloss.Color("#0F0F1E")
	ColorContent = lipgloss.Color("#12121E")
	ColorCard    = lipgloss.Color("#1A1A2E")
	ColorBorder  = lipgloss.Color("#2A2A40")
	ColorPrimary = lipgloss.Color("#3B6FE0")
	ColorText    = lipgloss.Color("#E0E0F0")
	ColorTextDim = lipgloss.Color("#666680")
	ColorSuccess = lipgloss.Color("#4CAF50")
	ColorWarning = lipgloss.Color("#FF9800")
	ColorError   = lipgloss.Color("#EF5350")

	StyleTitle = lipgloss.NewStyle().Foreground(ColorPrimary).Bold(true)

	StyleDim = lipgloss.NewStyle().Foreground(ColorTextDim)

	StyleBorder = lipgloss.NewStyle().BorderStyle(lipgloss.RoundedBorder()).BorderForeground(ColorBorder)

	StyleActiveTab = lipgloss.NewStyle().Foreground(ColorPrimary).Bold(true).Underline(true)

	StyleInactiveTab = lipgloss.NewStyle().Foreground(ColorTextDim)

	StyleUserMsg = lipgloss.NewStyle().Foreground(ColorPrimary).Bold(true)

	StyleAssistantMsg = lipgloss.NewStyle().Foreground(ColorText)

	StyleStatus = lipgloss.NewStyle().Foreground(ColorSuccess)

	StyleError = lipgloss.NewStyle().Foreground(ColorError)

	StyleWarning = lipgloss.NewStyle().Foreground(ColorWarning)

	StyleQueueItem = lipgloss.NewStyle().Foreground(ColorWarning)

	StyleQueueEditing = lipgloss.NewStyle().Foreground(ColorPrimary).Background(ColorCard)

	StyleOverlay = lipgloss.NewStyle().BorderStyle(lipgloss.RoundedBorder()).BorderForeground(ColorPrimary).Padding(0, 1).Width(50)

	StyleOverlayTitle = lipgloss.NewStyle().Foreground(ColorPrimary).Bold(true)

	StyleOverlayItem = lipgloss.NewStyle().Foreground(ColorText)

	StyleOverlayItemSelected = lipgloss.NewStyle().Foreground(ColorPrimary).Bold(true)

	StyleOverlayHelp = lipgloss.NewStyle().Foreground(ColorTextDim)

	StyleToolRunning = lipgloss.NewStyle().Foreground(ColorPrimary)

	StyleToolDone = lipgloss.NewStyle().Foreground(ColorSuccess)

	StyleToolFailed = lipgloss.NewStyle().Foreground(ColorError)

	StyleThinking = lipgloss.NewStyle().Foreground(ColorTextDim).Italic(true)

	StyleCode = lipgloss.NewStyle().Background(ColorCard).Foreground(ColorText)

	StyleBold = lipgloss.NewStyle().Bold(true)

	StyleItalic = lipgloss.NewStyle().Italic(true)

	StyleSeparator = lipgloss.NewStyle().Foreground(ColorBorder)

	StyleIndicator = lipgloss.NewStyle().Foreground(ColorWarning)
)
