keywords: awk, gawk, jawk
description: The Awk source allows to execute awk scripts using MetricsHub's internal jawk engine.

# Awk (Source)

The *Awk* source enables the execution of awk scripts using **MetricsHub**'s internal jawk engine. This source is particularly useful for executing algorithmic operations. **MetricsHub**'s internal jawk engine allows to use all awk operations and also to execute various queries using any protocol **MetricsHub** Sources can use, as well as Json2Csv computes to parse the results of those queries.

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
          type: awk
          script: # <string>
          input: # <string>
          separators: # <string>
          forceSerialization: # <boolean>
          computes: # <compute-object-array>
```

## Example of Awk source

In this example, we will process an Awk script using another source as an input.

```yaml
          - type: awk
            script: "${esc.d}{file::externalFile-1}" # The script can be either an external file or directly in the connector.
            input: "${esc.d}{source::source(1)}"
```

## Example of Awk script

In this example, we will see how to implement an HTTP query and a Json2Csv opeartion using the input from another source in the **MetricsHub**'s Jawk engine.

```awk
BEGIN {
    FS=";"  # Set the field separator to handle ";" characters
    OFS=";" # Set the output field separator to ";"
}

{
    storageSystemId = $2 # The script will be executed for each line of the input source, and in this case will use the second column from these lines as the storageSystemId.

    requestArguments["method"] = "get" # Operations arguments are to be put in a map. The arguments are the same as in the equivalent sources.
    requestArguments["header"] = "${esc.d}{file::httpHeader}" # External files can be used just like in a connector, even if the awk script is in an external file itself.
    requestArguments["resultContent"] = "body"
    requestArguments["path"] = "/rest/api/storageSystem/" storageSystemId "/disks"

    httpResult = executeHttpRequest(requestArguments) # The keywords used to execute protocol queries are "executeHttpRequest", "executeIpmiReqest", "executeSnmpGet", "executeSnmpTable", "executeWbemRequest" and "executeWmiRequest".

    json2csvArguments["entryKey"] = "/disk"
    json2csvArguments["properties"] = "diskId;diskType;totalCapacity;usedCapacity"
    json2csvArguments["separator"] = ";"
    json2csvArguments["jsonSource"] = httpResult

    json2csvResult = json2csv(json2csvArguments) # Additionnaly, json2csv operations can be executed to easily parse queries results.

    print storageSystemId, json2csvResult
}
```