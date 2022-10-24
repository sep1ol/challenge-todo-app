from sqlalchemy import Column, Integer, String, DateTime, Boolean

from ..db_setup import Base


class Todos(Base):
    __tablename__ = "todos"

    id = Column(Integer, primary_key=True, index=True)
    task = Column(String(100), nullable=False)
    description = Column(String(200))
    date = Column(DateTime)
    priority = Column(Integer)
    completed = Column(Boolean, nullable=False, default=False)
