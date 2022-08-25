USE Employees;

#1 select mostrando tabela employees e ordenando
select *
from employees 
order by first_name;

#2 select mostrando tabela departments e ordenando
select *
from departments
order by dept_name;

#3 select mostrando tabela manager e ordenando
select *
from dept_manager
order by to_date;

#4 select mostrando tabela titulos e ordenando
select *
from titles
order by title;

#5 select mostrando tabela salario, ordenando e agrupando
select *
from salaries 
group by from_date
order by salary desc;

#6 select mostrando tabela salario onde salario é maior que 0 ou salario null
select *
from salaries 
where salary >= 0 or salary is null
order by salary;

#7 select mostrando tabela titulo, onde se encontra a palavra set na coluna e ordenado.
select *
from titles
where title like '%set%'
order by title;

#8 select mostrando quantidade de linha da tabela manager
select count(*) AS TotalLinhas
from dept_manager;

#9 select mostrando tabela empregados, onde se encontra a letra a nas colunas e genero M, ordenado
select *
from employees 
where first_name like '%A%' and gender = 'M'
order by birth_date;

#10 
select *
from departments
where (dept_name = 'Minas Gerais' and dept_name like 'Min%') 
or (dept_name = 'Rio Grande do sul' and dept_name like 'Rio%')
or (dept_name = 'São Paulo' and dept_name like 'São%')
group by dept_name;

#---------------------------------------------------------------------#

#11 Total de datas e quantidades distintas
select count(*) Total, count(distinct from_date) De, count(distinct to_date) Para
from dept_manager;

#12 Media salarial
select CAST(AVG(salary) AS DECIMAL (9,2)) AS MediaSalarial
from salaries;

#13 SubQuery
SELECT c.Posicao, c.dept_name,c.to_date
FROM 
(SELECT ROW_NUMBER() OVER( PARTITION BY A.dept_name ORDER BY B.to_date ) Posicao, A.dept_name, b.to_date
FROM departments AS A
INNER JOIN dept_manager AS B
ON A.dept_no = B.dept_no
) AS C;

#14 CTE
WITH ConsultaCTE(first_name, last_name, salary, Quantidade)
AS (SELECT A.first_name, A.last_name, B.salary,
	ROW_NUMBER() OVER( PARTITION BY A.first_name ORDER BY B.salary) Quantidade
	FROM employees AS A
	INNER JOIN salaries AS B
	ON a.emp_no = b.emp_no) 
select *
from ConsultaCTE 
where Quantidade > 0;

#15 Titulos entre A e Z
select *
from titles
where title between 'A' and 'Z'
order by title;

#16 FULL join feito com left join e right join
SELECT A.emp_no, A.first_name, A.last_name, A.birth_date, A.gender, C.salary, A.hire_date, C.from_date, C.to_date
FROM employees A
LEFT JOIN salaries B
ON a.emp_no = b.emp_no
RIGHT JOIN salaries C	
ON C.emp_no = a.emp_no
ORDER BY first_name;

#17 Union
SELECT *
FROM dept_manager
UNION
SELECT *
FROM titles;

#18 DDL - ALTER
ALTER TABLE departments
ADD exemplo_alter varchar(30);
SELECT * FROM departments;

#19 Empregados contratados a partir de 2015
SELECT *
FROM employees 
where  year(hire_date) between '2015' and '2019'
order by birth_date;

#20 INNER JOIN em 3 tabelas
SELECT a.emp_no, b.first_name, b.last_name, c.title, a.salary
FROM salaries a
INNER JOIN employees b
ON a.emp_no = b.emp_no
INNER JOIN titles c
ON a.emp_no = c.emp_no
WHERE A.emp_no IN(1,2,3,4);

#----------------------------------------------------------------------------------#

#21 Exibir a quantidade de employees do sexo Feminino.
SELECT COUNT(DISTINCT emp_no) as "Quantidade de empregados do sexo Feminino:" FROM employees
WHERE gender = 'F';

#22 Mostra o Departamento mais recente.
SELECT * FROM dept_emp
WHERE from_date =
(SELECT max(from_date) FROM dept_emp);

#23 Exibir dados do Funcionário que esteja com o salário acima da média
SELECT * FROM salaries 
INNER JOIN employees
ON salaries.emp_no = employees.emp_no
WHERE salary >=(SELECT avg(salary) FROM salaries)
order by salary desc;

#24 Exibir Departamendo e nome dos Funcionários
SELECT titles.title as "Departamento do funcionário", 
       employees.first_name as "Nome do funcionário", 
       employees.last_name as "Sobrenome do funcionário"
FROM titles
INNER JOIN employees
ON titles.emp_no = employees.emp_no
order by title asc;

#25 Exibir os Dados de salaries e employees, ordenado pelo maior salário
SELECT * FROM salaries AS S
RIGHT JOIN employees AS E
ON S.emp_no = E.emp_no
order by salary desc;

#26 Exibir dados do Funcionário que esteja com o salário abaixo da média
SELECT * FROM salaries 
LEFT JOIN employees
ON salaries.emp_no = employees.emp_no
WHERE salary <=(SELECT avg(salary) FROM salaries)
order by salary desc;

#27 Mostra o Departamento mais antigo.
SELECT * FROM dept_emp
WHERE from_date =
(SELECT min(from_date) FROM dept_emp);

#28 Mostra os Departamentos com Rio
SELECT dept_name as "Cidade do Departamento"
FROM departments
WHERE dept_name like 'Rio%'
group by dept_name;

#29 Exibir a quantidade de employees do sexo Masculino.
SELECT COUNT(DISTINCT emp_no) as "Quantidade de empregados do sexo Masculino:" FROM employees
WHERE gender = 'M';

#30 Exibir a quantidade de employees cadastrados. */
SELECT COUNT(DISTINCT emp_no) as "Quantidade de employees Cadastrados:" FROM employees;

