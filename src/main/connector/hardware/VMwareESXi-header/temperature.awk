BEGIN {
	FS = ";"
}

{
	BaseUnits = $1
	Caption = $2
	CurrentReading = $3
	DeviceID = $4
	HealthState = $5
	UpperThresholdNonCritical = $6
	UpperThresholdCritical = $7
	SensorType = $8
	if (length(CurrentReading) > 2) {
		if (UpperThresholdNonCritical == "" && UpperThresholdCritical == "") {
			print "MSHW;" BaseUnits ";" Caption ";" CurrentReading ";" DeviceID ";" HealthState ";;;" SensorType ";"
		} else {
			print "MSHW;" BaseUnits ";" Caption ";" CurrentReading ";" DeviceID ";;" UpperThresholdNonCritical ";" UpperThresholdCritical ";" SensorType ";"
		}
	} else {
		print "MSHW;" BaseUnits ";" Caption ";;" DeviceID ";" HealthState ";;;" SensorType ";"
	}
}

