BEGIN {
	FS = ";"
	upper = ""
	lower = ""
}

{
	if (length($3) > 0) {
		upper = $3 / 100 * 110
		lower = $3 / 100 * 90
	}
}

END {
	print $1 ";" $2 ";" $3 ";" upper ";" lower ";"
}

