keywords: develop, connector, afterAll
description: This page defines sources that need to be executed after the monitoring jobs (discovery, collect and simple).

# *AfterAll* Sources

This page outlines the sources which are executed after each monitoring job, including discovery, collect, and simple jobs. These sources play a crucial role in finalizing processes, such as closing sessions, cleaning up temporary resources, or performing other post-monitoring activities.

## Format

```yaml
connector:
  # ...

afterAll:
 <sourceName>: # <object>
```

Each source format is defined in the [Sources Section](index.md) Section page.
