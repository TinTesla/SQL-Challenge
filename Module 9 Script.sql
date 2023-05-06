--Employees Table
create table employees (
    emp_no int   not null,
    emp_title_id varchar   not null,
    birth_date date   not null,
    first_name varchar   not null,
    last_name varchar   not null,
    sex varchar   not null,
    hire_date date   not null,
	primary key (emp_no)
);

--Dept_emp Table
create table dept_emp (
    emp_no int   not null,
    dept_no varchar   not null,
	primary key (emp_no)
);

--Department Table
create table departments (
    dept_no varchar   not null,
    dept_name varchar   not null,
    primary key (dept_no)
);

--Dept_manager Table
create table dept_manager (
   dept_no varchar   not null,
   emp_no int   not null,
   primary key (dept_no)
);

--Salaries Table
create table salaries (
    emp_no int   not null,
    salary money   not null,
    primary key (emp_no)
);

--Titles Table
create table titles (
    title_id varchar   not null,
    title varchar   not null,
    primary key (title_id)
);

--Employees Constraint
alter table "employees" add constraint "fk_employees_emp_title_id" foreign key("emp_title_id")
references "titles" ("title_id");

--Dept_emp Constraint 1
alter table "dept_emp" add constraint "fk_dept_emp_emp_no" foreign key("emp_no")
references "employees" ("emp_no");

--Dept_emp Constraint 2
alter table "dept_emp" add constraint "fk_dept_emp_dept_no" foreign key("dept_no")
references "departments" ("dept_no");

--Department Constraint
alter table "departments" add constraint "fk_departments_dept_no" foreign key("dept_no")
references "dept_manager" ("dept_no");

--Salaries Constraint
alter table "salaries" add constraint "fk_salaries_emp_no" foreign key("emp_no")
references "employees" ("emp_no");

--Build Check
select * from "employees" ;
 

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
SELECT dept_manager.dept_no, dept_manager.emp_no, departments.dept_name, employees.last_name, employees.first_name
from dept_manager
join employees as employees
on employees.emp_no = dept_manager.emp_no
join departments as departments
on departments.dept_no = dept_manager.dept_no

-- Result_4
select dept_emp.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from employees
join dept_emp as dept_emp
on dept_emp.emp_no = employees.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no

-- Result_5
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and last_name = 'B%'

-- Result_6
select dept_emp.emp_no, employees.last_name, employees.first_name
from dept_emp
join employees as employees
on employees.emp_no = dept_emp.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales'

--Result_7
select dept_emp.dept_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees as employees
on employees.emp_no = dept_emp.emp_no
join departments as departments
on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales' or dept_name = 'Development'

--Result_8
select employees.last_name, COUNT(employees.last_name) as "last name frequency"
from "employees"
group by employees.last_name
order by "last name frequency" desc;