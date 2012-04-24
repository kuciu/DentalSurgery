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
    blood_group varchar(2)
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
    descriptionvisit_activity_dictvisit_activity_dict varchar(100) not null,
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
    toot_number int not null,
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