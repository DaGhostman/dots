---
name: documentation
description: Leverage RAG to create, manage, and maintain comprehensive documentation systems from code, decisions, and knowledge.
license: MIT
---

# Documentation Skill

## What I Do

- **Create and manage knowledge bases** for different documentation domains (APIs, architecture, processes)
- **Ingest documents with proper chunking** strategies and extract metadata from source files
- **Generate documentation from code** annotations (JSDoc, Python docstrings, Go comments)
- **Search and retrieve documentation** using semantic and hybrid search across all knowledge bases
- **Build documentation graphs** showing relationships between documents and code
- **Export and publish documentation** in multiple formats (HTML, PDF, Markdown, JSON)

## When to Use Me

### ✅ API Documentation Generation
Generate API reference from source code annotations, create usage examples from test files, and maintain API changelogs.

**Example:** "Generate API documentation for the UserService class, including all public methods and their parameters"

### ✅ Architecture Documentation
Extract system architecture from code structure, create component diagrams, document data flows, and maintain ADRs.

**Example:** "Create architecture documentation for the payment processing system, showing all components and their interactions"

### ✅ Knowledge Base Creation
Build team knowledge bases for onboarding, ingest existing documentation, and create process documentation from workflows.

**Example:** "Create a knowledge base for our authentication system, ingesting all related code files and existing documentation"

### ✅ Technical Decision Records (ADRs)
Document architectural decisions with context, track decision evolution, and link decisions to affected code.

**Example:** "Generate ADRs for all major architectural changes in the last quarter based on commit messages and code changes"

### ✅ Onboarding Documentation
Create role-specific onboarding guides, document setup processes, and generate quick reference guides.

**Example:** "Create onboarding documentation for new backend developers, including setup, key components, and common workflows"

## When NOT to Use Me

### ❌ Marketing Content
Product marketing copy, sales documentation, brand messaging, and promotional materials should use dedicated marketing tools.

### ❌ UI Copy and Microcopy
Button text, labels, error messages, tooltips, and form field labels are better handled by design tools.

### ❌ Legal and Compliance
Legal terms, privacy policies, compliance documentation requiring legal review, and regulatory filings need legal expertise.

### ❌ Creative Writing
Blog posts, articles, newsletters, storytelling, and creative descriptions should use creative writing tools.

### ❌ Real-Time Information
Current status of live services, real-time metrics, and dynamic content that changes frequently are not suitable.

## RAG Operations

See [REFERENCES](REFERENCES.md) for complete API documentation.

## Workflows

See [WORKFLOWS](WORKFLOWS.md) for step-by-step examples.

## Best Practices

See [BEST_PRACTICES](BEST_PRACTICES.md) for guidelines.

## Quick Reference

### Key Tools
- `create_knowledge_base()` - initialize new knowledge bases
- `ingest_document()` - add documents with chunking
- `search_knowledge()` - retrieve documentation
- `generate_documentation()` - create docs from code/kb
- `build_documentation_graph()` - map relationships
- `export_documentation()` - publish in various formats

### Chunking Strategies
- `"size"` - Fixed-size character chunks
- `"heading"` - Split by document headings
- `"semantic"` - AI-powered semantic boundaries
- `"code_blocks"` - Split by code blocks and comments
- `"paragraph"` - Split by paragraphs

### Export Formats
- `"markdown"` - Plain Markdown files
- `"html"` - Static HTML pages
- `"pdf"` - PDF documents
- `"docusaurus"` - Docusaurus site structure
- `"mkdocs"` - MkDocs site structure
- `"json"` - Structured JSON data

### Search Types
- `"semantic"` - Vector-based semantic search
- `"keyword"` - Traditional keyword matching
- `"hybrid"` - Combined semantic and keyword
- `"similarity"` - Find similar content

### Metadata Fields
- `domain` - api|architecture|process|onboarding
- `service` - Specific service/component name
- `version` - Document version
- `authors` - List of authors
- `tags` - Searchable tags
- `status` - draft|review|published|deprecated

### Common Patterns

**Generate from Code:**
```
"Generate {format} documentation from {source_path} with {extraction_rules}"
```

**Search Documentation:**
```
"Search knowledge base '{kb_name}' for '{query}' with filters {filters}"
```

**Build Relationships:**
```
"Build documentation graph from '{knowledge_bases}' with relationship types {types}"
```

### Useful Commands

```python
# Check knowledge base health
check_knowledge_base_health(knowledge_base="api-documentation")

# Update incrementally
update_knowledge_base(knowledge_base="api-documentation", change_detection=True)

# Find documentation gaps
find_documentation_gaps(knowledge_base="api-documentation", source="/src")

# Suggest cross-references
suggest_cross_references(knowledge_base="api-documentation")
```

---

**Remember:** Always test documentation generation on small subsets first, use version control for all generated docs, and schedule regular updates to keep documentation current.
