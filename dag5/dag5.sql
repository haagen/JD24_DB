USE CRM;

CREATE DATABASE Relationer;
USE Relationer;

-- En-till-en relation (kan göras i en eller flera tabeller)
CREATE TABLE Persons (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE
);

-- En-till-många relation
-- En-till-många till Persons (Persons är förälder och Blogs är barn)
CREATE TABLE Blogs (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	subject VARCHAR(255) NOT NULL, 
	body TEXT NOT NULL, 
	personsId BIGINT NOT NULL, 		-- en-till-många
	FOREIGN KEY (personsId) REFERENCES Persons(id) -- en-till-många
);

-- En-till-många relation
-- Blogs är förälder och Commets är barn
CREATE TABLE Comments (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	comment VARCHAR(255) NOT NULL, 
	blogsId BIGINT NOT NULL, 
	FOREIGN KEY (blogsId) REFERENCES Blogs(id)
);


-- Flera Order kan ha flera Produkter

-- många-till-många
CREATE TABLE Orders (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	orderNumber VARCHAR(30) NOT NULL UNIQUE, 
	total FLOAT NOT NULL DEFAULT 0
);

-- många-till-många
CREATE TABLE Products (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(25) NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
);

-- många-till-många
CREATE TABLE OrdersProducts (
	ordersId BIGINT NOT NULL, 
	productsId INT NOT NULL,
	qty INT NOT NULL DEFAULT 0, 
	FOREIGN KEY (ordersId) REFERENCES Orders(id),
	FOREIGN KEY (productsId) REFERENCES Products(id),
	PRIMARY KEY (ordersId, productsId) -- orderId och productId är primär nyckel tillsammans
);


USE CRM; 

SHOW TABLES;
DESCRIBE Contacts;

SELECT * FROM Accounts;
SELECT * FROM Contacts; 

INSERT INTO Accounts (name, status) VALUES ('Korvbrödsbagaren', 'Customer');

SELECT
	a.name AS AccountName,
	c.name AS ContactName
FROM
	Accounts a
LEFT JOIN Contacts c ON a.id = c.accountsId
-- WHERE a.noOfEmployees > 1
ORDER BY c.name
;

USE Relationer;
	
SHOW TABLES;

DESCRIBE Orders;
DESCRIBE OrdersProducts;
DESCRIBE Products;

SELECT 
	orderNumber,
	SUM(op.qty*p.price) AS total
FROM 
	Orders o
INNER JOIN OrdersProducts op ON o.id = op.ordersId
INNER JOIN Products p ON op.productsId = p.id
GROUP BY orderNumber	
;	
	
USE CRM;

SELECT id, name, 'accounts' as type FROM Accounts
UNION
SELECT id, name, 'contacts' as type FROM Contacts;
	
	
	
	
	
	
	
	
	
	
	
	




