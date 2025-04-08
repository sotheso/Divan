import json

def generate_episode_links():
    base_url = "https://castbox.fm/episode/"
    channel_id = "id3052047"
    episodes = []
    
    # Generate links for poems 1 to 270
    for number in range(1, 271):
        # Format number with leading zeros
        formatted_number = str(number).zfill(3)
        
        if number == 270:
            title = "درد-عشقی-کشيده‌ام-که-مپرس"
            episode_id = "id795906147"
        elif number == 1:
            title = "الا-یا-ایها-الساقی"
            episode_id = "id686375125"
        else:
            title = f"غزل-شماره-{formatted_number}"
            episode_id = f"id{686375125 + number - 1}"  # Incrementing ID based on pattern
        
        link = f"{base_url}{title}-{formatted_number}-{channel_id}-{episode_id}?country=us"
        
        episodes.append({
            "poem_number": number,
            "title": f"غزل شماره {formatted_number}",
            "link": link
        })
    
    # Save to JSON file
    with open('hafez_podcast_links.json', 'w', encoding='utf-8') as f:
        json.dump(episodes, f, ensure_ascii=False, indent=2)
        
    print(f"Successfully generated {len(episodes)} episode links")

if __name__ == "__main__":
    generate_episode_links() 