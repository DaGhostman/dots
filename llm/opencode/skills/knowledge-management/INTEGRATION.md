# Integration with RAG

Knowledge Base and Knowledge Graph enhance RAG (Retrieval Augmented Generation).

## Knowledge Base Integration

- **Direct retrieval**: KB entries are indexed and searchable via `search_knowledge`
- **Structured context**: Facts and FAQs provide definitive answers
- **Boosted relevance**: High-importance entries rank higher in retrieval

## Knowledge Graph Integration

- **Entity-aware retrieval**: Graph structure informs what context is relevant
- **Relationship traversal**: Can retrieve connected context beyond simple similarity
- **Disambiguated queries**: Entity resolution via graph relationships

## Combined Usage Pattern

```
1. User query arrives

2. Search knowledge_base for exact matches (FAQ, facts)
   search_knowledge with query

3. Search knowledge_graph for related entities
   search_graph with query, depth: 2

4. If graph entities found, get their context
   get_graph_context for neighborhood

5. Combine results for rich context window:
   - Direct KB answers (FAQ, definitions)
   - Related entities and their connections
   - Source documents from graph entities

6. Use combined context for LLM response
```

## Example: Answering a Complex Question

**User**: "What projects is Alice working on and who are her teammates?"

```
1. nl_query: "What projects is Alice working on?"

2. nl_query: "Who are Alice's teammates?"

3. search_graph for "Alice" to get PERSON entity and connections

4. get_graph_context from Alice's entity to see all relations

5. Combine: Alice BELONGS_TO Project X, Alice WORKS_WITH Bob, etc.

6. Synthesize into coherent answer with project names and teammate names
```

## Example: Research Synthesis

**User** provides research documents. Extract and organize knowledge.

```
1. For each document chunk:
   build_graph to extract entities and relationships

2. Aggregate into knowledge base:
   import_knowledge with facts and definitions from the research

3. Explore connections:
   nl_query to understand relationships between concepts
```

## Example: FAQ Generation from Documentation

```
1. Search/list existing knowledge entries about the topic
2. build_graph on relevant chunks to extract key entities
3. Synthesize findings into FAQ entries with add_knowledge or import_knowledge
4. Use export_knowledge to generate the final FAQ document
```
