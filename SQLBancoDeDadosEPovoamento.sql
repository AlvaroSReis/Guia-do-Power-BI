CREATE SCHEMA escolams;


-- Tabela de conta do usuario

CREATE TABLE escolams.conta(
  usuario VARCHAR(15),
  senha VARCHAR(15),
  CONSTRAINT co_pk PRIMARY KEY (usuario),
  CONSTRAINT co_un UNIQUE (usuario)
);

-- Tabela de usuario

CREATE TABLE escolams.usuario(
  cpf BIGINT,
  usuario VARCHAR(15),
  primeiro_nome VARCHAR(200),
  sobrenome VARCHAR(200),
  data_de_nascimento DATE,
  telefone INT,
  email VARCHAR(255),
  CONSTRAINT us_pk PRIMARY KEY (cpf),
  CONSTRAINT us_fk FOREIGN KEY (usuario) REFERENCES escolams.conta(usuario)
  );
  
  
-- Tabela de aluno, especialização de usuario.
  
CREATE TABLE escolams.aluno(
    matricula BIGINT,
    responsavel_1 VARCHAR(100),
    responsavel_2 VARCHAR(100),
    serie INT NOT NULL,
    cpf BIGINT,
    CONSTRAINT al_pk PRIMARY KEY (matricula),
    CONSTRAINT al_fk FOREIGN KEY (cpf) REFERENCES escolams.usuario(cpf)
  );

-- Tabela de professor, especialização de usuario

CREATE TABLE escolams.professor(
  matricula BIGINT,
  salario INT,
  cpf BIGINT,
   CONSTRAINT pf_pk PRIMARY KEY (matricula),
   CONSTRAINT pf_fk FOREIGN KEY (cpf) REFERENCES escolams.usuario(cpf)
  );
  
-- Tabela de disciplinas
  
CREATE TABLE escolams.disciplina(
  ID INT,
  nome VARCHAR(25),
  ano INT,
  descricao VARCHAR(255),
  CONSTRAINT di_pk PRIMARY KEY (ID)
  );

-- Tabela de ano com semestres

CREATE TABLE escolams.ano(
  ID INT,
  ano VARCHAR(4),
  data_inicio DATE,
  data_termino DATE,
  semestres INT,
  CONSTRAINT an_pk PRIMARY KEY (ID)
  );
  
-- Tabela de turmas

CREATE TABLE escolams.turma(
   ID INT,
   registro VARCHAR(2),
   ano_id INT,
   CONSTRAINT tr_pk PRIMARY KEY (ID),
   CONSTRAINT tr_fk FOREIGN KEY (ano_id) REFERENCES escolams.ano(ID)
   );
  
-- Tabela de cronograma

CREATE TABLE escolams.cronograma(
  ID INT,
  datas DATE,
  descricao VARCHAR(255),
  ano_id INT,
  CONSTRAINT cr_pk PRIMARY KEY (ID),
  CONSTRAINT cr_fk FOREIGN KEY (ano_id) REFERENCES escolams.ano(ID)
  );
  
-- Tabela de eventos.

CREATE TABLE escolams.eventos(
  ID INT,
  data_inicio DATE,
  data_termino DATE,
  descricao VARCHAR(255),
  cronograma INT,
  CONSTRAINT ev_pk PRIMARY KEY (ID),
  CONSTRAINT ev_fk FOREIGN KEY (cronograma) REFERENCES escolams.cronograma(ID)
  );

-- Tabela de ensino
CREATE TABLE escolams.leciona(
  ID INT,
  professor BIGINT,
  disciplina INT,
  turma INT,
  CONSTRAINT le_pk PRIMARY KEY (ID),
  CONSTRAINT le_fk1 FOREIGN KEY (professor) REFERENCES escolams.professor(matricula),
  CONSTRAINT le_fk2 FOREIGN KEY (disciplina) REFERENCES escolams.disciplina(ID),
  CONSTRAINT le_fk3 FOREIGN KEY (turma) REFERENCES escolams.turma(ID)
  );
  
-- Presença do aluno na turma  
  
CREATE TABLE escolams.presenca(
  ID INT,
  aluno_matricula BIGINT,
  turma INT,
  CONSTRAINT pr_fk1 FOREIGN KEY (aluno_matricula) REFERENCES escolams.aluno(matricula),
  CONSTRAINT pr_fk2 FOREIGN KEY (turma) REFERENCES escolams.turma(ID),
  CONSTRAINT pr_pk PRIMARY KEY (ID)
  );

-- Notas de um aluno em uma turma para determinada disciplina;

CREATE TABLE escolams.notas(
  ID int,
  id_aluno_turma INT,
  disciplina INT,
  nota FLOAT,
  detalhes VARCHAR(255),
  CONSTRAINT no_fk FOREIGN KEY (id_aluno_turma) REFERENCES escolams.presenca(ID),
  CONSTRAINT no_fk2 FOREIGN KEY (disciplina) REFERENCES escolams.disciplina(ID),
  CONSTRAINT no_pk PRIMARY KEY (ID)
  );





------------------------------------------------ Povoamento --------------------------------------------------------

-- Povoamento tabela conta

INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno1', 'senhaa1');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno2', 'senhaa2');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno3', 'senhaa3');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno4', 'senhaa4');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno5', 'senhaa5');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno6', 'senhaa6');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno7', 'senhaa7');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno8', 'senhaa8');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno9', 'senhaa9');
INSERT INTO escolams.conta(usuario, senha) VALUES ('aluno10', 'senhaa10');
INSERT INTO escolams.conta(usuario, senha) VALUES ('professor1','senhap1');
INSERT INTO escolams.conta(usuario, senha) VALUES ('professor2','senhap2');
INSERT INTO escolams.conta(usuario, senha) VALUES ('professor3','senhap3');
INSERT INTO escolams.conta(usuario, senha) VALUES ('professor4','senhap4');
INSERT INTO escolams.conta(usuario, senha) VALUES ('professor5','senhap5');


-- Povoamento tabela usuario

INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111101,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno1'), 'aluno1', 'sobrenome a1', '03-05-1999', 999909991, 'aluno1@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111102,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno2'), 'aluno2', 'sobrenome a2', '03-05-1995', 999909992, 'aluno2@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111103,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno3'), 'aluno3', 'sobrenome a3', '05-03-1996', 999909993, 'aluno3@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111104,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno4'), 'aluno4', 'sobrenome a4', '07-03-1997', 999909994, 'aluno4@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111105,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno5'), 'aluno5', 'sobrenome a5', '11-04-1998', 999909995, 'aluno5@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111106,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno6'), 'aluno6', 'sobrenome a6', '10-08-1995', 999909996, 'aluno6@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111107,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno7'), 'aluno7', 'sobrenome a7', '07-02-1997', 999909997, 'aluno7@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111108,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno8'), 'aluno8', 'sobrenome a8', '02-01-1995', 999909998, 'aluno8@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111109,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno9'), 'aluno7', 'sobrenome a7', '07-02-1997', 999909997, 'aluno7@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (11111111110,  (SELECT usuario FROM escolams.conta WHERE usuario = 'aluno10'), 'aluno8', 'sobrenome a8', '02-01-1995', 999909998, 'aluno8@email.com');


INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (21111111111, (SELECT usuario FROM escolams.conta WHERE usuario = 'professor1'), 'professor1', 'sobrenome p1', '05-03-1972', 999901997, 'professor1@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (21111111121, (SELECT usuario FROM escolams.conta WHERE usuario = 'professor2'), 'professor2', 'sobrenome p2', '03-05-1982', 999902997, 'professor2@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (21111111131, (SELECT usuario FROM escolams.conta WHERE usuario = 'professor3'), 'professor3', 'sobrenome p3', '10-03-1993', 999903997, 'professor3@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (21111111141, (SELECT usuario FROM escolams.conta WHERE usuario = 'professor4'), 'professor4', 'sobrenome p4', '07-05-1984', 999904997, 'professor4@email.com');
INSERT INTO escolams.usuario(cpf, usuario, primeiro_nome, sobrenome, data_de_nascimento, telefone,email) VALUES (21111111151, (SELECT usuario FROM escolams.conta WHERE usuario = 'professor5'), 'professor5', 'sobrenome p5', '12-06-1985', 999905997, 'professor5@email.com');


-- Povoamento, tabela aluno

INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2001, 'pai 1', 'mãe 1', 1, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111101));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2002, 'pai 2', 'mãe 2', 4, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111102));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2003, 'pai 3', 'mãe 3', 3, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111103));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2004, 'pai 4', 'mãe 4', 5, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111104));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2005, 'pai 5', 'mãe 5', 4, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111105));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2006, 'pai 6', 'mãe 6', 2, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111106));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2007, 'pai 7', 'mãe 7', 5, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111107));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2008, 'pai 8', 'mãe 8', 5, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111108));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2009, 'pai 9', 'mãe 9', 5, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111109));
INSERT INTO escolams.aluno(matricula, responsavel_1,responsavel_2, serie, cpf) VALUES (2010, 'pai 10', 'mãe 10', 5, (SELECT cpf FROM escolams.usuario WHERE cpf = 11111111110));
                                                                                                                   
-- Povoamento tabela professor      
INSERT INTO escolams.professor(matricula, salario, cpf) VALUES (1001, 5000, (SELECT cpf FROM escolams.usuario WHERE cpf = 21111111111));
INSERT INTO escolams.professor(matricula, salario, cpf) VALUES (1002, 8000, (SELECT cpf FROM escolams.usuario WHERE cpf = 21111111121));
INSERT INTO escolams.professor(matricula, salario, cpf) VALUES (1003, 5000, (SELECT cpf FROM escolams.usuario WHERE cpf = 21111111131));
INSERT INTO escolams.professor(matricula, salario, cpf) VALUES (1004, 7000, (SELECT cpf FROM escolams.usuario WHERE cpf = 21111111141));
INSERT INTO escolams.professor(matricula, salario, cpf) VALUES (1005, 10000, (SELECT cpf FROM escolams.usuario WHERE cpf = 21111111151));


-- Povoamento tabela disciplina

INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (501, 'português', 5, 'portugues do 5º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (502, 'matemática', 5, 'matemática do 5º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (503, 'história', 5, 'história do 5º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (504, 'ciências', 5, 'ciências do 5º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (401, 'português', 4, 'portugues do 4º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (402, 'matemática', 4, 'matemática do 4º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (403, 'história', 4, 'história do 4º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (404, 'ciências', 4, 'ciências do 4º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (301, 'português', 3, 'portugues do 3º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (302, 'matemática', 3, 'matemática do 3º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (303, 'história', 3, 'história do 3º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (304, 'ciências', 3, 'ciências do 3º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (201, 'português', 2, 'portugues do 2º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (202, 'matemática', 2, 'matemática do 2º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (203, 'história', 2, 'história do 2º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (204, 'ciências', 2, 'ciências do 2º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (101, 'português', 1, 'portugues do 1º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (102, 'matemática', 1, 'matemática do 1º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (103, 'história', 1, 'história do 1º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (104, 'ciências', 1, 'ciências do 1º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (105, 'geografia', 1, 'geografia do 1º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (205, 'geografia', 2, 'geografia do 2º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (305, 'geografia', 3, 'geografia do 3º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (405, 'geografia', 4, 'geografia do 4º ano');
INSERT INTO escolams.disciplina(ID, nome, ano, descricao) VALUES (505, 'geografia', 5, 'geografia do 5º ano');


-- Povoamento tabela ano

INSERT INTO escolams.ano(ID, ano, data_inicio, data_termino, semestres) VALUES (1, '2019', '14-01-2019', '12-12-2019', 2);

-- Povoamento tabela turma

INSERT INTO escolams.turma(ID, registro, ano_id) VALUES (1, '1A', (SELECT ID FROM escolams.ano WHERE id = 1));
INSERT INTO escolams.turma(ID, registro, ano_id) VALUES (2, '2A', (SELECT ID FROM escolams.ano WHERE id = 1));
INSERT INTO escolams.turma(ID, registro, ano_id) VALUES (3, '3A', (SELECT ID FROM escolams.ano WHERE id = 1));
INSERT INTO escolams.turma(ID, registro, ano_id) VALUES (4, '3B', (SELECT ID FROM escolams.ano WHERE id = 1));
INSERT INTO escolams.turma(ID, registro, ano_id) VALUES (5, '4A', (SELECT ID FROM escolams.ano WHERE id = 1));


-- Povoamento tabela cronograma

INSERT INTO escolams.cronograma(ID, datas, descricao, ano_id) VALUES (1, '14-01-2019', 'inicio do periodo', (SELECT ID FROM escolams.ano WHERE ID = 1));
INSERT INTO escolams.cronograma(ID, datas, descricao, ano_id) VALUES (2, '12-12-2019' ,'fim do periodo', (SELECT ID FROM escolams.ano WHERE ID = 1));

-- Povoamento tabela eventos

INSERT INTO escolams.eventos(ID, data_inicio, data_termino, descricao, cronograma) VALUES (1, '15-01-2019', '15-01-2019', 'falta de energia', (SELECT ID FROM escolams.cronograma WHERE ID = 1));
INSERT INTO escolams.eventos(ID, data_inicio, data_termino, descricao, cronograma) VALUES (2, '17-03-2019', '03-04-2019', 'carnaval', (SELECT ID FROM escolams.cronograma WHERE ID = 1));

-- Povoamento tabela leciona


INSERT INTO escolams.leciona(ID, professor, disciplina, turma) VALUES(1, (SELECT matricula FROM escolams.professor WHERE matricula = 1001), (SELECT ID FROM escolams.disciplina WHERE ID = 101), (SELECT ID FROM escolams.turma WHERE ID = 1));
INSERT INTO escolams.leciona(ID, professor, disciplina, turma) VALUES(2, (SELECT matricula FROM escolams.professor WHERE matricula = 1002), (SELECT ID FROM escolams.disciplina WHERE ID = 102), (SELECT ID FROM escolams.turma WHERE ID = 2));
INSERT INTO escolams.leciona(ID, professor, disciplina, turma) VALUES(3, (SELECT matricula FROM escolams.professor WHERE matricula = 1003), (SELECT ID FROM escolams.disciplina WHERE ID = 103), (SELECT ID FROM escolams.turma WHERE ID = 3));
INSERT INTO escolams.leciona(ID, professor, disciplina, turma) VALUES(4, (SELECT matricula FROM escolams.professor WHERE matricula = 1004), (SELECT ID FROM escolams.disciplina WHERE ID = 104), (SELECT ID FROM escolams.turma WHERE ID = 4));
INSERT INTO escolams.leciona(ID, professor, disciplina, turma) VALUES(5, (SELECT matricula FROM escolams.professor WHERE matricula = 1005), (SELECT ID FROM escolams.disciplina WHERE ID = 105), (SELECT ID FROM escolams.turma WHERE ID = 5));


-- Povoamento de presenca

INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (1,(SELECT matricula FROM escolams.aluno WHERE matricula = 2001),(SELECT ID FROM escolams.turma WHERE ID = 1));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (2,(SELECT matricula FROM escolams.aluno WHERE matricula = 2002),(SELECT ID FROM escolams.turma WHERE ID = 2));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (3,(SELECT matricula FROM escolams.aluno WHERE matricula = 2003),(SELECT ID FROM escolams.turma WHERE ID = 1));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (4,(SELECT matricula FROM escolams.aluno WHERE matricula = 2004),(SELECT ID FROM escolams.turma WHERE ID = 4));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (5,(SELECT matricula FROM escolams.aluno WHERE matricula = 2005),(SELECT ID FROM escolams.turma WHERE ID = 5));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (6,(SELECT matricula FROM escolams.aluno WHERE matricula = 2006),(SELECT ID FROM escolams.turma WHERE ID = 4));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (7,(SELECT matricula FROM escolams.aluno WHERE matricula = 2007),(SELECT ID FROM escolams.turma WHERE ID = 2));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (8,(SELECT matricula FROM escolams.aluno WHERE matricula = 2008),(SELECT ID FROM escolams.turma WHERE ID = 3));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (9,(SELECT matricula FROM escolams.aluno WHERE matricula = 2009),(SELECT ID FROM escolams.turma WHERE ID = 3));
INSERT INTO escolams.presenca(ID, aluno_matricula, turma) VALUES (10,(SELECT matricula FROM escolams.aluno WHERE matricula = 2010),(SELECT ID FROM escolams.turma WHERE ID = 5));


-- Povoamento de notas

INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (1, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '9.27', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (2, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '9.59', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (3, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '3.74', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (4, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '5.04', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (5, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '4.56', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (6, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '3.71', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (7, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '7.52', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (8, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '5.29', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (9, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '4.14', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (10, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '5.65', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (11, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '8.43', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (12, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '8.6', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (13, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '8.27', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (14, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '6.33', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (15, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '6.92', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (16, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '6.93', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (17, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '9.36', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (18, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '6.1', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (19, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '5.93', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (20, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '9.83', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (21, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '5.98', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (22, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '4.25', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (23, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '8.02', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (24, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '4.77', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (25, (SELECT ID FROM escolams.presenca WHERE ID = 1), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '7.0', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (26, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '6.43', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (27, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '3.77', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (28, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '5.47', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (29, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '6.46', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (30, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '7.0', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (31, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '7.19', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (32, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '6.1', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (33, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '5.56', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (34, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '7.09', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (35, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '3.92', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (36, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '4.58', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (37, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '9.92', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (38, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '7.96', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (39, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '6.52', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (40, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '6.89', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (41, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '9.22', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (42, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '4.74', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (43, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '8.16', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (44, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '4.9', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (45, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '7.13', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (46, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '5.95', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (47, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '5.67', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (48, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '4.51', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (49, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '9.61', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (50, (SELECT ID FROM escolams.presenca WHERE ID = 2), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '4.44', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (51, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '4.11', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (52, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '4.68', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (53, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '6.33', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (54, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '7.92', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (55, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '8.29', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (56, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '4.92', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (57, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '4.22', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (58, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '6.35', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (59, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '5.26', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (60, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '9.29', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (61, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '7.21', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (62, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '7.67', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (63, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '7.66', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (64, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '6.89', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (65, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '9.53', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (66, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '7.19', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (67, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '4.96', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (68, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '6.31', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (69, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '5.01', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (70, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '4.84', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (71, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '4.8', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (72, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '5.43', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (73, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '5.56', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (74, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '7.21', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (75, (SELECT ID FROM escolams.presenca WHERE ID = 3), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '8.43', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (76, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '6.7', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (77, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '4.41', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (78, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '7.09', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (79, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '7.3', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (80, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '8.38', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (81, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '8.69', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (82, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '5.6', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (83, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '4.91', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (84, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '5.7', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (85, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '5.03', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (86, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '9.29', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (87, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '8.37', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (88, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '4.64', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (89, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '9.43', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (90, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '5.84', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (91, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '4.73', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (92, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '6.82', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (93, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '4.59', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (94, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '6.22', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (95, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '3.82', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (96, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '8.9', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (97, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '3.89', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (98, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '6.47', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (99, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '8.26', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (100, (SELECT ID FROM escolams.presenca WHERE ID = 4), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '9.78', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (101, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '5.99', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (102, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '9.42', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (103, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '8.08', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (104, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '8.7', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (105, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '7.26', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (106, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '4.11', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (107, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '8.87', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (108, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '6.02', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (109, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '9.28', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (110, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '5.02', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (111, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '7.25', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (112, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '7.56', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (113, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '6.68', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (114, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '6.74', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (115, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '6.57', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (116, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '7.65', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (117, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '5.7', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (118, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '8.13', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (119, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '3.51', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (120, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '8.45', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (121, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '3.64', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (122, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '3.96', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (123, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '6.88', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (124, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '5.67', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (125, (SELECT ID FROM escolams.presenca WHERE ID = 5), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '4.3', '1º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (126, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '3.52', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (127, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '7.62', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (128, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '5.84', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (129, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '8.28', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (130, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '6.65', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (131, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '7.26', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (132, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '8.79', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (133, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '7.82', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (134, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '8.81', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (135, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '5.76', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (136, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '6.81', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (137, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '4.46', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (138, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '6.56', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (139, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '9.36', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (140, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '5.44', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (141, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '5.81', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (142, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '7.31', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (143, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '9.21', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (144, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '6.88', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (145, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '4.31', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (146, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '9.45', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (147, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '5.89', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (148, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '4.05', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (149, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '8.76', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (150, (SELECT ID FROM escolams.presenca WHERE ID = 6), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '8.68', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (151, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '6.82', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (152, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '7.91', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (153, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '3.9', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (154, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '5.91', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (155, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '5.42', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (156, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '4.91', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (157, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '8.58', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (158, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '4.69', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (159, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '4.82', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (160, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '4.5', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (161, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '9.76', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (162, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '8.03', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (163, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '4.07', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (164, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '5.71', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (165, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '4.66', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (166, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '4.49', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (167, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '4.95', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (168, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '9.83', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (169, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '4.79', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (170, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '6.98', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (171, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '7.36', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (172, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '8.38', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (173, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '5.71', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (174, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '6.51', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (175, (SELECT ID FROM escolams.presenca WHERE ID = 7), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '4.76', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (176, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '8.54', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (177, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '3.96', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (178, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '9.66', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (179, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '4.12', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (180, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '6.18', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (181, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '7.52', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (182, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '7.61', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (183, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '6.4', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (184, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '6.13', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (185, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '8.83', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (186, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '7.73', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (187, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '8.62', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (188, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '6.02', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (189, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '9.97', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (190, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '8.24', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (191, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '6.3', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (192, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '8.61', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (193, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '5.04', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (194, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '8.84', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (195, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '5.89', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (196, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '4.11', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (197, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '9.86', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (198, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '5.37', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (199, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '8.74', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (200, (SELECT ID FROM escolams.presenca WHERE ID = 8), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '6.71', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (201, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '4.34', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (202, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '6.07', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (203, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '9.68', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (204, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '4.94', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (205, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '9.96', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (206, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '6.68', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (207, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '6.16', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (208, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '9.15', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (209, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '8.2', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (210, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '4.11', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (211, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '9.08', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (212, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '3.99', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (213, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '5.96', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (214, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '5.42', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (215, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '4.3', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (216, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '6.03', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (217, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '7.84', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (218, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '9.0', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (219, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '9.99', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (220, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '9.65', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (221, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '5.2', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (222, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '4.19', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (223, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '4.99', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (224, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '8.53', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (225, (SELECT ID FROM escolams.presenca WHERE ID = 9), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '9.19', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (226, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 101), '8.89', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (227, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 102), '5.62', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (228, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 103), '5.22', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (229, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 104), '9.12', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (230, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 105), '3.96', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (231, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 201), '8.16', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (232, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 202), '8.39', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (233, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 203), '7.98', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (234, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 204), '6.17', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (235, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 205), '8.6', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (236, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 301), '3.63', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (237, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 302), '6.19', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (238, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 303), '8.39', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (239, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 304), '9.79', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (240, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 305), '6.4', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (241, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 401), '6.34', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (242, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 402), '9.44', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (243, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 403), '8.24', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (244, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 404), '9.0', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (245, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 405), '6.98', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (246, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 501), '9.79', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (247, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 502), '4.38', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (248, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 503), '9.73', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (249, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 504), '5.98', '2º unidade');
INSERT INTO escolams.notas(id, id_aluno_turma, disciplina, nota, detalhes) VALUES (250, (SELECT ID FROM escolams.presenca WHERE ID = 10), (SELECT ID FROM escolams.disciplina WHERE ID = 505), '9.53', '2º unidade');

