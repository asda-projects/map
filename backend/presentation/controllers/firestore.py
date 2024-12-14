from flask import Blueprint, request

from backend.domain.services.firestore_manager import upload_audio, delete_audio
from backend.presentation.utils.http_response import jsonify_response

firestore_bp = Blueprint(__package__ or __name__.split('.')[0], __name__)


@firestore_bp.route('/upload_music', methods=['POST'])
def upload_music():
    video_id = request.form.get('video_id')

    upload_response = upload_audio(video_id=video_id)

    return jsonify_response(response=upload_response)


@firestore_bp.route('/delete_music', methods=['POST'])

def delete_music():

    file_path = request.args.get('file_path')

    delete_response = delete_audio(file_path=file_path)
    return jsonify_response(response=delete_response)
