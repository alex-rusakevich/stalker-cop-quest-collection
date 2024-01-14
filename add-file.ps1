#Requires -Version 5.1

<#
    .SYNOPSIS
        Добавить файл к проекту
    
    .DESCRIPTION
        Создать файл .bak с копией оригинала, переместить оригинал в рабочую папку, 
        создать на него ссылку в папке игры

    .NOTES
        Автор: Александр Русакевич
        Год: 2024
#>

# region Variables

$ErrorActionPreference = "Stop"

# endregion

# region Import

[void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )
Import-Module -Name .\common.psm1

#endregion

#region Main

$StalkerPath = Get-StalkerPath

$open_dialog = New-Object Windows.Forms.OpenFileDialog
$open_dialog.InitialDirectory = $StalkerPath
$file_path = ""

if($open_dialog.ShowDialog() -eq "OK") {
    $file_path = $open_dialog.FileName
} 
else 
{
    GUIThrowException "Не был выбран никакой файл"
}

if(!($file_path -match ([regex]::escape($StalkerPath) + "\\gamedata\\.*"))){
    GUIThrowException "Был выбран файл не из папки gamedata игры"
    return
}

$workspace_path = ('.\gamedata\' + ($file_path -replace '.*\\gamedata\\', ''))

New-Item (Split-Path $workspace_path) -ItemType Directory -Force
Copy-Item -Path $file_path -Destination $workspace_path -Recurse
Move-Item -Path $file_path -Destination ($file_path + ".bak")

Write-Host "Создание ссылки на ${workspace_path}..."

cmd /c mklink /H `"$file_path`" `"$workspace_path`"

# endregion
