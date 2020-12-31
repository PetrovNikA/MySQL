use vk;

-- Задание 1. Повторить все действия по доработке БД vk.

-- Вынесение статуса в отдельный справочник из таблицы profiles

CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название статуса (уникально)",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник статусов пользователей";  

-- очистка столбца status в таблице profiles
UPDATE profiles SET status = NULL;

-- Изменение имени столбца status на status_id в таблице profiles
ALTER TABLE profiles RENAME COLUMN status TO status_id;

-- Изменение типа данных столбца status на status_id в таблице profiles
ALTER TABLE profiles MODIFY COLUMN status_id INT UNSIGNED;

-- проверка внесенных изменений
DESC profiles;




-- Задание 2. Заполнение данных в таблице user_statuses
INSERT INTO user_statuses (name) VALUES ('single'),('married');


-- Задание 3. Повторить все действия CRUD.
-- Доработка тестовых данных


-- Доработка таблицы users
-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;
-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                  
-- Проверка внесенных изменений в данные пользователей, вывод строк, где updated_at меньше created_at.
SELECT * FROM users WHERE updated_at < created_at;



-- Доработка таблицы profiles
DESC profiles;
SELECT * FROM profiles;
-- Приводим в порядок временные метки
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;     
-- Добавляем ссылки на фото (коррекция)
UPDATE profiles SET photo_id = 1 + FLOOR(RAND() * 200);
-- Временный справочник пола
CREATE TEMPORARY TABLE genders (name CHAR(1));
-- Добавление значений во временную таблицу
INSERT INTO genders VALUES ('m'), ('f'); 
-- Проверка добавленных данных во временную таблицу
SELECT * FROM genders;
-- Обновление столбца пол в таблице profiles
UPDATE profiles 
  SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);
-- Изменение имени столбца status_id на user_status_id в таблице profiles
ALTER TABLE profiles RENAME COLUMN status_id TO user_status_id;
-- Добавляем ссылки на статус пользователя
UPDATE profiles SET user_status_id = FLOOR(1 + RAND() * 2);



-- Доработка таблицы messages
-- Смотрим структуру таблицы сообщений
DESC messages;
-- Анализируем данные
SELECT * FROM messages LIMIT 10;
-- Обновляем значения ссылок на отправителя и получателя сообщения
UPDATE messages SET 
  from_user_id = FLOOR(1 + RAND() * 200),
  to_user_id = FLOOR(1 + RAND() * 200);
-- Приводим в порядок временные метки
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;                  
-- Проверка внесенных изменений в данные пользователей, вывод строк, где updated_at меньше created_at.
SELECT * FROM messages WHERE updated_at < created_at;
 


-- Доработка таблицы media_types
-- Анализируем типы медиаконтента
SELECT * FROM media_types;
-- Удаляем все типы
DELETE FROM media_types;
-- Добавляем нужные типы
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;
-- Для обнуления счетчика поля id применяем TRUNCATE, и заново добавляем данные типов контента
TRUNCATE media_types;


-- Доработка таблицы media
-- Смотрим структуру таблицы
DESC media;
-- Анализируем данные
SELECT * FROM media;
-- Обновляем данные для ссылки на тип файла
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
-- Обновляем данные для ссылки на владельца файла
UPDATE media SET user_id = FLOOR(1 + RAND() * 200);

-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('pdf'), ('xlsx');
-- Проверяем
SELECT * FROM extensions;
-- Обновляем ссылку на файл
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);
-- Обновляем размер файлов
UPDATE media SET size = FLOOR(15000 + (RAND() * 1000000)) WHERE `size` < 15000;
-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  
-- изменение типа столбца в JSON
ALTER TABLE media MODIFY COLUMN metadata JSON;
-- Смотрим структуру таблицы
DESC media;
-- Анализируем данные
SELECT * FROM media;



-- Доработка таблицы friendship_statuses
 -- Анализируем данные 
SELECT * FROM friendship_statuses;
-- Очищаем таблицу
TRUNCATE friendship_statuses;
-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 


-- Доработка таблицы friendship
-- Смотрим структуру таблицы дружбы
DESC friendships;
-- Анализируем данные
SELECT * FROM friendships;
-- переименование таблицы
RENAME TABLE friendship TO friendships;
 -- Анализируем данные 
-- Смотрим структуру таблицы дружбы
DESC friendships;
-- Обновляем ссылки на статус 
UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3); 
-- Обновляем ссылки на друзей
UPDATE friendships SET 
  user_id = FLOOR(1 + RAND() * 200),
  friend_id = FLOOR(1 + RAND() * 200);



-- Смотрим структуру таблицы групп
DESC communities;
-- Анализируем данные
SELECT * FROM communities;
-- Удаляем часть групп, оставляем 25 групп
DELETE FROM communities WHERE id > 25;
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;                  
-- Проверка внесенных изменений в данные пользователей, вывод строк, где updated_at меньше created_at.
SELECT * FROM communities WHERE updated_at < created_at;



-- Анализируем таблицу связи пользователей и групп
SELECT * FROM communities_users;
-- Изменение принадлежности пользователей к группе
UPDATE communities_users SET community_id = 1 + FLOOR(RAND()*25),
                             user_id      = 1 + FLOOR(RAND()*200);
