using namespace System.Windows.Forms
using namespace System.Drawing
$showuninstallpromptopen = 0
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$TempDir = [System.IO.Path]::GetTempPath()
$OriginalPath = Get-Content "$TempDir\fvcdir.txt"
$OriginalPath = $OriginalPath -replace ".{1}$" 
Remove-Item -Force "$TempDir\fvcdir.txt" 
[Application]::EnableVisualStyles() 
Add-Type -AssemblyName PresentationCore,PresentationFramework
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    $regPath = "HKCR:\*\shell\Send to Files.vc"
    if(Test-Path -LiteralPath $regPath){
        $showuninstallpromptopen = 1
     }
    Else{
        if (-not (Test-Path -LiteralPath "C:\Program Files\WindowsPowerShell\Modules\BurntToast")) {
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
    takeown /f "C:\Program Files\FilesCM" /r /d y
    icacls "C:\Program Files\FilesCM" /grant %username%:F /T
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
            Remove-Item -LiteralPath $regPath -Force -Recurse
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
        $MessageBody = "Done. If you do not see the icon next to the context menu option, restart Explorer.exe. Open the AccountID file?"
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
