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
MYSQL_CMD="mysql -h 127.0.0.1 -u root -ppassword games_systems --table"
MYSQL_CMD_SILENT="mysql -h 127.0.0.1 -u root -ppassword games_systems -N -s"

echo "=========================================="
echo "  VALIDAÇÃO DE QUERIES SQL - GAMES SYSTEMS"
echo "=========================================="
echo ""

# Função para extrair e executar query específica
execute_student_query() {
    local query_number=$1
    local query=$(sed -n "/===== QUERY $query_number =====/,/===== QUERY/p" solucao.sql | grep -v "=====" | grep -v "^--" | grep -v "^$" | tr '\n' ' ')
    echo "$query"
}

# Função para comparar resultados
compare_count() {
    local test_name=$1
    local student_result=$2
    local expected_result=$3
    
    if [ "$student_result" == "$expected_result" ]; then
        echo -e "${GREEN}✓ PASSOU${NC} - $test_name"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FALHOU${NC} - $test_name"
        echo -e "  ${YELLOW}Esperado:${NC} $expected_result"
        echo -e "  ${YELLOW}Obtido:${NC}   $student_result"
        ((FAILED++))
        return 1
    fi
}

# ==========================================
# TESTE 1: Listar todos os jogos
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 1: Listar todos os jogos${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY1=$(execute_student_query 1)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY1"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY1" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY1" 2>/dev/null | wc -l)
compare_count "Total de registros" "$STUDENT_COUNT" "15"
echo ""

# ==========================================
# TESTE 2: Contar quantos jogos existem
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 2: Contar quantos jogos existem${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY2=$(execute_student_query 2)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY2"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY2" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY2" 2>/dev/null)
compare_count "Total de jogos" "$STUDENT_COUNT" "15"
echo ""

# ==========================================
# TESTE 3: Calcular preço médio
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 3: Calcular preço médio${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY3=$(execute_student_query 3)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY3"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY3" 2>/dev/null

STUDENT_AVG=$($MYSQL_CMD_SILENT -e "SELECT ROUND(AVG(preco), 2) FROM games;" 2>/dev/null)
compare_count "Preço médio" "$STUDENT_AVG" "51.99"
echo ""

# ==========================================
# TESTE 4: Jogo mais caro
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 4: Encontrar jogo mais caro${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY4=$(execute_student_query 4)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY4"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY4" 2>/dev/null

STUDENT_TITLE=$($MYSQL_CMD_SILENT -e "$QUERY4" 2>/dev/null | awk '{print $2}')
compare_count "Título do jogo mais caro" "$STUDENT_TITLE" "God"
echo ""

# ==========================================
# TESTE 5: Jogo com menor nota
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 5: Jogo com menor nota${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY5=$(execute_student_query 5)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY5"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY5" 2>/dev/null

STUDENT_TITLE=$($MYSQL_CMD_SILENT -e "$QUERY5" 2>/dev/null | awk '{print $2}')
compare_count "Jogo com menor nota" "$STUDENT_TITLE" "Cyberpunk"
echo ""

# ==========================================
# TESTE 6: Top 5 jogos mais vendidos
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 6: Top 5 jogos mais vendidos${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY6=$(execute_student_query 6)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY6"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY6" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY6" 2>/dev/null | wc -l)
compare_count "Quantidade de jogos" "$STUDENT_COUNT" "5"
echo ""

# ==========================================
# TESTE 7: Jogos por plataforma
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 7: Contar jogos por plataforma${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY7=$(execute_student_query 7)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY7"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY7" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY7" 2>/dev/null | wc -l)
compare_count "Número de plataformas" "$STUDENT_COUNT" "4"
echo ""

# ==========================================
# TESTE 8: Total de cópias vendidas
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 8: Total de cópias vendidas${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY8=$(execute_student_query 8)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY8"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY8" 2>/dev/null

STUDENT_SUM=$($MYSQL_CMD_SILENT -e "$QUERY8" 2>/dev/null)
compare_count "Total de cópias vendidas" "$STUDENT_SUM" "762000000"
echo ""

# ==========================================
# TESTE 9: Preço médio por género
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 9: Preço médio por género${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY9=$(execute_student_query 9)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY9"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY9" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY9" 2>/dev/null | wc -l)
compare_count "Número de géneros" "$STUDENT_COUNT" "8"
echo ""

# ==========================================
# TESTE 10: Plataformas com mais de 2 jogos
# ==========================================
echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${BLUE}TESTE 10: Plataformas com mais de 2 jogos${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"

QUERY10=$(execute_student_query 10)
echo -e "${YELLOW}Query do aluno:${NC}"
echo "$QUERY10"
echo ""

echo -e "${YELLOW}Resultado:${NC}"
$MYSQL_CMD -e "$QUERY10" 2>/dev/null

STUDENT_COUNT=$($MYSQL_CMD_SILENT -e "$QUERY10" 2>/dev/null | wc -l)
compare_count "Plataformas com mais de 2 jogos" "$STUDENT_COUNT" "3"
echo ""

# ==========================================
# RESUMO FINAL
# ==========================================
echo -e "${CYAN}=========================================="
echo "           RESUMO DOS TESTES"
echo -e "==========================================${NC}"
echo -e "${GREEN}Testes Aprovados:${NC} $PASSED"
echo -e "${RED}Testes Falhados:${NC}  $FAILED"
echo -e "${CYAN}=========================================="
echo "Total de Testes: 10"
echo -e "==========================================${NC}"

if [ $FAILED -gt 0 ]; then
    echo -e "${RED}❌ Alguns testes falharam. Revise suas queries!${NC}"
    exit 1
else
    echo -e "${GREEN}🎉 Parabéns! Todos os testes passaram!${NC}"
    exit 0
fi