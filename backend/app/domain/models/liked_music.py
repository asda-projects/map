from dataclasses import dataclass

from typing import ClassVar, Type, TypeVar, Optional
from datetime import datetime

from app.data.remote.firestore_adpter import BaseModelAdapter


@dataclass
class LikedMusic(BaseModelAdapter):
    collection_name: ClassVar[str] = "liked_music"

    user_id: str
    music_id: str
    music_title: str
    artist: str
    liked_at: datetime = datetime.now()