BEGIN {
	FS = ": "
	vmName = ""
	UUID = ""
	powerState = ""
	powerShare = ""
}

/Name/ {
	vmName = $2
	gsub(/ /, "", vmName)
}

/UUID/ {
	uuid = $2
	gsub(/ /, "", uuid)
}

/State/ {
	powerState = $2
	gsub(/ /, "", powerState)
}

/CPU\(s\)/ {
	powerShare = $2
	gsub(/ /, "", powerShare)
	print vmName ";" powerState ";" powerShare ";UUID: " uuid
	vmName = ""
	powerState = ""
	powerShare = ""
	uuid = ""
}

