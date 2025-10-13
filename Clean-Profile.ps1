# Clean User Profile Folders Script - Detailed File Logging
$UserProfile = [Environment]::GetFolderPath("UserProfile")
$LogFile = Join-Path $UserProfile "ProfileCleanup.log"

# Function to write log entries
function Write-Log {
    param([string]$Message, [string]$Type = "INFO")
    $Timestamp = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
    $LogEntry = "[$Timestamp] [$Type] $Message"
    Add-Content -Path $LogFile -Value $LogEntry
    Write-Output $LogEntry
}

# Function to recursively delete and log files in a folder
function Remove-FolderContents {
    param([string]$Path, [string]$BaseFolder)
    
    $itemsRemoved = 0
    
    try {
        $items = Get-ChildItem -Path $Path -Force -ErrorAction Stop | Where-Object { 
            -not $_.Attributes.ToString().Contains("Hidden") -and 
            -not $_.Attributes.ToString().Contains("System")
        }
        
        foreach ($item in $items) {
            try {
                if ($item.PSIsContainer) {
                    # Recursively process subfolder
                    $subItems = Remove-FolderContents -Path $item.FullName -BaseFolder $BaseFolder
                    # Delete the now-empty folder
                    Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
                    $relativePath = $item.FullName.Replace($UserProfile, "").TrimStart('\')
                    Write-Log "Removed folder: $relativePath" "DELETE"
                    $itemsRemoved += $subItems + 1
                } else {
                    # Delete file and log it
                    Remove-Item -Path $item.FullName -Force -ErrorAction Stop
                    $relativePath = $item.FullName.Replace($UserProfile, "").TrimStart('\')
                    Write-Log "Removed file: $relativePath" "DELETE"
                    $itemsRemoved++
                }
            } catch {
                $relativePath = $item.FullName.Replace($UserProfile, "").TrimStart('\')
                Write-Log "Could not remove: $relativePath - $($_.Exception.Message)" "ERROR"
                $script:ErrorsEncountered++
            }
        }
    } catch {
        Write-Log "Error accessing path: $Path - $($_.Exception.Message)" "ERROR"
        $script:ErrorsEncountered++
    }
    
    return $itemsRemoved
}

# Define folders to clean
$FoldersToClean = @(
    "Downloads",
    "Documents", 
    "Pictures",
    "Music",
    "Videos",
    "Desktop",
    "OneDrive",
    "3D Objects",
    "Favorites",
    "Links",
    "Searches",
    "Saved Games"
)

Write-Log "Starting user profile cleanup for: $UserProfile"

$TotalItemsRemoved = 0
$ErrorsEncountered = 0

foreach ($Folder in $FoldersToClean) {
    $FullPath = Join-Path $UserProfile $Folder
    
    if (-not (Test-Path $FullPath)) {
        Write-Log "Folder does not exist: $Folder" "WARNING"
        continue
    }
    
    Write-Log "Cleaning folder: $Folder"
    
    $folderItems = Remove-FolderContents -Path $FullPath -BaseFolder $Folder
    $TotalItemsRemoved += $folderItems
    
    if ($folderItems -eq 0) {
        Write-Log "No items to remove in: $Folder" "INFO"
    } else {
        Write-Log "Removed $folderItems items from: $Folder" "INFO"
    }
}

# Summary
Write-Log "Cleanup completed. Total items removed: $TotalItemsRemoved, Errors: $ErrorsEncountered" "SUMMARY"
