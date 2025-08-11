-- Criação das tabelas (DDL)
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

-- Inserção de dados de teste (DML)
INSERT INTO Cliente VALUES
(1, 'João Silva', '11999999999', 'joao@email.com', 'Rua A, 123'),
(2, 'Maria Oliveira', '11988888888', 'maria@email.com', 'Av B, 456');

INSERT INTO Veiculo VALUES
(1, 1, 'ABC1234', 'Toyota', 'Corolla', 2020),
(2, 2, 'XYZ5678', 'Honda', 'Civic', 2018);

INSERT INTO Equipe VALUES
(1, 'Equipe Alfa'),
(2, 'Equipe Beta');

INSERT INTO Mecanico VALUES
(1, 1, 'M001', 'Carlos Souza', 'Rua C, 789', 'Motor'),
(2, 1, 'M002', 'Pedro Santos', 'Rua D, 321', 'Suspensão'),
(3, 2, 'M003', 'Lucas Lima', 'Rua E, 654', 'Freios');

INSERT INTO Servico VALUES
(1, 'S001', 'Troca de óleo', 150.00),
(2, 'S002', 'Alinhamento', 100.00);

INSERT INTO Peca VALUES
(1, 'P001', 'Filtro de óleo', 50.00, 'Bosch'),
(2, 'P002', 'Pneu 175/65 R14', 300.00, 'Pirelli');

INSERT INTO Ordem_Servico VALUES
(1, 'OS001', 1, 1, '2025-08-01', '2025-08-05', NULL, NULL, 'Aberta', 'João Silva'),
(2, 'OS002', 2, 2, '2025-08-02', '2025-08-06', NULL, NULL, 'Aberta', 'Maria Oliveira');

INSERT INTO OS_Servico VALUES
(1, 1, 1, 150.00),
(1, 2, 1, 100.00),
(2, 2, 1, 100.00);

INSERT INTO OS_Peca VALUES
(1, 1, 1, 50.00),
(2, 2, 4, 300.00);

-- Consultas

-- 1) Recuperações simples
SELECT nome, telefone FROM Cliente;

-- 2) Filtro WHERE
SELECT * FROM Veiculo WHERE ano >= 2020;

-- 3) Atributo derivado (total peças por OS)
SELECT id_os, SUM(quantidade * valor_unitario_aplicado) AS total_pecas
FROM OS_Peca
GROUP BY id_os;

-- 4) Ordenação
SELECT * FROM Servico ORDER BY valor_mao_obra DESC;

-- 5) HAVING (OS com mais de R$ 200 em peças)
SELECT id_os, SUM(quantidade * valor_unitario_aplicado) AS total_pecas
FROM OS_Peca
GROUP BY id_os
HAVING total_pecas > 200;

-- 6) JOIN (OS com dados do cliente e veículo)
SELECT os.numero_os, c.nome AS cliente, v.placa, os.status
FROM Ordem_Servico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente;

-- 7) JOIN com agregação (valor total por cliente considerando serviços e peças)
SELECT c.nome,
       SUM(COALESCE(osv.valor_mao_obra_aplicado * osv.quantidade, 0)) +
       SUM(COALESCE(osp.valor_unitario_aplicado * osp.quantidade, 0)) AS valor_total
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente
JOIN Ordem_Servico os ON v.id_veiculo = os.id_veiculo
LEFT JOIN OS_Servico osv ON os.id_os = osv.id_os
LEFT JOIN OS_Peca osp ON os.id_os = osp.id_os
GROUP BY c.nome;
