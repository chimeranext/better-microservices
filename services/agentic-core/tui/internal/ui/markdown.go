package ui

import (
	"strings"
)

func RenderMarkdown(text string, width int) string {
	if text == "" {
		return ""
	}

	lines := strings.Split(text, "\n")
	var result []string
	inCodeBlock := false

	for _, line := range lines {
		trimmed := strings.TrimSpace(line)

		if strings.HasPrefix(trimmed, "```") {
			if inCodeBlock {
				inCodeBlock = false
				result = append(result, StyleDim.Render(strings.Repeat("\u2500", width-2)))
			} else {
				inCodeBlock = true
				result = append(result, StyleDim.Render(strings.Repeat("\u2500", width-2)))
			}
			continue
		}

		if inCodeBlock {
			result = append(result, StyleCode.Render("  "+line))
			continue
		}

		if strings.HasPrefix(trimmed, "# ") {
			content := strings.TrimPrefix(trimmed, "# ")
			result = append(result, StyleBold.Render(StyleTitle.Render(content)))
			continue
		}

		if strings.HasPrefix(trimmed, "## ") {
			content := strings.TrimPrefix(trimmed, "## ")
			result = append(result, StyleBold.Render(content))
			continue
		}

		if strings.HasPrefix(trimmed, "### ") {
			content := strings.TrimPrefix(trimmed, "### ")
			result = append(result, StyleItalic.Render(content))
			continue
		}

		if strings.HasPrefix(trimmed, "- ") || strings.HasPrefix(trimmed, "* ") {
			bullet := StyleDim.Render("\u2022")
			content := trimmed[2:]
			content = renderInline(content)
			result = append(result, "  "+bullet+" "+content)
			continue
		}

		if strings.HasPrefix(trimmed, "> ") {
			content := strings.TrimPrefix(trimmed, "> ")
			content = renderInline(content)
			result = append(result, StyleDim.Render("\u2502 ")+content)
			continue
		}

		result = append(result, renderInline(line))
	}

	return strings.Join(result, "\n")
}

func renderInline(text string) string {
	result := text

	for {
		start := strings.Index(result, "**")
		if start < 0 {
			break
		}
		end := strings.Index(result[start+2:], "**")
		if end < 0 {
			break
		}
		end += start + 2
		before := result[:start]
		boldContent := result[start+2 : end]
		after := result[end+2:]
		result = before + StyleBold.Render(boldContent) + after
	}

	for {
		start := strings.Index(result, "*")
		if start < 0 {
			break
		}
		end := strings.Index(result[start+1:], "*")
		if end < 0 {
			break
		}
		end += start + 1
		before := result[:start]
		italicContent := result[start+1 : end]
		after := result[end+1:]
		result = before + StyleItalic.Render(italicContent) + after
	}

	for {
		start := strings.Index(result, "`")
		if start < 0 {
			break
		}
		end := strings.Index(result[start+1:], "`")
		if end < 0 {
			break
		}
		end += start + 1
		before := result[:start]
		codeContent := result[start+1 : end]
		after := result[end+1:]
		result = before + StyleCode.Render(codeContent) + after
	}

	return result
}
