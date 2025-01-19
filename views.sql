-- Objetivo: Panorama geral de eficiência de um funcionário no mês. Fornece a média do valor das vendas, a quantidade de vendas realizadas e o valor total vendido no mês.
CREATE OR REPLACE VIEW vendas_mensais_funcionarios
(nome_funcionario, mes_venda, media_vendas, quantidade_vendas, valor_total_vendas)
AS
SELECT 
    c.nome AS nome_funcionario,
    DATE_FORMAT(v.data_venda, '%Y-%m') AS mes_venda,
    AVG(v.total) AS media_vendas,
    COUNT(v.cod) AS quantidade_vendas,
    SUM(v.total) AS valor_total_vendas
FROM 
    subordinado su
JOIN 
    colaborador c ON su.cod_colaborador = c.cod
JOIN 
    venda v ON c.cod = v.cod_colaborador
GROUP BY 
    c.nome, DATE_FORMAT(v.data_venda, '%Y-%m');


-- Objetivo: Permitir que a equipe da gerência identifique rapidamente os produtos com baixo estoque.
CREATE VIEW Produtos_Baixo_Estoque
AS SELECT 
    p.cod AS ID_Produto,
    p.nome AS Nome_Produto,
    p.quant AS Estoque_Restante
FROM 
    produto p
WHERE 
    p.quant < 10;

--Objetivo: Identificar inconsistências no orçamento feito fornecedor a partir da lista dada
CREATE VIEW Inconsistencia_Orcamento AS
SELECT 
    lp.cod AS ID_Lista,
    o.cod AS ID_Orcamento,
    f.nome AS Nome_Fornecedor,
    p.nome AS Nome_Produto,
    (lp.quant - op.quant) AS Diferenca 
FROM 
    orcamento_produto op
INNER JOIN
    lista_produto lp ON op.cod_produto = lp.cod_produto
INNER JOIN
    produto p ON op.cod_produto = p.cod
INNER JOIN
    orcamento o ON o.cod = op.cod_orcamento
INNER JOIN
    fornecedor f ON f.cod = o.cod_fornecedor
WHERE 
    lp.quant != op.quant;

-- Objetivo: Ter informações detalhadas sobre os produtos, incluindo o estoque disponível
CREATE VIEW Estoque_Preco_Produto AS
SELECT 
    p.cod AS cod_produto,
    p.nome AS nome_produto,
    p.quant AS estoque_disponivel,
    MIN(hp.preco) AS menor_preco,
    MAX(hp.preco) AS maior_preco,
    AVG(hp.preco) AS preco_medio
FROM 
    produto p
LEFT JOIN 
    historico_preco hp ON p.cod = hp.cod_produto
GROUP BY 
    p.cod, p.nome;
