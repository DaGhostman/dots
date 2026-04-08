# Code Intelligence Examples

Practical prompt examples for common code intelligence tasks.

---

## Indexing & Discovery

### Index a codebase

```
Tool: index_code_directory
{
  "directory": "/path/to/project/src",
  "git_repo_id": "my-project",
  "force": false
}
```

### Check what's indexed

```
Tool: get_code_index_stats
{
  "git_repo_id": "my-project"
}
```

### Find symbol by name

```
Tool: find_code_symbol
{
  "name": "main",
  "exact_match": true
}
```

### Search for symbols by concept

```
Tool: search_code
{
  "query": "authentication user login",
  "limit": 20
}
```

---

## Understanding Code

### Get symbol details

```
Tool: get_symbol_info
{
  "fqn": "UserService.authenticate"
}
```

### Get call graph for a function

```
Tool: get_call_graph
{
  "fqn": "processPayment",
  "direction": "both",
  "depth": 3
}
```

### Find all references to a symbol

```
Tool: find_references
{
  "fqn": "AuthService.authenticate"
}
```

---

## Semantic Search

### Find authentication-related code

```
Tool: semantic_code_search
{
  "query": "authentication login JWT token",
  "limit": 15
}
```

### Find error handling patterns

```
Tool: semantic_code_search
{
  "query": "error handling try catch exception logging",
  "limit": 10
}
```

### Find similar implementation

```
Tool: find_related_code
{
  "fqn": "HttpClient.get",
  "limit": 5
}
```

---

## Data Flow

### Where is user data saved to database?

```
Tool: trace_data_flow
{
  "start_symbol": "UserService.create",
  "direction": "forward",
  "target_types": ["database"]
}
```

### Trace data backward from persistence

```
Tool: trace_data_flow
{
  "start_symbol": "User.save",
  "direction": "backward",
  "target_types": ["network"]
}
```

---

## Concept Location

### Find where authentication happens

```
Tool: find_where_happens
{
  "concept": "authentication"
}
```

### Find database operations

```
Tool: find_where_happens
{
  "concept": "persistence"
}
```

### Find configuration loading

```
Tool: find_where_happens
{
  "concept": "configuration"
}
```

### Find custom concept

```
Tool: find_where_happens
{
  "concept": "custom",
  "custom_query": "email validation regex"
}
```

---

## Natural Language Queries

### Ask about architecture

```
Tool: code_reasoning_query
{
  "question": "What is the main architecture of this project?"
}
```

### Ask about authentication

```
Tool: code_reasoning_query
{
  "question": "Where does user authentication happen?"
}
```

### Ask about configuration

```
Tool: code_reasoning_query
{
  "question": "How is configuration managed and loaded?"
}
```

---

## Dependencies

### What external libraries does this project use?

```
Tool: analyze_external_dependencies
{}
```

---

## Code Review

### Analyze a file diff

```
Tool: analyze_code_diff
{
  "file_path": "src/auth/service.ts",
  "old_content": "function authenticate(user) { ... }",
  "new_content": "async function authenticate(user) { ... }"
}
```

### Analyze a commit

```
Tool: analyze_git_diff
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

---

## Export

### Export index for Sourcegraph

```
Tool: export_scip_index
{
  "git_repo_id": "my-project",
  "file_path": "/tmp/project.scip"
}
```

---

## Complete Workflows

### Understanding a new codebase

```
Step 1: Index
Tool: index_code_directory
{"directory": "src/", "git_repo_id": "my-project"}

Step 2: Explore
Tool: search_code
{"query": "main entry point", "limit": 10}

Step 3: Deep dive
Tool: find_code_symbol
{"name": "main"}

Tool: get_call_graph
{"symbol_id": "<id>", "direction": "both", "depth": 2}
```

### Finding and analyzing a feature

```
Step 1: Find concept
Tool: find_where_happens
{"concept": "validation"}

Step 2: Get details
Tool: get_symbol_info
{"fqn": "ValidationService.validate"}

Step 3: Check usage
Tool: find_references
{"fqn": "ValidationService.validate"}

Step 4: Trace flow
Tool: trace_data_flow
{"start_symbol": "ValidationService.validate", "direction": "both"}
```

### Impact analysis before changes

```
Tool: find_references
{"fqn": "processPayment", "limit": 100}

Tool: get_call_graph
{"fqn": "processPayment", "direction": "callers", "depth": 3}

Tool: trace_data_flow
{"start_symbol": "processPayment", "direction": "both"}
```

### Finding similar code

```
Tool: semantic_code_search
{"query": "retry logic with exponential backoff", "limit": 10, "min_score": 0.6}

Tool: find_related_code
{"fqn": "existingRetryFunction", "limit": 5}
```
