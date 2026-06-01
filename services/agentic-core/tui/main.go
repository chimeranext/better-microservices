package main

import (
	"flag"
	"fmt"
	"os"

	tea "charm.land/bubbletea/v2"

	"github.com/lapc506/agentic-core/tui/internal/ui"
)

func main() {
	baseURL := flag.String("url", "http://localhost:8080", "agentic-core API URL")
	model := flag.String("model", "asistente-demo", "Model to use (e.g. gemini/gemini-3-flash-preview:cloud, claude-sonnet-4-6, gpt-4o)")
	provider := flag.String("provider", "", "Model provider (openai, anthropic, google, groq, together, openrouter). Overrides model prefix.")
	modelsURL := flag.String("models-url", "", "Custom model catalog URL (default: https://models.dev/api.json)")
	flag.Parse()

	appModel := ui.NewAppModel(*baseURL, *model, *provider, *modelsURL)

	p := tea.NewProgram(appModel)

	if _, err := p.Run(); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}
