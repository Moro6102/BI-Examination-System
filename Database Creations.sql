create database Grad_Examination_System
go

use Grad_Examination_System
go

create table Student (
    st_id int primary key,
    st_name varchar(max),
    st_age int,
    st_address varchar(max),
    st_email varchar(max),
    st_phone varchar(23),
    track_id int
);
GO

create table Instructor (
    ins_id int primary key,
    ins_name varchar(max),
    ins_birthdate date,
    ins_email varchar(max),
    ins_salary decimal(10, 4),
    ins_phone varchar(23),
    dept_id int
);
GO

create table Exam (
    ex_id int primary key,
    ex_type varchar(256),
    ex_allowoptions varchar(max),
    ex_year int,
    ex_totaltime int,
    ex_st_time datetime,
    ex_end_time datetime,
    TF_num int,
    Mcq_num int,
    ins_id int,
    crs_id int
);
GO

create table Course (
    crs_id int primary key,
    crs_name varchar(max),
    mn_degree int,
    mx_degree int,
    track_id int
);
GO

create table Topic (
    topic_id int primary key,
    topic_name varchar(max),
    crs_id int
);
GO

create table Question_pool (
    q_id int primary key,
    q_question varchar(max),
    q_type varchar(max),
    q_correct_ans varchar(max),
    q_degree int,
    crs_id int
);
GO

create table Question_mcqOptions (
    q_id int,
    mcq_options varchar(255),
    primary key (q_id, mcq_options)
);
GO

create table Department (
    dept_id int primary key,
    dept_name varchar(max),
    dept_desc varchar(max),
    branch_id int,
    ins_id int, -- the manager
    HireDate date
);
GO

create table Track (
    track_id int primary key,
    track_name varchar(max),
    dept_id int,
    intake_id int
);
GO

create table Intake (
    intake_id int primary key,
    intake_name varchar(max),
    intake_year int
);
GO

create table Branch (
    branch_id int primary key,
    branch_name varchar(max),
    branch_location varchar(max)
);
GO

create table Exam_contain_question (
    ex_id int,
    q_id int,
    primary key (ex_id, q_id)
);
GO

create table Stud_enroll_course (
    st_id int,
    crs_id int,
    grade int,
    status varchar(max),
    primary key (st_id, crs_id)
);
GO

create table Stud_answer_exam (
    st_id int,
    ex_id int,
    crs_id int,
    student_answer varchar(max),
    primary key (st_id, ex_id, crs_id)
);
GO

create table Ins_teach_course (
    ins_id int,
    crs_id int,
    year int,
    primary key (ins_id, crs_id, year)
);
GO




use Grad_Examination_System;


alter table Student
add constraint FK_Student_Track foreign key (track_id) 
references Track(track_id)
on delete cascade 
on update cascade;

alter table Instructor
add constraint FK_Instructor_Dept foreign key (dept_id) 
references Department(dept_id)
on delete cascade 
on update cascade;

alter table Exam
add constraint FK_Exam_Instructor foreign key (ins_id) 
references Instructor(ins_id)
on delete cascade 
on update cascade;

alter table Exam
add constraint FK_Exam_Course foreign key (crs_id) 
references Course(crs_id)
on delete cascade 
on update cascade;

alter table Course
add constraint FK_Course_Track foreign key (track_id) 
references Track(track_id)
on delete cascade 
on update cascade;

alter table Topic
add constraint FK_Topic_Course foreign key (crs_id) 
references Course(crs_id)
on delete cascade 
on update cascade;

alter table Question_pool
add constraint FK_QPool_Course foreign key (crs_id) 
references Course(crs_id)
on delete cascade 
on update cascade;

alter table Question_mcqOptions
add constraint fk_Question_mcqOptions_Question_pool foreign key (q_id) 
references Question_pool(q_id);

alter table Department
add constraint FK_Department_Branch foreign key (branch_id) 
references Branch(branch_id)
on delete cascade 
on update cascade;

alter table Department
add constraint FK_Department_Manager foreign key (ins_id) 
references Instructor(ins_id)
on delete no action 
on update no action;

alter table Track
add constraint FK_Track_Dept foreign key (dept_id) 
references Department(dept_id)
on delete no action 
on update no action;

alter table Track
add constraint FK_Track_Intake foreign key (intake_id) 
references Intake(intake_id)
on delete cascade 
on update cascade;

alter table Exam_contain_question
add constraint FK_ExamQuestion_Exam foreign key (ex_id) 
references Exam(ex_id)
on delete cascade 
on update cascade;

alter table Exam_contain_question
add constraint FK_ExamQuestion_QPool foreign key (q_id) 
references Question_pool(q_id)
on delete no action 
on update no action;

alter table Stud_enroll_course
add constraint FK_EnrollCourse_Student foreign key (st_id) 
references Student(st_id)
on delete cascade 
on update cascade;

alter table Stud_enroll_course
add constraint FK_EnrollCourse_Course foreign key (crs_id) 
references Course(crs_id)
on delete no action 
on update no action;

alter table Stud_answer_exam
add constraint FK_AnswerExam_Student foreign key (st_id) 
references Student(st_id)
on delete cascade 
on update cascade;

alter table Stud_answer_exam
add constraint FK_AnswerExam_Exam foreign key (ex_id) 
references Exam(ex_id)
on delete no action 
on update no action;

alter table Stud_answer_exam
add constraint FK_AnswerExam_Course foreign key (crs_id) 
references Course(crs_id)
on delete no action 
on update no action;

alter table Ins_teach_course
add constraint FK_TeachCourse_Instructor foreign key (ins_id) 
references Instructor(ins_id)
on delete cascade 
on update cascade;

alter table Ins_teach_course
add constraint FK_TeachCourse_Course foreign key (crs_id) 
references Course(crs_id)
on delete cascade 
on update cascade;


