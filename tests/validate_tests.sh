#!/bin/bash

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Contadores
PASSED=0
FAILED=0

# Configuração MySQL
MYSQL_CMD="mysql -h 127.0.0.1 -u root -ppassword games_systems -N -s"
MYSQL_CMD_TABLE="mysql -h 127.0.0.1 -u root -ppassword games_systems --table"

# Diretório temporário para resultados do aluno
mkdir -p /tmp/student_results

echo "=========================================="
echo "  VALIDAÇÃO DE QUERIES SQL - GAMES SYSTEMS"
echo "=========================================="
echo ""

# Função para extrair query do arquivo do aluno
extract_query() {
    local query_number=$1
    local start_marker="-- ===== QUERY $query_number ====="
    local end_marker="-- ===== QUERY"
    
    # Extrair a query entre os marcadores
    awk "/$start_marker/,/$end_marker/" solucao.sql | \
        grep -v "=====" | \
        grep -v "^--" | \
        grep -v "^$" | \
        tr '\n' ' ' | \
        sed 's/;$//'
}

# Função para comparar resultados
compare_query_results() {
    local test_number=$1
    local test_name=$2
    local query=$3
    local expected_file="tests/expected_results/query${test_number}.txt"
    local student_file="/tmp/student_results/query${test_number}.txt"
    
    echo -e "${CYAN}══════════════════════���═════════════════${NC}"
    echo -e "${BLUE}TESTE $test_number: $test_name${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    
    # Mostrar a query do aluno
    echo -e "${YELLOW}Query do aluno:${NC}"
    echo "$query"
    echo ""
    
    # Executar query do aluno e salvar resultado
    if ! $MYSQL_CMD -e "$query" > "$student_file" 2>/dev/null; then
        echo -e "${RED}✗ ERRO ao executar a query!${NC}"
        echo -e "${YELLOW}Verifique a sintaxe SQL.${NC}"
        ((FAILED++))
        echo ""
        return 1
    fi
    
    # Mostrar resultado do aluno (primeiras 10 linhas)
    echo -e "${YELLOW}Resultado do aluno:${NC}"
    $MYSQL_CMD_TABLE -e "$query" 2>/dev/null | head -15
    if [ $(wc -l < "$student_file") -gt 10 ]; then
        echo "... (mostrando primeiras linhas)"
    fi
    echo ""
    
    # Verificar se arquivo esperado existe
    if [ ! -f "$expected_file" ]; then
        echo -e "${RED}✗ ERRO: Arquivo de resultado esperado não encontrado!${NC}"
        echo -e "${YELLOW}Arquivo: $expected_file${NC}"
        ((FAILED++))
        echo ""
        return 1
    fi
    
    # Comparar resultados
    if diff -q "$expected_file" "$student_file" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSOU${NC} - Resultado idêntico ao esperado!"
        ((PASSED++))
    else
        echo -e "${RED}✗ FALHOU${NC} - Resultado diferente do esperado!"
        echo ""
        echo -e "${YELLOW}Diferenças encontradas:${NC}"
        echo -e "${CYAN}--- Esperado ---${NC}"
        head -10 "$expected_file"
        echo ""
        echo -e "${CYAN}--- Obtido ---${NC}"
        head -10 "$student_file"
        echo ""
        echo -e "${YELLOW}Detalhes completos da diferença:${NC}"
        diff "$expected_file" "$student_file" | head -20
        ((FAILED++))
    fi
    
    echo ""
}

# ==========================================
# EXECUTAR TODOS OS TESTES
# ==========================================

# Teste 1
QUERY1=$(extract_query 1)
compare_query_results 1 "Listar todos os jogos" "$QUERY1"

# Teste 2
QUERY2=$(extract_query 2)
compare_query_results 2 "Contar quantos jogos existem" "$QUERY2"

# Teste 3
QUERY3=$(extract_query 3)
compare_query_results 3 "Calcular preço médio" "$QUERY3"

# Teste 4
QUERY4=$(extract_query 4)
compare_query_results 4 "Encontrar jogo mais caro" "$QUERY4"

# Teste 5
QUERY5=$(extract_query 5)
compare_query_results 5 "Jogo com menor nota" "$QUERY5"

# Teste 6
QUERY6=$(extract_query 6)
compare_query_results 6 "Top 5 jogos mais vendidos" "$QUERY6"

# Teste 7
QUERY7=$(extract_query 7)
compare_query_results 7 "Contar jogos por plataforma" "$QUERY7"

# Teste 8
QUERY8=$(extract_query 8)
compare_query_results 8 "Total de cópias vendidas" "$QUERY8"

# Teste 9
QUERY9=$(extract_query 9)
compare_query_results 9 "Preço médio por género" "$QUERY9"

# Teste 10
QUERY10=$(extract_query 10)
compare_query_results 10 "Plataformas com mais de 2 jogos" "$QUERY10"

# ==========================================
# RESUMO FINAL
# ==========================================
echo -e "${CYAN}=========================================="
echo "           RESUMO DOS TESTES"
echo -e "==========================================${NC}"
echo -e "${GREEN}✓ Testes Aprovados: $PASSED${NC}"
echo -e "${RED}✗ Testes Falhados:  $FAILED${NC}"
echo -e "${CYAN}=========================================="
echo "Total de Testes: 10"
echo -e "==========================================${NC}"
echo ""

# Limpar arquivos temporários
rm -rf /tmp/student_results

if [ $FAILED -gt 0 ]; then
    echo -e "${RED}❌ Alguns testes falharam. Revise suas queries!${NC}"
    exit 1
else
    echo -e "${GREEN}🎉 Parabéns! Todos os testes passaram com sucesso!${NC}"
    exit 0
fi