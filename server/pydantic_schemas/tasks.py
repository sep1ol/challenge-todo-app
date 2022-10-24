from pydantic import BaseModel
from typing import Optional
from datetime import datetime

"""
Task creation
"""


class TaskBase(BaseModel):
    task: str
    description: Optional(str)
    date: datetime
    priority: int


"""
Retrieve data
"""


class Task(TaskBase):
    id: int

    class Config:
        orm_mode = False
        # @dev: required manual data convertion into dict
