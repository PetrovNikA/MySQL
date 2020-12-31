use vk;

-- ������� 1. ��������� ��� �������� �� ��������� �� vk.

-- ��������� ������� � ��������� ���������� �� ������� profiles

CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
  name VARCHAR(100) NOT NULL COMMENT "�������� ������� (���������)",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���������� �������� �������������";  

-- ������� ������� status � ������� profiles
UPDATE profiles SET status = NULL;

-- ��������� ����� ������� status �� status_id � ������� profiles
ALTER TABLE profiles RENAME COLUMN status TO status_id;

-- ��������� ���� ������ ������� status �� status_id � ������� profiles
ALTER TABLE profiles MODIFY COLUMN status_id INT UNSIGNED;

-- �������� ��������� ���������
DESC profiles;




-- ������� 2. ���������� ������ � ������� user_statuses
INSERT INTO user_statuses (name) VALUES ('single'),('married');


-- ������� 3. ��������� ��� �������� CRUD.
-- ��������� �������� ������


-- ��������� ������� users
-- ����������� ������ �������������
SELECT * FROM users LIMIT 10;
-- �������� � ������� ��������� �����
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                  
-- �������� ��������� ��������� � ������ �������������, ����� �����, ��� updated_at ������ created_at.
SELECT * FROM users WHERE updated_at < created_at;



-- ��������� ������� profiles
DESC profiles;
SELECT * FROM profiles;
-- �������� � ������� ��������� �����
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;     
-- ��������� ������ �� ���� (���������)
UPDATE profiles SET photo_id = 1 + FLOOR(RAND() * 200);
-- ��������� ���������� ����
CREATE TEMPORARY TABLE genders (name CHAR(1));
-- ���������� �������� �� ��������� �������
INSERT INTO genders VALUES ('m'), ('f'); 
-- �������� ����������� ������ �� ��������� �������
SELECT * FROM genders;
-- ���������� ������� ��� � ������� profiles
UPDATE profiles 
  SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);
-- ��������� ����� ������� status_id �� user_status_id � ������� profiles
ALTER TABLE profiles RENAME COLUMN status_id TO user_status_id;
-- ��������� ������ �� ������ ������������
UPDATE profiles SET user_status_id = FLOOR(1 + RAND() * 2);



-- ��������� ������� messages
-- ������� ��������� ������� ���������
DESC messages;
-- ����������� ������
SELECT * FROM messages LIMIT 10;
-- ��������� �������� ������ �� ����������� � ���������� ���������
UPDATE messages SET 
  from_user_id = FLOOR(1 + RAND() * 200),
  to_user_id = FLOOR(1 + RAND() * 200);
-- �������� � ������� ��������� �����
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;                  
-- �������� ��������� ��������� � ������ �������������, ����� �����, ��� updated_at ������ created_at.
SELECT * FROM messages WHERE updated_at < created_at;
 


-- ��������� ������� media_types
-- ����������� ���� �������������
SELECT * FROM media_types;
-- ������� ��� ����
DELETE FROM media_types;
-- ��������� ������ ����
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;
-- ��� ��������� �������� ���� id ��������� TRUNCATE, � ������ ��������� ������ ����� ��������
TRUNCATE media_types;


-- ��������� ������� media
-- ������� ��������� �������
DESC media;
-- ����������� ������
SELECT * FROM media;
-- ��������� ������ ��� ������ �� ��� �����
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
-- ��������� ������ ��� ������ �� ��������� �����
UPDATE media SET user_id = FLOOR(1 + RAND() * 200);

-- ������ ��������� ������� �������� �����������
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
-- ��������� ����������
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('pdf'), ('xlsx');
-- ���������
SELECT * FROM extensions;
-- ��������� ������ �� ����
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);
-- ��������� ������ ������
UPDATE media SET size = FLOOR(15000 + (RAND() * 1000000)) WHERE `size` < 15000;
-- ��������� ����������
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  
-- ��������� ���� ������� � JSON
ALTER TABLE media MODIFY COLUMN metadata JSON;
-- ������� ��������� �������
DESC media;
-- ����������� ������
SELECT * FROM media;



-- ��������� ������� friendship_statuses
 -- ����������� ������ 
SELECT * FROM friendship_statuses;
-- ������� �������
TRUNCATE friendship_statuses;
-- ��������� �������� �������� ������
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 


-- ��������� ������� friendship
-- ������� ��������� ������� ������
DESC friendships;
-- ����������� ������
SELECT * FROM friendships;
-- �������������� �������
RENAME TABLE friendship TO friendships;
 -- ����������� ������ 
-- ������� ��������� ������� ������
DESC friendships;
-- ��������� ������ �� ������ 
UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3); 
-- ��������� ������ �� ������
UPDATE friendships SET 
  user_id = FLOOR(1 + RAND() * 200),
  friend_id = FLOOR(1 + RAND() * 200);



-- ������� ��������� ������� �����
DESC communities;
-- ����������� ������
SELECT * FROM communities;
-- ������� ����� �����, ��������� 25 �����
DELETE FROM communities WHERE id > 25;
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;                  
-- �������� ��������� ��������� � ������ �������������, ����� �����, ��� updated_at ������ created_at.
SELECT * FROM communities WHERE updated_at < created_at;



-- ����������� ������� ����� ������������� � �����
SELECT * FROM communities_users;
-- ��������� �������������� ������������� � ������
UPDATE communities_users SET community_id = 1 + FLOOR(RAND()*25),
                             user_id      = 1 + FLOOR(RAND()*200);
