-- Registra a alteração de preço do produto
DELIMITER $$
DROP PROCEDURE IF EXISTS registrar_alteracao_preco $$
CREATE PROCEDURE registrar_alteracao_preco (
	IN p_produto_cod INT,
    IN p_novo_preco DECIMAL (5,2) 
)
BEGIN
	-- Finaliza o registro da última alteração de preço de um produto no histórico
	UPDATE historico_preco 
	SET data_fim = NOW()
	WHERE cod_produto = p_produto_cod AND data_fim IS NULL;
			
	-- Registra o novo preço de um produto no histórico
	INSERT INTO historico_preco (cod_produto, preco, data_inicio, data_fim)
	VALUES(p_produto_cod, p_novo_preco, NOW(), NULL);
END $$
DELIMITER ;

-- Atualiza a pontuação de um cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS atualizar_pontos_fidelidade $$
CREATE PROCEDURE atualizar_pontos_fidelidade (
	IN p_venda_produto_cod INT
)
BEGIN
	DECLARE p_total_venda_produto DECIMAL (20, 2);
    DECLARE pontos_venda_produto INT;
	DECLARE p_cliente_cod INT;

    SET p_cliente_cod = (
        SELECT cl.cod
        FROM venda_produto vp
        INNER JOIN venda v ON v.cod = vp.cod_venda
        INNER JOIN cliente cl ON v.cod_cliente = cl.cod
        WHERE vp.cod = p_venda_produto_cod);
    SET p_total_venda_produto = (SELECT vp.valor FROM venda_produto vp WHERE vp.cod = p_venda_produto_cod);
    SET pontos_venda_produto = FLOOR(p_total_venda_produto); -- R$ 1 GASTO = 1 PONTO
	
    -- Aumenta a pontuação do cartão fidelidade
    UPDATE cliente
    SET pontos = pontos + pontos_venda_produto
    WHERE cod = p_cliente_cod;
END $$
DELIMITER ;

-- Atualiza o total de uma venda
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_total $$
CREATE PROCEDURE calcular_total (
	IN p_venda_cod INT,
	IN p_venda_produto_total DECIMAL(10, 2)
)
BEGIN
    -- Atualiza o valor de uma venda
    UPDATE venda
    SET total = total + p_venda_produto_total
    WHERE cod = p_venda_cod;
END $$
DELIMITER ;

-- Atualiza o total do orçamento
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_orcamento $$
CREATE PROCEDURE calcular_orcamento (
	IN p_orcamento_cod INT,
	IN p_orcamento_produto_custo_total DECIMAL(10, 2)
)
BEGIN
    -- Atualiza o valor de uma venda
    UPDATE orcamento
    SET total = total + p_orcamento_produto_custo_total
    WHERE cod = p_orcamento_cod;
END $$
DELIMITER ;

-- Diminuir no estoque a partir de um venda
DROP PROCEDURE IF EXISTS atualizar_estoque $$
DELIMITER $$
CREATE PROCEDURE atualizar_estoque(
	IN p_cod_produto INT,
	IN p_quantidade INT
)
BEGIN
	UPDATE produto
	SET quant = quant + p_quantidade
	WHERE cod = p_cod_produto;
END $$
DELIMITER ;
-- Funcao de descontos em compras realizadas (REVISAR)

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

-- Adicionar no estoque a partir de um orçamento aprovado
DELIMITER $$
DROP PROCEDURE IF EXISTS adicionar_estoque_a_partir_orcamento $$
CREATE PROCEDURE adicionar_estoque_a_partir_orcamento(
    IN p_cod_orcamento INT
)
BEGIN
    DECLARE v_cod_produto INT;
    DECLARE v_quant INT;

    DECLARE cur_produto CURSOR FOR
    SELECT op.cod_produto, op.quant
    FROM orcamento_produto op
    WHERE op.cod_orcamento = p_cod_orcamento;

    OPEN cur_produto;

    read_loop: LOOP
        FETCH cur_produto INTO v_cod_produto, v_quant;

        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE produto
        SET quant = quant + v_quant
        WHERE cod = v_cod_produto;

    END LOOP;

    CLOSE cur_produto;
END $$
DELIMITER ;
