-- 2. Создать все необходимые внешние ключи и диаграмму отношений.

USE vk;

-- Добавляем внешние ключи в БД vk


-- Для таблицы профилей
-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_status_id_fk
    FOREIGN KEY (user_status_id) REFERENCES user_statuses(id);

-- Для таблицы сообщений
-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_users_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);


-- Для таблицы медиа
-- Добавляем внешние ключи
ALTER TABLE media
  ADD CONSTRAINT media_from_media_types_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_to_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE media  
  ADD CONSTRAINT media_posts_fk 
    FOREIGN KEY (id) REFERENCES posts(media_id);

-- Для таблицы communities_users
-- Добавляем внешние ключи
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_from_media_types_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_to_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);


-- Для таблицы friendships
-- Добавляем внешние ключи
ALTER TABLE friendships
  ADD CONSTRAINT friendships_friendship_statuses_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
ALTER TABLE friendships
  ADD CONSTRAINT friendships_users_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT users_friendships_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id);


-- Для таблицы likes
-- Добавляем внешние ключи
ALTER TABLE likes
  ADD CONSTRAINT likes_target_types_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);
ALTER TABLE likes
  ADD CONSTRAINT likes_users_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);   
   
-- Для таблицы posts
-- Добавляем внешние ключи   
ALTER TABLE posts
  ADD CONSTRAINT posts_users_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_communities_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id);
  ADD CONSTRAINT posts_media_fk 
    FOREIGN KEY (media_id) REFERENCES media(id),
