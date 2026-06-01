# Agent Studio TUI

Terminal user interface for agentic-core, built with [Bubble Tea](https://github.com/charmbracelet/bubbletea).

Behaves like the [Hermes TUI](https://github.com/NousResearch/hermes-agent) — non-blocking input, slash commands, overlays, tool activity tracking, markdown rendering, **cloud model support**.

## Usage

```bash
# Local model
cd tui
go run . --url http://localhost:8080

# Cloud model (requires backend with LiteLLM/provider routing)
go run . --url http://localhost:8080 --model gemini/gemini-3-flash-preview:cloud

# Cloud model with explicit provider
go run . --url http://localhost:8080 --model gpt-4o --provider openai
```

## Cloud Models

The TUI supports cloud models via a model picker overlay. Select models from:

- **Gemini** — `gemini/gemini-3-flash-preview:cloud`, `gemini/gemini-3-pro:cloud`, `gemini/gemini-2.5-flash:cloud`
- **Anthropic** — `anthropic/claude-sonnet-4-6:cloud`, `anthropic/claude-opus-4-6:cloud`, `anthropic/claude-haiku-4-6:cloud`
- **OpenAI** — `openai/gpt-4o:cloud`, `openai/gpt-4o-mini:cloud`, `openai/o3:cloud`, `openai/o4-mini:cloud`
- **Groq** — `groq/llama-4:cloud`
- **Together** — `together/llama-4:cloud`
- **OpenRouter** — `openrouter/anthropic/claude-sonnet-4:cloud`

Press `M` or type `/model` to open the model picker at runtime.

The backend must support the `provider` field in the `/api/chat` request (e.g., via LiteLLM or custom routing).

## Hermes-like features

- **Non-blocking input** — type while the agent processes; messages queue and auto-drain
- **Queue management** — `/queue` to view, `Ctrl+X` to remove last queued item
- **Slash commands** — `/help`, `/clear`, `/new`, `/quit`, `/retry`, `/undo`, `/queue`, `/details`, `/model`
- **Cloud model picker** — `M` or `/model` opens overlay with cloud providers
- **Rich keybindings** — Tab/Shift+Tab view switching, Ctrl+C interrupt/clear/quit, Ctrl+L new session, Ctrl+D exit
- **Agent state tracking** — starting → ready → thinking → running → interrupted in status bar
- **Tool activity panel** — live tool call progress with completion/failure states
- **Markdown rendering** — headings, bold, italic, code, lists, blockquotes
- **Help overlay** — `?` or `/help` shows keybindings and commands in a modal panel
- **Overlay system** — modal panels for help, model picker, sessions, confirmations
- **Streaming elapsed timer** — shows per-response duration
- **Agent tree sidebar** — `T` to toggle, shows multi-agent workflow hierarchy

## Keyboard shortcuts

| Key | Action |
|-----|--------|
| `Enter` | Send message (or queue while agent is busy) |
| `Shift+Enter` | Insert newline |
| `Tab` / `Shift+Tab` | Switch between tabs |
| `Ctrl+C` | Interrupt agent / clear draft / quit |
| `Ctrl+D` | Exit TUI |
| `Ctrl+L` | New session (same as `/clear`) |
| `Ctrl+X` | Remove last queued message |
| `Esc` | Interrupt running agent |
| `?` | Open help overlay |
| `M` | Open model picker (cloud/local models) |
| `T` | Toggle agent tree sidebar |
| `c` / `d` / `a` / `s` | Switch to Chat / Dashboard / Agents / Settings |

## Slash commands

- `/help` — Show help overlay
- `/clear`, `/new` — Start a new session
- `/quit`, `/exit` — Exit TUI
- `/model` — Open cloud model picker
- `/queue` — Show queued messages
- `/retry` — Regenerate last assistant response
- `/undo` — Remove last turn
- `/details` — Toggle tool details panel

## Build

```bash
go build -o agentic-tui .
./agentic-tui --url http://localhost:8080 --model gemini/gemini-3-flash-preview:cloud
```
