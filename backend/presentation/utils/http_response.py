from flask import jsonify
from dataclasses import dataclass, asdict
from typing import Dict, Any
from flask import redirect

# Define a data class for structured response
@dataclass
class MyJson:
    error: str = ''
    status_code: int = 501
    message: str = ''
    data: Any = None


def jsonify_response(response: MyJson):
    
    # Convert data class to dict and jsonify it
    response_dict = asdict(response)
    status_code = response_dict.pop("status_code")  # Extract status code
    return jsonify(response_dict), status_code

def render_image_response(response: MyJson):

    
    status_code = asdict(response).pop("status_code")  # Extract status code
    image = response.data
    return image, status_code

def redirect_to(response: MyJson):

    location = response.data

    return redirect(location=location)





