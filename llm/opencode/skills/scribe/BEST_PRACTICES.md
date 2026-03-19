# Scribe - Best Practices

## Tagging & Metadata

### Always Tag Memories with Context

```python
add_memory(
    content="...",
    tags=["specific", "descriptive", "searchable"],  # 3-7 tags recommended
    metadata={
        "session_id": "sess_YYYYMMDD_name",  # Required
        "category": "technical_decision",  # Required
        "priority": "high|medium|low",  # Optional
        "date": "2024-03-19",  # Optional (auto-generated)
    }
)
```

### Tag Naming Conventions

- **Use lowercase with underscores**: `database`, `api_design`, `security`
- **Be specific**: `postgresql_migration` not just `db`
- **Include context**: `frontend_performance` not just `performance`
- **Create tag hierarchies**: `aws/lambda`, `aws/s3`
- **Recommended**: 3-7 tags per memory for optimal searchability

### Essential Metadata Fields

```python
metadata={
    "session_id": "Required - links to parent session",
    "category": "Required - type of content",
    "priority": "Optional - high/medium/low",
    "owners": ["Optional - responsible parties"],
    "decision_type": "Optional - for technical decisions",
    "rationale": "Optional - why this decision was made",
    "alternatives": "Optional - other options considered",
    "status": "Optional - current state of item",
    "due_date": "Optional - for action items"
}
```

---

## Structured Formats

### Use Consistent Formats for Content

#### Markdown Template for Technical Decisions

```markdown
## Technical Decision: Database Selection

### Decision
Adopt PostgreSQL as primary database

### Rationale
- ACID compliance required
- Complex query support
- Team expertise

### Alternatives Considered
- MongoDB (NoSQL, flexible schema)
- MySQL (relational, less feature-rich)
- DynamoDB (serverless, limited queries)

### Decision Makers
- Alex (Tech Lead)
- Sarah (Architect)

### Date
2024-03-19

### Status
Implemented
```

#### JSON Structure for Programmatic Access

```json
{
  "type": "technical_decision",
  "title": "Database Selection",
  "decision": "PostgreSQL",
  "rationale": ["ACID compliance", "Complex queries"],
  "alternatives": ["MongoDB", "MySQL"],
  "owners": ["alex", "sarah"],
  "date": "2024-03-19",
  "status": "implemented"
}
```

---

## Deduplication Cycles

### Schedule Regular Deduplication

- **Daily**: After major meetings or decision sessions
- **Weekly**: End of week consolidation
- **Monthly**: Comprehensive knowledge base review

### Deduplication Workflow

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

### Deduplication Tips

- **High confidence (>0.9)**: Auto-merge with combine strategy
- **Medium confidence (0.8-0.9)**: Manual review required
- **Low confidence (<0.8)**: Skip or investigate further
- **Always review**: Never auto-merge critical decisions without review

---

## Session Lifecycle Management

### Session Creation Best Practices

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

### Session Naming Convention

Format: `YYYYMMDD_type_topic`

Examples:
- `20240319_meeting_architecture_review`
- `20240319_decision_event_sourcing`
- `20240319_team_sync_platform`

### Session Closure Best Practices

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

### Session Management Tips

- **Always end sessions**: Don't leave sessions open
- **Write clear summaries**: Include key decisions and action items
- **Track action items**: Link to owners and due dates
- **Export promptly**: Generate notes within 24 hours while fresh

---

## Knowledge Graph Maintenance

### Regular Graph Updates

- **Update after each session**: Add new entities and relationships
- **Review quarterly**: Check for stale connections
- **Archive old sessions**: Preserve key relationships while cleaning up

### Graph Maintenance Workflow

```python
# Update graph after session
build_knowledge_graph(
    session_id="sess_20240319_arch_review",
    update_existing=True
)

# Clean up stale nodes
query_knowledge_graph(
    entity_type="decision",
    filter={"last_updated": "< 2023-01-01"}
)
```

### Knowledge Graph Best Practices

- **Define entity types**: Be consistent (person, technology, decision, project)
- **Standardize relationships**: Use clear relationship types (decides, uses, impacts)
- **Include metadata**: Store relevant context with entities
- **Query regularly**: Use graph to discover connections and insights

---

## Content Quality Guidelines

### Memory Content Best Practices

1. **Be specific**: Include concrete details, not vague statements
2. **Provide context**: Explain why something matters
3. **Link related items**: Reference related decisions and discussions
4. **Use structured format**: Follow templates for consistency
5. **Include trade-offs**: Document pros and cons of decisions

### Example of Good vs Bad Memory

**Bad:**
```python
add_memory(
    content="We talked about databases",
    category="discussion",
    tags=["db"]
)
```

**Good:**
```python
add_memory(
    content="Decided to adopt PostgreSQL as primary database for ACID compliance and complex query support",
    category="technical_decision",
    tags=["database", "postgresql", "architecture", "decision"],
    metadata={
        "session_id": "sess_20240319_arch_review",
        "rationale": "Need for ACID compliance and complex queries",
        "alternatives": ["MongoDB", "MySQL", "DynamoDB"],
        "priority": "high"
    }
)
```

---

## Search Optimization

### Search Tips for Better Results

```python
# Use specific tags
search_memories(query="database", tags=["postgresql"])

# Filter by session
search_memories(query="migration", session_id="sess_20240319_*")

# Combine filters
search_memories(
    query="performance",
    filters={
        "category": "lesson_learned",
        "priority": "high"
    }
)

# Use date ranges
search_memories(
    query="architecture",
    filters={
        "date_range": {"start": "2024-01-01", "end": "2024-03-31"}
    }
)
```

### Search Best Practices

- **Be specific**: Use detailed queries with context
- **Combine filters**: Use multiple filters for precision
- **Iterate**: Refine searches based on results
- **Save patterns**: Note successful search patterns for reuse

---

## Consistency Guidelines

### The Power of Consistency

The power of Scribe is in **consistency** and **rich metadata**. Tag everything well, and your knowledge base will become an invaluable resource over time.

### Consistency Checklist

- [ ] Use consistent session naming format
- [ ] Apply tags consistently (3-7 per memory)
- [ ] Include all essential metadata fields
- [ ] Follow content templates for decisions
- [ ] End sessions with summaries
- [ ] Run regular deduplication cycles
- [ ] Update knowledge graph after sessions
- [ ] Export notes within 24 hours

### Common Mistakes to Avoid

- ❌ Vague tags: `db` instead of `postgresql_migration`
- ❌ Missing metadata: Forgetting session_id or category
- ❌ Incomplete sessions: Not ending sessions with summaries
- ❌ Over-tagging: Using 20+ tags per memory
- ❌ Under-tagging: Using only 1-2 tags per memory
- ❌ Inconsistent formats: Mixing different content structures
- ❌ Delayed export: Waiting weeks to export notes

---

## Getting Started Checklist

### First Time Setup

```python
# Create your first session
create_session(
    title="20240319_first_session",
    description="Initial knowledge base session"
)

# Add your first memory
add_memory(
    content="Starting knowledge base for team",
    category="infrastructure",
    tags=["knowledge_base", "setup"]
)
```

### Daily Workflow

1. Create session at start of meeting/discussion
2. Add memories throughout the session
3. End session with summary and action items
4. Export notes if needed

### Weekly Workflow

1. Review and deduplicate memories
2. Consolidate by category
3. Update knowledge graph
4. Export weekly summary

---

## Remember

**Consistency is key.** The more consistently you use Scribe with rich metadata and proper tagging, the more valuable your knowledge base becomes over time. Start small, build the habit, and expand as you see the value.
