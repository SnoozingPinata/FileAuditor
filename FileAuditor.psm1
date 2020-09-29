function Start-FolderCleanup {
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
        # See if the parameter was defined, if not create a variable with a new path.
        if (-not ($ArchivePath)) {
            $ArchivePath = Join-Path -Path $Path -ChildPath "AutomatedCleanup"
        }

        # Test to see if path exists, if not then create a directory with the $ArchivePath variable. 
        # Need to add some more validation here to make sure the ArchivePath that was entered is a valid path, if it's not fail or use default parameters. 
        if (-not (Test-Path -Path $ArchivePath)) {
            New-Item -Path $ArchivePath -ItemType "directory"
        }

        # Check to see if the child items in the designated $Path are folders, if not move them to the designated $ArchivePath
        Get-ChildItem -Path $Path | ForEach-Object -Process {
            if (-not ($_ -is [System.IO.DirectoryInfo])) {
                Move-Item -Path $_.FullName -Destination (Join-Path -Path $ArchivePath -ChildPath $_.Name)
            }
        }
    }
}
