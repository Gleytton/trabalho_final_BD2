-- #1  Consulta: Verificar a quantidade em estoque do produto mais vendido
SELECT 
    p.nome AS produto,
    SUM(vp.quant) AS total_vendido,
    p.quant AS estoque_atual
FROM 
    venda_produto vp
INNER JOIN 
    produto p ON vp.cod_produto = p.cod
GROUP BY 
    p.cod, p.nome, p.quant
ORDER BY 
    total_vendido DESC
LIMIT 1;

--#2- Consulta: Retornar o Nome e CNPJ de todos os fornecedores contratados pelo gerente x na data y

SELECT 
    fo.cnpj,
    fo.nome
FROM 
    lista li
INNER JOIN 
    lista_fornecedor lf ON li.cod = lf.cod_lista
INNER JOIN
    fornecedor fo ON lf.cod_fornecedor = fo.cod
WHERE li.cod_gerente = 1;

-- #3- Retorna o valor total gasto por cada fornecedor (obs: com orçamentos aprovados)
SELECT 
    fo.cnpj,
    fo.nome,
    SUM(o.total)
FROM 
    orcamento o
INNER JOIN 
    fornecedor fo ON o.cod_fornecedor = fo.cod
INNER JOIN
    orcamento_produto op ON o.cod = op.cod_orcamento
WHERE 
    o.foi_aprovado = FALSE
GROUP BY fo.cnpj, fo.nome;

-- #4- Retorna o cliente com maior numero de pontos no cartão fidelidade e o número de pontos:
SELECT c.nome AS Nome_Cliente, c.pontos AS Numero_Pontos
FROM cliente AS c 
ORDER BY Numero_Pontos DESC LIMIT 1;

-- #5- Retorna o nome do fornecedor com mais orçamentos aprovados
SELECT fo.nome, COUNT(*) AS total_aprovados
FROM fornecedor fo
INNER JOIN orcamento o ON fo.cod = o.cod_fornecedor
WHERE o.foi_aprovado = TRUE
GROUP BY fo.nome
ORDER BY total_aprovados DESC
LIMIT 1;
 

-- #6- Retorna cpf, nome e quantidade de compras do funcionário que mais cadastrou vendas
SELECT co.cpf, co.nome, COUNT(*) AS quantidade_compras
FROM colaborador co
INNER JOIN venda ve ON co.cod = ve.cod_colaborador
GROUP BY co.cod
ORDER BY quantidade_compras DESC
LIMIT 1; 

-- #7 Consulta para obter o nome do produto mais vendido
SET @data_inicio = '2025-01-01';
SET @data_fim = '2025-01-18';

SELECT p.nome
FROM venda_produto vp
INNER JOIN produto p 
ON vp.cod = p.cod
INNER JOIN venda v 
ON vp.cod = v.cod
WHERE v.data_venda BETWEEN @data_inicio AND @data_fim
GROUP BY p.cod, p.nome
ORDER BY SUM(vp.quant) DESC
LIMIT 1;
 
-- #8 Seleciona o preço mais comprado com base nas vendas
SELECT hp.preco 
INTO preco_mais_comprado
FROM venda_produto vp
JOIN venda v 
ON vp.cod = v.cod
JOIN historico_preco hp
ON vp.cod = hp.cod_produto 
AND v.data_criacao BETWEEN hp.data_inicio AND COALESCE(hp.data_fim, CURRENT_DATE)
WHERE vp.cod = v.cod
GROUP BY hp.preco
ORDER BY SUM(vp.quant) DESC
LIMIT 1;

-- #9 Seleciona o menor preço já registrado de um produto
SELECT 
    hp.cod_produto,
    p.nome AS produto,
    MIN(hp.preco) AS menor_preco
FROM 
    historico_preco hp
INNER JOIN 
    produto p ON hp.cod_produto = p.cod
GROUP BY 
    hp.cod_produto, p.nome
ORDER BY 
    menor_preco ASC
LIMIT 1;

-- #10 Seleciona o menor preço já registrado determinado um produto
SELECT 
    hp.cod_produto,
    p.nome AS produto,
    MIN(hp.preco) AS menor_preco
FROM 
    historico_preco hp
INNER JOIN 
    produto p ON hp.cod_produto = p.cod
WHERE 
    hp.cod_produto = 'Refrigerante 1L'
GROUP BY 
    hp.cod_produto, p.nome;
