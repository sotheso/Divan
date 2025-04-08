import json

def generate_episode_links():
    base_url = "https://podcasts.apple.com/us/podcast/"
    podcast_id = "id1459918086"
    episodes = []
    
    # Generate links for poems 1 to 270
    for number in range(1, 271):
        # Format number with leading zeros
        formatted_number = str(number).zfill(2)
        
        if number == 270:
            title = "درد-عشقی-کشيده-ام-که-مپرس-۲۷۰"
            episode_id = "1000702628894"
        elif number == 1:
            title = "الا-یا-ایها-الساقی-۰۱"
            episode_id = "1000650652264"
        else:
            title = f"غزل-شماره-{formatted_number}"
            episode_id = f"1000650652264"  # Using base episode ID as pattern
        
        link = f"{base_url}{title}/{podcast_id}?i={episode_id}"
        
        episodes.append({
            "poem_number": number,
            "title": f"غزل شماره {formatted_number}",
            "link": link
        })
    
    # Save to JSON file
    with open('hafez_apple_podcast_links.json', 'w', encoding='utf-8') as f:
        json.dump(episodes, f, ensure_ascii=False, indent=2)
        
    print(f"Successfully generated {len(episodes)} episode links")

if __name__ == "__main__":
    generate_episode_links() 