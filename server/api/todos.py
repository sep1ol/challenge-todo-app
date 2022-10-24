from typing import Optional, List

import fastapi
from sqlalchemy.orm import Session
from fastapi import FastAPI, Path, Query, Depends, HTTPException

from db.db_setup import get_db
from pydantic_schemas.todos import Todo, TodoBase
from api.utils.todos import get_task, get_all_tasks, create_task, delete_task, complete_task

router = fastapi.APIRouter()


@router.get('/todos', response_model=List[Todo])
async def read_todos(db: Session = Depends(get_db)):
    todos = get_all_tasks(db)

    if todos is None:
        raise HTTPException(
            status_code=500, detail='Could not find all tasks.')
    else:
        return todos


@router.get('/todos/{id}', response_model=Todo)
async def read_todo(id: int, db: Session = Depends(get_db)):
    todo = get_task(db, task_id=id)

    if todo is None:
        raise HTTPException(status_code=404, detail='Task not found.')
    else:
        return todo


@router.post('/todos/create', response_model=Todo)
async def create_todo(new_todo: TodoBase, db: Session = Depends(get_db)):
    return create_task(db, task=new_todo)


@router.delete('/todos/delete/{id}', response_model=Todo)
async def delete_todo(id: int, db: Session = Depends(get_db)):
    return delete_task(db, task_id=id)


@router.put('/todos/complete/{id}', response_model=Todo)
async def complete_todo(id: int, db: Session = Depends(get_db)):
    return complete_task(db, task_id=id)


# @router.post('/users')
# async def create_user(user: User):
#     users.append(user)
#     return "Success"


# @router.get('/users/{id}', response_model=User)
# async def get_user(id: int):
#     return {"user": users[id]}

# BELOW WITH QUERY PARAMS
# @router.get('/users/{id}', response_model=User)
# async def get_user(
#     id: int = Path(..., description="Id of user we want to retrieve"),
#     q: str = Query(None, max_length=5)
# ):
#     return {"user": users[id], "query": q}
