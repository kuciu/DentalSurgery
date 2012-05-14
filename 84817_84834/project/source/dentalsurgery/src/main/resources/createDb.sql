
drop table if exists phone_numbers;
drop table if exists patients;
drop table if exists illnesses;
drop table if exists medications;
drop table if exists visits;
drop table if exists visit_activity_dict;
drop table if exists visit_activities;
drop table if exists tooth_state_dict;
drop table if exists tooths;
drop table if exists tooth_activity_dict;
drop table if exists tooth_activities;
drop table if exists attachments;

create table phone_numbers(
    phone_id int not null auto_increment primary key,
    patient_id int not null,
    phone_number varchar(20)
);

create table patients (
    patient_id int not null auto_increment primary key,
    name varchar(20) not null,
    surname varchar(20) not null,
    born_date timestamp not null,
    city varchar(20),
    street varchar(20),
    blood_group varchar(2),
	pesel varchar(11) not null,
	gender CHAR NOT null
);

create table illnesses(
    illness_id int not null auto_increment primary key,
    patient_id int not null,
    name varchar(20)
);

create table medications(
    medication_id int not null auto_increment primary key,
    patient_id int not null,
    name varchar(20)
);

create table visits (
    visit_id int not null auto_increment primary key,
    patient_id int not null,
    date timestamp not null,
    comments varchar(1000)
);

create table visit_activity_dict (
    va_dict_id int not null auto_increment primary key,
    description varchar(100) not null,
    price decimal(7,2),
    vat decimal(2,2)
);

create table visit_activities (
    visit_id int not null,
    va_dict_id int not null
);

create table tooth_state_dict (
    ts_dict_id int not null auto_increment primary key,
    description varchar(100),
    all_tooth boolean
);

create table tooths (
    tooth_id int not null auto_increment primary key,
    visit_id int not null,
    tooth_number int not null,
    all_tooth_state int,
    area_1_state int,
    area_2_state int,
    area_3_state int,
    area_4_state int,
    area_5_state int,
    area_6_state int,
    area_7_state int,
    area_8_state int
);

create table tooth_activity_dict (
    ta_dict_id int not null auto_increment primary key,
    description varchar(100),
    all_tooth boolean not null,
    price decimal(7,2),
    vat decimal(2,2)
);

create table tooth_activities (
    tooth_id int not null,
    ta_dict_id int not null
);

create table attachments (
    attachment_id int not null auto_increment primary key,
    visit_id int not null,
    file_name varchar(300) not null,
    description varchar(1000) not null,
    file longblob not null
);