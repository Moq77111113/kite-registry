#!/bin/bash

# Simple Backup Script
# Backs up files and databases with rotation

set -e  # Exit on error

# Configuration
BACKUP_DIR="/var/backups"
RETENTION_DAYS=7
DATE=$(date +%Y%m%d_%H%M%S)

# Directories to backup (space-separated)
DIRS_TO_BACKUP="/var/www /etc/nginx /home/user/important"

# Database credentials
DB_HOST="localhost"
DB_USER="backup_user"
DB_PASSWORD="your_password"
DB_NAME="myapp"

# S3 Upload (optional, leave empty to disable)
S3_BUCKET=""  # e.g., "s3://my-backups"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Create backup directory
mkdir -p "$BACKUP_DIR"

log "Starting backup..."

# Backup files
log "Backing up files..."
for dir in $DIRS_TO_BACKUP; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        backup_file="$BACKUP_DIR/files_${dir_name}_${DATE}.tar.gz"

        log "  - $dir → $backup_file"
        tar -czf "$backup_file" "$dir" 2>/dev/null || warning "Failed to backup $dir"
    else
        warning "Directory not found: $dir"
    fi
done

# Backup database
if command -v mysqldump &> /dev/null; then
    log "Backing up MySQL database..."
    backup_file="$BACKUP_DIR/db_${DB_NAME}_${DATE}.sql.gz"

    mysqldump -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" | gzip > "$backup_file"

    if [ $? -eq 0 ]; then
        log "  - Database backed up to $backup_file"
    else
        error "Database backup failed!"
    fi
else
    warning "mysqldump not found, skipping database backup"
fi

# Upload to S3 (if configured)
if [ -n "$S3_BUCKET" ] && command -v aws &> /dev/null; then
    log "Uploading to S3..."
    aws s3 sync "$BACKUP_DIR" "$S3_BUCKET/backups/" --exclude "*" --include "*${DATE}*"

    if [ $? -eq 0 ]; then
        log "  - Uploaded to $S3_BUCKET"
    else
        error "S3 upload failed!"
    fi
fi

# Remove old backups
log "Cleaning up old backups (older than $RETENTION_DAYS days)..."
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +$RETENTION_DAYS -delete

log "✓ Backup completed successfully!"

# Show backup summary
log "Backup summary:"
du -sh "$BACKUP_DIR"
ls -lh "$BACKUP_DIR" | grep "$DATE"
