BEGIN {
	deviceID = ""
}

/^lo[0-9]* / {
	deviceID = ""
}

# ip a
$2 ~ /^lo[0-9]*/ {
	deviceID = ""
}

$2 ~ /^eth[0-9][0-9]*:?|^vmnic[0-9][0-9]*:?|^em[0-9]*:?|^[Pp][0-9][0-9]*[Pp][0-9][0-9]*:?|^en[os][0-9]*:?|^enp[0-9]*s[0-9]*:?/ {
	deviceID = $2
	gsub(":", "", deviceID)
	ports[deviceID] = deviceID
	if ($2 ~ /UP/ || $3 ~ /UP/) {
		portActive[deviceID] = 1
	}
}

$1 ~ /link.ether/ {
	macAddress[deviceID] = $2
}

/ +inet [0-9]+/ {
	ipAddress[deviceID] = $2
	gsub("/.*", "", ipAddress[deviceID])
}

(/ UP /) {
	portActive[deviceID] = 1
}

END {
	for (deviceID in ports) {
		if (ports[deviceID] != "" && portActive[deviceID] == 1) {
			print "MSHW;" deviceID ";" macAddress[deviceID] ";" ipAddress[deviceID] ";"
		}
	}
}

