# 🚀 Complete Installation Guide

## 📋 System Requirements

- **Python**: 3.10 or higher
- **Node.js**: 18 or higher
- **npm**: 9 or higher
- **OpenAI API Key**: Required for AI features
- **OS**: Windows, Linux, or macOS
- **Privileges**: Administrator/root (for network monitoring)

## 🎯 Full Setup (Backend + Frontend)

### Step 1: Backend Setup

```bash
# Navigate to backend
cd C:\Users\Admin\Desktop\agent\backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt
```

### Step 2: Configure Environment

```bash
# Copy environment template
cp .env.example .env
```

**Edit `.env` file with your settings:**

```bash
# Required Settings
OPENAI_API_KEY=sk-your-openai-key-here
SECRET_KEY=your-random-secret-key-123456789

# Network Configuration
NETWORK_INTERFACE=eth0  # Change to your interface (see below)

# Optional Settings
DEBUG=True
API_PORT=8000
MONGODB_URL=mongodb://localhost:27017
REDIS_HOST=localhost
```

**Find Your Network Interface:**

```bash
# Windows
ipconfig
# Look for "Ethernet adapter" or "Wi-Fi adapter" name

# Linux
ip addr show
# or
ifconfig

# Mac
ifconfig
# Look for en0, en1, etc.
```

### Step 3: Start Backend Server

```bash
# Make sure you're in backend/ directory
python main.py

# Or with uvicorn directly
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Backend will start at: **http://localhost:8000**

### Step 4: Frontend Setup

**Open NEW terminal** (keep backend running):

```bash
# Navigate to frontend
cd C:\Users\Admin\Desktop\agent\frontend

# Install Node.js dependencies
npm install

# This may take 2-3 minutes...
```

### Step 5: Start Frontend

```bash
# Still in frontend/ directory
npm run dev
```

Frontend will start at: **http://localhost:3000**

## 🎉 Access the Application

1. **Backend API**: http://localhost:8000
2. **API Documentation**: http://localhost:8000/docs
3. **Frontend Dashboard**: http://localhost:3000

## ✅ Verify Installation

### Test Backend

```bash
# In new terminal
curl http://localhost:8000/

# Should return: {"status": "running", ...}
```

### Test Frontend

Open browser: **http://localhost:3000**

You should see the Security Monitoring Dashboard.

## 🔧 Troubleshooting

### Backend Issues

#### Error: "No module named 'fastapi'"

**Solution**: Install dependencies

```bash
pip install -r requirements.txt
```

#### Error: "Permission denied" (network monitoring)

**Solution**: Run with administrator privileges

```bash
# Windows: Run PowerShell/CMD as Administrator
python main.py

# Linux/Mac
sudo python main.py
```

#### Error: "Port 8000 already in use"

**Solution**: Change port in `.env`

```bash
API_PORT=8001
```

#### Error: "OpenAI API key not configured"

**Solution**: Add key to `.env`

```bash
OPENAI_API_KEY=sk-your-actual-key-here
```

### Frontend Issues

#### Error: "Cannot find module"

**Solution**: Clear cache and reinstall

```bash
rm -rf node_modules
rm package-lock.json
npm install
```

#### Error: "Port 3000 already in use"

**Solution**: Use different port

```bash
# Edit vite.config.ts
server: {
  port: 3001
}
```

#### Error: "Failed to fetch"

**Solution**: Make sure backend is running on port 8000

```bash
# Check if backend is running
curl http://localhost:8000/
```

### Network Interface Issues

#### Can't find interface name

**Windows**:
```powershell
Get-NetAdapter | Select-Object Name, InterfaceDescription
```

**Linux**:
```bash
ip link show
```

**Mac**:
```bash
networksetup -listallhardwareports
```

## 🐳 Docker Installation (Alternative)

### Coming Soon

Docker compose setup for easy deployment.

## 📊 Optional: MongoDB & Redis

### Install MongoDB (Optional)

**Windows**:
- Download from https://www.mongodb.com/try/download/community
- Install and start service

**Linux**:
```bash
sudo apt-get install mongodb
sudo systemctl start mongodb
```

**Mac**:
```bash
brew install mongodb-community
brew services start mongodb-community
```

### Install Redis (Optional)

**Windows**:
- Download from https://github.com/microsoftarchive/redis/releases
- Or use WSL2

**Linux**:
```bash
sudo apt-get install redis-server
sudo systemctl start redis
```

**Mac**:
```bash
brew install redis
brew services start redis
```

## 🔐 Security Configuration

### Generate Secure SECRET_KEY

```python
# In Python shell
import secrets
print(secrets.token_urlsafe(32))
```

### Configure Firewall

```bash
# Windows Firewall: Allow port 8000
netsh advfirewall firewall add rule name="SMAS API" dir=in action=allow protocol=TCP localport=8000

# Linux UFW
sudo ufw allow 8000/tcp
```

## 🚀 Production Deployment

### Backend

```bash
# Install production server
pip install gunicorn

# Run with Gunicorn
gunicorn main:app --workers 4 --bind 0.0.0.0:8000
```

### Frontend

```bash
# Build for production
npm run build

# Serve with static server
npm install -g serve
serve -s dist -p 3000
```

## 📝 Environment Variables Reference

### Backend (.env)

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `OPENAI_API_KEY` | ✅ Yes | - | OpenAI API key |
| `SECRET_KEY` | ✅ Yes | - | JWT secret key |
| `NETWORK_INTERFACE` | ✅ Yes | eth0 | Network interface name |
| `API_HOST` | No | 0.0.0.0 | API bind address |
| `API_PORT` | No | 8000 | API port |
| `DEBUG` | No | True | Debug mode |
| `MONGODB_URL` | No | mongodb://localhost:27017 | MongoDB connection |
| `REDIS_HOST` | No | localhost | Redis host |

### Frontend (.env)

```bash
VITE_API_URL=http://localhost:8000
VITE_WS_URL=ws://localhost:8000
```

## 🎓 Next Steps

1. ✅ Access Dashboard: http://localhost:3000
2. ✅ Read API Docs: http://localhost:8000/docs
3. ✅ Try Network Monitoring
4. ✅ Run Attack Simulations
5. ✅ Test AI Analysis
6. ✅ Generate Reports

## 🆘 Get Help

- Check logs: `backend/logs/smas.log`
- API docs: http://localhost:8000/docs
- Browser console: F12 (for frontend errors)

## 🎯 Quick Test Script

```bash
# Test backend
curl http://localhost:8000/api/agents/status

# Test port scan
curl -X POST "http://localhost:8000/api/attack-simulator/port-scan?target=127.0.0.1"

# Test AI analysis
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{"type":"port_scan","source_ip":"192.168.1.100"}'
```

---

**Installation complete! 🎉 Start monitoring your network security!**
