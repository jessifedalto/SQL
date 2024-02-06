----------------------------Exercício 5----------------------------------------------- 
--Preciso controlar se as reuniões estão sendo realizadas nas salas com a capacidade correta. Liste as Salas, Eventos, Capacidade das salas e Quantidade de Participantes.
--Crie uma coluna chamada "Avaliação da Capacidade" com dados como: "Ultrapassou o limite", "Limite ok".
--Dica: Use "Case When"-----
SELECT
	Sala.Nome as 'Nomes da sala',
	Sala.Capacidade,
	Evento.Descricao,
	COUNT(EventoPessoa.IDPessoa) as 'Pessoas',
	CASE
		WHEN Capacidade <= COUNT(EventoPessoa.IDPessoa) THEN 'Ultrapassou o limite'
		ELSE 'OK'
	END
FROM Evento
INNER JOIN EventoPessoa ON EventoPessoa.IDEvento = Evento.IDEvento
INNER JOIN Sala on Evento.IDSala = Sala.IDSala
GROUP BY EventoPessoa.IDEvento, Evento.Descricao, Sala.Nome, Sala.Capacidade, Evento.IDEvento
ORDER BY Evento.Descricao
