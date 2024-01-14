#Requires -Version 5.1
<#
    .SYNOPSIS
        Выбрать папку Сталкера: ЗП для работы

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

# endregion

# region Main

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
    GUIThrowException 'Не выбрано никакой папки'
}

$folder > .stalkerpath

# endregion
