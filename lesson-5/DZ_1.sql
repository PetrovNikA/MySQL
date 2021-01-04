-- ������������ ������� �� ���� ����������, ����������, ���������� � �����������
-- �������� � ����� ��
CREATE DATABASE shop;
USE shop;

-- ������� 1.
-- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

-- ������� ������� Users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

-- ��������� ������� �������
INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');
 
-- ���������� � ������� ������
-- ������� �������� created_at � updated_at
UPDATE users SET created_at = NULL;
UPDATE users SET updated_at = NULL;

-- ���������� �������� created_at � updated_at ������� ����� � ��������
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();



-- ������� 2.
-- ������� users ���� �������� ��������������. 
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. 
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

-- ������� ������� �� ����������� �������
DROP TABLE IF EXISTS users;

-- ������� ������� Users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = '����������';

-- ��������� ������� �������
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('��������', '1990-10-05', '13.01.2020 8:10', '19.07.2020 14:16'),
  ('�������', '1984-11-12', '14.02.2020 9:11', '20.08.2020 15:17'),
  ('���������', '1985-05-20', '15.03.2020 10:12', '21.09.2020 16:18'),
  ('������', '1988-02-14', '16.04.2020 11:13', '22.10.2020 17:19'),
  ('����', '1998-01-12', '17.05.2020 12:14', '23.11.2020 18:20'),
  ('�����', '1992-08-29', '18.06.2020 13:15', '24.12.2020 19:21');
 
-- ���������� ���� �������� � ���������� �������� ��� �������� ������ �� �������� created_at � updated_at 
ALTER TABLE users ADD new_created_at DATETIME;
ALTER TABLE users ADD new_updated_at DATETIME;


-- ����������� ������ � ��������������� � ����������� ��������� �������
UPDATE users SET new_created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i");
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
   
-- �������� �������� � ������������ ����� ������
ALTER TABLE users 
DROP created_at, 
DROP updated_at;

-- �������������� ����� �������� � ������������ �� �������
ALTER TABLE users
RENAME COLUMN new_created_at TO created_at, 
RENAME COLUMN new_updated_at TO updated_at;

-- �������� ����������
SELECT * FROM users



-- ������� 3.
-- � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
-- 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
-- ����� ��� ���������� � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

-- �������� ������� ���� ����������
DROP TABLE IF EXISTS storehouses_products;

-- �������� ������� storehouses_products
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT '����� �������� ������� �� ������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';

-- ���������� ������� �������
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

-- �������
SELECT * FROM storehouses_products
ORDER BY IF(value > 0, 0, 1), value;