-- database for servletcrud
create database if not exists servletcrud;
use servletcrud;
-- create table for users
create table if not exists users (
    id int(3) primary key auto_increment,
    name varchar(30) not null,
    email varchar(30) not null,
    country varchar(30) not null
);