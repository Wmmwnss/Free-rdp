#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Bắt đầu phiên tmate với chế độ do thám..."

# Khởi tạo tmate chạy nền
tmate -F -n railway-session &
sleep 2

# Lấy link kết nối
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

WEB_URL=$(tmate -S /tmp/tmate.sock display -p '#{tmate-web}')
SSH_URL=$(tmate -S /tmp/tmate.sock display -p '#{tmate-ssh}')

# --- TÌNH BÁO HỆ THỐNG ---
# Gửi thông tin tình báo vào chính cửa sổ tmate
(
    sleep 5 # Đợi tmate sẵn sàng hoàn toàn
    tmate -S /tmp/tmate.sock send-keys "echo '--- [BÁO CÁO TÌNH BÁO HỆ THỐNG] ---'" C-m
    tmate -S /tmp/tmate.sock send-keys "echo '>> Đang kiểm tra đặc quyền và filesystem...'" C-m
    tmate -S /tmp/tmate.sock send-keys "ls -la /" C-m
    tmate -S /tmp/tmate.sock send-keys "df -h" C-m
    tmate -S /tmp/tmate.sock send-keys "echo '>> Kiểm tra tiến trình đang chạy bên ngoài...'" C-m
    tmate -S /tmp/tmate.sock send-keys "ps aux" C-m
    tmate -S /tmp/tmate.sock send-keys "echo '>> Kiểm tra đặc quyền (Capabilities)...'" C-m
    tmate -S /tmp/tmate.sock send-keys "capsh --print" C-m
    tmate -S /tmp/tmate.sock send-keys "echo '>> Thông tin mạng và IP của máy chủ...'" C-m
    tmate -S /tmp/tmate.sock send-keys "ip a" C-m
    tmate -S /tmp/tmate.sock send-keys "echo '--- [KẾT THÚC BÁO CÁO] ---'" C-m
    tmate -S /tmp/tmate.sock send-keys "echo 'Giờ anh có thể tự do khám phá. Use sudo -l to see your powers.'" C-m
) &

echo "----------------------------------------"
echo "[TMATE] Web URL : $WEB_URL"
echo "[TMATE] SSH URL : $SSH_URL"
echo "Kết nối vào link trên. Báo cáo tình báo sẽ tự động hiển thị."
echo "----------------------------------------"

# Giữ container chạy
wait
