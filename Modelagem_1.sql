CREATE DATABASE estabelecimento;

USE estabelecimento;

CREATE TABLE departamento (
	codDepartamento SERIAL,
    nome VARCHAR(40) UNIQUE NOT NULL,
    descricaoFuncional VARCHAR(80),
    localizacao MEDIUMTEXT
);

CREATE TABLE estado (
	siglaEstado CHAR(2),
    nome VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE cidade (
	codCidade SERIAL,
    nome VARCHAR(50) UNIQUE NOT NULL,
    siglaEstado CHAR(2) NOT NULL
);

CREATE TABLE vendedor (
	codVendedor SERIAL,
    nome VARCHAR(60) NOT NULL,
    dataNascimento DATE,
    endereco VARCHAR(60),
    cep CHAR(8),
    telefone VARCHAR(20),
    codCidade INT,
    dataContratacao DATE DEFAULT(CURDATE()),
    codDepartamento INT
);

CREATE TABLE cliente (
	codCliente SERIAL,
    endereco VARCHAR(60),
    codCidade INT NOT NULL,
    telefone VARCHAR(20),
    tipo CHAR(1) CHECK (tipo IN ('F', 'J')),
    dataCadastro DATE DEFAULT(CURDATE()),
    cep CHAR(8)
);

CREATE TABLE clienteFisico (
	codCliente INT,
    nome VARCHAR(50) NOT NULL,
    dataNascimento DATE,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    rg VARCHAR(8)
);

CREATE TABLE clienteJuridico (
	codCliente INT,
    nomeFantasia VARCHAR(80) UNIQUE,
    razaoSocial VARCHAR(80) UNIQUE NOT NULL,
    ie VARCHAR(20) UNIQUE NOT NULL,
    cgc VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE classe (
	codClasse SERIAL,
    sigla VARCHAR(12),
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(80)
);

CREATE TABLE produto (
	codProduto SERIAL,
    descricao VARCHAR(40) NOT NULL,
    unidadeMedida CHAR(2),
    embalagem VARCHAR(15) DEFAULT 'Fardo',
    codClasse INT,
    precoVenda DECIMAL(14, 2),
    estoqueMinimo DECIMAL(14, 2)
);

CREATE TABLE produtoLote (
	codProduto INT,
    numeroLote INT,
    quantidadeAdquirida DECIMAL(14, 2),
    quantidadeVendida DECIMAL(14, 2),
    precoCusto DECIMAL(14, 2),
    dataValidade DATE
);

CREATE TABLE venda (
	codVenda INT,
    codCliente INT,
    codVendedor INT,
    dataVenda DATE DEFAULT(CURDATE()),
    enderecoEntrega VARCHAR(60),
    status VARCHAR(30)
);

CREATE TABLE itemVenda (
	codVenda INT,
    codProduto INT,
    numeroLote INT,
    quantidade DECIMAL(14, 2) NOT NULL CHECK (quantidade >= 0)
);

CREATE TABLE fornecedor (
	codFornecedor INT,
    nomeFantasia VARCHAR(80) UNIQUE,
    razaoSocial VARCHAR(80) UNIQUE NOT NULL,
    ie VARCHAR(20) UNIQUE NOT NULL,
    cgc VARCHAR(20) UNIQUE NOT NULL,
    endereco VARCHAR(60),
    telefone VARCHAR(20),
    codCidade INT
);

CREATE TABLE pedido (
	codPedido SERIAL,
    dataRealizacao DATE DEFAULT(CURDATE()),
    dataEntrega DATE,
    codFornecedor INT,
    valor DECIMAL(20, 2)
);

CREATE TABLE itemPedido (
	codPedido INT,
    codProduto INT,
    quantidade DECIMAL(14, 2) NOT NULL CHECK (quantidade >= 0)
);