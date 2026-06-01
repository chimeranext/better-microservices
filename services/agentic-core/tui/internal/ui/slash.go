package ui

import (
	"fmt"
	"sort"
	"strings"
)

type SlashCommand struct {
	Name        string
	Description string
	Handler     func(args string) string
}

type SlashHandler struct {
	commands  map[string]SlashCommand
	completions []string
}

func NewSlashHandler() *SlashHandler {
	sh := &SlashHandler{
		commands: make(map[string]SlashCommand),
	}

	sh.register(SlashCommand{
		Name: "help", Description: "Show available commands and keybindings",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "clear", Description: "Start a new session (clear messages)",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "new", Description: "Start a fresh session",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "quit", Description: "Exit the TUI",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "exit", Description: "Exit the TUI",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "queue", Description: "Show queued messages",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "details", Description: "Toggle tool details (hidden|collapsed|expanded)",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "model", Description: "Open model picker to switch between cloud/local models",
		Handler: func(string) string { return "" },
	})
	sh.register(SlashCommand{
		Name: "refresh", Description: "Refresh model list from models.dev",
		Handler: func(string) string { return "" },
	})

	return sh
}

func (sh *SlashHandler) register(cmd SlashCommand) {
	sh.commands[cmd.Name] = cmd
	sh.completions = append(sh.completions, cmd.Name)
	sort.Strings(sh.completions)
}

func (sh *SlashHandler) IsSlash(input string) bool {
	return strings.HasPrefix(input, "/")
}

func (sh *SlashHandler) Execute(input string) (string, bool) {
	if !sh.IsSlash(input) {
		return "", false
	}

	parts := strings.SplitN(input[1:], " ", 2)
	name := strings.ToLower(parts[0])
	args := ""
	if len(parts) > 1 {
		args = parts[1]
	}

	cmd, ok := sh.commands[name]
	if !ok {
		return fmt.Sprintf("Unknown command: /%s. Type /help for available commands.", name), false
	}

	result := cmd.Handler(args)
	return result, true
}

func (sh *SlashHandler) Completions(prefix string) []string {
	if !strings.HasPrefix(prefix, "/") {
		return nil
	}
	partial := strings.ToLower(prefix[1:])
	if partial == "" {
		result := make([]string, len(sh.completions))
		for i, c := range sh.completions {
			result[i] = "/" + c
		}
		return result
	}

	var matches []string
	for _, c := range sh.completions {
		if strings.HasPrefix(c, partial) {
			matches = append(matches, "/"+c)
		}
	}
	return matches
}

func (sh *SlashHandler) HelpText() string {
	var sb strings.Builder
	sb.WriteString("Available Commands:\n\n")
	for _, name := range sh.completions {
		cmd := sh.commands[name]
		sb.WriteString(fmt.Sprintf("  /%-12s %s\n", cmd.Name, cmd.Description))
	}
	return sb.String()
}
