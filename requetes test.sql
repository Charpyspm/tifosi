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
SELECT nom_boisson, marque FROM boisson ORDER BY nom_boisson;

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
SELECT ingrédients FROM focaccia WHERE nom_focaccia = 'Raclaccia';

/*
Résultat attendu:
    Base tomate, raclette, cresson, ail, champignon, parmesan, poivre

Résultat obtenu:
    Base tomate, raclette, cresson, ail, champignon, parmesan, poivre
*/

-- 6 afficher le nom et le nombre d'ingrédients de chaque focaccia
SELECT nom_focaccia, 
       (LENGTH(ingrédients) - LENGTH(REPLACE(ingrédients, ',', '')) + 1) AS nombre_ingredients
FROM focaccia;

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
SELECT nom_focaccia
FROM focaccia
WHERE (LENGTH(ingrédients) - LENGTH(REPLACE(ingrédients, ',', '')) + 1) = (
    SELECT MAX(LENGTH(ingrédients) - LENGTH(REPLACE(ingrédients, ',', '')) + 1)
    FROM focaccia
);

/*
Résultat attendu:
    Paysanne    

Résultat obtenu:
    Paysanne    
*/

-- 8 afficher la liste des focaccia qui contiennent de l'ail
SELECT nom_focaccia
FROM focaccia
WHERE ingrédients LIKE '%ail%';

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
SELECT nom_ingredient 
FROM ingredient
WHERE nom_ingredient NOT IN (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(ingrédients, ',', numbers.n), ',', -1)) AS ingredient
    FROM focaccia
    JOIN (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
        UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
    ) numbers ON CHAR_LENGTH(ingrédients) - CHAR_LENGTH(REPLACE(ingrédients, ',', '')) + 1 >= numbers.n
);
/*
Résultat attendu:
    Salami
    Tomate cerise

Résultat obtenu:
    Oeuf
    Olives vertes
    Salami
    Tomate cerise

La différence entre le résultat attendu et celui obtenu, 
est du au fait que la table ingredient stock "Oeuf" et la table focaccia le stock comme "œuf".
L'orthographe étant différent, le script SQL ne les considère pas comme identiques.
Pour ce qui est des Olives vertes, dans la table focaccia, une parenthèse est présente et pas dans la table ingredient.

*/

-- 10 afficher la liste des focaccia qui n'ont pas de champignons
SELECT nom_focaccia FROM focaccia
WHERE ingrédients NOT LIKE '%champignon%';

/*
Résultat attendu:
    Hawaienne
    Américaine

Résultat obtenu:
    Hawaienne
    Américaine
*/
