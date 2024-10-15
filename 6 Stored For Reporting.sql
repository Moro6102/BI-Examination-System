------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>

/*  Function of First Report
    First Report that returns the students information according to Department No parameter */

		Create or alter Proc Get_Students_info @Dept_id int
		as
		select  distinct S.* , T.track_name , D.dept_name , B.branch_name
		From    Student as S , Track as T, Department as D , Course as C , Branch as B
		where   S.track_id = T.track_id and T.dept_id =D.dept_id and
			    T.track_id = C.track_id and D.branch_id = B.branch_id
			    and D.dept_id = @Dept_id

	


		Exec Get_Students_info 1

------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>

/*  Function of Second Report
    Second Report that takes the student ID and returns the grades of the student in all courses. */

		Create or alter Proc Get_Students_Grades @Student_id int
		as
		select  S.st_name  , C.crs_name  , SC.grade ,  SC.status
		From    Student as S  ,  Course as C  ,  Stud_enroll_course as SC
		where   S.st_id  =   SC.st_id   and   SC.crs_id  =   C.crs_id
			    and S.st_id = @Student_id


		 Exec Get_Students_Grades 95

------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>

/*  Function of Third Report
    Third Report that takes the instructor ID
	and returns the name of the courses that he teaches and the number of student per course */

		Create or alter Proc Get_instructor_info @instructor_id int
		as
		select  I.ins_name  ,   C.crs_name  , COUNT(S.st_id) as [ Number of Students Per instructor_Course ] 
		From    Instructor as I   ,  Ins_teach_course   ,   Course as C   ,   Track as T   ,  Student as S
		where   I.ins_id  =   Ins_teach_course.ins_id   and   Ins_teach_course.crs_id  =  C.crs_id 
				and C.track_id  =  T.track_id   and T.track_id  = S.track_id and  I.ins_id = @instructor_id

		Group by C.crs_name , I.ins_name


        Exec Get_instructor_info 5

------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>


/*  Function of Fourth Report
    Fourth Report that takes course ID and returns its topics   */

		Create or alter Proc Get_all_Topics_in_Course @Course_id int
		as
		select  C.crs_name , T.topic_name
		From    Course as C  , Topic as T
		where   C.crs_id  = T.crs_id  and   C.crs_id  =  @Course_id


        Exec Get_all_Topics_in_Course 23


------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>

---------------  REPORT 5

create OR ALTER   PROCEDURE GetExamQuestionsAndChoices
    @ExamID INT
AS
BEGIN
    SELECT 
    qp.q_id, qp.q_question AS Question,
     ISNULL(STRING_AGG(qmo.mcq_options, '
	 '),'Ture [ ]
	 False [ ]' )AS Choices 
    FROM  
        Exam_contain_question ecq
    JOIN 
        Question_pool qp ON ecq.q_id = qp.q_id
    LEFT JOIN 
        Question_mcqOptions qmo ON qp.q_id = qmo.q_id
    WHERE 
        ecq.ex_id = @ExamID 
    GROUP BY 
        qp.q_id,qp.q_question
END

------------------------------------------------------------------------------->>
---------------------------------------------------------->>
------------------------------------------>>
-------------------------------->>
--------------------->>
----- REPORT 6

CREATE OR ALTER  Proc Report_Question_Stud_Answer @exam_id int , @Stud_id int
as

Declare @question table (qcol1 int identity(1,1),qcol2 varchar(max))

Declare @Answers table (acol1 int identity(1,1),acol2 varchar(max))

Insert into @Answers  (acol2)
Select value
From [dbo].[Stud_answer_exam] Cross apply string_split([student_answer],',')
Where ex_id = @exam_id And st_id = @Stud_id

----------------------------------------------------
Insert into  @question (qcol2)
Select a.q_question
From [dbo].[Question_pool] a
inner join [dbo].[Exam_contain_question] b
On a.q_id = b.q_id
And b.ex_id = @exam_id

--------------------------- Get Exam Question ---------------------------------------

Select b.qcol2 as "Exam Questions" , a.acol2 as "Student Answers"
From @Answers a inner join @question b
On a.acol1 = b.qcol1