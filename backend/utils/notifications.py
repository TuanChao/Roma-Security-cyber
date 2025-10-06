"""
Notification System - Send alerts via Telegram, Email, Discord
"""

from typing import Dict, Any, List, Optional
from loguru import logger
import aiohttp
import asyncio
from datetime import datetime

from config.settings import settings


class NotificationService:
    """Multi-channel notification service"""

    def __init__(self):
        self.telegram_bot_token = getattr(settings, 'TELEGRAM_BOT_TOKEN', '')
        self.telegram_chat_id = getattr(settings, 'TELEGRAM_CHAT_ID', '')
        self.discord_webhook = getattr(settings, 'DISCORD_WEBHOOK_URL', '')
        self.enabled_channels = []

        # Check which channels are configured
        if self.telegram_bot_token and self.telegram_chat_id:
            self.enabled_channels.append('telegram')
        if self.discord_webhook:
            self.enabled_channels.append('discord')

        logger.info(f"📢 Notification channels enabled: {self.enabled_channels or ['none']}")

    async def send_alert(self, incident: Dict[str, Any], severity: str = "medium") -> bool:
        """Send security alert to all configured channels"""
        if not self.enabled_channels:
            logger.debug("No notification channels configured")
            return False

        # Format alert message
        message = self._format_alert_message(incident, severity)

        tasks = []
        if 'telegram' in self.enabled_channels:
            tasks.append(self._send_telegram(message, severity))
        if 'discord' in self.enabled_channels:
            tasks.append(self._send_discord(message, severity))

        results = await asyncio.gather(*tasks, return_exceptions=True)
        success = any(r is True for r in results)

        return success

    def _format_alert_message(self, incident: Dict[str, Any], severity: str) -> str:
        """Format incident as alert message with HTML for Telegram"""
        severity_emoji = {
            'low': '🟢',
            'medium': '🟡',
            'high': '🟠',
            'critical': '🔴'
        }.get(severity.lower(), '⚪')

        # Get AI analysis from incident if available
        ai_analysis = incident.get('ai_analysis', {})
        incident_type = incident.get('type', 'Unknown').replace('_', ' ').title()

        # Build immediate actions list
        actions = ai_analysis.get('immediate_actions', ['Monitor the situation'])
        actions_html = '\n'.join([f'  {i+1}. {action}' for i, action in enumerate(actions)])

        confidence = int(ai_analysis.get('confidence', 0.5) * 100)

        message = f"""
🚨 <b>SECURITY ALERT</b> {severity_emoji}

━━━━━━━━━━━━━━━━━━━━
<b>📊 INCIDENT DETAILS</b>
━━━━━━━━━━━━━━━━━━━━

🔸 <b>Type:</b> {incident_type}
🔸 <b>Severity:</b> {severity.upper()}
🔸 <b>Source IP:</b> <code>{incident.get('source_ip', 'N/A')}</code>
🔸 <b>Target IP:</b> <code>{incident.get('dest_ip', 'N/A')}</code>
🔸 <b>Protocol:</b> {incident.get('protocol', 'N/A')}
🔸 <b>Time:</b> {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

━━━━━━━━━━━━━━━━━━━━
<b>🤖 AI ANALYSIS</b>
━━━━━━━━━━━━━━━━━━━━

{ai_analysis.get('explanation', 'AI analysis in progress...')}

━━━━━━━━━━━━━━━━━━━━
<b>⚡ IMMEDIATE ACTIONS</b>
━━━━━━━━━━━━━━━━━━━━

{actions_html}

━━━━━━━━━━━━━━━━━━━━
<b>🛡️ MITIGATION</b>
━━━━━━━━━━━━━━━━━━━━

{ai_analysis.get('mitigation', 'Review security policies and implement monitoring')}

━━━━━━━━━━━━━━━━━━━━

📈 <b>Confidence:</b> {confidence}%
⚡ <i>Powered by Roma AI Security</i>
        """.strip()

        return message

    async def _send_telegram(self, message: str, severity: str) -> bool:
        """Send alert via Telegram with HTML formatting"""
        try:
            url = f"https://api.telegram.org/bot{self.telegram_bot_token}/sendMessage"

            payload = {
                'chat_id': self.telegram_chat_id,
                'text': message,
                'parse_mode': 'HTML',
                'disable_web_page_preview': True
            }

            async with aiohttp.ClientSession() as session:
                async with session.post(url, json=payload) as response:
                    if response.status == 200:
                        logger.debug("✓ Telegram alert sent with HTML formatting")
                        return True
                    else:
                        error_text = await response.text()
                        logger.warning(f"Telegram send failed: {response.status} - {error_text}")
                        return False

        except Exception as e:
            logger.error(f"Telegram notification error: {e}")
            return False

    async def _send_discord(self, message: str, severity: str) -> bool:
        """Send alert via Discord webhook"""
        try:
            # Color based on severity
            color_map = {
                'low': 0x00FF00,      # Green
                'medium': 0xFFFF00,   # Yellow
                'high': 0xFF9900,     # Orange
                'critical': 0xFF0000  # Red
            }
            color = color_map.get(severity.lower(), 0x808080)

            embed = {
                "embeds": [{
                    "title": f"🚨 Security Alert - {severity.upper()}",
                    "description": message,
                    "color": color,
                    "timestamp": datetime.now().isoformat()
                }]
            }

            async with aiohttp.ClientSession() as session:
                async with session.post(self.discord_webhook, json=embed) as response:
                    if response.status in [200, 204]:
                        logger.debug("✓ Discord alert sent")
                        return True
                    else:
                        logger.warning(f"Discord send failed: {response.status}")
                        return False

        except Exception as e:
            logger.error(f"Discord notification error: {e}")
            return False

    async def send_summary_report(self, stats: Dict[str, Any]) -> bool:
        """Send daily/weekly summary report"""
        message = f"""
📊 **SECURITY SUMMARY REPORT**

**Period**: {stats.get('period', 'Last 24 hours')}
**Total Incidents**: {stats.get('total_incidents', 0)}
**Critical**: {stats.get('critical', 0)}
**High**: {stats.get('high', 0)}
**Medium**: {stats.get('medium', 0)}
**Low**: {stats.get('low', 0)}

**Top Threats**:
{chr(10).join([f"• {threat}" for threat in stats.get('top_threats', [])])}

**Top Source IPs**:
{chr(10).join([f"• {ip}" for ip in stats.get('top_ips', [])])}
        """.strip()

        return await self.send_alert(
            {'type': 'summary_report', 'ai_analysis': {'explanation': message}},
            'medium'
        )


# Global notification service
notification_service = NotificationService()
