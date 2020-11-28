-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-11-28 19:13:44.784

-- tables
-- Table: ADMISSIONS
CREATE TABLE ADMISSIONS (
    row_id int NOT NULL,
    subject_id int NOT NULL,
    hadm_id int NOT NULL,
    admittime datetime NOT NULL,
    dischtime datetime NOT NULL,
    deathtime datetime NOT NULL,
    admission_type varchar(50) NOT NULL,
    admission_location varchar(50) NOT NULL,
    discharge_location varchar(50) NOT NULL,
    insurance varchar(255) NOT NULL,
    language varchar(10) NOT NULL,
    religion varchar(50) NOT NULL,
    marital_status varchar(50) NOT NULL,
    ethnicity varchar(200) NOT NULL,
    edregtime datetime NOT NULL,
    edouttime datetime NOT NULL,
    diagnosis varchar(300) NOT NULL,
    hospital_expire_flag int NOT NULL,
    has_chartevents_data int NOT NULL,
    CONSTRAINT ADMISSIONS_pk PRIMARY KEY (hadm_id)
);

-- Table: DIAGNOSES_ICD
CREATE TABLE DIAGNOSES_ICD (
    row_id int NOT NULL,
    subject_id int NOT NULL,
    hadm_id int NOT NULL,
    seq_num int NOT NULL,
    icd9_code varchar(10) NOT NULL,
    CONSTRAINT DIAGNOSES_ICD_pk PRIMARY KEY (row_id)
);

-- Table: DOID
CREATE TABLE DOID (
    DOID varchar(10) NOT NULL,
    icd9_code varchar(10) NOT NULL,
    CONSTRAINT DOID_pk PRIMARY KEY (DOID)
);

-- Table: D_ICD_DIAGNOSES
CREATE TABLE D_ICD_DIAGNOSES (
    row_id int NOT NULL,
    icd9_code varchar(10) NOT NULL,
    short_title varchar(50) NOT NULL,
    long_title varchar(300) NOT NULL,
    CONSTRAINT D_ICD_DIAGNOSES_pk PRIMARY KEY (icd9_code)
);

-- Table: PATIENTS
CREATE TABLE PATIENTS (
    row_id int NOT NULL,
    subject_id int NOT NULL,
    gender varchar(5) NOT NULL,
    dob datetime NOT NULL,
    dod datetime NOT NULL,
    dod_hosp datetime NOT NULL,
    dod_ssn datetime NOT NULL,
    expire_flag varchar(5) NOT NULL,
    CONSTRAINT PATIENTS_pk PRIMARY KEY (subject_id)
);

-- Table: SYNONYM
CREATE TABLE SYNONYM (
    row_id int NOT NULL,
    DOID varchar(10) NOT NULL,
    label varchar(100) NOT NULL,
    synonym varchar(100) NOT NULL,
    CONSTRAINT SYNONYM_pk PRIMARY KEY (row_id)
);

-- foreign keys
-- Reference: ADMISSIONS_PATIENTS (table: ADMISSIONS)
ALTER TABLE ADMISSIONS ADD CONSTRAINT ADMISSIONS_PATIENTS FOREIGN KEY ADMISSIONS_PATIENTS (subject_id)
    REFERENCES PATIENTS (subject_id);

-- Reference: DIAGNOSES_ICD_ADMISSIONS (table: DIAGNOSES_ICD)
ALTER TABLE DIAGNOSES_ICD ADD CONSTRAINT DIAGNOSES_ICD_ADMISSIONS FOREIGN KEY DIAGNOSES_ICD_ADMISSIONS (hadm_id)
    REFERENCES ADMISSIONS (hadm_id);

-- Reference: DIAGNOSES_ICD_D_ICD_DIAGNOSES (table: DIAGNOSES_ICD)
ALTER TABLE DIAGNOSES_ICD ADD CONSTRAINT DIAGNOSES_ICD_D_ICD_DIAGNOSES FOREIGN KEY DIAGNOSES_ICD_D_ICD_DIAGNOSES (icd9_code)
    REFERENCES D_ICD_DIAGNOSES (icd9_code);

-- Reference: DIAGNOSES_ICD_PATIENTS (table: DIAGNOSES_ICD)
ALTER TABLE DIAGNOSES_ICD ADD CONSTRAINT DIAGNOSES_ICD_PATIENTS FOREIGN KEY DIAGNOSES_ICD_PATIENTS (subject_id)
    REFERENCES PATIENTS (subject_id);

-- Reference: DOID_D_ICD_DIAGNOSES (table: DOID)
ALTER TABLE DOID ADD CONSTRAINT DOID_D_ICD_DIAGNOSES FOREIGN KEY DOID_D_ICD_DIAGNOSES (icd9_code)
    REFERENCES D_ICD_DIAGNOSES (icd9_code);

-- Reference: SYNONYM_DOID (table: SYNONYM)
ALTER TABLE SYNONYM ADD CONSTRAINT SYNONYM_DOID FOREIGN KEY SYNONYM_DOID (DOID)
    REFERENCES DOID (DOID);

-- End of file.

