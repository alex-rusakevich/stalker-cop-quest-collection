#Requires -Version 5.1
<#
    .SYNOPSIS
        ������� ����� ��������: �� ��� ������

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

# endregion

# region Main

$open_folder_dialog = New-Object Windows.Forms.FolderBrowserDialog
$open_folder_dialog.rootfolder = "MyComputer"
$open_folder_dialog.Description = 
    "�������� �������� ����� ���� (� ��� ������ ���� ����� 'bin', �� ���� ����� 'bin' �� ���������)"
$folder = ""

if($open_folder_dialog.ShowDialog() -eq "OK") 
{
    $folder = $open_folder_dialog.SelectedPath
} 
else 
{
    GUIThrowException '�� ������� ������� �����'
}

$folder > .stalkerpath

# endregion
