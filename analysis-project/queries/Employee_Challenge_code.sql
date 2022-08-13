--determine # of retiring employees by title

SELECT e.emp_no
	, e.first_name
	, e.last_name
	, ti.title
	, ti.from_date
	, ti.to_date
--INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, from_date DESC;


-- retreive # employees by most recent title, about to retire.
select count(emp_no) AS "count"
	, title
INTO retiring_titles
from titles
GROUP BY title
ORDER BY "count" DESC

--identify employees who are eligible for mentorship program

--create a mentorship-eligibility table that holds the 
--current employees who were born between January 1, 1965 and December 31, 1965.

SELECT DISTINCT ON (e.emp_no) e.emp_no
	, e.first_name
	, e.last_name
	, e.birth_date
	, de.from_date
	, de.to_date
	, ti.title
INTO mentorship_eligiblity
FROM employees AS e
INNER JOIN dept_emp AS de ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND  de.to_date = '9999-01-01'
ORDER BY e.emp_no







