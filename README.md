# Sistema de Oficina Mecânica — Esquema Conceitual

## 📌 Descrição do Projeto
Este repositório contém o **modelo conceitual** de um sistema de controle e gerenciamento de ordens de serviço (OS) para uma oficina mecânica.
O objetivo é organizar clientes, veículos, equipes de mecânicos, ordens de serviço, serviços e peças utilizadas, desde a abertura da OS até a entrega do veículo ao cliente.

> Observações: Quando a narrativa não especificou algum detalhe (por exemplo, regras de negócio sobre como dividir valores entre mecânicos, ou políticas de garantia), adotei escolhas razoáveis e documentei estruturas que permitem extensão futura.

## 🗂 Modelo Conceitual - Entidades Principais

- **Cliente**
  - id_cliente (PK)
  - nome
  - telefone
  - email
  - endereco

- **Veiculo**
  - id_veiculo (PK)
  - id_cliente (FK)
  - placa
  - marca
  - modelo
  - ano

- **Equipe**
  - id_equipe (PK)
  - nome_equipe

- **Mecanico**
  - id_mecanico (PK)
  - id_equipe (FK)
  - codigo_mecanico UNIQUE
  - nome
  - endereco
  - especialidade

- **Ordem_Servico (OS)**
  - id_os (PK)
  - numero_os UNIQUE
  - id_veiculo (FK)
  - id_equipe (FK)
  - data_emissao
  - data_conclusao_estimada
  - data_conclusao_real
  - valor_total
  - status  -- (Aberta, Autorizada, Em Andamento, Concluída, Cancelada)
  - autorizada_por (nome/usuario) -- registro de autorização do cliente

- **Servico (tabela de referencia de mão-de-obra)**
  - id_servico (PK)
  - codigo_servico UNIQUE
  - descricao
  - valor_mao_obra  -- valor unitário ou por hora (definir no detalhe da implementação)

- **Peca**
  - id_peca (PK)
  - codigo_peca UNIQUE
  - descricao
  - valor_unitario
  - fabricante (opcional)

- **OS_Servico** (associação entre OS e Servico)
  - id_os (FK)
  - id_servico (FK)
  - quantidade
  - valor_mao_obra_aplicado

- **OS_Peca** (associação entre OS e Peca)
  - id_os (FK)
  - id_peca (FK)
  - quantidade
  - valor_unitario_aplicado

## 🔗 Relacionamentos principais
- Cliente 1:N Veiculo
- Veiculo 1:N Ordem_Servico
- Equipe 1:N Mecanico
- Equipe 1:N Ordem_Servico (a OS é atribuída a uma equipe)
- Ordem_Servico N:N Servico (via OS_Servico)
- Ordem_Servico N:N Peca (via OS_Peca)

## 🖼 Diagrama Conceitual
Arquivo: `images/modelo_oficina.png`

## 📜 Script SQL (DDL)
Arquivo: `script.sql` — script de criação das tabelas (DDL) incluído neste repositório.


