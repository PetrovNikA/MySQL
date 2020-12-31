--Таблица лайков медиафайлов
CREATE TABLE IF NOT EXISTS like_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT "Идентификатор строки",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл медиа по id",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  likes BOOLEAN COMMENT "Признак лайка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  PRIMARY KEY (media_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "лайки медиафайлов";

--Таблица лайков пользователей
CREATE TABLE IF NOT EXISTS like_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который поставил лайк",
  user_likes INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, которому поставили лайк",
  likes BOOLEAN COMMENT "Признак лайка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  PRIMARY KEY (user_id, user_likes) COMMENT "Составной первичный ключ"
) COMMENT "лайки медиафайлов";