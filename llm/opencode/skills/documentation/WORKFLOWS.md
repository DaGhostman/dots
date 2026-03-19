# Documentation - Workflows

## Workflow 1: API Documentation Generation

**Goal**: Generate comprehensive API documentation from TypeScript codebase

### Steps:

#### 1. Create Knowledge Base
```python
create_knowledge_base(
    name="api-documentation",
    description="API documentation for all services",
    config={
        "chunk_size": 500,
        "chunk_overlap": 50,
        "embedding_model": "text-embedding-ada-002",
        "index_type": "hybrid"
    }
)
```

#### 2. Ingest Source Code
```python
ingest_documents(
    pattern="/src/**/*.ts",
    chunk_strategy="code_blocks",
    extract_annotations=True,
    metadata={
        "domain": "api",
        "language": "typescript",
        "type": "source_code"
    }
)
```

#### 3. Ingest Existing Docs
```python
ingest_documents(
    pattern="/docs/api/**/*.md",
    chunk_strategy="heading",
    metadata={
        "domain": "api",
        "type": "documentation"
    }
)
```

#### 4. Generate Documentation
```python
generate_documentation(
    source="/src",
    output_format="markdown",
    extraction_rules={
        "include_public": True,
        "include_private": False,
        "extract_examples": True,
        "generate_signatures": True,
        "group_by_service": True
    }
)
```

#### 5. Build Knowledge Graph
```python
build_documentation_graph(
    knowledge_bases=["api-documentation"],
    relationship_types=["references", "implements", "calls"],
    detect_gaps=True
)
```

#### 6. Export Documentation
```python
export_documentation(
    knowledge_base="api-documentation",
    output_format="docusaurus",
    output_path="/docs/api-site",
    config={
        "site_title": "API Documentation",
        "sidebar_enabled": True,
        "search_enabled": True
    }
)
```

**Result**: Complete, searchable API documentation site with code examples and relationships.

---

## Workflow 2: Architecture Documentation

**Goal**: Create architecture documentation from code and decisions

### Steps:

#### 1. Create Architecture Knowledge Base
```python
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

#### 2. Ingest ADRs and Architecture Docs
```python
ingest_documents(
    pattern="/docs/architecture/**/*.md",
    chunk_strategy="heading",
    metadata={
        "domain": "architecture",
        "type": "adr"
    }
)
```

#### 3. Analyze Code Structure
```python
generate_documentation(
    source="/src",
    output_format="mermaid",
    type="component_diagram",
    relationships=["dependencies", "communication", "data_flow"],
    extract_from_code=True
)
```

#### 4. Build Architecture Graph
```python
build_documentation_graph(
    knowledge_bases=["architecture-kb"],
    sources=["code", "docs", "commits"],
    relationship_types=[
        "depends_on",
        "communicates_with",
        "implements",
        "deprecated_by"
    ],
    detect_gaps=True,
    suggest_links=True
)
```

#### 5. Generate Architecture Documentation
```python
generate_documentation(
    knowledge_base="architecture-kb",
    output_format="markdown",
    type="architecture_guide",
    sections=[
        "overview",
        "components",
        "data_flows",
        "decisions",
        "glossary"
    ]
)
```

#### 6. Export to Multiple Formats
```python
export_documentation(
    knowledge_base="architecture-kb",
    output_format=["markdown", "html", "pdf"],
    output_path="/exports/architecture",
    version="2.0.0"
)
```

**Result**: Comprehensive architecture documentation with diagrams, ADRs, and code relationships.

---

## Workflow 3: Team Knowledge Base Setup

**Goal**: Create searchable knowledge base for team onboarding and reference

### Steps:

#### 1. Create Onboarding Knowledge Base
```python
create_knowledge_base(
    name="onboarding-kb",
    description="Team onboarding and process documentation",
    config={
        "chunk_size": 800,
        "chunk_overlap": 100,
        "chunk_strategy": "semantic",
        "index_type": "hybrid"
    }
)
```

#### 2. Ingest Existing Documentation
```python
ingest_documents(
    pattern="/wiki/**/*.md",
    chunk_strategy="heading",
    metadata={
        "domain": "onboarding",
        "team": "engineering"
    }
)

ingest_documents(
    pattern="/docs/process/**/*.md",
    chunk_strategy="size",
    metadata={
        "domain": "process",
        "team": "engineering"
    }
)
```

#### 3. Extract Code-Based Knowledge
```python
ingest_document(
    path="/setup-guide.sh",
    chunk_strategy="size",
    extract_commands=True,
    metadata={
        "domain": "onboarding",
        "type": "setup_instructions"
    }
)
```

#### 4. Generate Role-Specific Guides
```python
generate_documentation(
    knowledge_base="onboarding-kb",
    output_format="markdown",
    type="guide",
    target_audience="new_developers",
    sections=[
        "first_day",
        "setup_environment",
        "first_commit",
        "team_processes",
        "resources"
    ]
)

generate_documentation(
    knowledge_base="onboarding-kb",
    output_format="markdown",
    type="guide",
    target_audience="new_managers",
    sections=[
        "team_overview",
        "processes",
        "tools",
        "responsibilities"
    ]
)
```

#### 5. Build Knowledge Graph
```python
build_documentation_graph(
    knowledge_bases=["onboarding-kb"],
    relationship_types=["references", "prerequisite", "see_also"],
    detect_gaps=True,
    suggest_links=True
)
```

#### 6. Export and Publish
```python
export_documentation(
    knowledge_base="onboarding-kb",
    output_format="docusaurus",
    output_path="/docs/onboarding-site",
    config={
        "site_title": "Engineering Onboarding",
        "sidebar_enabled": True,
        "search_enabled": True,
        "role_filtering": True
    }
)
```

#### 7. Set Up Maintenance
```python
# Schedule regular updates
export_documentation(
    knowledge_base="onboarding-kb",
    output_format="markdown",
    output_path="/docs/onboarding",
    version_control={
        "enabled": True,
        "auto_commit": True,
        "branch": "docs",
        "schedule": "weekly"
    }
)
```

**Result**: Comprehensive, searchable onboarding knowledge base with role-specific guides.

---

## Workflow 4: Incremental Knowledge Base Updates

**Goal**: Keep documentation current with code changes

### Steps:

#### 1. Detect Changes
```python
# Enable change detection
update_knowledge_base(
    knowledge_base="api-documentation",
    change_detection=True,
    source_path="/src"
)
```

#### 2. Re-ingest Modified Files
```python
# Re-ingest only changed files
ingest_documents(
    pattern="/src/**/*.ts",
    chunk_strategy="code_blocks",
    extract_annotations=True,
    only_changed=True,
    since="2024-03-15"
)
```

#### 3. Update Knowledge Graph
```python
# Update relationships
build_documentation_graph(
    knowledge_bases=["api-documentation"],
    relationship_types=["references", "implements", "calls"],
    update_existing=True
)
```

#### 4. Regenerate Affected Docs
```python
# Regenerate only affected documentation
generate_documentation(
    source="/src",
    output_format="markdown",
    extraction_rules={
        "include_public": True,
        "extract_examples": True
    },
    incremental=True
)
```

#### 5. Export Updated Documentation
```python
export_documentation(
    knowledge_base="api-documentation",
    output_format="docusaurus",
    output_path="/docs/api-site",
    config={
        "site_title": "API Documentation",
        "sidebar_enabled": True,
        "search_enabled": True
    }
)
```

**Result**: Updated documentation reflecting latest code changes.

---

## Workflow 5: Documentation Gap Analysis

**Goal**: Identify and fill missing documentation

### Steps:

#### 1. Analyze Code vs Documentation
```python
build_documentation_graph(
    source="/src",
    relationship_types=["calls", "imports", "extends"],
    include_code_analysis=True,
    detect_gaps=True
)
```

#### 2. Find Undocumented Code
```python
find_documentation_gaps(
    knowledge_base="api-documentation",
    source="/src",
    output_format="markdown",
    output_file="documentation_gaps.md"
)
```

#### 3. Generate Missing Documentation
```python
# Generate docs for undocumented components
generate_documentation(
    source="/src",
    output_format="markdown",
    extraction_rules={
        "include_public": True,
        "include_private": False,
        "extract_examples": True,
        "generate_signatures": True
    },
    target_gaps_only=True
)
```

#### 4. Suggest Cross-References
```python
suggest_cross_references(
    knowledge_base="api-documentation"
)
```

#### 5. Create Gap Fix Plan
```python
# Generate prioritized list of gaps
find_documentation_gaps(
    knowledge_base="api-documentation",
    source="/src",
    prioritize_by=["criticality", "usage", "complexity"]
)
```

**Result**: Comprehensive list of documentation gaps with prioritized fix plan.

---

## Workflow 6: Version Control Integration

**Goal**: Automate documentation versioning with Git

### Steps:

#### 1. Configure Version Control
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

#### 2. Set Up Automated Updates
```python
# Schedule regular updates
export_documentation(
    knowledge_base="api-documentation",
    output_format="markdown",
    output_path="/docs/generated",
    version_control={
        "enabled": True,
        "auto_commit": True,
        "branch": "generated-docs",
        "schedule": "weekly"
    }
)
```

#### 3. Track Documentation Versions
```python
# Version documentation with releases
export_documentation(
    knowledge_base="api-documentation",
    output_format="markdown",
    output_path="/docs/api-v2",
    version="2.0.0",
    version_control={
        "enabled": True,
        "tag": "api-v2.0.0",
        "create_release": True
    }
)
```

**Result**: Fully automated documentation versioning with Git integration.

---

## Best Practices for Workflows

- **Test on small subsets**: Always test documentation generation on small code sections first
- **Use version control**: Track all generated documentation in Git
- **Schedule regular updates**: Set up automated weekly/monthly updates
- **Monitor search analytics**: Use search data to improve documentation quality
- **Keep metadata consistent**: Use consistent metadata across all documents
- **Review before publishing**: Validate generated documentation before publishing
