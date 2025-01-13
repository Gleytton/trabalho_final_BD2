-- Objetivo: Panorama geral de eficiência de um funcionário no mês. Fornece a média do valor das vendas, a quantidade de vendas realizadas e o valor total vendido no mês.
CREATE OR REPLACE VIEW vendas_mensais_funcionarios
(nome_funcionario, mes_venda, media_vendas, quantidade_vendas, valor_total_vendas)
AS
SELECT 
    c.nome AS nome_funcionario,
    DATE_FORMAT(v.data, '%Y-%m') AS mes_venda,
    AVG(v.total) AS media_vendas,
    COUNT(v.nota_fiscal) AS quantidade_vendas,
    SUM(v.total) AS valor_total_vendas
FROM 
    colaborador_funcionario cf
JOIN 
    colaborador c ON cf.cpf = c.cpf
JOIN 
    venda v ON c.cpf = v.cpf_funcionario
GROUP BY 
    c.nome, TO_CHAR(v.data, 'YYYY-MM');

-- Objetivo: Permitir que a equipe da gerência identifique rapidamente os produtos com baixo estoque.
CREATE VIEW Produtos_Baixo_Estoque
AS SELECT 
    p.cod AS ID_Produto,
    p.nome AS Nome_Produto,
    c.nome AS Categoria,
    p.quant AS Estoque_Restante
FROM 
    produto p
JOIN 
    produto_categoria pc ON p.cod = pc.cod_prod
JOIN 
    categoria c ON pc.cod_cat = c.cod
WHERE 
    p.quant < 10;

