from flask import Blueprint, current_app

from app.presentation.utils.app_routes import list_routes
from app.presentation.utils.http_response import pretty_json_response


name = __name__.split('.')[-1]
home_bp = Blueprint(name, __name__)

@home_bp.route('/')
def home():
    routes_result = list_routes(current_app)
    return pretty_json_response(response=routes_result)



    