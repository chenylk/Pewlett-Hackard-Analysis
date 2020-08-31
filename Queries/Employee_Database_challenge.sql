--creating retirement table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_table
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;

select * from salaries;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_table
ORDER BY emp_no ASC, to_date DESC;

--retrieve the number of titles from the unique titles table
SELECT COUNT(title),
title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--retriving all employees that have mentorship eligibility 
SELECT DISTINCT ON (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;

SELECT COUNT(emp_no)
FROM mentorship_eligibility;

SELECT COUNT(emp_no)
FROM unique_titles;

SELECT SUM(s.salary),
	ut.title
FROM unique_titles as ut
LEFT JOIN salaries as s
ON (ut.emp_no = s.emp_no)
GROUP BY ut.title;

SELECT COUNT(ut.emp_no),
	d.dept_name
FROM unique_titles as ut
LEFT JOIN dept_emp as de
ON (ut.emp_no = de.emp_no)
LEFT JOIN departments as d
ON (de.dept_no = d.dept_no)
GROUP BY d.dept_name; 


