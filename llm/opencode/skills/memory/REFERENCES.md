# Tool Reference

## Session Tools (4)

### `create_session`
Create a new conversation session for organizing memories.

```json
{
  "name": "project-alpha-research",
  "description": "Research context for Project Alpha",
  "user_id": "user-123"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `name` | string | Yes | - | Human-readable session name |
| `description` | string | No | - | Session purpose |
| `user_id` | string | No | - | User identifier |

### `list_sessions`
List all sessions with optional user filter.

```json
{
  "user_id": "user-123",
  "limit": 20
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `user_id` | string | No | - | Filter by user |
| `limit` | integer | No | 20 | Max results |

### `get_session`
Retrieve session details including creation time and last active.

```json
{
  "session_id": "abc-123"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `session_id` | string | Yes | - | Session ID to retrieve |

### `delete_session`
Delete a session and all associated memories.

```json
{
  "session_id": "abc-123"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `session_id` | string | Yes | - | Session ID to delete |

---

## Memory CRUD (6)

### `add_memory`
Store a piece of context in a session.

```json
{
  "session_id": "abc-123",
  "role": "user",
  "content": "User prefers TypeScript over JavaScript for type safety",
  "importance": 0.8
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `session_id` | string | Yes | - | Target session ID |
| `role` | string | Yes | - | `user`, `assistant`, or `system` |
| `content` | string | Yes | - | The memory text |
| `importance` | number | No | 0.5 | 0.0-1.0 importance score |

**Best practices:**
- Set high importance (0.7+) for user preferences and key decisions
- Be specific but concise
- Store conclusions, not process

### `list_memories`
Retrieve memories from a session.

```json
{
  "session_id": "abc-123",
  "limit": 50
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `session_id` | string | Yes | - | Session ID |
| `limit` | integer | No | 50 | Max results |

### `search_memories`
Full-text and semantic search across memories.

```json
{
  "query": "TypeScript preferences",
  "session_id": "abc-123",
  "limit": 5,
  "work_dir": "/path/to/project"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | string | Yes | - | Search query text |
| `session_id` | string | No | - | Search within specific session only |
| `limit` | integer | No | 5 | Max results |
| `work_dir` | string | No | - | Boost memories from current project directory |

**Features:**
- **FTS (Full-Text Search)**: Exact text matching via SQLite FTS
- **Semantic search**: Vector embeddings for similarity matching (when available)
- **Git repo boosting**: Memories from current repo ranked higher

### `get_memory_context`
Get relevant contextual memories for a query.

```json
{
  "query": "What are the user's language preferences?",
  "session_id": "abc-123",
  "limit": 5
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | string | Yes | - | Query to find relevant memories |
| `session_id` | string | No | - | Session ID |
| `limit` | integer | No | 5 | Max context items |

**Returns:** Memories matching the query PLUS recent memories (for recency). This is your primary tool for context injection.

**Why both?** Query matching finds semantically relevant memories, but recent memories provide conversational continuity.

### `delete_memory`
Remove a memory by ID.

```json
{
  "memory_id": "mem-xyz"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `memory_id` | string | Yes | - | Memory ID to delete |

### `deduplicate_memories`
Find and merge duplicate memories based on content similarity.

```json
{
  "session_id": "abc-123",
  "threshold": 0.85,
  "strategy": "merge",
  "dry_run": true
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `session_id` | string | No | - | Deduplicate within specific session only |
| `threshold` | number | No | 0.85 | Similarity threshold 0-1 |
| `strategy` | string | No | "merge" | `keep_first`, `keep_latest`, or `merge` |
| `dry_run` | boolean | No | false | If true, only detect without merging |

**Strategies:**
- `keep_first`: Keep oldest memory, discard duplicates
- `keep_latest`: Keep newest memory, discard duplicates
- `merge`: Combine content intelligently (default)

---

## Unified Search (1)

### `unified_search`
Search documents, memories, and knowledge base simultaneously for comprehensive context.

```json
{
  "query": "What do you know about authentication?",
  "session_id": "abc-123",
  "limit": 5,
  "memory_limit": 3,
  "memory_weight": 0.3,
  "search_kb": true,
  "kb_limit": 3,
  "kb_weight": 0.2,
  "work_dir": "/path/to/project"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | string | Yes | - | Search query |
| `collection` | string | No | - | Specific document collection to search |
| `session_id` | string | No | - | Include memory context from session |
| `limit` | integer | No | 5 | Max document results |
| `memory_limit` | integer | No | 3 | Max memory results |
| `memory_weight` | number | No | 0.3 | Memory influence 0-1 |
| `search_kb` | boolean | No | false | Include knowledge base |
| `kb_limit` | integer | No | 3 | Max KB results |
| `kb_weight` | number | No | 0.2 | KB influence 0-1 |
| `work_dir` | string | No | - | Boost results from current project |
| `hybrid` | boolean | No | - | Use hybrid search for documents |
| `vector_weight` | number | No | - | Semantic weight 0-1 |
| `bm25_weight` | number | No | - | Keyword weight 0-1 |
| `filters` | object | No | - | Document metadata filters |
