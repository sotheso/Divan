import json

def merge_podcast_links():
    # Read both JSON files
    with open('hafez_podcast_links.json', 'r', encoding='utf-8') as f:
        castbox_links = json.load(f)
    
    with open('hafez_apple_podcast_links.json', 'r', encoding='utf-8') as f:
        apple_links = json.load(f)
    
    # Create a dictionary to store merged data
    merged_data = {}
    
    # Process Castbox links
    for item in castbox_links:
        poem_number = item['poem_number']
        merged_data[poem_number] = {
            'poem_number': poem_number,
            'title': item['title'],
            'castbox_link': item['link']
        }
    
    # Add Apple Podcast links
    for item in apple_links:
        poem_number = item['poem_number']
        if poem_number in merged_data:
            merged_data[poem_number]['apple_podcast_link'] = item['link']
    
    # Convert dictionary to list and sort by poem number
    final_data = sorted(merged_data.values(), key=lambda x: x['poem_number'])
    
    # Save merged data to a new JSON file
    with open('hafez_combined_podcast_links.json', 'w', encoding='utf-8') as f:
        json.dump(final_data, f, ensure_ascii=False, indent=2)
    
    print(f"Successfully merged {len(final_data)} podcast links")

if __name__ == "__main__":
    merge_podcast_links() 