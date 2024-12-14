import os
import re
from flask import Flask, Response, jsonify, request, send_file
import subprocess
import requests
from youtube_search import YoutubeSearch
from ftfy import fix_text
from flask_cors import CORS
import firebase_admin  # type: ignore
from firebase_admin import credentials, storage # type: ignore
import os
from dotenv import load_dotenv

load_dotenv()

# Initialize Firebase
cred = credentials.Certificate(os.getenv("FIREBASE_SERVICE_ACCOUNT_KEY_PATH"))
firebase_admin.initialize_app(cred, {
    'projectId': os.getenv("FIREBASE_PROJECT_ID"),
    'storageBucket': os.getenv("FIREBASE_STORAGE_BUCKET")
})


app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})








@app.route('/reproduce/<video_id>')
def reproduce_audio(video_id):
    # http://172.20.10.3:5000/reproduce/jNJkG8XMeis
    audio_file = f'{video_id}.m4a'
    if not os.path.exists(audio_file):
        # Baixa o áudio se não existir
        command = [
            'yt-dlp',
            '-o', audio_file,
            '-f', 'bestaudio[ext=m4a]',
            f'https://www.youtube.com/watch?v={video_id}'
        ]
        subprocess.run(command)

    # Serve o arquivo de áudio baixado
    return send_file(audio_file, mimetype='audio/mp4', as_attachment=False)

def clean_text(text):
    """Normalize and clean text."""
    # Fix Unicode issues
    text = fix_text(text)
    # Remove non-ASCII characters
    text = re.sub(r'[^\x00-\x7F]+', ' ', text)
    # Remove extra spaces
    text = re.sub(r'\s+', ' ', text).strip()
    return text


@app.route('/search', methods=['GET'])
def search_videos():
    query = request.args.get('query')
    if not query:
        return jsonify({"error": "Missing query parameter"}), 400

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

        return jsonify({"results": videos})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/search_image_music_cover/<video_id>')
def proxy_image(video_id):
    # http://172.20.10.3:5000/search_image_music_cover/jNJkG8XMeis
    url = f"https://img.youtube.com/vi/{video_id}/maxresdefault.jpg"
    print(f"Requesting image cover at {url}")
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        return Response(response.content, mimetype='image/jpeg')
    else:
        return Response("Error to search image!", status=404)
    

if __name__ == '__main__':
    
    app.run(host='0.0.0.0', port=5000)
