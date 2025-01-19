-- Active: 1736634064306@@127.0.0.1@3306@mercado_vinicius
#criar base da dados
CREATE DATABASE HortFruit;

#criar tabelas
DROP TABLE IF EXISTS cliente;
CREATE TABLE IF NOT EXISTS cliente(
	cod INT AUTO_INCREMENT,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	pontos INT DEFAULT 0,

	UNIQUE(cpf),
	PRIMARY KEY (cod)
) ;

DROP TABLE IF EXISTS categoria;
CREATE TABLE IF NOT EXISTS categoria(
	cod INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(20) NOT NULL,
	tipo VARCHAR(20) NOT NULL,

	PRIMARY KEY (cod)
);

DROP TABLE IF EXISTS produto;
CREATE TABLE IF NOT EXISTS produto(
	cod INT NOT NULL AUTO_INCREMENT ,
	cod_categoria INT NOT NULL,
	nome VARCHAR(30) NOT NULL,
	quant INT NOT NULL,
	valor_unitario DECIMAL(5,2) NOT NULL,

	FOREIGN KEY (cod_categoria) REFERENCES categoria(cod) ON DELETE RESTRICT,
	UNIQUE(nome),
	PRIMARY KEY (cod)
);

-- Tabela que registra as alterações de preço
DROP TABLE IF EXISTS historico_preco;
CREATE TABLE IF NOT EXISTS historico_preco (
	cod INT NOT NULL AUTO_INCREMENT,
	cod_produto INT NOT NULL,
	preco DECIMAL(5,2) NOT NULL,
	data_inicio DATETIME,
	data_fim DATETIME,

	PRIMARY KEY (cod),
	FOREIGN KEY (cod_produto) REFERENCES produto (cod) ON DELETE RESTRICT
);


DROP TABLE IF EXISTS colaborador;
CREATE TABLE IF NOT EXISTS colaborador(
	cod INT NOT NULL AUTO_INCREMENT,
 	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(255) NOT NULL,
	ativo BOOLEAN DEFAULT TRUE,
	PRIMARY KEY (cod),
	UNIQUE(cpf)
);

DROP TABLE IF EXISTS gerente;
CREATE TABLE IF NOT EXISTS gerente(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_colaborador INT NOT NULL,

	PRIMARY KEY (cod),
	FOREIGN KEY (cod_colaborador) REFERENCES colaborador(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS subordinado;
CREATE TABLE IF NOT EXISTS subordinado(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_colaborador INT NOT NULL,
	cod_gerente INT NOT NULL,

	PRIMARY KEY (cod),
	FOREIGN KEY (cod_colaborador) REFERENCES colaborador(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_gerente) REFERENCES gerente(cod) ON DELETE RESTRICT
);

DROP TABLE IF EXISTS venda;
CREATE TABLE IF NOT EXISTS venda(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_colaborador INT NOT NULL,
	cod_cliente INT,
	total DECIMAL(20, 2) DEFAULT 0.00,
	data_venda DATE NOT NULL,


	PRIMARY KEY(cod),
	FOREIGN KEY (cod_colaborador) REFERENCES colaborador(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_cliente) REFERENCES cliente(cod) ON DELETE SET NULL
);

DROP TABLE IF EXISTS venda_produto;
CREATE TABLE IF NOT EXISTS venda_produto(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_venda INT NOT NULL,
	cod_produto INT NOT NULL,
	quant INT NOT NULL,
	valor_unitario DECIMAL(5,2),
	valor DECIMAL(10,2),

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_venda) REFERENCES venda(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_produto) REFERENCES produto(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS fornecedor;
CREATE TABLE IF NOT EXISTS fornecedor(
	cod INT NOT NULL AUTO_INCREMENT,
	cnpj VARCHAR(14) NOT NULL UNIQUE,
	nome VARCHAR(255) NOT NULL,
	endereco VARCHAR(255) NOT NULL, 
	telefone VARCHAR(11) NOT NULL,

	PRIMARY KEY(cod)
);
DROP TABLE IF EXISTS lista;
CREATE TABLE IF NOT EXISTS lista(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_gerente INT NOT NULL,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_gerente) REFERENCES gerente(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS lista_produto;
CREATE TABLE IF NOT EXISTS lista_produto(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_lista INT NOT NULL,
	cod_produto INT NOT NULL,
	quant INT NOT NULL,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_lista) REFERENCES lista(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_produto) REFERENCES produto(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS lista_fornecedor;
CREATE TABLE IF NOT EXISTS lista_fornecedor(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_lista INT NOT NULL,
	cod_fornecedor INT NOT NULL,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_lista) REFERENCES lista(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS orcamento;
CREATE TABLE IF NOT EXISTS orcamento(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_fornecedor INT NOT NULL,
	total DECIMAL(30, 2) DEFAULT 0,
	foi_aprovado BOOLEAN DEFAULT FALSE,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS orcamento_produto;
CREATE TABLE IF NOT EXISTS orcamento_produto(
	cod INT NOT NULL AUTO_INCREMENT,
	cod_orcamento INT NOT NULL,
	cod_produto INT NOT NULL,
	quant INT NOT NULL,
	valor_custo_unitario DECIMAL(5,2) NOT NULL,
	valor_custo_total DECIMAL(20, 2) DEFAULT 0,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_orcamento) REFERENCES orcamento(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_produto) REFERENCES produto(cod) ON DELETE RESTRICT
);
DROP TABLE IF EXISTS lista_orcamento;
CREATE TABLE IF NOT EXISTS lista_orcamento (
	cod INT NOT NULL AUTO_INCREMENT,
	cod_lista INT NOT NULL,
	cod_orcamento INT NOT NULL,

	PRIMARY KEY(cod),
	FOREIGN KEY (cod_lista) REFERENCES lista(cod) ON DELETE RESTRICT,
	FOREIGN KEY (cod_orcamento) REFERENCES orcamento(cod) ON DELETE RESTRICT
);