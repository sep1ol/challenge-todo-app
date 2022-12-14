"""empty message

Revision ID: fc6032acf851
Revises: 
Create Date: 2022-10-24 21:07:47.657740

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'fc6032acf851'
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('todos',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('task', sa.String(length=100), nullable=False),
    sa.Column('description', sa.String(length=200), nullable=True),
    sa.Column('date', sa.DateTime(), nullable=True),
    sa.Column('priority', sa.Integer(), nullable=True),
    sa.Column('completed', sa.Boolean(), nullable=False),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_todos_id'), 'todos', ['id'], unique=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_todos_id'), table_name='todos')
    op.drop_table('todos')
    # ### end Alembic commands ###
