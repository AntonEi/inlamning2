-- Inlämning 2 - Bokhandel

USE bokhandel;

-- skapa tabeller

CREATE TABLE kunder (
    kund_id INT AUTO_INCREMENT PRIMARY KEY,
    namn VARCHAR(100),
    epost VARCHAR(100),
    telefon VARCHAR(20)
);

CREATE TABLE produkter (
    produkt_id INT AUTO_INCREMENT PRIMARY KEY,
    titel VARCHAR(100),
    forfattare VARCHAR(100),
    pris INT,
    lagersaldo INT,
    CHECK (pris > 0)
);

CREATE TABLE bestallningar (
    bestallning_id INT AUTO_INCREMENT PRIMARY KEY,
    kund_id INT,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kund_id) REFERENCES kunder(kund_id)
);

CREATE TABLE bestallningsrader (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bestallning_id INT,
    produkt_id INT,
    antal INT,
    FOREIGN KEY (bestallning_id) REFERENCES bestallningar(bestallning_id),
    FOREIGN KEY (produkt_id) REFERENCES produkter(produkt_id)
);

CREATE TABLE kundlogg (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kund_id INT,
    namn VARCHAR(100),
    epost VARCHAR(100),
    datum DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- index

CREATE INDEX idx_epost ON kunder(epost);

-- triggers

DELIMITER $$

CREATE TRIGGER logga_kund
AFTER INSERT ON kunder
FOR EACH ROW
BEGIN
    INSERT INTO kundlogg (kund_id, namn, epost)
    VALUES (NEW.kund_id, NEW.namn, NEW.epost);
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER minska_lager
AFTER INSERT ON bestallningsrader
FOR EACH ROW
BEGIN
    UPDATE produkter
    SET lagersaldo = lagersaldo - NEW.antal
    WHERE produkt_id = NEW.produkt_id;
END $$

DELIMITER ;

-- testdata

INSERT INTO kunder (namn, epost, telefon) VALUES
('Anna Andersson', 'anna@test.se', '0701111111'),
('Bjorn Berg', 'bjorn@test.se', '0702222222'),
('Clara Carlsson', 'clara@test.se', '0703333333'),
('David Dahl', 'david@test.se', '0704444444');

INSERT INTO produkter (titel, forfattare, pris, lagersaldo) VALUES
('Sagan om Ringen', 'Tolkien', 199, 10),
('1984', 'Orwell', 129, 20),
('Clean Code', 'Robert Martin', 349, 5);

INSERT INTO bestallningar (kund_id) VALUES
(1),
(1),
(1),
(2),
(3);

INSERT INTO bestallningsrader (bestallning_id, produkt_id, antal) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1),
(4, 2, 1);

-- select och filter

SELECT * FROM kunder;

SELECT * FROM kunder
WHERE namn LIKE 'A%';

SELECT * FROM produkter
ORDER BY pris;

-- update

UPDATE kunder
SET epost = 'ny@mail.se'
WHERE kund_id = 1;

-- delete + rollback

START TRANSACTION;

DELETE FROM kunder WHERE kund_id = 4;

ROLLBACK;

-- joins

SELECT k.namn, b.bestallning_id
FROM kunder k
INNER JOIN bestallningar b ON k.kund_id = b.kund_id;

SELECT k.namn, b.bestallning_id
FROM kunder k
LEFT JOIN bestallningar b ON k.kund_id = b.kund_id;

-- group by

SELECT k.namn, COUNT(b.bestallning_id) AS antal
FROM kunder k
LEFT JOIN bestallningar b ON k.kund_id = b.kund_id
GROUP BY k.namn;

-- having

SELECT k.namn, COUNT(b.bestallning_id) AS antal
FROM kunder k
INNER JOIN bestallningar b ON k.kund_id = b.kund_id
GROUP BY k.namn
HAVING COUNT(b.bestallning_id) > 2;

-- kolla triggers

SELECT * FROM kundlogg;

SELECT titel, lagersaldo FROM produkter;

SELECT * FROM kunder;
SELECT * FROM produkter;
SELECT * FROM bestallningar;
SELECT * FROM bestallningsrader;
SELECT * FROM kundlogg;

