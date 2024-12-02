import os
from flask import Flask, Response, send_file, stream_with_context
import subprocess

app = Flask(__name__)

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

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
