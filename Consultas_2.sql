1 - Listar o código, nome, endereço, nome da cidade, nome do estado dos vendedores cadastrados.

SELECT v.codVendedor, v.nome, v.endereco, c.nome AS cidade,
e.nome AS estado
FROM vendedor v
JOIN cidade c ON v.codCidade = c.codCidade
JOIN estado e ON c.siglaEstado = e.siglaEstado;

2 - Listar o código da venda, data de venda, nome do vendedor de todas as vendas com status de ‘Despachada’.

SELECT v.codVenda, v.dataVenda, v.status, vend.nome
FROM venda v
JOIN vendedor vend ON v.codVendedor = vend.codVendedor
WHERE v.status = 'Despachada';

3 - Listar os clientes pessoa física que moram na Rua Marechal Floriano, 56.

SELECT cf.nome, c.endereco 
FROM clienteFisico cf
JOIN cliente c ON cf.codCliente = c.codCliente
WHERE c.endereco = 'Rua Marechal Floriano, 56';

4 - Listar todas as informações dos clientes que são pessoas jurídicas.

SELECT c.*, cj.*
FROM cliente c
JOIN clienteJuridico cj ON c.codCliente = cj.codCliente;

5 - Listar o nome fantasia, endereço, telefone, nome da cidade, sigla do estado de todos os clientes jurídicos que foram cadastrados entre 01/01/1999 e 30/06/2003.
