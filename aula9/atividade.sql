CREATE TABLE au9.Maquina (
    Id_Maquina INT PRIMARY KEY NOT NULL,
    Tipo VARCHAR(255),
    Velocidade INT,
    HardDisk INT,
    Placa_Rede INT,
    Memoria_Ram INT,
    Fk_Usuario INT,
    FOREIGN KEY(Fk_Usuario) REFERENCES Usuarios(ID_Usuario)
);

CREATE TABLE au9.Usuarios (
    ID_Usuario INT PRIMARY KEY NOT NULL,
    Password VARCHAR(255),
    Nome_Usuario VARCHAR(255),
    Ramal INT,
    Especialidade VARCHAR(255)
);
CREATE TABLE au9.Software (
    Id_Software INT PRIMARY KEY NOT NULL,
    Produto VARCHAR(255),
    HardDisk INT,
    Memoria_Ram INT,
    Fk_Maquina INT,
    FOREIGN KEY(Fk_Maquina) REFERENCES Maquina(Id_Maquina)
);
insert into au9.Maquina values (1, 'Desktop', 2, 500, 1, 4, 1);
insert into au9.Maquina values (2, 'Notebook', 1, 250, 1, 2, 2);
insert into au9.Maquina values (3, 'Desktop', 3, 1000, 1, 8, 3);
insert into au9.Maquina values (4, 'Notebook', 2, 500, 1, 4, 4);
insert into au9.Maquina values (5, 'ALL-IN-ONE', 2, 500, 1, 4, 3);

insert into au9.Usuarios values (1, '123', 'Joao', 123, 'TI');
insert into au9.Usuarios values (2, '456', 'Maria', 456, 'RH');
insert into au9.Usuarios values (3, '789', 'Jose', 789, 'Financeiro');
insert into au9.Usuarios values (4, '101', 'Ana', 101, 'TI');

insert into au9.Software values (1, 'Windows', 100, 2, 1);
insert into au9.Software values (2, 'Linux', 50, 1, 2);
insert into au9.Software values (3, 'Windows', 200, 4, 3);
insert into au9.Software values (4, 'Linux', 100, 2, 4);

SELECT * from au9.maquina;
SELECT * from au9.usuarios;
SELECT * from au9.software;


--1) CRIE UMA FUNÇÃO CHAMADA ESPAÇO_DISPONIVEL QUE RECEBE O ID DA MAQUINA E RETORNA TRUE, SE HOUVER ESPAÇO SUFICIENTE PARA INSTALAR UM SOFTWARE

CREATE OR REPLACE FUNCTION AU9.ESPACO_DISPONIVEL(ID_MAQUINAP INTEGER, ID_SOFTWAREP INTEGER) RETURNS BOOLEAN AS $$
DECLARE
    ESPACO_MAQUINA INTEGER;
    ESPACO_SOFTWARE INTEGER;
    -- ESPACO_DISPONIVEL BOOLEAN;
BEGIN
    IF NOT FOUND ID_MAQUINAP THEN
        RAISE EXCEPTION 'Máquina não encontrado';
        
    ELSEIF NOT FOUND ID_SOFTWAREP THEN
        RAISE EXCEPTION 'Software não encontrado';
    
    ELSE
        SELECT HardDisk INTO ESPACO_MAQUINA FROM AU9.maquina WHERE id_maquina = ID_MAQUINAP;
        SELECT HardDisk INTO ESPACO_SOFTWARE FROM AU9.software WHERE id_software = ID_SOFTWAREP;

        IF ESPACO_MAQUINA > ESPACO_SOFTWARE THEN
            -- ESPACO_DISPONIVEL := TRUE;
            RETURN TRUE;
        ELSE
            -- ESPACO_DISPONIVEL := FALSE;
            RETURN FALSE;
        END IF;
        -- RETURN ESPACO_DISPONIVEL;
    END IF;
END;
$$ LANGUAGE PLPGSQL;




SELECT * FROM AU9.espaco_disponivel(1,1);

-- 2) CRIE UMA PROCEDURE INSTALAR_SOFTWARE QUE SÓ INSTALA UM SOFTWARE SE HOUVER ESPAÇO DISPONÍVEL
CREATE OR REPLACE PROCEDURE AU9.INSTALAR_SOFTWARE(ID_MAQUINAP INTEGER, ID_SOFTWAREP INTEGER) AS $$
DECLARE
    ESPACO_MAQUINA INTEGER;
    ESPACO_SOFTWARE INTEGER;
BEGIN
        IF NOT FOUND ID_MAQUINAP THEN
            RAISE EXCEPTION 'Máquina não encontrado';
            
        ELSEIF NOT FOUND ID_SOFTWAREP THEN
            RAISE EXCEPTION 'Software não encontrado';
        
        ELSE
            IF AU9.espaco_disponivel(ID_MAQUINA, id_software) THEN
                UPDATE AU9.software SET fk_maquina = ID_MAQUINAP WHERE id_software = id_softwareP;
            ELSE
                RAISE EXCEPTION 'Máquina não possui espaço suficiente';
        END IF;
    END IF;
END;
$$ LANGUAGE PLPGSQL;


SELECT * from au9.software;

-- 3) CRIE UMA FUNÇÃO CHAMADA MÁQUINAS_DO_USUARIO QUE RETORNA UMA LISTA DE MÁQUINAS ASSOCIADAS A UM USUÁRIO.
-- CREATE OR REPLACE FUNCTION MAQUINAS_DO_USUARIO(ID_USUARIOP INTEGER) RETURNS TABLE (Id_Maquina INTEGER,
-- Tipo VARCHAR(50),
-- Velocidade INTEGER,
-- HardDisk INTEGER,
-- Placa_Rede INTEGER,
-- Memoria_Ram INTEGER,
-- Fk_Usuario2 INTEGER) AS $$

CREATE OR REPLACE FUNCTION MAQUINAS_DO_USUARIO(ID_USUARIOP INTEGER) RETURNS SETOF MAQUINA AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM AU9.maquina WHERE fk_usuario = ID_USUARIOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT maquinas_do_usuario(3);

DROP FUNCTION maquinas_do_usuario;

--4) CRIE UMA PROCEDURE ATUALIZAR_RECURSOS_MAQUINA QUE AUMENTA A MEMÓRIA RAM E O ESPAÇO EM DISCO DE UMA MÁQUINA ESPECÍFICA
CREATE OR REPLACE PROCEDURE ATUALIZAR_RECURSOS_MAQUINA(ID_MAQUINAP INTEGER, NOVARAM INTEGER, NOVOHD INTEGER) AS $$
BEGIN

    UPDATE AU9.MAQUINA SET harddisk = NOVOHD, memoria_ram = NOVARAM WHERE id_maquina = id_maquinaP;

    IF NOT FOUND ID_MAQUINA THEN
        RAISE EXCEPTION 'Máquina não encontrada';
    END IF;
END; 
$$ LANGUAGE PLPGSQL;

CALL atualizar_recursos_maquina(1,4,500);


--5) CRIE UMA PROCEDURE CHAMADA TRANSFERIR_SOFTWARE QUE TRANSFERE UM SOFTWARE DE UMA MÁQUINA PARA A OUTRA. ANTES DE TREANSFERIR, A PROCEDURE DEVE VERIFICAR SE A MÁQUINA DE DESTINO TEM ESPAÇO SUFICIENTE PARA O SOFTWARE

CREATE OR REPLACE PROCEDURE TRANSFERIR_SOFTWARE(ID_MAQUINA1 INTEGER, ID_MAQUINA2 INTEGER, ID_SOFTWARE1 INTEGER) AS $$ -- 2 É A MAQUINA DESTINADA
BEGIN
    IF AU9.espaco_disponivel(ID_MAQUINA2, ID_SOFTWARE1)THEN
        UPDATE AU9.software SET fk_maquina = ID_MAQUINA2 WHERE id_software = id_software1 AND fk_maquina = ID_MAQUINA2;
    
        IF NOT FOUND THEN
            RAISE NOTICE 'SOFTWARE NÃO ENCONTRADO NA MÁQUINA DE ORIGEM';
        END IF;
    ELSE
        RAISE NOTICE 'MÁQUINA DE DESTINO NÃO TEM ESPAÇO SUFICIENTE';
    END IF;
END; $$ LANGUAGE PLPGSQL;
     
CALL transferir_software(1,2,1);

-- 6) CRIE UMA FUNÇÃO MEDIA_RECURSOS QUE RETORNA A MÉDIA DE MEMÓRIA RAM E HARD DISK DE TODAS AS MÁQUINAS CADASTRADAS;
CREATE OR REPLACE FUNCTION MEDIA_RECURSOS() RETURNS TABLE("Média HD" NUMERIC, "Média RAM" NUMERIC) AS $$
BEGIN
    RETURN QUERY
        SELECT AVG(HARDDISK) AS "Média HD", AVG(Memoria_Ram) AS "Média RAM"
        FROM AU9.maquina;
END;
$$ LANGUAGE PLPGSQL;

SELECT media_recursos();

DROP Function media_recursos();

-- 7) CRIE UMA PROCEDURE CHAMADA DIAGNÓSTICO_MAQUINA QUE FAZ UMA AVALIAÇÃO COMPLETA DE UMA MÁQUINA E SUGERE UM UPGRADE SE OS RECURSOS DELAS NÃO FOREM SUFICIENTES PARA RODAR OS SOFTWARES INSTALADOS

CREATE OR REPLACE PROCEDURE au9.diagnostico_maquinatESTE(p_id_maquina INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_hard_disk_total INT;
    v_memoria_ram_total INT;
    v_upgrade_sugerido TEXT;
BEGIN
    SELECT COALESCE(SUM(s.HardDisk), 0), COALESCE(SUM(s.Memoria_Ram), 0)
    INTO v_hard_disk_total, v_memoria_ram_total
    FROM au9.Software s
    WHERE s.Fk_Maquina = p_id_maquina;
    
    SELECT CASE 
        WHEN m.HardDisk < v_hard_disk_total THEN 'Aumentar Hard Disk'
        WHEN m.Memoria_Ram < v_memoria_ram_total THEN 'Aumentar Memória RAM'
        ELSE 'Recursos adequados'
    END INTO v_upgrade_sugerido
    FROM au9.Maquina m
    WHERE m.Id_Maquina = p_id_maquina;
    
    RAISE NOTICE 'Diagnóstico da Máquina %: %', p_id_maquina, v_upgrade_sugerido;
END;
$$;

-- PROFESSOR
CREATE OR REPLACE PROCEDURE AU9.DIAGNOSTICO_MAQUINAPROF(ID_MAQUINAP INTEGER) AS $$
DECLARE
    TOTAL_RAM_REQUERIDA INTEGER;
    TOTAL_HD_REQUERIDO INTEGER;
    RAM_ATUAL INTEGER;
    HD_ATUAL INTEGER;
    RAM_UPGRADE INTEGER;
    HD_UPGRADE INTEGER;
BEGIN
    -- OBTER A SOMA DOS REQUISITOS MÍNIMOS DOS SOFTWARES INSTALADOS NA MAQUINA
    SELECT
        COALESCE(SUM(MEMORIA_RAM),0),
        COALESCE(SUM(HARDDISK),0)
    INTO
        TOTAL_RAM_REQUERIDA,
        TOTAL_HD_REQUERIDO
    FROM 
        AU9.software
    WHERE
        fk_maquina = ID_MAQUINAP;
    
    -- OBTER A QUANTIDADE DE RAM E HARDDISK ATUAIS
    SELECT
        MEMORIA_RAM,
        HARDDISK
    INTO
        RAM_ATUAL,
        HD_ATUAL
    FROM
        AU9.maquina
    WHERE ID_MAQUINA = ID_MAQUINAP;

    IF NOT FOUND THEN
        RAISE NOTICE 'MÁQUINA NÃO ENCONTRADA';
    END IF;

    -- VERIFICAR SE A MAQUINA TEM RECURSOS SUFICIENTES
    IF RAM_ATUAL >= TOTAL_RAM_REQUERIDA AND HD_ATUAL >= TOTAL_HD_REQUERIDO THEN
        RAISE NOTICE 'Maquina % tem recursos suficientes', id_maquinaP;
    ELSE
        -- CALCULA A NECESSIDADE DO UPGRADE
        RAM_UPGRADE := GREATEST(0,TOTAL_RAM_REQUIRIDA - RAM_ATUAL); -- ELE RETORNA O MAIOR VALOR
        HD_UPGRADE := GREATEST(0,TOTAL_HD_REQUIRIDA - HD_ATUAL); -- ESSE 0 É PARA NÃO RETORNAR VALORES NEGATIVOS
        RAISE NOTICE 'Máquina % precisa de upgrade', id_maquinaP;
        -- SUGERE UPGRADE DE RAM SE NECESSÁRIO

        if RAM_UPGRADE > 0 THEN
            RAISE NOTICE 'SUGERE UPGRADE DE % GB DE RAM', RAM_UPGRADE;
        END IF;

        if HD_UPGRADE > 0 THEN
            RAISE NOTICE 'SUGERE UPGRADE DE % GB DE RAM', HD_UPGRADE;
        END IF;
    END IF;
END;
$$ LANGUAGE PLPGSQL;

CALL AU9.DIAGNOSTICO_MAQUINAPROF(1);


