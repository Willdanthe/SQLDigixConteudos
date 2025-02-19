CREATE TABLE IF NOT EXISTS au8.time (
id INTEGER PRIMARY KEY,
nome VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS au8.partida (
id INTEGER PRIMARY KEY,
time_1 INTEGER,
time_2 INTEGER,
time_1_gols INTEGER,
time_2_gols INTEGER,
FOREIGN KEY(time_1) REFERENCES au8.time(id),
FOREIGN KEY(time_2) REFERENCES au8.time(id)
);
INSERT INTO au8.time(id, nome) VALUES
(1,'CORINTHIANS'),
(2,'SÃO PAULO'),
(3,'CRUZEIRO'),
(4,'ATLETICO MINEIRO'),
(5,'PALMEIRAS');
INSERT INTO au8.partida(id, time_1, time_2, time_1_gols, time_2_gols)
VALUES
(1,4,1,0,4),
(2,3,2,0,1),
(3,1,3,3,0),
(4,3,4,0,1),
(5,1,2,0,0),
(6,2,4,2,2),
(7,1,5,1,2),
(8,5,2,1,2);

-- Tabela Temporária: Elas são para dados temporários, e que são de única sessão de banco de dados

CREATE TEMP TABLE TEMP_TIME AS SELECT * FROM AU8.TIME;
CREATE TEMP TABLE TEMP_JOGO AS SELECT * FROM AU8.partida WHERE TIME_1=1 OR TIME_2=1;

SELECT * FROM TEMP_TIME;
SELECT * FROM TEMP;

TRUNCATE TABLE TEMP_TIME;
-- INSERT INTO TEMP_TIME (ID,NOME) VALUES (1,'Corinthians');
INSERT INTO TEMP_JOGO SELECT * FROM AU8.partida WHERE TIME_1=1 OR TIME_2=1;

CREATE OR REPLACE FUNCTION OPRECAO_FUNCAO() RETURNS VOID AS $$
DECLARE
    V_ID INTEGER;
    V_NOME VARCHAR;
BEGIN
    -- Atribuindo valores nas variáveis
    -- V_ID := 1;
    -- V_NOME := 'CORINTHIANS';

    -- RAISE NOTICE 'ID: %, Nome: %', V_ID,V_NOME;

    -- Operação matemática

    RAISE NOTICE 'ID: %', V_ID;
    RAISE NOTICE 'Soma: %', 1+1;
    RAISE NOTICE 'Subtração: %', 1-1;
    RAISE NOTICE 'Multiplicação: %', 1*1;
    RAISE NOTICE 'Divisão: %', 1/1;

     -- Operação De comparação
    RAISE NOTICE '1 Maior 2: %', 1 > 2;
    RAISE NOTICE '1 Maior ou igual 2: %', 1 >= 2;
    RAISE NOTICE '1 Menor 2: %', 1 < 2;
    RAISE NOTICE ' 1 Menor ou igual 2: %', 1 <= 2;
    RAISE NOTICE '1 Igual 2: %', 1 = 2;
    RAISE NOTICE '1 Diferente 2: %', 1 <> 2;

    -- Operação de concatenação
    RAISE NOTICE 'Concatenação: %' , 'Aula ' || 'Digix';

    -- Operação de lógica
    RAISE NOTICE 'Verdadeiro E Verdadeiro: %', TRUE AND FALSE;
    RAISE NOTICE 'Verdadeiro Ou Falso: %', TRUE OR FALSE;
    RAISE NOTICE 'Não Verdadeiro: %', NOT TRUE;

    -- Manipulação de String
    RAISE NOTICE 'String: "Aula Digix"';
    RAISE NOTICE 'TAMANHO: %', LENGTH('Aula Digix');
    RAISE NOTICE 'SUBSTITUIÇÃO: %', REPLACE('Aula Digix','Digix','Postgres');
    RAISE NOTICE 'POSIÇÃO: %', POSITION('Digix' in 'Aula Digix');
    RAISE NOTICE 'SUB STRING: %', SUBSTRING('Aula Digix', 6 ,5);
    RAISE NOTICE 'Maiúscula: %', UPPER('Aula Digix');
    RAISE NOTICE 'Minúscula: %', LOWER('Aula Digix');

    -- Manipulação de Data
    RAISE NOTICE 'Data atual: %', NOW(); -- Data e Hora
    RAISE NOTICE 'Data atual: %', CURRENT_DATE;
    RAISE NOTICE 'Hora atual: %', CURRENT_TIME;

    -- Manipulação de array :,<V
    RAISE NOTICE 'ARRAY: %', ARRAY[1, 2, 3, 4, 5];
    RAISE NOTICE 'ARRAY: %', ARRAY['Aula', 'Digix'];
    -- RAISE NOTICE 'ARRAY: %', ARRAY['Aula', 1, TRUE]; NÃO É POSSÍVEL ARRAY COM TIPOS DIFERENTES
    RAISE NOTICE 'MATRIZ: %', 
    ARRAY[
        [[1,2,3],[4,5,6]],
        [[7,8,9],[10,11,12]]
    ];

    -- RAISE NOTICE 'MATRIZ TRIDIMENCIONAL: %', ARRAY[[]];

END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM oprecao_funcao();

-- Criar uma função que recebe parâmetros e retorna um valor

CREATE OR REPLACE FUNCTION AU8.OBTER_NOME_TIMES(P_ID INTEGER) RETURNS VARCHAR AS $$
DECLARE
    V_NOME VARCHAR(50);
BEGIN
    SELECT NOME into V_NOME FROM AU8.TIME WHERE ID = P_ID; -- O into está 'enviando' os dados para a variável v_nome
    RETURN V_NOME;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.obter_nome_times(1);

-- Criar função com loops
CREATE OR REPLACE FUNCTION OBTER_TIMES() RETURNS SETOF TIME AS $$
DECLARE
    I INTEGER := 1;
BEGIN
    -- LOOP -- Equivalente ao while
    --     EXIT WHEN I > 5;
    --     RAISE NOTICE 'Valor de i: %',i;
    --     i := i + 1;
    -- END LOOP;
    -- I := 1

    FOR I IN 1..5 LOOP --  A gente coloca os 2 pontos para indicar o inicio e o fim do loop
        RAISE NOTICE 'Valor de i: %', I;
    END LOOP;

    WHILE I <= 5 LOOP
        RAISE NOTICE 'Valor de i: %', i;
        I := I+1;
END LOOP;
RETURN;
END;
$$ LANGUAGE PLPGSQL;

SELECT OBTER_TIMES();

-- Criar uma função que percorra uma tabela usando RETURN NEXT
CREATE OR REPLACE FUNCTION OBTER_TIMES_DADOS() RETURNS SETOF TIME AS 
$$
DECLARE
    V_TIME TIME%ROWTYPE; -- ROWTYPE É PARA PEGAR O TIPO DA VAIÁVEL DA TABELA
BEGIN
    FOR V_TIME IN (SELECT * FROM TIME) LOOP
        RETURN NEXT V_TIME;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.obter_times_dados();

-- 5. Função que trabalha condições
CREATE OR REPLACE FUNCTION AU8.GOLS() RETURNS SETOF AU8.TIME AS $$
DECLARE
    V_GOLS INTEGER;
BEGIN
    SELECT TIME_1_GOLS INTO V_GOLS FROM au8.PARTIDA WHERE TIME_1 = 1;
    IF V_GOLS > 2 THEN 
        RAISE NOTICE 'Time marcou mais de 2 Gols';
    ELSE
        RAISE NOTICE 'Time marcou menos de 2 Gols';
    END IF;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.GOLS();

-- Função que Trata Exceções
CREATE OR REPLACE FUNCTION AU8.obter_nome_times(P_ID INTEGER) RETURNS VARCHAR AS $$
DECLARE
    V_NOME VARCHAR(50);
BEGIN
    SELECT NOME INTO V_NOME FROM AU8.TIME WHERE ID = P_ID;
    RETURN V_NOME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE NOTICE 'Nenhum registro encontrado';
END;
$$ LANGUAGE PLPGSQL;

SELECT obter_nome_times(1);