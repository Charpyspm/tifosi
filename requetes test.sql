-- 1 afficher la liste des noms des focaccias par ordre alphabétique croissant:
SELECT nom_focaccia FROM focaccia ORDER BY nom_focaccia ASC;
/*
Résultat attendu: 
    Américaine
    Emmentalaccia
    Gorgonzollaccia
    Hawaienne
    Mozaccia
    Paysanne
    Raclaccia
    Tradizione

Résultat obtenu: 
    Américaine
    Emmentalaccia
    Gorgonzollaccia
    Hawaienne
    Mozaccia
    Paysanne
    Raclaccia
    Tradizione
*/

-- 2 afficher le nombre total d'ingrédients
SELECT COUNT(*) AS id_ingredient FROM ingredient;

/*
Résultat attendu: 
    25

Résultat obtenu:
    25
*/

-- 3 afficher le prix moyen des focaccias
SELECT AVG(prix) AS prix FROM focaccia;

/*
Résultat attendu:
    10.375

Résultat obtenu:
    10.375
*/

-- 4 afficher la liste des boissons avec leurs marque, triée par nom de boisson
SELECT b.nom_boisson, m.nom_marque 
FROM boisson b 
JOIN marque m ON b.id_marque = m.id_marque 
ORDER BY b.nom_boisson;

/*
Résultat attendu:
    Capri-sun, Coca-cola
    Coca-cola original, Coca-cola
    Coca-cola zéro, Coca-cola
    Eau de source, Cristalline
    Fanta citron, Coca-cola
    Fanta orange, Coca-cola
    Lipton Peach, Pepsico
    Lipton zéro citron, Pepsico
    Monster energy ultra blue, Monster
    Monster energy ultra gold, Monster
    Pepsi, Pepsico
    Pepsi Max Zéro, Pepsico

Résultat obtenu:
    Capri-sun, Coca-cola
    Coca-cola original, Coca-cola
    Coca-cola zéro, Coca-cola
    Eau de source, Cristalline
    Fanta citron, Coca-cola
    Fanta orange, Coca-cola
    Lipton Peach, Pepsico
    Lipton zéro citron, Pepsico
    Monster energy ultra blue, Monster
    Monster energy ultra gold, Monster
    Pepsi, Pepsico
    Pepsi Max Zéro, Pepsico
*/

-- 5 afficher la liste des ingrédients pour une Raclaccia
SELECT GROUP_CONCAT(i.nom_ingredient SEPARATOR ', ') AS ingredients_noms
FROM focaccia f
JOIN ingredient i ON FIND_IN_SET(i.id_ingredient, f.ingrédients) > 0
WHERE f.nom_focaccia = 'Raclaccia';

/*
Résultat attendu:
    Base tomate, raclette, cresson, ail, champignon, parmesan, poivre

Résultat obtenu:
    Base tomate, raclette, cresson, ail, champignon, parmesan, poivre
*/

-- 6 afficher le nom et le nombre d'ingrédients de chaque focaccia
SELECT f.nom_focaccia, COUNT(i.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN ingredient i ON FIND_IN_SET(i.id_ingredient, f.ingrédients) > 0
GROUP BY f.id_focaccia, f.nom_focaccia;

/*
Résultat attendu:
    Mozaccia	10
    Gorgonzollaccia	8
    Raclaccia	7
    Emmentalaccia	7
    Tradizione	9
    Hawaienne	9
    Américaine	8
    Paysanne	12

Résultat obtenu:
    Mozaccia	10
    Gorgonzollaccia	8
    Raclaccia	7
    Emmentalaccia	7
    Tradizione	9
    Hawaienne	9
    Américaine	8
    Paysanne	12
*/

-- 7 afficher le nom de la focaccia qui as le plus d'ingrédients
SELECT f.nom_focaccia
FROM focaccia f
JOIN ingredient i ON FIND_IN_SET(i.id_ingredient, f.ingrédients) > 0
GROUP BY f.id_focaccia, f.nom_focaccia
HAVING COUNT(i.id_ingredient) = (
    SELECT MAX(ingredient_count)
    FROM (
        SELECT COUNT(i2.id_ingredient) AS ingredient_count
        FROM focaccia f2
        JOIN ingredient i2 ON FIND_IN_SET(i2.id_ingredient, f2.ingrédients) > 0
        GROUP BY f2.id_focaccia
    ) AS counts
);

/*
Résultat attendu:
    Paysanne    

Résultat obtenu:
    Paysanne    
*/

-- 8 afficher la liste des focaccia qui contiennent de l'ail
SELECT DISTINCT f.nom_focaccia
FROM focaccia f
JOIN ingredient i ON FIND_IN_SET(i.id_ingredient, f.ingrédients) > 0
WHERE i.nom_ingredient = 'Ail';

/*
Résultat attendu:
    Mozaccia 
    Gorgonzollaccia
    Raclaccia
    Paysanne

Résultat obtenu:
    Mozaccia 
    Gorgonzollaccia
    Raclaccia
    Paysanne
*/

-- 9 afficher la liste des ingrédients inutilisés
SELECT i.nom_ingredient
FROM ingredient i
LEFT JOIN focaccia f ON FIND_IN_SET(i.id_ingredient, f.ingrédients) > 0
WHERE f.id_focaccia IS NULL;
/*
Résultat attendu:
    Salami
    Tomate cerise

Résultat obtenu:
    Salami
    Tomate cerise

*/

-- 10 afficher la liste des focaccia qui n'ont pas de champignons
SELECT f.nom_focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT DISTINCT f2.id_focaccia
    FROM focaccia f2
    JOIN ingredient i ON FIND_IN_SET(i.id_ingredient, f2.ingrédients) > 0
    WHERE i.nom_ingredient = 'Champignon'
);

/*
Résultat attendu:
    Hawaienne
    Américaine

Résultat obtenu:
    Hawaienne
    Américaine
*/
