SELECT employee.name, department.name
FROM employee LEFT JOIN department
ON employee.department = department.code;

SELECT employee.name, employees.name
FROM employee JOIN employee AS employees
ON employee.department = employees.department
AND employee.name < employees.name;

WITH history_and_position AS (
        SELECT history.*, position.code, position.income
        FROM history LEFT JOIN position
        ON history.position = position.code
),
histories_and_position AS (
        SELECT employee histories_and_position_employee, MIN(start_date) AS min_start_date
        FROM history_and_position
	GROUP BY histories_and_position_employee
),
history_and_positions AS (
	SELECT histories_and_position.histories_and_position_employee history_and_positions_employee, histories_and_position.min_start_date history_and_positions_min_start_date, history_and_position.income history_and_positions_income
	FROM histories_and_position JOIN history_and_position
	ON histories_and_position.histories_and_position_employee = history_and_position.employee
	AND histories_and_position.min_start_date = history_and_position.start_date
	WHERE start_date < '2012-01-01'
),
histories_and_positions AS (
	SELECT employee histories_and_positions_employee, start_date histories_and_positions_start_date, income histories_and_positions_income
	FROM history_and_position LEFT JOIN history_and_positions
	ON history_and_position.employee = history_and_positions.history_and_positions_employee
	AND history_and_position.start_date = history_and_positions.history_and_positions_min_start_date
	AND history_and_position.income = history_and_positions.history_and_positions_income
	WHERE history_and_positions.history_and_positions_employee IS NULL
	OR history_and_positions.history_and_positions_min_start_date IS NULL
	OR history_and_positions.history_and_positions_income IS NULL
)
SELECT histories_and_positions.histories_and_positions_income - history_and_positions.history_and_positions_income AS income_increasement
FROM histories_and_positions JOIN history_and_positions
ON histories_and_positions.histories_and_positions_employee = history_and_positions.history_and_positions_employee
WHERE histories_and_positions.histories_and_positions_income - history_and_positions.history_and_positions_income = 50;

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