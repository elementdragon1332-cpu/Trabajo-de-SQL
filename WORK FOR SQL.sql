
CREATE DATABASE DESAFIO;
USE DESAFIO;


CREATE TABLE Livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    ano_publicacao INT,
    preco DECIMAL(10,2)
);

CREATE TABLE Emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT NOT NULL,
    nome_usuario VARCHAR(100) NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);


INSERT INTO Livros (titulo, autor, ano_publicacao, preco) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 89.90),
('1984', 'George Orwell', 1949, 49.90),
('Dom Quixote', 'Miguel de Cervantes', 1605, 69.90),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 1997, 59.90),
('A Metamorfose', 'Franz Kafka', 1915, 39.90),
('Orgulho e Preconceito', 'Jane Austen', 1813, 44.90),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 29.90),
('Cem Anos de Solidão', 'Gabriel García Márquez', 1967, 79.90),
('Crime e Castigo', 'Fiódor Dostoiévski', 1866, 64.90),
('A Arte da Guerra', 'Sun Tzu', -500, 34.90);

-- Inserir 10 linhas em Emprestimos
INSERT INTO Emprestimos (id_livro, nome_usuario, data_emprestimo, data_devolucao) VALUES
(1, 'Ana Silva', '2025-12-01', '2025-12-15'),
(2, 'Bruno Costa', '2025-11-20', NULL),
(3, 'Carla Mendes', '2025-12-05', '2025-12-20'),
(4, 'Diego Souza', '2025-10-10', '2025-10-25'),
(1, 'Eduarda Lima', '2025-12-10', NULL),
(5, 'Felipe Santos', '2025-09-15', '2025-09-30'),
(7, 'Gabriela Rocha', '2025-11-05', '2025-11-20'),
(8, 'Henrique Alves', '2025-12-08', NULL),
(9, 'Isabela Ferreira', '2025-11-25', '2025-12-10'),
(4, 'João Pereira', '2025-12-12', NULL);

UPDATE Livros
SET preco = preco * 1.20
WHERE ano_publicacao < 1900;

SELECT titulo, autor, preco 
FROM Livros 
WHERE preco > 50.00 
ORDER BY preco DESC;

SELECT COUNT(*) AS total_livros FROM Livros;

SELECT AVG(preco) AS preco_medio FROM Livros;

SELECT MAX(preco) AS mais_caro, MIN(preco) AS mais_barato 
FROM Livros;

SELECT nome_usuario, COUNT(*) AS qtd_emprestimos
FROM Emprestimos
GROUP BY nome_usuario
ORDER BY qtd_emprestimos DESC;

SELECT l.titulo, COUNT(e.id_emprestimo) AS qtd_vezes_emprestado
FROM Livros l
LEFT JOIN Emprestimos e ON l.id_livro = e.id_livro
GROUP BY l.id_livro, l.titulo
ORDER BY qtd_vezes_emprestado DESC;

SELECT 
    l.autor,
    COUNT(l.id_livro) AS qtd_livros,
    AVG(l.preco) AS preco_medio_autor,
    COUNT(e.id_emprestimo) AS total_emprestimos
FROM Livros l
LEFT JOIN Emprestimos e ON l.id_livro = e.id_livro
GROUP BY l.autor
HAVING qtd_livros >= 1
ORDER BY preco_medio_autor DESC;
