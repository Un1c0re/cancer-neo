import asyncio
import random
import time
from datetime import datetime

import bcrypt

from . import database as models, schemas

from typing import List, Union


def get_patients(skip: int = 0, limit: int = 100):
    return list(models.Patient.select().offset(skip).limit(limit))


def get_patient(patient_id: int):
    return models.Patient.filter(models.Patient.id == patient_id).first()


def get_patient_by_phone(phone: str):
    return models.Patient.filter(models.Patient.phone == phone).first()


def create_patient(patient: schemas.PatientCreate):
    db_patient = models.Patient(**patient.dict())
    db_patient.save()
    return db_patient


def get_doctor(doctor_id: int):
    return models.Doctor.filter(models.Doctor.id == doctor_id).first()


def get_doctor_by_phone(phone: str):
    return models.Doctor.filter(models.Doctor.phone == phone).first()


def create_doctor(doctor: schemas.DoctorCreate):
    db_doctor = models.Doctor(**doctor.dict())
    db_doctor.save()
    return db_doctor


def get_symptom(symptom_id: int):
    return models.Symptom.filter(models.Symptom.id == symptom_id).first()


def create_symptom(symptom: schemas.SymptomCreate):
    db_symptom = models.Symptom(**symptom.dict())
    db_symptom.save()
    return db_symptom


def create_symptoms(symptoms: List[schemas.SymptomCreate]):
    symptoms_arr = []
    for symptom in symptoms:
        symptoms_arr.append(create_symptom(symptom))
    return symptoms_arr


def get_symptoms_of_patient(patient_id: int):
    return list(models.Symptom.filter(models.Symptom.owner_id == patient_id))


def get_document(document_id: int):
    return models.Document.filter(models.Document.id == document_id).first()


def create_document(document: schemas.DocumentCreate):
    db_doc = models.Document(**document.dict())
    db_doc.save()
    return db_doc


def get_documents_of_patient(patient_id: int):
    return list(models.Document.filter(models.Document.owner_id == patient_id))


def bind_patient_to_doctor(patient_id: int, doctor_id: int):
    q = models.Patient.update(doctor_id=doctor_id).where(models.Patient.id == patient_id)
    return {"bind_successful": bool(q.execute())}