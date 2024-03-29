BEGIN {
	FS = " "
	Name = ""
	Type = ""
	Unit = ""
	Value = ""
	Lower = ""
	Upper = ""
}

{
	if (NF == 1 && $0 !~ /:/) {
		Name = $1
	}
	if ($3 ~ /V/) {
		Value = $2
		Unit = $3
		if (Unit == "V") {
			Value = Value * 1000
		}
		Lower = $6
		gsub(/\+/, "", Lower)
		if (Lower == 0) {
			Lower = ""
		}
		Upper = $10
		gsub(/\+/, "", Upper)
		if (Upper == 0) {
			Upper = ""
		} else {
			Upper = Upper * 1000
		}
		Type = $1
		gsub(/:/, "", Type)
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Lower ";" Upper ";")
	}
}

