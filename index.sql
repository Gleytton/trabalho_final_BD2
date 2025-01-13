-- Índice Hash para igualdade em 'entrega_produto.cod_entrega'
CREATE INDEX idx_cod_entrega ON entrega_produto USING HASH(cod_entrega);

-- Índice Árvore B para desigualdade em 'colaborador.ponto'
CREATE INDEX idx_colaborador_ponto ON colaborador(ponto);

-- Índice Hash para igualdade em 'contrata.cpf_gerente'
CREATE INDEX idx_cpf_gerente ON contrata USING HASH(cpf_gerente);

-- Índice Hash para igualdade em 'produto.cod'
CREATE INDEX idx_produto_cod ON produto USING HASH(cod);

-- Índice Árvore B para desigualdade em 'cliente.pontos'
CREATE INDEX idx_cliente_pontos ON cliente(pontos);

-- Índice Hash para igualdade em 'venda_produto.cod'
CREATE INDEX idx_venda_produto_cod ON venda_produto USING HASH(cod);

-- Índice Hash para igualdade em 'colaborador_funcionario.funcao'
CREATE INDEX idx_funcao ON colaborador_funcionario USING HASH(funcao);

-- Índice Hash para igualdade em 'cliente.cod'
CREATE INDEX idx_cliente_cod ON cliente USING HASH(cod);

-- Índice Árvore B para desigualdade em 'produto.quant'
CREATE INDEX idx_produto_quant ON produto(quant);