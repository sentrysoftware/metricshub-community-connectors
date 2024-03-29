BEGIN {
	FS = "[;]"
}

$3 ~ /.Device.MPIO/ {
	DriveLetter = $1
	DriveName = $2
	MPIOID = $3
	gsub(".*MPIO", "MPIO ", MPIOID)
	MPIOInfo[MPIOID] = MPIOInfo[MPIOID] DriveLetter " (" DriveName ") "
}

END {
	for (MPIOID in MPIOInfo) {
		if (MPIOInfo[MPIOID] != "") {
			print ("MSHW;" MPIOID ";" MPIOInfo[MPIOID] ";")
		}
	}
}

