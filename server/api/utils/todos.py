from sqlalchemy.orm import Session

# Models used to access data
from db.models.todos import Todos
# Schemas used to validate incoming data
from pydantic_schemas.todos import TodoBase


def get_task(db: Session, task_id: int):
    return db.query(Todos).filter(Todos.id == task_id).first()


def get_all_tasks(db: Session):
    return db.query(Todos).all()


def create_task(db: Session, task: TodoBase):
    new_task = Todos(
        task=task.task,
        description=task.description,
        date=task.date,
        priority=task.priority
    )
    db.add(new_task)
    db.commit()
    db.refresh(new_task)
    return new_task


def delete_task(db: Session, task_id: int):
    task = get_task(db, task_id)
    db.delete(task)
    db.commit()
    return task


def complete_task(db: Session, task_id: int):
    todo = get_task(db, task_id)
    todo.completed = not todo.completed
    db.commit()
    db.refresh(todo)
    return todo
