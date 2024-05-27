1 - Apresentar os pedidos realizados no ano de 2014. Campos: código do pedido, data de realização, data de entrega e nome fantasia do fornecedor. Usar junção natural.

SELECT p.codPedido, p.dataRealizacao, p.dataEntrega, f.nomeFantasia
FROM pedido p NATURAL JOIN fornecedor f
WHERE p.dataRealizacao > '2014-01-01' AND p.dataRealizacao < '2014-12-31';

2 - Listar os vendedores da cidade de ‘Apucarana’. Campos: nome do vendedor, data de nascimento, nome da cidade. Usar equi-junção.

SELECT v.nome, v.dataNascimento, c.nome
FROM vendedor v
JOIN cidade c ON v.codCidade = c.codCidade
WHERE c.nome = 'Apucarana';

3 - Listar as informações das vendas do produto ‘Cal’. Campos: código da venda, data da venda, nome do vendedor, número do lote, descrição do produto. Usar junção natural.

SELECT venda.codVenda, venda.dataVenda, v.nome, iv.numeroLote, p.descricao
FROM itemVenda iv NATURAL JOIN venda, vendedor v, produto p
WHERE p.descricao = 'Cal';

4 - Listar as informações dos produtos da classe ‘Acabamentos’. Campos: sigla da classe, nome da classe, código do produto, descrição, estoque mínimo.

SELECT c.sigla, c.nome, p.codProduto, p.descricao, p.estoqueMinimo
FROM produto p 
JOIN classe c ON p.codClasse = c.codClasse
WHERE c.nome = 'Acabamentos';

5 - Listar as informações dos pedidos do fornecedor ‘Incepa’. Campos: Nome Fantasia do fornecedor, código do pedido, data de realização, data da entrega.

SELECT f.nomeFantasia, p.codPedido, p.dataRealizacao, p.dataEntrega
FROM pedido p 
JOIN fornecedor f ON p.codFornecedor = f.codFornecedor
WHERE f.nomeFantasia = 'Incepa';

6 - Apresentar todos os produtos, e quando existirem, as vendas relativas ao produto. Campos: código do produto, descrição do produto, código da venda.  USAR LEFT JOIN

SELECT p.codProduto, p.descricao, iv.codVenda
FROM itemVenda iv 
LEFT JOIN produto p ON iv.codProduto = p.codProduto;

7 - Apresentar todos os fornecedores cadastrados, e quando existirem, os seus pedidos. Campos: nome fantasia do fornecedor, código do pedido, data de entrega do pedido. USAR LEFT JOIN 

SELECT f.nomeFantasia, p.codPedido, p.dataEntrega
FROM pedido p
LEFT JOIN fornecedor f ON p.codFornecedor = f.codFornecedor;

8 - Apresentar todos os departamentos, e seus vendedores. Apresentar também os departamentos que não possuem vendedores. Campos: nome do departamento, localização, nome do funcionário, data de nascimento. USAR RIGHT JOIN

SELECT d.nome, d.localizacao, v.nome, v.dataNascimento
FROM vendedor v
RIGHT JOIN departamento d ON v.codDepartamento = d.codDepartamento;

9 - Apresentar todos os clientes e suas respectivas compras, apresentar também os clientes que não fizeram compras. Campos: nome do cliente se o mesmo for pessoa física ou o nome fantasia se o mesmo for pessoa jurídica, código da venda. USAR RIGHT JOIN

SELECT CASE WHEN cf.nome IS NULL THEN cj.nomeFantasia ELSE cf.nome END AS Cliente, c.tipo, v.codVenda
FROM venda v
RIGHT JOIN cliente c ON v.codCliente = c.codCliente
LEFT JOIN clienteFisico cf ON cf.codCliente = v.codCliente
LEFT JOIN clienteJuridico cj ON cj.codCliente = v.codCliente

UNION ALL

SELECT CASE WHEN cf.nome IS NULL THEN cj.nomeFantasia ELSE cf.nome END AS Cliente, c.tipo, v.codVenda
FROM cliente c
LEFT JOIN venda v ON v.codCliente = c.codCliente
LEFT JOIN clienteFisico cf ON cf.codCliente = c.codCliente
LEFT JOIN clienteJuridico cj ON cj.codCliente = c.codCliente
WHERE v.codCliente IS NULL;
