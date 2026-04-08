# Code Intelligence Tools

Use these tools to efficiently analyze code during reviews.

---

## Setup

```bash
# Set project root for security boundaries and indexing
tree-sitter-analyzer_set_project_path: {"project_path": "/path/to/project"}
```

---

## Analyzing Changed Code

For PRs/diffs, analyze only affected files:

```bash
# List files changed in PR
tree-sitter-analyzer_list_files: {"roots": ["src/"], "pattern": "*.ts", "changed_within": "1d"}

# Analyze structure of changed files
tree-sitter-analyzer_analyze_code_structure: {"file_path": "src/changed-file.ts", "format_type": "compact"}

# Check complexity of changed files
tree-sitter-analyzer_check_code_scale: {"file_paths": ["src/file1.ts", "src/file2.ts"], "metrics_only": true}
```

---

## Finding References and Dependencies

Trace where code is used:

```bash
# Find all usages of a function
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "processPayment|handleUser", "include_globs": ["*.ts", "*.js"], "group_by_file": true}

# Query code structure to understand what calls what
tree-sitter-analyzer_query_code: {"file_path": "src/payment.ts", "query_string": "(method_definition name: (property_identifier) @name) @method", "result_format": "json"}
```

---

## Extracting Code for Review

Get relevant code sections with context:

```bash
# Extract function implementation
tree-sitter-analyzer_extract_code_section: {"file_path": "src/user-service.ts", "start_line": 45, "end_line": 80}

# Extract multiple sections at once
tree-sitter-analyzer_extract_code_section: {"requests": [{"file_path": "src/auth.ts", "sections": [{"start_line": 1, "end_line": 30, "label": "imports"}, {"start_line": 100, "end_line": 150, "label": "login-function"}]}], "format": "text"}
```

---

## Understanding Code Structure

Get overview of files/modules:

```bash
# Full structure analysis
tree-sitter-analyzer_analyze_code_structure: {"file_path": "src/services/user.service.ts", "format_type": "full"}

# Compact view for quick scanning
tree-sitter-analyzer_analyze_code_structure: {"file_path": "src/services/user.service.ts", "format_type": "compact"}
```

---

## Searching for Patterns

Find specific code patterns across the codebase:

```bash
# Security: Find potential SQL injection
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*.py", "query": "execute\\(|cursor\\.execute\\(|\\.format\\(|f['\\"].*SELECT"}

# Performance: Find loops with database calls
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*.ts", "query": "forEach.*await|for.*of.*await|\\.find\\(\\).*\\n.*db"}

# Maintainability: Find TODO/FIXME
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "TODO:|FIXME:|HACK:|XXX:", "summary_only": true}

# Correctness: Find missing error handling
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*.ts", "query": "\\.then\\(|\\.catch\\(|try \\{"}
```

---

## Context Gathering

```bash
# Find related code for context
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*user*.ts", "query": "UserService|userRepository"}
```

---

## Tool Quick Reference

| Tool | Purpose | Key Params |
|------|---------|------------|
| `set_project_path` | Set root for security boundaries | `project_path` |
| `list_files` | Find files by pattern | `roots`, `pattern`, `changed_within` |
| `search_content` | Search file contents | `roots`, `query`, `include_globs`, `group_by_file` |
| `find_and_grep` | Find files then search content | `roots`, `pattern`, `query` |
| `query_code` | Tree-sitter queries on code | `file_path`, `query_string` |
| `extract_code_section` | Get code with line numbers | `file_path`, `start_line`, `end_line` |
| `analyze_code_structure` | Overview of classes/methods | `file_path`, `format_type` |
| `check_code_scale` | Complexity metrics | `file_path`, `metrics_only`, `include_complexity` |
