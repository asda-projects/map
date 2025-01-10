from dataclasses import dataclass
from dataclasses import dataclass, field
from typing import ClassVar, Type, TypeVar, Optional
from datetime import datetime

from app.data.remote.firestore_adpter import BaseModelAdapter


@dataclass
class LikedMusic(BaseModelAdapter):
    collection_name: ClassVar[str] = "liked_music"

    channel: Optional[str] = None
    duration: Optional[str] = None
    title: Optional[str] = None
    user_id: Optional[str] = None
    video_id: Optional[str] = None
    views: Optional[str] = None
    liked_at: datetime = field(default_factory=datetime.now)
    
    