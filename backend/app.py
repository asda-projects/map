import os
import re
from flask import Flask, Response, jsonify, request, send_file, stream_with_context
import subprocess
from youtube_search import YoutubeSearch
from ftfy import fix_text

from duckduckgo_images_api import search




app = Flask(__name__)


def search_images(query):
    """Search for safe images using DuckDuckGo."""
    results = search(query)
    return [r["url"] for r in results["results"]]


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
                "title": clean_text(video.get('title')),
                "channel": clean_text(video.get('channel')),
                "duration": clean_text(video.get('duration')),
                "views": clean_text(video.get('views', '')),
                "video_id": video.get('id')
                # "link": f"https://www.youtube.com{clean_text(video.get('url_suffix'))}",
                # "published_time": clean_text(video.get('publish_time', '')),
            })

        return jsonify({"results": videos})

    except Exception as e:
        return jsonify({"error": str(e)}), 500



    

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
