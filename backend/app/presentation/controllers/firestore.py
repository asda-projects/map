from flask import Blueprint, request

from app.domain.services.firestore_manager import delete_audio, upload_audio
from app.presentation.utils.http_response import jsonify_response


name = __name__.split('.')[-1]
firestore_bp = Blueprint(name,  __name__)


@firestore_bp.route('/upload_music', methods=['POST'])
def upload_music():
    
    request_form = request.form

    video_id = request_form.get('video_id')
    user_id = request_form.get('user_id')

    upload_response = upload_audio(user_id=user_id,video_id=video_id)

    return jsonify_response(response=upload_response)


@firestore_bp.route('/delete_music', methods=['POST'])

def delete_music():

    request_form = request.form

    video_id = request_form.get('video_id')
    user_id = request_form.get('user_id')

    delete_response = delete_audio(user_id=user_id,video_id=video_id)
    
    return jsonify_response(response=delete_response)
