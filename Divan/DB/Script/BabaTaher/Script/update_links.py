import json
import os

# Paths (relative to project root)
LINKS_PATH = os.path.join(os.path.dirname(__file__), '../../../../../babataher_2beytiha_links.json')
DB_PATH = os.path.join(os.path.dirname(__file__), '../../../../#ASLI DB/#BabaTaher/BabaTaher2B.json')

print(f"LINKS_PATH: {os.path.abspath(LINKS_PATH)}")
print(f"DB_PATH: {os.path.abspath(DB_PATH)}")

# Load links
with open(LINKS_PATH, encoding='utf-8') as f:
    links = json.load(f)

# Load DB
with open(DB_PATH, encoding='utf-8') as f:
    db = json.load(f)

print(f"Number of links: {len(links)}")
print(f"Number of DB entries: {len(db)}")

# Map links by index (assume order matches, i.e. first link to first poem, etc.)
for i, entry in enumerate(db):
    if i < len(links):
        entry['link1'] = links[i]['link']
    else:
        entry['link1'] = ''

# Save DB
with open(DB_PATH, 'w', encoding='utf-8') as f:
    json.dump(db, f, ensure_ascii=False, indent=4)

print(f"Updated {len(db)} entries with links from {LINKS_PATH}") 