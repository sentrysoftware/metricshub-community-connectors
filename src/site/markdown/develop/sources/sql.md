keywords: sql, database
description: Use the "SQL" source type to query a relational database with an SQL query in MetricsHub.

# SQL (Source)

The *SQL* source type in MetricsHub allows you to execute SQL queries against a relational database.

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
          type: sql
          query: # <string>
          forceSerialization: # <boolean>
          executeForEachEntryOf: # <object>
            source: # <string>
            concatMethod: # oneOf [ <enum>, <object> ] | possible values for <enum> : [ list, json_array, json_array_extended ]
              concatStart: # <string>
              concatEnd: # <string>
          computes: # <compute-object-array>
```