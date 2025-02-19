-- Criando as Tabelas
CREATE TABLE IF NOT EXISTS exi.usuario(
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    senha VARCHAR(15) NOT NULL CHECK(LENGTH(senha) > 3),
    nome VARCHAR(30) NOT NULL,
    ramal SMALLINT UNIQUE, 
    especialidade VARCHAR(30) DEFAULT ('Nenhuma')
);

CREATE TABLE IF NOT EXISTS exi.maquina(
    id_maquina INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    tipo VARCHAR(15) NOT NULL CHECK(tipo IN('CORE II','Pentium','CORE III', 'CORE V')),
    velocidade DECIMAL(4,2) NOT NULL,
    armazenamento INT NOT NULL ,
    placaRede DECIMAL NOT NULL,
    ram INT NOT NULL
);

CREATE TABLE IF NOT EXISTS exi.software(
    id_software INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    produto VARCHAR(30) NOT NULL,
    armazenamento INT NOT NULL,
    ram INT NOT NULL
);

CREATE TABLE IF NOT EXISTS exi.contem(
    fk_maquina INT NOT NULL,
    fk_software INT NOT NULL,

    CONSTRAINT id_software FOREIGN KEY(fk_software) REFERENCES exi.software(id_software) ON DELETE CASCADE,
    CONSTRAINT id_maquina FOREIGN KEY(fk_maquina) REFERENCES exi.maquina(id_maquina) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exi.possuem(
    fk_usuario INT NOT NULL,
    fk_maquina INT NOT NULL,

    CONSTRAINT id_usuario FOREIGN KEY(fk_usuario) REFERENCES exi.usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT id_maquina FOREIGN KEY(fk_maquina) REFERENCES exi.maquina(id_maquina) ON DELETE CASCADE
);



-- Povoando as Tabelas
INSERT INTO exi.usuario (senha, nome, ramal, especialidade) VALUES
('abc123', 'Carlos Silva', 101, 'Tecnico'),
('senha123', 'Ana Souza', 102, 'Tecnico'),
('pass321', 'Roberto Lima', 103, 'RH'),
('key456', 'Juliana Mendes', 104, 'RH'),
('segredo', 'Maria', 105, 'Financeiro');

INSERT INTO exi.maquina (tipo, velocidade, armazenamento, placaRede, ram) VALUES
('CORE II', 2.40, 500, 1.0, 8),
('Pentium', 3.00, 256, 1.5, 4),
('CORE III', 2.80, 1000, 1.2, 16),
('CORE V', 3.50, 512, 1.0, 8),
('CORE II', 2.20, 1024, 1.3, 12);

INSERT INTO exi.software (produto, armazenamento, ram) VALUES
('C++', 50, 4),
('C#', 25, 2),
('Python', 800, 8),
('Lotus', 50, 16),
('Word', 100, 4);

INSERT INTO exi.contem (fk_maquina, fk_software) VALUES
(1, 1), -- Máquina 1 tem Windows 10
(2, 2), -- Máquina 2 tem Linux Ubuntu
(3, 3), -- Máquina 3 tem Photoshop
(4, 4), -- Máquina 4 tem AutoCAD
(5, 5); -- Máquina 5 tem Office 365

INSERT INTO exi.possuem (fk_usuario, fk_maquina) VALUES
(1, 1), -- Carlos usa a Máquina 1
(2, 2), -- Ana usa a Máquina 2
(3, 3), -- Roberto usa a Máquina 3
(4, 4), -- Juliana usa a Máquina 4
(5, 5); -- Fernando usa a Máquina 5




-- DELETAR AS TABELAS
DROP TABLE IF EXISTS exi.contem CASCADE;
DROP TABLE IF EXISTS exi.possuem CASCADE;
DROP TABLE IF EXISTS exi.software CASCADE;
DROP TABLE IF EXISTS exi.maquina CASCADE;
DROP TABLE IF EXISTS exi.usuario CASCADE;
-- DELETAR AS TABELAS


--1
SELECT * FROM exi.usuario WHERE especialidade = 'Tecnico';
--

--2
SELECT m1.tipo, m2.velocidade FROM exi.maquina m1 CROSS JOIN exi.maquina m2;
--

--3
SELECT m.tipo, m.velocidade FROM exi.maquina m where tipo IN ('CORE II','Pentium') ORDER BY m.tipo;
--

--4
SELECT m.id_maquina, m.tipo, m.placaRede from exi.maquina m WHERE m.placaRede < 1.3;
--

--5
SELECT u.nome from exi.usuario e WHERE exi.possuem.








-- **PROFESSOR CORREÇÃO** --

--12
SELECT tipo, count(id_maquina) FROM maquinas GROUP BY tipo;

--16 
SELECT avg(armazenamento) from software; -- avg = Média da coluna

--20
    SELECT maquina.[id_maquina], maquina.[armazenamento]
    from maquina
    where [armazenamento] > ALL (SELECT [armazenamento] from software);