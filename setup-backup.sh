#!/bin/bash
set -e

echo "==> Installing rclone..."
if ! command -v rclone &>/dev/null; then
  curl https://rclone.org/install.sh | sudo bash
fi

echo "==> Configuring Google Drive..."
echo "Follow the browser to authorize rclone."
echo "When asked, select:"
echo "  - n) New remote"
echo "  - name: gdrive"
echo "  - type: 13 (Google Drive)"
echo "  - client_id: (leave blank)"
echo "  - client_secret: (leave blank)"
echo "  - scope: 1 (full access)"
echo "  - root_folder_id: (leave blank)"
echo "  - service_account_file: (leave blank)"
echo "  - Edit advanced config: n)"
echo "  - Use auto config: y)"
echo ""
read -rp "Press Enter to start rclone config..." _
rclone config

echo ""
echo "==> Testing connection..."
rclone ls gdrive: 2>/dev/null && echo "OK" || echo "Create remote 'gdrive' first"

echo ""
echo "==> Done. Run 'npm run backup' to test."
