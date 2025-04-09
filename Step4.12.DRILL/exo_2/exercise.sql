-- 1. Obtenir l’utilisateur ayant le prénom “Muriel” et le mot de passe “test11”, sachant que l’encodage du mot de passe est effectué avec l’algorithme Sha1. --
SELECT * FROM client
    WHERE prenom = 'Muriel' AND password = sha1('test11')
;

-- 2. Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes. --
SELECT * FROM commande_ligne
    GROUP BY nom
    HAVING COUNT(*) > 1
;

-- 3. Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes et y ajouter une colonne qui liste les identifiants des commandes associées. --
SELECT nom, GROUP_CONCAT(id) AS commandes FROM commande_ligne
    GROUP BY nom
    HAVING COUNT(*) > 1
;

-- 4. Enregistrer le prix total à l’intérieur de chaque ligne des commandes, en fonction du prix unitaire et de la quantité --
UPDATE commande_ligne
    SET prix_total = prix_unitaire * quantite
    WHERE prix_total = 0
;

-- 5. Obtenir le montant total pour chaque commande et y voir facilement la date associée à cette commande ainsi que le prénom et nom du client associé --
SELECT SUM(prix_total) AS montant_total, commande.date_achat, client.prenom, client.nom FROM commande_ligne
    INNER JOIN commande
        ON commande_ligne.id = commande.id
    INNER JOIN client
        ON commande.id = client.id
    GROUP BY commande.id
;

-- 6. (difficulté très haute) Enregistrer le montant total de chaque commande dans le champ intitulé “cache_prix_total” --
UPDATE commande
    INNER JOIN commande_ligne
	    ON commande.id = commande_ligne.id
	SET cache_prix_total = commande_ligne.prix_total
	WHERE cache_prix_total = 0
;

-- 7. Obtenir le montant global de toutes les commandes, pour chaque mois --
SELECT cache_prix_total, date_achat FROM commande    
    GROUP BY MONTH(date_achat)
;

-- 8. Obtenir la liste des 10 clients qui ont effectué le plus grand montant de commandes, et obtenir ce montant total pour chaque client.
SELECT client.nom, prenom, COUNT(commande_id) AS count_id FROM commande_ligne
    INNER JOIN client
	    ON commande_ligne.commande_id = client.id
    GROUP BY commande_id
    ORDER BY count_id DESC
    LIMIT 10
;

-- 9. Obtenir le montant total des commandes pour chaque date
SELECT date_achat, SUM(cache_prix_total) AS total_par_date FROM commande    
    GROUP BY date_achat
;

-- 10. Ajouter une colonne intitulée “category” à la table contenant les commandes. Cette colonne contiendra une valeur numérique --
ALTER TABLE commande
    ADD COLUMN category FLOAT DEFAULT 0
;

/**
 * 
 * 11. Enregistrer la valeur de la catégorie, en suivant les règles suivantes :
 *  - “1” pour les commandes de moins de 200€
 *  - “2” pour les commandes entre 200€ et 500€
 *  - “3” pour les commandes entre 500€ et 1.000€
 *  - “4” pour les commandes supérieures à 1.000€
 *
 */
UPDATE commande
    SET category = 1
    WHERE cache_prix_total < 200
;

UPDATE commande
    SET category = 2
    WHERE cache_prix_total >= 200 AND cache_prix_total < 500
;

UPDATE commande
    SET category = 3
    WHERE cache_prix_total >= 500 AND cache_prix_total < 1000
;

UPDATE commande
    SET category = 4
    WHERE cache_prix_total > 1000
;

-- 12. Créer une table intitulée “commande_category” qui contiendra le descriptif de ces catégories --
CREATE TABLE commande_category (
    description TEXT DEFAULT NULL,
    category INTEGER DEFAULT NULL 
);


-- 13.Insérer les 4 descriptifs de chaque catégorie au sein de la table précédemment créée --
INSERT INTO commande_category
    (description, category)
VALUES
    ('Moins de 200€', 1),
    ('Entre 200€ et 500€', 2),
    ('Entre 500€ et 1.000€', 3),
    ('Plus de 1.000€', 4)
;

-- 14. Supprimer toutes les commandes (et les lignes des commandes) inférieur au 1er février 2019. Cela doit être effectué en 2 requêtes maximum --
DELETE FROM commande
    WHERE date_achat < '2019-02-01'
;

DELETE FROM commande_ligne
    WHERE id NOT IN (SELECT id FROM commande)
;





