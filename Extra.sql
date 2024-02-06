--------------EXTRA---------------------
SELECT
	S.Nome as 'Nomes da sala',
	E.Descricao as 'Evento',
	S.Capacidade as CapacidadeSala,
	COUNT(EP.IDEventoPessoa) as Presentes
FROM Evento E
LEFT JOIN Sala S ON E.IDSala = E.IDSala 
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

SELECT -- selecionou os eventos que haviam excedido a capacidade somente com os convidados, porém os presentes não excederam aquele valor
	S.Nome as Sala,
	E.Descricao as Evento,
	S.Capacidade as CapacidadeSala,
	COUNT(EP.IDEventoPessoa) as Presentes

FROM Evento as E

INNER JOIN Sala as S
ON S.IDSala = E.IDSala

INNER JOIN EventoPessoa as EP
ON  EP.IDEvento = E.IDEvento

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
