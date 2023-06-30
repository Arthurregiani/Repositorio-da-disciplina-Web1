create database tasks;

use tasks;
-- drop table tarefas;
-- drop table usuarios;

CREATE TABLE usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  login VARCHAR(255),
  senha VARCHAR(255),
  nome VARCHAR(255),
  email VARCHAR(255)
);

-- Criação da tabela "tarefas"
CREATE TABLE tarefas (
  id INT PRIMARY KEY auto_increment,
  titulo VARCHAR(255),
  descricao TEXT,
  data_criacao DATE,
  data_conclusao DATE,
  status VARCHAR(255),
  usuario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

select * from usuarios;

select * from tarefas;