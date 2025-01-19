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

-- Funcao de descontos em compras realizadas

CREATE OR REPLACE FUNCTION aplicar_desconto(nome TEXT, total NUMERIC)
RETURNS VOID AS $$

DECLARE

	novo_total NUMERIC;

BEGIN

-- se o total for menor que 100, o cliente recebe desconto de 5%
	IF total < 100 THEN
		novo_total := total - 0.05*total;

--se o total for maior que 100 e  menor que 200, o cliente recebe desconto de 10%
	ELSIF total > 100 AND total < 200 THEN
		novo_total := total - 0.10*total;

-- se o total for maior que 200, o cliente recebe desconto de 15%
	ELSE
		novo_total := total - 0.15*total;
	END IF

 -- atuliza o novo valor na tabela cliente
 	UPDATE venda
 	SET total = novo_total
 	WHERE cod_cliente = (SELECT cod_cliente FROM cliente WHERE nome = nome);

END; 
$$
LANGUAGE plpgsql;

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
