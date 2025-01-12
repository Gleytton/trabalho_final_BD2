 CREATE TABLE IF NOT EXISTS produto(

	cod VARCHAR(10) NOT NULL,
	nome VARCHAR(20) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	quant INT NOT NULL,
	valor_unitario DECIMAL(4,2) NOT NULL,
	data DATETIME NOT NULL,

	PRIMARY KEY(cod)
);

# consulta 2 
 SELECT quant FROM produto AS p WHERE p.nome = "?" 


 CREATE TABLE IF NOT EXISTS colaborador(

 	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	UF VARCHAR(2) NOT NULL, 
	telefone VARCHAR(10) NOT NULL,
	ponto DATETIME,
	atribuicao VARCHAR(100) NOT NULL,
	PRIMARY KEY(cpf)
);

 #consulta 7 

 SELECT c.nome, c.ponto FROM colaborador As c WHERE c.ponto BETWEEN "2024-01-01 9:00" and  "2024-02-01 9:00"