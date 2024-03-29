BEGIN {
	FS = ";"
}

# Skip bus clock speed
($1 ~ /[Bb]us/) {
	next
}

{
	if (clockCount[$2] == "") {
		clockCount[$2] = 0
		clockSum[$2] = 0
	}
	clockCount[$2] = clockCount[$2] + 1
	clockSum[$2] = clockSum[$2] + $3
}

# Print the result at the end
END {
	for (cpuId in clockCount) {
		print "MSHW;" cpuId ";" (clockSum[cpuId] / clockCount[cpuId])
	}
}

