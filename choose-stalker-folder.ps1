#
# Выбрать папку Сталкера для работы
# Александр Русакевич, 2024
#

$ErrorActionPreference = "Stop"

[void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )

$open_folder_dialog = New-Object Windows.Forms.FolderBrowserDialog
$open_folder_dialog.rootfolder = "MyComputer"
$open_folder_dialog.Description = 
    "Выберите корневую папку игры (в ней должна быть папка 'bin', но саму папку 'bin' не выбирайте)"
$folder = ""

if($open_folder_dialog.ShowDialog() -eq "OK") 
{
    $folder = $open_folder_dialog.SelectedPath
} 
else 
{
    write-host "Не выбрано никакой папки"
    return
}

$folder > .stalkerpath
