USE tifosi;

-- Vide les tables pour éviter les doublons ou les erreurs d'intégrité référentielle
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE boisson;
TRUNCATE TABLE marque;
TRUNCATE TABLE focaccia;
TRUNCATE TABLE ingredient;
SET FOREIGN_KEY_CHECKS = 1;

-- Charge les marques (table indépendante)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/marque.csv'
INTO TABLE marque
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(id_marque, nom_marque);

-- Charge les boissons (qui dépendent des marques)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/boisson.csv'
INTO TABLE boisson
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_boisson, nom_boisson, id_marque);

-- Charge les ingrédients (table indépendante)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ingredient.csv'
INTO TABLE ingredient
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_ingredient, nom_ingredient);

-- Charge les focaccias (qui dépendent des ingrédients)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/focaccia.csv'
INTO TABLE focaccia
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_focaccia, nom_focaccia, prix, ingrédients);