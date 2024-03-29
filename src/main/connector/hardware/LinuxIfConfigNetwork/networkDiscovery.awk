BEGIN {
	deviceID = ""
}

/^lo[0-9]* / {
	deviceID = ""
}

#ifconfig
$1 ~ /^eth[0-9][0-9]*:?|^vmnic[0-9][0-9]*:?|^em[0-9]*:?|^[Pp][0-9][0-9]*[Pp][0-9][0-9]*:?|^en[os][0-9]*:?|^enp[0-9]*s[0-9]*:?/ {
	deviceID = $1
	gsub(":", "", deviceID)
	ports[deviceID] = deviceID
	if ($(NF - 1) == "HWaddr") {
		macAddress[deviceID] = $NF
	}
	if ($2 ~ /UP/ || $3 ~ /UP/) {
		portActive[deviceID] = 1
	}
}

/ +inet addr:[0-9]+/ {
	ipAddress[deviceID] = $2
	gsub("addr:", "", ipAddress[deviceID])
}

(/ UP /) {
	portActive[deviceID] = 1
}

$1 ~ /^ether$/ && $2 ~ /[0-9A-Fa-f][0-9A-Fa-f]:[0-9A-Fa-f][0-9A-Fa-f]:/ {
	macAddress[deviceID] = $2
}

END {
	for (deviceID in ports) {
		if (ports[deviceID] != "" && portActive[deviceID] == 1) {
			print "MSHW;" deviceID ";" macAddress[deviceID] ";" ipAddress[deviceID] ";"
		}
	}
}

