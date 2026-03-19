# Scribe - Workflows

## Meeting Notes Workflow

**Scenario:** Weekly team sync meeting

### Step 1: Create Session
```python
create_session(
    title="20240319_team_sync_platform",
    description="Weekly platform team sync - sprint planning and blockers",
    metadata={
        "type": "meeting",
        "team": "platform",
        "participants": ["alex", "sarah", "mike", "jenny"]
    }
)
```

### Step 2: Add Memories During Meeting
```python
# Decision memory
add_memory(
    content="Team agreed to postpone GraphQL migration to Q2 to focus on performance improvements",
    category="decision",
    tags=["graphql", "migration", "sprint_planning", "q2"],
    metadata={
        "session_id": "sess_20240319_team_sync_platform",
        "decision_type": "scheduling",
        "rationale": "Performance issues blocking user experience",
        "vote": "unanimous",
        "priority": "medium"
    }
)

# Action item memory
add_memory(
    content="Alex to create performance profiling report for API endpoints",
    category="action_item",
    tags=["performance", "profiling", "action_item"],
    metadata={
        "session_id": "sess_20240319_team_sync_platform",
        "owner": "alex",
        "due_date": "2024-03-26",
        "priority": "high",
        "status": "pending"
    }
)

# Technical discussion memory
add_memory(
    content="Discussed caching strategy for user profile data. Agreed to implement Redis cache with 5-minute TTL",
    category="technical_discussion",
    tags=["caching", "redis", "performance", "user_profile"],
    metadata={
        "session_id": "sess_20240319_team_sync_platform",
        "decision": "Redis cache with 5-minute TTL",
        "alternatives": ["in-memory cache", "CDN caching"],
        "rationale": "Balance between freshness and performance"
    }
)
```

### Step 3: End Session with Summary
```python
end_session(
    session_id="sess_20240319_team_sync_platform",
    summary="Postponed GraphQL migration to Q2. Action items: Alex to profile APIs, Sarah to design Redis cache. Next sync: 2024-03-26",
    action_items=[
        {"task": "Create performance profiling report", "owner": "alex", "due": "2024-03-26"},
        {"task": "Design Redis cache implementation", "owner": "sarah", "due": "2024-03-28"}
    ]
)
```

### Step 4: Export Meeting Notes
```python
export_knowledge(
    session_id="sess_20240319_team_sync_platform",
    format="markdown",
    output_file="meeting_notes_2024-03-19.md"
)
```

---

## Technical Decision Tracking Workflow

**Scenario:** Architecture decision for event sourcing

### Step 1: Initial Discussion Session
```python
create_session(
    title="20240315_decision_event_sourcing",
    description="Evaluation of event sourcing for order processing system",
    metadata={
        "type": "decision",
        "project": "order_system",
        "participants": ["alex", "sarah", "mike"]
    }
)
```

### Step 2: Capture Decision Process
```python
# Add alternatives considered
add_memory(
    content="Explored three approaches: 1) Event sourcing with CQRS, 2) Traditional CRUD with audit log, 3) Event sourcing without CQRS",
    category="alternatives",
    tags=["event_sourcing", "architecture", "alternatives"],
    metadata={
        "session_id": "sess_20240315_decision_event_sourcing",
        "alternatives_list": [
            {"id": "A1", "name": "Event sourcing with CQRS", "pros": ["Perfect audit trail", "Temporal queries"], "cons": ["High complexity", "Learning curve"]},
            {"id": "A2", "name": "Traditional CRUD", "pros": ["Simple", "Familiar"], "cons": ["Limited history", "No temporal queries"]},
            {"id": "A3", "name": "Event sourcing without CQRS", "pros": ["Audit trail", "Simpler than CQRS"], "cons": ["Read model complexity"]}
        ]
    }
)

# Add final decision
add_memory(
    content="Chose Event sourcing with CQRS for order processing system due to regulatory requirements for complete audit trail and need for temporal queries",
    category="technical_decision",
    tags=["event_sourcing", "cqrs", "audit", "order_system", "decision"],
    metadata={
        "session_id": "sess_20240315_decision_event_sourcing",
        "decision_type": "architecture",
        "selected_alternative": "A1",
        "rationale": "Regulatory compliance requires complete audit trail. Business needs temporal queries for order history.",
        "decision_makers": ["alex", "sarah", "mike"],
        "vote": "unanimous",
        "priority": "high",
        "impacted_systems": ["order_processing", "billing", "compliance"],
        "implementation_timeline": "Q2 2024"
    }
)

# Add implementation notes
add_memory(
    content="Implementation plan: 1) Set up event store (EventStoreDB), 2) Create order aggregate, 3) Build read models, 4) Implement projections",
    category="implementation_plan",
    tags=["event_sourcing", "implementation", "plan"],
    metadata={
        "session_id": "sess_20240315_decision_event_sourcing",
        "steps": [
            {"step": 1, "task": "Set up EventStoreDB cluster", "owner": "mike"},
            {"step": 2, "task": "Create order aggregate with events", "owner": "alex"},
            {"step": 3, "task": "Build read models for order history", "owner": "sarah"},
            {"step": 4, "task": "Implement projections for reporting", "owner": "mike"}
        ],
        "estimated_effort": "6 weeks"
    }
)
```

### Step 3: Build Knowledge Graph
```python
build_knowledge_graph(
    session_id="sess_20240315_decision_event_sourcing",
    entity_types=["person", "technology", "decision", "system"],
    relationship_types=["decides", "uses", "impacts", "implements"],
    output_format="json"
)
```

### Step 4: Create ADR Document
```python
export_knowledge(
    session_id="sess_20240315_decision_event_sourcing",
    format="markdown",
    output_file="adr_001_event_sourcing.md"
)
```

---

## Knowledge Base Building Workflow

**Scenario:** Building a team knowledge base over multiple sessions

### Step 1: Initial Session Setup
```python
# Create knowledge base foundation
create_session(
    title="20240101_knowledge_base_init",
    description="Initial setup of team knowledge base",
    metadata={
        "type": "infrastructure",
        "project": "knowledge_management"
    }
)

# Add knowledge base structure
add_memory(
    content="Knowledge base structure defined with categories: technical_decisions, architectural_patterns, lessons_learned, team_processes, onboarding",
    category="infrastructure",
    tags=["knowledge_base", "structure", "categories"],
    metadata={
        "session_id": "sess_20240101_knowledge_base_init",
        "categories": [
            "technical_decisions",
            "architectural_patterns",
            "lessons_learned",
            "team_processes",
            "onboarding"
        ]
    }
)
```

### Step 2: Regular Knowledge Capture
```python
# After each meeting/decision, add relevant memories
# Example: After architecture review
add_memory(
    content="Learned that database sharding should be considered only after horizontal scaling fails. Start with read replicas first.",
    category="lessons_learned",
    tags=["database", "scaling", "sharding", "lesson"],
    metadata={
        "session_id": "sess_20240215_arch_review",
        "context": "Database scaling discussion",
        "applicable_to": ["relational_databases", "distributed_systems"]
    }
)
```

### Step 3: Monthly Consolidation
```python
# Consolidate memories by category
consolidate_memories(
    category="technical_decisions",
    time_range={"start": "2024-02-01", "end": "2024-02-29"},
    output_format="markdown",
    output_file="knowledge_base_feb_2024.md"
)
```

### Step 4: Quarterly Knowledge Graph Update
```python
# Build comprehensive knowledge graph
build_knowledge_graph(
    session_ids=["sess_20240101_*", "sess_20240201_*", "sess_20240301_*"],
    entity_types=["technology", "decision", "pattern", "lesson"],
    relationship_types=["uses", "replaces", "improves", "conflicts_with"],
    min_occurrences=2,
    output_file="knowledge_graph_q1_2024.json"
)
```

### Step 5: Export for Onboarding
```python
export_knowledge(
    format="markdown",
    output_file="team_onboarding_knowledge.md",
    categories=["technical_decisions", "lessons_learned", "onboarding"],
    include_graph=True
)
```

---

## Daily Workflow

1. **Start**: Create session at beginning of meeting/discussion
2. **During**: Add memories throughout the session as topics arise
3. **End**: Finalize session with summary and action items
4. **Export**: Generate notes if needed for distribution

## Weekly Workflow

1. **Review**: Go through all sessions from the week
2. **Deduplicate**: Run deduplication to merge similar memories
3. **Consolidate**: Group memories by category
4. **Update**: Refresh knowledge graph with new relationships
5. **Export**: Generate weekly summary for team

## Monthly Workflow

1. **Comprehensive Review**: Full knowledge base audit
2. **Archive**: Move old sessions to archive while preserving key insights
3. **Consolidate**: Create monthly summary documents
4. **Graph Update**: Build cross-session knowledge graph
5. **Quality Check**: Validate metadata consistency and tag usage

---

## Deduplication Workflow

### Manual Review Workflow
```python
# Find potential duplicates
duplicates = deduplicate_memories(
    similarity_threshold=0.80,
    review_required=True
)

# Review and merge
for group in duplicates['groups']:
    if group['confidence'] > 0.9:
        merge_memories(group['ids'], strategy="combine")
    else:
        mark_for_review(group['ids'])
```

### Auto-Deduplication Workflow
```python
# Auto-deduplicate with safe defaults
deduplicate_memories(
    similarity_threshold=0.90,
    merge_strategy="keep_highest_priority",
    auto_merge=True
)
```

---

## Session Lifecycle Management

### Session Creation Template
```python
create_session(
    title="[DATE] [TYPE] - [TOPIC]",
    description="Brief description of session purpose",
    metadata={
        "type": "meeting|decision|brainstorm|review",
        "team": "team_name",
        "project": "project_name"
    }
)
```

### Session Closure Template
```python
end_session(
    session_id="sess_20240319_arch_review",
    summary="Key outcomes and next steps",
    action_items=[
        {"task": "Create POC for event sourcing", "owner": "alex", "due": "2024-04-01"},
        {"task": "Document migration strategy", "owner": "sarah", "due": "2024-04-05"}
    ]
)
```

---

## Knowledge Graph Maintenance Workflow

### After Session Update
```python
# Update graph after session
build_knowledge_graph(
    session_id="sess_20240319_arch_review",
    update_existing=True
)
```

### Quarterly Cleanup
```python
# Find stale nodes
query_knowledge_graph(
    entity_type="decision",
    filter={"last_updated": "< 2023-01-01"}
)

# Archive or update stale connections
```
