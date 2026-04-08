# MCP Server Skill — RAG-First Memory & Context Management

## Overview

The MCP (Model Context Protocol) server provides a **RAG-first** architecture for AI agents — one where **memory is not an afterthought but the foundation of reasoning**. Every interaction should be guided by the principle:

> **Retrieve → Augment → Generate → Store → Repeat**

This creates a virtuous cycle where each response is better than the last because it builds on accumulated memory across multiple layers.

### The RAG-First Principle

**RAG (Retrieval-Augmented Generation)** means that before generating a response, you first retrieve relevant context from memory, then augment your reasoning with that context, and only then generate your output. This output is then **stored back into memory** for future retrieval.

```
┌─────────────────────────────────────────────────────────────────┐
│                     THE RAG CYCLE                               │
│                                                                 │
│   ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐  │
│   │ RETRIEVE │ →  │ AUGMENT  │ →  │ GENERATE │ →  │  STORE  │  │
│   │          │    │          │    │          │    │         │  │
│   │ Query     │    │ Build    │    │ Produce  │    │ Persist │  │
│   │ memory    │    │ context  │    │ response │    │ for later│ │
│   └──────────┘    └──────────┘    └──────────┘    └──────────┘  │
│        ↑                                                      │
│        └─────────────────── Loop ──────────────────────────────┘
└─────────────────────────────────────────────────────────────────┘
```

**Core Rule**: Always retrieve before generating. Always store after learning.

---

## The Layered Memory System

Memory is not a single bucket — it's a **layered architecture** where each layer serves different purposes:

```
┌─────────────────────────────────────────────────────────────────┐
│                    MEMORY PYRAMID                                │
│                                                                 │
│                         ┌───────────────┐                        │
│                         │ KNOWLEDGE     │  ← Long-term facts,  │
│                         │ GRAPH         │    relationships,     │
│                         └───────┬───────┘    entities           │
│                                 │                                │
│                    ┌────────────┴────────────┐                 │
│                    │ KNOWLEDGE BASE           │  ← Structured   │
│                    │                          │    facts, FAQs, │
│                    └────────────┬────────────┘    definitions  │
│                                 │                                │
│              ┌──────────────────┴──────────────────┐            │
│              │ PERSISTENT MEMORY                   │  ← Session │
│              │                                       │    state,  │
│              └───────────────┬───────────────────────┘    user prefs│
│                                │                                │
│           ┌────────────────────┴────────────────────┐           │
│           │ SESSION MEMORY                          │  ← Current │
│           │                                         │    conversation│
│           └─────────────────────────────────────────┘    context   │
└─────────────────────────────────────────────────────────────────┘
```

### Layer 1: Session Memory (Shortest-Term)

**Purpose**: Holds the immediate context of the current conversation.

**Tools**: 
- `session/create` — Initialize with explicit goals and constraints
- `session/update` — Add new context as conversation evolves
- `session/archive` — Persist important conclusions before ending

**When to use**:
- At the start of every session, explicitly define the goal
- When the user introduces a new topic or constraint
- Before making significant decisions, check what the session already knows

**Example**:
```json
{
  "tool": "session/create",
  "params": {
    "name": "api-design-review",
    "context": {
      "goal": "Review and improve the authentication API",
      "constraints": ["must maintain backward compatibility", "timeline: 1 week"],
      "focus": ["security", "performance", "developer experience"]
    }
  }
}
```

### Layer 2: Persistent Memory (Cross-Session)

**Purpose**: Stores information that persists across sessions — user preferences, project state, accumulated findings.

**Tools**:
- `context/store` — Save information with explicit keys
- `context/retrieve` — Fetch by exact key match
- `context/search` — Find by pattern or content

**When to use**:
- After discovering facts about the user or project
- When completing milestones that others should know about
- Before starting new work, retrieve relevant persistent context

**Memory Storage Patterns**:

```json
{
  "tool": "context/store",
  "params": {
    "key": "user/preferences",
    "value": {
      "preferred_language": "typescript",
      "code_style": "explicit over implicit",
      "communication": "concise summaries with options"
    },
    "mode": "merge"
  }
}
```

### Layer 3: Knowledge Base (Structured Long-Term Memory)

**Purpose**: Holds organized, searchable facts — FAQs, definitions, procedures, rules.

**Tools**:
- `rag_add_knowledge` — Add structured entries (faq, fact, definition, rule, procedure)
- `rag_search_knowledge` — Semantic search for relevant entries
- `rag_list_knowledge` — Browse by category, type, or importance

**Knowledge Types**:
| Type | Use Case | Example |
|------|----------|---------|
| `faq` | Q&A pairs | "How do I reset the password?" |
| `fact` | Statements | "The default port is 3000" |
| `definition` | Concept explanations | "What is OAuth2?" |
| `rule` | Guidelines | "Always validate input" |
| `procedure` | Step-by-step processes | "How to deploy to production" |
| `note` | Miscellaneous | "Workaround for bug #123" |

**When to use**:
- Store answers to questions the user might ask again
- Record decisions and the reasoning behind them
- Document patterns that worked well

**Example**:
```json
{
  "tool": "rag_add_knowledge",
  "params": {
    "title": "API rate limiting strategy",
    "content": "Use token bucket algorithm with 1000 requests/minute for standard tier, 10000 for enterprise. Implement exponential backoff with jitter on 429 responses.",
    "type": "rule",
    "category": "api-design",
    "importance": 0.8
  }
}
```

### Layer 4: Knowledge Graph (Relationship Memory)

**Purpose**: Captures entities and their relationships — who did what, how concepts connect, causal chains.

**Tools**:
- `rag_build_graph` — Extract entities and relationships from text
- `rag_add_graph_relation` — Create explicit connections
- `rag_nl_query` — Natural language queries about relationships
- `rag_search_graph` — Find related entities

**When to use**:
- After reading documents or making discoveries
- When entities have important relationships (uses, depends-on, caused-by)
- For tracing how things connect in complex systems

**Example**:
```json
{
  "tool": "rag_add_graph_relation",
  "params": {
    "source_entity_id": "auth-service",
    "target_entity_id": "user-db",
    "relation_type": "REFERENCES"
  }
}
```

---

## Memory Retrieval Patterns

Retrieval is the foundation of RAG. Use the right retrieval strategy for your goal:

### Pattern 1: Exact Match (Direct Recall)

When you know exactly what you're looking for.

```json
{
  "tool": "context/retrieve",
  "params": {
    "key": "project/current-phase"
  }
}
```

**Best for**: User preferences, known configuration values, specific findings.

### Pattern 2: Semantic Search (Deep Retrieval)

When you know the topic but not the exact words.

```json
{
  "tool": "rag_search_knowledge",
  "params": {
    "query": "authentication token refresh mechanism",
    "type": "procedure"
  }
}
```

**Best for**: Finding relevant facts, procedures, or explanations without knowing exact phrasing.

### Pattern 3: Relationship Traversal (Graph Discovery)

When you need to understand connections.

```json
{
  "tool": "rag_nl_query",
  "params": {
    "query": "What services depend on the legacy authentication module?"
  }
}
```

**Best for**: Understanding dependencies, tracing data flows, finding related concepts.

### Pattern 4: Contextual Retrieval (Session-Aware)

When you need to build context from multiple sources.

```json
{
  "tool": "rag_get_context",
  "params": {
    "query": "What is the current status of the API migration project?",
    "session_id": "current",
    "limit": 10
  }
}
```

**Best for**: Building comprehensive context before complex decisions.

### Pattern 5: Hybrid Search (Maximum Recall)

When thoroughness matters more than speed.

```json
{
  "tool": "rag_unified_search",
  "params": {
    "query": "deployment pipeline error handling",
    "session_id": "current",
    "search_kb": true,
    "memory_weight": 0.5,
    "kb_weight": 0.3,
    "hybrid": true
  }
}
```

**Best for**: Research tasks, debugging complex issues, comprehensive reviews.

---

## Building Context from Multiple Sources

A key RAG principle: **context is built by layering multiple sources**, not relying on a single retrieval.

### Context Building Process

```
Step 1: SESSION CONTEXT
         "What is the current session about?"
         ↓
Step 2: SESSION MEMORY RETRIEVAL
         "What has been discussed/decides in this session?"
         ↓
Step 3: PERSISTENT MEMORY RETRIEVAL
         "What do we know about this user/project?"
         ↓
Step 4: KNOWLEDGE BASE QUERY
         "What relevant facts/rules exist?"
         ↓
Step 5: KNOWLEDGE GRAPH EXPLORATION
         "How do these concepts connect?"
         ↓
┌─────────────────────────────────────────────────────────────┐
│                    COMPILED CONTEXT                          │
│                                                             │
│  Session goal + Session history + Prior knowledge +          │
│  Relevant facts + Relationship map = Complete context        │
└─────────────────────────────────────────────────────────────┘
```

### Multi-Source Context Example

```json
// Step 1-2: Get session context
{
  "tool": "session/list",
  "params": {}
}

// Step 3: Retrieve persistent project memory
{
  "tool": "context/search",
  "params": {
    "pattern": "project-api-*"
  }
}

// Step 4: Query knowledge base for relevant patterns
{
  "tool": "rag_search_knowledge",
  "params": {
    "query": "REST API error handling best practices",
    "category": "api-design",
    "limit": 5
  }
}

// Step 5: Get graph context for dependencies
{
  "tool": "rag_get_graph_context",
  "params": {
    "entity_id": "api-gateway",
    "depth": 2
  }
}
```

---

## The Importance of Storing for Later Retrieval

**The golden rule of RAG: If you don't store it, you can't retrieve it later.**

### Why Memory Storage Matters

1. **Compounding Intelligence**: Each session benefits from all previous sessions
2. **Consistency**: Users don't have to repeat themselves
3. **Traceability**: Decisions have documented reasoning
4. **Efficiency**: Future work can reference, not re-derive

### What to Store

| Category | Examples | Priority |
|----------|----------|----------|
| **Decisions** | Architectural choices, tool selections | High |
| **Discoveries** | Bug causes, workarounds found | High |
| **User Preferences** | Communication style, technical preferences | High |
| **Findings** | Research results, analysis conclusions | Medium |
| **References** | Useful URLs, documentation links | Medium |
| **Progress** | Completed milestones, next steps | Medium |
| **Artifacts** | Generated code, summaries, reports | Medium |

### When to Store

**Store IMMEDIATELY after**:
- Making a decision or recommendation
- Discovering a cause of a problem
- Learning a user preference
- Completing a research task
- Finding a useful resource
- Generating an artifact worth preserving

**Store BEFORE**:
- Ending a session
- Switching to a different task
- Attempting something risky
- Pausing for any reason

### Storage Best Practices

**Be Descriptive**: Use clear, searchable names and content.

```json
{
  "tool": "context/store",
  "params": {
    "key": "decision/api-auth-use-jwt",
    "value": {
      "decision": "Use JWT for API authentication",
      "reasoning": "Stateless, works well with horizontal scaling, widely supported",
      "alternatives_considered": ["session-cookies", "basic-auth"],
      "date": "2024-01-15"
    }
  }
}
```

**Be Structured**: When adding to knowledge base, use proper types.

```json
{
  "tool": "rag_add_knowledge",
  "params": {
    "title": "JWT token expiration policy",
    "content": "Access tokens: 15 minutes. Refresh tokens: 7 days. Rotate refresh tokens on use.",
    "type": "rule",
    "category": "security",
    "importance": 0.9,
    "source_type": "decision"
  }
}
```

**Tag for Discovery**: Add relationships in the knowledge graph.

```json
{
  "tool": "rag_build_graph",
  "params": {
    "source_type": "memory",
    "source_id": "session-123",
    "text": "The authentication service uses JWT tokens stored in httpOnly cookies. It validates tokens against the user service."
  }
}
```

---

## Session & Memory Workflows

### RAG-First Session Workflow

```
1. session/create (or resume)
   └─ Explicitly state the goal and retrieve relevant context

2. rag_get_context (build context)
   └─ Query multiple memory layers for relevant information

3. rag_unified_search (if needed)
   └─ Deep search across all sources for complex queries

4. [GENERATE] - Produce response with compiled context

5. rag_add_memory (store important insights)
   └─ Save key findings, decisions, preferences

6. rag_add_knowledge (store structured facts)
   └─ Add reusable facts, rules, procedures

7. rag_build_graph (capture relationships)
   └─ Extract entities and connections for future traversal

8. session/archive (preserve session state)
   └─ Save accumulated context for future retrieval
```

### Research Workflow (RAG-Enhanced)

```
1. session/create
   └─ Initialize with research question and scope

2. rag_get_context
   └─ Check if this topic was explored before

3. If prior work exists:
   └─ rag_search_knowledge → Review previous findings
   └─ session/resume (if relevant session found)
   └─ Skip to synthesis

4. If new topic:
   └─ tools/call (gather information)

5. rag_add_knowledge
   └─ Store key findings as structured knowledge

6. rag_build_graph
   └─ Extract entities and relationships discovered

7. rag_add_memory
   └─ Document conclusions and gaps

8. session/archive
   └─ Preserve research state
```

### Problem-Solving Workflow (RAG-Enhanced)

```
1. session/create
   └─ Frame the problem and constraints

2. rag_search_knowledge
   └─ Search for similar problems and solutions

3. rag_search_memories
   └─ Look for past debugging experiences

4. rag_nl_query (if graph available)
   └─ Query: "Show me components related to [symptom area]"

5. [INVESTIGATE] - Trace the problem

6. rag_add_memory
   └─ Store: Problem → Root Cause → Solution

7. rag_add_knowledge
   └─ Add as procedure or note for future reference

8. rag_build_graph
   └─ Connect: symptom → root cause → fix → affected components

9. session/archive
```

---

## Tool Categories (Enhanced)

### 1. Session Tools (Memory Layer 1)
| Tool | Purpose | RAG Role |
|------|---------|----------|
| `session/create` | Initialize new session | Sets context scope for retrieval |
| `session/resume` | Restore previous session | Loads accumulated context |
| `session/update` | Add session context | Incremental context building |
| `session/archive` | Persist and close | Stores session memory to layers 2-4 |

### 2. Context/Memory Tools (Memory Layer 2)
| Tool | Purpose | RAG Role |
|------|---------|----------|
| `context/store` | Save to persistent memory | Stores for cross-session retrieval |
| `context/retrieve` | Fetch by key | Direct recall |
| `context/search` | Find by pattern | Keyword search in persistent memory |

### 3. Knowledge Base Tools (Memory Layer 3)
| Tool | Purpose | RAG Role |
|------|---------|----------|
| `rag_add_knowledge` | Add structured fact/rule | Permanent knowledge storage |
| `rag_search_knowledge` | Semantic search | Deep retrieval by meaning |
| `rag_list_knowledge` | Browse knowledge | Exploration and review |
| `rag_import_knowledge` | Bulk add | Efficient knowledge population |

### 4. Knowledge Graph Tools (Memory Layer 4)
| Tool | Purpose | RAG Role |
|------|---------|----------|
| `rag_build_graph` | Extract entities/relations | Relationship mapping |
| `rag_nl_query` | Query graph naturally | Relationship-based discovery |
| `rag_add_graph_relation` | Create explicit links | Semantic relationship creation |
| `rag_search_graph` | Find related entities | Traversal-based retrieval |

### 5. Unified Retrieval Tools (Cross-Layer)
| Tool | Purpose | RAG Role |
|------|---------|----------|
| `rag_get_context` | Build context from memories | Multi-layer context compilation |
| `rag_unified_search` | Search all sources | Comprehensive retrieval |
| `rag_search_memories` | Session memory search | Recent context search |

---

## Error Handling (Memory-Focused)

### Retrieval Miss

```json
{
  "error": "No relevant memories found",
  "action": "Expand search scope or proceed without prior context"
}
```

**Recovery**:
1. Widen search: Try broader terms or `rag_unified_search`
2. Check knowledge graph: `rag_nl_query` for related concepts
3. Proceed without, but note gap for future storage
4. After generating, store for future retrieval

### Session Not Found

```json
{
  "error": "Session 'xyz' not found",
  "action": "Search for related sessions or create new"
}
```

**Recovery**:
1. `session/list` — Find relevant sessions
2. `rag_search_memories` — Search memory for related content
3. `rag_search_knowledge` — Query knowledge base for topic
4. Create new session, restore what you find

### Knowledge Gap Identified

When you realize you need information that should exist but doesn't:

```json
{
  "action": "Create knowledge entry to fill the gap"
}
```

**Recovery**:
1. After finding answer, `rag_add_knowledge` immediately
2. Build graph relationships: `rag_build_graph`
3. Store as memory: `rag_add_memory`

---

## Quick Reference

### The RAG Imperatives

1. **Always retrieve before generating** — Never assume you know the full context
2. **Always store after learning** — Future you will thank present you
3. **Tag relationships explicitly** — Connections enable graph traversal
4. **Use layered retrieval** — Context comes from multiple sources
5. **Archive sessions properly** — Session endings are memory beginnings

### Essential RAG Commands

| Action | Command | Memory Layer |
|--------|---------|-------------|
| Start with retrieval | `rag_get_context` | All layers |
| Find similar past work | `rag_search_knowledge` | Knowledge base |
| Check session history | `rag_search_memories` | Session memory |
| Explore relationships | `rag_nl_query` | Knowledge graph |
| Store decision | `context/store` + `rag_add_knowledge` | Layers 2-3 |
| Store relationship | `rag_add_graph_relation` | Layer 4 |
| Build complete context | `rag_unified_search` | All layers |

### Retrieval Strategy Selection

| Situation | Best Tool |
|-----------|-----------|
| Know the exact key | `context/retrieve` |
| Know the topic, not phrasing | `rag_search_knowledge` |
| Need connected information | `rag_search_graph` / `rag_nl_query` |
| Building context for complex task | `rag_get_context` |
| Comprehensive research | `rag_unified_search` |
| Need to recall session events | `rag_search_memories` |

### The Storage Checklist

After every significant interaction, store:

- [ ] Key decisions made
- [ ] Important facts discovered
- [ ] User preferences expressed
- [ ] Problems encountered and solved
- [ ] Useful resources found
- [ ] Relationships between entities
- [ ] Work completed and next steps
- [ ] Generated artifacts worth preserving

---

## Tool Calling Order (RAG-First)

```
session/create (or resume)
    ↓
rag_get_context (build from all layers)
    ↓
rag_unified_search (if complex)
    ↓
[WORK with compiled context]
    ↓
rag_add_memory (store new insights)
    ↓
rag_add_knowledge (structure important facts)
    ↓
rag_build_graph (capture relationships)
    ↓
session/archive (preserve everything)
```

---

*This skill emphasizes RAG-first reasoning. Memory is not storage — it's the foundation of intelligent, context-aware generation. Treat every interaction as an opportunity to retrieve, augment, generate, and store.*
