from io import BytesIO
import subprocess
from typing import IO
import cloudinary.uploader   # type: ignore
from app.presentation.utils.http_response import MyJson


def download_audio(video_id: str) -> bytes | None:
    command = [
        'yt-dlp', '--verbose',
        '-o', '-',  # Output to stdout
        '-f', 'bestaudio[ext=m4a]',
        f'https://www.youtube.com/watch?v={video_id}'
    ]

    try:
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        audio_data = process.stdout.read()  # Read the stream into memory

        return audio_data  # Return raw audio data

    except Exception as e:
        print(f"Download error: {e}")
        return None


def upload_audio(user_id: str, video_id: str) -> MyJson:
    if not video_id or not user_id:
        return MyJson(
            error="Missing parameter", 
            status_code=400, 
            message="user_id and video_id are required", 
            data=[]
        )

    try:
        downloaded_audio = download_audio(video_id=video_id)

        if downloaded_audio:
            folder_path = f'users/{user_id}'
            file_path = f'audio_files/{video_id}'

            # Upload to Cloudinary
            upload_result = cloudinary.uploader.upload(
                BytesIO(downloaded_audio),
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
                message="Music not loaded correctly", 
                data=[]
            )

    except Exception as e:
        return MyJson(
            error=str(e), 
            status_code=500, 
            message="An unknown error occurred.", 
            data=[]
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
            data=[]
        )
