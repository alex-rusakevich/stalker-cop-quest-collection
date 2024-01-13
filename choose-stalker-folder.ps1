#
# ������� ����� �������� ��� ������
# ��������� ���������, 2024
#

$ErrorActionPreference = "Stop"

[void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )

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
    write-host "�� ������� ������� �����"
    return
}

$folder > .stalkerpath
