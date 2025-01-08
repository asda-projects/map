
from flask import Blueprint

from app.domain.services.file_server_manager import delete_audio, upload_audio
from app.presentation.utils.http_response import jsonify_response


name = __name__.split('.')[-1]
file_server = Blueprint(name,  __name__)


@file_server.route('/upload_music/<user_id>/<video_id>', methods=['GET'])
def upload_music(user_id, video_id):
    
    upload_response = upload_audio(user_id=user_id,video_id=video_id)

    return jsonify_response(response=upload_response)


@file_server.route('/delete_music/<user_id>/<video_id>', methods=['GET'])

def delete_music(user_id, video_id):


    delete_response = delete_audio(user_id=user_id,video_id=video_id)
    
    return jsonify_response(response=delete_response)

