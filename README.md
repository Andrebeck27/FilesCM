# FilesCM
Context menu option to upload file to Files.vc

## Installation -- Windows only!
Open 'run this!.bat' in the root folder.

<sub> If you get a warning in the Powershell terminal asking "whether you want to run this script or not", press `R` and `Enter`.

## Usage
1. Right-click on any file/directory and click on "(Compress and) Send to files.vc"
2. By default, the output link will be **automatically copied to your clipboard** and you will be notified once the upload is complete. This can be changed in the settings.
> [!NOTE]
> Upload will be immediately rejected if:
> * No API key was given.
> * The selected file is >10 GB.
> * The selected folder (when compressed) is >10 GB.

## Settings
Settings are stored in `C:\Program Files\FilesCM\settings.ps1`.
Open this file in any text editor.

### Error handling
* If you receive an empty notification, there likely was an internet connection error; check if Files.vc is up and running, or if your internet connection is stable.
* You can check response.txt in %ProgramFiles%\FilesCM to get more information.
* Occasionally, when uploading a file / folder the command prompt will close immediately. There is no fix for this besides trying again.
