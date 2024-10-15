--SQL BOOTCAMP
--Table Creation

CREATE TABLE EmployeeDemographics(
EmployeeID int Primary key,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender Varchar(50)
)

CREATE TABLE EmployeeSalary(
EmployeeID int,
JobTitle varchar(50),
Saary int
)

INSERT INTO EmployeeDemographics VALUES
(1002,'Pam','Beasley',30,'Female'),
(1003,'Dwight','Schrute',29,'Male'),
(1004,'Angela','Martin',31,'Female'),
(1005,'Toby','Flenderson',32,'Male'),
(1006,'Micheal','Scott',35,'Male'),
(1007,'Meredith','Palmer',32,'Female'),
(1008,'Stanley','Hudson',38,'Male'),
(1009,'Kevin','Malone',31,'Male')

INSERT INTO EmployeeSalary VALUES
(1002,'Receptionist',36000),
(1003,'Salesman',63000),
(1004,'Accountant',47000),
(1005,'HR',50000),
(1006,'Regional Manager',65000),
(1007,'Regional Relations',41000),
(1008,'Salesman',48000),
(1009,'Accountant',42000)

--Lesson one--Select statement,*,Top,Distinct,Count,AS,Max,Min,AVG,Sum

SELECT *
FROM EmployeeDemographics

SELECT TOP 5*
FROM EmployeeDemographics

--Count will show all the values that are not null

SELECT count(LastName) as Lastnamecount
FROM EmployeeDemographics

--To change column name
sp_rename 'EmployeeSalary.saary','Salary'

--Querry for Maximum Salary
SELECT Max(Salary)
FROM EmployeeSalary

----Querry for Minimum Salary
SELECT Min(Salary)
FROM EmployeeSalary

--Querry for average salary
SELECT avg(Salary)
FROM EmployeeSalary

--When the Data Base is not linked directly then from statement changes
SELECT *
FROM [SQL BOOTCAMP].dbo.EmployeeSalary

--Lesson II where statement (=,>,<,>=,<=,and,or,like,not null,null,in)

--Not equal to
SELECT *
FROM EmployeeDemographics
Where FirstName<>'Jim'

--Greater than or equal to
SELECT *
FROM EmployeeDemographics
Where Age >=30

--And statement having to requests
SELECT *
FROM EmployeeDemographics
Where Age <=32 and Gender='Male'

--Or statement only one will be retained
SELECT *
FROM EmployeeDemographics
Where Age <=32 or Gender='Male'

--Like most used with wild cards(%)
--Any LastName starting with S
SELECT *
FROM EmployeeDemographics
Where LastName Like 'S%'

--Any LastName with Letter S anywhere in the name
SELECT *
FROM EmployeeDemographics
Where LastName Like 'S%o%'

--In multiple equal statements condensed way to say where
SELECT *
FROM EmployeeDemographics
Where FirstName IN ('Jim','Pam','Meredith','Kevin')

--Lesson III Group By, Order By statement

--Group By basically its like count/Distinct 
--CountGender is not at the Group By as it a derived column
SELECT Gender,Count(Gender) as Gendercount
FROM EmployeeDemographics
Where Age>31
Group by Gender

--Order by SQL has defaulty ASC order you can column number when ordering by
SELECT Gender,Count(Gender) as Gendercount
FROM EmployeeDemographics
Where Age<35
Group by Gender
Order by Gendercount desc

SELECT *
FROM EmployeeDemographics
Order by Age desc,Gender 

INSERT INTO EmployeeDemographics VALUES
(1011,'Ryan','Howard',26,'Male'),
(NULL,'Holy','Flux',Null,Null),
(1013,'Daryl','Philbin',Null,'Male')

INSERT INTO EmployeeSalary VALUES
(1010,null,47000),
(Null,'Salesman',43000)

--Intermediate SQL
--LESSON I inner joins,Full joins,Left and Right Joins
--A join is a way to combine multiple tables in a single output

--Inner Join shows everything with the same information in this  example with the same EmployeeID.
--Any information on the two tables withi different EmployeeID wont be shown in the joined output
SELECT * FROM EmployeeDemographics
Inner join EmployeeSalary
	ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

--Full outer join
--Shows everything regards of common information
SELECT * FROM EmployeeDemographics
Full outer Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

--Left Outer Join
--When using the Left Joins, it picks everythin on the First table and 
--ll the matching information on the other table
SELECT * FROM EmployeeDemographics--First Table
Left join EmployeeSalary--second table
	ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
--Right Join
--When using the Right Join,it picks everythin on the second table and 
--all the matching information on the other table
SELECT * FROM EmployeeDemographics--First Table
Left join EmployeeSalary--second table
	ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

--use case example
--Find the highest paid employer apart from Micheal Scott--Dwight Scruite will be the affacted Employee in the company
SELECT * FROM EmployeeDemographics--First Table
inner  Join EmployeeSalary--second table
	ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
Where Firstname<>'Micheal'
Order by Salary desc


--Use case example II
--Find the avareage salary for salesman
SELECT JobTitle,avg(Salary) as Avgsalary
FROM EmployeeDemographics as Demo 
Full outer join EmployeeSalary as Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Where JobTitle='Salesman'
Group By JobTitle

--Using Inner Join
SELECT JobTitle,avg(Salary) as Avgsalary
FROM EmployeeDemographics as Demo 
Inner Join EmployeeSalary as Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Where JobTitle='Salesman'
Group By JobTitle

--Unions and Union All
--Most used to join tables into one but they should have the same data type in the column

SELECT* FROM EmployeeDemographics

SELECT * FROM EmployeeSalary

CREATE TABLE WareHouseEmployeeDemographics (
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

INSERT INTO WareHouseEmployeeDemographics VALUES
(1013,'Daryl','Philbin',31,'Male'),
(1050,'Roy','Anderson',40,'Male'),
(1013,'Val','Johnson',31,'Female')

--Union and Union All worked beacuse the two table have the same data type 
SELECT * FROM EmployeeDemographics
UNION ALL
SELECT *FROM WareHouseEmployeeDemographics

--Updating Data in a Table
UPDATE WareHouseEmployeeDemographics
Set EmployeeID=1052 where FirstName='Val'

--Lesson III CASE STATEMENTS
--Allows to specify conditions and what to be return after the condition is met

SELECT * FROM EmployeeDemographics
WHERE Age is not null
order by age

--Case statement example Condition to be age >30 to be old and else to be young
SELECT FirstName,LastName,Age,
	(CASE
	When Age>30 Then 'Old'
	When Age Between 27 and 30 Then 'Young'
	ELSE 'Baby'
	END ) as Agegap
FROM EmployeeDemographics
Where Age is not null
Order by Age

--Use case II 
--Make yearly rise depending on the JobTitle (Salesman 0.5%,HR 0.0001%, REST 0.003%)
 SELECT FirstName,LastName,JobTitle,Salary,
	(CASE 
	WHEN JobTitle='Salesman' THEN Salary+(Salary*.10)
	WHEN JobTitle='Accountant' THEN Salary+(Salary*0.05)
	WHEN JobTitle='HR' THEN Salary+(Salary*0.00001)
	ELSE Salary+(Salary*0.03)
	END) Payrise
 FROM EmployeeDemographics as DEMO
 Inner Join EmployeeSalary as Sal
	ON	Demo.EmployeeID=Sal.EmployeeID

--Partition By
--Compared to Group By statement.Partition divides the rows

SELECT  FirstName,LastName,Gender,Count(Gender)
FROM EmployeeDemographics Demo
	Inner Join EmployeeSalary Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Group By  FirstName,LastName,Gender


SELECT  FirstName,LastName,Gender,
	Count(Gender) OVER(Partition By Gender) as TotalGender
FROM EmployeeDemographics Demo
	Inner Join EmployeeSalary Sal
	ON Demo.EmployeeID=Sal.EmployeeID



SELECT  Gender,
	Count(Gender) 
FROM EmployeeDemographics Demo
	Inner Join EmployeeSalary Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Group By Gender


--WITH CTES Common Express Tables
--Only used with the querry once the querry is not available
--The table doesnot exists(Temporary result set) Create in memory

SELECT  *
FROM EmployeeDemographics Demo
	Inner Join EmployeeSalary Sal
	ON Demo.EmployeeID=Sal.EmployeeID

WITH CTE_Employee as 
(SELECT  FirstName,LastName,Gender,Salary,
	Count(Gender) OVER(Partition By Gender) as TotalGender
	,AVG(Salary) OVER(Partition By Gender) as AvgSalary
FROM EmployeeDemographics Demo
	Inner Join EmployeeSalary Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Where Salary >'45000'
	)
Select * From  CTE_Employee

--Temp Table (Temporary Tables)
--You can use the Temp Tables mutliple times unlike with the CTES
--Which is only used within the querry.It is created in a similar manner as normal table

CREATE TABLE #Temp_Employee (
EmployeeID int,
JobTitle Varchar(100),
Salary Int )

INSERT INTO #Temp_Employee VALUES 
(1001,'HR',45000)
(

SELECT * FROM #Temp_Employee

--When inserting data into a Temp Table from a previous Table 
--You dont add value--you remove the value statement in your querry
INSERT INTO #Temp_Employee 
SELECT * FROM EmployeeSalary

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2( 
JobTitle Varchar(50),
EmployeeperJob int,
Avgage int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle,Count(JobTitle),AVG(Age),Avg(Salary)
FROM EmployeeDemographics as Demo
Inner Join EmployeeSalary as Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Group BY JobTitle

SELECT * FROM #Temp_Employee2

--String Functions TRIM,LTRIM,RTRIM,Replace,Substring
--Upper,Lower
 DROP TABLE IF EXISTS EmployeeErros
CREATE TABLE EmployeeErros (
EmployeeID Varchar (50),
FirstName Varchar(50),
LastName Varchar(50)
)
INSERT INTO EmployeeErros VALUES
(  '1001', 'Jimbo  ','Halbert'),
('1002  ','Pamela','Beasley'),
('1005','TOby','Flenderson-Fired')


SELECT * FROM EmployeeErros

--String Functions
--TRIM,LTRIM,RTRIM

--Full Trim
SELECT EmployeeID ,TRIM(EmployeeID) AS idtrim  FROM EmployeeErros


--Left Trim LTRIM
SELECT EmployeeID ,LTRIM(EmployeeID) AS idtrim  FROM EmployeeErros


--Right Trim RTRIM
SELECT EmployeeID ,RTRIM(EmployeeID) AS idtrim  FROM EmployeeErros


--Using Replace
SELECT LastName,REPLACE(LastName,'-Fired',' ') as LastNameFixed FROM EmployeeErros

--Substring
SELECT  Substring(FirstName,3,3) FROM EmployeeErros


--Froozing Matching
SELECT  Substring (Err.FirstName,1,3),Substring(Demo.FirstName,1,3) FROM EmployeeErros Err
Inner Join EmployeeDemographics Demo
	ON Substring (Err.FirstName,1,3)=Substring(Demo.FirstName,1,3)


SELECT  Substring(FirstName,3,3) FROM EmployeeErros

--UPPER AND LOWER CASES
SELECT FirstName,Lower(FirstName)
FROM EmployeeErros

--UPPER CASES
SELECT FirstName,UPPER(FirstName)
FROM EmployeeErros
Where FirstName='Jimbo'



--STORED PROCEDURES
--Group of SQL Statements that have been created and stored in the DataBase
--Can be used by several users..Reduce network traffic.

CREATE PROCEDURE TEST
AS
	SELECT * FROM EmployeeDemographics
	

	EXEC TEST


 CREATE PROCEDURE Temp_Employee
  AS
  CREATE TABLE #Temp_Employee2( 
JobTitle Varchar(50),
EmployeeperJob int,
Avgage int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle,Count(JobTitle),AVG(Age),Avg(Salary)
FROM EmployeeDemographics as Demo
Inner Join EmployeeSalary as Sal
	ON Demo.EmployeeID=Sal.EmployeeID
Group BY JobTitle

SELECT * FROM  #Temp_Employee2

EXEC  #Temp_Employee2



--Subquerries also called nested querry which are used in a querry
--They can be used in From, Select, Where statements

SELECT * FROM EmployeeSalary

--Subquerry in a SELCT Statement

SELECT EmployeeID,Salary,( select AVG(Salary) FROM EmployeeSalary) as AVGsalary
FROM EmployeeSalary

--How to do it with Partition By
SELECT EmployeeID,Salary,AVG(Salary) OVER()
FROM EmployeeSalary
Group by  EmployeeID,Salary

--SubQuerry From Statement
SELECT * FROM (SELECT EmployeeID,Salary,AVG(Salary) OVER () as AvgSal
		FROM EmployeeSalary)
		
--SubQuerry in a WHERE Statement
SELECT EmployeeID,JobTitle,Salary
FROM EmployeeSalary
WHERE EmployeeID IN(
	SELECT EmployeeID
	FROM EmployeeDemographics
	Where Age>30)


--DATA ANALYSIS PORTFOLIO PROJECT (ALEX THE ANALYST)
--PROJECT will be four SQL,DATA VISUALIZATION WITH TABLEAU,DATA CLEANING,Python(Panda and Data cleaning)

--EXERCISE ONE-Downloading data and importing data into SQL DataBase


SELECT * FROM CovidDeaths ORDER BY 3,4

--Select the Data which will be used in the Portfolio Project

SELECT location,Date,total_cases,new_cases,
		total_deaths,population
FROM CovidDeaths 
ORDER BY 1,2

--Looking at Total Cases vs Total deaths and using the where clause and like
--This shows the likelihood of dying when infacted with Covid in your location
SELECT location,Date,population,total_cases,
		total_deaths,(total_deaths/total_cases)*100 PercentageDeath
FROM CovidDeaths 
WHERE Location Like '%states%'
ORDER BY 1,2

SELECT location,Date,population,total_cases,
		total_deaths,(total_deaths/total_cases)*100 PercentageDeath
FROM CovidDeaths 
ORDER BY 1,2


--Looking at the total cases vs the population
--Shows what percentage  has been infected with Covid
SELECT location,Date,population,total_cases,
	(total_cases/population)*100 Percentageinfected
FROM CovidDeaths 
ORDER BY Percentageinfected desc

SELECT location,Date,population,total_cases,
		(total_cases/population)*100 Percentageinfected
FROM CovidDeaths 
Where Location like'%africa%'
ORDER BY 1,2

--Looking at the countries with the Highest Infection Rates compared to Populations
SELECT location,Date,population,
	Max(total_cases) HighestInceted,Max((total_cases/Population))*100 PercentageInfectedMax
FROM CovidDeaths
Group By location,Date,population,total_cases
ORDER BY PercentageInfectedMax DESC

--Showing countries with the Highest Death count per population

SELECT location,population,total_deaths,(total_deaths/population)*100 as Deathpercentage	
FROM CovidDeaths
Order By Deathpercentage Desc

--Solution II
SELECT location,population,total_deaths,Max(total_deaths)  MaxDeaths,Max((total_deaths/population))*100  Deathpercentage	
FROM CovidDeaths
Group By location,population,total_deaths
Order By Deathpercentage Desc


--Break things down by Continent(Converting Nvarchar type to int using cast)
SELECT location,Max(cast(total_deaths as int))  MaxDeaths
FROM CovidDeaths
Where Continent is null
Group By location
Order by MaxDeaths Desc

--Global numbers
SELECT Date,sum(new_cases),sum(cast(new_deaths as int))
FROM CovidDeaths
Where continent is not null
Group By date


--Global Numbers
SELECT sum(new_cases)sumnewcases,sum(cast(new_deaths as int)) sumnewdeaths,sum(cast(new_deaths as int))/sum(new_cases)*100 percntagedeath
FROM CovidDeaths
Where continent is not null


--Global Number per continent
SELECT continent,sum(new_cases)sumnewcases,sum(cast(new_deaths as int)) sumnewdeaths,sum(cast(new_deaths as int))/sum(new_cases)*100 percntagedeath
FROM CovidDeaths
Where continent is not null
Group By continent

--Global Numbers by Date
SELECT Date,sum(new_cases)sumnewcases,sum(cast(new_deaths as int)) sumnewdeaths,sum(cast(new_deaths as int))/sum(new_cases)*100 percntagedeath
FROM CovidDeaths
Where continent is not null
Group By Date


--Joining the Covid Deaths Table and Vaccination Table for further querring
SELECT * FROM CovidDeaths Dea
Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location

	--Looking at total population vs vaccination
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations
FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	Where dea.continent is not null
ORDER BY 2,3


--Rolling Count
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,
	sum(cast(Vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location) as rollungcount
FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	Where dea.continent is not null
ORDER BY 2,3

--Total number of people who were vaccinated in each location
--For this solution, one needs to create CTE or a temp table to solve the problem

WITH populationcount (continent,location,date,population,new_vaccinations,roullungcount)
 AS (
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,
	sum(cast(Vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location) as roullungcount
	FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	Where dea.continent is not null
)
SELECT *,(roullungcount/population) FROM populationcount


--Using a Temp Table solving the same problem

CREATE TABLE #PopVsVac (
Continent nvarchar(255),
Location nVarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
roullungcount numeric
)

INSERT INTO #PopVsVac
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,
	sum(cast(Vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location) as roullungcount
	FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	Where dea.continent is not null

SELECT *,(roullungcount/population) FROM #PopVsVac

--Using drop Table if exists espacially when you want to change anythin in the querry

DROP TABLE IF EXISTS #PopVsVac
CREATE TABLE #PopVsVac (
Continent nvarchar(255),
Location nVarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
roullungcount numeric
)

INSERT INTO #PopVsVac
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,
	sum(cast(Vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location) as roullungcount
	FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	--Where dea.continent is not null

SELECT *,(roullungcount/population) FROM #PopVsVac

--CREATE A VIEW using the global Numbers to store data for later visualization

CREATE VIEW PercentagePopulationvaccinated as
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,
	sum(cast(Vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location
	,dea.date) as Rollingpeoplevaccinated
	FROM CovidDeaths Dea
	Inner JOIN CovidVaccinations Vac
	ON Dea.date=Vac.date and 
	Dea.location=Vac.location
	Where dea.continent is not null


SELECT * FROM PercentagePopulationvaccinated





SELECT continent,sum(new_cases)sumnewcases,sum(cast(new_deaths as int)) sumnewdeaths,sum(cast(new_deaths as int))/sum(new_cases)*100 percntagedeath
FROM CovidDeaths
Where continent is not null
Group By continent