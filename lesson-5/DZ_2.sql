-- ������������ ������� ���� ���������� ������� 
-- ������� �������� � �� vk, ������� ������� �������� � ���������� ������ �� ����.
USE vk;
-- ������� 1.
-- ����������� ������� ������� ������������� � ������� users.
SELECT avg((YEAR(CURRENT_DATE)-YEAR(birthday))) AS age FROM users
INNER JOIN profiles ON id = user_id;


-- ������� 2.
-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
SELECT DAYNAME(concat(2020,'-', MONTH(birthday),'-', DAY(birthday))) AS day_name, count(*) FROM users
JOIN profiles ON id = user_id
GROUP BY day_name;