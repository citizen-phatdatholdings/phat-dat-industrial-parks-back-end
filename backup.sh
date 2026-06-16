#!/bin/bash
set -e

# Load environment variables from .env if present
if [ -f .env ]; then
  echo "==> Loading environment variables from .env..."
  while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    # Export variable
    export "$line"
  done < .env
fi

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TEMP_DIR="$BACKUP_DIR/temp_$TIMESTAMP"
ARCHIVE_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
RCLONE_DEST="gdrive:phat-dat-backups"

mkdir -p "$TEMP_DIR"

echo "==> Backing up database..."
if ! docker compose exec -T postgres pg_dump -U "${DB_USER:-directus}" "${DB_DATABASE:-directus}" > "$TEMP_DIR/db.sql"; then
  echo "==> [Error] Failed to dump PostgreSQL database."
  rm -rf "$TEMP_DIR"
  exit 1
fi

echo "==> Backing up uploads volume..."
if ! docker compose run --rm -v directus-uploads:/data -v "$(pwd)/$TEMP_DIR:/backup" --entrypoint "" postgres tar czf /backup/uploads.tar.gz -C /data .; then
  echo "==> [Warning] Failed to backup uploads volume."
  # Create an empty tarball to prevent failures during restore
  tar -czf "$TEMP_DIR/uploads.tar.gz" -T /dev/null
fi

echo "==> Backing up extensions volume..."
if ! docker compose run --rm -v directus-extensions:/data -v "$(pwd)/$TEMP_DIR:/backup" --entrypoint "" postgres tar czf /backup/extensions.tar.gz -C /data .; then
  echo "==> [Warning] Failed to backup extensions volume."
  tar -czf "$TEMP_DIR/extensions.tar.gz" -T /dev/null
fi

echo "==> Copying configuration files..."
[ -f .env ] && cp .env "$TEMP_DIR/.env"
[ -f docker-compose.yml ] && cp docker-compose.yml "$TEMP_DIR/docker-compose.yml"
if [ -d mail_templates ]; then
  cp -r mail_templates "$TEMP_DIR/mail_templates"
fi

echo "==> Compressing all backup components into one archive..."
tar -czf "$ARCHIVE_FILE" -C "$TEMP_DIR" .

# Clean up temp folder
rm -rf "$TEMP_DIR"

echo "==> Backup archive created: $ARCHIVE_FILE"

echo "==> Uploading to Google Drive..."
if command -v rclone &>/dev/null; then
  if rclone copy "$ARCHIVE_FILE" "$RCLONE_DEST/" 2>/dev/null; then
    echo "==> Upload complete: $RCLONE_DEST/$(basename "$ARCHIVE_FILE")"
  else
    echo "==> [!] rclone copy failed. Backup saved locally only."
  fi
else
  echo "==> [!] rclone not found. Backup saved locally only."
fi

echo "==> Done!"
ls -lh "$ARCHIVE_FILE"

