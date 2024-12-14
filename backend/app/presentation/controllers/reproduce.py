from flask import Blueprint

from app.domain.services.reproduce_manager import reproduce_audio_from_firestore
from app.presentation.utils.http_response import redirect_to

name = __name__.split('.')[-1]
reproduce_bp = Blueprint(name, __name__)

@reproduce_bp.route('/music/<video_id>', methods=['POST'])
def music(video_id):

    firestore_response = reproduce_audio_from_firestore(video_id=video_id)

    return redirect_to(response=firestore_response)
