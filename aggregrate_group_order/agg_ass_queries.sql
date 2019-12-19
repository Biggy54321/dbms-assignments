-- 1
select count(*) as teachers_dont_teach
from (select ID
      from instructor
      except
      select distinct ID
      from teaches) as teacher_dont_teach_ids;

-- 2
select building, sum(capacity) as total_capacity
from classroom
group by building;

-- 3
select count(ID) as max_teachers
from teaches
group by course_id, sec_id, semester, year
order by count(ID) desc
limit 1;

-- 4
select dept_name, count(ID) as num_of_teachers
from instructor
group by dept_name
order by num_of_teachers desc;

-- 5
select ID, sum(credits)
from takes, course
where takes.course_id = course.course_id and
      takes.grade != "F" and
      takes.grade is not null
      group by takes.ID;

-- 6
select count(distinct takes.ID)
from takes, teaches, instructor
where instructor.name = "Srinivasan" and
      instructor.ID = teaches.ID and
      teaches.course_id = takes.course_id;

-- 7
select name, salary
from instructor
where salary in (select max(salary)
                 from instructor
                 group by dept_name);

-- 8
select takes.ID from takes
except
select students_not_in_all_srinivasan.ID from (select student.ID, srinivasan_courses.course_id
                                             from student, (select teaches.course_id
                                             from teaches, instructor
                                             where instructor.name = "Srinivasan" and
                                             instructor.ID = teaches.ID) as srinivasan_courses
                                             except
                                             select takes.ID, takes.course_id
                                             from takes) as students_not_in_all_srinivasan;

-- 9
select dept_name, sum(salary) as total_money
from instructor
group by dept_name;

-- 10
with instructor_teaching_max_course as (with instructor_course_count as (select teaches.ID, count(teaches.course_id) course_count
                                                                         from teaches
                                                                         group by teaches.ID)
                                        select instructor_course_count.ID
                                        from instructor_course_count
                                        where instructor_course_count.course_count = (select max(instructor_course_count.course_count)
                                                                                      from instructor_course_count))
select student.name
from advisor, instructor_teaching_max_course, student
where advisor.i_ID = instructor_teaching_max_course.ID and student.ID = advisor.s_ID;

-- 11
select course.course_id, course.title
from course
where course.course_id not in (select prereq.course_id
                               from prereq);

-- 12
select student.name
from student
where student.ID in (select takes.ID
                     from takes
                     where takes.course_id not in (select course.course_id
                                                   from course
                                                   where course.dept_name = "Biology"));
