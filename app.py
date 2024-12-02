from flask import Flask, Response, stream_with_context
import subprocess

app = Flask(__name__)

@app.route('/stream/<video_id>')
def stream_audio(video_id):
    def generate_audio():
        command = [
            'yt-dlp',
            '-o', '-',
            '-f', 'bestaudio[ext=m4a]',  # Garante compatibilidade com Safari
            f'https://www.youtube.com/watch?v={video_id}'
        ]
        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        try:
            while True:
                chunk = process.stdout.read(4096)
                if not chunk:
                    break
                yield chunk
        finally:
            process.kill()

    headers = {
        "Content-Type": "audio/mp4",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive",
    }
    return Response(stream_with_context(generate_audio()), headers=headers, mimetype='audio/mp4')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

