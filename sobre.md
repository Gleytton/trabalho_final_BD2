# Sobre

Explicação das tabelas e seus relacionamentos

1. **cliente**  
   Armazena informações sobre os clientes, como CPF, nome, endereço, telefone e pontos acumulados.

2. **categoria**  
   Define categorias de produtos, com nome e tipo.

3. **produto**  
   Contém os produtos cadastrados, ligados às categorias, com nome, quantidade e valor unitário.

4. **historico_preco**  
   Registra alterações de preço dos produtos, com datas de início e fim.

5. **colaborador**  
   Armazena informações sobre os colaboradores, incluindo CPF e nome.

6. **gerente**  
   Representa gerentes vinculados aos colaboradores.

7. **subordinado**  
   Relaciona colaboradores subordinados a gerentes.

8. **venda**  
   Registra as vendas realizadas, associando colaboradores e clientes.

9. **venda_produto**  
   Detalha os produtos vendidos em cada venda, incluindo quantidade e valor unitário.

10. **fornecedor**  
    Contém informações sobre fornecedores, como CNPJ, nome, endereço e telefone.

11. **lista**  
    Representa listas criadas por gerentes, que podem estar associadas a produtos e fornecedores.

12. **lista_produto**  
    Relaciona produtos com listas, incluindo a quantidade necessária.

13. **lista_fornecedor**  
    Relaciona fornecedores com listas.

14. **orcamento**  
    Registra orçamentos fornecidos por fornecedores, incluindo o valor total e status de aprovação.

15. **orcamento_produto**  
    Relaciona produtos aos orçamentos, com quantidades e valores de custo.

16. **lista_orcamento**  
    Associa listas aos orçamentos.
