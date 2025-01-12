#consulta: Obter a data de entrega feita por um fornecedor X que contenha um produto Y

 SELECT e.data_ent FROM entrega AS e, entre_produto AS ep WHERE e.cod = ep.cod_entrega; 

# consulta: Verificar a quantidade em estoque de um produto X
 SELECT p.quant FROM produto AS p WHERE p.nome = "?" ;



 #consulta: Obter quantidade de atrasos de um funcionário X em no dia

 SELECT c.nome, c.ponto FROM colaborador As c WHERE c.ponto >"2024-01-01 9:00";

 # Consulta: Retornar o CNPJ de todos os fornecedores contratados pelo gerente x na data y

 SELECT c.cnpj FROM contrata AS c WHERE c.cpf_gerente = "x" AND c.data = 'y'

