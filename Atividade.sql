--------------------- Exercicio 3 --------------------------
CREATE DATABASE Mundo
GO
USE Mundo

CREATE TABLE PAÍS(
	Pais VARCHAR(35) PRIMARY KEY,
	Continente VARCHAR(35),
	Populacao FLOAT,
	PIB FLOAT,
	Expect_Vida FLOAT
)

CREATE TABLE CIDADE(
	Cidade VARCHAR(35) PRIMARY KEY,
	Pais VARCHAR(35) FOREIGN KEY REFERENCES PAÍS(Pais),
	Populacao FLOAT,
	Capital Bit
)

CREATE TABLE RIO(
	Rio VARCHAR(35) PRIMARY KEY,
	Nascente VARCHAR(35) FOREIGN KEY REFERENCES PAÍS(Pais),
	Pais VARCHAR(35) FOREIGN KEY REFERENCES PAÍS(Pais),
	Comprimento FLOAT
)

INSERT INTO PAÍS(Pais, Continente, Populacao, PIB, Expect_Vida) VALUES
('Canada', 'America do Norte', 38.25, 1.9, 82),
('Mexico', 'America do Norte', 126.7, 1.65, 75),
('Brasil', 'America do Sul', 214.3, 1.608, 75.5),
('USA', 'America do Norte', 331.9, 21.43, 76.1),
('China', 'Asia', 1444.2, 14.34, 83),
('Alemanha', 'Europa', 83.2, 4.1, 78.1)

INSERT INTO CIDADE(Cidade, Pais, Populacao, Capital) VALUES
('Washington', 'USA', 3.3, 1),
('Monterrey', 'Mexico', 2.0, 0),
('Brasilia', 'Brasil', 1.5, 1),
('São Paulo', 'Brasil', 15.0,0),
('Ottawa', 'Canada', 0.8, 1),
('Cid. Mexico', 'Mexico', 14.1, 1),
('Pequim', 'China', 21.5, 1)

INSERT INTO RIO(Rio, Nascente, Pais, Comprimento) VALUES
('St. Lawrence', 'USA', 'USA', 3.3),
('Grande', 'USA', 'Mexico', 2.0),
('Parana', 'Brasil', 'Brasil',1.5),
('Mississipi', 'USA', 'USA', 15.0)


--------------------- Exercicio 4 --------------------------
SELECT 
	P.Continente AS 'Continente',
	AVG(P.PIB) AS 'PIB Médio'
FROM PAÍS AS P
GROUP BY Continente


--------------------- Exercicio 5 --------------------------
SELECT TOP 1 
	P.Continente as 'Continente'
FROM RIO AS R
INNER JOIN PAÍS AS P
ON R.Pais = P.Pais
ORDER BY R.Comprimento DESC


--------------------- Exercicio 6 --------------------------
CREATE TRIGGER tgDelete
ON PAÍS
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Pais AS VARCHAR(35)
	SET @Pais = (SELECT Pais FROM DELETED)

	DELETE FROM CIDADE WHERE Pais = @Pais
	DELETE FROM RIO WHERE Pais = @Pais
	DELETE FROM PAÍS WHERE Pais = @Pais
END

DELETE FROM PAÍS WHERE Pais = 'China'


--------------------- Exercicio 7 --------------------------
CREATE FUNCTION fnSearchPais(@Busca VARCHAR(35))
RETURNS TABLE AS 
RETURN 
(
SELECT 
	P.Pais AS 'País',
	P.Continente AS 'Continente',
	P.Populacao AS 'População',
	P.PIB AS 'PIB',
	P.Expect_Vida AS 'Expectativa de vida'

FROM PAÍS AS P
WHERE P.Pais LIKE @Busca + '%'
)
SELECT * FROM fnSearchPais('U')


--------------------- Exercicio 8 --------------------------
ALTER TABLE PAÍS ADD PIB_per_capita FLOAT
UPDATE PAÍS SET PIB_per_capita = PAÍS.PIB/PAÍS.Populacao


--------------------- Exercicio 9 --------------------------
DECLARE @Media FLOAT
SET @Media = (
SELECT
	AVG(C.Populacao)
FROM CIDADE AS C)
SELECT @Media

SELECT 
	C.Cidade,
	C.Pais,
	C.Populacao,
	@Media AS 'Média',
	CASE 
		WHEN (C.Populacao > @Media) THEN 'Acima da média'
		ELSE 'Abaixo ou igual à média'
	END AS 'Situação População'

FROM PAÍS AS P
INNER JOIN CIDADE AS C
ON P.Pais = C.Pais
GROUP BY C.Cidade, C.Pais, C.Populacao
