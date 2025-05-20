import json
import os

# Find project root (5 levels up from this script)
BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../../../..'))
LINKS_PATH = os.path.join(BASE, 'babataher_2beytiha_links.json')
DB_PATH = os.path.join(BASE, 'DB/#ASLI DB/#BabaTaher/BabaTaher2B.json')

print(f"Reading links from: {LINKS_PATH}")
print(f"Reading DB from: {DB_PATH}")

# Load links
with open(LINKS_PATH, encoding='utf-8') as f:
    links = json.load(f)

# Load DB
with open(DB_PATH, encoding='utf-8') as f:
    db = json.load(f)

print(f"Links count: {len(links)} | DB count: {len(db)}")

# Assign links to link1
for i, entry in enumerate(db):
    if i < len(links):
        entry['link1'] = links[i]['link']
    else:
        entry['link1'] = ''

# Save DB
with open(DB_PATH, 'w', encoding='utf-8') as f:
    json.dump(db, f, ensure_ascii=False, indent=4)

print("Done! All links copied to link1 column.") 