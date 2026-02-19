-- Hunter Harwood

-- Question 1
SELECT description,
       course_no,
       TO_CHAR(cost, '$9,999') AS cost
FROM course
WHERE cost < (SELECT AVG(cost) FROM course)
ORDER BY cost DESC;

-- Question 2
SELECT c.course_no,
       c.description,
       c.cost,
       s.start_date_time
FROM course c
JOIN section s
     ON c.course_no = s.course_no
ORDER BY c.course_no, c.description;

-- Question 3
SELECT z.zip,
       COUNT(i.instructor_id) AS number_of_instructors
FROM zipcode z
LEFT JOIN instructor i
     ON z.zip = i.zip
GROUP BY z.zip
ORDER BY z.zip;

-- Question 4
SELECT s.student_id,
       s.first_name,
       s.last_name,
       s.street_address,
       z.state,
       z.zip
FROM student s
JOIN zipcode z
     ON s.zip = z.zip
WHERE z.city = 'Brooklyn'
ORDER BY s.last_name, s.first_name;

-- Question 5
SELECT i.first_name,
       i.last_name,
       COUNT(s.section_id) AS number_of_sections
FROM instructor i
LEFT JOIN section s
     ON i.instructor_id = s.instructor_id
GROUP BY i.first_name, i.last_name
ORDER BY number_of_sections DESC;

-- Question 6
SELECT s.first_name,
       s.last_name,
       s.street_address,
       s.zip
FROM student s
WHERE s.zip = (
        SELECT i.zip
        FROM instructor i
        WHERE i.first_name = 'Tom'
          AND i.last_name = 'Wojick'
      );

-- Question 7
SELECT student_id,
       salutation,
       first_name,
       last_name
FROM student
WHERE registration_date < (
        SELECT registration_date
        FROM student
        WHERE first_name = 'Vera'
          AND last_name = 'Wetcel'
      );

-- Question 8
SELECT s.student_id
FROM student s
WHERE NOT EXISTS (
        SELECT 1
        FROM enrollment e
    WHERE e.student_id = s.student_id
      );

-- Question 9
CREATE OR REPLACE VIEW all_people_view AS
SELECT salutation,
       first_name || ' ' || last_name AS full_name,
       street_address,
       zip,
       phone
FROM student
UNION
SELECT salutation,
       first_name || ' ' || last_name AS full_name,
       street_address,
       zip,
       phone
FROM instructor;

-- Question 10
SELECT s.first_name,
       s.last_name,
       s.student_id
FROM student s
JOIN enrollment e
     ON s.student_id = e.student_id
WHERE e.final_grade = (
        SELECT MAX(final_grade)
        FROM enrollment
      );

-- Question 11
SELECT c.course_no,
       c.description,
       COUNT(s.section_id) AS number_of_sections
FROM course c
JOIN section s
     ON c.course_no = s.course_no
GROUP BY c.course_no, c.description
HAVING COUNT(s.section_id) > 5
ORDER BY c.course_no;

-- Question 12
SELECT c.course_no,
       c.description,
       c.cost,
       p.course_no AS prereq_course_no,
       p.description AS prereq_description
FROM course c
LEFT JOIN course p
     ON c.prerequisite = p.course_no
ORDER BY c.course_no;

-- Question 13
SELECT c.course_no,
       c.description,
       COUNT(s.section_id) AS number_of_sections
FROM course c
JOIN section s
     ON c.course_no = s.course_no
GROUP BY c.course_no, c.description
HAVING COUNT(s.section_id) = (
        SELECT MAX(section_count)
        FROM (
              SELECT COUNT(*) AS section_count
              FROM section
              GROUP BY course_no
             )
      )
ORDER BY c.course_no;

-- Question 14
SELECT c.course_no,
       c.description,
       s.start_date_time,
       s.capacity,
       COUNT(e.student_id) AS current_enrollment
FROM course c
JOIN section s
     ON c.course_no = s.course_no
JOIN enrollment e
     ON s.section_id = e.section_id
GROUP BY c.course_no,
         c.description,
         s.start_date_time,
         s.capacity
HAVING COUNT(e.student_id) > s.capacity
ORDER BY c.course_no, s.start_date_time;
