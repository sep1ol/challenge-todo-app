from pydantic import BaseModel
from typing import Optional
from datetime import datetime

"""
Create data
"""


class TodoBase(BaseModel):
    task: str
    description: Optional[str]
    date: datetime
    priority: int


"""
Retrieve data
"""


class Todo(TodoBase):
    id: int
    completed: bool

    class Config:
        orm_mode = True
        # @dev: turning ORM on so that we can read data even if it's not a Dict; avoiding errors;
