#Requires -Version 5.1

<#
    .SYNOPSIS
        ������� ������ �� ����� ������� � ����� � �����
    
    .DESCRIPTION
        ������� ���� .bak � ������ ���������,
        ������� ������ �� ���� �� ������� ����� ������� � ��������� � ����� ����

    .NOTES
        �����: ��������� ���������
        ���: 2024
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
    Write-Host "������� ����� gamedata �����"
    return
}

$filesToRestore = @($filesToRestore)

foreach($workspace_file_path in $workspace_files){
    $game_file_path = $StalkerPath + "\gamedata\" + ($workspace_file_path -replace ".*\\gamedata\\", '')

    New-Item (Split-Path $game_file_path) -ItemType Directory -Force

    if (Test-Path $game_file_path) {
        Move-Item -Path $game_file_path -Destination ($game_file_path + ".bak")
    }

    Write-Host "�������� ������ ${workspace_file_path} -> ${game_file_path}..."

    cmd /c mklink /H `"$game_file_path`" `"$workspace_file_path`"
}

# endregion
