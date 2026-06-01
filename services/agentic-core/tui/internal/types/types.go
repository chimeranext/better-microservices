package types

type Agent struct {
	Name          string `json:"name"`
	Slug          string `json:"slug"`
	Role          string `json:"role"`
	Description   string `json:"description"`
	GraphTemplate string `json:"graph_template"`
}

type ChatMessage struct {
	Role    string
	Content string
}

type HealthResponse struct {
	Status string `json:"status"`
}

type QueueItem struct {
	ID      int
	Content string
	Editing bool
}

type AgentState string

const (
	AgentStarting    AgentState = "starting"
	AgentReady       AgentState = "ready"
	AgentThinking    AgentState = "thinking"
	AgentRunning     AgentState = "running"
	AgentInterrupted AgentState = "interrupted"
	AgentIdle        AgentState = "idle"
)

type ToolActivity struct {
	ToolID   string
	Name     string
	Status   string
	Preview  string
}

type ActivityUpdate struct {
	ToolID  string
	Name    string
	Status  string
	Preview string
	Done    bool
}

type SessionInfo struct {
	ID    string
	Title string
	Agent string
}
