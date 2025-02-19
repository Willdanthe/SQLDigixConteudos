-- Criando Tabelas
CREATE TABLE usuario(
	id_usuario serial PRIMARY KEY NOT NULL, -- Serial é igual ao autoincrement
	nome varchar(50) NOT NULL,
	email varchar(50) NOT NULL
);

CREATE TABLE cargo (
	id_cargo int PRIMARY KEY NOT NULL,
	nome varchar(50) NOT NULL,
	fk_usuario int,
	constraint fk_cargo foreign key (fk_usuario)
	references usuario(id_usuario)
	
);

-- Alterar tabela e adicionar coluna salário
ALTER TABLE cargo ADD COLUMN salario decimal(10,2);
ALTER TABLE cargo ALTER COLUMN nome type varchar(100);
ALTER TABLE cargo DROP COLUMN salario;

-- Removendo tabelas
DROP TABLE cargo;

SELECT * from usuario;


-- Inserindo dados na tabela
-- usuario
INSERT INTO usuario(nome,email) VALUES('Godofredo','godo.fredo@gmail.com'); -- 5
INSERT INTO usuario(nome,email) VALUES('Judite','Jud.ite@gmail.com'); -- 6
INSERT INTO usuario(nome,email) VALUES('Roberto','Robe.rto@gmail.com'); -- 7
INSERT INTO usuario(nome,email) VALUES('Clara','clara@gmail.com'); -- 8
INSERT INTO usuario(nome,email) VALUES('Willdanthe','will.danthe@gmail.com'); -- 9

-- cargo
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('1','Analista',1,5000.00); -- o 3 valor do FK_Usuario recebe a PK do usuario para poder referenciar ele
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('3','Programador Aprendiz',2,5000.00);
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('4','Programador Aprendiz',3,5000.00);
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('5','Programador Aprendiz',4,5000.00);

INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('6','Programador Sênior',4,9000.00);

INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('7','Analista',5,5000.00);



SELECT * FROM usuario;

-- Imprimir somente o nome 
SELECT cargo.nome from cargo;
SELECT cargo.id_cargo FROM cargo;


-- Abreviação da tabela
select c.nome from cargo c;
select c.nome, u.nome from cargo c, usuario u;

-- Aplicação de Condições
select c.nome from cargo c where id_cargo =1; -- IMprimi o nome do cargo com o id 1;

select u.id_usuario from usuario u where u.nome = 'Willdanthe'; -- imprime o ID do willdanthe

SELECT * from usuario;
SELECT * from cargo;

select u.nome from usuario u where u.id = 1 or u.id = 2; -- operador 'ou' que imprimi 1 ou 2 ID

select u.nome from usuario u where u.id = 1 and u.id = 2; -- operador 'and' que imprimi 1 e 2 ID

-- selecionar lista de ID 
select u.nome from usuario u where id_usuario in (1,2,3); -- in quer dizer vai selecionar os valores dentro da 'lista'
select u.nome from usuario u where id_usuario not in (1,2,3); -- not quer dizer que não é imprimir os valores da 'lista'
select u.nome from usuario u where id_usuario BETWEEN 1 and 3; -- Imprimindo entre os intervalos de  
select u.nome from usuario u where nome BETWEEN 'Godofredo' and 'Roberto'; -- Imprimindo entre os intervalos de 

-- utilizar Like para pesquisar partes de uma string
SELECT u.id_usuario, u.nome from usuario u where nome like '%e%' -- '%' quer dizer qualquer coisa, ou seja,
-- vai selecionar qualquer coisa que contenha antes, depois ou no meio da letra 'e'.

-- Operadores de comparação
SELECT u.id_usuario, u.nome from usuario u where id_usuario > 2;
SELECT u.id_usuario, u.nome from usuario u where id_usuario >= 2;

SELECT u.id_usuario, u.nome from usuario u where id_usuario > 2 and id_usuario < 4; -- Usando juntamente com operador lógico

-- Opereadores de ordenação 
select u.id_usuario, u.nome from usuario u order by id_usuario desc; -- desc == decrescente por Num

select u.id_usuario, u.nome from usuario u order by id_usuario asc; -- asc == crescente por Num

select u.id_usuario, u.nome from usuario u order by u.nome asc; -- Por string

select u.id_usuario, u.nome from usuario u order by u.nome desc; -- Por string

-- Limitar os resultados
select * from usuario limit 3;

-- Agrupamento
select u.nome, count(c.id_cargo) from usuario u, cargo c  where u.id_usuario = c.fk_usuario GROUP BY c.fk_usuario, u.id_usuario;

