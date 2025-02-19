<<<<<<< HEAD
-- TABELAS SEM RELAÇÕES

CREATE TABLE IF NOT EXISTS AU4AT1.FUNCIONARIO(
    IDFUNCIONARIO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    CARTEIRATRABALHO SMALLINT,
    DATACONTRATACAO DATE,
    SALARIO DECIMAL(6,2)
);

CREATE TABLE IF NOT EXISTS AU4AT1.FUNCAO(
    IDFUNCAO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.HORARIO(
    IDHORARIO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    HORARIO TIME
);

CREATE TABLE IF NOT EXISTS AU4AT1.SALA(
    IDSALA INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    CAPACIDADE SMALLINT
);

CREATE TABLE IF NOT EXISTS AU4AT1.DIRETOR(
    IDDIRETOR INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.GENERO(
    IDGENERO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.PREMIACAO(
    IDPREMAIACAO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    ANO INT
);

-- TABELAS COM RELAÇÕES

CREATE TABLE IF NOT EXISTS AU4AT1.FILME(
    IDFILME INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOMEBR VARCHAR(45),
    NOMEEN VARCHAR(45),
    ANOLANCAMENTO INT,
    DIRETORID INT,
    SINOPSE TEXT,
    GENEROID INT,

    CONSTRAINT DIRETO_FILME FOREIGN KEY(DIRETORID) REFERENCES AU4AT1.DIRETOR(IDDIRETOR) ON DELETE CASCADE,
    CONSTRAINT GENERO_FILME FOREIGN KEY(GENEROID) REFERENCES AU4AT1.GENERO(IDGENERO) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AU4AT1.FILME_PREMIACAO(
    FILMEID INT,
    PREMIACAOID INT,
    GANHOU BOOL,

    CONSTRAINT FILME_TEM_PREMIACAO FOREIGN KEY(FILMEID) REFERENCES AU4AT1.FILME(IDFILME) ON DELETE CASCADE,
    CONSTRAINT PREMIACAO_DO_DILME FOREIGN KEY(PREMIACAOID) REFERENCES AU4AT1.PREMIACAO(IDPREMAIACAO) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS AU4AT1.FILME_SALA(
    FILMEID INT,
    SALAID INT,
    HORARIOID INT,

    CONSTRAINT FILME_NA_SALA FOREIGN KEY(FILMEID) REFERENCES AU4AT1.FILME(IDFILME) ON DELETE CASCADE,
    CONSTRAINT SALA_DO_FILME FOREIGN KEY(SALAID) REFERENCES AU4AT1.SALA(IDSALA) ON DELETE CASCADE,
    CONSTRAINT HORARIO_FILME FOREIGN KEY(HORARIOID) REFERENCES AU4AT1.HORARIO(IDHORARIO) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AU4AT1.TRABALHO_FUNCIONARIO(
    HORARIOID INT,
    FUNCIONARIOID INT,
    FUNCAOID INT,

    CONSTRAINT HORARIO_FUNCIONARIO FOREIGN KEY(HORARIOID) REFERENCES AU4AT1.HORARIO(IDHORARIO) ON DELETE CASCADE,

    CONSTRAINT FUNCIONARIO_HORARIO FOREIGN KEY(FUNCAOID) REFERENCES AU4AT1.FUNCIONARIO(IDFUNCIONARIO) ON DELETE CASCADE,

    CONSTRAINT FUNCAO_FUNCIONARIO FOREIGN KEY(FUNCAOID) REFERENCES AU4AT1.FUNCAO(IDFUNCAO) ON DELETE CASCADE
);

-- Inserindo Valores sem relação


ALTER TABLE


INSERT INTO AU4AT1.FUNCIONARIO (NOME, CARTEIRATRABALHO, DATACONTRATACAO, SALARIO) VALUES
('Carlos Souza', 12345, '2020-03-15', 3500.00),
('Ana Oliveira', 12890, '2018-07-22', 4200.00),
('Mariana Santos', 11021, '2022-01-10', 3100.00),
('João Silva', 12233, '2019-05-10', 3800.00),
('Maria Souza', 14455, '2021-02-18', 3200.00),
('Fernando Lima', 16677, '2017-11-05', 4500.00),
('Luciana Alves', 18899, '2023-06-15', 2900.00),
('Ricardo Mendes', 11223, '2015-08-22', 5000.00);



INSERT INTO AU4AT1.FUNCAO (NOME) VALUES
('Bilheteiro'),
('Gerente'),
('Técnico de Som'),
('Operador de Projetor'),
('Atendente'),
('Segurança'),
('Zelador');


INSERT INTO AU4AT1.HORARIO (HORARIO) VALUES
('14:00:00'),
('17:00:00'),
('20:00:00'),
('10:00:00'),
('12:30:00'),
('15:45:00'),
('19:00:00');


INSERT INTO AU4AT1.SALA (NOME, CAPACIDADE) VALUES
('Sala 1', 100),
('Sala 2', 150),
('Sala 3', 200),
('Sala 4', 120),
('Sala 5', 180),
('Sala 4', 120),
('Sala 5', 180),
('Sala 6', 250);



INSERT INTO AU4AT1.DIRETOR (NOME) VALUES
('Christopher Nolan'),
('Steven Spielberg'),
('Quentin Tarantino');


INSERT INTO AU4AT1.GENERO (NOME) VALUES
('Ação'),
('Drama'),
('Ficção Científica');

INSERT INTO AU4AT1.PREMIACAO (NOME, ANO) VALUES
('Oscar de Melhor Filme', 2023),
('Globo de Ouro - Melhor Direção', 2022),
('BAFTA - Melhor Roteiro', 2021);


-- Inserindo valores com relação
INSERT INTO AU4AT1.FILME (NOMEBR, NOMEEN, ANOLANCAMENTO, DIRETORID, SINOPSE, GENEROID) VALUES
('O Grande Truque', 'The Prestige', 2006, 1, 'Dois mágicos rivais disputam o segredo de um truque incrível.', 3),
('Jurassic Park', 'Jurassic Park', 1993, 2, 'Cientistas clonam dinossauros e os mantêm em um parque temático.', 1),
('Pulp Fiction', 'Pulp Fiction', 1994, 3, 'Histórias interligadas sobre crime e redenção.', 2),
('Akira', 'Akira', 1988, 5, 'Num futuro cyberpunk, um jovem ganha poderes psíquicos que ameaçam Tóquio.', 3),
('O Castelo Animado', 'Howl’s Moving Castle', 2004, 4, 'Sophie é amaldiçoada por uma bruxa e encontra refúgio em um castelo mágico.', 4),
('A Voz do Silêncio', 'A Silent Voice', 2016, 5, 'Um jovem busca redenção após praticar bullying contra uma garota surda.', 5);



INSERT INTO AU4AT1.FILME_PREMIACAO (FILMEID, PREMIACAOID, GANHOU) VALUES
(1, 2, TRUE),
(2, 1, FALSE),
(3, 3, TRUE),
(7, 4, TRUE),  
(8, 5, TRUE),
(9, 6, TRUE);


INSERT INTO AU4AT1.FILME_SALA (FILMEID, SALAID, HORARIOID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(7, 4, 3),  
(8, 5, 4),
(9, 6, 1);




INSERT INTO AU4AT1.TRABALHO_FUNCIONARIO (HORARIOID, FUNCIONARIOID, FUNCAOID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(1, 4, 2),
(2, 5, 3),
(3, 1, 1),
(4, 2, 4),
(2, 3, 2),
(3, 4, 1);

-- TRUNCATE AU4AT1.FILME_SALA; limpar registros


SELECT * from AU4AT1.FUNCIONARIO;
SELECT * from AU4AT1.FUNCAO;
SELECT * from AU4AT1.HORARIO;
SELECT * from AU4AT1.SALA;
SELECT * from AU4AT1.DIRETOR;
SELECT * from AU4AT1.GENERO;
SELECT * from AU4AT1.PREMIACAO;
SELECT * from AU4AT1.FILME;
SELECT * from AU4AT1.FILME_SALA;
SELECT * from AU4AT1.FILME_PREMIACAO;
SELECT * from AU4AT1.TRABALHO_FUNCIONARIO;

-- Atividades

-- 1 Média dos salários dos funcionários
/* SELECT AVG(salario) FROM AU4AT1.FUNCIONARIO; -- PARÂMETRO DA AVG É O NOME DA COLUNA */
-- 1 PROFESSOR:
CREATE VIEW SALARIO_MEDIO AS SELECT AVG(SALARIO) AS MEDIA_SALARIO FROM AU4AT1.funcionario;

SELECT * FROM SALARIO_MEDIO;



-- 2 LISTAR FUNCIONARIO E SUAS FUNÇÕES INCLUINDO AQUELES SEM FUNÇÃO DEFINIDA
/*SELECT F.IDFUNCIONARIO AS ID, F.NOME AS FUNCIONARIO, FO.NOME AS FUNCAO FROM AU4AT1.FUNCIONARIO F
LEFT JOIN AU4AT1.TRABALHO_FUNCIONARIO TF ON F.IDFUNCIONARIO = TF.FUNCIONARIOID
LEFT JOIN AU4AT1.FUNCAO FO ON TF.FUNCAOID = FO.IDFUNCAO;*/
-- 2 PROFESSOR:
SELECT F.NOME AS FUNCIONARIO, COALESCE(FUNC.NOME,'SEM FUNÇÃO') AS "FUNÇÃO" FROM AU4AT1.FUNCIONARIO F
LEFT JOIN AU4AT1.FUNCAO FUNC ON F.idfuncionario = FUNC.idfuncao;

-- COALESCE É USADO PARAR SUBSTITUIR VALORES NULOS, OU SEJA AQUELE FUNCIONÁRIO QUE NÃO TEM FUNÇÃO TAMBÉM É LISTADO



-- 3 RETORNAR O NOME DE TODOS OS FUNCIONÁRIOS QUE POSSUEM O MESMO HORÁRIO DE ALGUM OUTRO FUNCIONARIO
/*SELECT DISTINCT F1.NOME AS FUNCIONARIO, H.HORARIO FROM AU4AT1.TRABALHO_FUNCIONARIO TF1
JOIN AU4AT1.TRABALHO_FUNCIONARIO TF2 ON TF1.HORARIOID = TF2.HORARIOID AND TF1.FUNCIONARIOID <> TF2.FUNCIONARIOID
JOIN AU4AT1.FUNCIONARIO F1 ON TF1.FUNCIONARIOID = F1.IDFUNCIONARIO
JOIN AU4AT1.HORARIO H ON TF1.HORARIOID = H.IDHORARIO;*/

-- Professor:
SELECT DISTINCT F1.NOME AS "Funcionário 1", F2.NOME AS "Funcionário 2", H.HORARIO AS "Horário" FROM AU4AT1.trabalho_funcionario HT1
JOIN AU4AT1.trabalho_funcionario HT2 ON HT1.horarioid = HT2.horarioid
AND HT1.funcionarioid <> HT2.funcionarioid
JOIN AU4AT1.funcionario F1 ON HT1.funcionarioid = F1.idfuncionario
JOIN AU4AT1.funcionario F2 ON HT2.funcaoid = F2.idfuncionario
JOIN AU4AT1.horario H ON HT1.horarioid = H.idhorario;

-- 4 ENCONTRAR FILMES QUE FORAM EXIBIDOS EM PELO MENOS DUAS SALAS DIFERENTES

SELECT FI.NOMEBR, S.NOME FROM AU4AT1.FILME FI, AU4AT1.SALA S
JOIN LEFT AU4AT1.FILME_SALA FS ON FI.idfilme = FS.filmeid;

SELECT F.NOMEBR AS FILME, COUNT(DISTINCT FS.SALAID) AS QTDE_SALAS FROM AU4AT1.FILME_SALA FS
JOIN AU4AT1.FILME F ON FS.FILMEID = F.IDFILME GROUP BY F.NOMEBR HAVING COUNT(DISTINCT FS.SALAID) >= 2;


-- 10 Listar os filmes que foram exibidos na mesma sala em horários diferentes

-- Professor:
SELECT F.nomeBR AS "Título", S.nome AS Sala 
FROM AU4AT1.filme_sala FS1
JOIN AU4AT1.filme_sala FS2 ON FS1.salaid = FS2.salaid 
AND FS1.filmeid = FS2.filmeid 
AND FS1.HORARIOID <> FS2.HORARIOID
JOIN AU4AT1.FILME F ON FS1.filmeid = F.idfilme
JOIN AU4AT1.SALA S ON FS1.salaid = S.idsala;



=======
-- TABELAS SEM RELAÇÕES

CREATE TABLE IF NOT EXISTS AU4AT1.FUNCIONARIO(
    IDFUNCIONARIO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    CARTEIRATRABALHO SMALLINT,
    DATACONTRATACAO DATE,
    SALARIO DECIMAL(6,2)
);

CREATE TABLE IF NOT EXISTS AU4AT1.FUNCAO(
    IDFUNCAO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.HORARIO(
    IDHORARIO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    HORARIO TIME
);

CREATE TABLE IF NOT EXISTS AU4AT1.SALA(
    IDSALA INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    CAPACIDADE SMALLINT
);

CREATE TABLE IF NOT EXISTS AU4AT1.DIRETOR(
    IDDIRETOR INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.GENERO(
    IDGENERO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS AU4AT1.PREMIACAO(
    IDPREMAIACAO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(45),
    ANO INT
);

-- TABELAS COM RELAÇÕES

CREATE TABLE IF NOT EXISTS AU4AT1.FILME(
    IDFILME INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOMEBR VARCHAR(45),
    NOMEEN VARCHAR(45),
    ANOLANCAMENTO INT,
    DIRETORID INT,
    SINOPSE TEXT,
    GENEROID INT,

    CONSTRAINT DIRETO_FILME FOREIGN KEY(DIRETORID) REFERENCES AU4AT1.DIRETOR(IDDIRETOR) ON DELETE CASCADE,
    CONSTRAINT GENERO_FILME FOREIGN KEY(GENEROID) REFERENCES AU4AT1.GENERO(IDGENERO) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AU4AT1.FILME_PREMIACAO(
    FILMEID INT,
    PREMIACAOID INT,
    GANHOU BOOL,

    CONSTRAINT FILME_TEM_PREMIACAO FOREIGN KEY(FILMEID) REFERENCES AU4AT1.FILME(IDFILME) ON DELETE CASCADE,
    CONSTRAINT PREMIACAO_DO_DILME FOREIGN KEY(PREMIACAOID) REFERENCES AU4AT1.PREMIACAO(IDPREMAIACAO) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS AU4AT1.FILME_SALA(
    FILMEID INT,
    SALAID INT,
    HORARIOID INT,

    CONSTRAINT FILME_NA_SALA FOREIGN KEY(FILMEID) REFERENCES AU4AT1.FILME(IDFILME) ON DELETE CASCADE,
    CONSTRAINT SALA_DO_FILME FOREIGN KEY(SALAID) REFERENCES AU4AT1.SALA(IDSALA) ON DELETE CASCADE,
    CONSTRAINT HORARIO_FILME FOREIGN KEY(HORARIOID) REFERENCES AU4AT1.HORARIO(IDHORARIO) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AU4AT1.TRABALHO_FUNCIONARIO(
    HORARIOID INT,
    FUNCIONARIOID INT,
    FUNCAOID INT,

    CONSTRAINT HORARIO_FUNCIONARIO FOREIGN KEY(HORARIOID) REFERENCES AU4AT1.HORARIO(IDHORARIO) ON DELETE CASCADE,

    CONSTRAINT FUNCIONARIO_HORARIO FOREIGN KEY(FUNCAOID) REFERENCES AU4AT1.FUNCIONARIO(IDFUNCIONARIO) ON DELETE CASCADE,

    CONSTRAINT FUNCAO_FUNCIONARIO FOREIGN KEY(FUNCAOID) REFERENCES AU4AT1.FUNCAO(IDFUNCAO) ON DELETE CASCADE
);

-- Inserindo Valores sem relação


ALTER TABLE


INSERT INTO AU4AT1.FUNCIONARIO (NOME, CARTEIRATRABALHO, DATACONTRATACAO, SALARIO) VALUES
('Carlos Souza', 12345, '2020-03-15', 3500.00),
('Ana Oliveira', 12890, '2018-07-22', 4200.00),
('Mariana Santos', 11021, '2022-01-10', 3100.00),
('João Silva', 12233, '2019-05-10', 3800.00),
('Maria Souza', 14455, '2021-02-18', 3200.00),
('Fernando Lima', 16677, '2017-11-05', 4500.00),
('Luciana Alves', 18899, '2023-06-15', 2900.00),
('Ricardo Mendes', 11223, '2015-08-22', 5000.00);



INSERT INTO AU4AT1.FUNCAO (NOME) VALUES
('Bilheteiro'),
('Gerente'),
('Técnico de Som'),
('Operador de Projetor'),
('Atendente'),
('Segurança'),
('Zelador');


INSERT INTO AU4AT1.HORARIO (HORARIO) VALUES
('14:00:00'),
('17:00:00'),
('20:00:00'),
('10:00:00'),
('12:30:00'),
('15:45:00'),
('19:00:00');


INSERT INTO AU4AT1.SALA (NOME, CAPACIDADE) VALUES
('Sala 1', 100),
('Sala 2', 150),
('Sala 3', 200),
('Sala 4', 120),
('Sala 5', 180),
('Sala 4', 120),
('Sala 5', 180),
('Sala 6', 250);



INSERT INTO AU4AT1.DIRETOR (NOME) VALUES
('Christopher Nolan'),
('Steven Spielberg'),
('Quentin Tarantino');


INSERT INTO AU4AT1.GENERO (NOME) VALUES
('Ação'),
('Drama'),
('Ficção Científica');

INSERT INTO AU4AT1.PREMIACAO (NOME, ANO) VALUES
('Oscar de Melhor Filme', 2023),
('Globo de Ouro - Melhor Direção', 2022),
('BAFTA - Melhor Roteiro', 2021);


-- Inserindo valores com relação
INSERT INTO AU4AT1.FILME (NOMEBR, NOMEEN, ANOLANCAMENTO, DIRETORID, SINOPSE, GENEROID) VALUES
('O Grande Truque', 'The Prestige', 2006, 1, 'Dois mágicos rivais disputam o segredo de um truque incrível.', 3),
('Jurassic Park', 'Jurassic Park', 1993, 2, 'Cientistas clonam dinossauros e os mantêm em um parque temático.', 1),
('Pulp Fiction', 'Pulp Fiction', 1994, 3, 'Histórias interligadas sobre crime e redenção.', 2),
('Akira', 'Akira', 1988, 5, 'Num futuro cyberpunk, um jovem ganha poderes psíquicos que ameaçam Tóquio.', 3),
('O Castelo Animado', 'Howl’s Moving Castle', 2004, 4, 'Sophie é amaldiçoada por uma bruxa e encontra refúgio em um castelo mágico.', 4),
('A Voz do Silêncio', 'A Silent Voice', 2016, 5, 'Um jovem busca redenção após praticar bullying contra uma garota surda.', 5);



INSERT INTO AU4AT1.FILME_PREMIACAO (FILMEID, PREMIACAOID, GANHOU) VALUES
(1, 2, TRUE),
(2, 1, FALSE),
(3, 3, TRUE),
(7, 4, TRUE),  
(8, 5, TRUE),
(9, 6, TRUE);


INSERT INTO AU4AT1.FILME_SALA (FILMEID, SALAID, HORARIOID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(7, 4, 3),  
(8, 5, 4),
(9, 6, 1);




INSERT INTO AU4AT1.TRABALHO_FUNCIONARIO (HORARIOID, FUNCIONARIOID, FUNCAOID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(1, 4, 2),
(2, 5, 3),
(3, 1, 1),
(4, 2, 4),
(2, 3, 2),
(3, 4, 1);

-- TRUNCATE AU4AT1.FILME_SALA; limpar registros


SELECT * from AU4AT1.FUNCIONARIO;
SELECT * from AU4AT1.FUNCAO;
SELECT * from AU4AT1.HORARIO;
SELECT * from AU4AT1.SALA;
SELECT * from AU4AT1.DIRETOR;
SELECT * from AU4AT1.GENERO;
SELECT * from AU4AT1.PREMIACAO;
SELECT * from AU4AT1.FILME;
SELECT * from AU4AT1.FILME_SALA;
SELECT * from AU4AT1.FILME_PREMIACAO;
SELECT * from AU4AT1.TRABALHO_FUNCIONARIO;

-- Atividades

-- 1 Média dos salários dos funcionários
/* SELECT AVG(salario) FROM AU4AT1.FUNCIONARIO; -- PARÂMETRO DA AVG É O NOME DA COLUNA */
-- 1 PROFESSOR:
CREATE VIEW SALARIO_MEDIO AS SELECT AVG(SALARIO) AS MEDIA_SALARIO FROM AU4AT1.funcionario;

SELECT * FROM SALARIO_MEDIO;



-- 2 LISTAR FUNCIONARIO E SUAS FUNÇÕES INCLUINDO AQUELES SEM FUNÇÃO DEFINIDA
/*SELECT F.IDFUNCIONARIO AS ID, F.NOME AS FUNCIONARIO, FO.NOME AS FUNCAO FROM AU4AT1.FUNCIONARIO F
LEFT JOIN AU4AT1.TRABALHO_FUNCIONARIO TF ON F.IDFUNCIONARIO = TF.FUNCIONARIOID
LEFT JOIN AU4AT1.FUNCAO FO ON TF.FUNCAOID = FO.IDFUNCAO;*/
-- 2 PROFESSOR:
SELECT F.NOME AS FUNCIONARIO, COALESCE(FUNC.NOME,'SEM FUNÇÃO') AS "FUNÇÃO" FROM AU4AT1.FUNCIONARIO F
LEFT JOIN AU4AT1.FUNCAO FUNC ON F.idfuncionario = FUNC.idfuncao;

-- COALESCE É USADO PARAR SUBSTITUIR VALORES NULOS, OU SEJA AQUELE FUNCIONÁRIO QUE NÃO TEM FUNÇÃO TAMBÉM É LISTADO



-- 3 RETORNAR O NOME DE TODOS OS FUNCIONÁRIOS QUE POSSUEM O MESMO HORÁRIO DE ALGUM OUTRO FUNCIONARIO
/*SELECT DISTINCT F1.NOME AS FUNCIONARIO, H.HORARIO FROM AU4AT1.TRABALHO_FUNCIONARIO TF1
JOIN AU4AT1.TRABALHO_FUNCIONARIO TF2 ON TF1.HORARIOID = TF2.HORARIOID AND TF1.FUNCIONARIOID <> TF2.FUNCIONARIOID
JOIN AU4AT1.FUNCIONARIO F1 ON TF1.FUNCIONARIOID = F1.IDFUNCIONARIO
JOIN AU4AT1.HORARIO H ON TF1.HORARIOID = H.IDHORARIO;*/

-- Professor:
SELECT DISTINCT F1.NOME AS "Funcionário 1", F2.NOME AS "Funcionário 2", H.HORARIO AS "Horário" FROM AU4AT1.trabalho_funcionario HT1
JOIN AU4AT1.trabalho_funcionario HT2 ON HT1.horarioid = HT2.horarioid
AND HT1.funcionarioid <> HT2.funcionarioid
JOIN AU4AT1.funcionario F1 ON HT1.funcionarioid = F1.idfuncionario
JOIN AU4AT1.funcionario F2 ON HT2.funcaoid = F2.idfuncionario
JOIN AU4AT1.horario H ON HT1.horarioid = H.idhorario;

-- 4 ENCONTRAR FILMES QUE FORAM EXIBIDOS EM PELO MENOS DUAS SALAS DIFERENTES

SELECT FI.NOMEBR, S.NOME FROM AU4AT1.FILME FI, AU4AT1.SALA S
JOIN LEFT AU4AT1.FILME_SALA FS ON FI.idfilme = FS.filmeid;

SELECT F.NOMEBR AS FILME, COUNT(DISTINCT FS.SALAID) AS QTDE_SALAS FROM AU4AT1.FILME_SALA FS
JOIN AU4AT1.FILME F ON FS.FILMEID = F.IDFILME GROUP BY F.NOMEBR HAVING COUNT(DISTINCT FS.SALAID) >= 2;


-- 10 Listar os filmes que foram exibidos na mesma sala em horários diferentes

-- Professor:
SELECT F.nomeBR AS "Título", S.nome AS Sala 
FROM AU4AT1.filme_sala FS1
JOIN AU4AT1.filme_sala FS2 ON FS1.salaid = FS2.salaid 
AND FS1.filmeid = FS2.filmeid 
AND FS1.HORARIOID <> FS2.HORARIOID
JOIN AU4AT1.FILME F ON FS1.filmeid = F.idfilme
JOIN AU4AT1.SALA S ON FS1.salaid = S.idsala;

--12. Exibir todas as funções diferentes que os funcionários 
-- exercem e a quantidade de funcionários em cada uma.

SELECT AU4AT1.FUNCAO.NOME AS FUNCAO, COUNT(F.IDFUNCIONARIO) AS TOTAL_FUNCIONARIO FROM AU4AT1.FUNCIONARIO F
JOIN AU4AT1.FUNCAO ON F.IDFUNCIONARIO = AU4AT1.FUNCAO.IDFUNCAO
GROUP BY AU4AT1.FUNCAO.NOME; -- Group by é usado para agrupar linhas com base em uma ou mais colunas

SELECT * from AU4AT1.funcao;

-- 13 Encontrar os filmes que foram exibidos em sala
-- com capacidade superior à media de todas as salas
SELECT F.NOMEBR AS "Título", S.NOME AS "Sala", S.CAPACIDADE AS "Capacidade"FROM AU4AT1.filme_sala FS
JOIN AU4AT1.sala S ON FS.salaid = S.idsala
JOIN AU4AT1.filme F ON FS.filmeid = F.idfilme 
WHERE S.capacidade > (SELECT AVG(CAPACIDADE) FROM AU4AT1.SALA);

-- 15 Exibir a relação entre a capacidade da sala e o número total de filmes exibidos nela.

SELECT S.NOME AS "Sala", S.CAPACIDADE AS "Capacidade", COUNT (FS.FILMEID) AS "Total de filmes", (COUNT(FS.FILMEID)/ NULLIF(S.CAPACIDADE,0)) AS "Filmes por assento"
FROM AU4AT1.SALA S
LEFT JOIN AU4AT1.FILME_SALA FS ON S.IDSALA = FS.SALAID
GROUP BY S.idsala, S.capacidade;
>>>>>>> 279bbf3 (Trigger)
