--������� ������ �����������
CREATE TABLE IF NOT EXISTS like_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT "������������� ������",
  media_id INT UNSIGNED NOT NULL COMMENT "������ �� ���� ����� �� id",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ������� �������� ����",
  likes BOOLEAN COMMENT "������� �����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������",
  PRIMARY KEY (media_id, user_id) COMMENT "��������� ��������� ����"
) COMMENT "����� �����������";

--������� ������ �������������
CREATE TABLE IF NOT EXISTS like_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ������� �������� ����",
  user_likes INT UNSIGNED NOT NULL COMMENT "������ �� ������������, �������� ��������� ����",
  likes BOOLEAN COMMENT "������� �����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������",
  PRIMARY KEY (user_id, user_likes) COMMENT "��������� ��������� ����"
) COMMENT "����� �����������";