# Code Intelligence Patterns

Best practices, performance tips, security considerations, and error handling.

---

## Performance Tips

### 1. Index Once, Query Many

Index the codebase once at the start, then query extensively:

```json
{
  "tool": "index_code_directory",
  "parameters": {
    "directory": "src/",
    "force": false
  }
}
```

Re-index only when needed:
```json
{
  "tool": "index_code_directory",
  "parameters": {
    "directory": "src/",
    "force": true
  }
}
```

### 2. Use Symbol IDs from Find Operations

When you find a symbol, use its ID for subsequent queries to avoid re-searching:

```json
{
  "tool": "find_code_symbol",
  "parameters": {"name": "authenticate"}
}
```
Returns: `symbol_id: "abc123"`

Then use the ID:
```json
{
  "tool": "get_call_graph",
  "parameters": {"symbol_id": "abc123"}
}
```

### 3. Combine Semantic and Keyword Search

| Search Type | Best For |
|-------------|----------|
| `semantic_code_search` | Conceptual queries, finding similar implementations |
| `search_code` | Exact symbol names, specific identifiers |

Use both to get comprehensive results.

### 4. Limit Results Appropriately

Use `limit` parameter to control result volume:

| Use Case | Recommended Limit |
|----------|------------------|
| Quick scan | 5 |
| Normal search | 20 |
| Comprehensive | 50+ |

### 5. Use Target Types in Data Flow

Filter data flow tracing to reduce noise:

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "handleRequest",
    "target_types": ["database"]
  }
}
```

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "handleRequest",
    "target_types": ["network"]
  }
}
```

### 6. Choose Appropriate Call Graph Depth

| Depth | Use Case |
|-------|----------|
| 1 | Direct callers/callees only |
| 2 | Local neighborhood (default) |
| 3+ | Broader impact analysis |

### 7. Filter by Language/Symbol Type

When searching large codebases, filter to reduce results:

```json
{
  "tool": "semantic_code_search",
  "parameters": {
    "query": "validation",
    "language": "typescript",
    "symbol_type": "function"
  }
}
```

---

## Security Considerations

### 1. Index Boundaries

Code intelligence is scoped to indexed directories. Unindexed code is not analyzed.

- Index only trusted code directories
- Be aware of what directories are excluded

### 2. Read-Only Operations

All code intelligence tools are read-only:
- No tools modify code
- No tools execute code
- Safe to use on any codebase

### 3. External Dependency Analysis

Use to audit for vulnerable dependencies:

```json
{
  "tool": "analyze_external_dependencies",
  "parameters": {}
}
```

### 4. Secret Detection

Can search for hardcoded credentials before committing:

```json
{
  "tool": "semantic_code_search",
  "parameters": {
    "query": "hardcoded password API key secret token"
  }
}
```

### 5. Trust Boundaries

When analyzing code:
- External library calls are flagged separately
- Consider untrusted input paths
- Review `analyze_external_dependencies` output

---

## Error Handling

### Search Returns No Results

1. Verify directory is indexed:
```json
{
  "tool": "get_code_index_stats",
  "parameters": {}
}
```

2. Try broader query (shorter terms or semantic search)

3. Check spelling - use `exact_match: true` if you know the exact name

### Symbol Not Found

1. Try partial name with `exact_match: false`:
```json
{
  "tool": "find_code_symbol",
  "parameters": {
    "name": "authenticate",
    "exact_match": false
  }
}
```

2. Use keyword search:
```json
{
  "tool": "search_code",
  "parameters": {
    "query": "authentication login"
  }
}
```

3. Re-index if needed:
```json
{
  "tool": "index_code_directory",
  "parameters": {
    "directory": "src/",
    "force": true
  }
}
```

### Call Graph Is Empty

1. Symbol may genuinely have no callers/callees

2. Try different direction:
```json
{"direction": "callers"}
{"direction": "callees"}
{"direction": "both"}
```

3. Increase depth:
```json
{"depth": 3}
```

### Semantic Search Quality Poor

1. Rebuild embeddings:
```json
{
  "tool": "reembed_code_index",
  "parameters": {}
}
```

2. Try more specific query

3. Lower `min_score` threshold

### Diff Analysis Fails

1. Ensure `old_content` and `new_content` exactly match the files

2. Check file path is correct

3. For large diffs, split into smaller chunks

---

## Tool Dependencies

Understanding tool relationships helps with troubleshooting:

```
index_code_directory
    ↓
(all other tools work on indexed code)
        ↓
    find_code_symbol ──→ get_call_graph
        │                     ↓
        ├──→ get_symbol_info  find_references
        │                     ↓
        ├──→ trace_data_flow   trace_data_flow
        │
        └──→ find_related_code

semantic_code_search
        ↓
(requires embeddings - rebuild with reembed_code_index if quality is poor)
```

---

## Common Patterns

### Exploration Pattern

```
index → search/code_reasoning → find_code_symbol → get_call_graph/get_symbol_info
```

### Impact Analysis Pattern

```
find_references → get_call_graph → trace_data_flow → analyze_external_dependencies
```

### Review Pattern

```
analyze_code_diff/analyze_git_diff → find_references → get_symbol_info
```

### Similarity Pattern

```
semantic_code_search → find_related_code → get_symbol_info
```
