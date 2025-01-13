SHOW DATABASES;
USE CRM;
SHOW TABLES;



-- Här använder vi en nästlad SQL-fråga för att hämta alla företag
-- som har kontakter vars email slutar på gritacademy.se
SELECT name FROM Accounts WHERE Id IN (
  SELECT accountsId FROM Contacts WHERE email LIKE '%@gritacademy.se'
);

-- Här listar vi alla kontakter och vad företaget heter som de jobbar på
SELECT 
	name, 
	-- accountsId,
	(SELECT name FROM Accounts WHERE id = accountsId) AS accountName
FROM 
	Contacts 
WHERE email LIKE '%@gritacademy.se';

SELECT * FROM Contacts;

-- Uppdatera namn och epost på kontakten som har id 4
UPDATE Contacts SET
	name = 'Kalle \'Volvo\' Nilsson',
	email = 'kalle.nilsson@volvo.se' 
WHERE 
	id = 4;

SELECT * FROM Accounts;

-- Hur många kontakter finns det som tillhör kontot med id 1 ? 
SELECT COUNT(id) FROM Contacts WHERE accountsId = 1;

-- Uppdatera alla konton. Sätt deras noOfEmployees till 
-- samma som antalet kontakter
UPDATE Accounts SET 
	noOfEmployees = (
		SELECT COUNT(id) 
		FROM Contacts WHERE 
		accountsId = Accounts.id
	)
-- WHERE id = 2	   -- Här uppdaterar vi bara noOfEmployees på account 2
;

-- Skapa en ny kontakt
INSERT INTO Contacts (name, email, accountsId) VALUES
('Stina Andersson', 'stina.andresson@volvo.se', 4);

-- Uppdatera kontakten som vi precis skapade
UPDATE Contacts SET accountsId = 2 WHERE id = 9;

-- Skapa ytterligare en kontakt, nu med ett nytt
-- sätt att skriva inserts på
INSERT INTO Contacts SET
	name = 'Åsa Nilsson',
	email = 'asa.nilsson@banken.se',
	accountsId = 4;

-- Vilket Id har Åsa?
SELECT id FROM Contacts 
WHERE name = 'Åsa Nilsson';

-- Vilket Id hade den senast skapade recorden (Åsa)
SELECT LAST_INSERT_ID();

-- Radera Åsa från databasen 
DELETE FROM Contacts WHERE id = 11;

-- Radera alla kontakter som arbetar på ett företag
-- som heter Volvo
DELETE FROM Contacts WHERE accountsId IN (
	SELECT id FROM Accounts 
	WHERE name = 'Volvo'
);

USE CRM2;


SELECT * FROM Contacts;
-- DELETE FROM Accounts WHERE id = 2;
-- DELETE FROM Contacts WHERE accountsId = 2;

-- Radera alla kontakter som tillhör ett företag som heter Google
DELETE FROM Contacts WHERE accountsId IN (
	SELECT id FROM Accounts WHERE name = 'Google'
);

-- Radera alla kontakter
DELETE FROM Contacts;

-- Här startar vi en transaktion 
START TRANSACTION;
-- Radera alla konton
DELETE FROM Accounts WHERE 1 = 1;
-- Kolla att alla konton var raderade
SELECT * FROM Accounts;
-- Lägg till ett konto
INSERT INTO Accounts (name) VALUES ('Sveriges Fotbollsförbund');
-- Om vi gör en rollback kommer databasen tillbaka till
-- läget den var när vi skapade vår transaktion
ROLLBACK;
-- Om vi gör en commit kommer våra förändring sedan att
-- vi startade vår transaktion att sparas till disk/databasen
COMMIT;

