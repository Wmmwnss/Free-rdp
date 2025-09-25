#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Starting tmate session..."

# Khởi tạo tmate
tmate -F -n railway-session &
sleep 2

# In ra URL web + SSH (tmate cung cấp qua socket)
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

WEB_URL=$(tmate -S /tmp/tmate.sock display -p '#{tmate-web}')
SSH_URL=$(tmate -S /tmp/tmate.sock display -p '#{tmate-ssh}')

echo "----------------------------------------"
echo "[TMATE] Web URL : $WEB_URL"
echo "[TMATE] SSH URL : $SSH_URL"
echo "Share link này cho ai cũng được (có full quyền CLI)."
echo "----------------------------------------"

# Giữ container chạy
wait
