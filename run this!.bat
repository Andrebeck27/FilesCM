cd installer
echo %cd% > %temp%\fvcdir.txt
Powershell Start-Process powershell -Verb runAs -ArgumentList '-ExecutionPolicy Unrestricted -File """%cd%\install.ps1"""'
exit
