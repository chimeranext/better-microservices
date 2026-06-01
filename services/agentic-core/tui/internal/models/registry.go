package models

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"time"
)

type ModelEntry struct {
	ID         string `json:"id"`
	Provider   string `json:"provider"`
	Name       string `json:"name"`
	ModelType  string `json:"type"`     // "cloud" | "local" | "hybrid"
	ToolCall   bool   `json:"tool_call"`
	OpenWeights bool  `json:"open_weights"`
	APIBase    string `json:"api_base,omitempty"`
}

type Registry struct {
	mu           sync.RWMutex
	entries      []ModelEntry
	backendURL   string
	modelsDevURL string
	cachePath    string
	ttl          time.Duration
	lastFetch    time.Time
}

type CacheData struct {
	FetchedAt time.Time    `json:"fetched_at"`
	Entries   []ModelEntry `json:"entries"`
}

type modelsAPIResponse struct {
	Models []ModelEntry `json:"models"`
	Count  int          `json:"count"`
	Cached bool         `json:"cached"`
}

var DefaultRegistry *Registry

func init() {
	cacheDir, err := os.UserCacheDir()
	if err != nil {
		cacheDir = os.TempDir()
	}
	cachePath := filepath.Join(cacheDir, "agentic-core", "models.json")
	DefaultRegistry = NewRegistry("http://localhost:8080", cachePath, time.Hour)
}

func NewRegistry(backendURL, cachePath string, ttl time.Duration, modelsURL ...string) *Registry {
	devURL := "https://models.dev/api.json"
	if len(modelsURL) > 0 && modelsURL[0] != "" {
		devURL = modelsURL[0]
	}
	r := &Registry{
		backendURL:   backendURL,
		modelsDevURL: devURL,
		cachePath:    cachePath,
		ttl:          ttl,
	}
	r.loadCache()

	if len(r.entries) == 0 {
		r.fetch()
	}

	return r
}

func (r *Registry) List() []ModelEntry {
	r.mu.RLock()
	defer r.mu.RUnlock()

	if len(r.entries) == 0 {
		return nil
	}
	result := make([]ModelEntry, len(r.entries))
	copy(result, r.entries)
	return result
}

func (r *Registry) Refresh() error {
	r.mu.Lock()
	r.lastFetch = time.Time{}
	r.mu.Unlock()
	return r.fetch()
}

func (r *Registry) FormatPickerItems() []string {
	entries := r.List()
	items := make([]string, 0, len(entries)+1)
	items = append(items, "asistente-demo (local)")
	for _, e := range entries {
		if e.ToolCall {
			tag := ""
			switch e.ModelType {
			case "cloud":
				tag = "\u2601" // ☁
			case "local":
				tag = "\ud83d\udcbb" // 💻
			case "hybrid":
				tag = "\u2601\ud83d\udcbb" // ☁💻
			}
			items = append(items, fmt.Sprintf("%s -- %s  %s", e.ID, e.Name, tag))
		}
	}
	return items
}

func (r *Registry) RawItems() []string {
	entries := r.List()
	items := make([]string, 0, len(entries)+1)
	items = append(items, "asistente-demo")
	for _, e := range entries {
		if e.ToolCall {
			items = append(items, e.ID)
		}
	}
	return items
}

func (r *Registry) loadCache() {
	data, err := os.ReadFile(r.cachePath)
	if err != nil {
		return
	}

	var cache CacheData
	if err := json.Unmarshal(data, &cache); err != nil {
		return
	}

	if time.Since(cache.FetchedAt) > r.ttl {
		return
	}

	r.mu.Lock()
	r.entries = cache.Entries
	r.lastFetch = cache.FetchedAt
	r.mu.Unlock()
}

func (r *Registry) fetch() error {
	var entries []ModelEntry

	entries, err := r.fetchFromBackend()
	if err == nil && len(entries) > 0 {
		r.mu.Lock()
		r.entries = entries
		r.lastFetch = time.Now()
		r.mu.Unlock()
		r.saveCache()
		return nil
	}

	entries, err = r.fetchFromModelsDev()
	if err == nil && len(entries) > 0 {
		r.mu.Lock()
		r.entries = entries
		r.lastFetch = time.Now()
		r.mu.Unlock()
		r.saveCache()
		return nil
	}

	return fmt.Errorf("all model sources failed: backend=%v, models.dev=%v", err, err)
}

func (r *Registry) fetchFromBackend() ([]ModelEntry, error) {
	apiURL := fmt.Sprintf("%s/api/models?tool_call=true", strings.TrimRight(r.backendURL, "/"))
	resp, err := http.Get(apiURL)
	if err != nil {
		return nil, fmt.Errorf("backend unreachable: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("backend status %d", resp.StatusCode)
	}

	var apiResp modelsAPIResponse
	if err := json.NewDecoder(resp.Body).Decode(&apiResp); err != nil {
		return nil, fmt.Errorf("parse backend response: %w", err)
	}

	return apiResp.Models, nil
}

func (r *Registry) fetchFromModelsDev() ([]ModelEntry, error) {
	resp, err := http.Get(r.modelsDevURL)
	if err != nil {
		return nil, fmt.Errorf("models.dev unreachable: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("models.dev status %d", resp.StatusCode)
	}

	var providers map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&providers); err != nil {
		return nil, fmt.Errorf("parse models.dev: %w", err)
	}

	type providerInfo struct {
		name string
		mtype string
	}
	wellKnownProviders := map[string]providerInfo{
		"openai": {"OpenAI", "cloud"}, "anthropic": {"Anthropic", "cloud"},
		"google": {"Google", "cloud"}, "deepseek": {"DeepSeek", "hybrid"},
		"mistral": {"Mistral", "hybrid"}, "groq": {"Groq", "cloud"},
		"together": {"Together", "cloud"}, "openrouter": {"OpenRouter", "cloud"},
		"meta": {"Meta", "local"}, "fireworks-ai": {"Fireworks AI", "cloud"},
		"perplexity": {"Perplexity", "cloud"}, "cohere": {"Cohere", "cloud"},
		"xai": {"xAI", "cloud"}, "replicate": {"Replicate", "cloud"},
		"amazon": {"AWS Bedrock", "cloud"}, "azure": {"Azure", "cloud"},
		"ibm": {"IBM Watsonx", "cloud"}, "huggingface": {"Hugging Face", "hybrid"},
		"alibaba": {"Alibaba Cloud", "cloud"}, "nvidia": {"NVIDIA", "hybrid"},
		"scaleway": {"Scaleway", "cloud"}, "abacus": {"Abacus AI", "cloud"},
		"nano-gpt": {"Nano GPT", "cloud"}, "ai21": {"AI21", "cloud"},
		"kimi": {"Kimi (Moonshot)", "cloud"}, "moonshot": {"Moonshot AI", "cloud"},
		"ollama-cloud": {"Ollama Cloud", "hybrid"},
		"vllm":     {"vLLM (Sidecar)", "local"},
	}

	var entries []ModelEntry
	seen := make(map[string]bool)

	for providerID, providerRaw := range providers {
		provider, ok := providerRaw.(map[string]interface{})
		if !ok {
			continue
		}

		pinfo := providerInfo{name: providerID, mtype: "cloud"}
		if p, ok := wellKnownProviders[providerID]; ok {
			pinfo = p
		}

		apiBase, _ := provider["api"].(string)

		modelsRaw, ok := provider["models"].(map[string]interface{})
		if !ok {
			continue
		}

		for modelID, modelRaw := range modelsRaw {
			model, ok := modelRaw.(map[string]interface{})
			if !ok {
				continue
			}

			toolCall, _ := model["tool_call"].(bool)
			if !toolCall {
				continue
			}

			fullID := fmt.Sprintf("%s/%s", providerID, modelID)
			if seen[fullID] {
				continue
			}
			seen[fullID] = true

			modelName, _ := model["name"].(string)
			if modelName == "" {
				modelName = modelID
			}

			openWeights, _ := model["open_weights"].(bool)

			modelType := pinfo.mtype
			if openWeights && pinfo.mtype == "cloud" {
				modelType = "local"
			} else if !openWeights {
				modelType = "cloud"
			}

			entries = append(entries, ModelEntry{
				ID:          fullID,
				Provider:    pinfo.name,
				Name:        modelName,
				ModelType:   modelType,
				ToolCall:    toolCall,
				OpenWeights: openWeights,
				APIBase:     apiBase,
			})
		}
	}

	sort.Slice(entries, func(i, j int) bool {
		if entries[i].Provider != entries[j].Provider {
			return entries[i].Provider < entries[j].Provider
		}
		return entries[i].Name < entries[j].Name
	})

	return entries, nil
}

func (r *Registry) saveCache() {
	r.mu.RLock()
	data := CacheData{
		FetchedAt: r.lastFetch,
		Entries:   r.entries,
	}
	r.mu.RUnlock()

	raw, err := json.MarshalIndent(data, "", "  ")
	if err != nil {
		return
	}

	if err := os.MkdirAll(filepath.Dir(r.cachePath), 0755); err != nil {
		return
	}
	os.WriteFile(r.cachePath, raw, 0644)
}

func (r *Registry) LastFetch() time.Time {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return r.lastFetch
}

func (r *Registry) Count() int {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return len(r.entries)
}
