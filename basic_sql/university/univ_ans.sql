-- 1
SELECT name
FROM student
WHERE tot_cred > 100;

-- 2
SELECT course_id, grade
FROM takes, student
WHERE student.name = "Tanaka" AND student.id = takes.id;

-- 3
SELECT DISTINCT instructor.ID, instructor.name
FROM instructor, teaches, course
WHERE course.dept_name = "Comp. Sci." AND
      teaches.course_id = course.course_id AND
      instructor.ID = teaches.ID;

-- 4
SELECT DISTINCT course.title
FROM section, course
WHERE section.semester IN ("Fall", "Spring") AND
      section.course_id = course.course_id;

-- 5
SELECT name
FROM instructor
WHERE dept_name = "Comp. Sci.";

-- 6
SELECT course.course_id, course.title
FROM teaches, instructor, course
WHERE instructor.name = "Srinivasan"
      AND instructor.ID = teaches.ID
      AND teaches.course_id = course.course_id;

-- 7
SELECT DISTINCT instructor.name
FROM instructor, teaches
WHERE teaches.semester = "Spring" AND year = "2009"
      AND teaches.ID = instructor.ID;
