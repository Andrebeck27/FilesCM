. ./settings.ps1
if ($LinkOut){
    $url = Get-Content response.txt | Select-Object -Index 2
    $urlOut = ($url -replace '.*    "file_url": "' -replace '",.*')
    if ($urlOut -like '*.mp4'){
        $linkOut = $Mp4Link
    }
    if ($linkOut -eq 2){
        $replacereg = '\..*$'
        $urlOut = ($urlOut -replace '.*/' -replace $replacereg)
        $urlOut = ("https://files.vc/d/dl?hash="+$urlOut)
    }elseif ($linkOut -eq 3){
        $replacereg = '\..*$'
        $urlOut = ($urlOut -replace 'https://cdn-1.files.vc/files/')
        $urlOut = ("https://api.files.vc/files/"+$urlOut)
    }
    Set-Clipboard $urlOut
}
        if ($notify){
            $message = Get-Content response.txt | Select-Object -Index 1
            $messageOut = ($message -replace '.*    "message": "' -replace '",.*')
            New-BurntToastNotification -Applogo "C:\Program Files\FilesCM\logo.ico" -Text "Files.vc upload","$Messageout","$Urlout"
        }
exit
