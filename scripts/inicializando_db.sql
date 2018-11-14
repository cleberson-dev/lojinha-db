CREATE DATABASE IF NOT EXISTS lojinha;
USE lojinha;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS estados;

CREATE TABLE produtos(
	produto_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco FLOAT(9, 2) UNSIGNED NOT NULL
);

CREATE TABLE estados(
	estado_id INT AUTO_INCREMENT PRIMARY KEY,
    estado_nome VARCHAR(50) NOT NULL,
    capital VARCHAR(50),
    regiao VARCHAR(50) NOT NULL CHECK (regiao IN ('Norte', 'Nordeste', 'Centro-Oeste', 'Sul', 'Sudeste'))
);

CREATE TABLE clientes(
	cliente_id INT AUTO_INCREMENT PRIMARY KEY,
	cliente_nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('M', 'F')),
    premium BOOLEAN NOT NULL DEFAULT FALSE,
    estado_id INT,
    FOREIGN KEY estado_id(estado_id) REFERENCES estados(estado_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE vendas(
	venda_id INT auto_increment PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    data_venda DATETIME DEFAULT NOW(),
    FOREIGN KEY cliente_id(cliente_id) REFERENCES clientes(cliente_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY produto_id(produto_id) REFERENCES produtos(produto_id) ON DELETE SET NULL ON UPDATE CASCADE
);