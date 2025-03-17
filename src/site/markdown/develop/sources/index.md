keywords: source
description: In a MetricsHub connector, the sources describe how to query the monitored system to retrieve the required data and metrics.

# Sources

<div class="alert alert-warning"><span class="fa-solid fa-person-digging"></span> Documentation under construction...</div>

In a MetricsHub connector, the sources describe how to query the monitored system to retrieve the required data and metrics.

## Format

Sources can be defined in one of three locations, depending on when they need to be executed:

- **beforeAll Section**: Sources specified here are executed before any monitoring job begins, setting up the connections or performing preparatory actions needed for subsequent tasks.
- **afterAll Section**: Sources defined here are executed after all monitoring jobs are completed, typically used for cleanup, session termination, or post-processing.
- **Monitoring Job Section**: Sources included directly within a specific monitoring `<job>` (e.g., `discovery`, `collect`, or `simple`) are executed as part of that job's workflow, tailored to the specific requirements of the job. 

```yaml
connector:
  # ...
beforeAll: # <object>
  <sourceKey>: # <source-object>

monitors:
  <monitorType>: # <object>
    <job>: # <object>
      sources: # <object>
        <sourceKey>: # <source-object>

afterAll: # <object>
  <sourceKey>: # <source-object>

```

Under each source we can define a set of computes. Refer to the [Computes Section](../computes/index.md) page for more details.
