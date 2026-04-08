---
name: red-team
description: Adversarial thinking and red-teaming methodology for challenging implementations and decisions before they become problems
license: MIT
---

# Red Team Skill

Systematic adversarial thinking to identify weaknesses BEFORE they become problems. Not criticism—constructive challenge to strengthen decisions.

## Core Concept

Red-teaming is the practice of rigorously challenging decisions, implementations, and plans from an adversarial perspective. It involves thinking like an attacker, critic, or pessimist to surface hidden weaknesses, flawed assumptions, and未被考虑的 risk.

The goal is NOT to shoot down ideas—it's to make them stronger through constructive challenge.

## When to Red-Team

Invoke red-teaming in these situations:

- **Architectural decisions** with significant trade-offs
- **Implementation plans** before developer starts coding
- **Business decisions** with ROI or resource implications
- **Security-sensitive** implementations
- **Any decision** where failure would be costly
- **Systems with significant unknowns** or dependencies
- **Migration or refactoring** plans with multiple failure points

## Red-Team Questions Framework

### For Requirements/Decisions

1. What could go wrong with this approach?
2. What's the worst-case scenario?
3. What are we assuming that might not be true?
4. What would make this fail at scale?
5. What edge cases are we missing?
6. What would an attacker/malicious actor do?
7. What would a competitor do to undermine this?
8. What happens if our constraints change?
9. What information are we missing that would change our decision?
10. Who has incentives opposed to this decision succeeding?

### For Implementations

1. What happens if this component is wrong?
2. What are the failure modes?
3. How does this handle load/stress?
4. What dependencies are we assuming?
5. What if the external service/API is down?
6. What data consistency issues could arise?
7. What are the rollback implications?
8. What happens during partial deployment?
9. How does this recover from cascading failures?
10. What memory/resource leaks could occur?

### For Business/Strategy

1. What's the ROI assumption and is it realistic?
2. What could kill this project?
3. What are competitors doing differently?
4. What regulatory risks exist?
5. What's the time-to-value?
6. What skills/team do we need vs have?
7. What's the total cost of ownership?
8. What happens if key personnel leave?
9. What assumptions about user behavior might be wrong?
10. What if the market/timeline shifts?

## Red-Team Process

Follow this structured approach for effective red-teaming:

```
1. PRESENT   - State the decision/implementation clearly
2. CHALLENGE - Ask adversarial questions (see framework above)
3. EVALUATE  - Assess the weaknesses identified
4. STRENGTHEN- Propose mitigations or alternatives
5. DOCUMENT  - Record the adversarial findings
```

### Step Details

**1. PRESENT**
- State the decision or implementation in one sentence
- Identify the success criteria
- Note the constraints and context

**2. CHALLENGE**
- Use the questions framework above
- Assume the role of attacker, pessimist, or competitor
- Don't accept "it'll be fine" or "that won't happen"
- Push until you find real weaknesses

**3. EVALUATE**
- Rate each weakness by Severity (Critical/High/Medium/Low)
- Rate likelihood of occurrence (High/Medium/Low)
- Calculate Risk Score = Severity × Likelihood
- Focus on High and Critical risks first

**4. STRENGTHEN**
- For each high/critical risk, propose a mitigation
- Consider alternatives that avoid the weakness
- Document what should change in the approach

**5. DOCUMENT**
- Record findings in the output format below
- Include all challenges even if mitigated
- Make it actionable for the decision-maker

## Output Format for Red-Team Review

```markdown
## Red-Team Review: [Decision/Implementation Name]

### Original Proposal
[Brief summary of what was proposed]

### Adversarial Challenges
| Challenge | Severity | Likelihood | Risk Score |
|-----------|----------|------------|------------|
| [What could go wrong] | Critical/High/Medium/Low | High/Medium/Low | [S×L] |

### Assumptions Challenged
1. [Assumption 1] → [Why it might be wrong]
2. [Assumption 2] → [Why it might be wrong]
3. [Assumption 3] → [Why it might be wrong]

### Weaknesses Identified
1. **Issue**: [Description]
   **Impact**: [What happens if this fails]
   **Mitigation**: [How to address this]

### Recommendations
1. [Based on adversarial findings]
2. [Specific actionable changes]

### Sign-Off
- [ ] Threats adequately addressed
- [ ] Mitigations assigned and tracked
- [ ] Decision maker aware of residual risks
```

## Integration Points

The red-team skill integrates into the workflow at these points:

- **Orchestrator**: Invoke red-team before finalizing plans
- **Architect**: Red-team before signing off on designs
- **Developer**: Self-red-team before implementing
- **Business Analyst**: Red-team requirements before specification

Use when:
- There are significant unknowns or trade-offs
- Previous attempts have failed
- Team is aligned too quickly (confirmation bias)
- Decision has irreversible consequences

## Adversarial Techniques

### Pre-Mortem Analysis

Before implementation, imagine the project has catastrophically failed. Work backwards to understand why.

```
"This project has failed completely. What happened?"
→ "The deployment broke production."
→ "Because the migration script had a bug."
→ "Because we didn't test the rollback."
→ ...
```

### ASSI (Assume Stupid Attacker)

Assume the attacker has the same information you do. What could they exploit?

- If source code is private, assume it's public
- If API is internal, assume it's public
- If credentials are rotated, assume they're compromised

### Five Whys (Adversarial)

Keep asking "And then what?" until you reach a fundamental weakness.

```
"Why would this fail?" → "API timeout."
"And then what?" → "Request queue builds up."
"And then what?" → "Memory exhausted."
"And then what?" → "Service crashes."
"And then what?" → "All requests fail."
```

### Prey on Preferences

If the decision-maker or team strongly prefers an option, rigorously question that option. People overweight their preferred choices and underweight risks.

### Kill the Feature

Ask: What would it take for this feature to be actively harmful?

- Could it hurt users?
- Could it damage trust?
- Could it create liability?
- Could it enable abuse?

If you can make it harmful, you understand its true risk surface.

## Quick Red-Team Checklist

Before any significant decision, run through these:

- [ ] Worst-case scenario defined and understood
- [ ] Assumptions explicitly stated and challenged
- [ ] Failure modes identified
- [ ] External dependencies failure planned
- [ ] Rollback/recovery strategy defined
- [ ] Load/stress cases considered
- [ ] Security implications reviewed
- [ ] Edge cases explored
- [ ] Competitor/adversary perspective considered
- [ ] Residual risks documented

## Common Red-Team Findings

Watch out for these frequently missed issues:

| Finding | Description |
|---------|-------------|
| **Dependency Blindness** | Assuming external services/APIs are reliable |
| **Happy Path Thinking** | Only considering nominal execution |
| **Scope Creep** | Underestimating complexity of integration |
| **Data Gravity** | Ignoring how data movement affects performance |
| **Human Factors** | Training, adoption, and fatigue issues |
| **Second-Order Effects** | Not tracing through consequences |
| **Rollback Gap** | No clear path to undo the change |

## Examples

### Example 1: API Integration

**Decision**: Use third-party payment processor API

**Red-Team Challenges**:
- What if the API is down for 1 hour? 1 day?
- What if API response times triple?
- What if API pricing model changes?
- What if API keys are compromised?
- What if API changes breaking format?
- What if we exceed rate limits?

**Outcome**: Add circuit breaker, fallback processor, and rate limit monitoring.

### Example 2: Database Migration

**Decision**: Migrate from PostgreSQL to MySQL

**Red-Team Challenges**:
- What data types don't translate?
- What queries will break?
- What's the rollback if migration fails at 50%?
- How long will downtime be?
- What about data in flight during migration?
- What about backup verification?

**Outcome**: Phased migration with dual-write period, automated query translation testing.

---

Use this skill to strengthen decisions through rigorous adversarial challenge. The goal is not to find problems for the sake of it, but to make implementations more resilient before they face real adversaries.
