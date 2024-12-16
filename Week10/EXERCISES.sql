SELECT DISTINCT name FROM employee
RIGHT JOIN commission
ON employee.number = commission.employee
WHERE value > 200 AND value <= 400;

SELECT position, department.name, COUNT(*) number_of_employees FROM employee
LEFT JOIN department ON employee.department = department.code
GROUP BY code, position;

WITH names_of_the_departments_and_codes_of_the_positions AS (
    SELECT department.name names_of_the_departments, position codes_of_the_positions, COUNT(*) number_of_employees FROM employee
    LEFT JOIN department ON employee.department = department.code
    GROUP BY names_of_the_departments, codes_of_the_positions
)
SELECT names_of_the_departments, codes_of_the_positions FROM names_of_the_departments_and_codes_of_the_positions
WHERE number_of_employees >= 2;

SELECT name, number FROM employee
WHERE number in (
    SELECT supervisor FROM employee
)
ORDER BY name ASC;

SELECT COUNT(*) FROM employee
RIGHT JOIN department ON employee.number = department.director
UNION
SELECT COUNT(*) FROM employee
JOIN employee AS employees
ON employee.number = employees.supervisor;

SELECT position.code, income, COUNT(*) FROM position
LEFT JOIN employee ON position.code = employee.position
LEFT JOIN department ON employee.department = department.code
WHERE department.location <> 'Hanoi'
GROUP BY code;

WITH supervisors AS (
    SELECT name, number FROM employee
    WHERE number IN (
        SELECT supervisor FROM employee
        JOIN department ON employee.department = department.code
        AND department.location <> 'Hanoi'
    )
)
SELECT supervisors.name, COUNT(*) FROM supervisors
JOIN employee ON supervisors.number = employee.supervisor
GROUP BY supervisors.name;

WITH total_number_of_employees_in_that_department AS (
    SELECT code, COUNT(*) total_number_of_employees FROM department
    JOIN employee ON department.code = employee.department
    GROUP BY code
)
SELECT employee.name, department.code, total_number_of_employees FROM employee
JOIN department ON employee.number = department.director
JOIN total_number_of_employees_in_that_department ON department.code = total_number_of_employees_in_that_department.code;

CREATE VIEW employees_most_positions_department AS
    WITH different_positions AS (
        SELECT employee.number, COUNT(*) different_positions
        FROM employee LEFT JOIN history
        ON employee.number = history.employee
        GROUP BY employee.number
    )
    SELECT department.name department_name, employee.name employee_name FROM department
    RIGHT JOIN employee ON department.code = employee.department
    LEFT JOIN different_positions ON employee.number = different_positions.number
    WHERE different_positions > 3;