from flask import Flask
from flask_cors import CORS
from app.presentation.controllers import reproduce, search, home

from app.presentation.controllers import cloudinary as cloudinary_controller
import cloudinary # type: ignore
import os

from dotenv import load_dotenv

import firebase_admin
from firebase_admin import credentials, firestore


def create_app():
    
    load_dotenv()
    
    cred = credentials.Certificate('../serviceAccountKey.json')
    firebase_admin.initialize_app(cred)
    
    cloudinary.config( 
        cloud_name=os.getenv("CLOUDINARY_CLOUD_NAME"), 
        api_key=os.getenv("CLOUDINARY_API_KEY"), 
        api_secret=os.getenv("CLOUDINARY_SECRET_KEY"), 
        secure=True
    )

    firestore_db = firestore.client()
    
    app = Flask(__name__)
    CORS(app, resources={r"/*": {"origins": "*"}})
    
    app.secret_key =  os.getenv("FLASK_SECRET_KEY")
    app.config["FIRESTORE_DB"] = firestore_db

    app.register_blueprint(cloudinary_controller.cloudinary_bp, url_prefix=f"/{cloudinary_controller.name}")
    app.register_blueprint(reproduce.reproduce_bp, url_prefix=f"/{reproduce.name}")
    app.register_blueprint(search.search_bp, url_prefix=f"/{search.name}")
    app.register_blueprint(home.home_bp) # main route does not need url_prefix

       

    return app