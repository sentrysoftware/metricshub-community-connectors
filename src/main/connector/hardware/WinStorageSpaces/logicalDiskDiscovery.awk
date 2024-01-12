BEGIN {
	FS = ";"
	alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

{
	if ($2 > 64 && $2 < 91) {
		deviceId = substr(alphabet, int($2) - 64, 1) ":"
		label = deviceId
	} else {
		deviceId = $1
		label = ""
	}
	if ($5 != "") {
		if (label != "") {
			label = label " "
		}
		label = label $5
	}
	filesystem = $4
	size = $6
	print "MSHW;" deviceId ";" label ";File System: " filesystem ";" size
}

