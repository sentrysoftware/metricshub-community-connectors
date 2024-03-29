BEGIN {
	FS = ";"
}

{
	if ($2 ~ /gpu-/) {
		gpuId = $2
		gpuIds[gpuId] = gpuId
	}
	if ($1 ~ /D3D Video Decode/) {
		gpuId = $2
		VideoDecode[gpuId] = $3
	}
	if ($1 ~ /D3D Video Encode/) {
		gpuId = $2
		VideoEncode[gpuId] = $3
	}
	if ($1 ~ /GPU Package/) {
		gpuId = $2
		PowerConsumption[gpuId] = $3
	}
	if ($1 ~ /GPU PCIe Tx/) {
		gpuId = $2
		TransmittedBytes[gpuId] = $3
	}
	if ($1 ~ /GPU PCIe Rx/) {
		gpuId = $2
		ReceivedBytes[gpuId] = $3
	}
	if ($1 ~ /GPU Core/ && $4 ~ /Load/) {
		gpuId = $2
		UsedTimePercent[gpuId] = $3
	}
	if ($1 ~ /GPU Memory$/ && $4 ~ /Load/) {
		gpuId = $2
		Memory[gpuId] = $3
	}
}

END {
	for (gpuId in gpuIds) {
		print ("MSHW;" gpuId ";" VideoDecode[gpuId] ";" VideoEncode[gpuId] ";" Memory[gpuId] ";" PowerConsumption[gpuId] ";" int(ReceivedBytes[gpuId]) ";" int(TransmittedBytes[gpuId]) ";" UsedTimePercent[gpuId] ";")
	}
}

