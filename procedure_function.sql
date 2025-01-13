-- Atualiza o preço do produto
DELIMITER $$ 
CREATE PROCEDURE atualizar_preco_produto (
	IN p_produto_id VARCHAR(10),
	IN p_novo_preco DECIMAL (4,2)
)
BEGIN
	UPDATE produto
    SET valor_unitario = p_novo_preco, data = NOW()
	WHERE cod = p_produto_id;
END $$
DELIMITER ;

-- Registra a alteração de preço do produto
DELIMITER $$
CREATE PROCEDURE registrar_alteracao_preco (
	IN p_produto_id VARCHAR(10),
    IN p_novo_preco DECIMAL (4,2) 
)
BEGIN
	-- Finaliza o registro da última alteração de preço de um produto no histórico
	UPDATE historico_preco 
	SET data_fim = NOW()
	WHERE cod_produto = p_produto_id AND data_fim IS NULL;
			
	-- Registra o novo preço de um produto no histórico
	INSERT INTO historico_preco (cod_produto, preco, data_inicio, data_fim)
	VALUES(p_produto_id, p_novo_preco, NOW(), NULL);
END $$
DELIMITER ;

-- Atualiza a pontuação de um cliente
DELIMITER $$
CREATE PROCEDURE atualizar_pontos_fidelidade (
	IN p_nota_fiscal VARCHAR(20)
)
BEGIN
	DECLARE p_total_venda DECIMAL (4, 2);
    DECLARE pontos_venda INT;
	DECLARE p_cliente_cod INT;
    
    SET p_total_venda = (SELECT total FROM venda WHERE nota_fiscal = p_nota_fiscal);
    SET p_cliente_cod = (SELECT cod_cliente FROM venda WHERE nota_fiscal = p_nota_fiscal);
    SET pontos_venda = FLOOR(p_total_venda); -- R$ 1 GASTO = 1 PONTO
	
    -- Aumenta a pontuação do cartão fidelidade
    UPDATE cliente
    SET pontos = pontos + pontos_venda
    WHERE cod = p_cliente_cod;
END $$
DELIMITER ;

-- Encontra o produto mais vendido dado um range de tempo
DELIMITER $$
CREATE FUNCTION produto_mais_vendido (data_inicio DATETIME, data_fim DATETIME)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE produto_nome VARCHAR(255);

    -- Consulta para obter o nome do produto mais vendido
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

    RETURN produto_nome;
END $$

-- Encontra o preço em que um determindo produto foi mais comprado
DELIMITER $$
CREATE FUNCTION encontrar_preco_mais_comprado (produto_cod VARCHAR(10))
RETURNS DECIMAL(4, 2)
DETERMINISTIC
BEGIN
    DECLARE preco_mais_comprado DECIMAL(4, 2);

    -- Seleciona o preço mais comprado com base nas vendas
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
    
    RETURN preco_mais_comprado;
END $$
DELIMITER ;