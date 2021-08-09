function Start-FolderCleanup {
<<<<<<< HEAD
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
=======
     <#
        .SYNOPSIS
        Moves any files in a directory to another directory. Useful for keeping public folders clean of files where users should not be placing them. 

        .DESCRIPTION
        Moves any files in a directory to another directory. Useful for keeping public folders clean of files where users should not be placing them. 

        .PARAMETER Path
        Mandatory: This is the path you wish to automatically cleanup.

        .PARAMETER ArchivePath
        This is the path to the directory you want to move the files to.

        .INPUTS
        

        .OUTPUTS


        .EXAMPLE
        Start-FolderCleanup -Path P:\Public

        .EXAMPLE
        Start-FolderCleanup -Path P:\Public -ArchivePath "P:\Cleaned Files"
>>>>>>> 6d521fb98a3bdf38c957021fbb4222b75bd2d9cf

        .LINK
        Github source: https://github.com/SnoozingPinata/FileAuditor

        .LINK
        Author's website: www.samuelmelton.com
    #>
<<<<<<< HEAD
=======

>>>>>>> 6d521fb98a3bdf38c957021fbb4222b75bd2d9cf
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

    Begin {
    }

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
<<<<<<< HEAD
}
=======

    End {
    }
}

# this does not work yet. Just added here from another scratch pad. 
function Compress-OldHomeFolders {
    # This creates the list of enabled users in AD. 

    # Definitely not working right yet. Looks like the compare object statement has a bug. Need to make sure that I'm sorting everything and generating the lists to compare properly. 
    $enabledUserList = @()
    Get-ADUser -Filter 'Enabled -eq $true' | Sort-Object -Property SamAccountName | ForEach-Object -Process {
        $enabledUserList += $_.SamAccountName
    }

    $directoryList = @()
    Get-ChildItem -Path $REMOVEDADDAPATHHERE | Sort-Object -Property Name | ForEach-Object -Process {
        $directoryList += $_.Name
    }


    Get-ChildItem -Path $REMOVEDADDAPATHHERE | Sort-Object -Property Name | ForEach-Object -Process {
        $directoryList += $_.Name
    }

    $sortedDirectoryList = $directoryList | Sort-Object -Property Name

    Compare-Object -ReferenceObject $enabledUserList -DifferenceObject $sortedDirectoryList
}
>>>>>>> 6d521fb98a3bdf38c957021fbb4222b75bd2d9cf
