# Sistema de Oficina Mecânica — Esquema Lógico e Implementação

## 📌 Descrição do Projeto
Este repositório contém o **modelo lógico** e a implementação SQL para um sistema de controle e gerenciamento de ordens de serviço (OS) em uma oficina mecânica.

O objetivo é evoluir o modelo conceitual criado no desafio anterior para o **modelo relacional** (esquema lógico) e implementá-lo em SQL, com inserção de dados de teste e consultas complexas.

---

## 🗂 Esquema Lógico — Modelo Relacional

**Cliente**(`id_cliente`, nome, telefone, email, endereco)  
**Veiculo**(`id_veiculo`, id_cliente*, placa, marca, modelo, ano)  
**Equipe**(`id_equipe`, nome_equipe)  
**Mecanico**(`id_mecanico`, id_equipe*, codigo_mecanico, nome, endereco, especialidade)  
**Ordem_Servico**(`id_os`, numero_os, id_veiculo*, id_equipe*, data_emissao, data_conclusao_estimada, data_conclusao_real, valor_total, status, autorizada_por)  
**Servico**(`id_servico`, codigo_servico, descricao, valor_mao_obra)  
**Peca**(`id_peca`, codigo_peca, descricao, valor_unitario, fabricante)  
**OS_Servico**(`id_os`*, `id_servico`*, quantidade, valor_mao_obra_aplicado)  
**OS_Peca**(`id_os`*, `id_peca`*, quantidade, valor_unitario_aplicado)  

---

## 🖼 Diagramas
- **images/modelo_oficina_logico.png** — diagrama lógico com tabelas e relacionamentos.

---

## 📜 Script SQL
O arquivo `script.sql` contém:
1. **Criação das tabelas (DDL)**  
2. **Inserção de dados de teste (DML)**  
3. **Consultas SQL** com:
   - Recuperações simples (`SELECT`)  
   - Filtros (`WHERE`)  
   - Expressões e atributos derivados  
   - Ordenações (`ORDER BY`)  
   - Agrupamentos e filtros de grupos (`GROUP BY` e `HAVING`)  
   - Junções (`JOIN`)  

---
