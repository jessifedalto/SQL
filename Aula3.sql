SELECT 
	E.Descricao as Evento, -- muda nome da coluna 
	S.Nome,
	S.Capacidade
FROM Evento as E

LEFT JOIN Sala as S  -- junta as duas tabelas
ON E.IDSala = S.IDSala -- junta ambas colunas


SELECT GETDATE() as Data -- retorna a data e horario
SELECT CONVERT(VARCHAR(10), GETDATE(), 103) as Data-- retorna a data convertido para BR
SELECT CONVERT(VARCHAR(5), GETDATE(), 108) as Hora -- retorna da hora em formato xx:xx


SELECT -- juntou duas tabelas separando a data e a hora
	E.IDEvento,
	E.Descricao,
	CONVERT(VARCHAR(10), E.DtHrInicio, 103) as DataInicio,
	CONVERT(VARCHAR(5), E.DtHrInicio, 108) as HoraInicio,
	CONVERT(VARCHAR(10), E.DtHrFim, 103) as DataFim,
	CONVERT(VARCHAR(5), E.DtHrFim, 108) as HoraFim,	
	S.Nome as Sala
FROM Evento as E

LEFT JOIN Sala as S
ON E.IDSala = S.IDSala
WHERE GETDATE() BETWEEN DtHrInicio AND DtHrFim -- conferir se algum evento está acontecendo agora


UPDATE Evento -- mudar algum dado
SET 
	DtHrInicio = '02/02/2024 13:00',
	DtHrFim = '02/02/2024 17:00'
WHERE IDEvento = '09ZPN89RXV5B'


SELECT TOP 3 -- SELECIONA OS 3 PRIMEIROS
	Nome,
	Capacidade
FROM Sala ORDER BY Capacidade DESC -- ordena


SELECT -- selecionou nome do responsavel da sala, descricao do evento, data e nome da sala
	Pessoa.Nome as Responsavel,
	Evento.Descricao as DescriçãoEvento,
	CONVERT(VARCHAR(10), Evento.DtHrInicio, 103) as Data,
	S.Nome
FROM EventoPessoa as E
INNER JOIN Evento
ON E.IDEvento = Evento.IDEvento

INNER JOIN Pessoa
ON E.IDPessoa = Pessoa.IDPessoa

INNER JOIN Sala as S
ON Evento.IDSala = S.IDSala
WHERE E.PapelEvento = 'Responsavel' -- fez aparecer somente os responsaveis


SELECT -- mostra quanto tempo x sala foi usada para x evento em x dia
	S.Nome as Sala,
	E.Descricao as Evento, 
	CONVERT(VARCHAR(10), E.DtHrInicio, 103) as Data,
	DATEDIFF(HOUR, E.DtHrInicio, E.DtHrFim) as 'Tempo De Uso (Horas)' -- diferenca entre duas datas em horas
FROM EVENTO	as E

INNER JOIN Sala as S
ON E.IDSala = S.IDSala

SELECT 
	P.Nome,
	COUNT(EP.IDPessoa) AS 'Ocorrências'
FROM  EventoPessoa EP
RIGHT JOIN Pessoa P
ON P.IDPessoa = EP.IDPessoa
GROUP BY P.Nome 
ORDER BY Ocorrências DESC

-- INNER JOIN ONDE TEM OS FK DE TODAS AS TABELAS RELACIONADAS
-- LEFT JOIN PEGA TODOS OS DADOS DA ESQUERDA E TODOS QUE LIGAM COM ELE
-- RIGHT JOIN PEGA TODOS OS DADOS DA DIREITA E TODOS QUE LIGAM COM ELE
-- FULL JOIN PUXA TUDO DE TODAS AS TABELAS
-- GROUP BY JUNTA EM UMA UNICA CÉLULA TODOS OS DADOS REPETIDOS
