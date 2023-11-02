DROP DATABASE IF EXISTS n1e2pizzeria;
CREATE DATABASE n1e2pizzeria CHARACTER SET utf8mb4;
USE n1e2pizzeria;

CREATE TABLE provincies(
    id INT UNSIGNED NOT NULL PRIMARY KEY,
    nom VARCHAR(60) NOT NULL
);

INSERT INTO provincies VALUES (8, 'Barcelona');
INSERT INTO provincies VALUES (48, 'Bizkaia');

CREATE TABLE localitats(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    provincia_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(provincia_id) REFERENCES provincies(id)
);

INSERT INTO localitats (nom, provincia_id) VALUES ('Barcelona', 8);
INSERT INTO localitats (nom, provincia_id) VALUES ('Mataró', 8);
INSERT INTO localitats (nom, provincia_id) VALUES ('Berga', 8);
INSERT INTO localitats (nom, provincia_id) VALUES ('Bilbao', 48);
INSERT INTO localitats (nom, provincia_id) VALUES ('Orduña', 48);

CREATE TABLE clients(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    cognoms VARCHAR(120) NOT NULL,
    adreca VARCHAR(120),
    codi_postal VARCHAR(10),
    localitat_id INT UNSIGNED,
    telefon BIGINT,
    FOREIGN KEY(localitat_id) REFERENCES localitats(id)
);

INSERT INTO clients (nom, cognoms, adreca, codi_postal, localitat_id, telefon) VALUES ('Joan', 'Girona Soler', 'C/ Matadegolla 23', 08032, 1, 938448739);
INSERT INTO clients (nom, cognoms, adreca, codi_postal, localitat_id, telefon) VALUES ('Anna', 'Capmany Garcia', 'C/ Roc Boronat 10', 08018, 2, NULL);
INSERT INTO clients (nom, cognoms, adreca, codi_postal, localitat_id, telefon) VALUES ('Pepa', 'Marín Hernández', NULL, NULL, 3, 933888776);
INSERT INTO clients (nom, cognoms, adreca, codi_postal, localitat_id, telefon) VALUES ('Xavi', 'Fernàndez Arando', 'C/ Malavista 12', 48041, 4, 948133344);
INSERT INTO clients (nom, cognoms, adreca, codi_postal, localitat_id, telefon) VALUES ('Txus', 'Fernàndez Arando', 'C/ Malavista 12', 48041, 4, 948133344);

CREATE TABLE botigues(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    adreca VARCHAR(100) NOT NULL,
    codi_postal VARCHAR(10) NOT NULL,
    localitat_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(localitat_id) REFERENCES localitats(id)
);

INSERT INTO botigues (adreca, codi_postal, localitat_id) VALUES ('C/ Llobregós, 19', 08032, 1);
INSERT INTO botigues (adreca, codi_postal, localitat_id) VALUES ('C/ Algun, 27', 48001, 5);

CREATE TABLE personal(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    cognoms VARCHAR(60) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    telefon BIGINT NOT NULL,
    carrec ENUM('Cuina', 'Repartiment') NOT NULL,
    botiga_id INT UNSIGNED,
    FOREIGN KEY(botiga_id) REFERENCES botigues(id)
);

INSERT INTO personal (nom, cognoms, nif, telefon, carrec, botiga_id) VALUES ('Joana', 'Giménez Meneses', '43377334E', 937284727, 'Cuina', 1);
INSERT INTO personal (nom, cognoms, nif, telefon, carrec, botiga_id) VALUES ('Pere', 'Arnau Guixó', '36577433R', 932267554, 'Repartiment', 1);
INSERT INTO personal (nom, cognoms, nif, telefon, carrec, botiga_id) VALUES ('Clara', 'Arnau Guixó', '38899716T', 938877665, 'Repartiment', 1);
INSERT INTO personal (nom, cognoms, nif, telefon, carrec, botiga_id) VALUES ('Ander', 'Giménez Segarra', '35927564Y', 946755234, 'Cuina', 2);
INSERT INTO personal (nom, cognoms, nif, telefon, carrec, botiga_id) VALUES ('Joseph', 'Smith Smith', '33998294J', 947762846, 'Repartiment', 2);

CREATE TABLE comandes(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    repartiment ENUM('Botiga', 'Domicili') NOT NULL,
    nombre_pizzes SMALLINT NOT NULL,
    nombre_hamburgueses SMALLINT NOT NULL,
    nombre_begudes SMALLINT NOT NULL,
    preu_total DOUBLE NOT NULL,
    client_id BIGINT UNSIGNED NOT NULL,
    botiga_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(client_id) REFERENCES clients(id),
    FOREIGN KEY(botiga_id) REFERENCES botigues(id)
);

INSERT INTO comandes (data_hora, repartiment, nombre_pizzes, nombre_hamburgueses, nombre_begudes, preu_total, client_id, botiga_id) VALUES ('2023-05-04 22:00:00', 'Botiga', 1, 0, 0, 5.99, 1, 1);
INSERT INTO comandes (data_hora, repartiment, nombre_pizzes, nombre_hamburgueses, nombre_begudes, preu_total, client_id, botiga_id) VALUES ('2023-05-10 23:30:00', 'Domicili', 2, 1, 3, 20.99, 2, 1);
INSERT INTO comandes (data_hora, repartiment, nombre_pizzes, nombre_hamburgueses, nombre_begudes, preu_total, client_id, botiga_id) VALUES ('2023-05-04 22:10:00', 'Domicili', 1, 0, 0, 5.99, 3, 1);
INSERT INTO comandes (data_hora, repartiment, nombre_pizzes, nombre_hamburgueses, nombre_begudes, preu_total, client_id, botiga_id) VALUES ('2023-05-04 20:00:00', 'Botiga', 0, 1, 1, 7.99, 4, 2);
INSERT INTO comandes (data_hora, repartiment, nombre_pizzes, nombre_hamburgueses, nombre_begudes, preu_total, client_id, botiga_id) VALUES ('2023-05-04 22:15:00', 'Domicili', 1, 1, 2, 19.99, 5, 2);

CREATE TABLE tipus_productes(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL
);

INSERT INTO tipus_productes (nom) VALUES ('Pizza');
INSERT INTO tipus_productes (nom) VALUES ('Hamburguesa');
INSERT INTO tipus_productes (nom) VALUES ('Beguda');

CREATE TABLE productes(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    descripcio TEXT,
    imatge BLOB,
    preu DOUBLE,
    tipus_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(tipus_id) REFERENCES tipus_productes(id)
);

INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Pizza carbonara', 'Pizza a la carbonara amb x ingredients', NULL, 5.99, 1);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Pizza quatre formatges', 'Pizza quatre formatges amb x ingredients', NULL, 5.99, 1);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Pizza carbonara sense gluten', 'Pizza a la carbonara amb x ingredients sense gluten', NULL, 5.99, 1);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Pizza quatre formatges sense gluten', 'Pizza quatre formatges amb x ingredients sense gluten', NULL, 5.99, 1);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Aigua', 'Aigua mineral', NULL, 1.99, 3);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Refresc', 'Refresc de soda', NULL, 2.99, 3);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Hamburguesa de porc', 'Hamburguesa de porc', NULL, 5.99, 2);
INSERT INTO productes (nom, descripcio, imatge, preu, tipus_id) VALUES ('Hamburguesa vegetal', 'Hamburguesa vegetal, vegana', NULL, 7.99, 2);
    
CREATE TABLE repartiments_domicili (
    comanda_id BIGINT UNSIGNED NOT NULL UNIQUE KEY,
    repartidor_id INT UNSIGNED NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY(comanda_id) REFERENCES comandes(id),
    FOREIGN KEY(repartidor_id) REFERENCES personal(id)
);

INSERT INTO repartiments_domicili VALUES (2, 2, '2023-05-10 23:50:00');
INSERT INTO repartiments_domicili VALUES (3, 3, '2023-05-04 22:35:00');
INSERT INTO repartiments_domicili VALUES (5, 5, '2023-05-04 22:45:00');

CREATE TABLE comanda_productes(
    comanda_id BIGINT UNSIGNED NOT NULL,
    producte_id BIGINT UNSIGNED NOT NULL,
    quantitat SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY(producte_id) REFERENCES productes(id),
    FOREIGN KEY(comanda_id) REFERENCES comandes(id)
);

INSERT INTO comanda_productes VALUES(1, 2, 1);
INSERT INTO comanda_productes VALUES(2, 1, 2);
INSERT INTO comanda_productes VALUES(2, 7, 1);
INSERT INTO comanda_productes VALUES(2, 6, 3);
INSERT INTO comanda_productes VALUES(3, 1, 1);
INSERT INTO comanda_productes VALUES(4, 8, 1);
INSERT INTO comanda_productes VALUES(4, 5, 1);
INSERT INTO comanda_productes VALUES(5, 1, 1);
INSERT INTO comanda_productes VALUES(5, 7, 1);
INSERT INTO comanda_productes VALUES(5, 6, 2);
    
CREATE TABLE categories_pizza(
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL
);

INSERT INTO categories_pizza (nom) VALUES ('Categoria1');
INSERT INTO categories_pizza (nom) VALUES ('Categoria2');

CREATE TABLE pizzes_per_categories(
    pizza_id BIGINT UNSIGNED NOT NULL UNIQUE KEY,
    categories_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY(categories_id) REFERENCES categories_pizza(id),
	FOREIGN KEY(pizza_id) REFERENCES productes(id)
);

INSERT INTO pizzes_per_categories VALUES (1, 1);
INSERT INTO pizzes_per_categories VALUES (2, 2);
INSERT INTO pizzes_per_categories VALUES (3, 1);
INSERT INTO pizzes_per_categories VALUES (4, 2);
