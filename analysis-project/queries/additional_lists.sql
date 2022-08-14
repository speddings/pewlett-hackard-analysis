

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
SELECT * FROM retirement_info;



-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;



-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Current Employees based on dept to_date
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');



-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- list employee info (employee number, their last name, first name, gender, and salary)
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')


-- list of management (department number, name, and the manager's employee number, last name, first name, and the starting and ending employment dates)
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);


-- Department Retiree list (current_emp tbl, but also the employee's departments)
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d ON (de.dept_no = d.dept_no);
	
	
-- sales team list with retirement_info tbl
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	dept_name
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales';


-- sales & dev teams list with retirement_info tbl
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	dept_name
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE dept_name in ('Sales', 'Development');





--mentorship eligible, by title
--mentorship-eligible-by-title.png
SELECT COUNT(title), title
FROM mentorship_eligiblity
GROUP BY title
ORDER BY COUNT(title) DESC;


--eliglble current employees, eligible by dept
--eligible-by-dept.png
select count (r.emp_no) as "count"
	, d.dept_name
FROM retirement_info AS r
INNER JOIN dept_emp AS de ON (r.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (r.emp_no = ti.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE  ti.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY "count" DESC;



--eligible current employees, including personal, dept, and title 
SELECT r.emp_no
	, r.first_name
	, r.last_name
	, e.birth_date
	, e.gender
	, e.hire_date
	, d.dept_name
	, de.from_date
	, de.to_date
	, ti.from_date
	, ti.to_date
FROM retirement_info AS r
INNER JOIN employees AS e ON (r.emp_no = e.emp_no)
INNER JOIN dept_emp AS de ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (e.emp_no = ti.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE  ti.to_date = '9999-01-01';



--current eligible employees, by dept & title
--eligible-by-dept-title.png
SELECT d.dept_name
	, ti.title
	, count (r.emp_no) as "count"
FROM retirement_info AS r
INNER JOIN dept_emp AS de ON (r.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (r.emp_no = ti.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE  ti.to_date = '9999-01-01'
GROUP BY d.dept_name, ti.title
ORDER BY d.dept_name, ti.title, "count" DESC;


--current eligible management, by dept & title
--eligible-mgmt-by-dept-title.png
SELECT d.dept_name
	, ti.title
	, count (r.emp_no) as "count"
FROM retirement_info AS r
INNER JOIN dept_emp AS de ON (r.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (r.emp_no = ti.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE  ti.to_date = '9999-01-01'
AND ti.title in ('Manager', 'Senior Staff', 'Technique Leader', 'Senior Engineer')
GROUP BY d.dept_name, ti.title
ORDER BY d.dept_name, ti.title, "count" DESC;