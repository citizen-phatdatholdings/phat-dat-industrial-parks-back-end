#!/bin/bash
set -e

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DB_FILE="$BACKUP_DIR/db_$TIMESTAMP.sql"
UPLOADS_FILE="$BACKUP_DIR/uploads_$TIMESTAMP.tar.gz"
RCLONE_DEST="gdrive:phat-dat-backups"

mkdir -p "$BACKUP_DIR"

echo "==> Backing up database..."
docker compose exec -T postgres pg_dump -U "${DB_USER:-directus}" "${DB_DATABASE:-directus}" > "$DB_FILE"

echo "==> Backing up uploads..."
docker run --rm -v directus-uploads:/data -v "$(pwd)/$BACKUP_DIR:/backup" alpine tar czf "/backup/uploads_$TIMESTAMP.tar.gz" -C /data .

echo "==> Uploading to Google Drive..."
if command -v rclone &>/dev/null; then
  rclone copy "$DB_FILE" "$RCLONE_DEST/db/"
  rclone copy "$UPLOADS_FILE" "$RCLONE_DEST/uploads/"
  echo "==> Upload complete: gdrive:phat-dat-backups/"
else
  echo "==> [!] rclone not found. Backups saved locally only."
fi

echo "==> Done:"
ls -lh "$DB_FILE" "$UPLOADS_FILE"
