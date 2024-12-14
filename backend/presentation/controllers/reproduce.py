from flask import Blueprint

from backend.domain.services.reproduce_manager import reproduce_audio_from_firestore
from backend.presentation.utils.http_response import redirect_to

reproduce_bp = Blueprint(__package__ or __name__.split('.')[0], __name__)

@reproduce_bp.route('/music/<video_id>', methods=['POST'])
def music(video_id):

    firestore_response = reproduce_audio_from_firestore(video_id=video_id)

    return redirect_to(response=firestore_response)
