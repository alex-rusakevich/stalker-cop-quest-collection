#Requires -Version 5.1

<#
    .SYNOPSIS
        Создать ссылки на файлы проекта в папке с игрой
    
    .DESCRIPTION
        Создать файл .bak с копией оригинала,
        создать ссылку на файл из рабочей папки проекта и поместить в папку игры

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

$workspace_files = Get-ChildItem -Path (".\\gamedata") -Recurse -Exclude .gitignore

if(!$workspace_files) {
    Write-Host "Рабочая папка gamedata пуста"
    return
}

$filesToRestore = @($filesToRestore)

foreach($workspace_file_path in $workspace_files){
    $game_file_path = $StalkerPath + "\gamedata\" + ($workspace_file_path -replace ".*\\gamedata\\", '')

    New-Item (Split-Path $game_file_path) -ItemType Directory -Force

    if (Test-Path $game_file_path) {
        Move-Item -Path $game_file_path -Destination ($game_file_path + ".bak")
    }

    Write-Host "Создание ссылки ${workspace_file_path} -> ${game_file_path}..."

    cmd /c mklink /H `"$game_file_path`" `"$workspace_file_path`"
}

# endregion
