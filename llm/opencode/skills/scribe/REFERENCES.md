# Scribe - Complete Reference

## RAG Operations Reference

### Session Management

#### Create New Session
```python
# Start a new conversation session
create_session(
    title="Q1 2024 Architecture Review",
    description="Review of system architecture and planning for Q1 initiatives",
    metadata={
        "team": "platform",
        "project": "architecture",
        "quarter": "Q1-2024"
    }
)
```

#### End Session
```python
# Close and finalize a session
end_session(
    session_id="sess_20240319_arch_review",
    summary="Completed architecture review. Key decisions: adopted event sourcing, delayed microservices migration."
)
```

### Memory Operations

#### Add Structured Memory
```python
# Add a memory with rich metadata
add_memory(
    content="Decided to adopt PostgreSQL as primary database instead of MongoDB for ACID compliance",
    category="technical_decision",
    tags=["database", "postgresql", "architecture", "decision"],
    metadata={
        "session_id": "sess_20240319_arch_review",
        "decision_type": "technology_selection",
        "alternatives": ["MongoDB", "MySQL", "DynamoDB"],
        "rationale": "Need for complex queries and transactional integrity",
        "owners": ["alex", "sarah"],
        "priority": "high",
        "vote": "unanimous"
    }
)
```

#### Search Memories
```python
# Semantic search across all memories
search_memories(
    query="database selection criteria",
    filters={
        "category": "technical_decision",
        "tags": ["database"],
        "date_range": {"start": "2024-01-01", "end": "2024-03-31"}
    },
    limit=10,
    include_scores=True
)

# Filter by specific session
search_memories(
    query="migration strategy",
    filters={"session_id": "sess_20240319_arch_review"},
    limit=5
)
```

#### Update Memory
```python
# Modify an existing memory
update_memory(
    memory_id="mem_db_decision_001",
    content="Updated: Decided to adopt PostgreSQL with read replicas for scale",
    metadata={"status": "implemented", "implementation_date": "2024-04-15"}
)
```

#### Delete Memory
```python
# Remove outdated or incorrect memory
delete_memory(
    memory_id="mem_old_proposal_002",
    reason="superseded_by_new_decision"
)
```

### Knowledge Graph Operations

#### Build Knowledge Graph
```python
# Construct knowledge graph from memories
build_knowledge_graph(
    session_id="sess_20240319_arch_review",
    entity_types=["person", "technology", "decision", "project"],
    relationship_types=["decides", "uses", "influences", "replaces"],
    output_format="json"
)

# Build cross-session graph
build_knowledge_graph(
    session_ids=["sess_20240115", "sess_20240220", "sess_20240319"],
    entity_types=["technology", "decision"],
    min_occurrences=2,
    output_file="knowledge_graph_q1_2024.json"
)
```

#### Query Knowledge Graph
```python
# Find relationships between entities
query_knowledge_graph(
    entity="PostgreSQL",
    relationship_types=["uses", "replaces", "competes_with"],
    depth=2
)

# Find all decisions by a person
query_knowledge_graph(
    entity="alex",
    relationship_types=["decides", "proposes", "votes_on"],
    entity_type="person"
)
```

#### Export Knowledge
```python
# Export all memories in structured format
export_knowledge(
    session_id="sess_20240319_arch_review",
    format="markdown",
    output_file="architecture_review_2024-03-19.md",
    include_graph=True
)

# Export knowledge graph
export_knowledge(
    format="graphml",
    output_file="knowledge_graph.json",
    include_entities=True,
    include_relationships=True
)

# Export to external format
export_knowledge(
    format="csv",
    output_file="memories_export.csv",
    fields=["content", "category", "tags", "date", "session_id"]
)
```

### Maintenance Operations

#### Deduplicate Memories
```python
# Find and merge duplicate memories
deduplicate_memories(
    similarity_threshold=0.85,
    merge_strategy="combine_with_timestamps",
    review_required=True,
    output_file="dedup_report.json"
)

# Auto-deduplicate with confirmation
deduplicate_memories(
    similarity_threshold=0.90,
    merge_strategy="keep_highest_priority",
    auto_merge=True
)
```

#### Consolidate Memories
```python
# Group and summarize memories by category
consolidate_memories(
    category="technical_decision",
    time_range={"start": "2024-01-01", "end": "2024-03-31"},
    output_format="summary",
    output_file="q1_decisions_summary.md"
)
```

## Memory Categories Reference

- `technical_decision` - Technology and architecture decisions
- `action_item` - Tasks with owners and due dates
- `discussion` - Technical discussions and debates
- `idea` - New ideas and proposals
- `lesson_learned` - Lessons from experiments or incidents
- `meeting_notes` - Meeting summaries and outcomes
- `alternatives` - Options considered for decisions
- `implementation_plan` - Step-by-step implementation details
- `infrastructure` - Knowledge base setup and configuration

## Priority Levels Reference

- `high` - Critical decisions, urgent actions
- `medium` - Important but not urgent
- `low` - Nice to know, future reference

## Tag Naming Conventions

- Use lowercase with underscores: `database`, `api_design`, `security`
- Be specific: `postgresql_migration` not just `db`
- Include context: `frontend_performance` not just `performance`
- Create tag hierarchies: `aws/lambda`, `aws/s3`
- Recommended: 3-7 tags per memory

## Session Naming Convention

Format: `YYYYMMDD_type_topic`

Examples:
- `20240319_meeting_architecture_review`
- `20240319_decision_event_sourcing`
- `20240319_team_sync_platform`

## Quick Reference

### Key Tools
- `create_session()` - start new conversation sessions
- `add_memory()` - store structured memories
- `search_memories()` - retrieve past information
- `end_session()` - finalize session with summary
- `build_knowledge_graph()` - construct entity relationships
- `export_knowledge()` - package memories for external use
- `deduplicate_memories()` - identify and merge duplicates
- `consolidate_memories()` - group and summarize by category

### Search Tips
- Use specific tags: `search_memories(query="database", tags=["postgresql"])`
- Filter by session: `search_memories(query="migration", session_id="sess_20240319_*")`
- Combine filters: `search_memories(query="performance", filters={"category": "lesson_learned", "priority": "high"})`
