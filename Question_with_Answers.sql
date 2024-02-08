-- 1. From the following table, write a SQL query to find those employees who receive a higher salary than the employee with ID 163. Return first name, last name.
#solution
select first_name,last_name
from employees
where salary > (select salary from employees where employee_id = '163');

-- 2. From the following table, write a SQL query to find out which employees have the same designation as the employee whose ID is 169. Return first name, last name, department ID and job ID.
#Solution 
select first_name,last_name,salary,department_id,job_id
from employees
where job_id in (select job_id from employees where employee_id = '169');

-- 3. From the following table, write a SQL query to find those employees whose salary matches the lowest salary of any of the departments. Return first name, last name and department ID.
#Solution
select first_name,last_name,department_id
from employees 
where salary in (select min(salary) 
				  from employees 
				   group by department_id);


-- 4. From the following table, write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name.
#Solution
select employee_id,first_name,last_name,salary
from employees
where salary > (select avg(salary)from employees);


-- 5. From the following table, write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.
#Solution

select first_name,last_name,employee_id,salary
from employees
where manager_id in (select employee_id from employees where first_name = 'Payam');


-- 6. From the following tables, write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.
select department_id,first_name,job_id,d.department_name
from employees
join departments d using(department_id)
where department_name = 'Finance';

-- 7.From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fieds.
#Solution
select *
from employees 
where salary = 3000 and manager_id = 121;

#Alternative Solution
select * 
from employees
where (salary,manager_id)=(select 3000,121);


-- 8.  From the following table, write a SQL query to find those employees whose ID matches any of the numbers 134, 159 and 183. Return all the fields. 
#Solution
select *
from employees
where employee_id in (134,159,183);


-- 9. From the following table, write a SQL query to find those employees whose salary is in the range of 1000, and 3000 (Begin and end values have included.). Return all the fields.
#Solution

select *
from employees
where salary between 1000 and 3000;

-- 10. From the following table and write a SQL query to find those employees whose salary falls within the range of the smallest salary and 2500. Return all the fields.
#Solution 

select *
from employees
where salary between (select min(salary) from employees) and 2500;


-- 11. From the following tables, write a SQL query to find those employees who do not work in the departments where managers’ IDs are between 100 and 200 (Begin and end values are included.). Return all the fields of the employeess.

#Solution
select * 
from employees
where department_id not in (select department_id from departments where manager_id between 100 and 200);

-- 12. From the following table, write a SQL query to find those employees who get second-highest salary.Return all the fields of the employees.
#Solution
with cte as (select *,dense_rank() over(order by salary desc) as rnk
from employees)
select *
from cte
where rnk = 2;

#Alternative Solution
select *
from employees
where salary = 
     (SELECT MAX(salary) 
      FROM employees 
      WHERE salary < 
        (SELECT MAX(salary) FROM employees)
     )
;
-- 13 -- From the following tables, write a SQL query to find those employees who work in the same department as ‘Clara’. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.
#Solution

select first_name,last_name,hire_date
from employees
where department_id = (select department_id from employees where first_name = 'Clara') and first_name <> 'Clara';

-- 14 --  From the following tables, write a SQL query to find those employees who work in a department where the employee’s first name contains the letter 'T'. Return employee ID, first name and last name.
#Solution
select employee_id,first_name, last_name
from employees
where department_id in (select department_id from employees where first_name like '%T%');

-- 15 -- From the following tables, write a SQL query to find those employees who earn more than the average salary and work in the same department as an employee whose first name contains the letter 'J'. Return employee ID, first name and salary
#Solution

select employee_id,first_name,salary
from employees
where salary > (select avg(salary)from employees) 
and 
department_id in (select department_id from employees where first_name like '%J%');

-- 16.From the following table, write a SQL query to find those employees whose department is located at ‘Toronto’. Return first name, last name, employee ID, job ID.


select first_name,last_name,employee_id,job_id
from employees
where department_id in (select department_id from departments join locations using(location_id)
						where locations.city = 'Toronto');
                        
                        
-- 17.From the following table, write a SQL query to find those employees whose salary is lower than that of employees whosejob title is ‘MK_MAN’. Return employee ID, first name, last name, job ID.


select employee_id,first_name,last_name,job_id
from employees
where salary < (select salary from employees where job_id = 'MK_MAN');

-- 18 --  From the following table, write a SQL query to find those employees whose salary is lower than that of employees whose job title is "MK_MAN".Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name, last name, job ID.


select employee_id,first_name,last_name,job_id
from employees
where salary < (select salary from employees where job_id = 'MK_MAN')
and job_id <> 'MK_MAN';



-- 19 -- From the following table, write a SQL query to find those employees whose salary exceeds the salary of all those employees whose job titleis "PU_MAN". Exclude job title ‘PU_MAN’. Return employee ID, first name, last name, job ID.


select employee_id,first_name,last_name,job_id
from employees
where salary > (select salary from employees where job_id = 'PU_MAN')
and job_id <> 'PU_MAN';



-- 20 -- From the following table, write a SQL query to find those employees whose salaries are higher than the average for all departments.Return employee ID, first name, last name, job ID.

select employee_id,first_name,last_name,job_id
from employees
where salary > All (select Avg(salary) 
				from employees 
                group by department_id);


-- 21 -- From the following table, write a SQL query to check whether there are any employees with salaries exceeding 3700.Return first name, last name and department ID.

select employee_id,first_name,last_name,department_id
from employees
where salary > '3700';


-- 22. -- From the following table, write a SQL query to calculate total salary of the departments where at least one employee works.  Return department ID, total salary.


SELECT d.department_id,
       SUM(e.salary) total_amt
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id
HAVING SUM(e.salary) > 0;


-- 23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.


select employee_id,first_name,last_name, 
case when job_id = 'ST_MAN' then 'Salesman'
when job_id = 'IT_PROG' then 'Developer'
else job_id
end
from employees 

-- 24 -- Write a query to display the employee id, name ( first name and last name ), 
salary and the SalaryStatus column with a title HIGH and LOW respectively for 
those employees whose salary is more than and less than the average salary of all employees.

select employee_id,first_name,last_name,salary,
case WHEN salary >= (SELECT AVG(salary) FROM employees) THEN 'HIGH'  
       ELSE 'LOW' 
end as SalaryStatus
from employees;

-- 25. Write a query to display the employee id, name ( first name and last name ),SalaryDrawn, AvgCompare (salary - the average salary of all employees) andthe SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select employee_id,first_name,last_name,salary as Salarydrawn,
case WHEN salary >= (SELECT AVG(salary) FROM employees) THEN 'HIGH'  
       ELSE 'LOW' 
end as SalaryStatus,
abs(salary-(select avg(salary) from employees))as AvgCompare
from employees;

-- 26-- From the following table, write a SQL query to find all those departments where at least one employee is employed. Return department name.

select department_name
from departments 
where department_id in (select distinct department_id from employees);

-- 27 -- From the following tables, write a SQL query to find employees who work in departments located in the United Kingdom. Return first name.

select first_name,last_name
from employees
join  departments using(department_id)
join locations on locations.location_id = departments.location_id
where country_id  = (select country_id from countries where country_name = 'United Kingdom');

-- 28 -- From the following table, write a SQL query to find out which employees are earning more than the average salary andwho work in any of the IT departments. Return last name.
 
 select last_name
 from employees
 where salary > (select avg(salary) from employees) 
 and 
 department_id = (select department_id from departments where department_name = 'IT');

-- 29 -- From the following table, write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. Sort the result in ascending order by last name. Return first name, last name and salary.


select first_name,last_name,salary
from employees
where salary > (select salary from employees where last_name = 'Ozer')
order by last_name;


-- 30 From the following tables, write a SQL query find the employees who report to a manager based in the United States. Return first name, last name.

select first_name,last_name
from employees
where manager_id in (select manager_id from departments where location_id 
						=(select location_id from countries where country_id = 'US'));
                        
-- 31 From the following tables, write a SQL query to find those employees whose salaries exceed 50% of their department's total salary bill'. Return first name, last name.

select e1.first_name,e1.last_name
from employees e1
where salary > (select sum(salary)*0.5 from employees e2 where e1.department_id = e2.department_id);


-- 32. From the following tables, write a SQL query to find those employees who are managers. Return all the fields of employees table

select *
from employees 
where employee_id in (select distinct manager_id from employees);


-- 33 From the following table, write a SQL query to find those employees who manage a department. Return all the fields of employees table

select *
from employees 
where employee_id in (select manager_id from departments);

-- 34 From the following table, write a SQL query to search for employees who receive such a salary, which is the maximum salary for salaried employees, hired between January 1st, 2002 and December 31st, 2003. Return employee ID, first name, last name, salary, department name and city


select employee_id,first_name,last_name,d.department_name,l.city
from employees
join departments d using (department_id)
join locations l on d.location_id = l.location_id
where salary = (select max(salary) from employees where hire_date between '2002-01-01' and '2003-12-31');


-- 35--From the following tables, write a SQL query to find those departments that are located in the city of London. Return department ID, department name.

select department_id,department_name
from departments
where location_id = (select location_id from locations where city = 'London');


-- 36 From the following table, write a SQL query to find 
those employees who earn more than the average salary. 
Sort the result-set in descending order by salary. Return first name, last name, salary, and department ID

select first_name,last_name,salary,department_id
from employees
where salary > (select avg(salary) from employees)
order by salary desc;

-- 37 -- From the following table, write a SQL query to find those employees who earn more than the maximum salary for a department of ID 40. Return first name, last name and department ID.


select first_name,last_name,salary,department_id
from employees
where salary > (select max(salary) from employees where department_id = '40');

-- 38 -- From the following table, write a SQL query to find departments for a particular location. The location matches the location of the department of ID 30. Return department name and department ID.

select department_id,department_name
from departments
where location_id = (select location_id from departments where department_id = '30');

-- 39 -- From the following table, write a SQL query to find employees who work for the department in which employee ID 201 is employed. Return first name, last name, salary, and department ID.

select first_name,last_name,salary,department_id
from employees
where department_id = (select department_id from employees where employee_id = 201);


-- 40 -- From the following table, write a SQL query to find those employees whose salary matches that of the employee who works in department ID 40. Return first name, last name, salary, and department ID.

select first_name,last_name,salary,department_id
from employees
where salary = (select salary from employees where department_id = '40');


-- 41 --From the following table, write a SQL query to find those employees who work in the department 'Marketing'. Return first name, last name and department ID.

select first_name,last_name,department_id
from employees
where department_id = (select department_id from departments where department_name = 'Marketing');


-- 42 -- From the following table, write a SQL query to find those employees who earn more than the minimum salary of a department of ID 40.Return first name, last name, salary, and department ID.

select first_name,last_name,salary,department_id
from employees
where salary > (select min(salary) from employees where department_id = '40');


-- 43 -- From the following table, write a SQL query to find those employees who joined afterthe employee whose ID is 165. Return first name, last name and hire date

select concat(first_name,' ', last_name), hire_date
from employees
where hire_date  > (select hire_date from employees where employee_id = '165');


-- 44 From the following table, write a SQL query to find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.

select first_name,last_name,salary,department_id
from employees
where salary < (select min(salary) from employees where department_id = '70');


-- 45 -From the following table, write a SQL query to find those employees who earn less than the average salary and work at the department where Laura (first name) is employed. Return first name, last name, salary, and department ID

select first_name,last_name,salary,department_id
from employees
where salary < (select Avg(salary) from employees)
and department_id = (select department_id from employees where first_name = 'Laura');


-- 46 From the following tables, write a SQL query to find all employees whose department is located in London.Return first name, last name, salary, and department ID.

select first_name,last_name,salary,department_id
from employees
join departments using (department_id)
where location_id = (select location_id from locations where city = 'London');


-- 47 --From the following tables, write a SQL query to find the city of the employee of ID 134. Return city.

select city 
from locations
join departments using (location_id)
join employees using (department_id)
where employee_id = 134;

-- 48 -- From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. Return all the fields of the departments


SELECT *
FROM departments
WHERE DEPARTMENT_ID IN
    (SELECT DEPARTMENT_ID
     FROM employees
     WHERE EMPLOYEE_ID IN
         (SELECT EMPLOYEE_ID
          FROM job_history
          GROUP BY EMPLOYEE_ID
          HAVING COUNT(EMPLOYEE_ID) > 1)
     GROUP BY DEPARTMENT_ID
     HAVING MAX(SALARY) > 7000);


-- 49 --From the following tables, write a SQL query to find those departments where the starting salary is at least 8000. Return all the fields of departments

select *
from departments 
where department_id in (select department_id from employees group by department_id having min(salary) >=8000);

-- 50 -- From the following table, write a SQL query to find those managers who supervise four or more employees. Return manager name, department ID.

select first_name,last_name,department_id
from employees
where employee_id in (select manager_id from employees group by manager_id having count(*)>=4);


-- 51 -- From the following table, write a SQL query to find employees who have previously worked as 'Sales Representatives'. Return all the fields of jobs.

select *
from jobs
where job_id in (select job_id from employees
					where employee_id in (select employee_id from job_history
                    where job_id = 'SA_REP')
                    
                    );


-- 52 -- From the following table, write a SQL query to find those employees who earn the second-lowest salary of all the employees. Return all the fields of employees.

select *
from employees
where salary = 
     (SELECT min(salary) 
      FROM employees 
      WHERE salary < 
        (SELECT min(salary) FROM employees)
     )
;

-- 53 -- From the following table, write a SQL query to find the departments managed by Susan. Return all the fields of departments.

select * 
from departments
where department_id in (select department_id 
						from employees 
                        where first_name = 'Susan');

-- 54 - From the following table, write a SQL query to find those employees who earn the highest salary in a department. Return department ID, employee name, and salary

select department_id,concat(first_name,' ', last_name) as employee_name,salary
from employees a
where salary = (select max(salary) from employees where department_id = a.department_id);


-- 55 From the following table, write a SQL query to find those employees who have not had a job in the past. Return all the fields of employees

SELECT * 
FROM employees 
WHERE employee_id NOT IN 
       (SELECT employee_id 
		FROM job_history);







