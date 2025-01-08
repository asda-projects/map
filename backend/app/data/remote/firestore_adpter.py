from google.cloud import firestore
from dataclasses import dataclass, asdict, fields
from typing import ClassVar, Type, TypeVar, Optional
from datetime import datetime
from flask import current_app
import logging

logger = logging.getLogger(__name__)

db = current_app.config["FIRESTORE_DB"]


T = TypeVar("T", bound="BaseModelAdapter")

@dataclass
class BaseModelAdapter:
    collection_name: ClassVar[str] = None  # To be defined in subclasses
    id: Optional[str] = None  # Document ID (optional)

    def save(self):
        if not self.id:
            raise ValueError("The model must have an 'id' attribute.")
        data = asdict(self)
        self.collection().document(self.id).set(data)

    @classmethod
    def get(cls: Type[T], document_id: str) -> Optional[T]:
        doc = cls.collection().document(document_id).get()
        if doc.exists:
            data = doc.to_dict()
            data["id"] = document_id  # Add the document ID back into the data
            return cls(**data)
        return None
    
    def delete(self):
        if not self.id:
            raise ValueError("The model must have an 'id' attribute.")
        try:
            self.collection().document(self.id).delete()
            logger.info(f"Document with ID '{self.id}' deleted successfully.")
        except Exception as e:
            logger.error(f"Error deleting document: {e}")

    @classmethod
    def collection(cls):
        if not cls.collection_name:
            raise ValueError("collection_name must be defined in the subclass.")
        return db.collection(cls.collection_name)

    def to_dict(self):
        # Use asdict to serialize the dataclass fields
        return asdict(self)

    @classmethod
    def from_dict(cls: Type[T], data: dict) -> T:
        # Create an instance from a dictionary
        field_names = {f.name for f in fields(cls)}
        filtered_data = {key: value for key, value in data.items() if key in field_names}
        return cls(**filtered_data)