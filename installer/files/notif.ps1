. ./settings.ps1
$message = Get-Content response.txt | Select-Object -Index 1
$url = Get-Content response.txt | Select-Object -Index 2
$messageOut = ($message -replace '.*    "message": "' -replace '",.*')
$urlOut = ($url -replace '.*    "file_url": "' -replace '",.*')
if ($LinkOut -ne 0){
    if ($linkOut -eq 2){
        $replacereg = '\..*$'
        $urlOut = ($urlOut -replace '.*/' -replace $replacereg)
        $urlOut = ("https://files.vc/d/dl?hash="+$urlOut)
    }
    Set-Clipboard $urlOut
}
        if ($notify){New-BurntToastNotification -Applogo "C:\Program Files\FilesCM\logo.ico" -Text "Files.vc upload","$Messageout","$Urlout"}
        exit
