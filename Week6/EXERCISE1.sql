SELECT employee.name, department.name
FROM employee JOIN department
ON employee.department = department.code;

SELECT employee.name, employees.name
FROM employee JOIN employee AS employees
ON employee.department = employees.department
AND employee.name < employees.name;

WITH history_and_position AS (
	SELECT history.*, position.code, position.income
	FROM history LEFT OUTER JOIN position
    	ON history.position = position.code  
),
history_before_20120101_and_position AS (
	SELECT *
    	FROM history_and_position
    	WHERE start_date < '2012-01-01'  
),
history_after_20120101_and_position AS (
    	SELECT *
    	FROM history_and_position
    	WHERE start_date >= '2012-01-01'
)
SELECT history_after_20120101_and_position.income - history_before_20120101_and_position.income AS income_increasement
FROM history_after_20120101_and_position JOIN history_before_20120101_and_position
ON history_after_20120101_and_position.employee = history_before_20120101_and_position.employee
WHERE history_after_20120101_and_position.income - history_before_20120101_and_position.income = 50;

SELECT name, position
FROM employee LEFT JOIN position
ON employee.position = position.code
WHERE income IN (
    	SELECT MAX(income) FROM position  
);

SELECT number, name, income
FROM employee LEFT JOIN position
ON employee.position = position.code
WHERE name REGEXP "^L.{3,}$";

SELECT number, name, position FROM employee
WHERE department = "DP1"
UNION
SELECT number, name, position FROM employee
WHERE department = "DP2";

SELECT department.name, employee.name
FROM department JOIN employee
ON department.code = employee.department
WHERE employee.supervisor IS NULL
UNION
SELECT department.name, employee.name
FROM department JOIN employee
ON department.director = employee.number;

SELECT department.name, employee.name
FROM department JOIN employee
ON department.code = employee.department
WHERE employee.supervisor IS NULL
UNION
SELECT department.name, employee.name
FROM department JOIN employee
ON department.director = employee.number;

SELECT DISTINCT position.code, department.name
FROM position
RIGHT JOIN employee
ON position.code = employee.position
LEFT JOIN department
ON employee.department = department.code;