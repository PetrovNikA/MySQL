CREATE database example;

use example;

create table if not exists users(
id SERIAL,
name VARCHAR(200) not null unique
);

mysqldump example > example.sql
CREATE DATABASE sample;
mysql sample < example.sql