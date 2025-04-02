CREATE TABLE operadoras (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(2),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    email VARCHAR(100),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    data_registro_ans DATE
);

CREATE TABLE demonstracoes (
    id SERIAL PRIMARY KEY,
    registro_ans VARCHAR(20),
    data DATE,
    conta VARCHAR(100),
    descricao TEXT,
    valor DECIMAL(15,2),
    FOREIGN KEY (registro_ans) REFERENCES operadoras(registro_ans)
);

COPY operadoras FROM './' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

SELECT o.razao_social, SUM(d.valor) as total_despesas
FROM demonstracoes d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
AND d.data >= DATE_TRUNC('quarter', CURRENT_DATE)::DATE
GROUP BY o.razao_social
ORDER BY total_despesas DESC
LIMIT 10;

SELECT o.razao_social, SUM(d.valor) as total_despesas
FROM demonstracoes d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
AND d.data >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY o.razao_social
ORDER BY total_despesas DESC
LIMIT 10;