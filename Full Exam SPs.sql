/*
The procedure then performs the following actions:
	Insert Exam Metadata: It inserts the provided exam metadata into the Exam table by calling InsertExam_sp.
	Insert Students in Answer Table:
		It checks for students enrolled in the specified course who do not have a grade.
		It inserts these students into the Stud_answer_Exam table for the specified exam.
	Insert Exam Questions:
		It checks if there are enough True/False questions in the Question_pool for the specified course.
		If valid, it randomly selects and inserts the specified number of True/False questions into the Exam_contain_question table.
		If not valid, it prints a message indicating insufficient True/False questions.
		It performs a similar check for Multiple Choice questions:
		If valid, it randomly selects and inserts the specified number of Multiple Choice questions.
		If not valid, it prints a message indicating insufficient Multiple Choice questions.
	Final Message: If all steps are successful, it prints "Exam Generated Successfully".
*/

create or alter procedure ExamGeneration_sp 
	@ex_id int,
    @ex_type varchar(20),
    @ex_allowoptions varchar(100),
	@ex_year int,
	@ex_totaltime int,
	@ex_st_time datetime,
	@ex_end_time datetime,
	@ex_TF_num int,
	@ex_Mcq_num int,
	@ins_id int,
	@crs_id int
 as 
	 -- insert exam metadata in exam table
 	 exec InsertExam_sp @ex_id, @ex_type, @ex_allowoptions, @ex_year, @ex_totaltime, @ex_st_time, @ex_end_time, @ex_TF_num, @ex_Mcq_num, @ins_id, @crs_id

	 begin try
		 -- insert studets in student answer table 
		 insert into Stud_answer_Exam(st_id, ex_id, crs_id)
		 select stc.st_id, @ex_id, stc.crs_id
		 from Stud_enroll_course as stc, Exam as ex
		 where ex.ex_id = @ex_id
		 and stc.crs_id = ex.crs_id
		 and stc.grade is null
	 
	 -- insert questions for exam in exam question table

	 -- insert T or F questions
	 if @ex_TF_num <= (select count(q.q_id) from Question_pool q where q.crs_id = @crs_id and q.q_type = 'True/False')
		 begin
			 declare @tf_count int = 1
			 while @tf_count <= @ex_TF_num
				 begin
					 insert into Exam_contain_question (ex_id, q_id)
					 select top 1 @ex_id, q.q_id 
					 from Question_pool as q
					 where q.crs_id = @crs_id
					 and q.q_type = 'True/False'
					 and q_id not in (select q_id from Exam_contain_question where ex_id = @ex_id)
					 order by newid()
					 set @tf_count = @tf_count + 1
				  end
		  end
      else 
		print 'Not Enough T or F Questions in The Selected Course'
	 
	 -- insert MCQ questions
	 if @ex_Mcq_num <= (select count(q.q_id) from Question_pool q where q.crs_id = @crs_id and q.q_type = 'Multiple Choice')
		begin 
			 declare @mcq_count int = 1
			 while @mcq_count <= @ex_Mcq_num
				 begin
					 insert into Exam_contain_question (ex_id, q_id)
					 select top 1 @ex_id, q.q_id 
					 from Question_pool as q
					 where q.crs_id = @crs_id
					 and q.q_type = 'Multiple Choice'
					 and q.q_id not in (select q_id from Exam_contain_question where ex_id = @ex_id)
					 order by newid()
					 set @mcq_count = @mcq_count + 1
				  end
		end
      else 
		print 'Not Enough MCQ Questions in The Selected Course'

	 print 'Exam Generated Successfully'
	 end try

	 begin catch
		 print 'Data is Not Valid'
	 end catch

-- Exam (ex_id, ex_type, ex_allowoptions, ex_year, ex_totaltime, ex_st_time, ex_end_time, TF_num, Mcq_num, ins_id, crs_id)

-- test case
exec ExamGeneration_sp 50, 'Course Exam', 'answer all questions', 2024, 2, '09-01-2024 10:00:00', '09-01-2024 12:00:00', 3, 2, 1, 1

-----------------------------------------------------------------------------------------------------------------------------

--#################################################################--
/*
This procedure takes student id, exam id and then:
	   check if student exists in student answer exam table specifically for this exam 
	   and check current date is between start date and end date (datetime)
	   if all is valid, display exam questions
	   it continues till the end time then print message that Exam Ended and stop 
	   if not, print Not Valid To Enter The Exam!.
*/
create or alter procedure display_exam @st_id int, @ex_id int
as
    begin
        declare @currentdate datetime = getdate()
		declare @start datetime = (select e.ex_st_time from Exam e where e.ex_id = @ex_id)
		declare @end datetime = (select e.ex_end_time from Exam e where e.ex_id = @ex_id)
        -- check validation
        if exists (
            select 1
            from Stud_answer_exam s
            where s.st_id = @st_id 
			and s.ex_id = @ex_id
			and @currentDate between @start and @end)
			begin
				select q.q_id, q.q_question, q.q_type, 'True - False' as q_options, q.q_degree 
				from Question_Pool q, Exam_contain_question ex
				where q.q_id = ex.q_id
				and ex.ex_id = @ex_id
				and q.q_type = 'True/False'
				union
				select q.q_id, q.q_question, q.q_type
				, string_agg (qmcq.mcq_options, ' - ') within group (order by qmcq.mcq_options)
				, q.q_degree
				from Question_Pool q, Question_McqOptions qmcq, Exam_contain_question ex
				where q.q_id = ex.q_id 
				and q.q_id = qmcq.q_id
				and ex.ex_id = @ex_id
				and q.q_type = 'Multiple Choice'
				group by q.q_id, q.q_question, q.q_type, q.q_degree

				declare @c int = 1
				while getdate() < @end
					begin
						if @c = 1
							begin
								select 'Exam Ended' as 'Message'
								set @c = 0
							end
					end
			end
		else 
			print 'Not Valid To Enter The Exam!'
		return;
    end

-- test case
exec display_exam 100, 41

---------------------------------------------------------------------------------------------------------------------------------

--#################################################################--
--ExamAnswer SP
CREATE OR ALTER PROCEDURE [dbo].[sp_ExamAnswer]
    @st_id int, 
    @ex_id int,
    @crs_id int,
    @student_answer varchar(MAX)
AS
BEGIN

    BEGIN TRY
        BEGIN TRANSACTION
        
        UPDATE Stud_answer_exam
        SET 
            student_answer = @student_answer
        WHERE 
            st_id = @st_id
            AND ex_id = @ex_id
            AND crs_id = @crs_id
        
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END

----------------------------------------------------------------------------------------------------------------

--#################################################################--
--Correction SP
CREATE OR ALTER Proc [dbo].[Correct_Qestions] (@Stu_id int ,@exm_id int , @crs_id int)
AS

Declare @Correct_Answer Table (clo1 int identity(1,1) ,col2 varchar(max) )

Insert into @Correct_Answer(col2)
Select lower(a.q_correct_ans)
From Question_pool a inner join Exam_contain_question b
on a.q_id=b.q_id
and a.crs_id = @crs_id and b.ex_id=@exm_id
---------------Store Correct Answer -------------------------
Declare @Stu_Answer Table (clo1 int identity(1,1) ,col2 varchar(max) )

Insert into @Stu_Answer (col2)
Select lower(Ltrim(Rtrim(value)))
From [dbo].[Stud_answer_exam] a Cross Apply String_split( student_answer,',')
Where a.ex_id = @exm_id and a.crs_id = @crs_id and a.st_id = @Stu_id  --@exm_id

--------------Store Student Answer---------------------------
Declare @Dgree Table (clo1 int identity(1,1), col2 varchar(max) )

Insert into @Dgree (col2)
seLect a.[q_degree]
From [dbo].[Question_pool] a inner join [dbo].[Exam_contain_question] b
On a.q_id = b.q_id
And b.ex_id = @exm_id  and a.crs_id = @crs_id

--------------Store Question Grade-----------------------------
Declare @Exam_num int

SELECT @Exam_num = TF_num + Mcq_num 
From [dbo].[Exam]
Where ex_id = @exm_id

--------------Get Num of Exam's Question -----------------------------
Declare @loob int = 1
Declare @Grad int = 0

While  @loob <= @Exam_num
Begin	 
Declare @stu_value varchar(Max)
Declare @correct_value varchar(Max)
Select @stu_value = a.col2 , @correct_value = b.col2
From @Correct_Answer a inner join @Stu_Answer b
On a.clo1 = b.clo1
And A.clo1 = @loob

		If  @stu_value = @correct_value
			Begin
				Select @Grad = @Grad + col2
				From @Dgree
				Where clo1 = @loob

			End
set @loob = @loob + 1
End
--Select @Grad 
---------------------------------Check the answer of Student and store The Degree Of Qestion in case of it's correct---------------------------------

		Update [dbo].[Stud_enroll_course] 
		Set grade= @Grad 
		Where st_id = @Stu_id And crs_id = @crs_id

-----------------------------------------------------------------------------------------------------------------------

--#################################################################--
--StudentStatus SP
CREATE OR ALTER PROCEDURE [dbo].[sp_StudentStatus] 
    @st_id int,  
    @crs_id int  
AS
BEGIN

    -- Check if a record was found	
		DECLARE @grade int
		DECLARE @Flag Bit = 0
	    SELECT @grade = grade
		FROM Stud_enroll_course
		WHERE st_id = @st_id AND crs_id = @crs_id and grade IS NOT NULL

		IF len(@grade) > 0
		Set @Flag = 1
		IF @Flag =1
		BEGIN 
        IF @grade >= (select [mn_degree] from Course c where c.crs_id = @crs_id) 
        BEGIN
            UPDATE Stud_enroll_course
            SET status = 'Pass'
            WHERE st_id = @st_id AND crs_id = @crs_id AND grade = @grade
        end
        ELSE
        BEGIN
            UPDATE Stud_enroll_course
            SET status = 'Corrective'
            WHERE st_id = @st_id AND crs_id = @crs_id
        END 
		END
    
    ELSE
	BEGIN
    
        PRINT 'No record found for the given st_id and crs_id.'
   
	END
END 