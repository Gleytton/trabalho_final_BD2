#criar base da dados

CREATE DATABASE IF NOT EXIST HortFruit;

#criar tabelas

CREATE TABLE IF NOT EXIST cliente(

	cod int AUTO_INCREMENT NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	UF VARCHAR(2) NOT NULL, 
	telefone VARCHAR(10) NOT NULL,
	numero_cartao VARCHAR(16) NOT NULL,
	bandeira VARCHAR(15) NOT NULL,
	dataEmissao DATE NOT NULL,
	validade DATE NOT NULL,
	codSeguranca VARCHAR(5) NOT NULL,

	PRIMARY KEY(cod,numero)
) 

CREATE TABLE IF NOT EXIST forma_pagamento(

	cod INT AUTO_INCREMENT NOT NULL,
	tipo VARCHAR(10) NOT NULL,

	PRIMARY KEY(cod)
)

CREATE TABLE IF NOT EXIST cadastrar(

	cod_cliente INT AUTO_INCREMENT NOT NULL,	
	cod_pagCad INT AUTO_INCREMENT NOT NULL,

	CONSTRAINT fk_cliente_cadastro FOREIGN KEY cod_cliente REFERENCES cliente(cod)
	cONSTRAINT fk_forma_pagamento_cadastro FOREIGN KEY cod_pagCad REFERENCES forma_pagamento(cod)

	PRIMARY KEY (cod_cliente, cod_pagCad)
)


# TABELA cartao_fidelidade FUI FUNDIDA A TABELA cliente 


#fusao das tabelas produto e estoque

# adicao de coluna da tabela Historico_Preco e na tabela  Produto

CREATE TABLE IF NOT EXIST produto(

	cod VARCHAR(10) NOT NULL,
	nome VARCHAR(20) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	quant INT NOT NULL,
	valor_unitario REAL(4,2) NOT NULL,
	data DATETIME NOT NULL,

	PRIMARY KEY(cod)
)


CREATE TABLE IF NOT EXIST categoria(

	cod VARCHAR(10) NOT NULL,
	nome VARCHAR(20) NOT NULL,
	tipo VARCHAR(10) NOT NULL,

	PRIMARY KEY(cod)
)

CREATE TABLE IF NOT EXIST produto_categoria(

	cod_prod VARCHAR(10) NOT NULL,
	cod_cat VARCAHR(10) NOT NULL

	CONSTRAINT fk_Prod_ProdCat FOREIGN KEY(cod_prod) REFERENCES produto(cod),
	CONSTRAINT fk_Cat_ProdCat FOREIGN KEY(cod_cat) REFERENCES categoria(cod),

	PRIMARY KEY (cod_prod)

)


#Adição de coluna da tabela ponto na tabela colaborador

CREATE TABLE IF NOT EXIST colaborador(

 	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	UF VARCHAR(2) NOT NULL, 
	telefone VARCHAR(10) NOT NULL,
	ponto DATETIME,
	atribuicao VARCHAR(100) NOT NULL,
	PRIMARY KEY(cpf)
)

CREATE TABLE IF NOT EXIST colaborador.gerente(

	area VARCHAR(10) NOT NULL,
)

CREATE TABLE IF NOT EXIST colaborador.funcionario(

	funcao VARCHAR(50) NOT NULL

)


CREATE TABLE IF NOT EXIST venda(

	nota_fiscal VARCHAR(20) NOT NULL,
	nome_produto VARCHAR(20) NOT NULL,
	nome_funcionario VARCHAR(50) NOT NULL,
	nome_cliente VARCHAR(50) NOT NULL,

	CONSTRAINT fk_venda_funcionario FOREIGN KEY nome_funcionario REFERENCES funcionario(nome)
	CONSTRAINT fk_venda_cliente FOREIGN KEY nome_cliente REFERENCES cliente(nome)

	PRIMARY KEY(nota_fiscal)


CREATE TABLE IF NOT EXIST venda_produto(

	nota_fiscal VARCHAR(20) NOT NULL,	
	cod VARCHAR(10) NOT NULL,
	quant INT NOT NULL,
	valor_unitario REAL(4,2) NOT NULL,
	valor REAL(4,2) NOT NULL,

	CONSTRAINT fk_venda_venda_produto FOREIGN KEY nota_fiscal REFERENCES venda(nota_fiscal)
	CONSTRAINT fk_produto_venda_produto FOREIGN KEY cod REFERENCES produto(cod)

	PRIMARY KEY(nota_fiscal,cod)

)

CREATE TABLE IF NOT EXIST fornecedor(

	cnpj VARCHAR(20) NOT NULL,
	nome VARCHAR(20) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	UF VARCHAR(2) NOT NULL, 
	telefone VARCHAR(10) NOT NULL,

	PRIMARY KEY(cnpj)
)

CREATE TABLE IF NOT EXIST contrata(

	cpf_gerente VARCHAR(11) NOT NULL,
	cnpj_fornecedor VARCHAR(20) NOT NULL,
	data DATETIME,

	CONSTRAINT fk_Funcionario_Contrata FOREIGN KEY cpf_gerente REFERENCES colaborador(cpf) ,
	CONSTRAINT fk_Fornecedor_Contrata FOREIGN KEY cnpj_fornecedor REFERENCES fornecedor(cnpj),

	PRIMARY KEY (cpf_gerente, cnpj_fornecedor)
)


CREATE TABLE IF NOT EXIST entrega(

	cod VARCHAR(10) NOT NULL,
	nome_cliente VARCHAR(50)
	data_ent DATETIME, NOT NULL
 
	PRIMARY KEY(cod)

)

CREATE TABLE IF NOT EXIST fornecedor_entrega(

	cnpj_fornecedor VARCHAR(20) NOT NULL,
	cod_entrega VARCHAR(10) NOT NULL,

	PRIMARY KEY(cnpj_fornecedor,cod_entrega),

	CONSTRAINT fk_fornecedor_fornecedor_entrega FOREIGN KEY cnpj_fornecedor REFERENCES fornecedor(cnpj),
	CONSTRAINT fk_entrega_fornecedor_entrega FOREIGN KEY cod_entrega REFERENCES entrega(cod)
)

CREATE TABLE IF NOT EXIST entrega_produto(

	cod_prod VARCHAR(10) NOT NULL,
	cod_entrega VARCHAR(10) NOT NULL,

	PRIMARY KEY(cod_prod,cod_entrega),

	CONSTRAINT fk_produto_entrega_produto FOREIGN KEY cod_prod REFERENCES produto(cod),

	CONSTRAINT fk_entrega_entrega_produto FOREIGN KEY cod_entrega REFERENCES entrega(cod)


)