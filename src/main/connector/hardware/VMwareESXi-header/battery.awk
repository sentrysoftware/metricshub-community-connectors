BEGIN {
	FS = "[;]"
}

#IpmisensorID contains at least 3 dots
$5 ~ /.*\..*\..*\.*/ {
	IPMISensorID = $5
	HealthState = $2
	SensorName = $4
	ID = IPMISensorID
	gsub(".[^.]*$", "", ID)
	# if we've already found a status for this ID, then try and find a common sensor name root
	# We're going to assume the first 5 characters are the same to avoid a null DisplayID
	# Note this will only be run if a battery has 2 or more sensors
	if (ID in status) {
		matchLength = 5
		for (i = 5; i <= length(DisplayID[ID]); i++) {
			if (substr(DisplayID[ID], 5, i) == substr(SensorName, 5, i)) {
				matchLength = i
			}
		}
		DisplayID[ID] = substr(DisplayID[ID], 1, matchLength)
		gsub(/:? *$/, "", DisplayID[ID])
	} else {
		DisplayID[ID] = SensorName
	}
	# See if we already have processed a valid statusInformation for this component
	# i.e. there's more than one fault, do a worse than and append the sensor ID
	if (ID in statusInformation) {
		if (status[ID] < HealthState) {
			status[ID] = (HealthState)
		}
		if (HealthState > 5) {
			if (statusInformation[ID] == "") {
				statusInformation[ID] = SensorName
			} else {
				statusInformation[ID] = (statusInformation[ID] " - " SensorName)
			}
		}
	} else {
		if (HealthState > 0) {
			status[ID] = HealthState
			# If we haven't seen a fault, check if this sensor state and set statusInformation if there's an issue
		}
		if (HealthState > 5) {
			statusInformation[ID] = SensorName
		}
	}
}

END {
	for (ID in status) {
		print ("MSHW;" ID ";" DisplayID[ID] ";" status[ID] ";" statusInformation[ID] ";")
	}
}

