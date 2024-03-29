BEGIN {
	FS = ";"
}

# Skip sensors that mention "Max" or "Average" (they are not real sensors anyway)
($2 ~ " Max" || $2 ~ " Average") {
	next
}

# Skip sensors from it8721f, because this chip is known to provide false values
($3 ~ "it8721f") {
	next
}

# Distance to TjMax sensors value are stored in an array to be retrieved later
($2 ~ / Distance to TjMax$/) {
	name = $2
	gsub(/ Distance to TjMax$/, "", name)
	distanceToThreshold[name] = $4
	next
}

{
	sensorId = $1
	sensorName[sensorId] = $2
	sensorParent[sensorId] = $3
	sensorValue[sensorId] = $4
	parentId[sensorId] = $5
	parentType[sensorId] = $7
}

# Now process what we got in our arrays and join with the thresholds
END {
	for (sensorId in sensorName) {
		# Retrieve the sensor properties from the arrays
		name = sensorName[sensorId]
		parent = sensorParent[sensorId]
		value = sensorValue[sensorId]
		parentDeviceId = parentId[sensorId]
		deviceType = parentType[sensorId]
		# Clean-up deviceType
		if (deviceType == "Cpu") {
			deviceType = "CPU"
		} else if (deviceType ~ "Gpu") {
			deviceType = "GPU"
		} else if (deviceType == "Psu") {
			deviceType = "Power Supply"
		}
		# Do we have a distance to TjMax?
		distanceToTjMax = distanceToThreshold[name]	# not sensorId!
		if (distanceToTjMax != "") {
			wThres = ""
			aThres = value + distanceToTjMax
		} else {
			# If no threshold from TjMax, try to figure something out
			if (deviceType == "CPU") {
				wThres = 80
				aThres = 90
			} else if (deviceType == "GPU") {
				wThres = 85
				aThres = 100
			} else if (parentDeviceId ~ "^/(ssd|nvme)") {
				wThres = 50
				aThres = 70
			} else if (parentDeviceId ~ "^/hdd") {
				wThres = 45
				aThres = 60
			} else if (deviceType == "Motherboard") {
				wThres = 40
				aThres = 45
			} else if (deviceType == "Memory" || deviceType == "Network") {
				wThres = 50
				aThres = 60
			} else if (deviceType == "Power Supply") {
				wThres = 55
				aThres = 65
			} else {
				wThres = ""
				aThres = ""
			}
		}
		# Build label
		label = deviceType " " parentDeviceId
		if (name != "Temperature" && name != "") {
			label = label " - " name
		}
		# Print
		print "MSHW;" sensorId ";" label ";" wThres ";" aThres ";"
	}
}

