# Start Kanata keyboard manager if not already running
try {
	$Random = Get-Random -Maximum 200
	Start-Sleep -Milliseconds $Random
	Get-Process kanata -ErrorAction Stop | Out-Null
}
catch {
	start-process -FilePath C:\CLI\kanata.exe -ArgumentList "-c C:\CLI\kanata_75.kbd" -WindowStyle Hidden
}

