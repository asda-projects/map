from flask import Flask
from flask_cors import CORS
from app.presentation.controllers import firestore, reproduce, search, home
import firebase_admin  # type: ignore
from firebase_admin import credentials, storage # type: ignore
import os

from dotenv import load_dotenv



def create_app():
    
    load_dotenv()
    cred = credentials.Certificate(os.getenv("FIREBASE_SERVICE_ACCOUNT_KEY_PATH"))
    firebase_admin.initialize_app(cred, {
    'projectId': os.getenv("FIREBASE_PROJECT_ID"),
    'storageBucket': os.getenv("FIREBASE_STORAGE_BUCKET")
    })
    
    app = Flask(__name__)
    
    app.secret_key =  os.getenv("SECRET_KEY")

    app.register_blueprint(firestore.firestore_bp, url_prefix=f"/{firestore.name}")
    app.register_blueprint(reproduce.reproduce_bp, url_prefix=f"/{reproduce.name}")
    app.register_blueprint(search.search_bp, url_prefix=f"/{search.name}")
    app.register_blueprint(home.home_bp) # main route does not need url_prefix

       

    return app