create table if not exists au8.Empregado (
Nome varchar(50),
Endereco varchar(500),
CPF int primary key not null,
DataNasc date,
Sexo char(10),
CartTrab int,
Salario float,
NumDep int,
CPFSup int
);

create table if not exists au8.Departamento (
NomeDep varchar(50),
NumDep int primary key not null,
CPFGer int,
DataInicioGer date
-- foreign key (CPFGer) references au8.Empregado(CPF)
);
ALTER TABLE AU8.empregado ADD foreign key (NumDep) references au8.Departamento(NumDep)
ALTER TABLE AU8.departamento ADD foreign key (CPFGer) references au8.Empregado(CPF)

create table if not exists au8.Projeto (
NomeProj varchar(50),
NumProj int primary key not null,
Localizacao varchar(50),
NumDep int,
foreign key (NumDep) references au8.Departamento(NumDep)
);

create table if not exists au8.Dependente (
idDependente int primary key not null,
CPFE int,
NomeDep varchar(50),
Sexo char(10),
Parentesco varchar(50),
foreign key (CPFE) references au8.Empregado(CPF)
);

create table if not exists au8.Trabalha_Em (
CPF int,
NumProj int,
HorasSemana int,
foreign key (CPF) references au8.Empregado(CPF),
foreign key (NumProj) references au8.Projeto(NumProj)
);

-- Inserir os dados
insert into au8.Departamento values ('Dep1', 1, null, '1990-01-01');
insert into au8.Departamento values ('Dep2', 2, null, '1990-01-01');
insert into au8.Departamento values ('Dep3', 3, null, '1990-01-01');
insert into au8.Empregado values ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, null);
insert into au8.Empregado values ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, null);
insert into au8.Empregado values ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, null);
update au8.Departamento set CPFGer = 123 where NumDep = 1;
update au8.Departamento set CPFGer = 456 where NumDep = 2;
update au8.Departamento set CPFGer = 789 where NumDep = 3;
insert into au8.Projeto values ('Proj1', 1, 'Local1', 1);
insert into au8.Projeto values ('Proj2', 2, 'Local2', 2);
insert into au8.Projeto values ('Proj3', 3, 'Local3', 3);
insert into au8.Dependente values (1, 123, 'Dep1', 'M', 'Filho');
insert into au8.Dependente values (2, 456, 'Dep2', 'F', 'Filha');
insert into au8.Dependente values (3, 789, 'Dep3', 'M', 'Filho');
insert into au8.Trabalha_Em values (123, 1, 40);
insert into au8.Trabalha_Em values (456, 2, 40);
insert into au8.Trabalha_Em values (789, 3, 40);

-- 1) Função que retorna o salário de um empregado dado o CPF
CREATE OR REPLACE FUNCTION AU8.SALARIO_EMPREGADO(CPF_PARAMETRO INTEGER) RETURNS FLOAT AS $$
DECLARE
    V_SALARIO FLOAT;
BEGIN 
    SELECT E.salario AS "Salário" INTO V_SALARIO FROM AU8.EMPREGADO E WHERE CPF_PARAMETRO = CPF;
    RETURN V_SALARIO;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.salario_empregado(123);

-- 2) Função que retorna o nome do departamento de um empregado dado o CPF
CREATE OR REPLACE FUNCTION AU8.EMPREGADO_DEPARTAMENTO(CPF_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEDEP VARCHAR(50);
BEGIN
    SELECT D.NOMEDEP AS "Nome do Departamento" into V_NOMEDEP FROM AU8.empregado E
    JOIN AU8.departamento D ON D.numdep = E.NUMDEP
    WHERE CPF_PARAMETRO = E.CPF;
    RETURN V_NOMEDEP;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.empregado_departamento(456);

-- 3) Função que retorna o nome do gerente de um departamento dado o NumDep
CREATE OR REPLACE FUNCTION AU8.GERENTE_DEPARTAMENTO(NUMDEP_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEGER VARCHAR(50);
BEGIN
    SELECT E.NOME AS "Nome do Gerente" into V_NOMEGER FROM AU8.departamento D
    JOIN AU8.empregado E ON D.numdep = E.NUMDEP
    WHERE NUMDEP_PARAMETRO = D.numdep;
    RETURN V_NOMEGER;
END;
$$ LANGUAGE PLPGSQL;

SELECT AU8.gerente_departamento(3);

-- 4) Função que retorna o nome do projeto de um empregado dado o CPF
CREATE OR REPLACE FUNCTION AU8.EMPREGADO_PROJETO(CPF_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEPROJ VARCHAR(50);
BEGIN
    SELECT P.nomeproj AS "Nome Projeto" into V_NOMEPROJ FROM AU8.projeto P
    JOIN AU8.EMPREGADO E ON E.numdep = P.NUMDEP
    WHERE CPF_PARAMETRO = E.CPF;
    RETURN V_NOMEPROJ;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM AU8.empregado_projeto(789);
-- 5) Função que retorna o nome do dependente de um empregado dado o CPF
CREATE OR REPLACE FUNCTION AU8.EMPREGADO_DEPENDENTE(CPF_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEDEPEN VARCHAR(50);
BEGIN
    SELECT D.nomeDEP AS "Nome Dependente" into V_NOMEDEPEN FROM AU8.dependente D
    JOIN AU8.EMPREGADO E ON E.CPF = D.CPFE
    WHERE CPF_PARAMETRO = E.CPF;
    RETURN V_NOMEDEPEN;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM AU8.empregado_dependente(789);
-- 6) Função que retorna o nome do gerente de um empregado dado o CPF
CREATE OR REPLACE FUNCTION AU8.EMPREGADO_GERENTE(CPF_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEDEPEN VARCHAR(50);
BEGIN
    SELECT E1.nome AS "Nome Gerente" into V_NOMEDEPEN FROM AU8.empregado E1 
    JOIN AU8.EMPREGADO E ON E.CPF = D.CPFE
    WHERE CPF_PARAMETRO = E.CPF;
    RETURN V_NOMEDEPEN;
END;
$$ LANGUAGE PLPGSQL;

-- 7) Função que retorna a quantidade de horas que um empregado trabalha em um projeto dado o CPF
CREATE OR REPLACE FUNCTION AU8.EMPREGADO_PROJETO(CPF_PARAMETRO INTEGER) RETURNS VARCHAR(50) AS $$
DECLARE
    V_NOMEPROJ VARCHAR(50);
BEGIN
    SELECT P.nomeproj AS "Nome Projeto" into V_NOMEPROJ FROM AU8.projeto P
    JOIN AU8.EMPREGADO E ON E.numdep = P.NUMDEP
    WHERE CPF_PARAMETRO = E.CPF;
    RETURN V_NOMEPROJ;
END;
$$ LANGUAGE PLPGSQL;
-- 8) Função com Exception que retorna o salário de um empregado dado o CPF

CREATE OR REPLACE FUNCTION AU8.SALARIOEMPREGADO(P_CPF INTEGER) RETURNS FLOAT AS $$
DECLARE
    V_SALARIO FLOAT;
BEGIN
    BEGIN
        SELECT SALARIO INTO V_SALARIO FROM AU8.EMPREGADO WHERE CPF = P_CPF;

        -- IF SALARIO IS NULL THEN
        --     RAISE EXCEPTION 'CPF não encontrado';
        -- END IF;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Erro ao buscar o salário';
    END;
    RETURN V_SALARIO;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM au8.salarioempregado(666);

create or replace function au8.SalarioEmpregado2(p_CPF integer) returns float as $$
declare 
    salarioV float;
begin
    begin
        select Salario into salarioV from au8.Empregado where CPF = p_CPF;

        -- If salario is null then
        --     raise exception 'CPF não encontrado';
        -- end if;
    EXCEPTION
     when others then
        raise notice 'Erro ao buscar salario';
    
    end;
    return salarioV;
end;
$$ language plpgsql;

SELECT * FROM au8.salarioempregado(123);
