#  MonitoredDeviceID,Caption,HealthState,IpmiSensorType,Name,NumericOnly,CurrentState,DeviceID,SensorType
BEGIN {
	FS = "[;]"
}

{
	#    MonitoredDeviceID = $1
	Caption = $2
	HealthState = $3
	IpmiSensorType = $4
	Name = $5
	NumericOnly = $6
	CurrentState = $7
	DeviceID = $8
	gsub(".[^.]*$", "", DeviceID)
	SensorType = $9
	if (SensorType == 11 && CurrentState == "Deassert") {
		MemoryNotPresent[DeviceID] = "True"
		print $0
	}
	if (DeviceID in Devices) {
		if (NumericOnly == 0) {
			NumericOnlyArray[DeviceID] = 0
		}
		if (Status[DeviceID] < HealthState) {
			Status[DeviceID] = HealthState
		}
		if (HealthState > 5) {
			if (StatusInformation[DeviceID] == "") {
				StatusInformation[DeviceID] = Caption
			} else {
				StatusInformation[DeviceID] = StatusInformation[DeviceID] " - " Caption
			}
		}
	} else {
		NumericOnlyArray[DeviceID] = NumericOnly
		DisplayID[DeviceID] = Caption
		gsub(/\(.*\)/, "", DisplayID[DeviceID])
		gsub(/:.*$/, "", DisplayID[DeviceID])
		if (HealthState > 0) {
			Devices[DeviceID] = DeviceID
			Status[DeviceID] = HealthState
			if (HealthState > 5) {
				StatusInformation[DeviceID] = Caption
			}
		}
	}
}

END {
	for (DeviceID in Devices) {
		if (MemoryNotPresent[DeviceID] != "True") {
			print ("MSHW;" DeviceID ";" StatusInformation[DeviceID] ";" Status[DeviceID] ";" DisplayID[DeviceID] ";" NumericOnlyArray[DeviceID] ";")
		}
	}
}

