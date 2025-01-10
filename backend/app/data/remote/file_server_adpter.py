from io import BytesIO
import os

from dotenv import load_dotenv
import requests

load_dotenv()

class FileServerAdapter:
    BASE_URL = "http://file-server-mini-api.asdaproject.com/api/v1"
    UPLOAD_ROUTE = "/files/"
    BASE_HEADERS = {"Authorization": f"Bearer {os.getenv('FILE_SERVER_API_KEY')}"}

    def upload(self, buffered_file: BytesIO, file_data: dict):
        """
        Uploads a buffered file to the file server.

        :param buffered_file: A BytesIO object containing the file data.
        :param file_name: The desired file name.
        :return: Response object from the file server.
        """

        file_name = file_data["video_id"]
        description = ", ".join([value for value in file_data])

        files = {"file": (file_name, buffered_file, "application/octet-stream")}
        data = {"name": file_name, "file_type": "media", "description": f"{description}"}
        response = requests.post(
            self.BASE_URL + self.UPLOAD_ROUTE,
            headers=self.BASE_HEADERS,
            files=files,
            data=data
        )
        # response.raise_for_status()  # Raise an exception for HTTP errors
        return response.json()