using namespace System.Windows.Forms
using namespace System.Drawing
$showuninstallpromptopen = 0
$TempDir = [System.IO.Path]::GetTempPath()
$OriginalPath = Get-Content "$TempDir\fvcdir.txt"
$OriginalPath = $OriginalPath -replace ".{1}$" 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[Application]::EnableVisualStyles() 
Add-Type -AssemblyName PresentationCore,PresentationFramework
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    $regPath = "HKCR:\*\shell\Send to Files.vc"
    $value = Test-Path -LiteralPath $regPath
    if($value){
        $showuninstallpromptopen = 1
     }
    Else{
        $BTexist = Test-Path -LiteralPath "C:\Program Files\WindowsPowerShell\Modules\BurntToast"
        if (-not $BTexist) {
        install-module BurntToast -Force
    }
        Set-location -LiteralPath "HKCR:\*\shell"
        New-Item -Name "Send to Files.vc"
        Set-location -LiteralPath "HKCR:\*\shell\Send to Files.vc"
        $IconregValue = @{
            LiteralPath = 'HKCR:\*\shell\Send to Files.vc'
            Name = 'Icon'
            PropertyType = 'String'
            Value = '"C:\Program Files\FilesCM\logo.ico"'
        }
        New-ItemProperty @IconregValue
        New-Item -Name "command" -Value '"C:\Program Files\FilesCM\send.bat" "%1%"'
    
    Set-location "C:\Program Files"
    $folderexists = Test-Path -Path "C:\Program Files\FilesCM"
    if(($folderexists)-and($showuninstallpromptopen -eq 0)){
        $showuninstallpromptopen = 1
    }else{
    New-Item -Name "FilesCM" -ItemType "directory"
    Copy-Item -path "$OriginalPath\files\*" -Destination "C:\Program Files\FilesCM" -Recurse
    }
    }
    if($showuninstallpromptopen -ne 0){

        $ButtonType = [System.Windows.Forms.MessageBoxButtons]::YesNo
        $MessageIcon = [System.Windows.Forms.MessageBoxIcon]::Warning
        $MessageBody = "Are you trying to uninstall the program?"+"
You can do so here."
        $MessageTitle = "Uninstaller"
        $Result = [System.Windows.Forms.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)

        if($Result -eq "Yes"){
            
            Remove-Item -LiteralPath $regPath -Force -Recurse # Spooky !
            Remove-Item -path "C:\Program Files\FilesCM" -Recurse
            $ButtonType = [System.Windows.Forms.MessageBoxButtons]::Ok
            $MessageIcon = [System.Windows.Forms.MessageBoxIcon]::Information
            $MessageBody = "Done."
            $MessageTitle = "Uninstaller"
            $Result = [System.Windows.Forms.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
        
            if($Result -eq "Ok"){
                [System.Environment]::Exit(0)
            }
        }



    } else { 
        $ButtonType = [System.Windows.Forms.MessageBoxButtons]::YesNo
        $MessageIcon = [System.Windows.Forms.MessageBoxIcon]::Information
        $MessageBody = "Done. If you do not see the icon next to the contest menu option, restart Explorer.exe. You must set your AccountID in C:\Program Files\FilesCM\AccountID. Open this file?"
        $MessageTitle = "Done!"
        $Result = [System.Windows.Forms.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
    
        if($Result -eq "Yes"){
            
    Start-process "C:\Program Files\FilesCM\accountID.txt"
    
        }
        Write-Host "exit isn't working for some reason. If you're seeing this, this is your cue to close this window!"
    }
Clear-Host
[System.Environment]::Exit(0)
Write-Host "exit isn't working for some reason. If you're seeing this, this is your cue to close this window!"
exit
