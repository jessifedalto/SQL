--DESAFIO
--Crie uma função cujo o retorno deverá ser um único select e retornar uma tabela com:

--1- Quantidade de pessoas presentes no primeiro evento (mais antigo) que ocorreu.

--2- Nome da sala em que esse evento ocorreu.

--3- A Função será chamada com um parâmetro de busca. Como Aula, Palestra ou Reunião.

--Nome Evento, Nome Sala, Qtd Pessoas, Data Início, Hora Início.

ALTER FUNCTION fEventoAntigo(@Descricao VARCHAR(10))
RETURNS TABLE AS
RETURN(
	SELECT TOP 1 
		E.Descricao,
		S.Nome,
		COUNT(CASE WHEN EP.Presenca = 1 THEN 1 END) AS 'Contagem de Presenca',
		CONVERT(VARCHAR(10), E.DtHrInicio, 103) AS 'Data Formatada',
		CONVERT(VARCHAR(5), E.DtHrInicio, 108) AS 'Hora de Início'
		
	FROM Evento E
	INNER JOIN EventoPessoa as EP 
	ON E.IDEvento = EP.IDEvento
	INNER JOIN Sala as S
	ON S.IDSala = E.IDSala
	WHERE E.Descricao LIKE '%' + @Descricao + '%'
	GROUP BY 
		E.IDEvento, E.Descricao, E.DtHrInicio, S.Nome
	
	ORDER BY E.DtHrInicio ASC
)



SELECT * FROM fEventoAntigo('Aula')
