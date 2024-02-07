CREATE VIEW VWNOME as
SELECT
	S.Nome, 
	E.Descricao,
	S.Capacidade,
	COUNT(EP.PapelEvento) AS 'Participantes',
	SUM(CASE WHEN EP.Presenca = 1 THEN 1 ELSE 0 END) AS 'Presentes'
FROM Evento E
INNER JOIN Sala S
ON S.IDSala = E.IDSala
INNER JOIN EventoPessoa EP
ON E.IDEvento = EP.IDEvento
GROUP BY S.Nome, E.Descricao, S.Capacidade, E.IDEvento
HAVING S.Capacidade < COUNT(EP.IDPessoa) AND S.Capacidade >= SUM(CASE WHEN EP.Presenca = 1 THEN 1 ELSE 0 END)

--Para usar a VIEW
SELECT * FROM vwnome
