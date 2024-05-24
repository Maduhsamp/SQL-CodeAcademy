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

SELECT cj.nomeFantasia, c.endereco, c.telefone, cidade.nome, e.siglaEstado, c.dataCadastro
FROM clienteJuridico cj
JOIN cliente c ON cj.codCliente = c.codCliente
JOIN cidade ON c.codCidade = cidade.codCidade
JOIN estado e ON cidade.siglaEstado = e.siglaEstado
WHERE c.dataCadastro > 01/01/1999 AND c.dataCadastro < 30/06/2003;

6 - Listar o nome dos vendedores que realizaram vendas para o cliente pessoa jurídica com nome fantasia ‘Gelinski’.

SELECT venda.codVenda, v.nome, cj.nomeFantasia
FROM venda
JOIN vendedor v ON venda.codVendedor = v.codVendedor
JOIN clienteJuridico cj ON venda.codCliente = cj.codCliente
WHERE cj.nomeFantasia = 'Gelinski';

7 - Listar o código, o número do lote e o nome dos produtos que estão com a data de validade vencida.

SELECT pl.codProduto, pl.numeroLote, p.descricao, pl.dataValidade
FROM produtoLote pl
JOIN produto p ON pl.codProduto = p.codProduto
WHERE pl.dataValidade < CURRENT_TIMESTAMP;

8 - Listar o nome dos departamentos e o nome dos vendedores neles lotados.

SELECT d.nome, v.nome
FROM vendedor v
JOIN departamento d ON v.codDepartamento = d.codDepartamento;