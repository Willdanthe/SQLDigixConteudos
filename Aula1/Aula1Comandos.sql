-- Criando Tabelas
CREATE TABLE usuario(
	id_usuario serial PRIMARY KEY NOT NULL, -- Serial é igual ao autoincrement
	nome varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
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



-- Inserindo dados na tabela
-- usuario
INSERT INTO usuario(nome,email) VALUES('Godofredo','godo.fredo@gmail.com'); -- 5
INSERT INTO usuario(nome,email) VALUES('Judite','Jud.ite@gmail.com'); -- 6
INSERT INTO usuario(nome,email) VALUES('Roberto','Robe.rto@gmail.com'); -- 7
INSERT INTO usuario(nome,email) VALUES('Clara','clara@gmail.com'); -- 8
INSERT INTO usuario(nome,email) VALUES('Willdanthe','will.danthe@gmail.com'); -- 9

-- cargo
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('1','Analista',5,5000.00); -- o 3 valor do FK_Usuario recebe a PK do usuario para poder referenciar ele
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('3','Programador Aprendiz',9,5000.00);
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('4','Programador Aprendiz',8,5000.00);
INSERT INTO cargo(id_cargo,nome,fk_usuario,salario) VALUES ('5','Programador Aprendiz',7,5000.00);



-- Alterar os dados
UPDATE cargo SET salario = 6500.00 WHERE id_cargo = 2;
UPDATE cargo SET fk_usuario = 6 WHERE id_cargo = 2;

-- Excluir dados
DELETE FROM usuario WHERE id_usuario = 5; -- OBS: só pode ser excluido se não tiver referência nele, pois caso tenha, teria que deletar primeiro as referencias dele para depois deletar ele, como é o caso do 5 que está sendo referenciado 2x na tabela cargo


-- Consultas
-- Total:
SELECT * FROM usuario;
SELECT * FROM cargo;

-- Interseção entre as tabelas (Os iguais)
-- Left Join retorna todos os usuários e seus cargos, ou seja, os registrso da tabela esquerda (usuario) e os registros da tabela da direita(cargo). Meu entendimento: Ele pesquisa a coluna da esquerda, e relaciona o carg
SELECT * FROM usuario LEFT JOIN cargo on usuario.id_usuario = cargo.fk_usuario;

SELECT * FROM usuario RIGHT JOIN cargo on usuario.id_usuario = cargo.fk_usuario;

-- Inner Join
SELECT * FROM usuario INNER JOIN cargo on usuario.id_usuario = cargo.fk_usuario;

