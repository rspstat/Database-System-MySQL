# Task 1
CREATE DATABASE test;
USE test;

CREATE TABLE department(
	deptno		int		NOT NULL,
	deptname	varchar(45)	NOT NULL,
	floor		int,
	CONSTRAINT PK_Department PRIMARY KEY (deptno)
);

-- EMPLOYEE relation with referential actions
CREATE TABLE employee(
	empno			int		NOT NULL,
	empname		varchar(45),
	dno			int,
    	CONSTRAINT PK_Employee PRIMARY KEY (empno),
	CONSTRAINT FK_Department_Employee
	FOREIGN KEY (dno) REFERENCES department(deptno) ON DELETE CASCADE
);

INSERT INTO department
VALUES 
	(1, '영업', 8),
	(2, '기획', 10),
	(3, '개발', 9);

INSERT INTO employee    
VALUES 
   (2106, '김창섭', 2),
   (3426, '박영권', 3),
   (3011, '이수민', 1),
   (1003, '조민희', 1),
   (3427, '최종철', 3);


# Task 2
/*
Find all cities located in the most populous country
HINT: (1) Find the most populous country (CountryCode); (2) Find its cities
*/

USE world;

SELECT Name, CountryCode
FROM City
WHERE CountryCode =  (
		SELECT Code
		FROM Country
		ORDER BY Population DESC
		LIMIT 1);


# Task 3
SELECT C.Name
FROM Country C
JOIN City T ON C.Code = T.CountryCode
WHERE T.Population > 5000000 AND C.Continent = ( 
		SELECT Continent
		FROM Country
		WHERE Name = 'Uzbekistan');


# Task 4
# (1) JOIN
SELECT C.Name, C.Continent, L.Language, L.Percentage
FROM Country C
JOIN CountryLanguage L ON C.Code = L.CountryCode
WHERE C.Continent = 'Asia' AND L.Percentage > 50
ORDER BY L.Percentage DESC;


# (2) Using Derived Table
SELECT C.Name, C.Continent, L.Language, L.Percentage
FROM (	
	SELECT L.CountryCode, L.Language, L.Percentage
	FROM CountryLanguage L
	WHERE L.Percentage > 50
    ORDER BY L.Percentage DESC
) AS L
JOIN Country C ON L.CountryCode = C.Code
WHERE C.Continent = 'Asia'
ORDER BY Percentage DESC;

# Task 5
SELECT C.Name, L.NumOfLanguages
FROM (
	SELECT L.CountryCode, COUNT(*) AS NumOfLanguages
	FROM CountryLanguage L
	GROUP BY L.CountryCode
	) AS L
JOIN Country C ON L.CountryCode = C.Code 
WHERE L.NumOfLanguages = 2
GROUP BY L.CountryCode
ORDER BY Name ASC;

