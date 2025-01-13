-- 1- consulta: Obter a data de entrega feita por um fornecedor X que contenha um produto Y

 SELECT e.data_ent FROM entrega AS e, entrega_produto AS ep WHERE e.cod = ep.cod_entrega; 

-- #2-  consulta: Verificar a quantidade em estoque de um produto X

 SELECT p.quant FROM produto AS p WHERE p.nome = "?" ;

-- #3- consulta: Obter quantidade de atrasos de um funcionário X em no dia

 SELECT c.nome, c.ponto FROM colaborador As c WHERE c.ponto >"2024-01-01 9:00";

--#4- Consulta: Retornar o CNPJ de todos os fornecedores contratados pelo gerente x na data y

 SELECT c.cnpj FROM contrata AS c WHERE c.cpf_gerente = "x" AND c.data = 'y';

-- #5- Retorna todos os codigos de entregas de um produto

SELECT ep.cod_entrega FROM entrega_produto AS ep , produto AS p WHERE ep.cod_prod = p.cod;

-- #6- Retorna o cliente com maior numero de pontos no cartão fidelidade e o número de pontos:

SELECT c.nome, MAX(c_pontos) AS MAIOR_PONTO FROM cliente AS c;

-- #7- Quantidade de produtos vendidos em uma venda X

SELECT vp.quant FROM venda_produto AS vp WHERE vp.cod = 'x';

-- #8- Retorna cpf dos funcionários que tem a função X

SELECT cf.cpf FROM colaborador_funcionario AS cf WHERE cf.funcao = 'x';

#9- Retorna as formas de pagamento cadastradas por um cliente

SELECT fp.tipo
FROM cliente AS cl JOIN cadastrar AS cad ON cl.cod = cad.cod_cliente
JOIN forma_pagamento AS fp ON cl.cod = fp.cod_cliente
WHERE cl.nome  = "x";

-- #10- Retorna o produto mais vendido

SELECT p.nome, MAX(p.quant) AS MAIOR_QUANTIDADE FROM produto AS p;  

