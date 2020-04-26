

-- TABLE CREATION:

create table Departments(
	Code Integer,
	Name varchar(25) NOT NULL,
	Budget Decimal NOT NULL,
	primary key (Code)
);

create table Employees(
	SSN Integer,
	Name varchar(25) NOT NULL,
	LastName varchar(25) NOT NULL,
	Department Integer NOT NULL,
	primary key (SSN),
	foreign key (Department) references Department(Code)
);

-- inserting values

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


-- 1. Select the last name of all employees. 
		select LastName from Employees;

-- 2. Select the last name of all employees, without duplicates. 
		select distinct(LastName) from Employees;

-- 3. Select all the data of employees whose last name is "Smith". 
		select * from Employees where LastName = "Smith";

-- 4. Select all the data of employees whose last name is "Smith" or "Doe". 
		select * from Employees where LastName = "Smith" or LastName = "Doe";

		select * from Employees where LastName in ("Smith", "Doe");

-- 5. Select all the data of employees that work in department 14. 
		select * from Employees where Department = 14;

-- 6. Select all the data of employees that work in department 37 or department 77. 
		select * from Employees where Department = 37 or Department = 77;

		select * from Employees where Department in (37, 77);

-- 7. Select all the data of employees whose last name begins with an "S". 
		select * from Employees where LastName like "S%";

-- 8. Select the sum of all the departments' budgets.
		select sum(Budget) from Departments;

-- 9. Select the number of employees in each department (you only need to show the department code and the number of employees). 
		select Department, count(SSN) as count
		from Employees
		group by Department;

-- 10. Select all the data of employees, including each employee's department's data. 
		select * 
		from Employees Inner join Departments
		on Employees.Department = Departments.Code;

-- 11. Select the name and last name of each employee, along with the name and budget of the employee's department. 
		select E.Name as Emp_Name, E.LastName, D.Name as Dep_Name, D.Budget
		from Employees E inner join Departments D
		on E.Department = D.Code;

-- 12. Select the name and last name of employees working for departments with a budget greater than $60,000. 
		select Name, LastName 
		from Employees
		where Department in ( select Code from Departments where Budget > 60000);

		select E.Name, E.LastName
		from Employees E inner join Departments D
		where E.Department = D.Code and D.Budget > 60000;

-- 13. Select the departments with a budget larger than the average budget of all the departments. 
		select Name 
		from Departments
		where Budget > (select avg(Budget) from Departments);

-- 14. Select the names of departments with more than two employees.
		select Name 
		from Departments
		where Code in (
				select Department
				from Employees 
				group by Department
				having count(*) > 2
			);

		select D.Name as Dep_Name
		from Departments D Inner Join Employees E
		on D.Code = E.Department
		group by E.Department
		having count(*) > 2;

-- 15. Select the name and last name of employees working for departments with second lowest budget. 
		select E.Name, E.LastName
		from Employees E
		where E.Department = (
				select sub.Code 
				from (select * from Departments order by Budget limit 2 ) sub
				order by sub.Budget DESC limit 1
			);

		select Name, LastName
		from Employees 
		where Department in (
				select Code 
				from Departments
				where Budget = (
						select top 1 Budget
						from Departments
						where Budget in (
							select top 2 Budget
							from Departments
							order by Budget
							)
						order by Budget DESC
					)
			);

-- 16. Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11
--  Add an employee called "Mary Moore" in that department, with SSN 847-21-9811. 
		insert into Departments(Code, Name, Budget) values (11, "Quality Assurance", 40000);
		insert into Employees(SSN, Name, LastName, Department) values ('847219811', "Mary", "Moore", 11);

-- 17. Reduce the budget of all departments by 10%.
		update Departments
			set Budget = Budget - (Budget * 0.1); 

-- 18. Reassign all employees from the Research department (code 77) to the IT department (code 14). 
		update Employees
			set Department = 14
			where Department = 77;

-- 19. Delete from the table all employees in the IT department (code 14). 
		delete from Employees
			where Department = 14;

-- 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000. 
		delete from Employees
			where Department in (
					select Code
					from Departments
					where Budget >= 60000
				);

-- 21. Delete from the table all employees. 
		delete from Employees;