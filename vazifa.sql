-- ----------------------< O'CHIRISH >----------------------
DROP TABLE IF EXISTS xodimlar;
DROP TABLE IF EXISTS buyurtmalar;
DROP TABLE IF EXISTS clientlar;
DROP TABLE IF EXISTS avtomobillar;

-- ----------------------< YARATISH >----------------------

CREATE TABLE IF NOT EXISTS avtomobillar(
	avto_id SERIAL PRIMARY KEY,
	avto_nomi VARCHAR(100) NOT NULL,
	model TEXT,
	avto_yil INTEGER,
	narxi NUMERIC(12, 2),
	sotuvda BOOL DEFAULT True
);

CREATE TABLE IF NOT EXISTS clientlar(
	clent_id SERIAL PRIMARY KEY,
	ism VARCHAR(50) NOT NULL,
	familya VARCHAR(50),
	telefon CHAR(17),
	manzil TEXT
);

CREATE TABLE IF NOT EXISTS buyurtmalar(
	buyurtma_id SERIAL PRIMARY KEY,
	avto_id INTEGER,
	clent_id INTEGER,
	CONSTRAINT fk_avto FOREIGN KEY(avto_id) REFERENCES avtomobillar(avto_id),
	CONSTRAINT fk_clent FOREIGN KEY(clent_id) REFERENCES clientlar(clent_id),
	buyurtma_sana DATE NOT NULL,
	umumiy_narx NUMERIC(12, 2)
);

CREATE TABLE IF NOT EXISTS xodimlar(
	xodim_id SERIAL PRIMARY KEY,
	xodim_ismi VARCHAR(50) NOT NULL,
	lavozim VARCHAR(50),
	maosh NUMERIC(10, 2)
);

-- ----------------------< O'ZGARTIRISH >----------------------

ALTER TABLE clientlar
ADD COLUMN email VARCHAR(100);

ALTER TABLE clientlar
RENAME COLUMN ism TO mijoz_ism;

ALTER TABLE clientlar
RENAME TO mijoz;

-- ----------------------< Ma'lumot Kiritish >-------------------

INSERT INTO avtomobillar(avto_nomi, model, avto_yil, narxi) VALUES
('Chervalert', 'Malibu2', 2017, 300000000),
('Mercedes-benz', 'GLB-ClassAMG', 2019, 450000000),
('Audi', 'Audi_Q2', 2023, 6900000000),
('Bugatty', 'Bugatty_Chiron', 2021, 9690000000),
('Labarghini', 'Sián_FKP_37', 2014, 9980000000);

INSERT INTO mijoz(mijoz_ism, familya, telefon, email, manzil) VALUES
('Ali', 'Aliyev', '+998 91 219 02 23', 'AliyevAli@gmail.com', 'Farg''ona'),
('Qodir', 'Qodirov', '+998 90 029 07 94', 'Qodirov@gmail.com', 'Toshkent'),
('Jeck', 'Toms', '+998 91 234 45 35', 'JeckT@gmail.com', 'AQSH'),
('Ivan', 'Ivanovich', '+998 33 923 32 53', 'IvanovichIvan@gmail.com', 'Maskova'),
('Yuriy', 'Mexayelov', '+998 90 913 83 23', 'Mexayelov@gmail.com', 'Yaroslavl');


INSERT INTO buyurtmalar(avto_id, clent_id, buyurtma_sana, umumiy_narx) VALUES
(2, 1, '2022-03-23', 5050000000),
(1, 5, '2019-07-29', 9990000000),
(3, 4, '2021-11-04', 9690070000),
(5, 3, '2016-09-26', 6900400000),
(4, 2, '2023-12-12', 4500900000);

INSERT INTO xodimlar(xodim_ismi, lavozim, maosh) VALUES
('Qahor', 'Xizmatchi', 50000000),
('Alisher', 'Xisob', 10000000),
('Doston', 'Ishchi', 40000000),
('Aziz', 'Boshlig''', 25000000),
('Bilol', 'Ishchi', 60000000);

-- ----------------------< Ma’lumotlarni O’zgartirish >---------------------------

UPDATE xodimlar SET xodim_ismi = 'Begzod' WHERE xodim_id = 1;
UPDATE xodimlar SET xodim_ismi = 'Muhammadali' WHERE xodim_id = 4;

DELETE FROM xodimlar WHERE xodim_id = 3;

-- ----------------------< Ma’lumotlarni Chiqarish >---------------------------

SELECT * FROM avtomobillar;

SELECT * FROM mijoz;

SELECT mijoz_ism, familya, telefon, manzil, avto_nomi, model, avto_yil, narxi, umumiy_narx, buyurtma_sana FROM buyurtmalar
JOIN avtomobillar ON buyurtmalar.avto_id = avtomobillar.avto_id
JOIN mijoz ON buyurtmalar.clent_id = mijoz.clent_id;

SELECT * FROM xodimlar;