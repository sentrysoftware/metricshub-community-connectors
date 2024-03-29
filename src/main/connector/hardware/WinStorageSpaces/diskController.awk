BEGIN {
	FS = ";"
}

{
	__Path = $1
	busType = $2
	deviceId = $3
	firmwareVersion = $4
	mediaType = $5
	model = $6
	serialNumber = $7
	size = $8
	speed = $9
	# Media Type
	if (mediaType == 3) {
		# HDD
		if (speed == 15000) {
			model = model " - 15K"
		} else if (speed == 10000) {
			model = model " - 10K"
		} else if (speed > 1000 && speed < 100000) {
			model = model " - " speed
		}
	} else if (mediaType == 4) {
		# SDD
		model = model " - SSD"
	} else if (mediaType == 5) {
		# SCM (fancy NVDIMM-N)
		model = model " - NVDIMM"
	}
	# Bus Type
	model = model " - " busType
	# Output
	print "MSHW;" __Path ";" deviceId ";" model ";" firmwareVersion ";" serialNumber ";" size
}

