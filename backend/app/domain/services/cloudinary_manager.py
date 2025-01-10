from io import BytesIO

from cloudinary.api import resource

import subprocess
from typing import IO
import cloudinary.uploader
from flask import Response
import requests   # type: ignore
from app.presentation.utils.http_response import MyJson
from pydub import AudioSegment # type: ignore
from io import BytesIO




def buffer_cloudinary_resource(user_id: str, video_id: str) -> BytesIO | None:

    
    try:

        file_path = f'users/{user_id}/audio_files/{video_id}'

        resource_info = resource(file_path, resource_type="video")
        file_url = resource_info.get("secure_url")
    
        # Download the file and load it into a BytesIO buffer
        response = requests.get(file_url, stream=True)
        response.raise_for_status()  # Raise an exception for HTTP errors
        
        buffer = BytesIO()
        buffer.write(response.content)
        buffer.seek(0)  # Reset the buffer's position to the start
        return buffer

    except Exception as e:
        print(f"Download error: {e}")
        return None

def download_audio(video_id: str) -> bytes | None:
    command = [
        'yt-dlp', '--verbose',
        '-o', '-',  # Output to stdout
        '-f', 'bestaudio[ext=m4a]',
        f'https://www.youtube.com/watch?v={video_id}'
    ]

    try:
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        audio_data, error = process.communicate()
        # audio_data = process.stdout.read()  Read the stream into memory, but it seems load twice the audio
        if process.returncode != 0:
            print(f"Download error: {error.decode('utf-8')}")
            return None

        return audio_data  # Return raw audio data

    except Exception as e:
        print(f"Download error: {e}")
        return None

def process_audio(raw_audio: bytes) -> bytes:
    audio = AudioSegment.from_file(BytesIO(raw_audio), format="m4a")
    return audio.export(format="mp3").read()

def upload_audio(user_id: str, video_id: str) -> MyJson:
    if not video_id or not user_id:
        return MyJson(
            error="Missing parameter", 
            status_code=400, 
            message="user_id and video_id are required", 
            data=''
        )

    try:
        downloaded_audio = download_audio(video_id=video_id)

        if downloaded_audio:
            # Cloudinary treats the uploaded file as a "video" (likely because of resource_type="video"). 
            # If the raw audio is not properly encoded or includes non-audio data,
            #  Cloudinary might process the file as a longer-than-expected track.
            processed_audio = process_audio(downloaded_audio)
            
            folder_path = f'users/{user_id}'
            file_path = f'audio_files/{video_id}'

            # Upload to Cloudinary
            upload_result = cloudinary.uploader.upload(
                BytesIO(processed_audio),
                resource_type="video",
                public_id=f'{folder_path}/{file_path}',
                overwrite=True
            )

            public_url = upload_result.get("secure_url")
            return MyJson(
                error="No Error", 
                status_code=200, 
                message="File uploaded successfully", 
                data=public_url
            )
        else:
            return MyJson(
                error="Download", 
                status_code=204, 
                message="Request processed but th music was not loaded correctly", 
                data=''
            )

    except Exception as e:
        return MyJson(
            error=str(e), 
            status_code=500, 
            message="An unknown error occurred.", 
            data=''
        )


def delete_audio(user_id: str, video_id: str) -> MyJson:
    try:
        folder_path = f'users/{user_id}'
        file_path = f'audio_files/{video_id}'

        # Delete from Cloudinary
        delete_result = cloudinary.uploader.destroy(
            public_id=f'{folder_path}/{file_path}',
            resource_type="video"
        )

        if delete_result.get("result") == "ok":
            return MyJson(
                error="No Error", 
                status_code=200, 
                message="File deleted successfully", 
                data=f'{folder_path}/{file_path}'
            )
        else:
            return MyJson(
                error="File", 
                status_code=404, 
                message="File not found.", 
                data=f'{folder_path}/{file_path}'
            )

    except Exception as e:
        return MyJson(
            error=str(e), 
            status_code=500, 
            message="An unknown error occurred.", 
            data=''
        )
