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

