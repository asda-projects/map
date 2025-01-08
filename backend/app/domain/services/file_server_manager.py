

from io import BytesIO
import subprocess
from typing import IO
import cloudinary.uploader   # type: ignore
from app.presentation.utils.http_response import MyJson
from app.data.remote import file_server_adpter
from pydub import AudioSegment # type: ignore
from io import BytesIO

def download_audio(video_id: str) -> bytes | None:
    try:
        return bytes  # Return raw audio data

    except Exception as e:
        print(f"Download error: {e}")
        return None

def process_audio(raw_audio: bytes) -> bytes:

    return bytes

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
            upload_result = file_server_adpter.upload(
                
            )

            
            return MyJson(
                error="No Error", 
                status_code=200, 
                message="File uploaded successfully", 
                data=upload_result
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
        folder_path = f''
        file_path = f''

        # Delete from Cloudinary
        delete_result = file_server_adpter.destroy(
        )

        if delete_result.get("status_code") == 200:
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
