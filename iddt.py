import pandas as pd
import numpy as np
from utils import log_info, log_error


def prepare_dataframe(raw_data):
    """แปลงข้อมูลจาก JSON ให้เป็น DataFrame และจัดการประเภทข้อมูล"""
    df = pd.DataFrame(raw_data)
    df['datetime'] = pd.to_datetime(df['datetime'])
    df = df.sort_values('datetime')  # จัดเรียงจากเวลาเก่า -> ใหม่

    # แปลงค่าตัวเลขหลักให้เป็น float
    for col in ['open', 'high', 'low', 'close']:
        df[col] = pd.to_numeric(df[col], errors='coerce')

    # ตรวจสอบว่ามี volume หรือไม่
    if 'volume' in df.columns:
        df['volume'] = pd.to_numeric(df['volume'], errors='coerce')
    else:
        log_error("ไม่มีคอลัมน์ 'volume' ในข้อมูลที่รับมา")

    return df


def calculate_ema(df, period=14):
    df[f'EMA_{period}'] = df['close'].ewm(span=period, adjust=False).mean()
    return df


def calculate_macd(df):
    df['EMA_12'] = df['close'].ewm(span=12, adjust=False).mean()
    df['EMA_26'] = df['close'].ewm(span=26, adjust=False).mean()
    df['MACD'] = df['EMA_12'] - df['EMA_26']
    df['Signal'] = df['MACD'].ewm(span=9, adjust=False).mean()
    df['MACD_Hist'] = df['MACD'] - df['Signal']
    return df


def calculate_rsi(df, period=14):
    delta = df['close'].diff()
    gain = (delta.where(delta > 0, 0)).rolling(window=period).mean()
    loss = (-delta.where(delta < 0, 0)).rolling(window=period).mean()

    rs = gain / loss
    df['RSI'] = 100 - (100 / (1 + rs))
    return df


def calculate_stochastic_rsi(df, period=14):
    # คำนวณ RSI ก่อน
    df = calculate_rsi(df, period)
    min_rsi = df['RSI'].rolling(window=period).min()
    max_rsi = df['RSI'].rolling(window=period).max()
    df['StochRSI'] = (df['RSI'] - min_rsi) / (max_rsi - min_rsi)
    return df


def calculate_atr(df, period=14):
    high_low = df['high'] - df['low']
    high_close = np.abs(df['high'] - df['close'].shift())
    low_close = np.abs(df['low'] - df['close'].shift())
    ranges = pd.concat([high_low, high_close, low_close], axis=1)

    true_range = ranges.max(axis=1)
    df['ATR'] = true_range.rolling(window=period).mean()
    df['ATR_%'] = (df['ATR'] / df['close']) * 100
    return df


def calculate_bollinger_bands(df, period=20, std_dev=2):
    sma = df['close'].rolling(window=period).mean()
    std = df['close'].rolling(window=period).std()
    df['BB_Upper'] = sma + std_dev * std
    df['BB_Lower'] = sma - std_dev * std
    df['BB_%B'] = (df['close'] - df['BB_Lower']) / (df['BB_Upper'] - df['BB_Lower'])
    return df


def calculate_vwap(df):
    if 'volume' not in df.columns:
        log_error("ไม่สามารถคำนวณ VWAP เนื่องจากไม่มีคอลัมน์ 'volume'")
        return df
    df['TP'] = (df['high'] + df['low'] + df['close']) / 3
    df['Cum_TPV'] = (df['TP'] * df['volume']).cumsum()
    df['Cum_Vol'] = df['volume'].cumsum()
    df['VWAP'] = df['Cum_TPV'] / df['Cum_Vol']
    return df


def calculate_obv(df):
    if 'volume' not in df.columns:
        log_error("ไม่สามารถคำนวณ OBV เนื่องจากไม่มีคอลัมน์ 'volume'")
        return df
    df['OBV'] = 0
    obv = np.where(df['close'] > df['close'].shift(), df['volume'], 
                   np.where(df['close'] < df['close'].shift(), -df['volume'], 0))
    df['OBV'] = obv.cumsum()
    return df


def apply_indicators(raw_data):
    df = prepare_dataframe(raw_data)
    df = calculate_ema(df, period=50)
    df = calculate_ema(df, period=200)
    df = calculate_macd(df)
    df = calculate_rsi(df)
    df = calculate_stochastic_rsi(df)
    df = calculate_atr(df)
    df = calculate_bollinger_bands(df)
    df = calculate_vwap(df)
    df = calculate_obv(df)
    log_info("คำนวณอินดิเคเตอร์ทั้งหมดเสร็จแล้ว")
    return df
