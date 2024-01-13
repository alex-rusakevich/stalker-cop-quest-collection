#
# �������� ���� � ������
# ��������� ���������, 2024
#

$ErrorActionPreference = "Stop"

$STALKER_PATH = (Get-Content .\.stalkerpath).Trim()

[void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )

$open_dialog = New-Object Windows.Forms.OpenFileDialog
$open_dialog.InitialDirectory = $STALKER_PATH
$file_path = ""

if($open_dialog.ShowDialog() -eq "OK") {
    $file_path = $open_dialog.FileName
} 
else 
{
    write-host "�� ��� ������ ������� ����"
    return
}

if(!($file_path -match ([regex]::escape($STALKER_PATH) + "\\gamedata\\.*"))){
    write-host "��� ������ ���� �� �� ����� gamedata"
    return
}

$workspace_path = ('.\gamedata\' + ($file_path -replace '.*\\gamedata\\', ''))

New-Item (Split-Path $workspace_path) -ItemType Directory -Force
Copy-Item -Path $file_path -Destination $workspace_path -Recurse
Move-Item -Path $file_path -Destination ($file_path + ".bak")

$workspace_path = $workspace_path

Write-Host "�������� ������ �� ${workspace_path}..."

cmd /c mklink /H `"$file_path`" `"$workspace_path`"
