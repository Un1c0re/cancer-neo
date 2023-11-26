from datetime import timedelta, datetime
from typing import Union

from dotenv import load_dotenv
from contextvars import ContextVar
import peewee as pw
from jose import jwt
from playhouse.postgres_ext import PostgresqlExtDatabase
from .config import Config

load_dotenv()

db_state_default = {"closed": None, "conn": None, "ctx": None, "transactions": None}
db_state = ContextVar("db_state", default=db_state_default.copy())

config = Config()

db = PostgresqlExtDatabase(config.DATABASE_NAME, user=config.DATABASE_USERNAME, password=config.DATABASE_PASSWORD,
                           host=config.DATABASE_HOST, port=config.DATABASE_PORT)


def create_access_token(data: dict, expires_delta: Union[timedelta, None] = None):
    to_encode = {"id": str(data.id)}
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=config.ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, config.SECRET_KEY, algorithm=config.ALGORITHM)
    return encoded_jwt


class PeeweeConnectionState(pw._ConnectionState):
    def __init__(self, **kwargs):
        super().__setattr__("_state", db_state)
        super().__init__(**kwargs)

    def __setattr__(self, name, value):
        self._state.get()[name] = value

    def __getattr__(self, name):
        return self._state.get()[name]


db._state = PeeweeConnectionState()


class BaseModel(pw.Model):
    class Meta:
        database = db


class Doctor(BaseModel):
    name = pw.CharField()
    phone = pw.CharField()


class Patient(BaseModel):  # TODO: Done
    name = pw.CharField()
    birthdate = pw.CharField()
    disease = pw.CharField()
    phone = pw.CharField()
    doctor_id = pw.ForeignKeyField(Doctor)


class Symptom(BaseModel):
    name = pw.CharField()
    owner_id = pw.ForeignKeyField(Patient)
    is_bool = pw.BooleanField()
    strength = pw.IntegerField()
    date = pw.DateField()


class Medicine(BaseModel):
    name = pw.CharField()
    owner_id = pw.ForeignKeyField(Patient)
    start_date = pw.DateField()
    frequency = pw.TimestampField()
    dose = pw.CharField()


class Document(BaseModel):
    title = pw.CharField()
    owner_id = pw.ForeignKeyField(Patient)
    date = pw.DateField()
    med_organization = pw.CharField()
    description = pw.CharField()
    file = pw.CharField()


tables = [Doctor, Patient, Symptom, Medicine, Document]
table = [Symptom]


def create_tables() -> None:
    with db:
        db.create_tables((tables))


if __name__ == "__main__":
    db.drop_tables(tables)
    create_tables()
