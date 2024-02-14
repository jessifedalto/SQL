select * from EventoPessoa
Where IDEventoPessoa = '01GDEQ75T14A'

BEGIN TRANSACTION
delete from EventoPessoa WHERE IDEventoPessoa = '01GDEQ75T14A'

COMMIT --salva, depois do commit não tem mais rollback
ROLLBACK -- como se fosse um control z

--Declaração de variáveis---
DECLARE 
	@Variavel INT,
	@Nome Varchar(255),
	@Idade INT

SET @Variavel = 20
set @Variavel = (Select Capacidade from Sala Where IDSala = '')
Select @Variavel = Capacidade from sala where IDSala = ''
SELECT @Variavel

Trigger --Procedimento realizado automaticamente sempre que ocorre um evento especial no banco de dados
-- Operações que isso ocorre:
-- Inserção, Exclusão e Atualizar
-- Três momento que a Trigger pode ser usada:
 For -- o gatilho é disparado junto da ação
 After -- o disparo é realizado após a ação ser concluída
 Instead of -- seja executado no lugar da ação que o gerou

-- Vantagens: impedir transações inválidas(integridade, segurança); Registro de eventos que ocorreram; Integridade referencial.

CREATE TRIGGER [Nome_Trigger]
ON [Nome_tabela] -- é a tabela à qual o trigger se aplica
AFTER DELETE 
AS
BEGIN
	--é possível declarar variáveis
	-- Inserir, excluir ou alterar dados em outras tabelas.
END

ALTER TRIGGER fnDelete
ON PESSOA
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM EventoPessoa WHERE IDPessoa = (SELECT IDPessoa FROM DELETED)
	DELETE FROM Pessoa WHERE IDPessoa = (SELECT IDPessoa FROM DELETED)
END

DELETE FROM Pessoa WHERE IDPessoa = '031MA0H5D14A'

select * from Pessoa


--Criando tabela que será populada pela trigger
CREATE TABLE Log(
Data DATETIME, 
Operacao VARCHAR(50), 
Observacao VARCHAR(255) --nome 
PRIMARY KEY (Data, Operacao)) -- Os dois juntos são a Primary Key


ALTER TRIGGER fnInsert
ON PESSOA
FOR INSERT
AS
BEGIN
	INSERT INTO Log(Data, Operacao, Observacao) values
	(
	GETDATE(),
	'Inserção',
	'Inserindo Pessoa ' + (SELECT Nome FROM inserted)
	)
END

INSERT INTO Pessoa values('1234555666', 'Jéssica', 'Estudante')

SELECT * FROM LOG

TRUNCATE TABLE LOG --apaga os dados da tabela
