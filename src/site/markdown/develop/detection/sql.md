keywords: develop, connector, criteria
description: This page defines the detection’s criteria that are defined in a connector.

# SQL (Detection)

The goal of this part is to see how to define SQL criteria.

```yaml
connector:
  # ...
  detection: # <object>
    # ...
    criteria: # <object-array>
    - type: sql
      query: # <string>
      expectedResult: # <string>
      errorMessage: # <string>
```

## Input Properties

| Input Property | Description |
| -------------- | ----------- |
| `query` | SQL query to be executed |
| `expectedResult` | Regular expression that is expected to match the result of the SQL query |
| `errorMessage` | The message to display if the detection criterion fails |

### Example

```yaml
connector:
  detection:
    criteria:
    - type: sql
      query: SELECT @@version_comment REGEXP 'mysql' AS is_mysql;
      expectedResult: 1
      errorMessage: Not a MySQL Server
```
