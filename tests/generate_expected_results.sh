#!/bin/bash

# Script para gerar resultados esperados usando MySQL do XAMPP no Mac

# Caminho do MySQL no XAMPP (Mac)
MYSQL_PATH="/Applications/XAMPP/xamppfiles/bin/mysql"
MYSQL_CMD="$MYSQL_PATH -u root games_systems -N -s"

# Criar diretório para resultados
mkdir -p tests/expected_results

echo "=========================================="
echo "  Gerando Resultados Esperados"
echo "=========================================="
echo ""

# Query 1: Listar todos os jogos
echo "Gerando query1.txt (Listar todos os jogos)..."
$MYSQL_CMD -e "SELECT * FROM games ORDER BY id;" > tests/expected_results/query1.txt

# Query 2: Contar quantos jogos existem
echo "Gerando query2.txt (Contar jogos)..."
$MYSQL_CMD -e "SELECT COUNT(*) AS total_jogos FROM games;" > tests/expected_results/query2.txt

# Query 3: Calcular preço médio
echo "Gerando query3.txt (Preço médio)..."
$MYSQL_CMD -e "SELECT ROUND(AVG(preco), 2) AS preco_medio FROM games;" > tests/expected_results/query3.txt

# Query 4: Jogo mais caro
echo "Gerando query4.txt (Jogo mais caro)..."
$MYSQL_CMD -e "SELECT * FROM games ORDER BY preco DESC, id ASC LIMIT 1;" > tests/expected_results/query4.txt

# Query 5: Jogo com menor nota
echo "Gerando query5.txt (Jogo com menor nota)..."
$MYSQL_CMD -e "SELECT * FROM games ORDER BY nota_avaliacao ASC, id ASC LIMIT 1;" > tests/expected_results/query5.txt

# Query 6: Top 5 jogos mais vendidos
echo "Gerando query6.txt (Top 5 mais vendidos)..."
$MYSQL_CMD -e "SELECT titulo, copias_vendidas FROM games ORDER BY copias_vendidas DESC, titulo ASC LIMIT 5;" > tests/expected_results/query6.txt

# Query 7: Jogos por plataforma
echo "Gerando query7.txt (Jogos por plataforma)..."
$MYSQL_CMD -e "SELECT plataforma, COUNT(*) AS total_jogos FROM games GROUP BY plataforma ORDER BY total_jogos DESC, plataforma ASC;" > tests/expected_results/query7.txt

# Query 8: Total de cópias vendidas
echo "Gerando query8.txt (Total de cópias vendidas)..."
$MYSQL_CMD -e "SELECT SUM(copias_vendidas) AS total_copias_vendidas FROM games;" > tests/expected_results/query8.txt

# Query 9: Preço médio por género
echo "Gerando query9.txt (Preço médio por género)..."
$MYSQL_CMD -e "SELECT genero, ROUND(AVG(preco), 2) AS preco_medio FROM games GROUP BY genero ORDER BY preco_medio DESC, genero ASC;" > tests/expected_results/query9.txt

# Query 10: Plataformas com mais de 2 jogos
echo "Gerando query10.txt (Plataformas com mais de 2 jogos)..."
$MYSQL_CMD -e "SELECT plataforma, COUNT(*) AS total_jogos FROM games GROUP BY plataforma HAVING COUNT(*) > 2 ORDER BY total_jogos DESC, plataforma ASC;" > tests/expected_results/query10.txt

echo ""
echo "=========================================="
echo "  ✅ Resultados Gerados com Sucesso!"
echo "=========================================="
echo ""
echo "Arquivos criados:"
ls -lh tests/expected_results/

echo ""
echo "Visualização rápida:"
echo ""
echo "=== Query 1 (primeiras 3 linhas) ==="
head -3 tests/expected_results/query1.txt
echo ""
echo "=== Query 2 ==="
cat tests/expected_results/query2.txt
echo ""
echo "=== Query 6 ==="
cat tests/expected_results/query6.txt