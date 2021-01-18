-- 4. ѕодсчитать количество лайков которые получили 10 самых молодых пользователей.

SELECT sum(sum_likes) AS sum_likes FROM (
SELECT likes.target_id, users.first_name, users.last_name, profiles.birthday, count(target_id) AS sum_likes 
FROM likes likes, users users, profiles profiles
WHERE 
	likes.user_id = users.id
	AND profiles.user_id = likes.user_id
GROUP BY target_id
ORDER BY birthday
LIMIT 10
) AS tabl;