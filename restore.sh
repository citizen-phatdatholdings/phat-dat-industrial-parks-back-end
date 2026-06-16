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
FORCE=false
SELECTED_BACKUP=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -y|--force) FORCE=true ;;
    *) SELECTED_BACKUP="$1" ;;
  esac
  shift
done

# If backup file is not passed, prompt user
if [ -z "$SELECTED_BACKUP" ]; then
  echo "Available backups:"
  # Use mapfile or loop to get array on macOS-safe bash
  BACKUPS=()
  while IFS= read -r line; do
    [ -n "$line" ] && BACKUPS+=("$line")
  done < <(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | sort -r || true)

  if [ ${#BACKUPS[@]} -eq 0 ]; then
    echo "No backups found in $BACKUP_DIR"
    exit 1
  fi

  for i in "${!BACKUPS[@]}"; do
    filename=$(basename "${BACKUPS[$i]}")
    if [ $i -eq 0 ]; then
      echo "  $((i+1))*) $filename (latest)"
    else
      echo "  $((i+1)))  $filename"
    fi
  done

  if [ "$FORCE" = true ]; then
    SELECTED_BACKUP="${BACKUPS[0]}"
  else
    read -rp "Select a backup to restore (default: 1): " selection
    selection=${selection:-1}
    
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "${#BACKUPS[@]}" ]; then
      echo "Invalid selection."
      exit 1
    fi
    SELECTED_BACKUP="${BACKUPS[$((selection-1))]}"
  fi
fi

if [ ! -f "$SELECTED_BACKUP" ]; then
  if [ -f "$BACKUP_DIR/$SELECTED_BACKUP" ]; then
    SELECTED_BACKUP="$BACKUP_DIR/$SELECTED_BACKUP"
  else
    echo "Error: Backup file $SELECTED_BACKUP not found."
    exit 1
  fi
fi

echo "==> Selected backup: $SELECTED_BACKUP"

if [ "$FORCE" != true ]; then
  read -rp "Are you sure you want to restore? This will overwrite existing database and volume data! (y/N): " confirm
  if [[ ! "$confirm" =~ ^[yY](es)?$ ]]; then
    echo "Restoration aborted."
    exit 0
  fi
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TEMP_DIR="$BACKUP_DIR/temp_restore_$TIMESTAMP"
mkdir -p "$TEMP_DIR"

echo "==> Extracting backup components..."
tar -xzf "$SELECTED_BACKUP" -C "$TEMP_DIR"

# Restore env if requested / missing
if [ -f "$TEMP_DIR/.env" ]; then
  if [ ! -f .env ]; then
    echo "==> Restoring missing .env file..."
    cp "$TEMP_DIR/.env" .env
  else
    if ! diff -q .env "$TEMP_DIR/.env" &>/dev/null; then
      if [ "$FORCE" = true ]; then
        echo "==> Overwriting .env due to force flag..."
        cp "$TEMP_DIR/.env" .env
      else
        read -rp "The backed up .env differs from current .env. Overwrite current .env? (y/N): " restore_env
        if [[ "$restore_env" =~ ^[yY](es)?$ ]]; then
          echo "==> Overwriting .env..."
          cp "$TEMP_DIR/.env" .env
        fi
      fi
    fi
  fi
fi

echo "==> Stopping Directus service..."
docker compose stop directus

echo "==> Dropping and recreating public database schema..."
docker compose exec -T postgres psql -U "${DB_USER:-directus}" -d "${DB_DATABASE:-directus}" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

echo "==> Restoring database from SQL dump..."
if ! docker compose exec -T postgres psql -U "${DB_USER:-directus}" -d "${DB_DATABASE:-directus}" < "$TEMP_DIR/db.sql" &>/dev/null; then
  echo "==> Running verbose database restore..."
  docker compose exec -T postgres psql -U "${DB_USER:-directus}" -d "${DB_DATABASE:-directus}" < "$TEMP_DIR/db.sql"
fi

echo "==> Clearing and restoring uploads volume..."
docker compose run --rm -v directus-uploads:/data --entrypoint "" postgres sh -c "rm -rf /data/* /data/.* 2>/dev/null || true"
docker compose run --rm -v directus-uploads:/data -v "$(pwd)/$TEMP_DIR:/backup" --entrypoint "" postgres tar xzf /backup/uploads.tar.gz -C /data

echo "==> Clearing and restoring extensions volume..."
docker compose run --rm -v directus-extensions:/data --entrypoint "" postgres sh -c "rm -rf /data/* /data/.* 2>/dev/null || true"
docker compose run --rm -v directus-extensions:/data -v "$(pwd)/$TEMP_DIR:/backup" --entrypoint "" postgres tar xzf /backup/extensions.tar.gz -C /data

if [ -d "$TEMP_DIR/mail_templates" ]; then
  echo "==> Restoring mail templates..."
  rm -rf mail_templates
  cp -r "$TEMP_DIR/mail_templates" ./mail_templates
fi

# Clean up temp folder
rm -rf "$TEMP_DIR"

echo "==> Starting all services..."
docker compose up -d

echo "==> Restore complete!"

