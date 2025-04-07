# این یه اسکریپته که باهاش فایل دیتابیس باباطاهر رو کامل کردم



import json
import os

# مسیر فایل‌ها
current_dir = os.path.dirname(os.path.abspath(__file__))
source_path = os.path.join(current_dir, 'babataher_poems.json')
target_path = os.path.join(current_dir, 'BabaTaher2B.json')

# خواندن فایل منبع
with open(source_path, 'r', encoding='utf-8') as f:
    source_data = json.load(f)

# خواندن فایل هدف
with open(target_path, 'r', encoding='utf-8') as f:
    target_data = json.load(f)

# پاک کردن داده‌های قبلی
target_data = []

# تبدیل داده‌ها
for index, item in enumerate(source_data, start=1):
    # ایجاد یک آیتم جدید
    new_item = {
        "alarm": None,
        "content": item['poem_text'],
        "id": f"BD{index:03d}",  # فرمت سه رقمی برای ID
        "link1": "",
        "link2": "",
        "share": None,
        "title": f"{index}- {item['poem_text'].split('/')[0]}",  # اولین مصرع به عنوان عنوان
        "vazn": None,
        "voice": None
    }
    
    # اضافه کردن به داده‌های اصلی
    target_data.append(new_item)

# ذخیره فایل نهایی
with open(target_path, 'w', encoding='utf-8') as f:
    json.dump(target_data, f, ensure_ascii=False, indent=4)

print("تبدیل با موفقیت انجام شد!") 
