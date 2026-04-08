# Practical Examples

Four common scenarios demonstrating Knowledge Base and Knowledge Graph usage.

---

## Scenario 1: Onboarding Documentation

**Context**: A new team member joins. Build both KB and Graph for them.

### Knowledge Base Entries

```json
// Required code reviews
add_knowledge with type="fact": "Code reviews are required for all PRs"

// Setup procedure
add_knowledge with type="procedure": "How to set up local environment"

// Common question
add_knowledge with type="faq": "Where is the CI/CD pipeline configured?"

// Security rule
add_knowledge with type="rule": "Never commit secrets to the repository"
```

### Knowledge Graph

```json
// Extract team structure from onboarding doc
build_graph from onboarding-doc with team structure info

// Understand system relationships
search_graph for "architecture" to understand system relationships
```

---

## Scenario 2: Debugging with Knowledge

**Context**: User reports an API error. Use knowledge systems to help.

```
1. search_knowledge for similar issues (FAQ entries)
   Query: "API error 500"

2. search_graph for related error entities or services
   Query: "authentication service"

3. get_graph_context to see what services interact with the failing one
   entity_id: "auth-service", depth: 2
```

---

## Scenario 3: Research Synthesis

**Context**: User provides research documents. Extract and organize knowledge.

```
1. For each document chunk:
   build_graph to extract entities and relationships

2. Aggregate into knowledge base:
   import_knowledge with facts and definitions from the research

3. Explore connections:
   nl_query to understand relationships between concepts
```

### Example Input

Document text:
```
Transformer models use self-attention mechanisms. Vaswani et al. introduced this architecture in 2017. GPT and BERT are prominent examples.
```

```json
{
  "source_type": "chunk",
  "source_id": "chunk-research-1",
  "text": "Transformer models use self-attention mechanisms. Vaswani et al. introduced this architecture in 2017. GPT and BERT are prominent examples."
}
```

**Extracted**:
- Entities: `Transformer` (CONCEPT), `Self-Attention` (CONCEPT), `Vaswani et al.` (PERSON), `2017` (DATE), `GPT` (CONCEPT), `BERT` (CONCEPT)
- Relations: `Transformer USES Self-Attention`, `Vaswani et al. INTRODUCED Transformer`

---

## Scenario 4: FAQ Generation

**Context**: User wants to create an FAQ from existing documentation.

```
1. Search existing knowledge entries about the topic
   list_knowledge with category: "api"

2. Build graph on relevant chunks to extract key entities
   build_graph on API documentation chunks

3. Synthesize findings into FAQ entries
   import_knowledge with synthesized FAQs

4. Export the final FAQ document
   export_knowledge with format: "json"
```

### Example Output

```json
{
  "entries": [
    {
      "title": "How do I authenticate API requests?",
      "content": "Pass your API key in the Authorization header: Bearer <key>",
      "type": "faq",
      "category": "api"
    },
    {
      "title": "What is the rate limit?",
      "content": "The API allows 1000 requests per minute per key",
      "type": "faq",
      "category": "api"
    },
    {
      "title": "How do I retry failed requests?",
      "content": "Use exponential backoff starting at 1 second, max 5 retries. Failed requests return 429 status.",
      "type": "faq",
      "category": "api"
    }
  ]
}
```
