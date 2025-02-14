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

