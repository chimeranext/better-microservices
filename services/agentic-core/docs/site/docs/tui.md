# Go TUI

Agent Studio ships with a terminal UI written in Go using [Bubble Tea](https://github.com/charmbracelet/bubbletea) v2. It provides a keyboard-driven interface inspired by the [Hermes TUI](https://github.com/NousResearch/hermes-agent) — non-blocking input, slash commands, overlays, tool activity tracking, and markdown rendering.

---

## Starting the TUI

With the backend running (HTTP API on port 8080):

```bash
cd tui
go run . --url http://localhost:8080
```

Or build a binary:

```bash
cd tui
go build -o agentic-tui .
./agentic-tui --url http://localhost:8080
```

---

## Hermes-like Behaviors

### Non-blocking input

You can type while the agent is processing. Messages are queued and automatically drain after each assistant response. The queue is shown in the chat view and updates live.

- **Queue while busy**: Type and press Enter while the agent is streaming — your message enters a queue.
- **Auto-drain**: After each assistant response, the next queued message is sent automatically.
- **View queue**: `/queue` shows all queued messages.
- **Remove last queued**: `Ctrl+X` removes the last queued message.

### Slash commands

All slash commands execute immediately, even while the agent is busy:

| Command | Action |
|---------|--------|
| `/help` | Show help overlay with keybindings and commands |
| `/clear` | Start a new session (clear messages) |
| `/new` | Start a fresh session |
| `/quit`, `/exit` | Exit the TUI |
| `/queue` | Show queued messages |
| `/retry` | Regenerate the last assistant response |
| `/undo` | Remove the last user/assistant turn |
| `/details` | Toggle tool details panel expanded/collapsed |

### Agent state tracking

The status bar and chat header track the agent lifecycle:

| State | Meaning |
|-------|---------|
| `starting agent...` | Session initializing, tools/skills coming online |
| `ready` | Agent is idle, accepting input |
| `thinking...` | Agent is reasoning or streaming a response |
| `running...` | Agent is executing a tool |
| `interrupted` | Current turn was cancelled |

---

## Key Bindings

| Key | Action |
|-----|--------|
| `Enter` | Send message (queues if agent is busy) |
| `Shift+Enter` | Insert newline |
| `Tab` | Next tab |
| `Shift+Tab` | Previous tab |
| `Ctrl+C` | Interrupt agent / clear draft / quit |
| `Ctrl+D` | Exit TUI |
| `Ctrl+L` | New session |
| `Ctrl+X` | Remove last queued message |
| `Esc` | Interrupt running agent |
| `?` | Open help overlay panel |
| `T` | Toggle agent tree sidebar |
| `c` | Switch to Chat tab |
| `d` | Switch to Dashboard tab |
| `a` | Switch to Agents tab |
| `s` | Switch to Settings tab |
| `q` | Quit (when not in chat input) |
| `p` | Pause/resume (dashboard demo) |
| `j/k` | Navigate agent list |
| `r` | Refresh agent list |

---

## Flags

| Flag | Default | Description |
|------|---------|-------------|
| `--url` | `http://localhost:8080` | agentic-core HTTP API URL |

---

## Features

- **Non-blocking input queue** — type while agent processes, messages auto-drain
- **Slash commands** — `/help`, `/clear`, `/new`, `/quit`, `/retry`, `/undo`, `/queue`, `/details`
- **Markdown rendering** — assistant responses render headings, bold, italic, code, lists, blockquotes
- **Tool activity panel** — live progress of tool calls with completion/failure states
- **Streaming elapsed timer** — shows per-response duration in the viewport
- **Help overlay** — `?` opens a modal panel with all keybindings and commands
- **Agent state in status bar** — real-time connection status and agent lifecycle
- **Queue preview** — shows queued messages in the chat view
- **Agent tree sidebar** — `T` toggles a tree view of multi-agent execution
- **Tab-based navigation** — Chat, Dashboard, Agents, Settings
- **Dashboard** — live status, progress bar, task tracking, token/cost estimation
- **Agent list** — browse and select registered personas
- **Theme system** — dark, catppuccin, dracula, solarized, high-contrast
- **Streaming tokens** — responses stream in real-time
- **5 built-in themes** — switch via `/theme` command

---

## Technical Stack

| Component | Technology |
|-----------|------------|
| Language | Go 1.26+ |
| TUI framework | Bubble Tea v2 (Charm ecosystem) |
| Styling | Lipgloss v2 |
| API transport | HTTP REST + Ollama-compatible streaming |
| Build tool | Go toolchain |
