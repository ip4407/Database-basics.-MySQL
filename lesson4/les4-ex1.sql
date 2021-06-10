/* 
  C - Create = INSERT
  R - Read   = SELECT
  U - Update = UPDATE
  D - Delete = DELETE
*/

/*
 * INSERT
 * https://dev.mysql.com/doc/refman/8.0/en/insert.html
 */

USE vk;

DESCRIBE users;

-- добавляем пользователя
-- не указываем названия колонок
INSERT INTO users
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', 'aaa', DEFAULT);

SELECT * FROM users;

-- не указываем default значения
-- добавляем повторно того же пользователя, ошибка не возникает
INSERT IGNORE INTO users (first_name, last_name, email, phone, password_hash)
VALUES ('Alex', 'Stepanov', 'alex@mail.com', '89213546566', 'aaa');
-- явно задаем id
INSERT INTO users (id, first_name, last_name, email, phone, password_hash, created_at)
VALUES (13, 'Lena', 'Stepanova', 'lena@mail.com','89213546568','ghjgjhg','2020-01-01 00:00:00');

-- явно задаем id
INSERT INTO users (id, first_name, last_name, email, phone) VALUES 
(55, 'Jane', 'Kvanov', 'jane@mail.com', '89293546560');

-- добавляем несколько пользователей
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Igor', 'Petrov', 'igor@mail.com', '89213549560'),
       ('Oksana', 'Petrova', 'oksana@mail.com', '89213549561');
       
-- пробуем добавить id меньше текущего
INSERT INTO users (id, first_name, last_name, email, phone) VALUES 
(45, 'Jane', 'Night', 'jane_n@mail.com', '89293946560');

-- добавляем через SET

INSERT users
SET 
	first_name = 'Iren',
	last_name = 'Sidorova',
	email = 'iren@mail.com',
    phone = '89213541560';
   
    
-- добавляем через SELECT

-- Для того, чтобы добавить пользователей с другим форматом телефона, удаляем проверку по регулярному выражению
-- ALTER TABLE users DROP CONSTRAINT phone_check;

-- Вставляем данные в таблицу users из другой БД users_db таблицы users
INSERT users (first_name, last_name, email, phone)
SELECT first_name, last_name, email, phone FROM users_db.users;

/*
 * SELECT
 * https://dev.mysql.com/doc/refman/8.0/en/select.html
 */

-- выбираем константы

SELECT 1+4;

SELECT 'Hello!';

SELECT NOW();

-- выбираем все поля users
SELECT * FROM users;

-- выбираем фамилию и имя
SELECT last_name, first_name FROM users;

-- выбираем только неповторяющиеся фамилии и имена
SELECT DISTINCT first_name, last_name FROM users;

-- выбираем пользователей, у которых задан пароль
SELECT * FROM users WHERE password_hash IS NOT NULL;

-- ищем пользователя с фамилией Stepanov
SELECT * FROM users WHERE last_name = 'Stepanov';

-- ищем пользователя с фамилией Stepanov или Степанов
SELECT * FROM users WHERE last_name = 'Stepanov' OR last_name = 'Степанов';

-- ищем пользователей с фамилиями Stepanov, Sidorova, Гончарова, Сушкова
	WHERE last_name = 'Stepanov' 
		OR last_name = 'Sidorova' 
		OR last_name = 'Гончарова'
		OR last_name = 'Сушкова';
	
-- аналогично предыдущему запросу
SELECT * FROM users 
	WHERE last_name IN('Stepanov','Sidorova','Гончарова','Сушкова');

-- ищем пользователя с именем Ирина и фамилией Гончарова
SELECT * FROM users WHERE first_name = 'Ирина' AND last_name ='Гончарова';

-- Ищем пользователя Ирина, у которой фамилия Гончарова или Сушкова
SELECT * FROM users WHERE first_name = 'Ирина' AND (last_name = 'Сушкова' OR last_name ='Гончарова');

-- Ищем пользователей с фамилиями Сушкова и Гончарова, но которых не зовут Ирина
SELECT * FROM users WHERE first_name <> 'Ирина' AND (last_name = 'Сушкова' OR last_name ='Гончарова'); -- != <>

SELECT * FROM users;

-- выбираем пользователей, зарегистрировавшихся в 2000 году и позже
SELECT * FROM users WHERE created_at >= '2000-01-01 00:00:00';

-- выбираем пользователей, зарегистрировавшихся с 2000 по 2010 год
SELECT * FROM users WHERE created_at >= '2000-01-01 00:00:00' AND created_at <= '2010-01-01 00:00:00';

-- аналогично предыдущему запросу
SELECT * FROM users WHERE created_at BETWEEN '2021-01-01 00:00:00' AND '2021-12-31 00:00:00';

-- выбираем пользователей, зарегистрировавшихся в 2020 году и позже, используем встроенную функцию YEAR()
SELECT * FROM users WHERE YEAR(created_at) = '2020';

--используем встроенную функцию CONCAT(), чтобы объединить имя и фамилию
SELECT CONCAT(first_name,' ',last_name) AS name FROM users;

-- "вкладываем" функции друг в друга, используем SUBSTRING(), чтобы получить первую букву имени
SELECT CONCAT(SUBSTRING(first_name, 1,1),'. ',last_name) AS name FROM users;

-- выбираем пользователей с фамилиями, начинающимися на 'Stepanov'
SELECT * FROM users WHERE last_name LIKE 'Stepanov%';

-- выбираем 10 пользователей
SELECT * FROM users LIMIT 10;

-- пропускаем 5 пользователей и выбираем троих
SELECT * FROM users LIMIT 3 OFFSET 5;

-- аналогично предыдущему запросу
SELECT * FROM users LIMIT 5,3;

--отсортировываем пользователей по убыванию по фамилии
SELECT * FROM users ORDER BY last_name DESC;

-- считаем кол-во строк в таблице с пользователями
SELECT count(*) FROM users;

-- считаем кол-во пользователей, у которых задан пароль
SELECT count(password_hash) FROM users;

/*
 * UPDATE
 * https://dev.mysql.com/doc/refman/8.0/en/update.html 
*/

INSERT INTO messages VALUES (DEFAULT, 3, 1, 'Hello!', TRUE, DEFAULT, DEFAULT);

SELECT * FROM messages;

-- изменяем текст сообщения с id = 3
UPDATE messages 
SET txt =  'I love you' WHERE id = 3;

/*
 * DELETE
 * https://dev.mysql.com/doc/refman/8.0/en/update.html 
 * TRUNCATE
 * https://dev.mysql.com/doc/refman/8.0/en/truncate-table.html
*/

SELECT * FROM users;

-- удаляем пользователей с фамилией Stepanov
DELETE FROM users WHERE last_name ='Stepanov';

-- удаляем все строки из таблицы сообщений
DELETE FROM messages;

INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (1, 2, 'Hi!');

INSERT INTO messages (from_user_id, to_user_id, txt)
VALUES (2, 1, 'I hate you!');

-- установить значение для auto_increment
ALTER TABLE messages AUTO_INCREMENT = 255;

-- очищаем таблицу messages
-- TRUNCATE TABLE messages;
-- очищаем таблицу users
-- TRUNCATE TABLE users;


-- отключаем проверку внешних ключей ( С ОСТОРОЖНОСТЬЮ!!!!)
/*SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;*/

