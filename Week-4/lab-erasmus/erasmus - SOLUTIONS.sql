use erasmus;

-- 01. What is the average age of students who have outstanding grades? Provide the table with:
-- EXCELLENT if they have a 9 or 10, 
-- GOOD if they have 7 or 8, 
-- PASS if they have a 5 or 6 
-- and FAIL if it is less than 5.
SELECT 
    CASE
        WHEN g.grades >= 9 THEN 'EXCELLENT'
        WHEN g.grades >= 7 AND g.grades <= 8 THEN 'GOOD'
        WHEN g.grades >= 5 AND g.grades <= 6 THEN 'PASS'
        ELSE 'FAIL'
    END AS Grade_Category,
    ROUND(AVG(YEAR(NOW()) - YEAR(s.dob))) AS Average_Age
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY Grade_Category
ORDER BY Average_Age;


-- 02. What is the average age of students by university?
SELECT
    u.uni_name AS university_name,
    ROUND(AVG(YEAR(NOW()) - YEAR(s.dob))) AS average_age
FROM
    university u
JOIN
    campus c ON u.university_id = c.university_id
JOIN
    students s ON c.city = s.city
GROUP BY
    u.uni_name
ORDER BY
    average_age DESC;


-- 03. What is the proportion of students who failed each subject? 
-- Provide the subject name, number of students who failed, total number of students, 
-- and the proportion of students who failed (as a percentage) for each subject. 
-- Display the results in descending order of the proportion of students who failed.
SELECT
    s.subj_name AS Subject_Name,
    COUNT(CASE WHEN avg_grades < 5.00 THEN 1 END) AS Number_of_Failures,
    COUNT(DISTINCT g.student_id) AS Number_of_Students,
    CONCAT(ROUND(COUNT(CASE WHEN avg_grades < 5.00 THEN 1 END) / COUNT(DISTINCT g.student_id) * 100, 2), '%') AS Proportion_of_Failures
FROM
    subjects s
LEFT JOIN (
    SELECT
        student_id,
        subject_id,
        AVG(grades) AS avg_grades
    FROM
        grades
    GROUP BY
        student_id, subject_id
) g ON s.subject_id = g.subject_id
GROUP BY
    s.subj_name
ORDER BY
    Proportion_of_Failures DESC;


-- 04. What is the average grade of students who have done an erasmus compared to those who have not?
SELECT
    CASE
        WHEN ia.agreement_code IS NOT NULL THEN 'w_erasmus'
        ELSE 'wo_erasmus'
    END AS Erasmus_Status,
    AVG(g.grades) AS AVG_Grade
FROM
    students s
LEFT JOIN
    international_agreement ia ON s.student_id = ia.student_id
LEFT JOIN
    grades g ON s.student_id = g.student_id
GROUP BY
    Erasmus_Status;


-- 05. For each university, identify the number of bachelor's, master's and PhD degrees awarded. 
-- Provide the university ID and name along with the count for each type of degree.
SELECT 
    b.university_id as university_id,
    u.uni_name as uni_name,
    SUM(CASE WHEN LEFT(bachelor_id, 1) = 'B' THEN 1 ELSE 0 END) AS Bachelor_Count,
    SUM(CASE WHEN LEFT(bachelor_id, 1) = 'M' THEN 1 ELSE 0 END) AS Master_Count,
    SUM(CASE WHEN LEFT(bachelor_id, 1) = 'D' THEN 1 ELSE 0 END) AS Phd_Count
FROM bachelor b
JOIN university u ON b.university_id = u.university_id
GROUP BY university_id;


-- 06. Which are the top 5 universities with the highest average ranking over the years?
-- Provide the University ID, University Name, and Average Ranking.
SELECT 
    u.university_id AS University_ID,
    u.uni_name AS University_Name, 
    ROUND(AVG(r.intl_ranking), 0) AS Average_Ranking
FROM university u
INNER JOIN ranking r ON u.university_id = r.university_id
GROUP BY University_ID
ORDER BY Average_Ranking DESC
LIMIT 5;


-- 07. Provide de id, the name, the last name, the name of the home university and the email 
-- of the 10 students that have been on an international agreement more times.
SELECT 
    s.student_id,
    s.f_name,
    s.l_name,
    u.uni_name AS Home_University,
    s.email,
    COUNT(ia.student_id) AS Agreement_Count
FROM international_agreement ia
INNER JOIN students s ON ia.student_id = s.student_id
LEFT JOIN university u ON ia.home_university = u.university_id
GROUP BY s.student_id, s.f_name, s.l_name, u.uni_name, s.email
ORDER BY Agreement_Count DESC
LIMIT 10;

-- 08. Make a query where, by modifying the international_agreement number, you can identify 
-- the id and name of the student who did the exchange, the name of the home university and the name 
-- of the city where the exchange took place.
SELECT 
    ia.agreement_code,
    s.student_id,
    s.f_name AS Student_First_Name,
    s.l_name AS Student_Last_Name,
    u_home.uni_name AS Home_University,
    u_away.uni_name AS Away_University
FROM international_agreement ia
INNER JOIN students s ON ia.student_id = s.student_id
LEFT JOIN university u_home ON ia.home_university = u_home.university_id
LEFT JOIN university u_away ON ia.away_university = u_away.university_id
WHERE ia.agreement_code = '9OP82'; -- nº of agreement


-- 09. Find and display the number of universities offering each subject, 
-- along with the average grade for each subject
SELECT
    s.subj_name AS 'Subject',
    ROUND(AVG(g.grades)) AS Average_Grade,
	COUNT(DISTINCT us.university_id) AS Num_Universidades
FROM
    subjects s
LEFT JOIN
    grades g ON s.subject_id = g.subject_id
JOIN
	uni_subj us ON s.subject_id = us.subject_id
GROUP BY
    s.subj_name;
    

-- 10. Find the top 5 cities with the highest percentage of students who have outstanding grades (9 or 10). 
-- Provide the city, state and the percentage of outstanding students for each city.
SELECT
    c.city AS City,
    c.state AS State,
    ROUND(SUM(CASE WHEN g.grades >= 9 THEN 1 ELSE 0 END) / COUNT(s.student_id) * 100, 2) AS Percentage_Outstanding
FROM
    campus c
JOIN
    students s ON c.city = s.city
LEFT JOIN
    grades g ON s.student_id = g.student_id
GROUP BY
    c.city, c.state
ORDER BY
    Percentage_Outstanding DESC
    limit 5; 
    

-- 11. Compare the universities that send the most students with the universities that receive the most students.
SELECT u.uni_name AS uni_name, COUNT(ia.student_id) AS sent_students
FROM university u
LEFT JOIN international_agreement ia ON u.university_id = ia.home_university
GROUP BY u.uni_name
ORDER BY sent_students DESC
LIMIT 5;

SELECT u.uni_name AS uni_name, COUNT(ia.student_id) AS received_students
FROM university u
LEFT JOIN international_agreement ia ON u.university_id = ia.away_university
GROUP BY u.uni_name
ORDER BY received_students DESC
LIMIT 5;


		-- **BONUS**
SELECT uni_name, sent_students, NULL as received_students
FROM (
    SELECT u.uni_name AS uni_name, COUNT(ia.student_id) AS sent_students
    FROM university u
    LEFT JOIN international_agreement ia ON u.university_id = ia.home_university
    GROUP BY u.uni_name
    ORDER BY sent_students DESC
    LIMIT 5
) AS sent_query

UNION ALL

SELECT uni_name, NULL as sent_students, received_students
FROM (
    SELECT u.uni_name AS uni_name, COUNT(ia.student_id) AS received_students
    FROM university u
    LEFT JOIN international_agreement ia ON u.university_id = ia.away_university
    GROUP BY u.uni_name
    ORDER BY received_students DESC
    LIMIT 5
) AS received_query;


-- 12.Create a CTE that lists all students who have not signed any international agreements. 
-- Include the columns student_id, f_name, and l_name. Then, write a query to select all the rows from the CTE.
WITH StudentsWithoutAgreements AS (
    SELECT s.student_id, s.f_name, s.l_name
    FROM students s
    LEFT JOIN international_agreement ia ON s.student_id = ia.student_id
    WHERE ia.student_id IS NULL
)
SELECT * FROM StudentsWithoutAgreements;


-- 13. Write a SQL query to rank universities based on their international ranking for the year 2022 in descending order. 
-- Include the following columns in the result: uni_name, intl_ranking, and the rank assigned using the window function.
SELECT
    u.uni_name,
    r.intl_ranking,
    ROW_NUMBER() OVER (ORDER BY r.intl_ranking DESC) AS ranking
FROM university u
JOIN ranking r ON u.university_id = r.university_id
WHERE r.year_ranking = 2022
ORDER BY ranking;


-- 14. Write a query to find the students who have the highest and lowest grades for each subject. 
-- Include the columns subject_id, subj_name, student_id, f_name, l_name, and grades. 
-- Use window functions to rank the students within each subject based on their grades.
WITH RankedStudents AS (
    SELECT
        s.subject_id,
        s.subj_name,
        g.student_id,
        st.f_name,
        st.l_name,
        g.grades,
        ROW_NUMBER() OVER (PARTITION BY s.subject_id ORDER BY g.grades DESC) AS rank_highest,
        ROW_NUMBER() OVER (PARTITION BY s.subject_id ORDER BY g.grades ASC) AS rank_lowest
    FROM subjects s
    JOIN grades g ON s.subject_id = g.subject_id
    JOIN students st ON g.student_id = st.student_id
)
SELECT subject_id, subj_name, student_id, f_name, l_name, grades
FROM RankedStudents
WHERE rank_highest = 1 OR rank_lowest = 1
ORDER BY subject_id, rank_highest;

-- 15.Create a CTE that calculates the total number of subjects offered by each university. 
-- Include the columns uni_name and total_subjects. Then, write a query to select all the rows from the CTE in descending order of total subjects.
WITH UniversitySubjectCounts AS (
    SELECT
        u.uni_name,
        COUNT(DISTINCT us.subject_id) AS total_subjects
    FROM university u
    LEFT JOIN uni_subj us ON u.university_id = us.university_id
    GROUP BY u.uni_name
)
SELECT uni_name, total_subjects
FROM UniversitySubjectCounts
ORDER BY total_subjects DESC;
