$1 ~ /UID:/ {
	LunID = ""
}

$1 ~ /Runtime/ && $2 ~ /Name:/ {
	PathNameTempVar = $3
}

$1 ~ /Device:/ && $2 ~ /^naa/ {
	LunID = $2
	PathName[LunID] = PathNameTempVar
}

$1 ~ /Device:/ && $2 ~ /^eui/ {
	LunID = $2
	PathName[LunID] = PathNameTempVar
}

$1 ~ /Device/ && $2 ~ /Display/ && $3 ~ /Name:/ && LunID != "" {
	LunName[LunID] = $0
	gsub(/\(.+\)/, "", LunName[LunID])
	gsub(" *Device Display Name: *", "", LunName[LunID])
}

$1 ~ /State:/ {
	if ($2 ~ /active/) {
		PathCount[LunID] = PathCount[LunID] + 1
	}
	StatusInformation[LunID] = StatusInformation[LunID] PathName[LunID] "=" $2 "   "
}

$1 ~ /Transport:/ {
	Transport[LunID] = $2
}

END {
	for (LunID in LunName) {
		if (PathCount[LunID] == "") {
			PathCount[LunID] = 0
		}
		if (Transport[LunID] == "fc") {
			print "MSHW;" LunID ";" LunName[LunID] ";" PathCount[LunID] ";" StatusInformation[LunID]
		}
	}
}

