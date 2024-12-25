from flask import url_for
from app.presentation.utils.http_response import MyJson
import cloudinary  # type: ignore
from cloudinary.api import NotFound, resource # type: ignore


def reproduce_audio_from_cloudinary(user_id: str, video_id: str) -> MyJson:
    try:
        # Cloudinary Storage path with user-specific storage
        file_path = f'users/{user_id}/audio_files/{video_id}'

        # Check if the file exists on Cloudinary
        resource_info = resource(file_path, resource_type="video")
        audio_url = resource_info.get("secure_url")

        
        
        return MyJson(
            error="No Error", 
            status_code=200, 
            message="Audio file found successfully.", 
            data=audio_url
            )
    except NotFound:
        
        return MyJson(
            error="FileNotFound",
            status_code=404,
            message="The requested audio file does not exist on Cloudinary.",
            data=url_for('cloudinary.upload_music', user_id=user_id, video_id=video_id)
    )
    except Exception as e:
        return MyJson(
            error="ServerError",
            status_code=500,
            message=str(e),
            data=""
        )
