-- selecionou os eventos que haviam excedido a capacidade somente com os convidados, porém os presentes não excederam aquele valor
--------------EXTRA USANDO 'IN'---------------------
SELECT
	S.Nome as 'Nomes da sala',
	E.Descricao as 'Evento',
	S.Capacidade as 'Capacidade	da Sala',
	COUNT(EP.IDEventoPessoa) as Presentes

FROM Evento E
LEFT JOIN Sala S ON S.IDSala = E.IDSala 
INNER JOIN EventoPessoa EP ON EP.IDEvento = E.IDEvento
GROUP BY EP.Presenca, E.IDEvento, S.Nome, S.Capacidade, E.Descricao

HAVING EP.Presenca = 1 AND S.Capacidade >= COUNT(EP.IDEventoPessoa) AND E.IDEvento IN (
	SELECT 
		E.IDEvento
	FROM Evento as E

	INNER JOIN Sala as S
	ON S.IDSala = E.IDSala

	INNER JOIN EventoPessoa as EP
	ON  EP.IDEvento = E.IDEvento

	GROUP BY E.IDEvento, S.Capacidade
	HAVING COUNT(EP.IDEventoPessoa) > S.Capacidade)

-----------------EXTRA ---------------------

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
