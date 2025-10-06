# 🛡️ Security Monitoring Agent System (SMAS)

## 🎯 Overview

A comprehensive **Multi-Agent Security Monitoring and Attack Simulation Platform** powered by AI. The system provides real-time threat detection, attack simulation, log analysis, and intelligent response coordination.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│          Security Monitoring Platform               │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌──────────────┐  ┌──────────────────────────┐   │
│  │   Network    │  │   Threat Intelligence   │   │
│  │   Monitor    │  │       Agent             │   │
│  │   Agent      │  │  (AI Pattern Analysis)  │   │
│  └──────────────┘  └──────────────────────────┘   │
│                                                     │
│  ┌──────────────┐  ┌──────────────────────────┐   │
│  │   Attack     │  │     Log Parser          │   │
│  │  Simulator   │  │       Agent             │   │
│  │   Agent      │  │  (Anomaly Detection)    │   │
│  └──────────────┘  └──────────────────────────┘   │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │     AI Response Coordinator (GPT-4)         │  │
│  │  - Threat Analysis & Decision Making        │  │
│  │  - Auto Response & Mitigation               │  │
│  │  - Report Generation                        │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │     Real-time Dashboard (React + WebSocket) │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

## 🤖 Agents

### 1. **Network Monitor Agent**
- **Purpose**: Real-time network traffic monitoring
- **Capabilities**:
  - Port scanning detection
  - DDoS attack identification
  - Unusual traffic pattern detection
  - Protocol analysis (TCP/UDP/ICMP)
  - Bandwidth monitoring
- **Tech**: Python (Scapy, socket)

### 2. **Attack Simulator Agent**
- **Purpose**: Simulate various attack scenarios for testing
- **Capabilities**:
  - Port scanning simulation
  - DDoS simulation (controlled)
  - SQL injection attempts
  - Brute force attacks
  - Man-in-the-middle simulation
  - Honeypot deployment
- **Tech**: Python (Scapy, Nmap, custom scripts)

### 3. **Threat Intelligence Agent**
- **Purpose**: AI-powered threat analysis and prediction
- **Capabilities**:
  - Attack pattern recognition
  - Threat classification (ML models)
  - CVE database integration
  - IOC (Indicators of Compromise) detection
  - Behavioral analysis
  - Predictive threat modeling
- **Tech**: Python (scikit-learn, TensorFlow, OpenAI GPT-4)

### 4. **Log Parser Agent**
- **Purpose**: Parse and analyze system/network logs
- **Capabilities**:
  - Multi-format log parsing (syslog, JSON, CSV)
  - Anomaly detection
  - Pattern matching
  - Alert generation
  - Log correlation
  - Time-series analysis
- **Tech**: Python (pandas, regex, ELK stack compatible)

### 5. **AI Response Coordinator** (GPT-4 powered)
- **Purpose**: Intelligent decision-making and response
- **Capabilities**:
  - Threat severity assessment
  - Auto-response actions (block IP, isolate host)
  - Mitigation strategy recommendations
  - Incident report generation
  - Natural language incident explanation
  - Learning from past incidents
- **Tech**: Python + OpenAI GPT-4 + LangChain

## 🚀 Features

### Real-time Monitoring
- ✅ Live network traffic visualization
- ✅ Attack detection and alerts
- ✅ System health monitoring
- ✅ Geographic threat mapping

### Attack Simulation
- ✅ Configurable attack scenarios
- ✅ Controlled penetration testing
- ✅ Honeypot system
- ✅ Vulnerability assessment

### AI-Powered Analysis
- ✅ Pattern recognition
- ✅ Anomaly detection
- ✅ Threat prediction
- ✅ Automated response

### Dashboard & Reporting
- ✅ Real-time metrics
- ✅ Attack timeline visualization
- ✅ Threat heatmaps
- ✅ Automated reports
- ✅ Export to PDF/CSV
- ✅ **Dark/Light Mode** - Seamless theme switching with localStorage persistence

## 📦 Tech Stack

### Backend (Python)
```
- Scapy          # Packet manipulation
- Nmap           # Network scanning
- pandas         # Data analysis
- scikit-learn   # ML models
- FastAPI        # REST API
- WebSocket      # Real-time communication
- OpenAI API     # GPT-4 integration
- LangChain      # AI orchestration
- MongoDB        # Database
- Redis          # Caching & message queue
```

### Frontend (TypeScript/React)
```
- React 18       # UI framework
- TypeScript     # Type safety
- Vite           # Build tool
- Socket.io      # Real-time updates
- Chart.js       # Data visualization
- Tailwind CSS   # Styling with Dark/Light mode
- Recharts       # Advanced charts
- React Context  # Theme management
```

## 🔧 Installation

### Prerequisites
```bash
- Python 3.10+
- Node.js 18+
- MongoDB
- Redis
- OpenAI API Key
```

### Backend Setup
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
# Configure .env with your API keys
python main.py
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

## 🎮 Usage

### Start Monitoring
```python
from agents import NetworkMonitorAgent

monitor = NetworkMonitorAgent(interface="eth0")
monitor.start()
```

### Simulate Attack
```python
from agents import AttackSimulatorAgent

simulator = AttackSimulatorAgent()
simulator.simulate_port_scan(target="192.168.1.1", ports=[80, 443, 22])
```

### Analyze Threat
```python
from agents import ThreatIntelligenceAgent

threat_agent = ThreatIntelligenceAgent()
analysis = threat_agent.analyze_pattern(packet_data)
print(f"Threat Level: {analysis['severity']}")
print(f"Recommendation: {analysis['action']}")
```

### AI Response
```python
from agents import AIResponseCoordinator

coordinator = AIResponseCoordinator(openai_key="your-key")
response = await coordinator.handle_incident({
    "type": "port_scan",
    "source_ip": "192.168.1.100",
    "target_ports": [22, 23, 3389]
})
print(response.action)  # "Block source IP immediately"
print(response.explanation)
```

## 📊 Dashboard Views

1. **Dashboard** - System overview with real-time statistics
2. **Network Monitor** - Live network traffic analysis
3. **Attack Simulator** - Configure and run attack simulations
4. **Threat Analysis** - AI-powered threat detection
5. **Reports** - Generated incident reports
6. **AI Chat - Roma** - Intelligent cybersecurity assistant powered by Gemini 2.0 Flash

### 🎨 Theme Support
- **Dark Mode** (Default) - Optimized for low-light environments
- **Light Mode** - Professional bright interface
- Seamless switching with smooth animations
- Theme preference saved to localStorage
- Consistent colors across all pages

## 🔒 Security Features

- **Zero Trust Architecture**
- **Encrypted communications**
- **Role-based access control**
- **Audit logging**
- **Sandboxed attack simulations**

## 🧪 Attack Scenarios

### Supported Attack Types
1. **Network Attacks**
   - Port Scanning
   - DDoS/DoS
   - ARP Spoofing
   - DNS Poisoning
   - Packet Sniffing

2. **Web Attacks**
   - SQL Injection
   - XSS (Cross-Site Scripting)
   - CSRF
   - Path Traversal

3. **Authentication**
   - Brute Force
   - Credential Stuffing
   - Session Hijacking

4. **Malware Simulation**
   - Ransomware behavior
   - Backdoor detection
   - C&C communication patterns

## 🤝 Integration

### SIEM Integration
- Export to Splunk
- ELK Stack compatible
- QRadar integration
- Custom webhook support

### Automation
- Python SDK
- REST API
- WebSocket streams
- CLI tools

## 📈 Roadmap

- [ ] Phase 1: Core Agents (Network, Attack Sim, Log Parser)
- [ ] Phase 2: AI Integration (Threat Intel, Response Coordinator)
- [ ] Phase 3: Dashboard & Visualization
- [ ] Phase 4: Advanced ML Models
- [ ] Phase 5: Cloud Integration (AWS/Azure)
- [ ] Phase 6: Mobile App

## 🚨 Disclaimer

**IMPORTANT**: This tool is for **educational and authorized security testing only**.

⚠️ **DO NOT use for:**
- Unauthorized network scanning
- Attacking systems you don't own
- Illegal penetration testing
- Malicious activities

Always obtain proper authorization before conducting security assessments.

## 📄 License

MIT License - See LICENSE file

## 🤝 Contributing

Contributions welcome! Please read CONTRIBUTING.md

---

**Built with 🛡️ for Cybersecurity Research & Defense**
