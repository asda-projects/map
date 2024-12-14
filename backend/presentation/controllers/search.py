from flask import Blueprint, jsonify, request

from backend.domain.services.search_manager import proxy_for_music_cover_image, youtube_search_videos
from backend.presentation.utils.http_response import jsonify_response, render_image_response

search_bp = Blueprint(__package__ or __name__.split('.')[0], __name__)

@search_bp.route('/videos', methods=['GET'])
def search_videos():
    query = request.args.get('query')
    search_results = youtube_search_videos(query=query)


    return jsonify_response(response=search_results)


@search_bp.route('/music_cover_image/<video_id>', methods=['GET'])
def search_music_cover_image(video_id):
    
    image_response = proxy_for_music_cover_image(video_id=video_id)
    return render_image_response(response=image_response)
