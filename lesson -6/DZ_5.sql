-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

-- критерии активности: 1. Добавление друзей. 2. Публикация постов 3. Загрузка файлов 



SELECT active AS user_id, count(active) AS Activ FROM 
(
SELECT user_id AS active
FROM friendships
UNION all
SELECT user_id AS active
FROM posts
UNION all
SELECT user_id AS active
FROM media
) AS tb_activ
GROUP BY active
ORDER BY Activ
LIMIT 10;