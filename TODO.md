# TODO

## Modelo ER

- [ ] Consertar o MER

### Sugestões de alterações na modelagem

- [ ] Criar tabela `Ponto`
- Cada cliente terá o seu horário chegada e saída registrado no ponto
- `ponto(cod, codFuncionario, horaData, atrasado)`
- `codFuncionario` aponta para `cod` do `funcionario`

- [ ] Cria tabela `Escala`
- Uma tabela onde terá o horário da escala do funcionário
- `escala (cod, codFuncionario, horaData)`
- `codFuncionario` aponta para `cod` do `funcionario`

## Modelo Físico

- [ ] A partir do MER atualizado **consertar** e **inserir** as novas tabelas no Modelo Físico
- [ ] Inserir dados no Banco de Dados
- [ ] Refazer as procedures/functions simples
- [ ] Refazer as consultas simples

## Verificação de erros

- [ ] Verificar cada `VIEW`
- [ ] Verificar cada `SELECT`
- [ ] Verificar cada `INDEX`
- [ ] Verificar cada `PROCEDURE/FUNCTION`

## Etapa Final

- [ ] Rodar todos os scripts e tudo funcionar
- [ ] Entregar trabalho
