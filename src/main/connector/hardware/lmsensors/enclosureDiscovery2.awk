BEGIN {
	FS = ":"
	Vendor = ""
	Version = ""
	Date = ""
}

{
	if ($1 ~ /Vendor/) {
		Vendor = $2
	}
	if ($1 ~ /Version/) {
		Version = $2
	}
	if ($1 ~ /Release Date/) {
		Date = $2
		print ("MSHW;" "Vendor:" Vendor " Version:" Version " Date:" Date)
	}
}

