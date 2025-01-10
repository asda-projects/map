


from app.domain.models.liked_music import LikedMusic
from app.presentation.utils.http_response import MyJson
from app.domain.services.cloudinary_manager import buffer_cloudinary_resource
from app.data.remote.file_server_adpter import FileServerAdapter




def like_audio(data: dict) -> MyJson:

    user_id = data['user_id']
    video_id = data['video_id']

    data["id"] = f"{user_id}_{video_id}"

    liked_music_instance = LikedMusic(**data)

    audio_buffer = buffer_cloudinary_resource(user_id, video_id)
    
    if audio_buffer:
        message = FileServerAdapter().upload(audio_buffer, data)
        
        like_response =MyJson(
                    error="No Error", 
                    status_code=200, 
                    message=message, 
                    data=liked_music_instance.to_dict()
                )
    else:
        return MyJson(
            error="Audio Buffer", 
            status_code=500, 
            message="An unknown error occurred.", 
            data=''
        )

    
    return like_response