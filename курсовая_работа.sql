-- База данных для интернет-магазина "Дети кота". Магазин, где продаются животные и товары для них. 
-- В таблице staff представлен персонал магазина, в таблицах catalogs и products - каталог и товары, 
-- в таблице clients - клиенты, таблица kittens содержит животных, таблица orders - заказы.

DROP DATABASE IF EXISTS cat_house;
CREATE DATABASE cat_house;
USE cat_house;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id SERIAL PRIMARY KEY,
	name VARCHAR (150) COMMENT 'ФИО',
	`position` VARCHAR (50) COMMENT 'Должность',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Персонал';

INSERT INTO staff (name, `position`)
VALUES 
	('Иванова Анна Николаевна', 'Директор/Ветеринарный врач'),
	('Петров Иван Петрович','Зам.директора/Администратор'),
	('Соколова Елена Сергеевна','Продавец-консультант'),
	('Орлов Игорь Иванович','Продавец-консультант'),
	('Кошкина Марина Андреевна','Ветеринарный врач');

DROP TABLE IF EXISTS clients;
CREATE TABLE clients (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	birthday_at DATE,
	phone BIGINT,
	email VARCHAR (100),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Клиенты';

INSERT INTO clients (name, birthday_at, phone, email) 
VALUES
	('Александр Борисов', '1972-06-08','9122344543','borisa@mail.net'),
	('Сергей Любимов','1992-12-21','91234432671','lub_s@mail.net'),
 	('Ольга Гусева','2002-04-12','9475648327','olgu@mail.net'),
 	('Ирина Грачева','1995-07-17','9377365482','i_gra@mail.net'),
 	('Андрей Козлов','1989-09-09','9377589320','a_ko@mail.net'),
 	('Мария Никитина','1999-04-23','9377583726','niki@mail.net'),
 	('Алина Серегина','1987-05-05','9579987465','sereg@mail.net'),
 	('Николай Краснов','1977-09-09','9585767758','kras@mail.net'),
 	('Виктор Пряников','1989-06-06','9388476583','vipr@mail.net'),
 	('Людмила Белова','1999-02-02','9387682824','belu@mail.net');
 
 
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	UNIQUE unique_name(name(20))
);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  UNIQUE unique_name(name(20))
);

INSERT INTO catalogs 
VALUES
	(NULL, 'Корма для животных'),
	(NULL, 'Товары для ухода за животными'),
	(NULL, 'Игрушки'),
	(NULL, 'Пушистые комочки');
 
 
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	description TEXT COMMENT 'Описание',
	price DECIMAL (10,2),
	catalog_id BIGINT UNSIGNED,
	total INT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY index_of_catalog_id (catalog_id),
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
);

INSERT INTO products (name, description, price, catalog_id, total)
VALUES
	('Кискас', 'Корм из мраморной говядины под соусом из трюфелей', 190.00, 1, 4),
	('Кискас', 'Корм из осетра с икрой морского ежа', 190.00, 1, 4),
	('Кискас', 'Корм из неугодных коту врагов в нежном сливочном соусе', 190.00, 1, 6),
	('Лоток "Царь горы" + наполнитель', 'Для пушистых любителей делать важные дела на вершине мира', 540.00, 2, 2),
	('Лоток "Мау" + наполнитель', 'С возможностью построить пирамиду фараона', 650.00, 2, 3),
	('Когтеточка', 'Столбик для выражения эмоций', 920.00, 2, 3),
	('Когтеточка высокая', 'Для пушистых любителей смотреть свысока', 3600.00, 2, 1),
	('Кошачий домик "Зато не в ипотеку" ','Домик хорош, но Ваш кот всё равно выберет коробку', 2300.00, 2, 1),
	('Мышь белая','Из греческого зала', 150.00, 3, 4),
	('Мяч "Гоняй меня полностью"','С задорными бубенцами', 130.00, 3, 5);

DROP TABLE IF EXISTS kittens;
CREATE TABLE kittens (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	description TEXT COMMENT 'Описание',
	age VARCHAR (20),
	price TEXT,
	catalog_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY index_of_catalog_id (catalog_id),
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
);

INSERT INTO kittens (name, description, age, price, catalog_id)
VALUES
	('Тень','Кот. Абсолютно чёрный, как безлунная ночь. Глаза зелёные. Характер нордический','2 месяца', 'Отдаём за "спасибо"', 4),
	('Белое облачко','Кот. Мобильный. Есть режим мурчания. +10 к желанию научиться вязать варежки','1 месяц', 'Отдаём за "спасибо"', 4),
	('Совесть','Кошка. Спокойная. Чайлдфри. Рекомендуется тем, кто на диете','2 года', 'Отдаём за "Большое спасибо"', 4);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	client_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY index_of_client_id(client_id),
	FOREIGN KEY (client_id) REFERENCES clients(id)
) COMMENT = 'Заказы';

INSERT INTO orders (client_id)
VALUES
	(1),
	(3),
	(2),
	(4),
	(5);
 
DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED,
	product_id BIGINT UNSIGNED,
	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товаров',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO orders_products (order_id, product_id, total)
VALUES
	(1, 3, 1),
	(2, 4, 2),
	(3, 1, 1),
	(4, 3, 2),
	(5, 6, 1);

-- выборка клиентов и заказанных ими товаров

SELECT c.name, op.product_id, p.name 
FROM clients c 
	JOIN orders_products op ON c.id = op.order_id
	JOIN products p ON p.id = op.product_id; 


-- процедура добавления товара в таблицу products

DELIMITER //

DROP PROCEDURE IF EXISTS prod_insert//
CREATE PROCEDURE prod_insert (IN name VARCHAR(150), IN description TEXT, IN price DECIMAL,
							  IN catalog_id INT UNSIGNED, IN total INT UNSIGNED)
BEGIN
	INSERT INTO products (name, description, price, catalog_id, total) 
	VALUES(name, description, price, catalog_id, total);
END//

DELIMITER ;

CALL prod_insert('Хомяк "Как живой"','Но плюшевый', 200.00, 3, 2); 
select * from products;


-- Триггер на ошибку внесения товара в таблицу products

DELIMITER //

DROP TRIGGER IF EXISTS prod_info //
CREATE TRIGGER prod_info BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL OR NEW.description IS NULL OR NEW.price IS NULL OR NEW.catalog_id IS NULL OR NEW.total IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка введения данных";
	END IF;
END //

DELIMITER ;


-- триггер на добавлении записи при поступлении нового кота

DROP TABLE IF EXISTS entrance;
CREATE TABLE entrance (
	created_at DATETIME NOT NULL,
	name_of_table VARCHAR (50) NOT NULL,
	id_value INT NOT NULL,
	name_value VARCHAR(150));

DELIMITER //

DROP TRIGGER IF EXISTS cat_new //
CREATE TRIGGER cat_new AFTER INSERT ON kittens
FOR EACH ROW
BEGIN
	INSERT INTO entrance (created_at, name_of_table, id_value, name_value)
	VALUES (NOW(), 'name', NEW.id, NEW.name);
END //

DELIMITER ;

select * from kittens;
INSERT INTO kittens (name, description, age, price, catalog_id)
VALUES
	('Алиса', 'То ли кошка, то ли лиса', 'Возраст философский', 'Отдаётся сама', 4);
select * from kittens;
select * from entrance;


-- представление "выбери кота и подарок для него"

CREATE OR REPLACE VIEW surprise (cat_name, prod_name)
AS SELECT k.name, p.name 
FROM kittens k  LEFT JOIN products p ON k.id = p.catalog_id
ORDER BY RAND()
LIMIT 1;

select * from surprise;

-- представление товары и раздел каталога

CREATE OR REPLACE VIEW prods_catalogs (catal_name, prod_name)
AS SELECT c.name, p.name
FROM products p LEFT JOIN catalogs c ON c.id = p.catalog_id
ORDER BY c.name;

select * from prods_catalogs;

