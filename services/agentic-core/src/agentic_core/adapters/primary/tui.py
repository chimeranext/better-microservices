from __future__ import annotations

import logging
import uuid
from enum import StrEnum
from dataclasses import dataclass, field

logger = logging.getLogger(__name__)


class AgentState(StrEnum):
    STARTING = "starting"
    READY = "ready"
    THINKING = "thinking"
    RUNNING = "running"
    INTERRUPTED = "interrupted"
    IDLE = "idle"


class TUIPanel(StrEnum):
    CONVERSATION = "conversation"
    TOOLS = "tools"
    STATUS = "status"
    SESSIONS = "sessions"


@dataclass
class QueueItem:
    id: int
    content: str
    editing: bool = False


@dataclass
class ToolActivity:
    tool_id: str
    name: str
    status: str  # running | completed | failed | pending
    preview: str = ""


@dataclass
class OverlayState:
    active: bool = False
    kind: str = ""  # help | sessions | model_picker | confirm
    title: str = ""
    items: list[str] = field(default_factory=list)
    cursor: int = 0
    prompt: str = ""


@dataclass
class TUIConfig:
    show_panels: list[TUIPanel] | None = None
    show_timestamps: bool = True
    max_history: int = 1000
    theme: str = "default"

    def __post_init__(self):
        if self.show_panels is None:
            self.show_panels = [
                TUIPanel.CONVERSATION,
                TUIPanel.TOOLS,
                TUIPanel.STATUS,
            ]


@dataclass
class TUIState:
    active_panel: TUIPanel = TUIPanel.CONVERSATION
    session_id: str | None = None
    messages: list[dict] = field(default_factory=list)
    tool_outputs: list[str] = field(default_factory=list)
    agent_state: AgentState = AgentState.STARTING
    queue: list[QueueItem] = field(default_factory=list)
    activities: list[ToolActivity] = field(default_factory=list)
    overlay: OverlayState = field(default_factory=OverlayState)
    streaming: bool = False
    elapsed_seconds: int = 0
    next_queue_id: int = 1


DEFAULT_KEYBINDINGS: list[dict] = [
    {"key": "enter", "action": "send_or_queue", "description": "Send message (or queue if busy)"},
    {"key": "shift+enter", "action": "newline", "description": "Insert newline"},
    {"key": "ctrl+c", "action": "interrupt_clear_quit", "description": "Interrupt / clear draft / quit"},
    {"key": "ctrl+d", "action": "quit", "description": "Exit TUI"},
    {"key": "ctrl+l", "action": "new_session", "description": "New session"},
    {"key": "ctrl+x", "action": "remove_last_queued", "description": "Remove last queued message"},
    {"key": "esc", "action": "interrupt", "description": "Interrupt running agent"},
    {"key": "?", "action": "show_help", "description": "Open help overlay"},
    {"key": "tab", "action": "switch_panel", "description": "Switch to next panel"},
    {"key": "shift+tab", "action": "prev_panel", "description": "Switch to previous panel"},
    {"key": "T", "action": "toggle_tree", "description": "Toggle agent tree sidebar"},
    {"key": "/help", "action": "slash_help", "description": "Show help"},
    {"key": "/clear", "action": "slash_clear", "description": "New session"},
    {"key": "/new", "action": "slash_new", "description": "Start fresh session"},
    {"key": "/quit", "action": "slash_quit", "description": "Exit TUI"},
    {"key": "/queue", "action": "slash_queue", "description": "Show queued messages"},
    {"key": "/retry", "action": "slash_retry", "description": "Regenerate last response"},
    {"key": "/undo", "action": "slash_undo", "description": "Remove last turn"},
    {"key": "/details", "action": "slash_details", "description": "Toggle tool details"},
    {"key": "/model", "action": "slash_model", "description": "Open model picker"},
]


class TUIAdapter:
    """TUI adapter with Hermes-like behavior: non-blocking input queue,
    slash commands, overlays, tool activity tracking, and agent state machine.
    """

    def __init__(self, config: TUIConfig | None = None) -> None:
        self._config = config or TUIConfig()
        self._state = TUIState(session_id=str(uuid.uuid4()))
        self._keybindings = list(DEFAULT_KEYBINDINGS)

    @property
    def config(self) -> TUIConfig:
        return self._config

    @property
    def keybindings(self) -> list[dict]:
        return list(self._keybindings)

    def get_state(self) -> TUIState:
        return self._state

    # --- Message handling ---

    def add_message(self, role: str, content: str) -> None:
        msg = {"role": role, "content": content}
        self._state.messages.append(msg)
        max_hist = self._config.max_history
        if len(self._state.messages) > max_hist:
            self._state.messages = self._state.messages[-max_hist:]

    def add_tool_output(self, tool_name: str, output: str) -> None:
        formatted = f"[{tool_name}] {output}"
        self._state.tool_outputs.append(formatted)
        max_hist = self._config.max_history
        if len(self._state.tool_outputs) > max_hist:
            self._state.tool_outputs = self._state.tool_outputs[-max_hist:]

    # --- Queue (non-blocking input) ---

    def enqueue_message(self, content: str) -> QueueItem:
        item = QueueItem(id=self._state.next_queue_id, content=content)
        self._state.queue.append(item)
        self._state.next_queue_id += 1
        return item

    def dequeue_message(self) -> QueueItem | None:
        if not self._state.queue:
            return None
        return self._state.queue.pop(0)

    def remove_last_queued(self) -> bool:
        if not self._state.queue:
            return False
        self._state.queue.pop()
        return True

    def clear_queue(self) -> None:
        self._state.queue.clear()

    def queue_preview(self, max_items: int = 3) -> list[str]:
        return [item.content for item in self._state.queue[:max_items]]

    # --- Tool activity ---

    def start_tool(self, tool_id: str, name: str) -> None:
        self._state.activities.append(
            ToolActivity(tool_id=tool_id, name=name, status="running")
        )

    def update_tool(self, tool_id: str, status: str, preview: str = "") -> None:
        for act in self._state.activities:
            if act.tool_id == tool_id:
                act.status = status
                if preview:
                    act.preview = preview
                break

    def complete_tool(self, tool_id: str) -> None:
        self.update_tool(tool_id, "completed")

    def fail_tool(self, tool_id: str) -> None:
        self.update_tool(tool_id, "failed")

    def clear_activities(self) -> None:
        self._state.activities.clear()

    # --- Agent state ---

    def set_agent_state(self, state: AgentState) -> None:
        self._state.agent_state = state

    def set_streaming(self, streaming: bool) -> None:
        self._state.streaming = streaming

    # --- Overlay ---

    def show_overlay(self, kind: str, title: str, items: list[str], prompt: str = "") -> None:
        self._state.overlay = OverlayState(
            active=True,
            kind=kind,
            title=title,
            items=items,
            cursor=0,
            prompt=prompt,
        )

    def close_overlay(self) -> None:
        self._state.overlay = OverlayState()

    def overlay_cursor_up(self) -> None:
        if self._state.overlay.cursor > 0:
            self._state.overlay.cursor -= 1

    def overlay_cursor_down(self) -> None:
        o = self._state.overlay
        if o.cursor < len(o.items) - 1:
            o.cursor += 1

    # --- Slash commands ---

    def handle_slash(self, command: str) -> str | None:
        cmd = command.lower()
        if cmd == "help":
            self.show_overlay("help", "Help & Keybindings", [
                "Enter: Send/queue  Shift+Enter: Newline",
                "Ctrl+C: Interrupt/clear/quit",
                "Ctrl+D: Exit  Ctrl+L: New session",
                "Ctrl+X: Remove last queued",
                "Esc: Interrupt  ?: Help overlay",
                "/clear, /new: New session",
                "/queue: View queue  /retry: Regenerate",
                "/undo: Remove last turn  /details: Toggle tools",
            ])
            return None
        elif cmd in ("clear", "new"):
            self._state.messages.clear()
            self.clear_activities()
            self.clear_queue()
            self.set_agent_state(AgentState.READY)
            self.set_streaming(False)
            return None
        elif cmd in ("quit", "exit"):
            return "__QUIT__"
        elif cmd == "queue":
            if not self._state.queue:
                return "No queued messages."
            items = "\n".join(
                f"  {i+1}. {item.content}"
                for i, item in enumerate(self._state.queue)
            )
            return f"Queued messages ({len(self._state.queue)}):\n{items}"
        elif cmd == "retry":
            # Remove last assistant message so it can be regenerated
            if len(self._state.messages) >= 2:
                self._state.messages.pop()
            return None
        elif cmd == "undo":
            # Remove last user + assistant turn
            removed = 0
            while self._state.messages and removed < 2:
                self._state.messages.pop()
                removed += 1
            return None
        elif cmd == "details":
            return None
        else:
            return f"Unknown command: /{cmd}. Type /help for available commands."

    # --- Panel ---

    def switch_panel(self, panel: TUIPanel) -> None:
        self._state.active_panel = panel

    def clear(self) -> None:
        self._state.messages.clear()
        self._state.tool_outputs.clear()
        self.clear_queue()
        self.clear_activities()
