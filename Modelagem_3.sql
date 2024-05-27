CREATE TABLE departamento (
	codDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) UNIQUE NOT NULL,
    descricaoFuncional VARCHAR(80),
    localizacao MEDIUMTEXT
);

CREATE TABLE estado (
	siglaEstado CHAR(2) PRIMARY KEY,
    nome VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE cidade (
	codCidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    siglaEstado CHAR(2) NOT NULL REFERENCES estado(siglaEstado) ON DELETE no action ON UPDATE cascade
);

CREATE TABLE vendedor (
	codVendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    dataNascimento DATE,
    endereco VARCHAR(60),
    cep CHAR(8),
    telefone VARCHAR(20),
    codCidade INT DEFAULT 1,
    dataContratacao DATE DEFAULT(CURDATE()),
    codDepartamento INT,
    FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON DELETE cascade ON UPDATE cascade,
    FOREIGN KEY (codDepartamento) REFERENCES departamento (codDepartamento) ON DELETE set null ON UPDATE cascade
);

CREATE TABLE cliente (
	codCliente INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(60),
    codCidade INT NOT NULL,
    telefone VARCHAR(20),
    tipo CHAR(1) CHECK (tipo IN ('F', 'J')),
    dataCadastro DATE DEFAULT(CURDATE()),
    cep CHAR(8),
    CONSTRAINT fk_cliente_cidade FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON DELETE no action ON UPDATE cascade
);

CREATE TABLE clienteFisico (
	codCliente INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    dataNascimento DATE,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    rg VARCHAR(8),
    FOREIGN KEY (codCliente) REFERENCES cliente (codCliente) ON DELETE restrict ON UPDATE cascade
);

CREATE TABLE clienteJuridico (
	codCliente INT PRIMARY KEY,
    nomeFantasia VARCHAR(80) UNIQUE,
    razaoSocial VARCHAR(80) UNIQUE NOT NULL,
    ie VARCHAR(20) UNIQUE NOT NULL,
    cgc VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES cliente (codCliente) ON DELETE restrict ON UPDATE cascade
);

CREATE TABLE classe (
	codClasse INT AUTO_INCREMENT PRIMARY KEY,
    sigla VARCHAR(12),
    nome VARCHAR(40) NOT NULL,
    descricao VARCHAR(80)
);

CREATE TABLE produto (
	codProduto INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(40) NOT NULL,
    unidadeMedida CHAR(2),
    embalagem VARCHAR(15) DEFAULT 'Fardo',
    codClasse INT,
    precoVenda DECIMAL(14, 2),
    estoqueMinimo DECIMAL(14, 2),
    FOREIGN KEY (codClasse) REFERENCES classe (codClasse) ON DELETE set null ON UPDATE set null
);

CREATE TABLE produtoLote (
    codProduto INT, 
    numeroLote INT, 
    quantidadeAdquirida DECIMAL(14, 2), 
    quantidadeVendida DECIMAL(14, 2), 
    precoCusto DECIMAL(14, 2), 
    dataValidade DATE, 
    PRIMARY KEY (codProduto, numeroLote), 
    FOREIGN KEY (codProduto) REFERENCES produto (codProduto) ON DELETE cascade ON UPDATE cascade
);

CREATE TABLE venda (
	codVenda INT PRIMARY KEY,
    codCliente INT,
    codVendedor INT DEFAULT 100,
    dataVenda DATE DEFAULT(CURDATE()),
    enderecoEntrega VARCHAR(60),
    status VARCHAR(30),
    FOREIGN KEY (codCliente) REFERENCES cliente (codCliente) ON DELETE cascade ON UPDATE no action,
    FOREIGN KEY (codVendedor) REFERENCES vendedor (codVendedor) ON DELETE set default ON UPDATE cascade
);

CREATE TABLE itemVenda (
	codVenda INT,
    codProduto INT,
    numeroLote INT,
    quantidade DECIMAL(14, 2) NOT NULL CHECK (quantidade >= 0),
    PRIMARY KEY (codVenda, codProduto, numeroLote),
    FOREIGN KEY (codVenda) REFERENCES venda (codVenda) ON DELETE cascade ON UPDATE cascade,
    FOREIGN KEY (codProduto, numeroLote) REFERENCES produtoLote (codProduto, numeroLote) ON DELETE restrict
);

CREATE TABLE fornecedor (
	codFornecedor INT PRIMARY KEY,
    nomeFantasia VARCHAR(80) UNIQUE,
    razaoSocial VARCHAR(80) UNIQUE NOT NULL,
    ie VARCHAR(20) UNIQUE NOT NULL,
    cgc VARCHAR(20) UNIQUE NOT NULL,
    endereco VARCHAR(60),
    telefone VARCHAR(20),
    codCidade INT,
    FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON DELETE restrict ON UPDATE cascade
);

CREATE TABLE pedido (
	codPedido INT AUTO_INCREMENT PRIMARY KEY,
    dataRealizacao DATE DEFAULT(CURDATE()),
    dataEntrega DATE,
    codFornecedor INT,
    valor DECIMAL(20, 2),
    FOREIGN KEY (codFornecedor) REFERENCES fornecedor (codFornecedor) ON DELETE cascade ON UPDATE set null
);

CREATE TABLE itemPedido (
	codPedido INT,
    codProduto INT,
    quantidade DECIMAL(14, 2) NOT NULL CHECK (quantidade >= 0),
    PRIMARY KEY (codPedido, codProduto),
    FOREIGN KEY (codPedido) REFERENCES pedido (codPedido) ON DELETE cascade ON UPDATE cascade,
    FOREIGN KEY (codProduto) REFERENCES produto (codProduto) 
);

CREATE TABLE contasPagar (
	codTitulo INT PRIMARY KEY,
    dataVencimento DATE NOT NULL,
    parcela INT,
    codPedido INT,
    valor DECIMAl(20, 2),
    dataPagamento DATE,
    localPagamento VARCHAR(80),
    juros DECIMAL(12, 2),
    correcaoMonetaria DECIMAL(12, 2),
    FOREIGN KEY (codPedido) REFERENCES pedido (codPedido) ON DELETE cascade ON UPDATE cascade
);

CREATE TABLE contasReceber (
	codTitulo INT PRIMARY KEY,
    dataVencimento DATE NOT NULL,
    codVenda INT NOT NULL,
    parcela INT,
    valor DECIMAL(20, 2),
    dataPagamento DATE,
    localPagamento VARCHAR(80),
    juros DECIMAL(12, 2),
    correcaoMonetaria DECIMAL(12, 2),
    FOREIGN KEY (codVenda) REFERENCES venda (codVenda) ON DELETE cascade ON UPDATE cascade
);