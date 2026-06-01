package api

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/lapc506/agentic-core/tui/internal/types"
)

type Client struct {
	BaseURL  string
	Provider string
}

func NewClient(baseURL string) *Client {
	return &Client{BaseURL: baseURL}
}

func (c *Client) Health() (*types.HealthResponse, error) {
	resp, err := http.Get(c.BaseURL + "/api/health")
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result types.HealthResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, err
	}
	return &result, nil
}

func (c *Client) ListAgents() ([]types.Agent, error) {
	resp, err := http.Get(c.BaseURL + "/api/agents")
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var agents []types.Agent
	if err := json.NewDecoder(resp.Body).Decode(&agents); err != nil {
		return nil, err
	}
	return agents, nil
}

func (c *Client) ChatStream(model string, messages []types.ChatMessage, callback func(string)) error {
	type message struct {
		Role    string `json:"role"`
		Content string `json:"content"`
	}
	type request struct {
		Model    string    `json:"model"`
		Messages []message `json:"messages"`
		Stream   bool      `json:"stream"`
		Provider string    `json:"provider,omitempty"`
	}

	var msgs []message
	for _, m := range messages {
		msgs = append(msgs, message{Role: m.Role, Content: m.Content})
	}

	reqBody := request{Model: model, Messages: msgs, Stream: true}
	if c.Provider != "" {
		reqBody.Provider = c.Provider
	}

	body, err := json.Marshal(reqBody)
	if err != nil {
		return err
	}

	resp, err := http.Post(c.BaseURL+"/api/chat", "application/json", bytes.NewReader(body))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		respBody, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("API error (status %d): %s", resp.StatusCode, string(respBody))
	}

	decoder := json.NewDecoder(resp.Body)
	for {
		var chunk map[string]interface{}
		if err := decoder.Decode(&chunk); err != nil {
			if err == io.EOF {
				break
			}
			return err
		}
		if msg, ok := chunk["message"].(map[string]interface{}); ok {
			if content, ok := msg["content"].(string); ok && content != "" {
				callback(content)
			}
		}
		if done, ok := chunk["done"].(bool); ok && done {
			break
		}
	}
	return nil
}
