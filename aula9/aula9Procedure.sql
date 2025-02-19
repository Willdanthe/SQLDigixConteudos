/*

        -- Diferença entre Function e Procedure
Function:
1- sempre retorna um valor simples  ou tabela
2-(Uso em Queries (SELECT)) pode usar select
3- não pode modificar tabelas
4- Chamadentro de uma query (Select nome_função)

Procedure: 
1- não precisa retornar um valor, pode ter OUT para saída
2- (Uso em Queries (SELECT)) não pode usar SELECT
3- pode manipular tabelas normalmente
4- chama separadamente com (call nome_procedure)

        -- Qual usar em casa caso?
se precisar de um valor de retorne em consulta usa Função

Se precisar modificar dados (insert, update, delete) usa PROCEDURE

Se precisar de controle transacional (COMMIT/ROLLBACK) usa PROCEDURE
se precisar retornar múltiplas colunas e linhas pode usar ambos. Function (returns table; PROCEDURE (OUT parameters))
*/

CREATE TABLE IF NOT EXISTS AU9.time (
id INTEGER PRIMARY KEY,
nome VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS AU9.partida (
id INTEGER PRIMARY KEY,
time_1 INTEGER,
time_2 INTEGER,
time_1_gols INTEGER,
time_2_gols INTEGER,
FOREIGN KEY(time_1) REFERENCES AU9.time(id),
FOREIGN KEY(time_2) REFERENCES AU9.time(id)
);
INSERT INTO AU9.time(id, nome) VALUES
(1,'CORINTHIANS'),
(2,'SÃO PAULO'),
(3,'CRUZEIRO'),
(4,'ATLETICO MINEIRO'),
(5,'PALMEIRAS');
INSERT INTO AU9.partida(id, time_1, time_2, time_1_gols, time_2_gols)
VALUES
(1,4,1,0,4),
(2,3,2,0,1),
(3,1,3,3,0),
(4,3,4,0,1),
(5,1,2,0,0),
(6,2,4,2,2),
(7,1,5,1,2),
(8,5,2,1,2);

SELECT * FROM AU9.PARTIDA;


-- PROCEDURE É UM CONJUNTO DE INSTRUIÇÕES SQL QUE PODEM SER EXECUTADAS EM CONJUNTO.

-- CRIANDO UM PROCEDURE NO POSTGRESQL
CREATE OR REPLACE PROCEDURE AU9.INSERIR_PARTIDA
(ID INTEGER,TIME_1 INTEGER, TIME_2 INTEGER, TIME_1_GOLS INTEGER, TIME_2_GOLS INTEGER) AS $$
BEGIN
        INSERT INTO AU9.partida(ID, TIME_1 , TIME_2 , TIME_1_GOLS , TIME_2_GOLS )
         VALUES (ID, TIME_1 , TIME_2 , TIME_1_GOLS , TIME_2_GOLS );
END;
$$ LANGUAGE PLPGSQL

-- EXECUTANDO PROCEDURE
CALL AU9.inserir_partida(9,1,2,10,0);

-- FAÇA A PROCEDURE UPDATE NOME DO TIME

CREATE OR REPLACE PROCEDURE AU9.ALTERANDO_NOME(ID_P INTEGER, NOVONOME VARCHAR(50)) AS $$
BEGIN
        UPDATE AU9.time SET NOME = NOVONOME WHERE ID = ID_P;
        IF NOT FOUND ID THEN
                RAISE EXCEPTION 'ID não encontrado';
        END IF;
END;
$$ LANGUAGE PLPGSQL

SELECT * FROM AU9.time;
CALL AU9.ALTERANDO_NOME(11,'CORINTHIANS');

-- FAÇA A PROCEDURE EXCLUIR PARTIDA E COM EXCEÇÃO PARA CASO NÃO ENCONTRE A PARTIDA
CREATE OR REPLACE PROCEDURE AU9.EXCLUINDO_PARTIDA(ID_P INTEGER)
AS $$
BEGIN
        DELETE FROM AU9.TIME WHERE ID = ID_P;

        IF NOT FOUND ID THEN
                RAISE EXCEPTION 'Partida não encontrada';
        END IF;
END;
$$ LANGUAGE PLPGSQL;

CALL AU9.EXCLUINDO_PARTIDA

