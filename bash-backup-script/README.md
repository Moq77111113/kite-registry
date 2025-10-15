# Bash Backup Script

Dead simple backup script for files and MySQL databases with automatic rotation.

## Features

- ✅ Backs up multiple directories
- ✅ MySQL database dumps
- ✅ Automatic old backup cleanup
- ✅ Optional S3 upload
- ✅ Colored output
- ✅ Error handling
- ✅ Simple configuration

## Quick Start

### 1. Make executable
```bash
chmod +x backup.sh
```

### 2. Edit configuration
```bash
# Edit the script directly or create backup.conf
nano backup.sh

# Change these variables:
BACKUP_DIR="/var/backups"
DIRS_TO_BACKUP="/var/www /etc/nginx"
DB_NAME="myapp"
DB_PASSWORD="your_password"
```

### 3. Run backup
```bash
sudo ./backup.sh
```

## Configuration

### Directories to Backup
```bash
DIRS_TO_BACKUP="/var/www /etc/nginx /home/user/data"
```

### Database Backup
```bash
DB_HOST="localhost"
DB_USER="backup_user"
DB_PASSWORD="your_secure_password"
DB_NAME="myapp"
```

### Retention Period
```bash
RETENTION_DAYS=7  # Keep backups for 7 days
```

### S3 Upload (Optional)
```bash
S3_BUCKET="s3://my-backups"  # Leave empty to disable
```

## Automated Backups with Cron

### Daily at 2 AM
```bash
# Edit crontab
sudo crontab -e

# Add this line
0 2 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
```

### Every 6 hours
```bash
0 */6 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
```

### Weekly (Sunday at 3 AM)
```bash
0 3 * * 0 /path/to/backup.sh >> /var/log/backup.log 2>&1
```

## Backup Structure

```
/var/backups/
├── files_www_20241011_020000.tar.gz
├── files_nginx_20241011_020000.tar.gz
├── db_myapp_20241011_020000.sql.gz
├── files_www_20241010_020000.tar.gz
└── ...
```

## S3 Setup (Optional)

### Install AWS CLI
```bash
# Ubuntu/Debian
sudo apt install awscli

# macOS
brew install awscli
```

### Configure AWS credentials
```bash
aws configure
```

### Set S3 bucket in script
```bash
S3_BUCKET="s3://my-backups"
```

## Database User Setup

Create a dedicated backup user:

```sql
CREATE USER 'backup_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER ON myapp.* TO 'backup_user'@'localhost';
FLUSH PRIVILEGES;
```

## Restore from Backup

### Restore files
```bash
# Extract backup
tar -xzf /var/backups/files_www_20241011_020000.tar.gz -C /

# Or to specific location
tar -xzf /var/backups/files_www_20241011_020000.tar.gz -C /tmp/restore
```

### Restore database
```bash
# Decompress and restore
gunzip < /var/backups/db_myapp_20241011_020000.sql.gz | mysql -u root -p myapp
```

## Monitor Backups

### Check backup size
```bash
du -sh /var/backups
```

### List recent backups
```bash
ls -lht /var/backups | head -10
```

### Test backup integrity
```bash
# Test tar file
tar -tzf /var/backups/files_www_20241011_020000.tar.gz > /dev/null

# Test SQL file
gunzip -t /var/backups/db_myapp_20241011_020000.sql.gz
```

## Disk Space Warning

Backups can grow large! Monitor disk space:

```bash
# Add to cron before backup
df -h /var/backups | awk 'NR==2 {if ($5+0 > 80) print "Warning: Backup disk usage at "$5}'
```

## Security

- Store `backup.conf` with restricted permissions: `chmod 600 backup.conf`
- Use a dedicated database user with minimal permissions
- Consider encrypting backups: `gpg -c backup.tar.gz`
- Keep off-site backups (S3 or another server)

## Troubleshooting

### Permission Denied
```bash
# Run with sudo
sudo ./backup.sh

# Or fix permissions
sudo chown -R $USER:$USER /var/backups
```

### Database Connection Failed
- Check credentials
- Verify database user has permissions
- Test manually: `mysqldump -u backup_user -p myapp`

### Disk Full
- Reduce `RETENTION_DAYS`
- Clear old backups manually: `rm /var/backups/files_*.tar.gz`
- Move to larger partition

## That's It!

Simple, effective backups. No complex tools required. Just bash.
