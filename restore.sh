#!/bin/bash
set -e

BACKUP_DIR="./backups"

echo "Available backups:"
ls -1 "$BACKUP_DIR" 2>/dev/null || echo "(none)"

read -rp "DB backup file (db_*.sql): " DB_FILE
read -rp "Uploads backup file (uploads_*.tar.gz): " UPLOADS_FILE

if [ -n "$DB_FILE" ] && [ -f "$BACKUP_DIR/$DB_FILE" ]; then
  echo "==> Restoring database..."
  docker compose exec -T postgres psql -U "${DB_USER:-directus}" -d "${DB_DATABASE:-directus}" < "$BACKUP_DIR/$DB_FILE"
fi

if [ -n "$UPLOADS_FILE" ] && [ -f "$BACKUP_DIR/$UPLOADS_FILE" ]; then
  echo "==> Restoring uploads..."
  docker run --rm -v directus-uploads:/data -v "$(pwd)/$BACKUP_DIR:/backup" alpine tar xzf "/backup/$UPLOADS_FILE" -C /data
fi

echo "==> Restore complete. Restarting Directus..."
docker compose restart directus
