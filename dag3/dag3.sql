
USE CRM;

SHOW TABLES;

-- Visa hur tabellerna ser ut
DESCRIBE Accounts;
DESCRIBE Contacts;

-- Visa alla kolumner och alla rader
SELECT * FROM Contacts;
SELECT * FROM Accounts;

SELECT name, email FROM Contacts;

-- Hämta alla kontakter från Account 1 
-- som har ett namn som börjar på Sture
SELECT 
	name, 
	email 
FROM 
	Contacts 
WHERE 
	accountsId = 1 AND 
	name LIKE 'Sture%';

-- Hämta accountId för alla kontakter 
-- som har ett namn som innehåller a
SELECT 
	accountsId
FROM 
	Contacts
WHERE
	name LIKE '%a%';
	
-- Hämta id och namn för Accounts för
-- företagen med id 1,2 eller 3.
SELECT 
	id,
	name
FROM 
	Accounts
WHERE 
--	id = 1 OR id = 2 OR id = 3;
--	id >= 1 AND id <= 3;
--	id IN (1, 3, 2);
	id BETWEEN 1 AND 3;
	
-- Hämta alla företags namn för "Customers"
SELECT
	name
FROM
	Accounts
WHERE 
	status = 'Customer';

-- Räkna hur många kontakter det finns
-- för varje företag (id) sortera i 
-- stigande ordning efter noOfEmployees
SELECT 
	accountsId, 
	COUNT(id) AS noOfEmployees 
FROM 
	Contacts
-- WHERE 
--	name LIKE '%a%'
GROUP BY 
	accountsId
ORDER BY
	noOfEmployees ASC;

-- Hur många anställda har företagen i snitt?
SELECT AVG(noOfEmployees) FROM Accounts;

-- Hur många anställda finns det sammanlagt 
-- för alla företag som är "Prospect"?
SELECT 
	SUM(noOfEmployees) 
FROM 
	Accounts 
WHERE
	status = 'Prospect';
	

-- Skapa ett nytt företag 
INSERT INTO 
	Accounts
(	name, noOfEmployees )
VALUES
( 'Sparbanken Finn', 0 );

-- Hämta ut id som generades förra
-- gången ett företag skapades 
SELECT LAST_INSERT_ID();	

-- Skapa en ny kontakt och anslut den till
-- den senast skapade företaget. 
-- Detta kommer bara bli rätt om det var 
-- ett företag som skapades senast.
INSERT INTO Contacts ( 
	name, 
	email, 
	accountsId 
) VALUES ( 
	'Bo Ek', 
	'bo.ek@finn.se', 
	LAST_INSERT_ID()
);
	
-- Samma fråga som tidigare - hämta
-- alla företags id för kontakter 
-- som innehåller bokstaven a 
-- Vi kallar denna fråga för (A)
SELECT 
	accountsId
FROM 
	Contacts
WHERE
	name LIKE '%a%';

-- Samma fråga som tidigare, hämta 
-- id och namn för företagen med ID
-- 1,2 eller 3.
-- Vi kallar denna fråga för (B)
SELECT 
	id,
	name
FROM 
	Accounts
WHERE 
	id IN (1, 3, 2);

-- Vi nästlar fråga A i fråga B. Resultatet
-- från fråga A används automatiskt i fråga
-- B. 
-- Här börjar fråga B
SELECT 
	id, name
FROM 
	Accounts
WHERE 
	id IN (
		-- Detta börjar fråga A:
		SELECT 
			accountsId
		FROM 
			Contacts
		WHERE
			name LIKE '%a%'
		-- Här slutar fråga A
	);
-- Här slutar fråga B
	