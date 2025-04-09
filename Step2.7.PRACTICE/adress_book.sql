CREATE TABLE contactsneo (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO contactsneo 
    (first_name, last_name, email)
VALUES  
    ("Mike", "Turner", "MikeT@mail.com"),
    ("John", "Smith", "JohnS@mail.com"),
    ("Jenna", "Mason", "JennaM@mail.com")
;

UPDATE contactsneo
SET email = "JoohnSS@mail.com"
WHERE id = 2
;

DELETE FROM contactsneo
WHERE last_name = "Smith"
;

INSERT INTO contactsneo 
(first_name, last_name, email)
VALUES  ("John", "Smith", "JSmith@mail.com")
;

ALTER TABLE contactsneo
ADD phone_number TEXT DEFAULT NULL
;

UPDATE contactsneo
    SET phone_number = "555-865-497"
    WHERE first_name = "Mike" AND last_name = "Turner"
;

UPDATE contactsneo
    SET phone_number = "555-791-538"
    WHERE first_name = "Jenna" AND last_name = "Mason"
;

UPDATE contactsneo
    SET phone_number = "555-476-157"
    WHERE first_name = "John" AND last_name = "Smith"
;
