USE games_systems;

-- 1. Listar todos os jogos
SELECT * FROM games;

-- 2. Contar quantos jogos existem na base de dados
SELECT COUNT(*) AS total_jogos FROM games;

-- 3. Calcular o preço médio de todos os jogos
SELECT AVG(preco) AS preco_medio FROM games;

-- 4. Encontrar o jogo mais caro
SELECT * FROM games ORDER BY preco DESC LIMIT 1;

-- 5. Encontrar o jogo com a menor nota de avaliação
SELECT * FROM games ORDER BY nota_avaliacao ASC LIMIT 1;

-- 6. Listar os 5 jogos mais vendidos
SELECT titulo, copias_vendidas
FROM games
ORDER BY copias_vendidas DESC
LIMIT 5;

-- 7. Contar quantos jogos existem por plataforma
SELECT plataforma, COUNT(*) AS total_jogos
FROM games
GROUP BY
    plataforma
ORDER BY total_jogos DESC;

-- 8. Calcular a soma total de cópias vendidas de todos os jogos
SELECT SUM(copias_vendidas) AS total_copias_vendidas FROM games;

-- 9. Calcular o preço médio dos jogos por género, ordenado do mais caro para o mais barato
SELECT genero, AVG(preco) AS preco_medio
FROM games
GROUP BY
    genero
ORDER BY preco_medio DESC;

-- 10. Listar as plataformas que têm mais de 2 jogos cadastrados
SELECT plataforma, COUNT(*) AS total_jogos
FROM games
GROUP BY
    plataforma
HAVING
    COUNT(*) > 2;
    