import os
import re
from flask import Flask, Response, jsonify, request, send_file, stream_with_context
import subprocess
import requests
from youtube_search import YoutubeSearch
from ftfy import fix_text
from flask_cors import CORS



app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})




@app.route('/stream/<video_id>')
def stream_audio(video_id):
    def generate_audio():


        command = [
            'yt-dlp',
            '-o', '-',          # Saída em stdout
            '-f', 'bestaudio',  # Melhor formato de áudio disponível
            f'https://www.youtube.com/watch?v={video_id}'
        ]

        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:

            while True:
                chunk = process.stdout.read(8192)
                if not chunk:
                    break
                yield chunk
        finally:
            process.kill()

    headers = {
        "Cache-Control": "no-cache",      # Prevent caching for real-time streaming
        "Connection": "keep-alive",       # Keeps the connection open for streaming
        }
    
    return Response(stream_with_context(generate_audio()),headers=headers ,mimetype='audio/mpeg')


@app.route('/reproduce/<video_id>')
def reproduce_audio(video_id):
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
    # localhost:5000/search_image_music_cover/jNJkG8XMeis
    url = f"https://img.youtube.com/vi/{video_id}/maxresdefault.jpg"
    print(f"Requesting image cover at {url}")
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        return Response(response.content, mimetype='image/jpeg')
    else:
        return Response("Error to search image!", status=404)
    

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
