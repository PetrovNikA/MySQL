-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT max(target_id) AS summ, gender from( 
SELECT likes.target_id, profiles.gender
FROM likes, users, profiles
WHERE 
	likes.user_id = users.id
	AND profiles.user_id = likes.user_id
GROUP BY gender
) AS tabl;