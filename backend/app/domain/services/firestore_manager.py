import subprocess
from typing import IO

from app.presentation.utils.http_response import MyJson
from firebase_admin import  storage # type: ignore



def download_audio(video_id: str)-> IO[bytes] | None:
    command = [
        'yt-dlp',
        '-o', '-',  # Output to stdout
        '-f', 'bestaudio[ext=m4a]',
        f'https://www.youtube.com/watch?v={video_id}'
    ]

    try:
        # Run yt-dlp and capture the output
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        return process.stdout
    
    except Exception as e:

        return None


def upload_audio(video_id: str) -> MyJson:
    
    if not video_id:
        return MyJson(error = f"video_id", status_code=400, message="Missing video_id parameter", data= [])

    # Command to download audio from YouTube


    try:
        # Run yt-dlp and capture the output
        downloaded_audio = download_audio(video_id=video_id)

        if downloaded_audio:
            # Get the bucket
            bucket = storage.bucket()
            blob = bucket.blob(f'audio_files/{video_id}.m4a')  # Firebase Storage path

            # Stream directly to Firebase Storage
            blob.upload_from_file(downloaded_audio, content_type='audio/mp4')

            # Get the public URL
            public_url = blob.public_url
            return MyJson(error = "No Error", status_code=200, message= "File uploaded successfully", data=public_url)
        
        else:
            return MyJson(error = "Download", status_code=204, message= "Music not loaded correctly", data=public_url)

        

    except Exception as e:
        return MyJson(error = f"{e}", status_code=500, message="an unknow error occurs.", data= [])
    

def delete_audio(file_path: str) -> MyJson:
    try:
        # Get the bucket and delete the file
        bucket = storage.bucket()
        blob = bucket.blob(file_path)

        if blob.exists():
            blob.delete()
            return MyJson(error = "No Error", status_code=200, message= "File deleted successfully", data=file_path)
            
        else:
            return MyJson(error = "File", status_code=404, message= "File not found.", data=file_path)
            

    except Exception as e:
        return MyJson(error = f"{e}", status_code=500, message="an unknow error occurs.", data= [])