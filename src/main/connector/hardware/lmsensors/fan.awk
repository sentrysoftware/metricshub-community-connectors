BEGIN {
	DName = ""
	FName = ""
	Value = ""
	Min = ""
	Max = ""
	Alarm = ""
}

{
	if (NF == 1 && $1 !~ /:/) {
		DName = $1
	}
	if (NF == 1 && $1 ~ /fan/ && $1 ~ /:/) {
		FName = $1
		gsub(/:/, "", FName)
	}
	if (NF == 2) {
		if ($1 ~ /fan[0-9]_input/) {
			Value = $2
			if (Value <= 0) {
				Value = ""
			}
		}
		if ($1 ~ /fan[0-9]_min/) {
			Min = $2
			if (Min <= 0) {
				Min = ""
			}
		}
		if ($1 ~ /fan[0-9]_max/) {
			Max = $2
			if (Max <= 0) {
				Max = ""
			}
		}
		if ($1 ~ /fan[0-9]_alarm/) {
			Alarm = $2
			if (Alarm <= 0) {
				Alarm = ""
			}
		}
		if ($1 ~ /fan[0-9]_pulses/) {
			print ("MSHW;" DName "-" FName ";" Value ";" Min ";" Max ";" Alarm ";")
		}
	}
}

