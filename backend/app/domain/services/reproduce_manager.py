



from app.presentation.utils.http_response import MyJson
from firebase_admin import  storage # type: ignore

def reproduce_audio_from_firestore(video_id: str) -> MyJson:
    try:
        # Firebase Storage path
        file_path = f'audio_files/{video_id}.m4a'

        # Access Firebase Storage
        bucket = storage.bucket()
        blob = bucket.blob(file_path)

        if not blob.exists():
            return MyJson(error = "File", status_code=404, message= "File not found.", data=file_path)

        # Generate signed URL (valid for 1 hour)
        audio_url = blob.generate_signed_url(expiration=3600)

        # Redirect user to the file's URL
        return MyJson(error = "No Error", status_code=200, message= "Generated signed URL, is valid for 1 hour.", data=audio_url)

    except Exception as e:
        return MyJson(error = f"{e}", status_code=500, message="an unknow error occurs.", data= [])