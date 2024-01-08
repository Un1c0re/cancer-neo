# -*- coding: utf-8 -*-
from datetime import datetime
from typing import Any, List, Union

from pydantic import BaseModel, validator, root_validator, field_validator
from pydantic.utils import GetterDict

import peewee
from pydantic import BaseModel, validator
from pydantic.utils import GetterDict
from . import database


class PeeweeGetterDict(GetterDict):
    def get(self, key: Any, default: Any = None):
        res = getattr(self._obj, key, default)
        if isinstance(res, peewee.ModelSelect):
            return list(res)
        return res


class Login(BaseModel):
    phone: str


class DoctorCreate(BaseModel):
    name: str
    phone: str


class Doctor(DoctorCreate):
    id: int

    class Config:
        orm_mode = True
        getter_dict = PeeweeGetterDict


class PatientCreate(BaseModel):
    name: str
    birthdate: str
    disease: str
    phone: str
    doctor_id: Union[None, int]


class Patient(PatientCreate):
    id: int
    doctor_id: Any

    class Config:
        orm_mode = True
        getter_dict = PeeweeGetterDict

    @validator("doctor_id")
    def doctor_process(cls, v):
        if type(v) is None:
            return None
        elif type(v) is not int:
            return {"id": v.id, "name": v.name}


class SymptomCreate(BaseModel):
    name: str
    owner_id: int
    is_bool: bool
    strength: int
    date: str


class Symptom(SymptomCreate):
    id: int
    owner_id: Any

    class Config:
        orm_mode = True
        getter_dict = PeeweeGetterDict

    @validator("owner_id")
    def owner_process(cls, v):
        if type(v) is None:
            return None
        elif type(v) is not int:
            return v.name


class DocumentCreate(BaseModel):
    title: str
    owner_id: int
    date: str
    med_organization: str
    description: str
    file: str


class Document(DocumentCreate):
    id: int
    owner_id: Any

    class Config:
        orm_mode = True
        getter_dict = PeeweeGetterDict

    @validator("owner_id")
    def owner_process(cls, v):
        if type(v) is None:
            return None
        elif type(v) is not int:
            return v.name


class BindData(BaseModel):
    patient_id: int
    doctor_id: int


class BindStatus(BaseModel):
    bind_successful: bool
