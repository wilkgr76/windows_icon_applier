#$sourcepath = "new_shortcuts\Access 2016.lnk"
$ErrorActionPreference= 'silentlycontinue'

# Unzip icons.zip
#Expand-Archive -DestinationPath icons -Path icons.zip 

$files = Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse

foreach ($file in $files) {
    #$file.FullName
    $currshortcut = $file.FullName
    $destination = "new_shortcuts\$($file.BaseName).lnk"
    #Write-Host $destination
    Copy-Item $currshortcut $destination  ## Get the lnk we want to use as a template
    $shell = New-Object -COM WScript.Shell
    $shortcut = $shell.CreateShortcut($destination)  ## Open the lnk
    $ICOname = "icons\"+(Get-Item $shortcut.TargetPath).BaseName+".ico"
    #Write-Host $ICOname
    $shortcutName = (Get-Item $destination).BaseName
    if(Test-Path $ICOname) {
        $shortcut.IconLocation = (Get-Item $ICOname).FullName
        Write-Host "Custom icon being applied for $shortcutName"
    }
    else {
        Write-Host "Stock item kept for $shortcutName"
    }
    $shortcut.Save()  ## Save
}

