# Workflows

Common patterns for using Knowledge Base and Knowledge Graph effectively.

---

## Workflow A: Building a Knowledge Base from Research

**When**: User provides information to store for future reference.

### Steps

```
1. Analyze the content to determine entry types:
   - Factual statements → type: "fact"
   - Questions with answers → type: "faq"
   - Concept explanations → type: "definition"
   - Step-by-step instructions → type: "procedure"
   - Rules or constraints → type: "rule"

2. Batch similar entries using import_knowledge

3. Assign appropriate categories for organization

4. Set importance based on frequency of access
```

### Example

User provides meeting notes with multiple facts:

```json
{
  "entries": [
    {
      "title": "API Rate Limiting",
      "content": "The API allows 1000 requests per minute per key",
      "type": "fact",
      "category": "api"
    },
    {
      "title": "How to authenticate?",
      "content": "Pass your API key in the Authorization header: Bearer <key>",
      "type": "faq",
      "category": "api"
    },
    {
      "title": "RAG System Architecture",
      "content": "RAG combines retrieval and generation: documents are chunked, embedded, stored in vector DB, retrieved by semantic similarity, and fed to LLM with user query",
      "type": "definition",
      "category": "architecture"
    }
  ]
}
```

---

## Workflow B: Extracting Entities and Relationships

**When**: Analyzing documents to build the knowledge graph.

### Steps

```
1. Use build_graph with source chunks to extract entities

2. For each extracted entity, the system identifies:
   - Entity name and type (PERSON, ORG, etc.)
   - Confidence score
   - Source location

3. Relationships are inferred from context

4. Use search_graph to verify and explore extracted content

5. Use reclassify tools if initial classifications are incorrect
```

### Example

Input text:
```
At Acme Corp, engineer Jane Smith developed the new authentication system. She presented the results at the Q4 all-hands meeting in San Francisco.
```

```json
{
  "source_type": "chunk",
  "source_id": "chunk-abc123",
  "text": "At Acme Corp, engineer Jane Smith developed the new authentication system. She presented the results at the Q4 all-hands meeting in San Francisco."
}
```

**Expected extraction**:
- Entities: `Acme Corp` (ORG), `Jane Smith` (PERSON), `Q4 all-hands` (EVENT), `San Francisco` (LOCATION)
- Relations: `Jane Smith BELONGS_TO Acme Corp`, `Jane Smith PRESENTED_AT Q4 all-hands`

---

## Workflow C: Natural Language Queries Against the Graph

**When**: User asks relationship questions.

### Steps

```
1. Use nl_query for direct questions:
   - "How is X related to Y?"
   - "Who worked on project Z?"
   - "What organizations are connected to this?"

2. Use search_graph for entity discovery:
   - "Find all entities related to X"
   - "Show me people connected to this project"

3. Use get_graph_context for neighborhood exploration:
   - Start from known entity, traverse outward
```

### Example Queries

| Question | Tool | Query |
|----------|------|-------|
| "How is Alice connected to the project?" | `nl_query` | "How is Alice connected to the project?" |
| "Find all companies mentioned" | `nl_query` | "List all companies mentioned" |
| "Show me connections to the API entity" | `search_graph` | query: "API", depth: 2 |
| "What surrounds entity xyz?" | `get_graph_context` | entity_id: "xyz", depth: 2 |

---

## Workflow D: Combined KB and Graph Usage

**When**: User needs both definitive answers and relationship context.

### Steps

```
1. Search KB for exact matches (FAQ, facts, definitions)
   search_knowledge with query

2. Search Graph for related entities
   search_graph with query, depth: 2

3. If graph entities found, get their context
   get_graph_context for neighborhood

4. Combine results:
   - Direct KB answers (FAQ, definitions)
   - Related entities and their connections
   - Source documents from graph entities

5. Use combined context for LLM response
```

### Example

User: "What projects is Alice working on and who are her teammates?"

```
1. nl_query: "What projects is Alice working on?"
2. nl_query: "Who are Alice's teammates?"
3. search_graph for "Alice" to get PERSON entity and connections
4. get_graph_context from Alice's entity to see all relations
5. Combine: Alice BELONGS_TO Project X, Alice WORKS_WITH Bob, etc.
6. Synthesize into coherent answer
```
