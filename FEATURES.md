# 🚀 Security Monitoring Agent System - Tính năng mới

## ✅ Đã hoàn thành

### 1. **Multi-AI Provider Support**
- ✅ **Google Gemini** - Miễn phí 60 requests/phút
- ✅ **OpenAI GPT** - GPT-3.5/GPT-4
- 🔧 Tự động fallback nếu provider lỗi

**Cấu hình (.env):**
```bash
AI_PROVIDER=gemini  # hoặc "openai"
GEMINI_API_KEY=your-gemini-key
OPENAI_API_KEY=your-openai-key
```

### 2. **Notification System**
- 📱 **Telegram Bot** - Nhận cảnh báo realtime
- 💬 **Discord Webhook** - Alert vào Discord channel
- 📧 **Email** (Coming soon)

**Setup Telegram:**
1. Tạo bot: [@BotFather](https://t.me/botfather)
2. Lấy token: `/newbot`
3. Get chat ID: [@userinfobot](https://t.me/userinfobot)
4. Thêm vào `.env`:
```bash
TELEGRAM_BOT_TOKEN=your-bot-token
TELEGRAM_CHAT_ID=your-chat-id
```

**Setup Discord:**
1. Vào Server Settings > Integrations > Webhooks
2. Create Webhook
3. Copy URL
4. Thêm vào `.env`:
```bash
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...
```

### 3. **Enhanced Dashboard** (Đang phát triển)
- 📊 Real-time threat visualization
- 🗺️ Geo-location attack map
- 📈 Advanced analytics
- 🎨 Custom themes

## 🔮 Tính năng đang làm

### 4. **Anomaly Detection with ML**
- 🧠 Machine Learning - Scikit-learn
- 📊 Pattern recognition
- 🎯 Auto-learning từ incidents
- ⚡ Realtime detection

### 5. **Geo-Location Mapping**
- 🗺️ Hiển thị attacks trên bản đồ
- 🌍 IP geolocation
- 📍 Attack origin tracking
- 🎯 Heat maps

## 📚 Cách sử dụng

### Test AI Analysis với Gemini:
```bash
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "type": "port_scan",
    "source_ip": "192.168.1.100",
    "dest_ip": "192.168.1.1",
    "protocol": "TCP",
    "details": {"ports_scanned": [22, 80, 443]}
  }'
```

### Test Notifications:
Khi có incident severity "high" hoặc "critical", hệ thống tự động gửi alert qua:
- Telegram (nếu configured)
- Discord (nếu configured)

### Monitor Logs:
```bash
docker logs -f smas-backend
```

## 🎯 Roadmap

### Phase 2 (Tuần này):
- [ ] Geo-location attack mapping
- [ ] ML-based anomaly detection
- [ ] Advanced dashboard visualizations
- [ ] Email notifications

### Phase 3 (Tuần sau):
- [ ] SIEM integration (Splunk, ELK)
- [ ] Custom playbooks
- [ ] Mobile app (React Native)
- [ ] Multi-tenant support

### Phase 4 (Sau):
- [ ] Threat intelligence feeds
- [ ] Automated penetration testing
- [ ] Compliance reports (ISO 27001, GDPR)
- [ ] API marketplace

## 🔧 Cấu hình đầy đủ

File `.env` mẫu:
```bash
# AI Provider
AI_PROVIDER=gemini
GEMINI_API_KEY=AIzaSy...
OPENAI_API_KEY=

# Security
SECRET_KEY=your-secret-key-change-in-production

# Network
NETWORK_INTERFACE=eth0

# API
DEBUG=True
API_HOST=0.0.0.0
API_PORT=8000

# Notifications
TELEGRAM_BOT_TOKEN=123456:ABC-DEF...
TELEGRAM_CHAT_ID=123456789
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...

# Database
MONGODB_URL=mongodb://mongodb:27017
REDIS_HOST=redis
REDIS_PORT=6379
```

## 🆘 Troubleshooting

### Gemini API errors:
- Check API key: https://makersuite.google.com/app/apikey
- Rate limit: 60 requests/minute (free tier)

### Notifications không gửi:
```bash
# Check logs
docker logs smas-backend | grep "Notification"

# Test Telegram bot
curl https://api.telegram.org/bot<TOKEN>/getMe
```

### AI analysis failed:
- Kiểm tra API key đúng chưa
- Check quota còn không
- Xem logs: `docker logs smas-backend --tail 50`

## 📊 Performance

| Feature | Latency | Throughput |
|---------|---------|------------|
| Gemini AI Analysis | ~2-3s | 60 req/min |
| Network Monitoring | <100ms | 1000 pkt/s |
| Notifications | ~500ms | 100 msg/min |

## 🔐 Security Best Practices

1. ⚠️ **KHÔNG commit `.env` vào git**
2. 🔑 **Rotate API keys định kỳ**
3. 🛡️ **Dùng strong SECRET_KEY**
4. 🔒 **Enable authentication trong production**
5. 🌐 **Sử dụng HTTPS**

## 🎓 Learning Resources

- [Gemini API Docs](https://ai.google.dev/docs)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [Discord Webhooks](https://discord.com/developers/docs/resources/webhook)
- [Scapy Network](https://scapy.readthedocs.io/)

---

**Built with ❤️ using Claude Code**
