CREATE TABLE customers(
customer_number INT,
customer_name VARCHAR(50),
phone VARCHAR(50)
);

CREATE TABLE customers2(
customer_number INT NOT null,
customer_name VARCHAR(50) NOT null,
phone VARCHAR(50) NOT null
);

insert into customers2
	(customer_number,customer_name,phone) 
values
	(1,'이상원','010-1234-5678'),
	(2,'김상원','010-1234-5679'),
	(3,'박상원','010-1234-5679')
;

ALTER TABLE customers RENAME newcustomers;

ALTER TABLE newcustomers add 지역 VARCHAR(50);
ALTER TABLE newcustomers modify 지역 INT;
ALTER TABLE newcustomers change 지역 Region VARCHAR(10);
ALTER TABLE newcustomers drop Region;

SHOW GLOBAL VARIABLES LIKE 'LOCAL_INFILE';

SET GLOBAL LOCAL_INFILE=TRUE;
SHOW GLOBAL VARIABLES LIKE 'LOCAL_INFILE';

SELECT * FROM `newcustomers`;
SELECT customer_name, phone FROM `newcustomers`;

SELECT 이름, 영어, 수학,  영어+수학 AS 영수 FROM `exercise1`;

SELECT * FROM `exercise1` LIMIT 5;
SELECT * FROM `exercise1` LIMIT 5, 8;

SELECT * FROM `exercise1` LIMIT 3 OFFSET 5;

SELECT 수학 FROM exercise1;
SELECT DISTINCT 수학 FROM exercise1;

--

SELECT DISTINCT productline  FROM productlines LIMIT 3, 8;
SELECT DISTINCT productline  FROM productlines LIMIT 8 OFFSET 3;

--
SELECT customerName AS ClientName FROM customers;

-- 주문없는 날 분석 가능
SELECT DISTINCT orderDate FROM orders;

--
SELECT lastname, firstname AS GivenName FROM employees;

--
SELECT DISTINCT productCode FROM orderdetails LIMIT 15;

--
SELECT checkNumber AS Check_ID FROM payments;

-- 
SELECT productname FROM products LIMIT 9, 5;

--
SELECT officeCODE as OfficeID FROM offices;  

--
SELECT productcode, quantityordered as totalordered FROM orderdetails;

--
SELECT DISTINCT customername FROM customers LIMIT 10;

-- 실습
SELECT DISTINCT customername FROM customers;

--
SELECT productname FROM products LIMIT 5;

--
SELECT DISTINCT STATUS FROM orders; 

-- 
SELECT lastname FROM employees LIMIT 10 OFFSET 4;

--
SELECT productvendor AS Vendor FROM products;

-- 
SELECT DISTINCT customernumber FROM orders;

--
SELECT employeenumber AS employee_id FROM employees LIMIT 2,6;

-- 
SELECT DISTINCT country FROM offices;

--
SELECT productcode AS CODE, quantityordered AS quantity FROM orderdetails;

-- 
SELECT DISTINCT checknumber FROM payments LIMIT 10;


--
SELECT * 
FROM orderdetails WHERE orderlinenumber = 1;

SELECT * 
FROM orderdetails 
WHERE productcode = 's24_3969';

SELECT * 
FROM orderdetails 
WHERE quantityordered > 70;

SELECT * 
FROM orderdetails 
WHERE quantityordered >= 70;

-- 문제1
SELECT customerName 
FROM customers 
WHERE creditLimit > 10000;

--
SELECT *
FROM orderdetails
WHERE quantityordered = 46
AND productcode = 's24_3969';

SELECT *
FROM orderdetails
WHERE quantityordered = 46
or productcode = 's24_3969';

SELECT *
FROM orderdetails
WHERE priceEach = 35.29
and productcode = 's24_3969'
OR quantityordered = 46;

SELECT *
FROM orderdetails
WHERE (priceEach = 35.29
and productcode = 's24_3969')
OR quantityordered = 46;

SELECT *
FROM orderdetails
WHERE priceEach = 35.29
AND (productcode = 's24_3969'
OR quantityordered = 46);

-- 문제2
SELECT orderNumber AS orno
FROM orders
WHERE STATUS = 'Shipped'
OR STATUS = 'In Process';

--
SELECT productName AS PN
FROM products
WHERE quantityInStock < 100 
OR quantityInStock > 500; 

--
SELECT productName AS PN
FROM products
WHERE quantityInStock < 100 
and buyPrice > 50;

-- like
SELECT DISTINCT productline FROM products;

SELECT * 
FROM products
WHERE productline = 'vintage cars' OR productline = 'classic cars';

SELECT * 
FROM products
WHERE productline LIKE '%cars';

-- 문제5
SELECT firstName, lastName 
FROM employees
WHERE jobTitle LIKE '%Sales%';

--
SELECT *
FROM orders
WHERE orderdate BETWEEN '2003-01-01' AND '2003-01-31';

-- 문제6
SELECT orderNumber AS orno
FROM orderdetails
WHERE quantityordered BETWEEN 10 AND 50;

--
SELECT *
FROM orders
WHERE orderdate not BETWEEN '2003-01-01' AND '2003-01-31';

SELECT *
FROM orders
WHERE orderdate IN ('2003-02-11', '2003-02-17');

-- 문제7
SELECT customerName
FROM customers
WHERE country IN ('USA', 'Canada', 'France');

SELECT *
FROM employees
WHERE officecode not IN (1,2,3);

SELECT *
FROM employees
WHERE officecode <> 1 and officecode <> 2 AND officecode <> 3;

--
SELECT * 
FROM orders 
WHERE comments IS NOT NULL;

-- 문제8
SELECT firstName, lastName
from employees
WHERE reportsTo IS NULL;

--
SELECT Lastname, firstname, officecode
FROM employees
ORDER BY officecode
LIMIT 5;

SELECT Lastname, firstname, officecode
FROM employees
ORDER BY officecode desc
LIMIT 5;

-- 문제 9
SELECT productname AS pn
FROM products
order by buyprice DESC; 

--
SELECT productline, COUNT(productline)
FROM products
GROUP BY productline;

SELECT productline, avg(buyprice)
FROM products
GROUP BY productline;

SELECT productcode, sum(quantityordered)
FROM orderdetails
WHERE orderlinenumber = 1
GROUP BY productcode;

SELECT productline, MAX(msrp)
FROM products
group BY productline;

-- 문제10
SELECT * FROM orders;

SELECT STATUS, COUNT(ordernumber) AS ordercount
FROM orders
group by STATUS;

-- 문제 11
SELECT productcode, SUM(quantityordered) AS totalordered
FROM orderdetails
GROUP BY productcode;

-- 문제12
SELECT * FROM products;

# primary key인 productcode로 세는 것이 바람직.
SELECT productline, COUNT(productcode) AS productcount
FROM products
GROUP BY productline;

-- 문제13
SELECT productline, MAX(buyprice) AS maxprice, MIN(buyprice) AS minprice
FROM products
GROUP BY productline;

-- 문제 14
SELECT * FROM customers;

SELECT city, AVG(creditlimit) AS avgcl
FROM customers
GROUP BY city
ORDER BY avgcl desc
LIMIT 5;

-- 문제 15
SELECT ordernumber, SUM(priceeach * quantityordered) AS totalrevenue
FROM orderdetails
GROUP BY ordernumber
ORDER BY totalrevenue desc
LIMIT 5;

-- 문제 16
SELECT country, COUNT(customernumber) AS noc
FROM customers
GROUP BY country
ORDER BY noc DESC
LIMIT 5;

-- 문제 17
SELECT productline, AVG(buyprice) AS avgp 
FROM products
WHERE productscale = '1:10'
GROUP BY productline;

-- 예제 1
SELECT city, AVG(creditlimit) AS avgcl
FROM customers
WHERE country IN ('USA', 'Canada', 'France')
GROUP BY city;

-- 예제2
SELECT productline, AVG(buyprice) AS abp
FROM products
WHERE productline NOT IN ('ships','trains')
group by productline;

-- 예제3
SELECT STATUS, COUNT(ordernumber) AS totalorder
FROM orders
WHERE orderdate BETWEEN '2003-01-01' AND '2005-12-31'
GROUP BY STATUS;

# 모범
SELECT STATUS, COUNT(ordernumber) AS totalorder
FROM orders
WHERE year(orderdate) BETWEEN 2003 AND 2005
GROUP BY STATUS;

-- 예제4
SELECT officecode, COUNT(employeenumber) AS no_worker
FROM employees
WHERE reportsto IS NOT NULL
GROUP BY officecode;

-- 예제5
SELECT productcode, avg(priceeach) AS avg_price
FROM orderdetails
WHERE quantityordered BETWEEN 30 AND 50
group BY productcode; 

-- 예제6
SELECT productline, AVG(quantityinstock) AS avgstock
FROM products
WHERE productline IN ('ships', 'trains')
GROUP BY productline;

-- 예제7
SELECT STATUS, COUNT(ordernumber) AS no_order
FROM orders
WHERE COMMENTs IS NULL
GROUP BY STATUS;

-- 예제8
SELECT productcode, AVG(quantityordered) AS avg_order
FROM orderdetails
WHERE priceeach BETWEEN 50 AND 100
GROUP BY productcode;

-- 예제9
SELECT country, AVG(creditlimit) AS avgcl 
FROM customers
WHERE country NOT IN ('usa', 'canada')
GROUP BY country;

-- 예제10
SELECT officecode, COUNT(employeenumber) AS NO_worker
FROM employees
WHERE reportsto IS null
group BY officecode;

--
SELECT productline, COUNT(productline)
FROM products
GROUP BY productline
HAVING COUNT(productline) > 20;

SELECT productline, avg(buyprice) AS bp
FROM products
GROUP BY productline
HAVING bp <= 50;

SELECT productcode, sum(quantityordered) AS QO
FROM orderdetails
WHERE orderlinenumber = 1
GROUP BY productcode
HAVING productcode LIKE 'S12%';

SELECT productline, MAX(msrp)
FROM products
GROUP BY productline
HAVING productline = 'planes';

-- 문제1
SELECT year(orderdate) AS orderyear, COUNT(ordernumber) AS totalorders
FROM orders
group by orderyear 
HAVING totalorders > 100;

-- having 문제2 
SELECT productcode, sum(quantityordered) AS totalquan
FROM orderdetails
GROUP BY productcode
HAVING totalquan >= 500
LIMIT 7;

-- 
SELECT customernumber, SUM(amount) AS sa
FROM payments
GROUP BY customernumber
HAVING sa >= 150000;

-- 문제4
SELECT country, count(customernumber) AS cn
FROM customers
GROUP by country
HAVING cn >= 10
ORDER BY cn DESC;

--
SELECT checknumber, amount, if(amount > 50000, 'L', 'S') AS size
FROM payments;

-- 문제5
SELECT productname, if(buyprice > 100, 'expensive', 'cheap') AS category
FROM products;

--
SELECT productname, buyprice, 
	case 
		when buyprice < 20 then 'cheap'
		when buyprice BETWEEN 20 AND 50 then 'moderate'
		ELSE 'expensive'
	END AS category
FROM products; 

-- 문제6
SELECT firstname, lastname, jobtitle,
	case jobtitle
		when 'sales rep' then 'sales team'
		when 'VP sales' then 'management'
		when 'VP marketing' then 'management'
		ELSE 'other'
	END AS 'position'
FROM employees
ORDER BY POSITION;

--
CREATE TABLE ex3(
	`id` TINYINT,
	`name` varchar(10),
	`age` TINYINT);
	
INSERT INTO ex3 (id, `NAME`, age) 
VALUES 
	(1, '홍길동', 10),
	(2, '손흥민', 20),
	(3, '차범근', 30);
	
CREATE TABLE ex4(
	`id` TINYINT,
	`region` varchar(10));
	
INSERT INTO ex4 (id, `region`) 
VALUES 
	(1, '포항'),
	(4, '춘천'),
	(5, '서울');
	
-- inner
SELECT * FROM ex3 JOIN ex4 ON ex3.id = ex4.id;

-- left
SELECT * FROM ex3 LEFT JOIN ex4 ON ex3.id = ex4.id;

SELECT * 
FROM ex3 LEFT JOIN ex4 ON ex3.id = ex4.id
WHERE ex4.id IS null;

-- right 
SELECT * 
FROM ex3 RIGHT JOIN ex4 ON ex3.id = ex4.id;

SELECT * 
FROM ex3 RIGHT JOIN ex4 ON ex3.id = ex4.id
WHERE ex3.id IS NULL;

-- UNION
SELECT id FROM ex3  
UNION 
SELECT id FROM ex4;

SELECT id FROM ex3  
UNION all
SELECT id FROM ex4;

-- full outer
SELECT ex3.id, ex3.name, ex3.age, ex4.id, ex4.region
FROM ex3 LEFT JOIN ex4 ON ex3.id = ex4.id
UNION
SELECT ex3.id, ex3.name, ex3.age, ex4.id, ex4.region
FROM ex3 RIGHT JOIN ex4 ON ex3.id = ex4.id
WHERE ex3.id IS NULL;

-- 문제7
SELECT customers.customername, orders.ordernumber
FROM customers 
JOIN orders ON customers.customerNumber = orders.customernumber;

-- 문제8
SELECT products.productname, orderdetails.quantityordered
FROM products JOIN orderdetails ON products.productcode = orderdetails.productcode;

-- 문제9 
SELECT c.customername 
FROM employees e 
JOIN customers c ON e.employeenumber = c.salesrepemployeenumber
WHERE e.firstname = 'Leslie';

-- 문제10
SELECT e.firstname, e.lastname
FROM employees e
JOIN offices o ON e.officeCode = o.officecode
WHERE o.city = 'san francisco'
ORDER BY firstname;

-- 문제11 변형
SELECT p.productcode, p.productname, o.priceeach, p.buyprice, o.quantityordered   
FROM products p
JOIN orderdetails o ON p.productcode = o.productcode
WHERE o.priceeach >= 2.5 * p.buyprice;

-- 문제12
SELECT c.customername, o.ordernumber
FROM customers c
JOIN orders o ON c.customernumber = o.customerNumber
WHERE YEAR(o.orderdate) = 2003;

-- 문제13
SELECT c.customername, p.amount
FROM customers c
JOIN payments p ON c.customernumber = p.customerNumber
WHERE YEAR(p.paymentdate) = 2004;

-- 문제14
SELECT concat(e.firstname, ' ', e.lastname) AS employee, COUNT(c.customernumber) AS no_cus
FROM employees e
JOIN customers c ON e.employeenumber = c.salesrepemployeeNumber
GROUP BY e.employeenumber;

-- 문제15 2개 join 후 다시 join
SELECT p.productname, od.quantityordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.ordernumber = o.orderNumber
WHERE YEAR(o.orderdate) = 2003;

-- 문제 16
SELECT c.customername, sum(od.priceeach * od.quantityordered) AS totalrevenue
FROM customers c
JOIN orders o on c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.ordernumber = od.orderNumber
GROUP BY c.customernumber
ORDER BY totalrevenue DESC
LIMIT 5;

-- 문제17

SELECT CONCAT(e.firstname, ' ', e.lastname) AS NAME, SUM(p.amount)
FROM employees e
JOIN customers c ON e.employeenumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber;

-- 문제 18
SELECT pl.productline, SUM(o.quantityordered) AS totalquan
FROM productlines pl
JOIN products p ON pl.productline = p.productline
JOIN orderdetails o ON p.productcode = o.productCode
GROUP BY pl.productLine;

-- 문제 19
SELECT p.productname, sum(od.quantityordered) AS totalquan
FROM products p
JOIN orderdetails od ON p.productcode = od.productcode
JOIN orders o ON od.ordernumber = o.ordernumber
WHERE YEAR(o.orderdate) = 2004
group BY p.productcode 
ORDER BY totalquan desc
LIMIT 5;

--
# window 특정 구간, 특정 기간이라고 생각.
# partition by 생략 가능

# 누적합
SELECT customernumber, paymentdate, amount,
SUM(amount) OVER(PARTITION BY customernumber 
ORDER BY paymentdate) AS total_amount
FROM payments; 

# paymentdate를 오름차순으로 정렬하고 amount를 더함.

--
SELECT customernumber, paymentdate, amount,
SUM(amount) OVER(PARTITION BY customernumber) AS total_amount
FROM payments; 

# 전부 한꺼번에 더해버림

--
SELECT customernumber, paymentdate, amount,
SUM(amount) OVER(ORDER BY paymentdate) AS total_amount
FROM payments; 

# 구분없이 일별로 다 더함.

--
SELECT customernumber, paymentdate, amount,
SUM(amount) OVER() AS total_amount
FROM payments; 

# 전체 합을 구해버림

-- 문제 20 group by로 하면 ordernumber 값 하나씩 남음 10,100
SELECT ordernumber AS orno, productcode AS proco, 
AVG(quantityordered) OVER(PARTITION BY ordernumber) AS avgquan
FROM orderdetails;

-- 문제21 o로 하면 컬럼명 리스트가 나와서 코딩이 편함.
SELECT o.customernumber, o.ordernumber, o.orderdate,
COUNT(o.ordernumber) OVER(PARTITION BY o.customernumber ORDER BY o.orderdate) AS cnt_od  
FROM orders o;

# LEAD 증가분을 보고 싶을 때
SELECT o.orderNumber, o.customerNumber, o.orderDate,
LAG(o.orderDate) OVER(PARTITION BY o.customernumber ORDER BY o.orderDate) AS prev_date,
LEAD(o.orderDate) OVER(PARTITION BY o.customernumber ORDER BY o.orderDate) AS next_date
FROM orders o;

--
SELECT o.orderNumber, o.customerNumber, o.orderDate,
LAG(o.orderDate) OVER(ORDER BY o.orderDate) AS prev_date,
LEAD(o.orderDate) OVER(ORDER BY o.orderDate) AS next_date
FROM orders o;

# 전체 데이터 기준 이전, 다음 거래 출력

--
SELECT o.orderNumber, o.customerNumber, o.orderDate,
LAG(o.orderDate) OVER(PARTITION BY o.customernumber) AS prev_date,
LEAD(o.orderDate) OVER(PARTITION BY o.customernumber) AS next_date
FROM orders o;

--
SELECT o.orderNumber, o.customerNumber, o.orderDate,
LAG(o.orderDate) OVER() AS prev_date,
LEAD(o.orderDate) OVER() AS next_date
FROM orders o;

-- 문제22 증분계산
SELECT o.orderNumber, o.productCode, o.quantityOrdered,
o.quantityOrdered - LAG(o.quantityOrdered) OVER(PARTITION BY o.productCode ORDER BY o.ordernumber) AS diff
FROM orderdetails o;

SELECT o.orderNumber, o.productCode, o.quantityOrdered,
LEAD(o.quantityOrdered) OVER(PARTITION BY o.productCode ORDER BY o.ordernumber) - o.quantityOrdered AS diff
FROM orderdetails o;

-- 순위 asc -> desc
SELECT c.customerName, c.creditLimit,
row_number() OVER(ORDER BY c.creditLimit) AS row_num,
RANK() OVER(ORDER BY c.creditLimit) AS rank_,
DENSE_RANK() OVER(ORDER BY c.creditLimit) AS dense_num
FROM customers c;

SELECT c.customerName, c.creditLimit,
row_number() OVER(ORDER BY c.creditLimit desc) AS row_num,
RANK() OVER(ORDER BY c.creditLimit desc) AS rank_,
DENSE_RANK() OVER(ORDER BY c.creditLimit desc) AS dense_num
FROM customers c
ORDER BY c.creditLimit desc;

-- 문제 23
# 정답 1
SELECT p.productLine, p.productName, p.buyPrice,
FIRST_VALUE(p.productName) OVER(PARTITION BY p.productLine ORDER BY p.buyPrice) AS cheapest,
FIRST_VALUE(p.productName) OVER(PARTITION BY p.productLine ORDER BY p.buyPrice desc) AS expensive
FROM products p; 

# 정답 2
SELECT p.productLine, p.productName, p.buyPrice,
FIRST_VALUE(p.productName) OVER(PARTITION BY p.productLine ORDER BY p.buyPrice) AS cheapest,
last_VALUE(p.productName) OVER(PARTITION BY p.productLine ORDER BY p.buyPrice ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED following) AS expensive
FROM products p
ORDER BY p.productLine, p.buyPrice DESC; 

--
SELECT orderNumber, productCode, quantityOrdered,
AVG(quantityOrdered) OVER (ORDER BY orderNumber ROWS BETWEEN 1
PRECEDING AND 1 FOLLOWING) AS moving_avg_quantity_1,
AVG(quantityOrdered) OVER (ORDER BY orderNumber ROWS BETWEEN 
CURRENT ROW AND 1 FOLLOWING) AS moving_avg_quantity_2,
AVG(quantityOrdered) OVER (ORDER BY orderNumber ROWS BETWEEN 1
PRECEDING AND CURRENT ROW) AS moving_avg_quantity_3,
AVG(quantityOrdered) OVER (ORDER BY orderNumber RANGE BETWEEN 1
PRECEDING AND 1 FOLLOWING) AS moving_avg_quantity_4
FROM orderdetails;

-- 문제 24 누적합인데...

/*
SELECT e.employeeNumber, e.firstName, e.lastName, count(c.customerNumber) AS cus_cnt, 
LAG(count(c.customerNumber)) OVER(PARTITION BY e.employeeNumber)
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber;


SELECT e.employeeNumber, e.firstName, e.lastName, 
count(c.customerNumber) AS cus_cnt,
lead(count(c.customerNumber)) OVER(order BY e.employeeNumber) + count(c.customerNumber)
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber;
*/

SELECT distinct e.employeeNumber, e.firstName, e.lastName, 
COUNT(c.customernumber) OVER(PARTITION BY e.employeenumber) AS cumul
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
;

SELECT o.customernumber, o.ordernumber, o.orderdate,
COUNT(o.ordernumber) OVER(PARTITION BY o.customernumber ORDER BY o.orderdate) AS cnt_od  
FROM orders o;



# 4과목 실습 영상
-- 문제1
SELECT e.employeeNumber, e.firstName, e.lastName, count(c.customerNumber) AS cnt_cn
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
HAVING cnt_cn >= 5
ORDER BY cnt_cn DESC;

-- 문제 2
SELECT p.productLine, AVG(p.buyPrice) AS avg_pr 
FROM products p
GROUP BY p.productLine
HAVING avg_pr >= 50;

-- 문제3
SELECT p.productName, SUM(o.quantityOrdered) AS total_od
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
GROUP BY p.productcode
HAVING total_od >= 1000;

-- 문제4
SELECT YEAR(o.orderDate) AS year_, COUNT(o.orderNumber) AS od_no
FROM orders o
GROUP BY YEAR(o.orderdate)
HAVING od_no >= 100;

-- 문제5
SELECT c.country, COUNT(c.customerNumber) AS no_cus
FROM customers c
GROUP BY c.country
HAVING no_cus >= 5;

-- 문제6
SELECT c.customerName, MAX(o.orderDate) AS latest
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber;

-- 문제7
SELECT p.productLine, MAX(p.buyPrice), MIN(p.buyPrice), MAX(p.buyPrice)-MIN(p.buyPrice) AS diff
FROM products p
GROUP BY p.productLine
ORDER BY diff DESC;

-- 문제8
SELECT p.productCode, p.productName, sum(od.quantityOrdered) AS amount
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE YEAR(o.orderDate) = 2004
GROUP BY p.productCode, p.productName
ORDER BY amount DESC
LIMIT 1;

-- 문제9
SELECT e.employeeNumber, AVG(c.creditLimit) AS avg_limit
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
HAVING avg_limit > 50000;

SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS ename, AVG(c.creditLimit) AS avg_limit
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
HAVING avg_limit > 50000;

-- 서브쿼리
# 가상의 테이블 생성

SELECT productName, buyPrice
FROM products
WHERE buyPrice > 
(SELECT AVG(buyPrice) FROM products);

--
SELECT customernumber, ordercount
FROM (SELECT customernumber, COUNT(ordernumber) AS ordercount
FROM orders 
GROUP BY customernumber) AS subquery
WHERE ordercount>= 5;

-- 문제1
# 풀이1
SELECT customernumber 
FROM orders
GROUP BY customernumber
HAVING COUNT(ordernumber) = 
	(SELECT MAX(ordercount)
	FROM (select COUNT(ordernumber) AS ordercount 
	FROM orders 
	GROUP BY customernumber) AS sq); 
	
# 풀이2
SELECT customernumber
FROM (
	SELECT customernumber, COUNT(ordernumber) AS ordercount
	FROM orders 
	GROUP BY customernumber
	ORDER BY ordercount DESC
	LIMIT 1) AS sq;
	
-- 문제2
# 풀이1
SELECT productcode, productname, amount
FROM (
	SELECT p.productCode, p.productName, SUM(o.priceEach * o.quantityOrdered) AS amount  
	FROM products p
	JOIN orderdetails o ON p.productCode = o.productCode
	GROUP BY p.productCode) AS sq
ORDER BY amount DESC
LIMIT 5;	

# 풀이2
SELECT p.productCode, p.productName, SUM(o.priceEach * o.quantityOrdered) AS amount  
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
GROUP BY p.productCode
ORDER BY amount desc
LIMIT 5;

--
SELECT c.customername, o.orderdate
FROM customers c, orders o
WHERE c.customerNumber = o.customerNumber; # join과 동일 	

	SELECT c.customerNumber, c.customername, o.orderdate
	FROM customers c, orders o
	WHERE c.customerNumber = o.customerNumber 
	AND o.orderDate = 
		(SELECT MAX(orderdate) FROM orders WHERE customernumber = c.customerNumber); # 참조 가능
	
-- 문제3
SELECT customername
FROM customers
WHERE customernumber IN (
	SELECT customernumber FROM orders 
	WHERE YEAR(orderdate) = 2003);
	
SELECT customernumber FROM orders 
WHERE YEAR(orderdate) = 2003;

-- CTE
# group by로 나타낼 수 있는 이외의 데이터를 볼 떄 가상의 테이블을 만들어 조인하여 사용
WITH latestorders AS(
	SELECT customernumber, MAX(orderdate) AS maxod
	FROM orders
	GROUP BY customernumber)
SELECT o.ordernumber, o.customerNumber, o.orderDate
FROM orders o
JOIN latestorders lo ON o.customerNumber = lo.customernumber
	AND o.orderDate = lo.maxod; 

-- 문제5
WITH avgtable AS(
	SELECT productline, AVG(buyprice) AS avgpr
	FROM products
	GROUP BY productline)
SELECT p.productName, p.productLine, p.buyPrice, a.avgpr
FROM products p
JOIN avgtable a ON p.productLine = a.productline
WHERE p.buyPrice > a.avgpr; 

# 서브쿼리보다 가독성 높음.

-- 문제6
# 풀이1
WITH pdtable AS (
	SELECT productline, AVG(buyprice) AS avgpr
	FROM products
	group by productline),
total AS (
	SELECT AVG(buyprice) AS totavgpr
	FROM products)
SELECT p.productline, p.avgpr, t.totavgpr  
FROM pdtable p, total t
WHERE p.avgpr > t.totavgpr;

# 같은 키가 없을 때 join하는 방법

# 풀이2 - 서브쿼리
SELECT p.productLine, AVG(p.buyPrice) AS avgpr, (SELECT AVG(buyprice) FROM products) AS totavgpr
FROM products p 
GROUP BY p.productline
HAVING avgpr > totavgpr;

# SELECT AVG(buyprice) FROM products;

-- 문제7 
# 풀이1
WITH avgtable AS(
	SELECT salesrepemployeenumber, AVG(creditlimit) AS avglimit
	FROM customers
	GROUP BY salesrepemployeenumber)
SELECT e.employeenumber, e.firstName, e.lastname, a.avglimit
FROM employees e
JOIN avgtable a ON e.employeenumber = a.salesrepemployeenumber
WHERE avglimit >= 100000;

# 직원 이름과 고객정보를 모두 구하기 위해 join 필요

# 풀이2 - 서브쿼리
SELECT e.employeenumber, e.firstName, e.lastName, av.avglimit
FROM employees e
JOIN (SELECT salesrepemployeenumber, AVG(creditlimit) AS avglimit
		FROM customers
		GROUP BY salesrepemployeenumber) av 
ON e.employeeNumber = av.salesrepemployeenumber
WHERE av.avglimit >= 100000;

# 테이블 서브쿼리 별칭 필요

# 풀이3 - join
SELECT e.employeeNumber, e.firstName, e.lastName, AVG(c.creditLimit) AS avglimit
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
HAVING avglimit >= 100000;

