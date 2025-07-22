CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'DevoirCef';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

CREATE SCHEMA tifosi;
USE tifosi;
CREATE TABLE boisson (
	id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom_boisson VARCHAR(50) NOT NULL,
    marque VARCHAR(50)
);

CREATE TABLE marque (
	id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom_marque VARCHAR(50) NOT NULL
);

CREATE TABLE focaccia (
	id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom_focaccia VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    ingrédients VARCHAR(200) NOT NULL
);

CREATE TABLE ingredient (
	id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom_ingredient VARCHAR(50) NOT NULL
);