-- Script DDL para o esquema conceitual da oficina
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(30),
    email VARCHAR(150),
    endereco VARCHAR(255)
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(20) UNIQUE NOT NULL,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    ano INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Equipe (
    id_equipe INT PRIMARY KEY,
    nome_equipe VARCHAR(100) NOT NULL
);

CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY,
    id_equipe INT,
    codigo_mecanico VARCHAR(20) UNIQUE,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(255),
    especialidade VARCHAR(100),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

CREATE TABLE Ordem_Servico (
    id_os INT PRIMARY KEY,
    numero_os VARCHAR(50) UNIQUE NOT NULL,
    id_veiculo INT NOT NULL,
    id_equipe INT NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao_estimada DATE,
    data_conclusao_real DATE,
    valor_total DECIMAL(10,2),
    status VARCHAR(50),
    autorizada_por VARCHAR(150),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    codigo_servico VARCHAR(50) UNIQUE,
    descricao VARCHAR(255),
    valor_mao_obra DECIMAL(10,2)
);

CREATE TABLE Peca (
    id_peca INT PRIMARY KEY,
    codigo_peca VARCHAR(50) UNIQUE,
    descricao VARCHAR(255),
    valor_unitario DECIMAL(10,2),
    fabricante VARCHAR(150)
);

CREATE TABLE OS_Servico (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_mao_obra_aplicado DECIMAL(10,2),
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

CREATE TABLE OS_Peca (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_unitario_aplicado DECIMAL(10,2),
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);
