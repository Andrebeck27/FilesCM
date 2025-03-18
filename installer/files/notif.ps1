$message = Get-Content response.txt | Select-Object -Index 1
$url = Get-Content response.txt | Select-Object -Index 2
$messageOut = ($message -replace '.*    "message": "' -replace '",.*')
$urlOut = ($url -replace '.*    "file_url": "' -replace '",.*')
New-BurntToastNotification -Applogo "C:\Program Files\FilesCM\logo.ico" -Text "Files.vc upload","$Messageout","$Urlout"
Set-Clipboard $urlOut
# hey future me add the exit here
exit
# HI