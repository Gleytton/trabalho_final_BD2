-- 1- consulta: Obter a data de entrega feita por um fornecedor X que contenha um produto Y

 SELECT e_data_ent FROM entrega AS e, entrega_produto AS ep WHERE e_cod = ep_cod_entrega; 

-- #2-  consulta: Verificar a quantidade em estoque de um produto X

 SELECT p_quant FROM produto AS p WHERE p_nome = "?" ;

-- #3- consulta: Obter quantidade de atrasos de um funcionário X em no dia

 SELECT c_nome, c_ponto FROM colaborador As c WHERE c_ponto >"2024-01-01 9:00";

--#4- Consulta: Retornar o CNPJ de todos os fornecedores contratados pelo gerente x na data y

 SELECT c_cnpj FROM contrata AS c WHERE c_cpf_gerente = "x" AND c_data = 'y'

-- #5- Retorna todos os codigos de entregas de um produto

SELECT ep_cod_entrega FROM entrega_produto AS ep , produto AS p WHERE ep_cod_prod = p_cod

-- #6- Retorna o cliente com maior numero de pontos no cartão fidelidade e o número de pontos:

SELECT c_nome, c_pontos FROM cliente AS c WHERE c_pontos = MAX(c_pontos)

-- #7- Quantidade de produtos vendidos em uma venda X

SELECT vp_quant FROM venda_produto AS vp WHERE vp_cod = 'x'

-- #8- Retorna cpf dos funcionários que tem a função X

SELECT cf_cpf FROM colaborador_funcionario AS cf WHERE cf_funcao = 'x'

#9- Retorna as formas de pagamento cadastradas por um cliente

SELECT fp.tipo
FROM cliente AS cl JOIN cadastrar AS cad ON cl_cod = cad_cod_cliente
JOIN forma_pagamento AS fp ON cl_cod = fp_cod_cliente
WHERE cl_nome  = "x"

-- #10- Retorna o produto mais vendido

SELECT p_nome FROM produto AS p WHERE p_quant = MAX(p_quant) 

