CREATE TABLE IF NOT EXISTS CONCESSIONARIA(
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(255),
    CIDADE VARCHAR(255),
    ESTADO VARCHAR(255)

);

CREATE TTABLE CARRO (
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    MODELO VARCHAR(255),
    -- CODIGOBARRA DEFAULT UUID_GENERATE(),
    ANO INT,
    COR VARCHAR(50),
    CONCESSIONARIA_ID INT,

    CONSTRAINT CONCESSIONARIA_CARRO FOREIGN KEY(CONCESSIONARIA_ID) REFERENCES CONCESSIONARIA(ID) ON DELETE CASCADE
);