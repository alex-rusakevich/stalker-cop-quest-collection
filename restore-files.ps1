#Requires -Version 5.1
<#
    .SYNOPSIS
        Восстановить оригинальные файлы Сталкера

    .DESCRIPTION
        Переместить все файлы .bak из gamedata игры с заменой на место тех же файлов, 
        но без расширения .bak

    .NOTES
        Автор: Александр Русакевич
        Год: 2024
#>

# region Variables

$ErrorActionPreference = "Stop"

# endregion

# region Import

Import-Module -Name .\common.psm1

# endregion

# region Main

$StalkerPath = Get-StalkerPath
$filesToRestore = Get-ChildItem -Path ($StalkerPath + "\\gamedata") -Include *.bak -Recurse

if(!$filesToRestore) {
    Write-Host "Нечего восстанавливать, программа завершается..."
    return
}

$filesToRestore = @($filesToRestore)

$number_found = $filesToRestore.Length
write-host "Найдено $number_found файл(ов) для восстановления"

foreach($bak_path in $filesToRestore) {
    $orig_path = $bak_path -replace '.bak$', ''
    write-host "Восстанавливается $bak_path -> $orig_path"

    if (Test-Path $orig_path) {
        Remove-Item $orig_path -Force
    }
    Rename-Item -Path $bak_path -newName $orig_path
}

# endregion
