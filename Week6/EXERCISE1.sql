SELECT employee.name, department.name
FROM employee JOIN department
ON employee.department = department.code;

SELECT employee.name, employees.name
FROM employee JOIN employee AS employees
ON employee.department = employees.department
AND employee.name < employees.name;

WITH commission_and_history AS (
SELECT commission.employee AS commission_employee, history.employee AS history_employee, commission.date, commission.value FROM commission LEFT JOIN history
ON commission.employee = history.employee
WHERE history.start_date < "2012-01-01"
OR (history.start_date IS NULL AND commission.date <= "2012-01-01")
)




SELECT name, position,  FROM employee LEFT JOIN 
ON employee.number = commission.employee
WHERE name REGEXP "^L.{3,}$";

SELECT number, name, position FROM employee
WHERE department = "DP1"
UNION
SELECT number, name, position FROM employee
WHERE department = "DP2";

SELECT department.name, employee.name
FROM department JOIN employee
ON department.code = employee.department
AND (department.director = employee.number
OR employee.number IN (
SELECT supervisor FROM employee
WHERE supervisor IS NOT NULL
));

