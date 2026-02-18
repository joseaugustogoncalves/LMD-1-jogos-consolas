CREATE DATABASE IF NOT EXISTS games_systems;
USE games_systems;

CREATE TABLE games (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    plataforma VARCHAR(50) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    ano_lancamento INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    nota_avaliacao DECIMAL(3, 1) NOT NULL,
    copias_vendidas INT NOT NULL
);

-- Inserir dados de exemplo
INSERT INTO games (titulo, plataforma, genero, ano_lancamento, preco, nota_avaliacao, copias_vendidas) VALUES
('The Last of Us Part II', 'PlayStation', 'Ação', 2020, 69.99, 9.5, 10000000),
('Halo Infinite', 'Xbox', 'FPS', 2021, 59.99, 8.7, 8000000),
('Zelda: Breath of the Wild', 'Nintendo Switch', 'Aventura', 2017, 59.99, 9.8, 31000000),
('Cyberpunk 2077', 'PC', 'RPG', 2020, 49.99, 7.5, 18000000),
('FIFA 23', 'PlayStation', 'Desporto', 2022, 69.99, 8.2, 12000000),
('Minecraft', 'PC', 'Sandbox', 2011, 26.95, 9.0, 238000000),
('God of War Ragnarök', 'PlayStation', 'Ação', 2022, 79.99, 9.7, 15000000),
('Forza Horizon 5', 'Xbox', 'Corrida', 2021, 59.99, 9.1, 20000000),
('Animal Crossing', 'Nintendo Switch', 'Simulação', 2020, 59.99, 9.2, 42000000),
('Elden Ring', 'PC', 'RPG', 2022, 59.99, 9.6, 20000000),
('Mario Kart 8', 'Nintendo Switch', 'Corrida', 2014, 59.99, 9.3, 55000000),
('Grand Theft Auto V', 'PlayStation', 'Ação', 2013, 29.99, 9.5, 185000000),
('Red Dead Redemption 2', 'Xbox', 'Ação', 2018, 39.99, 9.7, 50000000),
('Overwatch 2', 'PC', 'FPS', 2022, 0.00, 8.0, 35000000),
('Valorant', 'PC', 'FPS', 2020, 0.00, 8.5, 23000000);