-- 1- consulta: Obter a data de entrega feita por um fornecedor X que contenha um produto Y

 SELECT e.data_ent FROM entrega AS e, entrega_produto AS ep WHERE e.cod = ep.cod_entrega; 

-- #2-  consulta: Encontra o produto mais vendido dado um range de tempo

   SELECT p.nome
    INTO produto_nome
    FROM venda_produto vp
    INNER JOIN produto p 
    ON vp.cod = p.cod
    INNER JOIN venda v 
    ON vp.nota_fiscal = v.nota_fiscal
    WHERE v.data_venda BETWEEN data_inicio AND data_fim
    GROUP BY p.cod, p.nome
    ORDER BY SUM(vp.quant) DESC
    LIMIT 1;


-- #3- consulta: Obter quantidade de atrasos de um funcionário X em no dia

 SELECT c.nome, c.ponto FROM colaborador As c WHERE c.ponto >"2024-01-01 9:00";

--#4- Consulta: Retornar o CNPJ de todos os fornecedores contratados pelo gerente x na data y

 SELECT c.cnpj FROM contrata AS c WHERE c.cpf_gerente = "x" AND c.data = 'y';

-- #5- Retorna todos os codigos de entregas de um produto

SELECT ep.cod_entrega FROM entrega_produto AS ep , produto AS p WHERE ep.cod_prod = p.cod;

-- #6- Retorna o cliente com maior numero de pontos no cartão fidelidade e o número de pontos:

SELECT c.nome, MAX(c_pontos) AS MAIOR_PONTO 
FROM cliente AS c 
GROUP BY c.nome
ORDER BY MAIOR_PONTO DESC LIMIT 1;

-- #7- Consulta: Seleciona o preço mais comprado com base nas vendas

 SELECT hp.preco 
    INTO preco_mais_comprado
    FROM venda_produto vp
    JOIN venda v 
    ON vp.nota_fiscal = v.nota_fiscal
    JOIN historico_preco hp
    ON vp.cod = hp.cod_produto 
    AND v.data BETWEEN hp.data_inicio AND COALESCE(hp.data_fim, CURRENT_DATE)
    WHERE vp.nota_fiscal = v.nota_fiscal
    GROUP BY hp.preco
    ORDER BY SUM(vp.quant) DESC
    LIMIT 1;

-- #8- Retorna cpf dos funcionários que tem a função X

SELECT cf.cpf FROM colaborador_funcionario AS cf WHERE cf.funcao = 'x';

#9- Retorna as formas de pagamento cadastradas por um cliente

SELECT fp.tipo
FROM cliente AS cl JOIN cadastrar AS cad ON cl.cod = cad.cod_cliente
JOIN forma_pagamento AS fp ON cl.cod = fp.cod_cliente
WHERE cl.nome  = "x";

-- #10- Retorna o produto mais vendido

SELECT p.nome, MAX(p.quant) AS MAIOR_QUANTIDADE 
FROM produto AS p 
GROUP BY p.nome
ORDER BY MAIOR_QUANTIDADE 
DESC LIMIT 1;  

