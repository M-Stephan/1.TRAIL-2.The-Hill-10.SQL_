CREATE TABLE contacts (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO contacts 
(first_name, last_name, email)
VALUES  ("Mike", "Turner", "MikeT@mail.com"),
        ("John", "Smith", "JohnS@mail.com"),
        ("Jenna", "Mason", "JennaM@mail.com")
;

UPDATE contacts
SET email = "JoohnSS@mail.com"
WHERE id = 2
;

DELETE FROM contacts
WHERE last_name = "Smith"
;

INSERT INTO contacts 
(first_name, last_name, email)
VALUES  ("John", "Smith", "JSmith@mail.com")
;

ALTER TABLE contacts
ADD phone_number TEXT DEFAULT NULL
;

UPDATE contacts
SET phone_number = "555-865-497"
WHERE first_name = "Mike" AND last_name = "Turner";

UPDATE contacts
SET phone_number = "555-791-538"
WHERE first_name = "Jenna" AND last_name = "Mason";

UPDATE contacts
SET phone_number = "555-476-157"
WHERE first_name = "John" AND last_name = "Smith";
