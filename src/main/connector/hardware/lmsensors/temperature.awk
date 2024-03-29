BEGIN {
	Name = ""
	Type = ""
	Sensor = ""
	Value = ""
	Max = ""
	Critical = ""
	TEMP = 0
}

{
	if (NF == 1 && $0 !~ /:/) {
		Name = $1
	}
	if (NF == 1 && $0 ~ /:/ && TEMP == 1) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
	if (NF == 1 && $0 ~ /:/ && TEMP == 0) {
		Type = $0
		gsub(/:/, "", Type)
	}
	if (NF == 2 && $2 ~ /:/ && TEMP == 1) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
	if (NF == 2 && $2 ~ /:/ && TEMP == 0) {
		Type = $0
		gsub(/:/, "", Type)
		gsub(" ", "", Type)
	}
	if (NF == 2 && $1 ~ /temp/) {
		Sensor = $1
		gsub(/:/, "", Sensor)
		if ($1 ~ /temp[0-9]_input:/ || $1 ~ /temp[0-9][0-9]_input:/) {
			Value = $2
			TEMP = 1
		}
		if ($1 ~ /temp[0-9]_max:/ || $1 ~ /temp[0-9][0-9]_max:/) {
			Max = $2
			if (Max <= 0) {
				Max = ""
			}
		}
		if ($1 ~ /temp[0-9]_crit:/ || $1 ~ /temp[0-9][0-9]_crit:/ && length($1) == 11) {
			Critical = $2
			if (Critical <= 0) {
				Critical = ""
			}
			if (Max == Value && Value == Critical) {
				Max = ""
				Critical = ""
			}
			if (Max == Critical && Max > 0) {
				Max = Max - Critical / 10
			}
			if (Max == 0 && Critical > 0) {
				Max = Critical - Critical / 10
			}
			print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
			Value = ""
			Max = ""
			Critical = ""
			TEMP = 0
		}
	}
	if (NF == 1 && TEMP == 1 && $0 !~ /temp/) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
	if (NF == 0 && TEMP == 1 && $0 !~ /temp/) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
	if (NF >= 3 && TEMP == 1 && $0 !~ /temp/) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
	if (NF >= 3 && $0 !~ /temp/) {
		Type = $0
		gsub(/:/, "", Type)
	}
}

END {
	if (TEMP == 1) {
		print ("MSHW;" Name "-" Type ";" Type ";" Value ";" Max ";" Critical ";")
		Value = ""
		Max = ""
		Critical = ""
		TEMP = 0
	}
}

