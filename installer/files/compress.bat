@echo off
if "%~1"=="" goto Noarg
cd "%~1"
Powershell -ExecutionPolicy Bypass -File "C:\Program Files\FilesCM\chksize.ps1" -dir "%~1" > "C:\Program Files\FilesCM\temp.txt"
c: & cd "C:\Program Files\FilesCM"
set /p foldersize=<temp.txt
if %foldersize% GEQ 10000000000 goto toobig
:chksize
for /f "skip=1 delims= " %%a in ('wmic logicaldisk get freespace') do set "space=%%a" & goto break
:break
if %foldersize% GEQ %space% goto nospace
:start
tar -a -cf "C:\Program Files\FilesCM\temp.zip" "%~1" 	|| 	(echo Something went wrong.
															echo Press any key to exit.
															echo %errorlevel%
															pause >nul
															exit
															)
send.bat "C:\Program Files\FilesCM\temp.zip"
exit

:toobig
echo Max filesize allowed is 10GB. (10000000000 Bytes)
echo. 
echo The directory selected is ^~%foldersize:~0,2% GB. (%foldersize% Bytes)
echo Explorer shows sizes in GiB, not GB.
echo.
echo Compression may lower this size, but there is no estimate.
echo Press any key to continue.
pause > nul
goto chksize


:Noarg
echo No first argument found.
echo.
echo Please run from commandline with a path in quotation marks beside the command, or from context menu, or from dragging a folder in.
echo.
pause > nul
exit

:nospace
echo Not enough space on your C: drive.
echo.
echo The file you are trying to compress is ^>%foldersize:~0,2% Gigabytes. (%foldersize% Bytes)
echo Explorer shows sizes in GiB, not GB.
echo Your free disk space is ^~%space:~0,2% Gigabytes. (%space% Bytes)
echo.
echo You can close this window and compress the folder yourself, then send it as a file.
echo Or you can press any key to attempt compression anyway.
pause >nul
goto start
