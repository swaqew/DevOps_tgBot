CREATE ROLE repl_user WITH REPLICATION PASSWORD '123' LOGIN;
CREATE DATABASE PostgreSQL owner "postgres";
\c postgresql postgres;
CREATE TABLE emails (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);
CREATE TABLE phones (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL
);
insert into emails(email) values('123@123.ru'),('test_00@test.ru');
insert into phones(phone_number) values('8(123) 132-44-44'),('81231232233');
