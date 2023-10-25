DROP DATABASE IF EXISTS n1e1Optica;
CREATE DATABASE n1e1Optica CHARACTER SET utf8mb4;
USE n1e1Optica;

CREATE TABLE proveidors (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(60) NOT NULL,
adreca VARCHAR(60),
telefon BIGINT UNSIGNED,
fax BIGINT UNSIGNED,
nif VARCHAR(9) UNIQUE
);

CREATE TABLE marques (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(60) NOT NULL,
proveidor_id INT UNSIGNED NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (proveidor_id) REFERENCES proveidors(id)
);

CREATE TABLE ulleres (
id INT UNSIGNED NOT NULL PRIMARY KEY,
graduacio_esq FLOAT,
graduacio_dre FLOAT,
tipus_muntura ENUM('flotant', 'pasta', 'metàl·lica'),
color_muntura VARCHAR (15),
color_vidre_esq VARCHAR (15),
color_vidre_dre VARCHAR (15),
preu FLOAT,
marca_id INT UNSIGNED NOT NULL,
FOREIGN KEY (marca_id) REFERENCES marques(id)
);

CREATE TABLE clients (
id INT UNSIGNED NOT NULL PRIMARY KEY,
adreca_postal VARCHAR(45),
telefon BIGINT,
email VARCHAR(60),
data_registre DATE,
client_referencia_id INT UNSIGNED,
FOREIGN KEY (client_referencia_id) REFERENCES clients(id)
);

CREATE TABLE vendes (
venedor VARCHAR(60) NOT NULL,
ullera_id INT UNSIGNED NOT NULL,
client_id INT UNSIGNED NOT NULL,
FOREIGN KEY (ullera_id) REFERENCES ulleres(id),
FOREIGN KEY (client_id) REFERENCES clients(id)
);

INSERT INTO proveidors VALUES (1, 'SunFlowers', 'C/ Marmara, 58', 9348283820, 9348283822, 'X83947293');
INSERT INTO proveidors VALUES (2, 'Amazon', 'C/ Consell de Cent, 30', 937468428, 937468421, 'N84938475');
INSERT INTO proveidors VALUES (3, 'Just Glasses SA', 'C/ Avinguda, 75', NULL ,  NULL , 'T99821273');

INSERT INTO marques VALUES (1, 'Gucci', 3);
INSERT INTO marques VALUES (2, 'NotGucci', 2);
INSERT INTO marques VALUES (3, 'El Cheapo', 2);
INSERT INTO marques VALUES (4, 'Roland', 1);
INSERT INTO marques VALUES (5, 'Domus', 3);

INSERT INTO ulleres VALUES (1, 3.5, 3.5, 'flotant', 'Verd', NULL, NULL, 19.99, 2);
INSERT INTO ulleres VALUES (2, 1, 0, 'pasta','Groc', NULL, NULL, 39.99, 1);
INSERT INTO ulleres VALUES (3, 1.25, 1, 'metàl·lica','Verd', NULL, NULL, 39.99, 1);
INSERT INTO ulleres VALUES (4, 3.5, 2.5, 'flotant','Vermell', NULL, NULL, 19.99, 4);
INSERT INTO ulleres VALUES (5, 0, 0, 'pasta','Negre', 'Verd', 'Verd', 14.99, 3);
INSERT INTO ulleres VALUES (6, 0.5, 0.5, 'flotant','Negre', NULL, NULL, 12.99, 3);
INSERT INTO ulleres VALUES (7, 3.5, 1.25, 'metàl·lica','Negre', NULL, NULL, 34.99, 2);
INSERT INTO ulleres VALUES (8, 0.25, 0.5, 'metàl·lica','Gris', NULL, NULL, 24.99, 4);
INSERT INTO ulleres VALUES (9, 0.25, 2.25, 'pasta','Verd', 'Negre', 'Negre', 29.99, 1);
INSERT INTO ulleres VALUES (10, 3.5, 3.5, 'flotant','Vermell', NULL, NULL, 14.99, 2);

INSERT INTO clients VALUES (1, 'C/ Matadegolla 23', 938448739, 'joanjosep@laseva.org', '1987-12-05', NULL);
INSERT INTO clients VALUES (2, 'C/ Roc Boronat 10', 938874626, NULL, '1987-12-05', NULL);
INSERT INTO clients VALUES (3, 'C/ Cinc de Maig, S/N', NULL, NULL, '1988-11-28', NULL);
INSERT INTO clients VALUES (4, 'C/ Bonavista 1', 938448739, 'pepa21@laseva.org', NULL, NULL);
INSERT INTO clients VALUES (5, 'C/ Malavista 12', 938448739, 'rambling2@laseva.org', '1999-01-03', 1);
INSERT INTO clients VALUES (6, 'C/ Matadegolla 165', NULL, 'jalarcon@laseva.org', '2001-03-22', 3);

INSERT INTO vendes VALUES ('Joana Alarcon', 1, 1);
INSERT INTO vendes VALUES ('Pere Llamantol', 2, 2);
INSERT INTO vendes VALUES ('Joana Alarcon', 4, 1);
INSERT INTO vendes VALUES ('Joana Alarcon', 5, 3);
INSERT INTO vendes VALUES ('Pere Llamantol', 3, 4);
INSERT INTO vendes VALUES ('Clara Rovira', 7, 5);
INSERT INTO vendes VALUES ('Joana Alarcon', 8, 6);
INSERT INTO vendes VALUES ('Clara Rovira', 9, 3);