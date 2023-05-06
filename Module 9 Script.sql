-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/oun3bA
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
--

CREATE TABLE employees (
    emp_no int   NOT NULL,
    emp_title_id varchar   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL,
	PRIMARY KEY (emp_no)
);


CREATE TABLE departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    PRIMARY KEY (dept_no)
);

--DROP TABLE "dept_manager";

CREATE TABLE dept_manager (
   dept_no varchar   NOT NULL,
   emp_no int   NOT NULL,
   PRIMARY KEY (dept_no)
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary money   NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    title_id varchar   NOT NULL,
    title varchar   NOT NULL,
    PRIMARY KEY (title_id)
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "dept_manager" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM "employees" ;
 

-- Result_1
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
join salaries as salaries
on salaries.emp_no = employees.emp_no

--Result_2
SELECT employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31'

-- Result_3


-- Result_4
SELECT dept_emp.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from employees
join dept_emp as dept_emp
on dept_emp.emp_no = employees.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no

-- Result_5
SELECT employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and last_name = 'B%'

-- Result_6
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
from dept_emp
join employees as employees
on employees.emp_no = dept_emp.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales'

--Result_7
SELECT dept_emp.dept_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees as employees
on employees.emp_no = dept_emp.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales' or dept_name = 'Development'

--Result_8

--result 8 structure
SELECT country.country, COUNT(country.country) AS "country count"
FROM "employees"
GROUP BY country.country
ORDER BY "country count" DESC;