BEGIN {
	transmitPackets = ""
	transmitErrors = ""
	receivePackets = ""
	receiveErrors = ""
	transmitBytes = ""
	receiveBytes = ""
}

# ifconfig
$1 ~ /^eth[0-9][0-9]*:?|^vmnic[0-9][0-9]*:?|^em[0-9]*:?|^[Pp][0-9][0-9]*[Pp][0-9][0-9]*:?|^en[os][0-9]*:?|^enp[0-9]*s[0-9]*:?/ {
	deviceID = $1
	gsub(":", "", deviceID)
}

/^ +RX packets:/ {
	receivePackets = substr($2, 9, length($2) - 8)
	receiveErrors = substr($3, 8, length($3) - 7)
}

/^ +TX packets:/ {
	transmitPackets = substr($2, 9, length($2) - 8)
	transmitErrors = substr($3, 8, length($3) - 7)
}

/^ +RX bytes:.*TX bytes:/ {
	receiveBytes = substr($2, 7, length($2) - 6)
	transmitBytes = substr($6, 7, length($6) - 6)
}

$1 == "RX" && $2 == "packets" && $4 == "bytes" {
	receivePackets = $3
	receiveBytes = $5
}

$1 == "TX" && $2 == "packets" && $4 == "bytes" {
	transmitPackets = $3
	transmitBytes = $5
}

$1 == "RX" && $2 == "errors" {
	receiveErrors = $3
}

$1 == "TX" && $2 == "errors" {
	transmitErrors = $3
}

END {
	print "MSHW;" deviceID ";" receivePackets ";" transmitPackets ";" (receiveErrors + transmitErrors) ";" receiveBytes ";" transmitBytes
}

