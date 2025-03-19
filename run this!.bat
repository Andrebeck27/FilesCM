cd installer
echo %cd% > %temp%\fvcdir.txt
Powershell Unblock-File """%cd%\install.ps1"""
Powershell Start-Process powershell -Verb runAs -ArgumentList '-ExecutionPolicy Unrestricted -File """%cd%\install.ps1"""'
exit
