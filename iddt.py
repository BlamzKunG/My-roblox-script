from utils import log_info

def calculate_confidence(scores):
    base = 50
    bonus = sum(scores)
    # clamp between 10 and 99
    return max(10, min(base + bonus, 99))


def analyze_signal(df):
    """
    วิเคราะห์จากอินดิเคเตอร์ เพื่อให้สัญญาณ Buy, Sell หรือ Hold
    กลยุทธ์อัปเกรด:
      - MACD Cross + RSI + EMA200 + VWAP + OBV
      - Price Breakout EMA200
      - RSI Oversold/Overbought Reversal
      - OBV Divergence
      - Trend Continuation with ATR
    """
    if df is None or len(df) < 3:
        return "HOLD", "ข้อมูลไม่เพียงพอสำหรับการวิเคราะห์", 0

    latest = df.iloc[-1]
    previous = df.iloc[-2]
    before_prev = df.iloc[-3]

    # ดึงค่าที่จำเป็น
    macd = latest.get('MACD')
    signal_line = latest.get('Signal')
    macd_prev = previous.get('MACD')
    signal_prev = previous.get('Signal')
    rsi = latest.get('RSI')
    ema200 = latest.get('EMA_200')
    close = latest.get('close')
    prev_close = previous.get('close')
    vwap = latest.get('VWAP')
    obv = latest.get('OBV')
    obv_prev = previous.get('OBV')
    obv_prev2 = before_prev.get('OBV')
    atr = latest.get('ATR')
    mean_atr = df['ATR'].mean() if 'ATR' in df.columns else None

    # HELPER: ฟังก์ชันตรวจสอบค่าพร้อมเปรียบเทียบ
    def is_valid(*args):
        return all(arg is not None for arg in args)

    # เก็บคะแนนสำหรับ confidence
    scores = []

    # STRATEGY 1: Intelligent MACD Cross
    if is_valid(macd_prev, signal_prev, macd, signal_line, rsi, ema200, close, vwap, obv, obv_prev) and \
       macd_prev < signal_prev and macd > signal_line and 50 < rsi < 70 and close > ema200 and close > vwap and obv > obv_prev:
        scores = [10, 15, 10]
        log_info("พบสัญญาณซื้อ (Buy) แบบ MACD + RSI + EMA + OBV")
        return "BUY", f"MACD↑, RSI: {rsi:.2f}, Close > EMA200 & VWAP, OBV↑", calculate_confidence(scores)

    # STRATEGY 2: Price Breakout EMA200
    if is_valid(ema200, close, prev_close) and prev_close <= ema200 < close:
        scores = [20]
        log_info("พบสัญญาณซื้อ (Buy) จาก Breakout EMA200")
        return "BUY", f"Breakout EMA200: {prev_close:.2f} → {close:.2f}", calculate_confidence(scores)

    # STRATEGY 3: RSI Reversal from Oversold
    prev_rsi = previous.get('RSI')
    if is_valid(prev_rsi, rsi) and prev_rsi < 30 < rsi:
        scores = [15]
        log_info("พบสัญญาณซื้อ (Buy) จาก RSI Oversold Reversal")
        return "BUY", f"RSI Reversal: {prev_rsi:.2f} → {rsi:.2f}", calculate_confidence(scores)

    # STRATEGY 4: OBV Divergence
    if is_valid(obv_prev2, obv_prev, obv, prev_close, before_prev.get('close'), close) and \
       before_prev['close'] > prev_close > close and obv_prev2 < obv_prev < obv:
        scores = [10]
        log_info("พบสัญญาณซื้อ (Buy) จาก OBV Divergence")
        return "BUY", "ราคา ↓ แต่ OBV ↑ → อาจเกิด Divergence", calculate_confidence(scores)

    # STRATEGY 5: Trend Continuation with ATR
    if is_valid(atr, mean_atr, ema200, close) and atr > mean_atr * 1.2 and close > ema200:
        scores = [10]
        log_info("พบสัญญาณซื้อ (Buy) จากแนวโน้มต่อเนื่อง (ATR + EMA)")
        return "BUY", f"ATR: {atr:.2f}, แนวโน้มแข็งแกร่งต่อเนื่อง", calculate_confidence(scores)

    # STRATEGY 6: Intelligent Sell (MACD + RSI + EMA + OBV)
    if is_valid(macd_prev, signal_prev, macd, signal_line, rsi, ema200, close, vwap, obv, obv_prev) and \
       macd_prev > signal_prev and macd < signal_line and 30 < rsi < 50 and close < ema200 and close < vwap and obv < obv_prev:
        scores = [10, 15, 10]
        log_info("พบสัญญาณขาย (Sell) แบบ MACD + RSI + EMA + OBV")
        return "SELL", f"MACD↓, RSI: {rsi:.2f}, Close < EMA200 & VWAP, OBV↓", calculate_confidence(scores)

    # STRATEGY 7: RSI Overbought Reversal
    if is_valid(prev_rsi, rsi) and prev_rsi > 70 > rsi:
        scores = [15]
        log_info("พบสัญญาณขาย (Sell) จาก RSI Overbought Reversal")
        return "SELL", f"RSI Reversal: {prev_rsi:.2f} → {rsi:.2f}", calculate_confidence(scores)

    # STRATEGY 8: Break Below EMA200
    if is_valid(ema200, close, prev_close) and prev_close >= ema200 > close:
        scores = [20]
        log_info("พบสัญญาณขาย (Sell) จาก Breakdown EMA200")
        return "SELL", f"Breakdown EMA200: {prev_close:.2f} → {close:.2f}", calculate_confidence(scores)

    # HOLD
    scores = []
    log_info("ยังไม่พบสัญญาณที่ชัดเจน (Hold)")
    return "HOLD", f"MACD: {macd:.2f}, RSI: {rsi:.2f}, Close: {close:.2f}", calculate_confidence(scores)
