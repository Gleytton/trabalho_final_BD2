-- Active: 1736634064306@@127.0.0.1@3306@hortfruit
-- Sempre que o preço do produto for alterado registraremos a alteração em uma tabela
DELIMITER $$
CREATE TRIGGER after_produto_update
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    -- Verifica se o preço foi alterado
    IF OLD.valor_unitario  <> NEW.valor_unitario  THEN
        -- Chama a procedure que registra a alteração de preço
        CALL registrar_alteracao_preco (NEW.cod, NEW.valor_unitario );
    END IF;
END $$
DELIMITER ;

-- Sempre que registrarmos um venda para um cliente os pontos fidelidade serão aumentados
DELIMITER $$
CREATE TRIGGER after_venda_insert 
AFTER INSERT ON venda 
FOR EACH ROW
BEGIN
	-- Chama a procedure que atualiza o pontos fidelidade
	CALL atualizar_pontos_fidelidade (NEW.nota_fiscal);
END $$

DELIMITER ;
