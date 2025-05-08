import requests
from config import DISCORD_WEBHOOK_URL, DISCORD_MENTION_ID
from utils import log_info, log_error

def send_discord_notification(title, message, confidence=0):
    """
    ส่งข้อความไปยัง Discord ผ่าน Webhook
    พร้อม Mention หากเป็น Buy/Sell และแสดงคะแนนความน่าเชื่อถือ

    title: str, message: str, confidence: float (0-100)
    """
    if not DISCORD_WEBHOOK_URL:
        log_error("ไม่พบ Discord Webhook URL ใน config.py")
        return

    # เตรียม Mention ถ้าเป็น Buy หรือ Sell
    mention = ""
    if "BUY" in title or "SELL" in title:
        if hasattr(__import__('config'), 'DISCORD_MENTION_ID') and DISCORD_MENTION_ID:
            mention = f"<@{DISCORD_MENTION_ID}> "
        else:
            mention = "@here "

    # แสดง Confidence Score โดยตรง (0-100%)
    confidence_str = f"{confidence:.1f}%"
    full_message = (
        f"{mention}{message}\n"
        f"**ความน่าเชื่อถือ:** `{confidence_str}`"
    )

    data = {
        "embeds": [
            {
                "title": title,
                "description": full_message,
                "color": 0x00ff00 if "BUY" in title else (0xff0000 if "SELL" in title else 0x808080)
            }
        ]
    }

    try:
        response = requests.post(DISCORD_WEBHOOK_URL, json=data)
        if response.status_code == 204:
            log_info(f"แจ้งเตือน Discord เรียบร้อย: {title}")
        else:
            log_error(f"แจ้งเตือน Discord ไม่สำเร็จ: {response.status_code} - {response.text}")
    except Exception as e:
        log_error(f"เกิดข้อผิดพลาดขณะส่ง Discord: {e}")
