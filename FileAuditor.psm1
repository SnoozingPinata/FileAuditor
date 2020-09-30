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
        # Checks if parameter was defined. 
            # If it was not defined, it creates the ArchivePath with a default name in the parent path. 
            # If it was defined, checks to see if the path is valid.
                # If path is valid, writes a verbose message and exits this bit of code.
                # If path is not valid, writes a verbose message and sets the archive path to the same default name in the parent path.
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

        # Test to see if the ArchivePath directory exists.
            # If not then it create a directory with the $ArchivePath variable. 
        if (-not (Test-Path -Path $ArchivePath)) {
            New-Item -Path $ArchivePath -ItemType "directory"
        }

        # Gets all of the items in the mandatory Path directory.
        # Checks each one to see if it is a directory.
            # If it's not a directory, moves the item to the $ArchivePath directory.
        Get-ChildItem -Path $Path | ForEach-Object -Process {
            if (-not ($_ -is [System.IO.DirectoryInfo])) {
                Move-Item -Path $_.FullName -Destination (Join-Path -Path $ArchivePath -ChildPath $_.Name)
            }
        }
    }
}