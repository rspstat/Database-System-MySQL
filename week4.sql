# Part 1
CREATE DATABASE PART1;
USE PART1;

CREATE TABLE department(
		deptno		int		NOT NULL,
		deptname	varchar(45)	NOT NULL,
		floor		int,
		CONSTRAINT PK_Department PRIMARY KEY (deptno)
);

CREATE TABLE employee(
	empno		int			NOT NULL,
	empname		varchar(45),
	title		varchar(45)		DEFAULT '사원',
	manager		int,
	salary		int,
	dno		int,
	CONSTRAINT PK_Employee PRIMARY KEY (empno),
	CONSTRAINT FK_Employee_Manager
	FOREIGN KEY (manager) REFERENCES employee(empno),
	CONSTRAINT FK_Department_Employee
	FOREIGN KEY (dno) REFERENCES department(deptno),
	CONSTRAINT UQ_empname UNIQUE (empname),
	CONSTRAINT CH_salary CHECK (salary < 6000000),
	CONSTRAINT CH_dno CHECK (dno IN (1, 2, 3, 4, 5, 6))
);

# Task 1
# DEFAULT
INSERT INTO department (deptno, deptname, floor) VALUES (1, '개발부', 3);
INSERT INTO employee (empno, empname, salary, dno) VALUES (1001, 'kgh', 3000000, 1);

# UNIQUE
INSERT INTO employee (empno, empname, title, salary, dno) VALUES (1002, '김철수', '대리', 3500000, 1);

# CHECK1
INSERT INTO employee (empno, empname, title, salary, dno) VALUES (1003, '박민수', '과장', 4500000, 1);

# CHECK2
INSERT INTO employee (empno, empname, title, salary, dno) VALUES (1004, '최지훈', '사원', 2800000, 2);

# Task 2
CREATE SCHEMA sport;
USE sport;

CREATE TABLE ADDRESS
(
    ADDRESS_ID CHAR(5) NOT NULL,
    ADDRESS_NAME VARCHAR(45) NOT NULL,
    ZIP_CODE INTEGER UNIQUE NOT NULL,
    CONSTRAINT PK_ADDRESS PRIMARY KEY(ADDRESS_ID)
);

CREATE TABLE TEAM
(
    TEAM_ID CHAR(5) NOT NULL,
    TEAM_NAME VARCHAR(45) NOT NULL,
    PHONE VARCHAR(45) DEFAULT '010-0000-0000',
    ADDRESS_ID CHAR(5) NOT NULL,
    CONSTRAINT PK_TEAM PRIMARY KEY(TEAM_ID),
    CONSTRAINT FK_TEAM_ADDRESS FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

CREATE TABLE PLAYER
(
    PLAYER_ID CHAR(5) NOT NULL,
    PLAYER_NAME VARCHAR(45)	NOT NULL,
    PLAYER_NO INTEGER CHECK (PLAYER_NO < 99),
    EMAIL VARCHAR(45) NOT NULL,
    TEAM_ID CHAR(5)	NOT NULL,
    CONSTRAINT PK_PLAYER PRIMARY KEY(PLAYER_ID),
    CONSTRAINT FK_Player_Team FOREIGN KEY(TEAM_ID) REFERENCES TEAM(TEAM_ID)
);

# Task 2 Test
INSERT INTO ADDRESS VALUES (1, '서울시 강남구', '1234');
INSERT INTO TEAM (TEAM_ID, TEAM_NAME, ADDRESS_ID) VALUES (1, 'FC-SEOUL', 1);
INSERT INTO PLAYER VALUES ('1', '김규현', 7, 'kgh@email.com', 1);

INSERT INTO ADDRESS VALUES (3, '부산시 해운대구', '12345');

# Task 3
USE world;

SELECT C.Name AS Country_Name, T.Name AS City_Name, T.Population
FROM city T
JOIN country C on T.CountryCode = C.Code
WHERE T.Population > 5000000;

# Task 4
USE world;

SELECT Country.Name AS Country, city.Name AS Capital, countrylanguage.Language AS OfficialLanguage
FROM country
JOIN city ON country.Capital = city.ID
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE country.Name = 'Sweden'
AND countrylanguage.isOfficial = 'T';

# Final Tasks
# 1
USE world;

SELECT DISTINCT C.Name AS Country
FROM Country C
JOIN CountryLanguage L ON C.Code = L.CountryCode
WHERE L.Language = 'Korean';

# 2
SELECT C.Name AS Country, T.Name AS City
FROM city T
JOIN country C ON T.CountryCode = C.Code
WHERE C.Name IN ('South Korea', 'Japan');

# 3
SELECT C.Name AS Country, COUNT(*) AS OfficialLanguage
FROM country C
JOIN countrylanguage L ON C.Code = L.CountryCode
WHERE L.IsOfficial = 'T'
GROUP BY C.Code, C.Name
ORDER BY OfficialLanguage DESC
LIMIT 1;
