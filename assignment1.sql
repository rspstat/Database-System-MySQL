# 1. JOIN Query
SELECT T.Name AS CityName, C.Name AS CountryName
FROM city T
JOIN country C ON T.CountryCode = C.Code;


# 2. JOIN + WHERE + AND
SELECT T.Name AS CityName, C.Name AS CountryName, T.Population
FROM city T
JOIN country C ON T.CountryCode = C.Code
AND T.Population > 5000000;


# 3. JOIN + Aggregation Function + WHERE + GROUP BY + HAVING
SELECT C.Name AS CountryName, COUNT(L.Language) AS LanguageCount
FROM country C
JOIN countrylanguage L ON C.Code = L.CountryCode
WHERE L.IsOfficial = 'T'
GROUP BY C.Name
HAVING COUNT(L.Language) >= 2;


# 4. NESTED QUERY (Subquery)
SELECT C.Name
FROM country C
WHERE Code IN (
    SELECT L.CountryCode 
    FROM countrylanguage L
    WHERE Language = 'English' AND IsOfficial = 'T'
);


# 5. NESTED QUERY + Derived Table
SELECT A.CountryCode, A.LanguageCount
FROM (
    SELECT L.CountryCode, COUNT(*) AS LanguageCount
    FROM countrylanguage L
    WHERE IsOfficial = 'T'
    GROUP BY L.CountryCode
) AS A
WHERE A.LanguageCount >= 3;


# 6. NESTED QUERY + Derived Table + JOIN – (1 query)
SELECT C.Name AS CountryName, A.LanguageCount
FROM (
    SELECT L.CountryCode, COUNT(*) AS LanguageCount
    FROM countrylanguage L
    WHERE IsOfficial = 'T'
    GROUP BY L.CountryCode
) AS A
JOIN country C ON A.CountryCode = C.Code
WHERE A.LanguageCount >= 3;  
