import re
from flask import Response
from ftfy import fix_text
import requests
from youtube_search import YoutubeSearch

from app.presentation.utils.http_response import MyJson




def clean_text(text: str):
    """Normalize and clean text."""
    # Fix Unicode issues
    text = fix_text(text)
    # Remove non-ASCII characters
    text = re.sub(r'[^\x00-\x7F]+', ' ', text)
    # Remove extra spaces
    text = re.sub(r'\s+', ' ', text).strip()
    return text

def youtube_search_videos(query: str) -> MyJson:
    
    if not query:
        return MyJson(error = f"Query", status_code=400, message="Missing query parameter", data= [])

    try:
        # Perform the search using youtube-search
        search_results = YoutubeSearch(query, max_results=10).to_dict()

        # Clean and extract relevant data
        videos = []
        for video in search_results:
            videos.append({
                "title": video.get('title'),
                "channel": video.get('channel'),
                "duration": clean_text(video.get('duration')),
                "views": clean_text(video.get('views', '')),
                "video_id": video.get('id')
                # "link": f"https://www.youtube.com{clean_text(video.get('url_suffix'))}",
                # "published_time": clean_text(video.get('publish_time', '')),
            })

        return MyJson(error = "No Error", status_code=200, message="search sucessfull.", data= videos)

    except Exception as e:
        print(e)
        return MyJson(error = f"{e}", status_code=500, message="an unknow error occurs.", data= [])
    


def proxy_for_music_cover_image(video_id: str) -> MyJson:
    url = f"https://img.youtube.com/vi/{video_id}/maxresdefault.jpg"
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        return MyJson(error = "No Error", status_code=200, message="search sucessfull.", data= Response(response.content, mimetype='image/jpeg'))
    else:
        return MyJson(error = f"Not found.", status_code=404, message="Error to search image!", data= [])
