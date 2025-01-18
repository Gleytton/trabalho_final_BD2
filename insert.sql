INSERT INTO cliente (cod, cpf, nome, endereco, telefone) 
VALUES 
(1, '12345678901', 'Maria Silva', 'Rua A, 123', '21987654321'),
(2, '23456789012', 'João Souza', 'Avenida B, 456', '21976543210'),
(3, '34567890123', 'Ana Clara', 'Praça C, 789', '21965432109'),
(4, '45678901234', 'Pedro Henrique', 'Travessa D, 101', '21954321098'),
(5, '56789012345', 'Carla Mendes', 'Alameda E, 202', '21943210987');

INSERT INTO colaborador (cod, cpf, nome) 
VALUES 
(1, '12345678901', 'Lucas Pereira'),
(2, '23456789012', 'Fernanda Alves'),
(3, '34567890123', 'Marcos Silva'),
(4, '45678901234', 'Aline Santos'),
(5, '56789012345', 'Gabriel Costa');

INSERT INTO gerente (cod, cod_colaborador)
VALUES (1, 1);

INSERT INTO subordinado (cod, cod_colaborador, cod_gerente)
VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1);

INSERT INTO categoria (cod, nome, tipo) 
VALUES 
(1, 'Bebidas', 'Consumo'),
(2, 'Laticínios', 'Alimentação'),
(3, 'Higiene', 'Pessoal'),
(4, 'Limpeza', 'Doméstico'),
(5, 'Padaria', 'Alimentação');

INSERT INTO fornecedor (cod, cnpj, nome, endereco, telefone) 
VALUES 
(1, '12345678000199', 'Distribuidora XYZ', 'Rua A, 123', '21987654321'),
(2, '23456789000188', 'Fornecedor ABC', 'Avenida B, 456', '21976543210'),
(3, '34567890000177', 'Comercial Silva', 'Praça C, 789', '21965432109'),
(4, '45678901000166', 'Atacadão Central', 'Travessa D, 101', '21954321098'),
(5, '56789012000155', 'Mercantil Popular', 'Alameda E, 202', '21943210987');

INSERT INTO produto (cod, cod_categoria, nome, quant, valor_unitario) 
VALUES 
(1, 1, 'Refrigerante 1L', 50, 4.50),
(2, 1, 'Água Mineral 500ml', 100, 2.00),
(3, 1, 'Suco Natural 1L', 30, 6.00),
(4, 2, 'Queijo Mussarela 500g', 20, 12.00),
(5, 2, 'Leite Integral 1L', 50, 4.20),
(6, 2, 'Iogurte Natural 200g', 40, 3.50),
(7, 3, 'Shampoo 250ml', 25, 15.00),
(8, 3, 'Sabonete 90g', 60, 2.50),
(9, 3, 'Creme Dental 90g', 45, 6.80),
(10, 4, 'Detergente 500ml', 70, 3.00),
(11, 4, 'Esponja de Limpeza', 50, 1.50),
(12, 4, 'Desinfetante 1L', 40, 8.00),
(13, 5, 'Pão de Forma', 30, 7.50),
(14, 5, 'Bolo Simples 500g', 20, 12.00),
(15, 5, 'Croissant', 15, 4.00),
(16, 1, 'Cerveja Lata 350ml', 100, 3.80),
(17, 1, 'Energético 250ml', 25, 8.50),
(18, 2, 'Manteiga 200g', 30, 9.00),
(19, 3, 'Condicionador 250ml', 20, 16.00),
(20, 4, 'Sabão em Pó 1kg', 35, 18.50);

INSERT INTO venda(cod, cod_colaborador, cod_cliente)
VALUES 
    (1, 3, 2);

INSERT INTO venda_produto (cod, cod_venda, cod_produto, quant)
VALUES
    (1, 1, 1, 2),
    (2, 1, 2, 1),
    (3, 1, 3, 5);

INSERT INTO lista(cod, cod_gerente) VALUES (1, 1);

INSERT INTO lista_fornecedor (cod, cod_fornecedor, cod_lista)
VALUES
    (1, 1, 1),
    (2, 4, 1);

INSERT INTO orcamento (cod, cod_fornecedor)
VALUES
    (1, 1),
    (2, 4);

INSERT INTO lista_produto (cod, cod_lista, cod_produto, quant)
VALUES (1, 1, 1, 10),
(2, 1, 2, 12),
(3, 1, 6, 5),
(4, 1, 3, 3);

INSERT INTO orcamento_produto (cod, cod_orcamento, cod_produto, quant, valor_custo_unitario)
VALUES (1, 2, 1, 10, 3.10),
(2, 2, 2, 12, 3.60),
(3, 2, 6, 5, 6.00),
(4, 2, 3, 3, 3.13);

INSERT INTO lista_orcamento (cod, cod_lista, cod_orcamento)
VALUES
    (1, 1, 1),
    (2, 1, 2);