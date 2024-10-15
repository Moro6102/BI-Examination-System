--           <<------------------------------------------------------------------------------------------------------------>>
--		                  <<----------------------------------------------------------------------->>
--						                <<------------------------------------------->>
--           <<------------------------------------------------------------------------------------------------------------>>
--		                  <<----------------------------------------------------------------------->>
--						                <<------------------------------------------->>

------------------------------------------  Create Users for Database ------------------------------------------------

--<<----		User 1								        ---->> 
--<<-----		Username = 'Instructor'		                ---->>
--<<-----		Password = '111'					        ---->>

/* 
   this user has a permession for (( Editing )) every thing related by Exam as ( select & insert & Update & Delete Exam )
   Either all things related by Exam such (( Editing )) The Questions
   Either Other Permission on Some Procedures
*/

Create Login Instructor with Password = '111'
go
use Grad_Examination_System
go
Create User Instructor  For Login Instructor

-----------------------------
----------------------
------------ (( Instructor Permissions ))
-------

Grant execute on [dbo].[SelectExam_sp] to Instructor
go
Grant alter on [dbo].[SelectExam_sp] to Instructor
go
Grant execute on [dbo].[DeleteExam_sp] to Instructor
go
Grant alter on [dbo].[DeleteExam_sp] to Instructor
go
Grant execute on [dbo].[InsertExam_sp] to Instructor
go
Grant alter on [dbo].[InsertExam_sp] to Instructor
go
Grant execute on [dbo].[UpdateExam_sp] to Instructor
go
Grant alter on [dbo].[UpdateExam_sp] to Instructor

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[SelectQuestion] to Instructor
go
Grant alter on [dbo].[SelectQuestion] to Instructor
go
Grant execute on [dbo].[Qestionpool_Delete] to Instructor
go
Grant alter on [dbo].[Qestionpool_Delete] to Instructor
go
Grant execute on [dbo].[Qestionpool_Insert] to Instructor
go
Grant alter on [dbo].[Qestionpool_Insert] to Instructor
go
Grant execute on [dbo].[Qestionpool_Update] to Instructor
go
Grant alter on [dbo].[Qestionpool_Update] to Instructor

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[SelectExamQuestion_sp] to Instructor                    --Other Permission
go
Grant execute on [dbo].[GetExamQuestionsAndChoices] to Instructor                  --Other Permission
go
Grant execute on [dbo].[display_exam] to Instructor                                        --Other Permission  
go
Grant execute on [dbo].[ExamGeneration_sp] to Instructor                                            --Other Permission
go
Grant execute on [dbo].[Get_all_Topics_in_Course] to Instructor                                             --Other Permission
go
Grant execute on [dbo].[Get_instructor_info] to Instructor 
go
Grant execute on [dbo].[Get_Students_Grades] to Instructor 
go
Grant execute on [dbo].[Get_Students_info] to Instructor 

--------------------------------------------------------
----------------------------------------
------------------------
--------------

--<<----		User 2								        ---->> 
--<<-----		Username = 'trainingmanager'		        ---->>
--<<-----		Password = '222'					        ---->>

/*
   7-	Training Manager (One of the instructors) can edit (add, Update and delete) instructors and courses and instructors for each course.
   8- 	Training manager can add and edit: Branches, tracks in each department, and add new intake.
   9-	Training manager can add students, and define their personal data, intake, branch, and track.
   10-	Training manager, Instructors, Students should have a login account to access the system.
*/

Create Login trainingmanager with Password = '222'
go
use Grad_Examination_System
go
Create User trainingmanager  For Login trainingmanager

-----------------------------
----------------------
------------ (( trainingmanager Permissions ))
-------

Grant execute on [dbo].[Update_Branch] to trainingmanager
go
Grant alter   on [dbo].[Update_Branch] to trainingmanager
go
Grant execute on [dbo].[Delete_Branch] to trainingmanager
go
Grant alter   on [dbo].[Delete_Branch] to trainingmanager
go
Grant execute on [dbo].[insert_Branch] to trainingmanager
go
Grant alter   on [dbo].[insert_Branch] to trainingmanager
go
Grant execute on [dbo].[Select_Branch] to trainingmanager
go
Grant alter   on [dbo].[Select_Branch] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[sp_InsertTrack] to trainingmanager
go
Grant alter   on [dbo].[sp_InsertTrack] to trainingmanager
go
Grant execute on [dbo].[sp_UpdateTrack] to trainingmanager 
go
Grant alter   on [dbo].[sp_UpdateTrack] to trainingmanager
go
Grant execute on [dbo].[sp_DeleteTrack] to trainingmanager
go
Grant alter   on [dbo].[sp_DeleteTrack] to trainingmanager
go
Grant execute on [dbo].[sp_SelectTracks] to trainingmanager
go
Grant alter   on [dbo].[sp_SelectTracks] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[sp_UpdateStudent] to trainingmanager
go
Grant alter on [dbo].[sp_UpdateStudent] to trainingmanager
go
Grant execute on [dbo].[sp_DeleteStudent] to trainingmanager
go
Grant alter on [dbo].[sp_DeleteStudent] to trainingmanager
go
Grant execute on [dbo].[sp_InsertStudent] to trainingmanager
go
Grant alter on [dbo].[sp_InsertStudent] to trainingmanager
go
Grant execute on [dbo].[sp_SelectStudents] to trainingmanager
go
Grant alter on [dbo].[sp_SelectStudents] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[Select_Course] to trainingmanager
go
Grant execute on [dbo].[Select_Course] to trainingmanager
go
Grant execute on [dbo].[Delete_Course] to trainingmanager
go
Grant execute on [dbo].[Delete_Course] to trainingmanager
go
Grant execute on [dbo].[Insert_Course] to trainingmanager
go
Grant execute on [dbo].[Insert_Course] to trainingmanager
go
Grant execute on [dbo].[Update_Course] to trainingmanager
go
Grant execute on [dbo].[Update_Course] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[Select_Department] to trainingmanager
go
Grant alter on [dbo].[Select_Department] to trainingmanager
go
Grant execute on [dbo].[Delete_Department] to trainingmanager
go
Grant alter on [dbo].[Delete_Department] to trainingmanager
go
Grant execute on [dbo].[Insert_Department] to trainingmanager
go
Grant alter on [dbo].[Insert_Department] to trainingmanager
go
Grant execute on [dbo].[Update_Department] to trainingmanager
go
Grant alter on [dbo].[Update_Department] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

Grant execute on [dbo].[sp_SelectInstructor] to trainingmanager
go
Grant alter on [dbo].[sp_SelectInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_DeleteInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_DeleteInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_InsertInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_InsertInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_UpdateInstructor] to trainingmanager
go
Grant execute on [dbo].[sp_UpdateInstructor] to trainingmanager

--------------------------------------------------------
----------------------------------------
------------------------
--------------

--<<----		User 3								        ---->> 
--<<-----		Username = 'Student'		        ---->>
--<<-----		Password = '333'					        ---->>

Create Login Student with Password = '333'
go
use Grad_Examination_System
go
Create User Student  For Login Student

-----------------------------
----------------------
------------ (( Student Permissions  ))
-------

Grant execute on [dbo].[Get_Students_Grades] to Student
go
Grant execute on [dbo].[StudentGradeswithReport] to Student
go
Grant execute on [dbo].[Report_Question_Stud_Answer] to Student
go
Grant execute on [dbo].[Get_all_Questions_with_answer] to Student