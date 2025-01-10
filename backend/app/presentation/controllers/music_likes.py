
from flask import Blueprint, request

# from app.domain.services.music_likes_manager import delete_audio, upload_audio
from app.presentation.utils.http_response import MyJson, jsonify_response
from app.domain.services.music_likes_manager import like_audio


name = __name__.split('.')[-1]
music_likes_bp = Blueprint(name,  __name__)


@music_likes_bp.route('/like_music', methods=['GET'])
def like_music():
    
     # upload_audio(user_id=user_id,video_id=video_id)
    # print(request.args, type(request.args))

    data_args = dict(request.args)
    

    like_response = like_audio(data_args)

    return jsonify_response(response=like_response)


@music_likes_bp.route('/unlike_music', methods=['GET'])

def unlike_music():


    delete_response = 'unlike_music' # delete_audio(user_id=user_id,video_id=video_id)
    
    return jsonify_response(response=delete_response)

