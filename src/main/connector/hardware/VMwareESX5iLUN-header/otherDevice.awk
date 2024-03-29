$1 ~ /Display/ && $2 ~ /Name:/ {
	Type = $0
	gsub(/\(.+\)/, "", Type)
	gsub(" *Display Name: *", "", Type)
	USBID = $0
	gsub(/.*\(/, "", USBID)
	gsub(/\).*/, "", USBID)
}

$1 ~ /Vendor:/ {
	Vendor = $0
	gsub(/.*: /, "", Vendor)
}

$1 ~ /Model:/ {
	Model = $0
	gsub(/.*: /, "", Model)
}

$1 ~ /Status:/ {
	Status = $2
	StatusInformation = $0
	gsub(/.*: /, "", StatusInformation)
}

$0 ~ /Is Boot USB Device: true/ {
	print "MSHW;" Type ";" USBID ";Vendor: " Vendor ";Model: " Model ";" Status ";" StatusInformation ";"
}

