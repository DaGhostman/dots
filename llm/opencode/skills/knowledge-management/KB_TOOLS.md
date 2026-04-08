# Knowledge Base Tools

Structured storage for facts, FAQs, definitions, procedures, rules, and examples.

## Entry Types

`faq`, `fact`, `definition`, `rule`, `procedure`, `example`, `note`

## Core CRUD Operations

### `add_knowledge`

Add a new entry to the knowledge base.

```json
{
  "title": "Default API Port",
  "content": "The API server listens on port 3000 by default",
  "type": "fact",
  "category": "api",
  "importance": 0.8,
  "source_type": "manual"
}
```

**Parameters**: title (required), content (required), type (required), category, importance (0-1), metadata, source_type, source_name, source_url, tag_ids

---

### `get_knowledge`

Retrieve a specific entry by ID.

```json
{
  "id": "entry-abc123"
}
```

---

### `update_knowledge`

Update an existing entry. Use to correct outdated information or change importance/category.

```json
{
  "id": "entry-abc123",
  "title": "Updated Title",
  "content": "Corrected information",
  "importance": 0.9
}
```

**Parameters**: id (required), title, content, type, category, importance, metadata, source_type, source_name, source_url

---

### `delete_knowledge`

Remove an entry. Use when information is no longer relevant or was added incorrectly.

```json
{
  "id": "entry-abc123"
}
```

---

## Discovery & Search

### `list_knowledge`

List entries with filtering, sorting, pagination.

```json
{
  "category": "api",
  "type": "faq",
  "sort_by": "importance",
  "sort_order": "desc",
  "limit": 20,
  "offset": 0
}
```

**Filter parameters**: category, type, tag_ids (entries must have ALL specified tags), min_importance, max_importance
**Sort options**: created_at, updated_at, importance, title

---

### `search_knowledge`

Full-text and semantic search across entries.

```json
{
  "query": "authentication setup",
  "category": "api",
  "type": "faq",
  "limit": 10
}
```

**Best for**: "Find FAQ about authentication", "What is the definition of X?"
**Returns**: Matching entries with relevance scores and content snippets

---

## Bulk Operations

### `import_knowledge`

Bulk import multiple entries at once.

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
    }
  ]
}
```

**Efficient for**: Adding FAQ sets, migrating from other systems, batch population from research

---

### `export_knowledge`

Export entries as JSON or CSV.

```json
{
  "category": "api",
  "type": "faq",
  "format": "json"
}
```

**Use for**: Backup and portability, analysis in external tools, sharing with team members

---

### `deduplicate_knowledge`

Find and merge duplicate entries based on similarity.

```json
{
  "category": "api",
  "threshold": 0.85,
  "strategy": "merge",
  "dry_run": false
}
```

**Parameters**:
- `threshold`: Similarity level (0-1) to consider duplicates
- `strategy`: `keep_first` (oldest), `keep_latest` (newest), `merge` (combine)
- `dry_run`: `true` to preview before applying

---

## Best Practices

1. **Use appropriate types**: Choose the right entry type for better retrieval
2. **Set importance wisely**: High-importance facts appear first in search
3. **Use categories**: Group related entries for easier browsing and export
4. **Prefer import/export**: Batch operations are more efficient than individual calls
5. **Use dry_run for destructive ops**: Preview before deduplication
