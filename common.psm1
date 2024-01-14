#Requires -Version 5.1
<#
    .SYNOPSIS
        ����� ����� ��� �������� �������

    .NOTES
        �����: ��������� ���������
        ���: 2024
#>

# region Variables

$ErrorActionPreference = "Stop"

# endregion

# region Import

[void] [Reflection.Assembly]::LoadWithPartialName( 'System.Windows.Forms' )

# endregion

# region Functions

function GUIThrowException {
    [CmdletBinding()]
        param (
            [Parameter(Mandatory)]
            [string]
            $Message
        )

    [System.Windows.Forms.MessageBox]::Show($Message,'������',`
        'Ok','Error','Button1','DefaultDesktopOnly')
    throw "��������� ������: $Message"
}

function Get-StalkerPath {
    try {
        return (Get-Content .\.stalkerpath).Trim()
    }
    catch {
        GUIThrowException '���������� ��������� .\.stalkerpath. �� ��������� ������ choose-stalker-folder.ps1?'
    }
}

# endregion

# region Main

# endregion

# region Export

Export-ModuleMember `
    -Function GUIThrowException

Export-ModuleMember `
    -Function Get-StalkerPath

# endregion
