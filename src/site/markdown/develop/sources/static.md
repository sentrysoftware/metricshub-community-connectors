keywords: hardcoded, constant
description: To specify hard-coded content as a source for MetricsHub, use source type "static".

# Static (Source)

```yaml
connector:
  # ...
beforeAll: # <object>
  <sourceKey>: # <source-object>

monitors:
  <monitorType>: # <object>
    <job>: # <object>
      sources: # <object>
        <sourceKey>:
          type: static
          value: # <string>
          computes: # <compute-object-array>
```
