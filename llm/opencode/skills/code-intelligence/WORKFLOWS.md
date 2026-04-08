# Code Intelligence Workflows

Step-by-step workflows for common code intelligence tasks.

---

## 1. Understanding a New Codebase

Quickly explore and understand an unfamiliar codebase.

### Step 1: Index the codebase

```json
{
  "tool": "index_code_directory",
  "parameters": {
    "directory": "/path/to/project/src",
    "git_repo_id": "my-project"
  }
}
```

### Step 2: Explore structure

```json
{
  "tool": "search_code",
  "parameters": {
    "query": "main entry controller service",
    "limit": 20
  }
}
```

```json
{
  "tool": "code_reasoning_query",
  "parameters": {
    "question": "What is the main architecture of this project?"
  }
}
```

### Step 3: Find key modules

```json
{
  "tool": "search_code",
  "parameters": {
    "query": "authentication user management",
    "limit": 10
  }
}
```

```json
{
  "tool": "find_code_symbol",
  "parameters": {
    "name": "UserService"
  }
}
```

---

## 2. Finding Authentication Implementation

Locate and analyze authentication-related code.

### Step 1: Find authentication symbols

```json
{
  "tool": "find_where_happens",
  "parameters": {
    "concept": "authentication"
  }
}
```

### Step 2: Get symbol details

```json
{
  "tool": "get_symbol_info",
  "parameters": {
    "fqn": "AuthService.authenticate"
  }
}
```

### Step 3: Get call graph

```json
{
  "tool": "get_call_graph",
  "parameters": {
    "fqn": "AuthService.authenticate",
    "direction": "both",
    "depth": 2
  }
}
```

### Step 4: Find all references

```json
{
  "tool": "find_references",
  "parameters": {
    "fqn": "AuthService.authenticate"
  }
}
```

---

## 3. Analyzing Data Flow

Trace how data moves through the codebase.

### Trace user input to database

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "UserController.createUser",
    "direction": "forward",
    "target_types": ["database"]
  }
}
```

### Trace backward from persistence

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "User.save",
    "direction": "backward",
    "target_types": ["network"]
  }
}
```

### Full bidirectional trace

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "handleRequest",
    "direction": "both"
  }
}
```

---

## 4. Finding Similar Code

Find code similar to an implementation or description.

### Find code by description

```json
{
  "tool": "semantic_code_search",
  "parameters": {
    "query": "retry logic with exponential backoff",
    "limit": 10,
    "min_score": 0.6
  }
}
```

### Find related to existing function

```json
{
  "tool": "find_related_code",
  "parameters": {
    "fqn": "HttpClient.get",
    "limit": 5
  }
}
```

### Find implementation patterns

```json
{
  "tool": "semantic_code_search",
  "parameters": {
    "query": "error handling try catch exception logging",
    "limit": 10
  }
}
```

---

## 5. Code Review Workflow

Analyze code changes for review.

### Analyze a single file diff

```json
{
  "tool": "analyze_code_diff",
  "parameters": {
    "file_path": "src/service.ts",
    "old_content": "function oldFunc() { ... }",
    "new_content": "async function newFunc() { ... }"
  }
}
```

### Analyze full commit/PR

```json
{
  "tool": "analyze_git_diff",
  "parameters": {
    "changes": [
      {"file_path": "src/a.ts", "old_content": "...", "new_content": "..."},
      {"file_path": "src/b.ts", "old_content": "...", "new_content": "..."}
    ]
  }
}
```

### Review symbol impact

```json
{
  "tool": "get_call_graph",
  "parameters": {
    "fqn": "modifiedFunction",
    "direction": "both",
    "depth": 2
  }
}
```

---

## 6. Impact Analysis

Assess the impact of modifying a function.

### Before modifying a function

```json
{
  "tool": "find_references",
  "parameters": {
    "fqn": "processPayment",
    "limit": 100
  }
}
```

```json
{
  "tool": "get_call_graph",
  "parameters": {
    "fqn": "processPayment",
    "direction": "callers",
    "depth": 3
  }
}
```

```json
{
  "tool": "trace_data_flow",
  "parameters": {
    "start_symbol": "processPayment",
    "direction": "both"
  }
}
```

### Check external dependencies

```json
{
  "tool": "analyze_external_dependencies",
  "parameters": {}
}
```

---

## Quick Workflow Combinations

### Explore entry point

1. `find_code_symbol` with `name="main"` or entry function
2. `get_call_graph` with `direction: "callees"`, `depth: 2`
3. `trace_data_flow` with `direction: "forward"`

### Find all database operations

1. `find_where_happens` with `concept: "persistence"`
2. For each result, `get_symbol_info` to understand purpose
3. `trace_data_flow` to see data sources

### Audit security-related code

1. `find_where_happens` with `concept: "authentication"`
2. `semantic_code_search` with query: "security validation encryption"
3. `analyze_external_dependencies` to check for vulnerable libs
