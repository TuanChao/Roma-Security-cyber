# 🚀 Quick Start Guide - Security Monitoring Agent System

## 📋 Prerequisites

Before starting, ensure you have:

```bash
✅ Python 3.10 or higher
✅ pip (Python package manager)
✅ OpenAI API Key (for AI features)
✅ Administrator/root privileges (for network monitoring)
```

## ⚡ Quick Setup (5 minutes)

### 1. **Install Dependencies**

```bash
cd C:\Users\Admin\Desktop\agent\backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install packages
pip install -r requirements.txt
```

### 2. **Configure Environment**

```bash
# Copy environment template
cp .env.example .env

# Edit .env file and add your OpenAI API key
```

**Minimum required in `.env`:**
```bash
OPENAI_API_KEY=sk-your-key-here
SECRET_KEY=your-secret-key-here
NETWORK_INTERFACE=eth0  # Change to your network interface
```

**Find your network interface:**
```bash
# Windows:
ipconfig

# Linux/Mac:
ifconfig
# or
ip addr show
```

### 3. **Start the Backend**

```bash
# Run with Python
python main.py

# Or with uvicorn directly
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server will start at: **http://localhost:8000**

## 🎯 Test the API

### Open API Documentation

Visit: **http://localhost:8000/docs**

Interactive Swagger UI will be available for testing all endpoints.

### Quick API Tests

#### 1. **Health Check**
```bash
curl http://localhost:8000/
```

#### 2. **Get Agents Status**
```bash
curl http://localhost:8000/api/agents/status
```

#### 3. **Start Network Monitor**
```bash
curl -X POST http://localhost:8000/api/network-monitor/start
```

#### 4. **Simulate Port Scan**
```bash
curl -X POST "http://localhost:8000/api/attack-simulator/port-scan?target=127.0.0.1" \
  -H "Content-Type: application/json" \
  -d '{"ports": [80, 443, 22]}'
```

#### 5. **Analyze Incident with AI**
```bash
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{
    "type": "port_scan",
    "source_ip": "192.168.1.100",
    "dest_ip": "192.168.1.1",
    "protocol": "TCP",
    "details": {
      "ports_scanned": [22, 23, 80, 443, 3389]
    }
  }'
```

## 🎨 Dashboard (Coming Soon)

The frontend React dashboard is under development. For now, use:

1. **Swagger UI**: http://localhost:8000/docs
2. **WebSocket Test**: Use a WebSocket client to connect to `ws://localhost:8000/ws`

## 🔥 Common Commands

### Start Individual Agents

```python
# In Python shell
from agents import NetworkMonitorAgent, AttackSimulatorAgent, AIResponseCoordinator

# Network Monitor
monitor = NetworkMonitorAgent(interface="eth0")
await monitor.start()

# Attack Simulator
simulator = AttackSimulatorAgent()
await simulator.start()
await simulator.simulate_port_scan("127.0.0.1", [80, 443])

# AI Coordinator
ai = AIResponseCoordinator()
await ai.start()
result = await ai.analyze_incident({
    "type": "port_scan",
    "source_ip": "192.168.1.100"
})
```

## 🎯 Example Workflows

### Workflow 1: Monitor Network & Auto-Respond

1. Start network monitor
2. Network monitor detects suspicious activity
3. AI coordinator analyzes the incident
4. Automatic response actions executed
5. Alert sent to administrators

### Workflow 2: Penetration Testing

1. Start attack simulator
2. Run port scan simulation
3. Run DDoS simulation (controlled)
4. Analyze results
5. Generate security report

### Workflow 3: Threat Analysis

1. Collect incident data
2. Submit to AI coordinator
3. Get threat assessment
4. Review recommended actions
5. Execute mitigation strategies

## 🐛 Troubleshooting

### Error: "Permission denied" when starting network monitor

**Solution**: Run with administrator/root privileges

```bash
# Windows (Run as Administrator)
python main.py

# Linux/Mac
sudo python main.py
```

### Error: "OpenAI API key not configured"

**Solution**: Add your API key to `.env` file

```bash
OPENAI_API_KEY=sk-your-actual-key-here
```

### Error: "Cannot find network interface"

**Solution**: Check and update interface name

```bash
# List available interfaces
# Windows: ipconfig
# Linux: ip addr show

# Update in .env
NETWORK_INTERFACE=your-interface-name
```

### Error: "Port 8000 already in use"

**Solution**: Change port in `.env` or kill existing process

```bash
# Change port
API_PORT=8001

# Or kill process (Linux/Mac)
lsof -ti:8000 | xargs kill -9

# Windows
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

## 📊 Monitoring Logs

Logs are saved to: `backend/logs/smas.log`

```bash
# View live logs
tail -f backend/logs/smas.log

# Windows (PowerShell)
Get-Content backend/logs/smas.log -Wait
```

## 🔐 Security Notes

⚠️ **IMPORTANT WARNINGS:**

1. **Only test on authorized networks**
2. **Attack simulation can be detected as real attacks**
3. **Use strong SECRET_KEY in production**
4. **Never expose API without authentication in production**
5. **Keep OpenAI API key secret**

## 🚀 Next Steps

1. ✅ Test all API endpoints
2. ✅ Run a port scan simulation
3. ✅ Analyze incidents with AI
4. ✅ Generate security reports
5. 🔜 Build custom dashboard
6. 🔜 Add more attack simulations
7. 🔜 Integrate with SIEM

## 📚 Full Documentation

- **API Docs**: http://localhost:8000/docs
- **README**: See `README.md` for architecture details
- **Code**: Explore `backend/agents/` for agent implementations

## 🆘 Need Help?

- Check logs: `backend/logs/smas.log`
- Review API docs: http://localhost:8000/docs
- Test with Swagger UI for interactive debugging

---

**Happy Security Testing! 🛡️**
