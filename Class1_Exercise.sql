-- Q1
show tables;

-- Q2
select first_name, last_name, gender
from employees;

-- Q3
select title 
from titles; 

-- Q4
select distinct(title)
from titles;

-- Q5
select count(*)
from employees;

-- Q6
select count(*) 
from salaries;

-- Q7 How many departments are there 
select count(distinct(dept_no))
from departments;

-- Q8 What are the names of these departments?
select dept_name
from departments;

-- Q9 Find the names of all female employees.
SELECT first_name, last_name
FROM employees
WHERE gender = "F";

-- Q10	How many male employees are there?
SELECT COUNT(*) AS MaleCount
FROM employees
WHERE gender = "M";

-- Q11	Find all employees who were hired before the year 1990.
SELECT *
FROM employees
WHERE hire_date < "1990-01-01";

-- Q12.	Find male employees who were hired after 1995;
SELECT *
FROM employees
WHERE gender = "M" and hire_date > "1995-01-01";

-- 13. How many employees have their first names as either Adin, Deniz, Youssef and Roded?
SELECT count(*)
FROM employees
WHERE first_name IN ("Adin", "Deniz", "Youssef", "Roded");

-- 14.	How many employees are:
-- a.	engineers?
select count(*)
from titles
where title like "%Engineer";

-- b.	non-engineers?
select count(*)
from titles
where title not like "%Engineer";

-- 15.	How many employees were hired between 1990/01/01 and 1994/01/01.
select count(distinct(emp_no))
from employees 
where hire_date >= "1990-01-01" AND hire_date <= "1994-01-01"; 

-- 16.	Find the list of unique last names of female employees (in alphabetical order), 
-- who were born before the year 1970, and hired after 1996. 
select distinct(last_name) 
from employees
where gender = "F" AND birth_date < "1970-01-01" AND hire_date > "1996-12-31"
order by last_name ASC;

-- 17.	For each gender, how many employees were hired before 1989;
select gender, count(distinct(emp_no))
from employees
where hire_date < "1989-01-01"
group by gender;

-- 18.	For each gender:
-- a.	how many employees are in each department?
select gender,dept_name, count(distinct employees.emp_no)
from dept_emp, departments, employees
where dept_emp.dept_no = departments.dept_no AND dept_emp.emp_no = employees.emp_no
group by gender, dept_emp.dept_no
order by gender;

-- b.	hired between the years of 1994-1996?
select gender, count(distinct employees.emp_no)
from employees
where hire_date >=  "1994-01-01" AND hire_date < "1997-01-01"
group by gender;

-- 19.	List the names of all employees with department managers appointed starting from 1992/09/08 and ending at 1996/01/03.
    select first_name, last_name
    from employees
    where emp_no IN
    (
          select distinct emp_no
          from dept_emp
          where dept_no IN
          (
                select dept_no
                from dept_manager
                where from_date = "1992/09/08" AND to_date = "1996/01/03"
) );

-- 20.	List the names of employees and their respective job titles.
select first_name, last_name, title
from employees, titles
where employees.emp_no = titles.emp_no;

-- 21.	Find the average salary of every department.
select dept_no, avg(salary) 
from dept_emp, salaries
where dept_emp.emp_no = salaries.emp_no
group by dept_no;

-- 22.	Find the average salary of every department and the number of employees.
select dept_no, count(distinct(dept_emp.emp_no)), avg(salary)
from dept_emp, salaries
where dept_emp.emp_no = salaries.emp_no
group by dept_no;

-- 23.	Number of employees in every department who make more than $130000.
select dept_no, count(distinct(dept_emp.emp_no))
from dept_emp, salaries
where salary > 130000 AND dept_emp.emp_no = salaries.emp_no
group by dept_no;