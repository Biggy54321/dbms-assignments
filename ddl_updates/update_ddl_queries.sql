-- A1
update instructor
set salary = salary * 1.10;

-- A2
update instructor
set salary = salary + 50000
where instructor.ID in (select advisor.i_ID
                       from advisor
                       group by advisor.i_ID
                       having count(advisor.s_ID) >= 2);

-- B1
-- Add new fields
alter table student
add (course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year decimal(4, 0));

-- Add foreign key constraints
alter table student
add foreign key (course_id, sec_id, semester, year)
references section (course_id, sec_id, semester, year) on delete set null;

-- Add some entries (null means not an assistant)
update student
set course_id = 'CS-101',
    sec_id = "1",
    semester = "Fall",
    year = 2009
where ID = "00128";

update student
set course_id = 'CS-319',
    sec_id = "2",
    semester = "Spring",
    year = 2010
where ID = "54321";

update student
set course_id = 'HIS-351',
    sec_id = "1",
    semester = "Spring",
    year = 2010
where ID = "19991";

update student
set course_id = 'PHY-101',
    sec_id = "1",
    semester = "Fall",
    year = 2009
where ID in ("44553", "45678");

update student
set course_id = 'EE-181',
    sec_id = "1",
    semester = "Spring",
    year = 2009
where ID in ("76653", "98765");

update student
set course_id = 'BIO-301',
    sec_id = "1",
    semester = "Summer",
    year = 2010
where ID in ("98988");

-- B2
-- Get constraint names
select *
from information_schema.table_constraints
where table_name = "advisor";

-- Drop the foreign key constraints first
alter table advisor drop constraint advisor_ibfk_1;
alter table advisor drop constraint advisor_ibfk_2;

-- Drop the existing primary key
alter table advisor drop constraint advisor.PRIMARY;

-- Add new primary key
alter table advisor add primary key (s_ID, i_ID);

-- Add the foreign key constraints to the new again
alter table advisor add foreign key (s_ID) references student (ID);
alter table advisor add foreign key (i_ID) references instructor (ID);

-- B3
insert into instructor values ("11111", "Ashok", "Elec. Eng.", "80000.00");

insert into advisor values ("12345", "22222"),
                           ("12345", "76766"),
                           ("76653", "45565"),
                           ("76653", "10101"),
                           ("12345", "98345"),
                           ("76653", "76766"),
                           ("12345", "11111"),
                           ("45678", "10101"),
                           ("45678", "11111");

-- a
select student.name
from advisor, student
where student.ID = advisor.s_ID
group by advisor.s_ID
having count(advisor.i_ID) > 3;

-- b
select distinct student.name
from student, advisor as A1
where student.ID = A1.s_ID and
      exists (select A2.s_ID
             from advisor as A2
             where A2.i_ID = (select ID from instructor where name = "Srinivasan") and
             A1.s_ID = A2.s_ID) and
      exists (select A3.s_ID
             from advisor as A3
             where A3.i_ID = (select ID from instructor where name = "Ashok") and
             A1.s_ID = A3.s_ID);

-- c
select distinct student.name
from advisor, student, instructor
where (advisor.s_ID, advisor.i_ID) = (student.ID, instructor.ID) and
      student.dept_name != instructor.dept_name;

-- B4
-- a
insert into section
values ("MU-199", "2", "Fall", "2006", "Packard", "101", "F"),
       ("PHY-101", "2", "Summer", "2005", "Watson", "120", "C"),
       ("HIS-351", "2", "Spring", "2007", "Painter", "514", "D");

delete from section
where year < (select year(current_timestamp) - 10);


-- b
-- Get constraint names
select *
from information_schema.table_constraints
where table_name = "prereq" and constraint_schema = "univ";

-- Remove the foreign key constraints for the prerequite course id
alter table prereq
drop constraint prereq_ibfk_2;

-- Add new foreign key constraint with delete on cascade feature
alter table prereq
add foreign key (prereq_id) references course (course_id) on delete cascade;

-- Delete CS-101 course
delete from course
where course_id = "CS-101";
