---
name: knowledge-management
description: Comprehensive knowledge management using Knowledge Base and Knowledge Graph. Use when working with facts, definitions, FAQs, procedures, entity relationships, concept connections, or natural language queries about stored knowledge.
license: MIT
allowed-tools:
  - Bash(kb:*)
  - Bash(graph:*)
  - Bash(mcp:*)
---

# Knowledge Management Skill

Two complementary knowledge systems: **Knowledge Base** (structured facts/FAQs) and **Knowledge Graph** (entity relationships).

## Knowledge Base vs. Knowledge Graph

| Aspect | Knowledge Base | Knowledge Graph |
|--------|---------------|-----------------|
| **Purpose** | Store structured facts, FAQs, definitions, procedures | Map entities and their relationships |
| **Data Model** | Flat entries with types and categories | Nodes (entities) connected by edges (relations) |
| **Best For** | Facts, rules, step-by-step procedures, Q&A | "How is X related to Y?", exploring connections |
| **Query Pattern** | "Find me an FAQ about X" | "Find entities related to X" |

### When to Use Each

**Knowledge Base** — Facts, FAQs, definitions, procedures, rules, examples
**Knowledge Graph** — Entity relationships, concept connections, network exploration, path discovery

## Quick Reference

### Knowledge Base Tools
| Tool | Purpose |
|------|---------|
| `add_knowledge` | Add single entry |
| `get_knowledge` | Retrieve by ID |
| `update_knowledge` | Modify entry |
| `delete_knowledge` | Remove entry |
| `list_knowledge` | Browse with filters |
| `search_knowledge` | Full-text/semantic search |
| `import_knowledge` | Bulk add entries |
| `export_knowledge` | Export as JSON/CSV |
| `deduplicate_knowledge` | Merge duplicates |

### Knowledge Graph Tools
| Tool | Purpose |
|------|---------|
| `search_graph` | Find entities by query |
| `get_graph_context` | Traverse from entity |
| `add_graph_relation` | Create relationship |
| `get_graph_stats` | Graph statistics |
| `build_graph` | Extract from text |
| `nl_query` | Natural language query |
| `reclassify_entity` | Change entity type |
| `reclassify_bulk` | Bulk reclassify |
| `auto_reclassify` | Auto-fix classifications |
| `suggest_reclassification` | Get suggestions |
| `auto_link_entities` | Auto-create relations |
| `deduplicate_graph` | Merge duplicate entities |

## Reference Links

- [Knowledge Base Tools](./KB_TOOLS.md)
- [Knowledge Graph Tools](./GRAPH_TOOLS.md)
- [Workflows](./WORKFLOWS.md)
- [Integration with RAG](./INTEGRATION.md)
- [Examples](./EXAMPLES.md)
