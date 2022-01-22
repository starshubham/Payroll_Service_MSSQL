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
Insert into employee_payroll (name,salary,startDate) values('Arjun',5545,GETDATE()),('Madan',54545,GETDATE())

--Delete
--from employee_payroll
--Where id=3               # It is used to delete a particular row by using id or name etc..


--UC4 : Ability to retrieve all the employee payroll data 
select * 
from employee_payroll;