@echo off
if "%~1"=="" goto Noarg
if "%~z1" GEQ 10000000000 goto toobig
c:
cd "C:\Program Files\FilesCM"
set /p AccID=<AccountID.txt
if "%AccID%"=="" goto noacc
break > "C:\Program Files\FilesCM\response.txt"
curl -F "file=@%~1" -H "X-Account-ID: %AccID%" https://api.files.vc/upload > "C:\Program Files\FilesCM\response.txt"
cmd /c start /min "" Powershell -ExecutionPolicy Bypass -File "C:\Program Files\FilesCM\notif.ps1"
exit

:toobig
echo Max filesize allowed is 10GB. (10000000000 Bytes)
echo. 
set "gbval=%~z1"
echo The file selected is ^>%gbval:~0,2% Gigabytes. (%~z1 Bytes)
echo.
echo Nothing has been uploaded. Press any key to exit.
echo.
pause > nul
exit

:Noarg
echo No first argument found.
echo.
echo Please run from commandline with a path in quotation marks beside the command, or from context menu, or from dragging a file in.
echo.
pause > nul
exit

:noacc
break > "C:\Program Files\FilesCM\response.txt"
curl -F "file=@%~1" -H "X-Account-ID: %AccID%" https://api.files.vc/upload > "C:\Program Files\FilesCM\response.txt"
cmd /c start /min "" Powershell -ExecutionPolicy Bypass -File "C:\Program Files\FilesCM\notif.ps1"
exit
