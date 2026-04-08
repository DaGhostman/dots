# Code Intelligence Tools for Debugging

## trace_data_flow

**Purpose**: Trace how data moves through the system from source to sink.

**Usage**: Follow a variable/value through functions, modules, or services.

**Example workflow**:
```
Input user data
     │
     ▼
trace_data_flow("userInput", from="entry", to="database")
     │
     ▼
Shows: validation → sanitization → processing → storage
                    ↑
              Where sanitization was bypassed
```

**When to use**:
- Tracking down where data gets corrupted
- Finding missing validation
- Understanding unexpected transformations

## find_references

**Purpose**: Find all places code references a symbol, function, variable, or type.

**Usage**: Locate usages to understand scope of a problem or verify no side effects.

**Example workflow**:
```
find_references("parseConfig", scope="project")
     │
     ▼
Found: 5 references
  - config_loader.ts:42 (definition)
  - main.ts:15 (call)
  - tests/config.test.ts:89 (test)
     │
     ▼
One caller not handling parseConfig returning null
```

**When to use**:
- A variable is unexpectedly modified
- Checking if a "safe" change is actually safe
- Finding all callers of a function that might fail

## get_call_graph

**Purpose**: Understand execution paths and dependencies.

**Usage**: Map how code flows from entry point to current location.

**Example workflow**:
```
get_call_graph("processWebhook", depth=5)
     │
     ▼
processWebhook
  ├─→ validateSignature
  │     └─→ compareHmac (might throw)
  ├─→ parseBody
  │     └─→ JSON.parse (might throw)
  └─→ handleEvent
        └─→ dispatchToHandler
              └─→ [specific handler]
                   ↑
              The bug is in the specific handler
```

**When to use**:
- Understanding how you reached a failure point
- Finding all paths to a function
- Identifying where errors could originate

## search_code

**Purpose**: Find code patterns across the codebase.

**Usage**: Locate similar code, repeated patterns, or specific implementations.

**Example workflow**:
```
search_code("async.*fetch.*await", include="*.ts")
     │
     ▼
Found 12 matches across 4 files
     │
     ▼
3 of them missing try/catch—potential unhandled rejection source
```

**When to use**:
- Finding similar bugs in analogous code
- Locating all instances of a pattern
- Verifying consistency of error handling
