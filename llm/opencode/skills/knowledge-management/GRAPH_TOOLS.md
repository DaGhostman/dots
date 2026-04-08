# Knowledge Graph Tools

Entity-based storage with relationships for exploring connections and networks.

## Entity Types

`PERSON`, `ORG`, `LOCATION`, `DATE`, `EVENT`, `CONCEPT`

## Relation Types

`RELATED_TO`, `PART_OF`, `BELONGS_TO`, `REFERENCES`, `CAUSES`, `FOLLOWS`, `MENTIONS`

---

## Core Graph Operations

### `search_graph`

Search for entities and relationships using semantic similarity.

```json
{
  "query": "authentication",
  "limit": 5,
  "depth": 2,
  "entity_types": ["PERSON", "ORG"],
  "hybrid_search": true
}
```

**Parameters**: query (required), limit, depth (1-5), entity_types, hybrid_search

---

### `get_graph_context`

Traverse the graph from a starting entity to discover neighbors.

```json
{
  "entity_id": "abc123",
  "depth": 2,
  "direction": "both"
}
```

**Parameters**:
- `entity_id` (required): Starting entity
- `depth`: How many hops (1-5)
- `direction`: `outgoing`, `incoming`, `both`

---

### `add_graph_relation`

Create explicit relationships between entities.

```json
{
  "source_entity_id": "person-alice",
  "target_entity_id": "org-acme",
  "relation_type": "BELONGS_TO",
  "metadata": { "confidence": 0.9 }
}
```

**Parameters**: source_entity_id (required), target_entity_id (required), relation_type (required), metadata

---

### `get_graph_stats`

Get overview statistics: entity counts, relation counts, breakdown by type.

```json
{}
```

---

### `build_graph`

Extract entities and relationships from text and add to graph.

```json
{
  "source_type": "chunk",
  "source_id": "chunk-xyz",
  "text": "Alice from Acme Corp presented the Q3 results..."
}
```

**Parameters**: source_type (`chunk`, `memory`, `session`), source_id, text

**Expected extraction**: Entities (Acme Corp → ORG, Alice → PERSON, Q3 results → EVENT) with inferred relations

---

## Natural Language Queries

### `nl_query`

Query the graph using natural language questions.

```json
{
  "query": "How is Alice connected to the project?"
}
```

**Example queries**:
- "How is Alice connected to the project?"
- "What companies are mentioned in the context?"
- "Find all events that occurred in Q4"
- "Who worked on the authentication system?"

---

## Entity Classification

### `reclassify_entity`

Manually change an entity's type classification.

```json
{
  "entity_id": "entity-123",
  "new_type": "PERSON",
  "reason": "Name refers to a person, not a concept"
}
```

**Parameters**: entity_id (required), new_type (required), reason

---

### `reclassify_bulk`

Bulk reclassify multiple entities with filtering.

```json
{
  "entity_types": ["CONCEPT"],
  "source_type": "chunk",
  "min_confidence": 0.3,
  "new_type": "ORG",
  "dry_run": true
}
```

**Parameters**: entity_types, source_type, min_confidence, max_confidence, new_type, dry_run

---

### `auto_reclassify`

Automatically improve entity classifications based on context patterns.

```json
{
  "confidence_threshold": 0.5,
  "max_entities": 100
}
```

---

### `suggest_reclassification`

Get AI-suggested reclassification for an entity before applying.

```json
{
  "entity_id": "entity-123"
}
```

---

## Relationship Management

### `auto_link_entities`

Automatically create relationships based on type patterns.

```json
{
  "pairs": [
    {
      "source_type": "PERSON",
      "target_type": "ORG",
      "relation_type": "BELONGS_TO"
    }
  ],
  "threshold": 0.7
}
```

---

## Graph Maintenance

### `deduplicate_graph`

Find and merge duplicate entities.

```json
{
  "mode": "full",
  "threshold": 0.85,
  "strategy": "merge",
  "entity_ids": ["entity-1", "entity-2"]
}
```

**Parameters**:
- `mode`: `detect` (dry run), `merge` (apply once), `full` (detect then apply)
- `strategy`: `keep_first`, `keep_latest`, `merge`
- `threshold`: Similarity threshold (0-1)
- `entity_ids`: Optional specific entities to check

---

## Best Practices

1. **Correct misclassifications early**: Wrong entity types break traversal
2. **Use appropriate depth**: Deeper traversal = more context but slower
3. **Use hybrid_search**: Combines vector similarity with keyword matching
4. **Prefer dry_run**: Preview deduplication and bulk reclassification
5. **Regular maintenance**: Periodically deduplicate the graph
6. **Entity reclassification**: Fix misclassified entities early for accurate traversal
