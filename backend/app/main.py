# -*- coding: utf-8 -*-

from fastapi import FastAPI, Depends, Request, HTTPException, status, Header
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.middleware.cors import CORSMiddleware
from jose import jwt, JWTError
from .config import Config
from . import schemas
from .felix import mkb_grab
from .database import create_access_token
from . import database as db
from . import crud
from typing import Union, List
from pydantic import Json
from enum import Enum
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm, OAuth2AuthorizationCodeBearer
from typing import Annotated
from playhouse.shortcuts import model_to_dict

app = FastAPI()

config = Config()

origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


sleep_time = 10


async def reset_db_state():
    db.db._state._state.set(db.db_state_default.copy())
    db.db._state.reset()


def get_db(db_state=Depends(reset_db_state)):
    try:
        db.db.connect()
        yield
    finally:
        if not db.db.is_closed():
            db.db.close()


class Tags(Enum):
    patient = "Patient"
    doctor = "Doctor"
    symptom = "Symptom"
    medicine = "Medicine"
    document = "Document"


# TODO: Patient API

@app.get("/patient/", tags=[Tags.patient], response_model=Union[schemas.Patient, None])
async def get_patient(phone: str):
    db_patient = crud.get_patient_by_phone(phone)
    return db_patient if db_patient is not None else None


@app.post("/patient/", tags=[Tags.patient], response_model=schemas.Patient)
async def create_patient(patient: schemas.PatientCreate):
    return crud.create_patient(patient)


@app.get("/patients/", tags=[Tags.patient], response_model=List[schemas.Patient])
async def get_all_patients(skip: int = 0, limit: int = 100):
    patients = crud.get_patients(skip=skip, limit=limit)
    return patients


# TODO: Doctor API

@app.get("/doctor/", tags=[Tags.doctor], response_model=Union[schemas.Doctor, None])
async def get_doctor(phone: str):
    db_doctor = crud.get_doctor_by_phone(phone)
    return db_doctor if db_doctor is not None else None


@app.get("/doctor/{doctor_id}", tags=[Tags.doctor], response_model=Union[schemas.Doctor, None])
async def get_doctor_by_id(doctor_id: int):
    db_doctor = crud.get_doctor(doctor_id)
    return db_doctor if db_doctor is not None else None


@app.post("/doctor/", tags=[Tags.doctor], response_model=schemas.Doctor)
async def create_doctor(doctor: schemas.DoctorCreate):
    return crud.create_doctor(doctor)


@app.post("/doctor/patient/bind/", tags=[Tags.doctor], response_model=schemas.BindStatus)
async def bind_patient_to_doctor(data: schemas.BindData):
    return crud.bind_patient_to_doctor(data.patient_id, data.doctor_id)


# TODO: Symptom API

@app.get("/symptom/{symptom_id}", tags=[Tags.symptom], response_model=Union[schemas.Symptom, None])
async def get_symptom(symptom_id: int):
    db_symptom = crud.get_symptom(symptom_id)
    return db_symptom if db_symptom is not None else None


@app.post("/symptom/", tags=[Tags.symptom], response_model=schemas.Symptom)
async def create_symptom(symptom: schemas.SymptomCreate):
    return crud.create_symptom(symptom)


@app.post("/symptoms/", tags=[Tags.symptom], response_model=List[schemas.Symptom])
async def create_symptoms(symptoms: List[schemas.SymptomCreate]):
    return crud.create_symptoms(symptoms)


@app.get("/patient/{patient_id}/symptoms", tags=[Tags.patient], response_model=List[schemas.Symptom])
async def get_symptoms_of_patient(patient_id: int):
    return crud.get_symptoms_of_patient(patient_id)


# TODO: Document API


@app.get("/document/{document_id}", tags=[Tags.document], response_model=Union[schemas.Document, None])
async def get_document(document_id: int):
    db_document = crud.get_document(document_id)
    return db_document if db_document is not None else None


@app.post("/document/", tags=[Tags.document], response_model=schemas.Document)
async def create_document(document: schemas.DocumentCreate):
    return crud.create_document(document)


@app.get("/patient/{patient_id}/document", tags=[Tags.patient], response_model=List[schemas.Document])
async def get_documents_of_patient(patient_id: int):
    return crud.get_documents_of_patient(patient_id)


@app.get("/symptom/search/", tags=[Tags.symptom], response_model=List[dict])
async def search_symptoms(query: str):
    return mkb_grab.process_user_query(query)