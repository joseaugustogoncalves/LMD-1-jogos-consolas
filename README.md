# Assignment SQL: Sistema de Gestão de Jogos (Games Systems)

## Introdução

Neste exercício, você vai trabalhar com uma base de dados chamada **`games_systems`** que contém informações sobre jogos de videogame de diferentes plataformas. O objetivo é praticar consultas SQL utilizando operadores e funções essenciais.

---

## Objetivos Gerais

- Desenvolver competências na escrita de queries SQL para consulta e análise de dados.
- Praticar o uso de funções agregadas: `SUM`, `COUNT`, `AVG`, `MIN`, `MAX`.
- Aplicar cláusulas de ordenação (`ORDER BY`) e agrupamento (`GROUP BY`).
- Utilizar limitadores de resultados (`LIMIT`) para filtrar dados.
- Compreender a estrutura e organização de bases de dados relacionais.

---

## Objetivos Específicos

1. **Consultas Básicas**: Listar todos os registros de uma tabela.
2. **Funções Agregadas**: Usar `COUNT`, `SUM`, `AVG`, `MIN` e `MAX` para análise de dados.
3. **Ordenação**: Ordenar resultados com `ORDER BY` (ascendente e descendente).
4. **Limitação de Resultados**: Usar `LIMIT` para retornar apenas um número específico de registros.
5. **Agrupamento**: Agrupar dados com `GROUP BY` para análises por categoria.
6. **Filtragem de Grupos**: Aplicar condições em grupos usando `HAVING`.

---

## Estrutura da Base de Dados

### Tabela: `games`

| Campo            | Tipo          | Descrição                                    |
|------------------|---------------|----------------------------------------------|
| id               | INT(11)       | Chave primária (auto-incremento)             |
| titulo           | VARCHAR(255)  | Nome do jogo                                 |
| plataforma       | VARCHAR(50)   | Plataforma (PlayStation, Xbox, PC, Switch)   |
| genero           | VARCHAR(100)  | Género do jogo (Ação, RPG, FPS, etc.)        |
| ano_lancamento   | INT           | Ano de lançamento do jogo                    |
| preco            | DECIMAL(10,2) | Preço do jogo                                |
| nota_avaliacao   | DECIMAL(3,1)  | Nota de avaliação (0.0 a 10.0)              |
| copias_vendidas  | INT           | Número de cópias vendidas                    |

---

## Exercícios

Complete as seguintes queries no arquivo **`solucao.sql`**:

### 1. Listar todos os jogos
Retorne todos os registros da tabela `games`.

### 2. Contar quantos jogos existem
Retorne o número total de jogos cadastrados.

### 3. Calcular o preço médio
Calcule o preço médio de todos os jogos.

### 4. Encontrar o jogo mais caro
Retorne o jogo com o maior preço.

### 5. Encontrar o jogo com menor nota
Retorne o jogo com a menor nota de avaliação.

### 6. Listar os 5 jogos mais vendidos
Mostre os 5 jogos com mais cópias vendidas.

### 7. Contar jogos por plataforma
Mostre quantos jogos existem em cada plataforma.

### 8. Calcular total de cópias vendidas
Calcule a soma total de cópias vendidas de todos os jogos.

### 9. Preço médio por género
Calcule o preço médio dos jogos agrupados por género, ordenado do mais caro para o mais barato.

### 10. Plataformas com mais de 2 jogos
Liste as plataformas que têm mais de 2 jogos cadastrados.

---

## Como Submeter

1. Clone este repositório para o seu ambiente local.
2. Complete as queries no arquivo **`solucao.sql`**.
3. Teste localmente usando MySQL ou outro SGBD compatível.
4. Faça commit e push das suas alterações:
   ```bash
   git add solucao.sql
   git commit -m "Completar exercício de SQL"
   git push origin main
   ```
5. O GitHub Actions executará os testes automaticamente.

---

## Validação Automática

Os testes serão executados automaticamente pelo GitHub Actions. Você verá:
- **Testes Aprovados**: Queries corretas
- **Testes Falhados**: Queries com erros ou resultados incorretos

Verifique os logs do GitHub Actions para ver detalhes sobre os testes.

---

## 📖 Recursos Úteis

- [Documentação MySQL](https://dev.mysql.com/doc/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [SQLBolt - Interactive SQL Tutorial](https://sqlbolt.com/)

---

Boa sorte!