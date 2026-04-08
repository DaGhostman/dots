# Quality Assurance

## Verification Strategies

### 1. Independent Verification

```
Developer writes code → Reviewer checks → Both address issues
```

**Best for**: Security-critical, complex logic, API changes

### 2. Two-Pass Review

```
First pass: Logic/correctness
Second pass: Style/consistency
```

**Best for**: Large changes, multiple concerns

### 3. Specification Verification

```
Spec defines expected behavior → Implementation tested against spec
```

**Best for**: Feature additions, protocol implementations

### 4. Integration Verification

```
Components work individually → Tested together
```

**Best for**: Multi-component changes

---

## QA Checklist for Orchestrated Work

- [ ] Each subtask has explicit acceptance criteria
- [ ] Output format agreed before delegation
- [ ] Reviewer is independent of developer
- [ ] All agent outputs documented
- [ ] Conflicts resolved with rationale
- [ ] Final integration tested
- [ ] Nothing lost in aggregation
