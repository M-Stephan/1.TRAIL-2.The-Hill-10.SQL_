/* Crée la table books avec les colonnes "book_id, title, author, publication_year, available, created_at" */
CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publication_year INTEGER NOT NULL,
    genre VARCHAR(50) DEFAULT "Unknown",
    available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* Insère Les nouveaux livres et leurs informations */
INSERT INTO books
    (title, author, publication_year, genre, available)
    VALUES  ("Et vive l'Aspidistra ! ", "George Orwell", 1936, "Fiction", TRUE),
            ("L'Île mystérieuse", "Jules Verne", 1874, "Science-fiction", TRUE),
            ("1984", "George Orwell", 1949, "Dystopian Fiction", FALSE),
            ("Le Meilleur des mondes", "Aldous Huxley", 1932, "Dystopian Fiction", TRUE),
            ("Les Misérables", "Victor Hugo", 1862, "Historical Fiction", TRUE),
            ("L'Étranger", "Albert Camus", 1942, "Philosophical Fiction", FALSE)
;

/* Tourne la disponibilité du livre sur "FALSE" */
UPDATE books
    SET available = FALSE
    WHERE author = "George Orwell" AND title  = "Et vive l'Aspidistra ! "
;

/* Supprime le livre "L'Île mystérieuse" de la bibliothèque */
DELETE FROM books
    WHERE publication_year < 1900
;

/* Ajoute un livre "L'Île mystérieuse" de Jules Verne à la bibliothèque avec une nouvelle date de publication*/
INSERT INTO books
    (title, author, publication_year, genre, available)
    VALUES  ("L'Île mystérieuse", "Jules Verne", 1905, "Science-fiction", TRUE)
;

/* Ajoute une colonne price de type decimal avec 5 chiffres avant la virgules et 2 chiffres après la virgule */
ALTER TABLE books
    ADD price DECIMAL(5, 2) DEFAULT NULL
;

/* Met à jour le prix de chaque livre dans la bibliothèque */
UPDATE books
    SET price = 19.50
    WHERE title = "Et vive l'Aspidistra ! "
;
UPDATE books
    SET price = 15.15
    WHERE title = "L'Île mystérieuse"
;

UPDATE books
    SET price = 12.65
    WHERE title = "1984"
;

UPDATE books
    SET price = 18.99
    WHERE title = "Le Meilleur des mondes"
;

UPDATE books
    SET price = 20.49
    WHERE title = "Les Misérables"
;

UPDATE books
    SET price = 14.35
    WHERE title = "L'Étranger"
;
/* ======================================================= */

/* Renomme la colonne "available" en "is_available" */
ALTER TABLE books
    RENAME COLUMN available TO is_available
;

/* Crée la table authors avec les colonnes "id, name" */
CREATE TABLE IF NOT EXISTS authors (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

/* crée la table author_id */
ALTER TABLE books
    ADD author_id INTEGER DEFAULT NULL
;

/* Supprime la collone author */
ALTER TABLE books
    DROP COLUMN author
;

/* Ajoute une contrainte de clé étrangère pour la colonne author_id qui référence la colonne id de la table authors */
ALTER TABLE books
    ADD CONSTRAINT fk_author
    FOREIGN KEY (author_id)
    REFERENCES authors(id);
;

/* Insère des auteurs dans la table authors */
INSERT INTO authors
    (name)
    VALUES  ("George Orwell"), ("Jules Verne"), ("George Orwell"), ("Aldous Huxley"), ("Victor Hugo"), ("Albert Camus"), ("Jules Verne")
;

/* Met à jour la colonne author_id dans la table books en fonction des auteurs correspondants */
UPDATE books
    SET author_id = 1
    WHERE title = "Et vive l'Aspidistra ! "
;

UPDATE books
    SET author_id = 3
    WHERE title = "1984"
;
UPDATE books
    SET author_id = 4
    WHERE title = "Le Meilleur des mondes"
;

UPDATE books
    SET author_id = 6
    WHERE title = "L'Étranger"
;

UPDATE books
    SET author_id = 7
    WHERE title = "L'Île mystérieuse"
;
/* ======================================================= */

    