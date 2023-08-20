from fastapi import FastAPI
from pydantic import BaseModel

from . import logic

APP = FastAPI(max_request_size=1024 * 1024 * 20)


class MessageRequest(BaseModel):
    message: str


@APP.post("/api/message/categorize")
async def categorize_message_handler(message_data: MessageRequest):
    return await logic.categorize_message(message=message_data.message)
