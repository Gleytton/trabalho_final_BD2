-- Índice para a tabela 'venda_produto' na coluna 'cod_produto'
CREATE INDEX idx_venda_produto_cod_produto ON venda_produto(cod_produto);

-- Índice para a tabela 'produto' na coluna 'cod'
CREATE INDEX idx_produto_cod ON produto(cod);

-- Índice para a tabela 'lista' na coluna 'cod_gerente'
CREATE INDEX idx_lista_cod_gerente ON lista(cod_gerente);

-- Índice para a tabela 'lista_fornecedor' na coluna 'cod_lista'
CREATE INDEX idx_lista_fornecedor_cod_lista ON lista_fornecedor(cod_lista);

-- Índice para a tabela 'fornecedor' na coluna 'cod'
CREATE INDEX idx_fornecedor_cod ON fornecedor(cod);

-- Índice para a tabela 'orcamento' na coluna 'cod_fornecedor'
CREATE INDEX idx_orcamento_cod_fornecedor ON orcamento(cod_fornecedor);

-- Índice para a tabela 'orcamento' na coluna 'foi_aprovado'
CREATE INDEX idx_orcamento_foi_aprovado ON orcamento(foi_aprovado);

-- Índice para a tabela 'cliente' na coluna 'pontos'
CREATE INDEX idx_cliente_pontos ON cliente(pontos);

-- Índice para a tabela 'venda' na coluna 'cod_colaborador'
CREATE INDEX idx_venda_cod_colaborador ON venda(cod_colaborador);

-- Índice para a tabela 'venda' na coluna 'data_venda'
CREATE INDEX idx_venda_data_venda ON venda(data_venda);

-- Índice para a tabela 'venda_produto' na coluna 'cod'
CREATE INDEX idx_venda_produto_cod ON venda_produto(cod);

-- Índice para a tabela 'historico_preco' na coluna 'cod_produto'
CREATE INDEX idx_historico_preco_cod_produto ON historico_preco(cod_produto);