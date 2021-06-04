-- Показать список БД
SHOW DATABASES;
-- Показать расположение БД
SHOW VARIABLES LIKE 'datadir'; 
-- Показать список таблиц БД mysql
SHOW TABLES FROM mysql;
-- Извлечь из таблицы user БД mysql поля user и host
SELECT mysql.user.user, mysql.user.host FROM mysql.user;
-- Просмотреть информационную схему
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;

-- Создать БД example
CREATE DATABASE IF NOT EXISTS example;
SHOW DATABASES;
-- Использовать по умолчанию БД example
USE example;

-- Создать таблицу users
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL COMMENT 'User Name'
) COMMENT 'Users table';
-- Просмотреть структуру таблицы users
DESCRIBE users;