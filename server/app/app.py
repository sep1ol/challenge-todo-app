from fastapi import FastAPI

from db.db_setup import engine
from db.models import todos
from api.todos import router

"""
DATABASE MODELS AND ENGINE SETUP
"""
todos.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Title",
    description="description",
)

"""
ROUTERS SETUP
"""
app.include_router(router)
