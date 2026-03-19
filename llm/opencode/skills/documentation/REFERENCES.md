# Documentation - Complete Reference

## RAG Operations Reference

### 1. Create Knowledge Base

```python
# Initialize a new knowledge base
create_knowledge_base(
    name="api-documentation",
    description="API documentation for all microservices",
    config={
        "chunk_size": 500,
        "chunk_overlap": 50,
        "embedding_model": "text-embedding-ada-002",
        "index_type": "vector"
    }
)

# Create domain-specific knowledge bases
create_knowledge_base(
    name="architecture-kb",
    description="System architecture and design decisions",
    config={
        "chunk_strategy": "semantic",
        "metadata_fields": ["authors", "dates", "tags", "relationships"],
        "index_type": "hybrid"
    }
)
```

**Configuration Options:**
- `chunk_size`: Number of characters per chunk (default: 500)
- `chunk_overlap`: Overlap between chunks for context (default: 50)
- `chunk_strategy`: "semantic", "size", or "heading"
- `embedding_model`: Model for vector embeddings
- `index_type`: "vector", "keyword", or "hybrid"

### 2. Ingest Documents

```python
# Ingest a single document with custom chunking
ingest_document(
    path="/docs/api/user-service.md",
    chunk_strategy="heading",
    metadata={
        "domain": "api",
        "service": "user-service",
        "version": "2.1.0",
        "authors": ["john@example.com"]
    }
)

# Ingest code files with annotation extraction
ingest_document(
    path="/src/services/UserService.ts",
    chunk_strategy="code_blocks",
    extract_annotations=True,
    metadata={
        "language": "typescript",
        "type": "source_code",
        "dependencies": ["database", "cache"]
    }
)

# Batch ingest multiple documents
ingest_documents(
    pattern="/docs/**/*.md",
    chunk_strategy="size",
    metadata_template={
        "domain": "architecture",
        "team": "platform"
    }
)
```

**Chunking Strategies:**
- `"size"`: Fixed-size character chunks
- `"heading"`: Split by document headings
- `"semantic"`: AI-powered semantic boundaries
- `"code_blocks"`: Split by code blocks and comments
- `"paragraph"`: Split by paragraphs

### 3. Search Knowledge Base

```python
# Semantic search with metadata filtering
search_knowledge(
    query="how to implement rate limiting",
    knowledge_base="api-documentation",
    filters={
        "domain": "api",
        "service": "gateway"
    },
    top_k=5,
    return_context=True
)

# Hybrid search with keyword and vector matching
search_knowledge(
    query="authentication flow",
    knowledge_base="architecture-kb",
    search_type="hybrid",
    filters={"authors": ["alice@example.com"]},
    min_score=0.7
)

# Similarity search for related documentation
search_knowledge(
    query="",
    knowledge_base="api-documentation",
    search_type="similarity",
    reference_chunk="chunk_id_123",
    top_k=10
)
```

**Search Parameters:**
- `query`: Search query string
- `knowledge_base`: Target knowledge base name
- `filters`: Metadata filters for precise retrieval
- `top_k`: Number of results to return
- `search_type`: "semantic", "keyword", "hybrid", or "similarity"
- `min_score`: Minimum relevance score threshold

### 4. Generate Documentation

```python
# Generate API documentation from code
generate_documentation(
    source="/src/services",
    output_format="markdown",
    extraction_rules={
        "include_public": true,
        "include_private": false,
        "extract_examples": true,
        "generate_signatures": true
    }
)

# Generate architecture documentation
generate_documentation(
    source="/architecture",
    output_format="mermaid",
    type="component_diagram",
    relationships=["dependencies", "communication", "data_flow"]
)

# Generate from knowledge base
generate_documentation(
    knowledge_base="onboarding-kb",
    output_format="markdown",
    type="guide",
    target_audience="new_developers",
    sections=["setup", "architecture", "workflow"]
)
```

**Extraction Rules:**
- `include_public`: Include public API members
- `include_private`: Include private members
- `extract_examples`: Extract code examples from comments
- `generate_signatures`: Generate method signatures
- `relationship_types`: Types of relationships to extract

### 5. Build Documentation Graph

```python
# Build knowledge graph from documentation
build_documentation_graph(
    knowledge_bases=["api-documentation", "architecture-kb"],
    relationship_types=["references", "dependencies", "implements"],
    output_format="json"
)

# Analyze documentation relationships
build_documentation_graph(
    source="/src",
    relationship_types=["calls", "imports", "extends"],
    include_code_analysis=True,
    detect_gaps=True
)

# Export graph for visualization
build_documentation_graph(
    knowledge_base="api-documentation",
    output_format="graphml",
    include_metadata=True,
    include_embeddings=False
)
```

**Relationship Types:**
- `"references"`: Document A references Document B
- `"dependencies"`: Code dependency relationships
- `"implements"`: Implementation relationships
- `"calls"`: Function call relationships
- `"imports"`: Import dependencies

### 6. Export Documentation

```python
# Export to static site
export_documentation(
    knowledge_base="api-documentation",
    output_format="docusaurus",
    output_path="/docs/generated",
    config={
        "site_title": "API Documentation",
        "sidebar_enabled": true,
        "search_enabled": true
    }
)

# Export to multiple formats
export_documentation(
    knowledge_base="architecture-kb",
    output_format=["markdown", "html", "pdf"],
    output_path="/exports/architecture",
    version="2.0.0"
)

# Export with versioning
export_documentation(
    knowledge_base="onboarding-kb",
    output_format="markdown",
    output_path="/docs/onboarding",
    version_control={
        "enabled": true,
        "branch": "docs",
        "commit_message": "Update onboarding documentation"
    }
)
```

**Export Formats:**
- `"markdown"`: Plain Markdown files
- `"html"`: Static HTML pages
- `"pdf"`: PDF documents
- `"docusaurus"`: Docusaurus site structure
- `"mkdocs"`: MkDocs site structure
- `"json"`: Structured JSON data

---

## Metadata Tagging Reference

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
2. **Service tagging**: Link to specific services/components
3. **Status tagging**: Track documentation lifecycle
4. **Priority tagging**: Mark critical vs. optional docs

---

## Quick Reference

### Key Tools
- `create_knowledge_base()` - initialize new knowledge bases
- `ingest_document()` - add documents with chunking
- `search_knowledge()` - retrieve documentation
- `generate_documentation()` - create docs from code/kb
- `build_documentation_graph()` - map relationships
- `export_documentation()` - publish in various formats

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

# Update incremental
update_knowledge_base(knowledge_base="api-documentation", change_detection=True)

# Find documentation gaps
find_documentation_gaps(knowledge_base="api-documentation", source="/src")

# Suggest cross-references
suggest_cross_references(knowledge_base="api-documentation")
```
