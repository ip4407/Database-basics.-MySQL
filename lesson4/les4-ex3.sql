/*Урок 4. Вебинар. CRUD-операции
1) Написать запрос для переименования названий типов медиа (колонка name в media_types), которые вы получили в пункте 3 в image, audio, video, document.
2) Написать запрос, удаляющий заявки в друзья самому себе.*/

-- использование заполненой БД vk_data
USE vk_data;

-- Просмотр данных в таблице  media_types
SELECT * FROM media_types;

-- Переименования названий типов медиа (колонка name в media_types)
UPDATE media_types SET name = 'image' WHERE id = 1;
UPDATE media_types SET name = 'audio' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'document' WHERE id = 4;

-- Просмотр данных в таблице  media_types
SELECT * FROM friend_requests;

-- Просмотр таблицы friend_requests на предмет наличия запросов самому себе. 
SELECT * FROM friend_requests WHERE from_user_id = to_user_id;

-- Т.к. в нашей таблице нет запросов самому себе, то добавим их принудительно
INSERT INTO friend_requests (from_user_id, to_user_id)
VALUES (1, 1), (2, 2),(3, 3),(10, 10),(11, 11),(12, 12), (20, 20), (21, 21), (22, 22);

-- Просмотр таблицы friend_requests на предмет наличия запросов самому себе. 
SELECT * FROM friend_requests WHERE from_user_id = to_user_id;

-- Удаление заявки в друзья самому себе в таблице friend_requests.
DELETE FROM friend_requests WHERE from_user_id = to_user_id;
