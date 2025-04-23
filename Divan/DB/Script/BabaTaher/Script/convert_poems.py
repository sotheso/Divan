# این یه اسکریپته که باهاش فایل دیتابیس حافظ رو کامل کردم



import json
import os

# مسیر فایل‌ها
current_dir = os.path.dirname(os.path.abspath(__file__))
hafez_path = os.path.join(current_dir, 'HafezQazal.json')
faal_path = os.path.join(current_dir, 'Faal.json')

# خواندن فایل اصلی
with open(hafez_path, 'r', encoding='utf-8') as f:
    hafez_data = json.load(f)

# خواندن فایل جدید
with open(faal_path, 'r', encoding='utf-8') as f:
    faal_data = json.load(f)

# پاک کردن داده‌های قبلی
hafez_data = []

# تبدیل داده‌ها
for index, faal_item in enumerate(faal_data, start=1):
    if index > 495:  # فقط 495 غزل اول
        break
        
    # استخراج اولین جمله از شعر
    first_line = faal_item['شعر'].split('\r\n')[0]
    
    # ایجاد یک آیتم جدید با شماره
    new_item = {
        "alarm": None,
        "content": faal_item['شعر'],
        "id": f"HQ{index:03d}",  # فرمت سه رقمی برای ID
        "link1": "",
        "link2": "",
        "share": None,
        "title": f"{index}- {first_line}",
        "vazn": None,
        "voice": None
    }
    
    # اضافه کردن به داده‌های اصلی
    hafez_data.append(new_item)

# ذخیره فایل نهایی
with open(hafez_path, 'w', encoding='utf-8') as f:
    json.dump(hafez_data, f, ensure_ascii=False, indent=4)

print("تبدیل با موفقیت انجام شد!") 
