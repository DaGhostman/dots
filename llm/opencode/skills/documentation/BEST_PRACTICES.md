# Documentation - Best Practices

## Document Chunking Strategies

### For Code Files

```python
# Use code-aware chunking for source files
ingest_document(
    path="/src/**/*.ts",
    chunk_strategy="code_blocks",  # Split by functions/classes
    extract_annotations=True,      # Extract JSDoc/comments
    metadata={"language": "typescript"}
)
```

**Best Practices for Code:**
- Use `code_blocks` strategy for source files
- Enable `extract_annotations` to capture docstrings/JSDoc
- Include language metadata for better processing
- Set appropriate chunk sizes (500-800 chars for code)

### For Documentation Files

```python
# Use heading-based chunking for Markdown
ingest_document(
    path="/docs/**/*.md",
    chunk_strategy="heading",      # Split by H2/H3 headings
    metadata={"type": "documentation"}
)
```

**Best Practices for Docs:**
- Use `heading` strategy for structured docs
- Set larger chunk sizes (800-1000 chars)
- Include author and last_updated metadata
- Track document status (draft/review/published)

### For Mixed Content

```python
# Use semantic chunking for complex documents
ingest_document(
    path="/docs/architecture.md",
    chunk_strategy="semantic",     # AI-powered boundaries
    metadata={"domain": "architecture"}
)
```

**Best Practices for Complex Docs:**
- Use `semantic` strategy for unstructured content
- Set appropriate chunk overlap (100-200 chars)
- Include rich metadata for context
- Consider domain-specific chunking rules

---

## Metadata Tagging for Retrieval

### Essential Metadata Fields

```python
metadata={
    "domain": "api|architecture|process|onboarding",
    "service": "user-service|payment-gateway",
    "version": "2.1.0",
    "authors": ["author@example.com"],
    "tags": ["authentication", "security", "critical"],
    "last_updated": "2024-03-15",
    "status": "draft|review|published|deprecated"
}
```

### Tagging Strategy

1. **Domain tagging**: Categorize by documentation type
   - `api`: API reference documentation
   - `architecture`: System design and ADRs
   - `process`: Team workflows and processes
   - `onboarding`: New hire guides

2. **Service tagging**: Link to specific services/components
   - `user-service`, `payment-gateway`, `auth-service`
   - Use consistent naming conventions

3. **Status tagging**: Track documentation lifecycle
   - `draft`: In progress, not ready
   - `review`: Awaiting review
   - `published`: Approved and live
   - `deprecated`: Obsolete, use with caution

4. **Priority tagging**: Mark critical vs. optional docs
   - `critical`: Essential for operations
   - `high`: Important but not critical
   - `medium`: Good to have
   - `low`: Nice to know

### Metadata Best Practices

- **Be consistent**: Use same field names across all docs
- **Be complete**: Include all essential fields
- **Be accurate**: Keep metadata up to date
- **Be searchable**: Use tags that help find docs
- **Validate**: Check metadata before ingestion

---

## Cross-Referencing Documentation

### Create Explicit References

```python
# When writing documentation, use cross-references
generate_documentation(
    source="/docs/api.md",
    cross_references=True,
    reference_patterns=[
        "See {{architecture}} for implementation details",
        "Refer to {{onboarding}} for setup instructions"
    ]
)
```

### Build Reference Graph

```python
build_documentation_graph(
    knowledge_bases=["api-documentation", "architecture-kb"],
    relationship_types=["references"],
    detect_implicit_refs=True  # Find unlinked references
)
```

### Cross-Reference Best Practices

- **Use clear patterns**: Define standard reference patterns
- **Link related docs**: Connect API docs to architecture docs
- **Track dependencies**: Map code to documentation
- **Validate links**: Check for broken references regularly
- **Update on changes**: Refresh references when docs change

---

## Version Control Integration

### Automated Versioning

```python
export_documentation(
    knowledge_base="api-documentation",
    output_path="/docs/generated",
    version_control={
        "enabled": True,
        "auto_commit": True,
        "branch": "generated-docs",
        "commit_message_template": "Auto-update {kb_name} v{version}",
        "pr_enabled": True,
        "pr_reviewers": ["docs-team"]
    }
)
```

### Version Strategy

1. **Source versioning**: Track documentation versions in source
   - Use semantic versioning (MAJOR.MINOR.PATCH)
   - Tag releases in Git
   - Maintain changelog

2. **Generated versioning**: Version generated documentation
   - Include version in output paths
   - Create versioned branches
   - Maintain historical versions

3. **Release alignment**: Sync documentation with releases
   - Generate docs before releases
   - Tag generated docs with release version
   - Archive old versions

4. **Changelog tracking**: Maintain documentation change history
   - Document all changes
   - Link to source commits
   - Include reason for changes

### Version Control Best Practices

- **Use dedicated branches**: Keep generated docs separate
- **Automate commits**: Set up CI/CD for updates
- **Require reviews**: Enable PRs for generated docs
- **Track history**: Maintain version history
- **Archive old versions**: Keep historical docs accessible

---

## Knowledge Graph Population

### Populate Graph from Multiple Sources

```python
build_documentation_graph(
    knowledge_bases=["api-documentation", "architecture-kb"],
    sources=["code", "docs", "commits"],
    relationship_types=[
        "implements",      # Code implements API docs
        "references",      # Docs reference each other
        "depends_on",      # Components depend on each other
        "deprecated_by"    # Deprecation relationships
    ],
    detect_gaps=True,    # Find undocumented code
    suggest_links=True   # Suggest new cross-references
)
```

### Graph Maintenance

- **Run weekly**: Detect changes and updates
- **Auto-suggest updates**: Flag stale documentation
- **Flag orphaned docs**: Find docs with no references
- **Identify gaps**: Find undocumented code paths

### Knowledge Graph Best Practices

- **Define entity types**: Be consistent (component, doc, decision)
- **Standardize relationships**: Use clear relationship types
- **Include metadata**: Store context with relationships
- **Query regularly**: Use graph to discover insights
- **Visualize**: Use graph for better understanding

---

## Documentation Quality Guidelines

### Content Quality

1. **Be specific**: Include concrete details, not vague statements
2. **Provide context**: Explain why something matters
3. **Include examples**: Show code in action
4. **Update regularly**: Keep docs current with code
5. **Review frequently**: Validate accuracy and completeness

### Structure Quality

1. **Use templates**: Follow consistent formats
2. **Organize logically**: Group related content
3. **Use headings**: Structure with clear hierarchy
4. **Add navigation**: Include table of contents
5. **Link resources**: Connect to related docs

### Search Quality

1. **Use good keywords**: Choose searchable terms
2. **Include synonyms**: Add alternative terms
3. **Tag appropriately**: Use descriptive tags
4. **Write clear titles**: Make titles descriptive
5. **Test searches**: Verify docs are findable

---

## Common Patterns

### Generate from Code

```python
# Basic API generation
generate_documentation(
    source="/src",
    output_format="markdown",
    extraction_rules={
        "include_public": True,
        "extract_examples": True
    }
)

# With grouping
generate_documentation(
    source="/src",
    output_format="markdown",
    extraction_rules={
        "group_by_service": True,
        "group_by_category": True
    }
)
```

### Search Documentation

```python
# Simple search
search_knowledge(
    query="authentication flow",
    knowledge_base="api-documentation",
    top_k=5
)

# With filters
search_knowledge(
    query="rate limiting",
    knowledge_base="api-documentation",
    filters={
        "domain": "api",
        "service": "gateway"
    },
    top_k=5
)

# Similarity search
search_knowledge(
    query="",
    knowledge_base="api-documentation",
    search_type="similarity",
    reference_chunk="chunk_id_123",
    top_k=10
)
```

### Build Relationships

```python
# Basic graph
build_documentation_graph(
    knowledge_bases=["api-documentation"],
    relationship_types=["references"]
)

# Advanced graph
build_documentation_graph(
    knowledge_bases=["api-documentation", "architecture-kb"],
    relationship_types=["references", "implements", "depends_on"],
    detect_gaps=True,
    suggest_links=True
)
```

---

## Notes

- **Test on small subsets**: Always test documentation generation on small code sections first
- **Use version control**: Track all generated documentation in Git
- **Schedule regular updates**: Set up automated weekly/monthly updates
- **Monitor search analytics**: Use search data to improve documentation
- **Keep metadata consistent**: Use consistent metadata across all documents
- **Review and validate**: Validate generated documentation before publishing

---

## Checklist for Documentation Workflows

### Before Generation
- [ ] Define knowledge base structure
- [ ] Set up metadata conventions
- [ ] Configure chunking strategy
- [ ] Define extraction rules

### During Generation
- [ ] Test on small subset
- [ ] Validate generated output
- [ ] Check for errors
- [ ] Review quality

### After Generation
- [ ] Export to target format
- [ ] Version control integration
- [ ] Set up maintenance schedule
- [ ] Update knowledge graph
- [ ] Notify team of changes

### Ongoing Maintenance
- [ ] Weekly updates
- [ ] Monthly reviews
- [ ] Quarterly audits
- [ ] Annual restructuring
