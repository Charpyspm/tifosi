-- Supprime l'utilisateur s'il est déjà existant, puis le crée
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'DevoirCef';


-- Supprime la base de donnée si elle existe déjà, puis la crée
DROP DATABASE IF EXISTS tifosi;
CREATE SCHEMA tifosi;


-- Accorde tous les privilèges à l'utilisateur tifosi
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE tifosi;


-- Création des différentes tables 
CREATE TABLE marque (
	id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom_marque VARCHAR(50) NOT NULL
);

CREATE TABLE boisson (
	id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom_boisson VARCHAR(50) NOT NULL,
    id_marque INT,
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
);

CREATE TABLE focaccia (
	id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom_focaccia VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    ingrédients VARCHAR(200) NOT NULL
);

CREATE TABLE ingredient (
	id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom_ingredient VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL
);

CREATE TABLE Client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT NOT NULL
);

