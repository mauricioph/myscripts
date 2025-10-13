#!/bin/bash

# Simplified Clean User Profile Script for macOS and Linux
USER_HOME="$HOME"
LOG_FILE="$USER_HOME/ProfileCleanup.log"

write_log() {
    local message="$1"
    local type="${2:-INFO}"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$type] $message" | tee -a "$LOG_FILE"
}

# Define folders to clean
folders_to_clean=(
    "Downloads"
    "Documents"
    "Pictures"
    "Music" 
    "Movies"
    "Desktop"
    "Public"
    "Applications"
    "Sites"
    "OneDrive"
)

write_log "Starting user profile cleanup for: $USER_HOME"

total_items_removed=0
errors_encountered=0

for folder in "${folders_to_clean[@]}"; do
    full_path="$USER_HOME/$folder"
    
    if [ ! -d "$full_path" ]; then
        write_log "Folder does not exist: $folder" "WARNING"
        continue
    fi
    
    write_log "Cleaning folder: $folder"
    
    # Find and remove all non-hidden items, logging each one
    while IFS= read -r item; do
        if [ -n "$item" ] && [ -e "$item" ]; then
            local relative_path="${item#$USER_HOME/}"
            if rm -rf "$item" 2>/dev/null; then
                if [ -d "$item" ]; then
                    write_log "Removed folder: $relative_path" "DELETE"
                else
                    write_log "Removed file: $relative_path" "DELETE"
                fi
                ((total_items_removed++))
            else
                write_log "Could not remove: $relative_path" "ERROR"
                ((errors_encountered++))
            fi
        fi
    done < <(find "$full_path" -mindepth 1 -maxdepth 1 ! -name ".*" 2>/dev/null)
    
done

write_log "Cleanup completed. Total items removed: $total_items_removed, Errors: $errors_encountered" "SUMMARY"
