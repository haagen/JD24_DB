
-- Skapa en databas som heter CRM.
CREATE DATABASE CRM; 

-- Från IDE (Dbeaver) kan man byta databas
-- genom att använda USE
USE CRM;

-- Tabort tabellen för företag
DROP TABLE IF EXISTS Accounts; 

-- Tabell för företag
CREATE TABLE IF NOT EXISTS Accounts (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	noOfEmployees INT NULL,
	status ENUM('Prospect', 'Customer', 'Churned') 
		NOT NULL DEFAULT 'Prospect'
);

INSERT INTO Accounts (
	name, status
) VALUES (
	'Grit Academy AB', 'Customer'
), (
	'Volvo Cars AB',
	'Prospect'
);

-- Funkar inte eftersom status inte får vara NULL
INSERT INTO Accounts (
	name, status
) VALUES (
	'Ikea Malmö Svågertorp AB',
	NULL
);

-- Skapar IKEA men defaultar status
INSERT INTO Accounts (
	name
) VALUES (
	'Ikea Malmö Svågertorp AB'
);

-- Visa alla Accounts
SELECT * FROM Accounts;

-- Visa hur tabellen ser ut
DESCRIBE Accounts;

-- Tabort tabellen för kontaktpersoner om den
-- finns
DROP TABLE IF EXISTS Contacts;

-- Skapa en tabell för kontaktpersoner
CREATE TABLE IF NOT EXISTS Contacts (
	id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	accountsId BIGINT NOT NULL,
	FOREIGN KEY (accountsId) 
		REFERENCES Accounts (id)
);

-- Visa hur tabellen Contacts ser ut
DESCRIBE Contacts;

-- Skapa en kontakt
INSERT INTO Contacts (
	name, email, accountsId
) VALUES (
	'Martin Haagen',
	'martin.haagen@gritacademy.se',
	1
);

-- Skapa två kontakter på samma gång
INSERT INTO Contacts (
	name, email, accountsId
) VALUES (
	'Ingvar Kamprad',
	'ingvar@ikea.se',
	3
), (
	'Volvo Kalle',
	'volvo.kalle@volvo.se',
	2
); 

-- Fel! Kan inte skapa kontakter till konton
-- som inte finns
INSERT INTO Contacts (
	name, email, accountsId
) VALUES (
	'Martin Felsson',
	'e.post@adress.se',
	99
);

-- Visa alla kontakter
SELECT * FROM Contacts;


