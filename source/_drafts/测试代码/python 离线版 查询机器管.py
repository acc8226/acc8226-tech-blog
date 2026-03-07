#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
每 30 分钟查询一次“机器管”项目总数，
若 > 本地记录，则：
  1. 追加一行到 csv
  2. 钉钉群通知
"""

import json
import time
import csv
import os
import urllib.request

# ========== 可配置项 ==========
API_URL = (
    "https://zhuzhou.hnsggzy.com/tradeApi/constructionTender/listSection"
    "?current=1&size=1&tenderProjectName=&bidSectionName=&regionCode=430700"
    "&tenderProjectType=&notice=&bidOpeningTimeStartGt=&bidOpeningTimeStartLt=&resourceState="
)
DING_TOKEN = "aa850dea248c9a94b6fbef332ee4d9f6fe8a8ceddbac6f96d2562235ec7d5763"
DING_URL = f"https://oapi.dingtalk.com/robot/send?access_token={DING_TOKEN}"
CSV_FILE = "machine管记录.csv"
STATE_FILE = "total.txt"
LOOP_SECONDS = 30 * 60  # 30 min
LOOP_SECONDS = 60


# ===============================

def read_old() -> int:
    """读取本地存储的上次总数"""
    try:
        with open(STATE_FILE, "r", encoding="utf-8") as f:
            return int(f.read().strip())
    except (FileNotFoundError, ValueError):
        return 0


def save_new(total: int):
    """更新本地存储"""
    with open(STATE_FILE, "w", encoding="utf-8") as f:
        f.write(str(total))


def fetch_total() -> int:
    """调接口拿总数"""
    req = urllib.request.Request(API_URL, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        data = json.loads(resp.read())
    return int(data["data"]["total"])


def append_csv(total: int):
    """追加一行到 csv"""
    exist = os.path.isfile(CSV_FILE)
    with open(CSV_FILE, "a", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        if not exist:
            w.writerow(["时间", "总数"])
        w.writerow([time.strftime("%Y-%m-%d %H:%M:%S"), total])


def push_to_kdocs(total: int):
    """把总数推送到金山文档 webhook"""
    url = f"https://www.kdocs.cn/chatflow/api/v2/func/webhook/32RiFD9UwTUyyLnbhPzwPfhOswE?count={total}"
    try:
        req = urllib.request.Request(url, method="GET")
        with urllib.request.urlopen(req, timeout=10) as resp:
            # 接口返回任意内容都无所谓，只要状态码 200 即成功
            resp.read()
        print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] 已推送至金山文档：count={total}")
    except Exception as e:
        print("金山文档 webhook 推送失败：", e)


def ding(old: int, new: int):
    """发钉钉群消息"""
    content = f"中心：机器管个数由 {old} 更新为 {new} 条"
    body = json.dumps({"msgtype": "text", "text": {"content": content}}).encode("utf-8")
    req = urllib.request.Request(
        DING_URL,
        data=body,
        headers={"Content-Type": "application/json"},
    )
    urllib.request.urlopen(req, timeout=10)


def once():
    """单次调度逻辑"""
    try:
        old = read_old()
        new = fetch_total()
        if new > old:
            save_new(new)
            # append_csv(new)
            push_to_kdocs(new)
            ding(old, new)
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] 已更新并通知：{old} -> {new}")
        else:
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] 无变化，当前 {new}")
    except Exception as e:
        print("异常：", e)


def main():
    while True:
        once()
        time.sleep(LOOP_SECONDS)


if __name__ == "__main__":
    main()
