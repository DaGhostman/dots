# Code Intelligence Tools

Complete documentation for all code intelligence tools.

---

## Indexing Tools

### `index_code_directory`

Index a directory of source code for code intelligence.

**When to use:** First-time indexing, re-indexing after changes.

```json
{
  "directory": "/path/to/project/src",
  "git_repo_id": "my-project",
  "force": false,
  "languages": ["typescript", "python"]
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `directory` | string | Yes | - | Directory path to index |
| `git_repo_id` | string | No | - | Git repo ID for organization |
| `force` | boolean | No | false | Re-index even unchanged files |
| `languages` | string[] | No | all | Specific languages to index |

**Returns:** Statistics about indexed files and symbols.

---

### `get_code_index_stats`

Get statistics about indexed code.

**When to use:** Checking indexing status, understanding code metrics.

```json
{
  "git_repo_id": "my-project"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `git_repo_id` | string | No | - | Filter by git repo ID |

**Returns:** File counts, symbol counts by type/language.

---

### `remove_code_index`

Remove indexed code.

**When to use:** Cleaning up old indexes, removing code that's no longer needed.

```json
{
  "file_path": "/path/to/project/src/old-module",
  "git_repo_id": "my-project"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `file_path` | string | No | - | Specific file path to remove |
| `git_repo_id` | string | No | - | Git repo to remove |

**Returns:** Confirmation of removal.

---

## Symbol Discovery

### `find_code_symbol`

Find a code symbol by name.

**When to use:** Locating function/class definition.

```json
{
  "name": "authenticateUser",
  "fqn": "UserService.authenticateUser",
  "exact_match": false
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `name` | string | Yes | - | Symbol name to search for |
| `fqn` | string | No | - | Fully qualified name (e.g., "User.authenticate") |
| `exact_match` | boolean | No | false | Require exact name match |

**Returns:** Symbol details including location, signature, and file.

---

### `search_code`

Search indexed symbols.

**When to use:** Finding code related to a concept, searching across all symbols.

```json
{
  "query": "authentication login",
  "limit": 20,
  "language": "typescript",
  "symbol_type": "function"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | string | Yes | - | Search query |
| `limit` | integer | No | 20 | Maximum results |
| `language` | string | No | - | Filter by language |
| `symbol_type` | string | No | - | Filter by type (function, class, method, etc.) |

**Returns:** List of matching symbols with locations and scores.

---

### `get_symbol_info`

Get detailed information about a symbol.

**When to use:** Understanding function/class behavior, getting parameter details.

```json
{
  "fqn": "UserService.authenticate"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `symbol_id` | string | No* | - | Symbol ID (alternative to fqn) |
| `fqn` | string | No* | - | Fully qualified symbol name (alternative to symbol_id) |

*Either `symbol_id` or `fqn` is required.

**Returns:** Symbol signature, parameters, return type, and documentation.

---

### `find_references`

Find all references to a symbol.

**When to use:** Finding where a function is called, understanding usage.

```json
{
  "fqn": "UserService.authenticate",
  "include_definitions": true,
  "limit": 50
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `symbol_id` | string | No* | - | Symbol ID (alternative to fqn) |
| `fqn` | string | No* | - | Fully qualified name (alternative to symbol_id) |
| `include_definitions` | boolean | No | true | Include definition location |
| `limit` | integer | No | 50 | Maximum results |

*Either `symbol_id` or `fqn` is required.

**Returns:** All references to the symbol with locations.

---

## Call Graph & Dependencies

### `get_call_graph`

Get the call graph for a symbol.

**When to use:** Understanding function dependencies, tracing execution paths.

```json
{
  "fqn": "processPayment",
  "direction": "both",
  "depth": 3
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `symbol_id` | string | No* | - | Symbol ID (alternative to fqn) |
| `fqn` | string | No* | - | Fully qualified symbol name |
| `direction` | string | No | "both" | "both" \| "callers" \| "callees" |
| `depth` | integer | No | 2 | Traversal depth |

*Either `symbol_id` or `fqn` is required.

**Returns:** Call graph with nodes and edges, showing internal and external calls.

---

### `analyze_external_dependencies`

Analyze where code calls external/vendor libraries.

**When to use:** Understanding dependencies, auditing external library usage.

```json
{
  "git_repo_id": "my-project"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `git_repo_id` | string | No | - | Filter by git repo |

**Returns:** List of external dependencies with call counts and locations.

---

## Semantic Search

### `semantic_code_search`

Search semantically similar code using embeddings.

**When to use:** Finding code similar to a description, implementation patterns.

**Uses embeddings** for semantic similarity, not just keyword matching.

```json
{
  "query": "retry logic with exponential backoff",
  "limit": 10,
  "min_score": 0.7,
  "language": "typescript",
  "symbol_type": "function"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | string | Yes | - | Natural language query describing the code |
| `limit` | integer | No | 10 | Maximum results |
| `min_score` | number | No | 0.5 | Minimum similarity score (0-1) |
| `language` | string | No | - | Filter by programming language |
| `symbol_type` | string | No | - | Filter by symbol type |

**Returns:** Similar code with similarity scores.

---

### `find_related_code`

Find code related to a given symbol.

**When to use:** Understanding what else is related to a function.

```json
{
  "fqn": "UserService.authenticate",
  "limit": 5
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `symbol_id` | string | No* | - | Symbol ID (alternative to fqn) |
| `fqn` | string | No* | - | Fully qualified symbol name |
| `limit` | integer | No | 5 | Maximum results |

*Either `symbol_id` or `fqn` is required.

**Returns:** Related code with similarity scores.

---

### `reembed_code_index`

Re-generate embeddings for indexed code.

**When to use:** Changing embedding model, fixing missing embeddings.

```json
{
  "code_index_id": "abc123"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `code_index_id` | string | No | all | Specific code index to re-embed |

**Returns:** Number of embeddings generated.

---

### `get_code_embedding_stats`

Get statistics about code embeddings.

**When to use:** Checking embedding status, understanding coverage.

```json
{}
```

**Returns:** Embedding statistics.

---

## Data Flow Analysis

### `trace_data_flow`

Trace how data flows through the codebase.

**When to use:** Understanding data origins, finding all places data is modified.

```json
{
  "start_symbol": "UserService.createUser",
  "direction": "forward",
  "target_types": ["database", "network"]
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `start_symbol` | string | Yes | - | Fully qualified name of starting symbol |
| `direction` | string | No | "both" | "forward" \| "backward" \| "both" |
| `target_types` | string[] | No | all | Target types: database, network, file |

**Returns:** Data flow paths with locations.

---

## Concept Location

### `find_where_happens`

Find where specific concepts or behaviors are implemented.

**When to use:** Where does X happen?

```json
{
  "concept": "authentication"
}
```

```json
{
  "concept": "custom",
  "custom_query": "email validation regex"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `concept` | string | Yes | - | One of: "authentication" \| "persistence" \| "validation" \| "network" \| "logging" \| "configuration" \| "custom" |
| `custom_query` | string | No* | - | Custom search query (*required if concept is "custom") |

**Returns:** Locations of matching code.

---

## Natural Language Analysis

### `code_reasoning_query`

Answer natural language questions about code structure and behavior.

**When to use:** Complex questions about code, understanding code flows.

```json
{
  "question": "Where does user authentication happen?",
  "context": {
    "git_repo_id": "my-project",
    "file_path": "src/auth/"
  }
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `question` | string | Yes | - | Natural language question about the code |
| `context` | object | No | - | Optional context: `git_repo_id`, `file_path`, `symbol_id` |

**Returns:** Detailed answer with source locations.

---

## Diff Analysis

### `analyze_code_diff`

Analyze code changes for a single file.

**When to use:** Reviewing code changes, finding breaking changes.

```json
{
  "file_path": "src/auth/service.ts",
  "old_content": "function authenticate(user) { ... }",
  "new_content": "async function authenticate(user) { ... }"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `file_path` | string | Yes | - | Path to the file that changed |
| `old_content` | string | Yes | - | Previous content of the file |
| `new_content` | string | Yes | - | New content of the file |

**Returns:** Detailed analysis of changes with impact assessment.

---

### `analyze_git_diff`

Analyze multi-file git changes.

**When to use:** Reviewing commits, analyzing PRs.

```json
{
  "changes": [
    {
      "file_path": "src/auth/service.ts",
      "old_content": "...",
      "new_content": "..."
    },
    {
      "file_path": "src/auth/types.ts",
      "old_content": "...",
      "new_content": "..."
    }
  ]
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `changes` | array | Yes | - | Array of {file_path, old_content, new_content} |

**Returns:** Summary of all changes with impact analysis.

---

## Export

### `export_scip_index`

Export code index in SCIP format for Sourcegraph compatibility.

**When to use:** Using Sourcegraph, exporting for external tools.

```json
{
  "git_repo_id": "my-project",
  "file_path": "/tmp/project.scip"
}
```

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `git_repo_id` | string | Yes | - | Git repo ID to export |
| `file_path` | string | Yes | - | Output file path |

**Returns:** SCIP file at specified path.
