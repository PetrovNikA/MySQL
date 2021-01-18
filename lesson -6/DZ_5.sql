-- 5. ����� 10 �������������, ������� ��������� ���������� ���������� �
-- ������������� ���������� ����
-- (�������� ���������� ���������� ���������� ��������������).

-- �������� ����������: 1. ���������� ������. 2. ���������� ������ 3. �������� ������ 



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