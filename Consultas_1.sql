1 - Listar todas as informações dos produtos cadastrados.

SELECT * FROM produto;

-------------------------------------------------------------

2 - Listar o código, nome fantasia, endereço, telefone e código da cidade dos fornecedores cadastrados.

SELECT codFornecedor, nomeFantasia, endereco, telefone, codCidade FROM fornecedor;

-------------------------------------------------------------

3 - Listar o código da venda, data de venda de todas as vendas com status de ‘Despachada’.

SELECT codVenda, dataVenda, status FROM venda WHERE status = 'Despachada';

-------------------------------------------------------------

4 - Listar todas as informações da tabela de pessoas jurídicas.

SELECT * FROM clienteJuridico;

-------------------------------------------------------------

5 - Listar o número do lote dos produtos que estão com a data de validade vencida.

SELECT numeroLote, dataValidade FROM produtoLote WHERE dataValidade < CURDATE();

-------------------------------------------------------------

6 - Listar o nome dos departamentos.

SELECT nome FROM departamento;
