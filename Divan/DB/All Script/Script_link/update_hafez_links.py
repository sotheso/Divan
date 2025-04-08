import json
import os

def update_hafez_links():
    # Get the current directory
    current_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Define file paths
    podcast_links_path = os.path.join(current_dir, 'hafez_combined_podcast_links.json')
    hafez_data_path = os.path.join(current_dir, '..', '..', 'HafezQazal.json')
    
    print(f"Reading podcast links from: {podcast_links_path}")
    print(f"Reading/Writing HafezQazal from: {hafez_data_path}")
    
    # Read the combined podcast links
    with open(podcast_links_path, 'r', encoding='utf-8') as f:
        podcast_links = json.load(f)
        print(f"Found {len(podcast_links)} podcast links")
    
    # Read the main HafezQazal.json file
    with open(hafez_data_path, 'r', encoding='utf-8') as f:
        hafez_data = json.load(f)
        print(f"Found {len(hafez_data)} ghazals in database")
    
    # Create a dictionary for quick lookup of podcast links
    links_dict = {str(item['poem_number']): item for item in podcast_links}
    print(f"Created lookup dictionary with {len(links_dict)} entries")
    
    # Update each ghazal with its corresponding links
    updated_count = 0
    for ghazal in hafez_data:
        # Extract the numeric part from HQ001 format and convert to integer
        poem_number = int(ghazal['id'][2:])  # Remove 'HQ' and convert to integer
        str_poem_number = str(poem_number)
        
        if poem_number <= 270 and str_poem_number in links_dict:
            ghazal['link1'] = links_dict[str_poem_number]['castbox_link']
            ghazal['link2'] = links_dict[str_poem_number]['apple_podcast_link']
            updated_count += 1
        else:
            ghazal['link1'] = ""
            ghazal['link2'] = ""
    
    # Save the updated data back to HafezQazal.json
    with open(hafez_data_path, 'w', encoding='utf-8') as f:
        json.dump(hafez_data, f, ensure_ascii=False, indent=2)
    
    print(f"Successfully updated {updated_count} ghazals with podcast links")

if __name__ == "__main__":
    update_hafez_links() 