from app.presentation.utils.http_response import MyJson
import cloudinary  # type: ignore
import cloudinary.api  # type: ignore


def reproduce_audio_from_cloudinary(user_id: str, video_id: str) -> MyJson:
    try:
        # Cloudinary Storage path with user-specific storage
        file_path = f'users/{user_id}/audio_files/{video_id}'

        # Check if the file exists on Cloudinary
        try:
            resource_info = cloudinary.api.resource(file_path, resource_type="video")
            audio_url = resource_info.get("secure_url")

            if audio_url:
                return MyJson(
                    error="No Error", 
                    status_code=200, 
                    message="Audio file found successfully.", 
                    data=audio_url
                )
            else:
                return MyJson(
                    error="File", 
                    status_code=404, 
                    message="File not found.", 
                    data=[]
                )

        except cloudinary.exceptions.NotFound:
            return MyJson(
                error="File", 
                status_code=404, 
                message="File not found.", 
                data=[]
            )

    except Exception as e:
        return MyJson(
            error=str(e), 
            status_code=500, 
            message="An unknown error occurred.", 
            data=[]
        )
