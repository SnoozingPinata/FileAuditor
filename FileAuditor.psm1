function Start-FolderCleanup {
    <#
        .SYNOPSIS
        Moves all non-directory files from the given directory into a target ArchivePath directory.

        .DESCRIPTION
        Moves all non-directory files from the given directory into a target ArchivePath directory.
        If ArchivePath is not defined, a directory is created in the given directory with the name "zAutomatedCleanup".

        .PARAMETER Path
        The path of the Directory you want to clean.

        .PARAMETER ArchivePath
        The path where all non-directory files will be moved to.

        .INPUTS
        Path accepts input from pipeline.

        .OUTPUTS
        None.

        .EXAMPLE
        Start-FolderCleanup -Path '\\contoso.com\PublicSharedFolder' -ArchivePath '\\contoso.com\PublicSharedFolder\ToBeDeleted'

        .LINK
        Github source: https://github.com/SnoozingPinata/FileAuditor

        .LINK
        Author's website: www.samuelmelton.com
    #>
    [CmdletBinding()]
    Param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true)]
        [string] $Path,

        [Parameter(
            Mandatory=$false)]
        [string] $ArchivePath
    )

    Process {

        if ($ArchivePath) {
            if (Test-Path -Path $ArchivePath) {
                Write-Verbose -Message "ArchivePath parameter has been validate."
            } else {
                Write-Verbose -Message "ArchivePath parameeter was not valid."
                $ArchivePath = Join-Path -Path $Path -ChildPath "zAutomatedCleanup"
            } 
        } else {
            $ArchivePath = Join-Path -Path $Path -ChildPath "zAutomatedCleanup"
        }

        if (-not (Test-Path -Path $ArchivePath)) {
            New-Item -Path $ArchivePath -ItemType "directory"
        }

        Get-ChildItem -Path $Path | ForEach-Object -Process {
            if (-not ($_ -is [System.IO.DirectoryInfo])) {
                Move-Item -Path $_.FullName -Destination (Join-Path -Path $ArchivePath -ChildPath $_.Name)
            }
        }
    }
}