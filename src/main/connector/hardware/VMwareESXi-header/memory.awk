BEGIN {
	FS = "[;]"
	ipmiFound = "false"
	globalFound = "false"
}

{
	if ($1 ~ /Global/) {
		if ($2 > 0) {
			globalFound = ("MSHW;" $0)
		}
	} else if ($3 ~ /OldInstance-/) {
		globalFound = "false"
		# If an OldInstance is found, then deactivate the GlobalFound as the previous discovery found individual modules
		ipmiFound = "true"
	} else if (NF > 3) {
		print ("MSHW;" $0)
		# If it's not an OldInstance or Global or Blank, then print
		if ($4 != 1) {
			ipmiFound = "true"
		}
	}
}

END {
	if (ipmiFound == "false" && globalFound != "false") {
		print globalFound
	}
	if (ipmiFound == "true") {
		print "MSHW;ipmiFound;99;ipmiFound;0;"
	}
}

