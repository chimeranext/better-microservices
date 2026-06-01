from __future__ import annotations

from agentic_core.adapters.primary.tui import (
    DEFAULT_KEYBINDINGS,
    TUIAdapter,
    TUIConfig,
    TUIPanel,
    TUIState,
    AgentState,
    QueueItem,
    ToolActivity,
)


def test_tui_panel_values() -> None:
    assert TUIPanel.CONVERSATION.value == "conversation"
    assert TUIPanel.TOOLS.value == "tools"
    assert TUIPanel.STATUS.value == "status"
    assert TUIPanel.SESSIONS.value == "sessions"


def test_agent_state_values() -> None:
    assert AgentState.STARTING.value == "starting"
    assert AgentState.READY.value == "ready"
    assert AgentState.THINKING.value == "thinking"
    assert AgentState.RUNNING.value == "running"
    assert AgentState.INTERRUPTED.value == "interrupted"


def test_tui_config_defaults() -> None:
    cfg = TUIConfig()
    assert TUIPanel.CONVERSATION in cfg.show_panels
    assert cfg.show_timestamps is True
    assert cfg.max_history == 1000
    assert cfg.theme == "default"


def test_tui_config_custom() -> None:
    cfg = TUIConfig(show_panels=[TUIPanel.CONVERSATION], show_timestamps=False, max_history=50, theme="dark")
    assert cfg.show_panels == [TUIPanel.CONVERSATION]
    assert cfg.show_timestamps is False
    assert cfg.max_history == 50
    assert cfg.theme == "dark"


def test_default_keybindings_count() -> None:
    assert len(DEFAULT_KEYBINDINGS) == 20


def test_default_keybindings_have_hermes_actions() -> None:
    actions = {kb["action"] for kb in DEFAULT_KEYBINDINGS}
    assert "send_or_queue" in actions
    assert "interrupt_clear_quit" in actions
    assert "new_session" in actions
    assert "remove_last_queued" in actions
    assert "show_help" in actions
    assert "slash_help" in actions
    assert "slash_clear" in actions
    assert "slash_quit" in actions
    assert "slash_queue" in actions


def test_tui_state_defaults() -> None:
    state = TUIState()
    assert state.active_panel == TUIPanel.CONVERSATION
    assert state.messages == []
    assert state.queue == []
    assert state.activities == []
    assert state.agent_state == AgentState.STARTING
    assert state.streaming is False


def test_adapter_default_config() -> None:
    adapter = TUIAdapter()
    assert adapter.config.theme == "default"
    assert adapter.get_state().session_id is not None


def test_adapter_add_message() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "Hello")
    adapter.add_message("assistant", "Hi there")
    state = adapter.get_state()
    assert len(state.messages) == 2
    assert state.messages[0] == {"role": "user", "content": "Hello"}


def test_adapter_add_tool_output() -> None:
    adapter = TUIAdapter()
    adapter.add_tool_output("search", "3 results found")
    state = adapter.get_state()
    assert len(state.tool_outputs) == 1
    assert "[search] 3 results found" in state.tool_outputs[0]


def test_adapter_switch_panel() -> None:
    adapter = TUIAdapter()
    assert adapter.get_state().active_panel == TUIPanel.CONVERSATION
    adapter.switch_panel(TUIPanel.TOOLS)
    assert adapter.get_state().active_panel == TUIPanel.TOOLS


def test_adapter_clear() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "msg1")
    adapter.add_tool_output("tool", "out1")
    adapter.enqueue_message("queued")
    adapter.start_tool("t1", "test")
    adapter.clear()
    state = adapter.get_state()
    assert state.messages == []
    assert state.tool_outputs == []
    assert state.queue == []
    assert state.activities == []


def test_max_history_truncation() -> None:
    cfg = TUIConfig(max_history=3)
    adapter = TUIAdapter(config=cfg)
    for i in range(5):
        adapter.add_message("user", f"msg{i}")
    state = adapter.get_state()
    assert len(state.messages) == 3
    assert state.messages[0]["content"] == "msg2"


def test_max_history_truncation_tool_outputs() -> None:
    cfg = TUIConfig(max_history=2)
    adapter = TUIAdapter(config=cfg)
    for i in range(4):
        adapter.add_tool_output("t", f"out{i}")
    state = adapter.get_state()
    assert len(state.tool_outputs) == 2


# ── Queue (non-blocking input) ───────────────────────────────


def test_enqueue_message() -> None:
    adapter = TUIAdapter()
    item = adapter.enqueue_message("hello")
    assert item.content == "hello"
    assert item.id == 1
    assert len(adapter.get_state().queue) == 1


def test_dequeue_message() -> None:
    adapter = TUIAdapter()
    adapter.enqueue_message("first")
    adapter.enqueue_message("second")
    item = adapter.dequeue_message()
    assert item is not None
    assert item.content == "first"
    assert len(adapter.get_state().queue) == 1


def test_dequeue_empty() -> None:
    adapter = TUIAdapter()
    assert adapter.dequeue_message() is None


def test_remove_last_queued() -> None:
    adapter = TUIAdapter()
    adapter.enqueue_message("a")
    adapter.enqueue_message("b")
    assert adapter.remove_last_queued() is True
    assert len(adapter.get_state().queue) == 1
    assert adapter.get_state().queue[0].content == "a"


def test_remove_last_queued_empty() -> None:
    adapter = TUIAdapter()
    assert adapter.remove_last_queued() is False


def test_clear_queue() -> None:
    adapter = TUIAdapter()
    adapter.enqueue_message("a")
    adapter.enqueue_message("b")
    adapter.clear_queue()
    assert adapter.get_state().queue == []


def test_queue_auto_increment_id() -> None:
    adapter = TUIAdapter()
    a = adapter.enqueue_message("a")
    b = adapter.enqueue_message("b")
    assert b.id == a.id + 1


# ── Tool Activity ────────────────────────────────────────────


def test_start_tool() -> None:
    adapter = TUIAdapter()
    adapter.start_tool("t1", "search")
    state = adapter.get_state()
    assert len(state.activities) == 1
    assert state.activities[0].name == "search"
    assert state.activities[0].status == "running"


def test_complete_tool() -> None:
    adapter = TUIAdapter()
    adapter.start_tool("t1", "search")
    adapter.complete_tool("t1")
    state = adapter.get_state()
    assert state.activities[0].status == "completed"


def test_fail_tool() -> None:
    adapter = TUIAdapter()
    adapter.start_tool("t1", "search")
    adapter.fail_tool("t1")
    state = adapter.get_state()
    assert state.activities[0].status == "failed"


def test_update_tool_with_preview() -> None:
    adapter = TUIAdapter()
    adapter.start_tool("t1", "search")
    adapter.update_tool("t1", "running", "searching...")
    state = adapter.get_state()
    assert state.activities[0].preview == "searching..."


def test_clear_activities() -> None:
    adapter = TUIAdapter()
    adapter.start_tool("t1", "search")
    adapter.clear_activities()
    assert adapter.get_state().activities == []


# ── Agent State ──────────────────────────────────────────────


def test_set_agent_state() -> None:
    adapter = TUIAdapter()
    assert adapter.get_state().agent_state == AgentState.STARTING
    adapter.set_agent_state(AgentState.READY)
    assert adapter.get_state().agent_state == AgentState.READY


def test_set_streaming() -> None:
    adapter = TUIAdapter()
    adapter.set_streaming(True)
    assert adapter.get_state().streaming is True
    adapter.set_streaming(False)
    assert adapter.get_state().streaming is False


# ── Overlays ─────────────────────────────────────────────────


def test_show_overlay() -> None:
    adapter = TUIAdapter()
    adapter.show_overlay("help", "Help", ["item1", "item2"])
    o = adapter.get_state().overlay
    assert o.active is True
    assert o.kind == "help"
    assert o.title == "Help"
    assert o.items == ["item1", "item2"]


def test_close_overlay() -> None:
    adapter = TUIAdapter()
    adapter.show_overlay("help", "Help", ["item1"])
    adapter.close_overlay()
    assert adapter.get_state().overlay.active is False


def test_overlay_cursor_navigation() -> None:
    adapter = TUIAdapter()
    adapter.show_overlay("picker", "Pick", ["a", "b", "c"])
    assert adapter.get_state().overlay.cursor == 0
    adapter.overlay_cursor_down()
    assert adapter.get_state().overlay.cursor == 1
    adapter.overlay_cursor_down()
    assert adapter.get_state().overlay.cursor == 2
    adapter.overlay_cursor_down()  # should not go past end
    assert adapter.get_state().overlay.cursor == 2
    adapter.overlay_cursor_up()
    assert adapter.get_state().overlay.cursor == 1
    adapter.overlay_cursor_up()
    assert adapter.get_state().overlay.cursor == 0
    adapter.overlay_cursor_up()  # should not go below 0
    assert adapter.get_state().overlay.cursor == 0


# ── Slash Commands ───────────────────────────────────────────


def test_slash_help_shows_overlay() -> None:
    adapter = TUIAdapter()
    adapter.handle_slash("help")
    assert adapter.get_state().overlay.active is True
    assert adapter.get_state().overlay.kind == "help"


def test_slash_clear_clears_state() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "hello")
    adapter.enqueue_message("queued")
    adapter.start_tool("t1", "test")
    adapter.handle_slash("clear")
    state = adapter.get_state()
    assert state.messages == []
    assert state.queue == []
    assert state.activities == []
    assert state.agent_state == AgentState.READY


def test_slash_new_clears_state() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "hello")
    adapter.handle_slash("new")
    assert adapter.get_state().messages == []


def test_slash_quit() -> None:
    adapter = TUIAdapter()
    result = adapter.handle_slash("quit")
    assert result == "__QUIT__"


def test_slash_exit() -> None:
    adapter = TUIAdapter()
    result = adapter.handle_slash("exit")
    assert result == "__QUIT__"


def test_slash_queue_empty() -> None:
    adapter = TUIAdapter()
    result = adapter.handle_slash("queue")
    assert "No queued messages" in result


def test_slash_queue_with_items() -> None:
    adapter = TUIAdapter()
    adapter.enqueue_message("first msg")
    adapter.enqueue_message("second msg")
    result = adapter.handle_slash("queue")
    assert "Queued messages" in result
    assert "first msg" in result
    assert "second msg" in result


def test_slash_undo_removes_turns() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "hello")
    adapter.add_message("assistant", "hi")
    adapter.handle_slash("undo")
    assert len(adapter.get_state().messages) == 0


def test_slash_unknown() -> None:
    adapter = TUIAdapter()
    result = adapter.handle_slash("nonexistent")
    assert "Unknown command" in result


def test_slash_retry() -> None:
    adapter = TUIAdapter()
    adapter.add_message("user", "hello")
    adapter.add_message("assistant", "hi")
    adapter.handle_slash("retry")
    assert len(adapter.get_state().messages) == 1


def test_slash_details_no_error() -> None:
    adapter = TUIAdapter()
    result = adapter.handle_slash("details")
    assert result is None
