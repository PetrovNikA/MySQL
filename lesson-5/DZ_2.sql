-- Практическое задание теме «Агрегация данных» 
-- Запросы применяю к БД vk, поэтому скрипты создания и заполнения таблиц не пишу.
USE vk;
-- Задание 1.
-- Подсчитайте средний возраст пользователей в таблице users.
SELECT avg((YEAR(CURRENT_DATE)-YEAR(birthday))) AS age FROM users
INNER JOIN profiles ON id = user_id;


-- Задание 2.
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT DAYNAME(concat(2020,'-', MONTH(birthday),'-', DAY(birthday))) AS day_name, count(*) FROM users
JOIN profiles ON id = user_id
GROUP BY day_name;