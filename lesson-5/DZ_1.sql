-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- Создание и выбор БД
CREATE DATABASE shop;
USE shop;

-- Задание 1.
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

-- Создаем таблицу Users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
-- Приведение к условию задачи
-- Очистка столбцов created_at и updated_at
UPDATE users SET created_at = NULL;
UPDATE users SET updated_at = NULL;

-- Заполнение столбцов created_at и updated_at текущей датой и временем
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();



-- Задание 2.
-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

-- Удаляем таблицу от предыдущего задания
DROP TABLE IF EXISTS users;

-- Создаем таблицу Users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '13.01.2020 8:10', '19.07.2020 14:16'),
  ('Наталья', '1984-11-12', '14.02.2020 9:11', '20.08.2020 15:17'),
  ('Александр', '1985-05-20', '15.03.2020 10:12', '21.09.2020 16:18'),
  ('Сергей', '1988-02-14', '16.04.2020 11:13', '22.10.2020 17:19'),
  ('Иван', '1998-01-12', '17.05.2020 12:14', '23.11.2020 18:20'),
  ('Мария', '1992-08-29', '18.06.2020 13:15', '24.12.2020 19:21');
 
-- Добавление двух столбцов с корректным форматом для переноса данных из столбцов created_at и updated_at 
ALTER TABLE users ADD new_created_at DATETIME;
ALTER TABLE users ADD new_updated_at DATETIME;


-- перемещение данных с преобразованием в аналогичные созданные столбцы
UPDATE users SET new_created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i");
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
   
-- Удаление столбцов с некорректным типом данных
ALTER TABLE users 
DROP created_at, 
DROP updated_at;

-- Переименование новых столбцов в соответствии со старыми
ALTER TABLE users
RENAME COLUMN new_created_at TO created_at, 
RENAME COLUMN new_updated_at TO updated_at;

-- проверка результата
SELECT * FROM users



-- Задание 3.
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

-- Удаление таблицы если существует
DROP TABLE IF EXISTS storehouses_products;

-- Создание таблицы storehouses_products
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- Заполнение таблицы данными
INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  ('1', '11', '2'),
  ('2', '12', '0'),
  ('3', '13', '5'),
  ('4', '14', '8'),
  ('5', '15', '7'),
  ('6', '16', '0'),
  ('7', '17', '9'),
  ('8', '18', '1'),
  ('9', '19', '3'),
  ('10', '20', '0');

-- Решение
SELECT * FROM storehouses_products
ORDER BY IF(value > 0, 0, 1), value;