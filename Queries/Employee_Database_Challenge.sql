--Determine the number of retiring employees per title, 
--and identify employees who are eligible to participate 
--in a mentorship program.

--A Retirement Titles table that holds all the titles of current employees 
--who were born between January 1, 1952 and December 31, 1955. 

SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER join titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, title DESC;

---Retrieve number of employees by thier most recent job title who are about to 
--retire
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

---Create a mentorship-eligibility table that holds the current employees 
--who were born between January 1, 1965 and December 31, 1965.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
LEFT OUTER JOIN dept_emp as d 
ON (e.emp_no = d.emp_no)
LEFT OUTER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;