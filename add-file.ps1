#
# Добавить файл в проект
# Александр Русакевич, 2024
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
    write-host "Не был выбран никакой файл"
    return
}

if(!($file_path -match ([regex]::escape($STALKER_PATH) + "\\gamedata\\.*"))){
    write-host "Был выбран файл не из папки gamedata"
    return
}

$workspace_path = ('.\gamedata\' + ($file_path -replace '.*\\gamedata\\', ''))

New-Item (Split-Path $workspace_path) -ItemType Directory -Force
Copy-Item -Path $file_path -Destination $workspace_path -Recurse
Move-Item -Path $file_path -Destination ($file_path + ".bak")

$workspace_path = $workspace_path

Write-Host "Создание ссылки на ${workspace_path}..."

cmd /c mklink /H `"$file_path`" `"$workspace_path`"
