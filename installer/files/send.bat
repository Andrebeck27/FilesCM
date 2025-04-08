@echo off
if "%~1"=="" goto Noarg
if %~z1 GEQ 10000000000 goto toobig
c: & cd "C:\Program Files\FilesCM"
set /p APIkey=<APIkey.txt
if "%APIkey%"=="" goto nokey
set /p AccID=<AccountID.txt
if "%AccID%"=="" goto noacc
break > "C:\Program Files\FilesCM\response.txt"
echo If % uploaded is 100, but nothing is happening, there is likely an internet connection issue!
curl -F "file=@%~1" -H "X-Account-ID: %AccID%" -H "X-API-Key: %APIkey%" https://api.files.vc/upload > "C:\Program Files\FilesCM\response.txt"
cmd /c start /min "" Powershell -ExecutionPolicy Bypass -File "C:\Program Files\FilesCM\notif.ps1"
if exist "C:\Program Files\FilesCM\temp.zip" 	(
												del /f "C:\Program Files\FilesCM\temp.zip"
												del /f "C:\Program Files\FilesCM\temp.txt"
												)
exit

:toobig
echo Max filesize allowed is 10GB. (10000000000 Bytes)
echo. 
set "gbval=%~z1"
echo The file selected is ^>%gbval:~0,2% Gigabytes. (%~z1 Bytes)
echo Explorer shows sizes in (x)iB, not (x)B, and as such will appear smaller than they really are.
echo Nothing has been uploaded. Press any key to exit.
pause > nul
exit

:Noarg
echo No first argument found.
echo.
echo Please run from commandline with a path in quotation marks beside the command, or from context menu, or from dragging a file in.
pause > nul
exit

:Nokey
echo No API key given.
echo.
echo Please paste your API key in "C:\Program Files\FilesCM\APIkey.txt".
echo If you do not have an API key, contact an admin on the Files.vc discord server with a vaild reason to get an API key, or email admin@files.vc.
echo.
echo Press any key to open "C:\Program Files\FilesCM\APIkey.txt".
pause > nul
"C:\Program Files\FilesCM\APIkey.txt"
exit

:noacc
break > "C:\Program Files\FilesCM\response.txt"
curl -F "file=@%~1" -H "X-API-Key: %APIkey%" https://api.files.vc/upload > "C:\Program Files\FilesCM\response.txt"
cmd /c start /min "" Powershell -ExecutionPolicy Bypass -File "C:\Program Files\FilesCM\notif.ps1"
exit
