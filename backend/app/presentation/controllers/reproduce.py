from flask import Blueprint

from app.domain.services.reproduce_manager import reproduce_audio_from_cloudinary
from app.presentation.utils.http_response import redirect_to

name = __name__.split('.')[-1]
reproduce_bp = Blueprint(name, __name__)

@reproduce_bp.route('/music/<user_id>/<video_id>', methods=['GET'])
def music(user_id, video_id):
    
    firestore_response = reproduce_audio_from_cloudinary( user_id=user_id, video_id=video_id)

    return redirect_to(response=firestore_response)
