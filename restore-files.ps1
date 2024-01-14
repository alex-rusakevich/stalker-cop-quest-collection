#Requires -Version 5.1
<#
    .SYNOPSIS
        ������������ ������������ ����� ��������

    .DESCRIPTION
        ����������� ��� ����� .bak �� gamedata ���� � ������� �� ����� ��� �� ������, 
        �� ��� ���������� .bak

    .NOTES
        �����: ��������� ���������
        ���: 2024
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
    Write-Host "������ ���������������, ��������� �����������..."
    return
}

$filesToRestore = @($filesToRestore)

$number_found = $filesToRestore.Length
write-host "������� $number_found ����(��) ��� ��������������"

foreach($bak_path in $filesToRestore) {
    $orig_path = $bak_path -replace '.bak$', ''
    write-host "����������������� $bak_path -> $orig_path"

    if (Test-Path $orig_path) {
        Remove-Item $orig_path -Force
    }
    Rename-Item -Path $bak_path -newName $orig_path
}

# endregion
