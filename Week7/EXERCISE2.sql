SELECT department.name, employee.name
FROM department JOIN employee
ON department.code = employee.department
WHERE employee.supervisor IS NULL
UNION
SELECT department.name, employee.name
FROM department JOIN employee
ON department.director = employee.number
WHERE EXISTS (
    SELECT 1 FROM employee  
);

WITH employees_who_are_directors_or_supervisors AS (
    SELECT department.name department_name, employee.name employee_name
    FROM department JOIN employee
    ON department.code = employee.department
    WHERE employee.supervisor IS NULL
    UNION
    SELECT department.name, employee.name
    FROM department JOIN employee
    ON department.director = employee.number   
)
SELECT COUNT(*) FROM employees_who_are_directors_or_supervisors;

WITH department_and_employee AS (
    	SELECT department.director department_director, employee.name employee_name
    	FROM department JOIN employee
    	ON department.director = employee.number
)
SELECT position.code FROM position
RIGHT JOIN employee
ON position.code = employee.position
LEFT JOIN department
ON employee.department = department.code
LEFT JOIN department_and_employee
ON department.director = department_and_employee.department_director
WHERE department.location = 'Hanoi'
AND department_and_employee.employee_name REGEXP "^P";

SELECT employee.name, income, department.name FROM employee
LEFT JOIN position
ON employee.position = position.code
LEFT JOIN department
ON employee.department = department.code
WHERE employee.supervisor IS NULL
AND department.location = 'Hanoi';

SELECT name FROM employee
LEFT JOIN position ON employee.position = position.code
WHERE income IN (
    	SELECT MAX(income) FROM position  
);

SELECT name, number FROM employee
WHERE number IN (
    	SELECT supervisor FROM employee  
);

SELECT name FROM employee
LEFT JOIN position ON employee.position = position.code
WHERE position.income > ALL (
    SELECT income FROM position
    RIGHT JOIN employee ON position.code = employee.position
    WHERE department = 'DP1'  
);

SELECT name, number FROM employee
WHERE number NOT IN (
    SELECT supervisor FROM employee
    WHERE supervisor IS NOT NULL  
);

SELECT employee.name FROM employee
LEFT JOIN department ON employee.department = department.code
WHERE number IN (
    SELECT supervisor FROM employee
    RIGHT JOIN department ON employee.department = department.code
    AND department.location = 'HCMC'  
);