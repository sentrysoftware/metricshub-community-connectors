keywords: develop, beforeAll
description: This page defines sources that need to be executed before each monitoring job (discovery, collect and simple).

# *BeforeAll* Sources

This page describes the *BeforeAll* sources, which are executed prior to each monitoring job, including discovery, collection, and simple jobs. These preliminary sources are essential for setting up the connections or performing preparatory actions. They can also be referenced by other sources within a monitoring job.

## Format

```yaml
connector:
  # ...

beforeAll:
 <sourceName>: # <object>
```

Each source format is defined in the [Sources Section](index.md) Section page.
