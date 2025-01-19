-- Active: 1736634064306@@127.0.0.1@3306@mercado_vinicius
-- Sempre que o preço do produto for alterado registraremos a alteração em uma tabela
DELIMITER $$
DROP TRIGGER IF EXISTS after_produto_insert $$
CREATE TRIGGER after_produto_insert
    AFTER INSERT ON produto
    FOR EACH ROW
BEGIN
    -- Chama a procedure que registra a alteração de preço
    CALL registrar_alteracao_preco (NEW.cod, NEW.valor_unitario );
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS after_produto_update $$
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

-- Sempre que inserir na tabela orcamento_produto o valor total do custo será atualizado
DELIMITER $$
DROP TRIGGER IF EXISTS before_orcamento_produto_insert $$
CREATE TRIGGER before_orcamento_produto_insert
BEFORE INSERT ON orcamento_produto
FOR EACH ROW
BEGIN
    SET NEW.valor_custo_total = NEW.quant * NEW.valor_custo_unitario;
    CALL calcular_orcamento(NEW.cod_orcamento, NEW.valor_custo_total);
END $$
DELIMITER ;

-- Sempre que inserir na tabela venda_produto o valor total da venda do produto será atualizado e o total da venda
DELIMITER $$
DROP TRIGGER IF EXISTS before_venda_produto_insert $$
CREATE TRIGGER before_venda_produto_insert
BEFORE INSERT ON venda_produto
FOR EACH ROW
BEGIN
    SET NEW.valor_unitario = (SELECT valor_unitario FROM produto WHERE cod = NEW.cod_produto);
    SET NEW.valor = NEW.valor_unitario * NEW.quant;
    CALL calcular_total(NEW.cod_venda, NEW.valor);
END $$
DELIMITER ;

-- Sempre que registrarmos uma produto em uma venda o estoque será atualizado
-- Sempre que registrarmos um venda para um cliente os pontos fidelidade serão aumentados
DELIMITER $$
DROP TRIGGER IF EXISTS after_venda_produto_insert $$
CREATE TRIGGER after_venda_produto_insert
AFTER INSERT ON venda_produto
FOR EACH ROW
BEGIN
    CALL atualizar_estoque(NEW.cod, NEW.quant * -1);
    CALL atualizar_pontos_fidelidade (new.cod);
END $$
DELIMITER ;

-- Sempre que o orçamento for aprovado o estoque será atualizado
DELIMITER $$
DROP TRIGGER IF EXISTS after_orcamento_insert $$
CREATE TRIGGER after_orcamento_insert
AFTER INSERT ON orcamento
FOR EACH ROW
BEGIN
    IF NEW.foi_aprovado = TRUE THEN
        cALL adicionar_estoque_a_partir_orcamento(NEW.cod);
    END IF;
END $$
DELIMITER ;