---
name: code-intelligence
description: RAG-powered code analysis, search, and understanding for semantic search, symbol navigation, and code intelligence.
license: MIT
---

# Code Intelligence Skill

RAG-powered tools for analyzing, searching, and understanding code.

## Overview

Code Intelligence enables:
- **Index** code for semantic search and symbol navigation
- **Find** symbols, functions, classes, and relationships
- **Search** using natural language or semantic similarity
- **Analyze** call graphs, data flow, and dependencies
- **Compare** code changes and understand impact

Uses embeddings + vector similarity for semantic search, combined with code analysis.

## Quick Reference

| Tool | Purpose | Key Params |
|------|---------|------------|
| `index_code_directory` | Index code | `directory`, `git_repo_id`, `force`, `languages` |
| `get_code_index_stats` | Index statistics | `git_repo_id` |
| `find_code_symbol` | Locate symbol | `name`, `fqn`, `exact_match` |
| `search_code` | Search symbols | `query`, `limit`, `language`, `symbol_type` |
| `get_call_graph` | Dependency graph | `fqn`, `direction`, `depth` |
| `semantic_code_search` | Find similar code | `query`, `limit`, `min_score` |
| `code_reasoning_query` | NL code queries | `question`, `context` |
| `trace_data_flow` | Trace data paths | `start_symbol`, `direction`, `target_types` |
| `find_where_happens` | Concept locations | `concept`, `custom_query` |
| `find_references` | Find usage | `fqn`, `limit` |
| `get_symbol_info` | Symbol details | `fqn` |
| `analyze_code_diff` | Review changes | `file_path`, `old_content`, `new_content` |
| `analyze_git_diff` | Review commits | `changes[]` |
| `analyze_external_dependencies` | Audit deps | `git_repo_id` |
| `export_scip_index` | Export for Sourcegraph | `git_repo_id`, `file_path` |

## Detailed Documentation

- **[TOOLS.md](TOOLS.md)** - Complete tool documentation with all parameters
- **[WORKFLOWS.md](WORKFLOWS.md)** - Step-by-step workflows for common tasks
- **[PATTERNS.md](PATTERNS.md)** - Performance tips, security, error handling
- **[EXAMPLES.md](EXAMPLES.md)** - Practical prompt examples

## Dependencies

```
index_code_directory → all other tools
find_code_symbol → get_call_graph, find_references, get_symbol_info, trace_data_flow
semantic_code_search → requires embeddings (rebuild with reembed_code_index)
```
