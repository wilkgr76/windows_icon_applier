#$sourcepath = "new_shortcuts\Access 2016.lnk"
$ErrorActionPreference= 'silentlycontinue'

# Unzip icons.zip
#Expand-Archive -DestinationPath icons -Path icons.zip 

$files = Get-ChildItem "D:\materialos\original_icons\*.lnk" -Recurse

foreach ($file in $files) {
    #Write-Host $file.FullName
    $currshortcut = $file.FullName
    $destination = "new_shortcuts\$($file.BaseName).lnk"
    #$destination = $currshortcut.Replace("D:\materialos\original_icons\","new_shortcuts\")

    #$destination -replace "D:\materialos\original_icons\"
    #$destination = "new_shortcuts\$($currshortcut_shortened).lnk"
    Write-Host $destination

    Copy-Item $currshortcut $destination ## Get the lnk we want to use as a template
    $shell = New-Object -COM WScript.Shell
    $shortcut = $shell.CreateShortcut($destinaton)  ## Open the lnk

    $ICOname = "icons\"+(Get-Item $shortcut.TargetPath).BaseName+".ico"

    #Write-Host $ICOname
    $shortcutName = (Get-Item ("D:\materialos\$destination")).BaseName
    #Write-Host "D:\materialos\$destination"
    if(Test-Path $ICOname) {
        $shortcut.IconLocation = (Get-Item $ICOname).FullName
        Write-Host "Custom icon being applied for $shortcutName"
    }
    else {
        Write-Host "Stock item kept for $shortcutName"
    }
    $shortcut.Save()  ## Save
}

