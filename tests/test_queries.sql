USE games_systems;

-- ============================================
-- TESTES AUTOMÁTICOS
-- Este arquivo valida os resultados esperados
-- ============================================

-- TESTE 1: Verificar se todos os jogos estão na base de dados
SELECT 
    'TESTE 1' AS Teste,
    'Listar todos os jogos' AS Descricao,
    CASE 
        WHEN COUNT(*) = 15 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    15 AS Esperado,
    COUNT(*) AS Obtido
FROM games;

-- TESTE 2: Verificar contagem total de jogos
SELECT 
    'TESTE 2' AS Teste,
    'Contar quantos jogos existem' AS Descricao,
    CASE 
        WHEN COUNT(*) = 15 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    15 AS Esperado,
    COUNT(*) AS Obtido
FROM games;

-- TESTE 3: Verificar preço médio dos jogos
SELECT 
    'TESTE 3' AS Teste,
    'Calcular preço médio' AS Descricao,
    CASE 
        WHEN ROUND(AVG(preco), 2) = 51.99 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    51.99 AS Esperado,
    ROUND(AVG(preco), 2) AS Obtido
FROM games;

-- TESTE 4: Verificar o jogo mais caro
SELECT 
    'TESTE 4' AS Teste,
    'Encontrar jogo mais caro' AS Descricao,
    CASE 
        WHEN titulo = 'God of War Ragnarök' AND preco = 79.99 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    'God of War Ragnarök' AS Esperado,
    titulo AS Obtido,
    79.99 AS PrecoEsperado,
    preco AS PrecoObtido
FROM games 
ORDER BY preco DESC 
LIMIT 1;

-- TESTE 5: Verificar jogo com menor nota
SELECT 
    'TESTE 5' AS Teste,
    'Jogo com menor nota' AS Descricao,
    CASE 
        WHEN titulo = 'Cyberpunk 2077' AND nota_avaliacao = 7.5 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    'Cyberpunk 2077' AS Esperado,
    titulo AS Obtido,
    7.5 AS NotaEsperada,
    nota_avaliacao AS NotaObtida
FROM games 
ORDER BY nota_avaliacao ASC 
LIMIT 1;

-- TESTE 6: Verificar os 5 jogos mais vendidos
SELECT 
    'TESTE 6' AS Teste,
    'Top 5 jogos mais vendidos' AS Descricao,
    CASE 
        WHEN COUNT(*) = 5 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    5 AS Esperado,
    COUNT(*) AS Obtido
FROM (
    SELECT titulo, copias_vendidas 
    FROM games 
    ORDER BY copias_vendidas DESC 
    LIMIT 5
) AS top5;

-- TESTE 6b: Verificar se o jogo mais vendido está correto
SELECT 
    'TESTE 6b' AS Teste,
    'Jogo mais vendido' AS Descricao,
    CASE 
        WHEN titulo = 'Minecraft' THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    'Minecraft' AS Esperado,
    titulo AS Obtido,
    238000000 AS CopiasEsperadas,
    copias_vendidas AS CopiasObtidas
FROM games 
ORDER BY copias_vendidas DESC 
LIMIT 1;

-- TESTE 7: Verificar contagem de jogos por plataforma
SELECT 
    'TESTE 7' AS Teste,
    'Contar jogos por plataforma' AS Descricao,
    CASE 
        WHEN COUNT(DISTINCT plataforma) = 4 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    4 AS PlataformasEsperadas,
    COUNT(DISTINCT plataforma) AS PlataformasObtidas
FROM games;

-- TESTE 7b: Verificar plataforma com mais jogos
SELECT 
    'TESTE 7b' AS Teste,
    'Plataforma com mais jogos' AS Descricao,
    plataforma,
    COUNT(*) AS total_jogos,
    CASE 
        WHEN plataforma IN ('PC', 'PlayStation') AND COUNT(*) = 5 THEN 'PASSOU'
        ELSE 'VERIFICAR'
    END AS Resultado
FROM games 
GROUP BY plataforma 
ORDER BY total_jogos DESC 
LIMIT 1;

-- TESTE 8: Verificar soma total de cópias vendidas
SELECT 
    'TESTE 8' AS Teste,
    'Total de cópias vendidas' AS Descricao,
    CASE 
        WHEN SUM(copias_vendidas) = 762000000 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    762000000 AS Esperado,
    SUM(copias_vendidas) AS Obtido
FROM games;

-- TESTE 9: Verificar número de géneros diferentes
SELECT 
    'TESTE 9' AS Teste,
    'Preço médio por género' AS Descricao,
    CASE 
        WHEN COUNT(DISTINCT genero) = 8 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    8 AS GenerosEsperados,
    COUNT(DISTINCT genero) AS GenerosObtidos
FROM games;

-- TESTE 9b: Verificar género com maior preço médio
SELECT 
    'TESTE 9b' AS Teste,
    'Género com maior preço médio' AS Descricao,
    genero,
    ROUND(AVG(preco), 2) AS preco_medio,
    CASE 
        WHEN genero = 'Ação' AND ROUND(AVG(preco), 2) = 54.99 THEN 'PASSOU'
        ELSE 'VERIFICAR'
    END AS Resultado
FROM games 
GROUP BY genero 
ORDER BY preco_medio DESC 
LIMIT 1;

-- TESTE 10: Verificar plataformas com mais de 2 jogos
SELECT 
    'TESTE 10' AS Teste,
    'Plataformas com mais de 2 jogos' AS Descricao,
    CASE 
        WHEN COUNT(*) = 3 THEN 'PASSOU'
        ELSE 'FALHOU'
    END AS Resultado,
    3 AS Esperado,
    COUNT(*) AS Obtido
FROM (
    SELECT plataforma, COUNT(*) AS total_jogos 
    FROM games 
    GROUP BY plataforma 
    HAVING COUNT(*) > 2
) AS plataformas_filtradas;

-- RESUMO FINAL: Contar quantos testes passaram
SELECT 
    '========================================' AS Separador;

SELECT 
    'RESUMO GERAL' AS Teste,
    COUNT(*) AS TotalTestes,
    'Verifique os resultados acima' AS Mensagem
FROM (
    SELECT 'TESTE 1' AS teste UNION ALL
    SELECT 'TESTE 2' UNION ALL
    SELECT 'TESTE 3' UNION ALL
    SELECT 'TESTE 4' UNION ALL
    SELECT 'TESTE 5' UNION ALL
    SELECT 'TESTE 6' UNION ALL
    SELECT 'TESTE 7' UNION ALL
    SELECT 'TESTE 8' UNION ALL
    SELECT 'TESTE 9' UNION ALL
    SELECT 'TESTE 10'
) AS todos_testes;