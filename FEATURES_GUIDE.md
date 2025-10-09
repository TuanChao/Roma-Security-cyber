# 📘 HƯỚNG DẪN SỬ DỤNG CHI TIẾT - Security Monitoring Agent System (SMAS)

## 📋 MỤC LỤC
1. [Tổng quan hệ thống](#tổng-quan-hệ-thống)
2. [Các tính năng chính](#các-tính-năng-chính)
3. [Hướng dẫn sử dụng từng tính năng](#hướng-dẫn-sử-dụng-từng-tính-năng)
4. [API Endpoints](#api-endpoints)
5. [Cấu hình nâng cao](#cấu-hình-nâng-cao)

---

## 🎯 TỔNG QUAN HỆ THỐNG

**Security Monitoring Agent System (SMAS)** là nền tảng giám sát bảo mật đa agent, tích hợp AI để phát hiện, mô phỏng và phân tích các mối đe dọa an ninh mạng theo thời gian thực.

### Kiến trúc:
```
Frontend (React + TypeScript) ←→ Backend (FastAPI) ←→ AI Services (Gemini 2.0 Flash)
                ↓                            ↓
         WebSocket Updates           Multi-Agent System
```

---

## 🚀 CÁC TÍNH NĂNG CHÍNH

### 1. 📊 **Dashboard - Tổng Quan Hệ Thống**
**Mục đích:** Hiển thị toàn bộ trạng thái hệ thống và số liệu quan trọng

**Tính năng:**
- ✅ **Real-time Statistics Cards:**
  - Active Agents (Số agent đang hoạt động)
  - Total Threats (Tổng số mối đe dọa)
  - Packets Analyzed (Số gói tin đã phân tích)
  - System Uptime (Thời gian hoạt động)

- ✅ **Threat Activity Chart:**
  - Biểu đồ đường thời gian thực
  - Hiển thị hoạt động đe dọa theo giờ
  - Cập nhật liên tục

- ✅ **Threat Distribution Pie Chart:**
  - Phân loại các loại tấn công (Port Scan, DDoS, Brute Force, etc.)
  - Tỷ lệ phần trăm từng loại
  - Màu sắc phân biệt rõ ràng

- ✅ **Agents Status:**
  - Trạng thái từng agent (Running/Stopped)
  - Số events đã xử lý
  - Indicator màu xanh/đỏ

- ✅ **Recent Alerts:**
  - 5 cảnh báo gần nhất
  - Mức độ nghiêm trọng (Critical/High/Medium)
  - Timestamp chi tiết

**Cách sử dụng:**
1. Vào trang Dashboard (trang chủ)
2. Xem tổng quan các chỉ số quan trọng
3. Click vào từng card để xem chi tiết
4. Theo dõi biểu đồ theo thời gian thực

---

### 2. 🌐 **Network Monitor - Giám Sát Mạng**
**Mục đích:** Theo dõi lưu lượng mạng và phát hiện bất thường

**Tính năng:**
- ✅ **Start/Stop Monitoring:**
  - Nút bật/tắt giám sát
  - Status banner hiển thị trạng thái
  - Real-time capture

- ✅ **Network Statistics:**
  - Total Packets (Tổng số gói tin)
  - Active IPs (Số IP đang hoạt động)
  - Total Alerts (Tổng cảnh báo)
  - Protocols Count (Số giao thức)

- ✅ **Protocol Distribution:**
  - Phân tích theo protocol (TCP, UDP, ICMP, HTTP, etc.)
  - Số lượng packets mỗi protocol
  - Grid view dễ nhìn

- ✅ **Security Alerts Table:**
  - Bảng danh sách alerts
  - Thông tin: Time, Type, Source IP, Severity, Status
  - Màu sắc phân biệt severity
  - Hover effect để xem chi tiết

**Cách sử dụng:**
1. Click nút **"Start Monitoring"** màu xanh
2. Hệ thống bắt đầu capture packets
3. Xem statistics cập nhật real-time
4. Kiểm tra Protocol Distribution
5. Theo dõi Security Alerts table
6. Click **"Stop Monitoring"** để dừng

**API Endpoint:**
```bash
# Start
POST /api/network-monitor/start

# Stop
POST /api/network-monitor/stop

# Get Statistics
GET /api/network-monitor/statistics

# Get Alerts
GET /api/network-monitor/alerts?limit=10
```

---

### 3. ⚡ **Attack Simulator - Mô Phỏng Tấn Công**
**Mục đích:** Kiểm tra khả năng phòng thủ bằng cách mô phỏng các cuộc tấn công

**⚠️ CẢNH BÁO:** Chỉ sử dụng trên mạng được ủy quyền!

**Tính năng:**

#### 📍 **Tab 1: Port Scan**
- **Cấu hình:**
  - Target IP (IP đích)
  - Ports (danh sách port, phân cách bằng dấu phẩy)
  - Scan Type: SYN Scan (Stealthy) / Connect Scan / UDP Scan

- **Kết quả hiển thị:**
  - Target IP
  - Total Ports scanned
  - Open Ports (danh sách port mở)
  - Status (completed/failed)

#### 💥 **Tab 2: DDoS Simulation**
- **Cấu hình:**
  - Target IP
  - Duration (giây, max 300s)
  - Packet Rate (packets/second)

- **Kết quả hiển thị:**
  - Packets Sent
  - Duration
  - Average Rate

#### 📡 **Tab 3: Ping Sweep**
- **Cấu hình:**
  - Network (CIDR notation, vd: 192.168.1.0/24)

- **Kết quả hiển thị:**
  - Alive Hosts (số lượng)
  - Total Scanned
  - List of alive hosts

#### 📚 **Common Attack Types**
- Hiển thị 8 loại tấn công phổ biến:
  1. SQL Injection
  2. XSS Attack
  3. Phishing
  4. Ransomware
  5. MITM Attack
  6. Brute Force
  7. Malware
  8. Data Exfiltration
- Mỗi loại có description ngắn gọn
- Border màu khác nhau để phân biệt

**Cách sử dụng:**
1. Chọn tab tương ứng (Port Scan / DDoS / Ping Sweep)
2. Điền thông tin Target và cấu hình
3. Click nút **"Start..."** (màu blue/red/purple)
4. Chờ simulation hoàn thành
5. Xem kết quả ở panel bên phải
6. Kiểm tra Common Attack Types để học thêm

**API Endpoints:**
```bash
# Port Scan
POST /api/attack-simulator/port-scan
Body: {
  "target": "127.0.0.1",
  "ports": [80, 443, 22],
  "scan_type": "syn"
}

# DDoS
POST /api/attack-simulator/ddos
Body: {
  "target": "127.0.0.1",
  "duration": 10,
  "packet_rate": 100
}

# Ping Sweep
POST /api/attack-simulator/ping-sweep
Body: {
  "network": "192.168.1.0/24"
}

# Get Simulations
GET /api/attack-simulator/simulations?limit=10

# Stop Simulation
POST /api/attack-simulator/stop
```

---

### 4. 🧠 **Threat Analysis - Phân Tích Mối Đe Dọa (AI-Powered)**
**Mục đích:** Sử dụng AI để phân tích và đánh giá các mối đe dọa

**Tính năng:**
- ✅ **AI-Powered Analysis:**
  - Tự động phân loại threats
  - Đánh giá mức độ nguy hiểm
  - Gợi ý phương án xử lý

- ✅ **Threat Classification:**
  - Critical (Nghiêm trọng)
  - High (Cao)
  - Medium (Trung bình)
  - Low (Thấp)

- ✅ **Incident Details:**
  - Timestamp
  - Source IP
  - Target
  - Attack type
  - AI analysis result

- ✅ **Response Recommendations:**
  - Suggested actions
  - Mitigation steps
  - Block rules

**Cách sử dụng:**
1. Vào trang Threat Analysis
2. Xem danh sách incidents
3. Click vào incident để xem chi tiết
4. Đọc AI analysis
5. Follow recommendations

**API Endpoint:**
```bash
# Analyze Incident
POST /api/ai/analyze
Body: {
  "type": "port_scan",
  "source_ip": "192.168.1.100",
  "target_ip": "192.168.1.1",
  "timestamp": "2025-01-07T...",
  "details": {...}
}

# Get Statistics
GET /api/ai/statistics
```

---

### 5. 📑 **Reports - Báo Cáo**
**Mục đích:** Tạo và quản lý báo cáo bảo mật

**Tính năng:**
- ✅ **Generate Reports:**
  - Incident reports
  - Timeframe selection (24h, 7d, 30d)
  - Custom date range

- ✅ **Report Contents:**
  - Executive Summary
  - Incident Timeline
  - Threat Analysis
  - Recommendations
  - Statistics & Charts

- ✅ **Export Options:**
  - PDF format
  - CSV format
  - JSON format

**Cách sử dụng:**
1. Vào trang Reports
2. Chọn timeframe hoặc custom range
3. Click **"Generate Report"**
4. Xem preview
5. Click **"Export"** để tải xuống

**API Endpoint:**
```bash
# Generate Report
POST /api/ai/report
Body: {
  "incident_ids": ["id1", "id2"],
  "timeframe": "24h"
}
```

---

### 6. 💬 **AI Chat - Roma Assistant**
**Mục đích:** Trợ lý AI hỗ trợ về cybersecurity

**Tính năng:**
- ✅ **Powered by Gemini 2.0 Flash:**
  - Response nhanh
  - Hiểu context tốt
  - Trả lời chính xác

- ✅ **Cybersecurity Expert:**
  - Giải thích về threats
  - Best practices
  - Mitigation strategies
  - Tool recommendations
  - Vulnerability explanations

- ✅ **Conversation History:**
  - Lưu context cuộc hội thoại
  - Follow-up questions
  - Consistent answers

- ✅ **Quick Questions:**
  - "What is a DDoS attack?"
  - "How to prevent SQL injection?"
  - "Explain ransomware attacks"
  - "Best practices for network security"
  - "What is a zero-day vulnerability?"

- ✅ **Chat Interface:**
  - User messages: Red bubble
  - AI messages: Gray bubble (light) / Dark gray (dark mode)
  - Timestamps
  - Typing indicator
  - Auto-scroll

**Cách sử dụng:**
1. Vào trang **AI Chat - Roma**
2. Đọc welcome message
3. Click Quick Question hoặc nhập câu hỏi
4. Nhấn Enter hoặc click nút Send (icon máy bay)
5. Chờ Roma trả lời (loading animation)
6. Tiếp tục hỏi follow-up questions
7. Roma sẽ nhớ context để trả lời chính xác hơn

**Ví dụ câu hỏi:**
- "What is the difference between DDoS and DoS?"
- "How can I protect against SQL injection?"
- "Explain zero-day vulnerabilities"
- "What are the best practices for password security?"
- "How does a firewall work?"
- "What is penetration testing?"

**API Endpoint:**
```bash
# Chat
POST /api/ai/chat
Body: {
  "message": "What is a DDoS attack?",
  "conversation_history": [
    {"role": "user", "content": "..."},
    {"role": "assistant", "content": "..."}
  ]
}
```

---

## 🎨 **7. Dark/Light Mode - Chuyển Đổi Giao Diện**

**Tính năng:**
- ✅ **Seamless Theme Switching:**
  - Toggle button ở sidebar (Desktop)
  - Toggle button ở header (Mobile)
  - Icon thay đổi: ☀️ Sun (light mode) / 🌙 Moon (dark mode)
  - Animation mượt mà 300ms

- ✅ **Dark Mode (Default):**
  - Background: Gradient gray-900 → gray-800
  - Cards: gray-800/30 opacity
  - Text: White/Gray
  - Optimized cho làm việc đêm

- ✅ **Light Mode:**
  - Background: Gradient blue-50 → indigo-50 → purple-50
  - Cards: white/80 opacity
  - Text: Gray-900/Gray-700
  - Professional và sáng sủa

- ✅ **Persistent:**
  - Lưu vào localStorage
  - Auto-load khi refresh
  - Consistent trên tất cả pages

**Cách sử dụng:**
1. Tìm nút toggle theme (có icon Sun/Moon):
   - Desktop: Ở sidebar, phía dưới trên System Status
   - Mobile: Ở header bar, góc phải
2. Click nút để chuyển đổi
3. Theme thay đổi ngay lập tức với animation
4. Preference được lưu tự động
5. Tất cả pages sẽ theo theme đã chọn

---

## 🔧 CÁC TÍNH NĂNG KỸ THUẬT

### WebSocket Real-time Updates
**Endpoint:** `ws://localhost:8000/ws`

**Tính năng:**
- Auto-reconnect khi mất kết nối
- Update mỗi 2 giây
- Broadcast alerts tức thì
- Status updates của tất cả agents

**Cách sử dụng:**
```javascript
const ws = new WebSocket('ws://localhost:8000/ws');

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  console.log('Update:', data);
};
```

### Agent System
**3 Agents chính:**

1. **Network Monitor Agent**
   - Interface: Configurable
   - Packet capture với Scapy
   - Pattern detection
   - Real-time alerts

2. **Attack Simulator Agent**
   - Controlled simulations
   - Safety limits (max duration: 300s)
   - Multiple attack types
   - Result tracking

3. **AI Coordinator Agent**
   - Gemini 2.0 Flash integration
   - Incident analysis
   - Report generation
   - Chat functionality

---

## 📚 API ENDPOINTS TỔNG HỢP

### System
```bash
GET  /                           # Health check
GET  /api/agents/status          # All agents status
GET  /api/agents/{name}/health   # Specific agent health
GET  /api/dashboard/overview     # Dashboard data
```

### Network Monitor
```bash
POST /api/network-monitor/start       # Start monitoring
POST /api/network-monitor/stop        # Stop monitoring
GET  /api/network-monitor/statistics  # Get stats
GET  /api/network-monitor/alerts      # Get alerts
```

### Attack Simulator
```bash
POST /api/attack-simulator/port-scan   # Port scan
POST /api/attack-simulator/ddos        # DDoS sim
POST /api/attack-simulator/ping-sweep  # Ping sweep
GET  /api/attack-simulator/simulations # Get history
POST /api/attack-simulator/stop        # Stop sim
```

### AI Coordinator
```bash
POST /api/ai/analyze      # Analyze incident
POST /api/ai/chat         # Chat with Roma
POST /api/ai/report       # Generate report
GET  /api/ai/statistics   # Get AI stats
```

### WebSocket
```bash
WS   /ws                  # Real-time updates
```

---

## ⚙️ CẤU HÌNH NÂNG CAO

### Environment Variables (.env)
```bash
# API Settings
API_HOST=localhost
API_PORT=8000
DEBUG=true

# Network
NETWORK_INTERFACE=eth0
ENABLE_ATTACK_SIM=true
MAX_SIMULATION_DURATION=300

# AI
GEMINI_API_KEY=your_gemini_api_key
AI_MODEL=gemini-2.0-flash

# Database
MONGODB_URL=mongodb://localhost:27017
DATABASE_NAME=security_monitoring

# Logging
LOG_LEVEL=INFO
LOG_FILE=logs/smas.log
LOG_ROTATION=100 MB
```

### Safety Features
- ✅ Attack simulation duration limits
- ✅ IP whitelist/blacklist
- ✅ Rate limiting
- ✅ Sandboxed execution
- ✅ Audit logging
- ✅ Role-based access (future)

---

## 🎯 WORKFLOW ĐIỂN HÌNH

### Scenario 1: Monitoring & Detection
1. Start Network Monitor
2. Observe real-time statistics
3. Alert tự động xuất hiện khi có bất thường
4. AI Coordinator phân tích alert
5. Xem recommendations
6. Generate report

### Scenario 2: Penetration Testing
1. Vào Attack Simulator
2. Configure target (authorized network)
3. Run Port Scan
4. Analyze results
5. Run additional tests (DDoS, Ping Sweep)
6. Document findings

### Scenario 3: Threat Investigation
1. Alert xuất hiện trên Dashboard
2. Vào Threat Analysis
3. Xem AI analysis
4. Chat với Roma để hiểu sâu hơn
5. Follow recommendations
6. Generate incident report

### Scenario 4: Learning & Research
1. Vào AI Chat
2. Hỏi về các loại attacks
3. Học best practices
4. Tham khảo mitigation strategies
5. Kiểm tra Attack Simulator để thực hành

---

## 🚀 TIPS & BEST PRACTICES

1. **Luôn start Network Monitor trước khi test**
2. **Sử dụng localhost (127.0.0.1) để test an toàn**
3. **Check logs thường xuyên:** `backend/logs/smas.log`
4. **Generate report định kỳ:** Mỗi tuần/tháng
5. **Chat với Roma khi có thắc mắc:** Roma rất thông minh!
6. **Sử dụng Dark Mode khi làm việc đêm** - giảm mỏi mắt
7. **Export reports để lưu trữ:** PDF format recommended
8. **Monitor WebSocket connection:** Đảm bảo real-time updates

---

## 🔐 BẢO MẬT

- ✅ CORS configured
- ✅ Input validation
- ✅ SQL injection prevention
- ✅ XSS protection
- ✅ Rate limiting (future)
- ✅ Authentication (future)
- ✅ HTTPS support (production)

---

## 📞 HỖ TRỢ

**Issues:** https://github.com/your-repo/issues
**Documentation:** https://docs.example.com
**AI Assistant:** Sử dụng AI Chat trong app!

---

**🛡️ Built for Cybersecurity Research & Defense**
**⚡ Powered by Gemini 2.0 Flash AI**
**💻 Made with React + FastAPI + TypeScript**
