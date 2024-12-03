keywords: sql, h2, database
description: The "InternalDbQuery" source allows executing SQL queries on other sources.

# Internal Db Query (Source)

```yaml
connector:
  # ...
pre: # <object>
  <sourceKey>: # <source-object>

monitors:
  <monitorType>: # <object>
    <job>: # <object>
      sources: # <object>
        <sourceKey>:
          type: internalDbQuery
          tables: <sqltable-object-array>
          - source: <string>
            alias: <string>
            columns: <sqlcolumn-object-array>
            - name: <string>
              number: <integer>
              type: <string>
          query: <string>
          computes: <compute-object-array>
```

