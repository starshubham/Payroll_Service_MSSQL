--UC1 : Ability to create payroll service database
create database payroll_services;
use payroll_services;    --go to the database created by using use payroll_service query

exec sp_databases;   --Show all existing databases in short

select * 
from sys.databases;   --Show all the existing databases in detailed


---UC2 : Ability create a employee payroll table in the payroll service database
CREATE TABLE employee_payroll 
(
   id int identity primary key,
   name varchar(Max) Not null,
   salary money default 1000,
   startDate DateTime default GetDate()
);

--Drop Table employee_payroll; --Drop is used to Delete DB or Table
-- Note:- SQL Queries is case insensitive


--UC3 : Ability to create employee payroll data service database
INSERT INTO employee_payroll (name,salary,startDate) VALUES
('Bill', 100000.00, '2018-01-03'),
('Terisa', 200000.00, '2019-11-13'),
('Charlie', 300000.00, '2020-05-21');
Insert into employee_payroll (name,salary,startDate) values('Arjun',5545,GETDATE()),
('Madan',54545,GETDATE());

--Delete
--from employee_payroll
--Where id=3               # It is used to delete a particular row by using id or name etc..


--UC4 : Ability to retrieve all the employee payroll data 
select * 
from employee_payroll;     --Retrieving Records from Table


--UC5 : Ability to retrieve salary data for a particular
--      employee as well as all employees who have
--      joined in a particular data range from the
--      payroll service database
--Use SELECT salary FROM employee_payroll WHERE name = 'Bill’ Query to View Bill’s salary.
select salary from employee_payroll
where name = 'Bill';                 --where condition use to get only salary of Bill

select *  from employee_payroll
where name = 'Bill';                 --where condition use to get all details of Bill

--Use Select query with Where condition View employees between start date and now date.
select * from employee_payroll
where startDate BETWEEN CAST('2018-01-01' as DATE) AND GETDATE();


--UC6 : Ability to add Gender to Employee
--Payroll Table and Update the Rows to
--reflect the correct Employee Gender
--UC6.1:- Use Alter Table Command to add Field gender after the name field
Alter Table employee_payroll add Gender varchar(1);
select *  from employee_payroll      --Retrieving Records from Table
SELECT TOP 5 * FROM [INFORMATION_SCHEMA].[COLUMNS] WHERE TABLE_NAME='employee_payroll'; --- show table information

-- UC6.2:- Use Update Query to set the gender using where condition with the employee name.
UPDATE employee_payroll set Gender = 'F' where name = 'Terisa';   --updating Gender of employees
UPDATE employee_payroll set Gender = 'M' where name = 'Bill' or name = 'Charlie' or name = 'Arjun' or name = 'Madan';
UPDATE employee_payroll set salary = 300000.00 where name = 'Terisa'
UPDATE employee_payroll set salary = 500000.00 where name = 'Arjun'
UPDATE employee_payroll set salary = 400000.00 where name = 'Madan'   --updating salary of employees


--UC7 : Ability to find sum, average, min, max
--and number of male and female employees
--UC7.1:- Ability to find SUM(salary) from the number of male and female employees.
SELECT SUM(salary) FROM employee_payroll       -- The SUM() function returns the total sum of a numeric column. 
WHERE Gender = 'M' 
GROUP BY Gender;   --The GROUP BY statement groups rows that have the same values into summary rows.

SELECT SUM(salary) FROM employee_payroll          --The SUM() function returns the total sum of a numeric column. 
WHERE Gender = 'F' 
GROUP BY Gender;   --The GROUP BY statement groups rows that have the same values into summary rows.

Select Gender, SUM(salary) From employee_payroll GROUP BY Gender;  -- Group the sum of employee's salaries on the basis of gender

--UC7.2:- Ability to find AVG(salary) from the number of male and female employees.
Select Gender, AVG(salary) From employee_payroll GROUP BY Gender;  -- Group the avg of employee's salaries on the basis of gender
--AVG() function returns the average value of a numeric column.

--UC7.3:- Ability to find MIN(salary) from the number of male and female employees.
Select Gender, MIN(salary) From employee_payroll GROUP BY Gender;  -- Group the min(salary) from employees on the basis of gender
--The MIN() function returns the smallest value of the selected column.

--UC7.4:- Ability to find MAX(salary) from the number of male and female employees.
Select Gender, MAX(salary) From employee_payroll GROUP BY Gender;  -- Group the max(salary) from employees  on the basis of gender
--The MAX() function returns the largest value of the selected column.

--UC7.5:- Ability to COUNT number of male and female employees.
Select Gender, COUNT(name) From employee_payroll GROUP BY Gender;  -- Group the max(salary) from employees  on the basis of gender
 --The COUNT() function returns the number of rows that matches a specified criterion.


-- UC8:- Ability to extend employee_payroll data to store employee information like employee phone, address and department.
-- Ensure employee department is non nullable fields.
-- Add Default Value for address field.
-- UC8.1:- Ability to extend employee_payroll data to store employee information like employee phone.
alter table employee_payroll add phone_number bigint;                  --Alter the table by adding new column
alter table employee_payroll ALTER COLUMN phone_number VARCHAR(250);   --Alter any column of the table
select *  from employee_payroll

-- UC8.2:- Ability to extend employee_payroll data to store employee information like address.
-- Add Default Value for address field.
alter table employee_payroll add address varchar(250) NOT NULL default'Jaunpur';  --Adding address field with default value
select *  from employee_payroll

-- UC8.3:- Ability to extend employee_payroll data to store employee information like department.
-- Ensure employee department is non nullable fields.
alter table employee_payroll add department varchar(150) NOT NULL default 'CE';
select *  from employee_payroll


--UC9:- Ability to extend employee_payroll table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay.
--Ability to extend employee_payroll table salary to have Basic Pay.
EXEC sp_RENAME 'employee_payroll.salary', 'Basic_Pay', 'COLUMN';  
--SQL Server use sp_rename to rename the column in the Employee_payroll table from salary to Basic_Pay.
select *  from employee_payroll;

ALTER TABLE employee_payroll ADD Deductions Float;  --In MSSQL we cann't add datatype as Double
select *  from employee_payroll;

ALTER TABLE employee_payroll ADD Taxable_Pay FLOAT;  --Adding Taxable_Pay field
select *  from employee_payroll;

ALTER TABLE employee_payroll ADD Income_Tax FLOAT;    --Adding Income_Tax field
select *  from employee_payroll;

ALTER TABLE employee_payroll ADD Net_Pay FLOAT;       --Adding Net_Pay field
select *  from employee_payroll;

exec sp_help employee_payroll;
--sp_help is executed with no arguments, summary information of objects of all types 
--that exist in the current database is returned.


-- UC10:- Ability to make Terissa as part of Sales and Marketing Department.
-- Note: The Complete employee payroll roll need to be Inserted.
-- If a Salary is now going to be updated multiple rows has to be updated creating unnecessary redundancy
-- Further There is 2 Employee ID so according to Database there is two different Terissa

--UC10.1:- If a Salary is now going to be updated multiple rows has to be updated creating unnecessary redundancy.
UPDATE employee_payroll set department = 'Sales' where name = 'Terisa'; -- Updating department of Terisa

INSERT INTO employee_payroll
(name, Basic_Pay, startdate, Gender, department, Deductions, Taxable_Pay, Income_Tax, Net_Pay) VALUES
('Terisa',300000.00, '2018-01-03','F','Marketting',100000.00, 200000.00, 50000.00,150000.00);

--UC10.2:- Further There is 2 Employee ID so according to Database there is two different Terissa
select * from employee_payroll where name='Terisa'

--UC11:- Implement the ER Diagram into Payroll Service DB.
--       - Create the corresponding tables as identified in the ER Diagram along with attributes.
--       - For Many to Many relationship, create new Table called Employee Department having Employee Id and Department ID and redo the UC 7.

-- UC11.1:- Create table PayrollDetails 
create table PayrollDetails(
Payroll_id int not null Primary Key,
BasePay int not null,
Deduction int not null,
TaxtablePay as (BasePay-Deduction) persisted,
NetPay as (BasePay-Deduction-0.05*( BasePay-Deduction)) persisted,
IncomeTax as 0.05*(BasePay-Deduction) persisted
);
select * from PayrollDetails

--Insert Values PayrollDetails Table
insert into PayrollDetails values (1,500000,40000),(2,400000,8000),(3,450000,50000),(4,300000,45000);
select * from PayrollDetails


--UC11.2:- Create EmployeeDetails Table
create table EmployeeDetails 
(
Emp_id int not null Primary Key identity(1,1),
Emp_Name varchar(50) not null,
Gender char(1) not null,
Phone_Number varchar(50),
Payroll_id int not null Foreign key References PayrollDetails(Payroll_id),
Start_Date Date default GetDate()
);
select * from EmployeeDetails; -- Display Table

--insert values into EmployeeDetails Table
INSERT into EmployeeDetails(Emp_Name,Gender,Phone_Number,Payroll_id) values
('Shubham Seth','M','8188616249','1'),
('Ajay Seth','M','9856237845','2'),
('Om Prakash','M','7856239865','3'),
('Terissa','F','8945123698','4');

--UC11.3:- Create Table Department   relation M-M
create table Department(Dept_id int not null identity(1,1) primary key,DeptName varchar(50) not null unique);
select * from Department;  --display Table

--drop table Department
--Insert Values Department Table
insert into Department(DeptName) values
('Computer'),
('IT'),
('Civil'),
('Mech');
select * from Department;  --display Table


--UC11.4:- Create Table DeptEmployee   relation M-M
create table DeptEmployee(
Emp_id int not null Foreign key references EmployeeDetails(Emp_id),
Dept_id int not null Foreign key references Department(Dept_id) 
);
select * from DeptEmployee;

--Insert Values into DeptEmployee Table
insert into DeptEmployee values(1,3);
select * from DeptEmployee;


--UC11.5:- Create Table Addresses  Relation 1-1
create table Addresses(
Emp_id int not null primary key Foreign key references EmployeeDetails(Emp_id),
Street varchar(50) not null,
City varchar(50),
State varchar(50)
);
select * from Addresses;

--Insert Values Addresses Table
insert into Addresses Values
(1,'Chandawak-Ghazipur Road','Jaunpur','UttarPradesh'),
(2,'Kale Colony','Pune','Maharashtra');
select * from Addresses;


--UC12:- Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure.
--Rechecking UC4 get income Tax Employee
select Emp_id,Emp_Name,IncomeTax from EmployeeDetails,PayrollDetails where EmployeeDetails.Payroll_id=PayrollDetails.Payroll_id;

--Retrive income Tax UC5 get income Tax Employee
select Emp_id,Emp_Name,IncomeTax from EmployeeDetails,PayrollDetails where Emp_Name='Om Prakash' and  
EmployeeDetails.Payroll_id=PayrollDetails.Payroll_id;

--Retrive income Tax UC5 get income Tax Employee
select Emp_id,Emp_Name,IncomeTax from EmployeeDetails,PayrollDetails where Start_Date between CAST('1900-01-01' as date) and GETDATE() and  
EmployeeDetails.Payroll_id=PayrollDetails.Payroll_id;

--Joining the EmployeeDetails table and PayrollDetails table using inner join
Select * from PayrollDetails a
inner join EmployeeDetails b on
a.Payroll_id = b.Payroll_id;

--Check MIN MAX Income Tax UC7
select * from PayrollDetails
Alter Table PayrollDetails add Gender varchar(1);
UPDATE PayrollDetails set Gender = 'F' where Payroll_id = 4;   --updating Gender
UPDATE PayrollDetails set Gender = 'M' where Payroll_id = 1 or Payroll_id = 2 or Payroll_id = 3 

Select Gender, MIN(IncomeTax) From PayrollDetails GROUP BY Gender;
Select Gender, MAX(IncomeTax) From PayrollDetails GROUP BY Gender;
Select Gender, AVG(IncomeTax) From PayrollDetails GROUP BY Gender;
Select Gender, Sum(IncomeTax) From PayrollDetails GROUP BY Gender;

