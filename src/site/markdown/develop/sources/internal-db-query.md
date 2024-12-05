keywords: internal, database, query, h2
description: The Internal DB Query source allows to perform database queries using MetricsHub's internal database engine.

# Internal DB Query Source

The *Internal DB Query* source enables the execution of SQL queries using **MetricsHub**'s internal database engine, powered by H2. This source is particularly useful for accessing and manipulating data within MetricsHub's internal database to facilitate custom monitoring jobs.

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
          type: interalDbQuery
          tables: <interaldb-query-object-array>
          - source: <string>
            alias: <string>
            columns: <sqlcolumn-object-array>
            - name: <string>
              number: <integer>
              type: <string>
          query: <string>
          computes: <compute-object-array>
```

