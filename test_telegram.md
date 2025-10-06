# 📱 Test Telegram Notification

## Bước 1: Setup Telegram Bot

### Tạo Bot
1. Mở Telegram, tìm **@BotFather**
2. Gửi lệnh: `/newbot`
3. Đặt tên bot: `Security Alert Bot`
4. Đặt username: `your_security_bot` (phải kết thúc bằng `bot`)
5. Copy **TOKEN** mà BotFather gửi

### Lấy Chat ID
1. Mở bot vừa tạo, gửi tin nhắn `/start`
2. Truy cập URL (thay YOUR_TOKEN):
   ```
   https://api.telegram.org/botYOUR_TOKEN/getUpdates
   ```
3. Tìm `"chat":{"id":123456789}` trong JSON
4. Copy số `123456789` (đây là CHAT_ID)

---

## Bước 2: Cập nhật .env

Mở file `.env` và thêm:
```bash
TELEGRAM_BOT_TOKEN=123456789:ABCdefGHIjklMNOpqrsTUVwxyz
TELEGRAM_CHAT_ID=123456789
```

Sau đó restart backend:
```bash
docker-compose restart backend
```

---

## Bước 3: Test với incident HIGH severity

### Test 1: DDoS Attack (High Severity)
```bash
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "type": "ddos",
    "source_ip": "203.0.113.100",
    "dest_ip": "192.168.1.1",
    "protocol": "TCP",
    "details": {
      "packet_rate": 50000,
      "duration": 300,
      "target_port": 80
    }
  }'
```

### Test 2: Brute Force (Critical Severity)
```bash
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "type": "brute_force",
    "source_ip": "198.51.100.50",
    "dest_ip": "192.168.1.10",
    "protocol": "SSH",
    "details": {
      "failed_attempts": 500,
      "target_service": "SSH",
      "duration": 60
    }
  }'
```

### Test 3: Data Exfiltration (Critical)
```bash
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "type": "data_exfiltration",
    "source_ip": "192.168.1.50",
    "dest_ip": "203.0.113.200",
    "protocol": "HTTPS",
    "details": {
      "data_size_mb": 5000,
      "suspicious_destination": true,
      "encrypted": true
    }
  }'
```

---

## Bước 4: Kiểm tra Telegram

Sau khi chạy các lệnh test trên:
- ✅ Bạn sẽ nhận được alert trên Telegram bot
- 🟠 Alert có màu sắc theo severity (High = Orange, Critical = Red)
- 📊 Có đầy đủ thông tin: IP, loại tấn công, phân tích AI, hành động cần làm

---

## Ví dụ Alert trên Telegram:

```
🔴 SECURITY ALERT - CRITICAL

Incident Type: data_exfiltration
Source IP: 192.168.1.50
Target: 203.0.113.200
Protocol: HTTPS
Time: 2025-10-06 01:15:30

Analysis: Large-scale data exfiltration detected. 5GB of data
transferred to suspicious external IP via encrypted channel...

Immediate Actions:
• Immediately block outbound connection to 203.0.113.200
• Isolate host 192.168.1.50 from network
• Initiate forensic analysis
• Alert security team

Mitigation: Implement DLP (Data Loss Prevention) solution...

🤖 Powered by Google Gemini AI
```

---

## Troubleshooting

### Không nhận được alert?
1. Kiểm tra TOKEN và CHAT_ID đúng chưa
2. Kiểm tra đã restart backend chưa: `docker logs smas-backend --tail 20`
3. Test bot thủ công:
   ```bash
   curl "https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text=Test"
   ```

### Alert chỉ gửi khi nào?
- Chỉ gửi khi severity là **HIGH** hoặc **CRITICAL**
- Low và Medium không gửi notification (để tránh spam)

---

## 🎯 Next Steps

Sau khi Telegram hoạt động, bạn có thể:
1. Setup Discord webhook (tương tự)
2. Tùy chỉnh message format
3. Thêm email notification
4. Tạo dashboard để xem lịch sử alerts
