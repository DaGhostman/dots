# Error Classification by Symptom

| Symptom | Likely Category | First Actions |
|---------|-----------------|---------------|
| Crash with stack trace | Synchronous error | Read trace, find origin line |
| Intermittent failures | Race condition, timing | Add logging, check async paths |
| Memory grows unbounded | Memory leak | Heap profiling, find retained refs |
| Performance degrades | Resource exhaustion | Profile, check O complexity |
| Wrong output | Logic error | Trace data, verify assumptions |
| Works locally, fails CI | Environment difference | Compare configs, versions |
| Works in test, fails prod | Data/state difference | Check production data shape |
| TypeError: X is not a function | API contract violation | Check actual type, validate shapes |
| Cannot read property of undefined | Null/undefined handling | Find where value originates |
| Timeout errors | Resource exhaustion, network | Check timeouts, improve handling |
