package ui

import (
	"fmt"
	"strings"

	"charm.land/lipgloss/v2"
	"github.com/lapc506/agentic-core/tui/internal/types"
)

type QueueModel struct {
	items    []types.QueueItem
	nextID   int
	editIdx  int
	editBuf  string
	editing  bool
}

func NewQueueModel() QueueModel {
	return QueueModel{nextID: 1, editIdx: -1}
}

func (q *QueueModel) Enqueue(content string) {
	q.items = append(q.items, types.QueueItem{
		ID:      q.nextID,
		Content: content,
	})
	q.nextID++
}

func (q *QueueModel) Dequeue() (string, bool) {
	if len(q.items) == 0 {
		return "", false
	}
	item := q.items[0]
	q.items = q.items[1:]
	if q.editIdx == 0 {
		q.editIdx = -1
		q.editing = false
	} else if q.editIdx > 0 {
		q.editIdx--
	}
	return item.Content, true
}

func (q *QueueModel) Peek() (string, bool) {
	if len(q.items) == 0 {
		return "", false
	}
	return q.items[0].Content, true
}

func (q *QueueModel) Len() int {
	return len(q.items)
}

func (q *QueueModel) Items() []types.QueueItem {
	return q.items
}

func (q *QueueModel) Clear() {
	q.items = nil
	q.editIdx = -1
	q.editing = false
}

func (q *QueueModel) RemoveLast() bool {
	if len(q.items) == 0 {
		return false
	}
	q.items = q.items[:len(q.items)-1]
	return true
}

func (q *QueueModel) StartEdit(offset int) bool {
	if offset < 0 || offset >= len(q.items) {
		return false
	}
	q.editIdx = offset
	q.editBuf = q.items[offset].Content
	q.editing = true
	return true
}

func (q *QueueModel) CommitEdit(newContent string) {
	if !q.editing || q.editIdx < 0 || q.editIdx >= len(q.items) {
		return
	}
	q.items[q.editIdx].Content = newContent
	q.items[q.editIdx].Editing = false
	q.editing = false
	q.editIdx = -1
}

func (q *QueueModel) CancelEdit() {
	if !q.editing {
		return
	}
	q.editing = false
	q.editIdx = -1
}

func (q *QueueModel) IsEditing() bool {
	return q.editing
}

func (q *QueueModel) EditingContent() string {
	return q.editBuf
}

func (q *QueueModel) SetEditingContent(s string) {
	q.editBuf = s
}

func (q *QueueModel) View(width int) string {
	if len(q.items) == 0 {
		return ""
	}

	var sb strings.Builder
	lines := make([]string, 0, len(q.items))

	for i, item := range q.items {
		prefix := fmt.Sprintf("  %s %2d: ", StyleWarning.Render("\u25a0"), i+1)
		display := item.Content
		if len(display) > width-len(prefix)-10 {
			display = display[:width-len(prefix)-13] + "..."
		}
		lines = append(lines, prefix+StyleQueueItem.Render(display))
	}

	if len(lines) > 3 {
		lines = lines[:3]
		lines = append(lines, fmt.Sprintf("  %s ... %d more",
			StyleWarning.Render("\u25a0"), len(q.items)-3))
	}

	sb.WriteString(lipgloss.NewStyle().
		BorderStyle(lipgloss.RoundedBorder()).
		BorderForeground(ColorWarning).
		BorderTop(true).
		Padding(0, 1).
		Width(width-4).
		Render(strings.Join(lines, "\n")))

	return sb.String()
}
