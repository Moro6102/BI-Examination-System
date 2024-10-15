--enroll course number 1 for 2 students with (100,101) ids
insert into Stud_enroll_course 
values(100,1,null,null),
	  (101,1,null,null)

/*
ExamGeneration_sp works as follows:
	- Insert Exam Metadata
	- Insert Students in Answer Table
	- Insert Exam Questions
	- Final Message

test case for ExamGeneration_sp
generate exam with these attributes:
41, 'Corrective Exam', 'Exam Contains T/f and MCQ Questions, Answer All Questions',
2024, 2, '2024-09-24 10:00:00', '2024-09-24 12:00:00', 4, 3, 1, 1
*/

exec ExamGeneration_sp 
    @ex_id = 41, 
    @ex_type = 'Corrective Exam', 
    @ex_allowoptions = 'Exam Contains T/F and MCQ Questions, Answer All Questions', 
    @ex_year = 2024, 
    @ex_totaltime = 2, 
    @ex_st_time = '2024-09-20 01:00:00', 
    @ex_end_time = '2024-09-20 03:00:00', 
    @ex_TF_num = 4, 
    @ex_Mcq_num = 3, 
    @ins_id = 1, 
    @crs_id = 1;

/*
after sp execution:
1 insertion in Exam table with id = 41
2 insertions in Stud_answer_exam table which the students that enroll this course and not have grade for it (in our case the inserted 2 students before execution) 
7 insertions in Exam_contain_question which ex_id = 41 and q_ids in this exam, which 4 T/F and 3 MCQ
*/

---------------------------------------------------------------------------------------------

/*
display_exam sp takes student id, exam id and works as follows:
	- check if student exists in student answer exam table specifically for this exam 
	- check current date is between start date and end date (datetime)
	- if all is valid, display exam questions
	- it continues till the end time then print message that Exam Ended and stop 
	- if not, print Not Valid To Enter The Exam!.

test cases for display_exam sp
st_id = 100, ex_id = 41
st_id = 101, ex_id = 41
st_id = 102, ex_id = 41
*/

exec display_exam @st_id = 100, @ex_id = 41            --Valid
--exec display_exam @st_id = 101, @ex_id = 41          --Valid
--exec display_exam @st_id = 102, @ex_id = 41          --Not Valid


-------------------------------------------------------------------------------------------------------------
/*This stored procedure is designed to record or process a student's answers to an exam.
 The procedure accepts the student's ID, exam ID, course ID, and their answers as parameters.*/


exec sp_ExamAnswer @st_id=100, @ex_id=41,@crs_id =1,@student_answer='True,b,True,d,True,True,b'
Go
------------------------------------------------------------------------------------------------
/*This stored procedure is to correct the student's answers in a particular exam.
The procedure uses the student ID, exam ID and course ID to fetch the submitted answers,
evaluate them, and compare them with the correct answers stored in the system.*/

exec [dbo].[Correct_Qestions]  @stu_id=100, @exm_id=41,@crs_id =1
----------------------------------------------------------------------------------------------------
/*The StudentStatus stored procedure is most likely to be used to evaluate a student's status in a particular course.
The student's status can be based on their exam results.
The status is returned as either "Pass" or "Corrective" */
exec sp_StudentStatus @st_id=100, @crs_id=1
----------------------------------------------------------------------------------------------------

Select * from Stud_enroll_course Where st_id =100 and crs_id =1

------------------------------------------------------------------------------------------------

          --------------------------------------------------------------
		        --------------------------------------------------
		                ---------------------------------
		                       ------------------
---------------------------------------------- SP Reports --------------------------------------------------

-- First Report that returns the students information according to Department Number as parameter
-- test case: get students in department 1
exec Get_Students_info 1

----------------------------------------------------------------------

--Second Report that takes the student ID and returns the grades of the student in all courses
-- test case: get all grades for student with id = 95
exec Get_Students_Grades 95

-------------------------------------------------------------------------

--Third Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course
-- test case: get all courses taught by the teacher with id = 5 with number of students in each course
exec Get_instructor_info 5

--------------------------------------------------------------------------

-- Fourth Report that takes course ID and returns its topics
-- test case: get all topics in course with id = 23 
exec Get_all_Topics_in_Course 23

--------------------------------------------------------------------------

-- fifth Report that takes exam number and returns the Questions in it and chocies 

EXEC GetExamQuestionsAndChoices @ExamID = 1


--------------------------------------------------------------------------

-- Sixth Report that takes exam number and the student ID then returns the Questions in this exam with the student answers. 

exec Report_Question_Stud_Answer @exam_id=1 ,@stud_id=7
          --------------------------------------------------------------
		        --------------------------------------------------
		                ---------------------------------
		                       ------------------
