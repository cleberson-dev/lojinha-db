/* Queries Básicas */

USE lojinha;
SET sql_mode = '';

SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM estados;
SELECT * FROM vendas;


/* Informar os clientes do sexo Feminino */
SELECT * FROM clientes WHERE sexo='F';

/* Informar a quantidade de clientes do sexo feminino */
SELECT COUNT(*) AS "Mulheres"
FROM clientes 
WHERE sexo='F';

/* Informar os clientes do sexo masculino */
SELECT * FROM clientes WHERE sexo='F';

/* Informar a quantidade de clientes do sexo masculino */
SELECT COUNT(*) AS "Homens"
FROM clientes 
WHERE sexo='M';

/* Informar a quantidade total de clientes */
SELECT COUNT(*) AS 'Total de clientes' FROM clientes;

/* Informar a média de preço dos produtos */
SELECT AVG(preco) as 'Média de Preço' FROM produtos;

/* Informe a média de preço dos videogames */
SELECT AVG(preco) AS 'Média de Preço dos Videogames' 
FROM produtos 
WHERE categoria = 'Videogame';

/* Quais seriam os estados que começariam com A? */
SELECT estado_nome 
FROM estados 
WHERE estado_nome LIKE 'A%';

/* Quais seriam os estados que pertencem às regiões Norte e Nordeste? */
SELECT estado_nome 
FROM estados 
WHERE regiao IN ('Norte', 'Nordeste');

/* Informar os estados e suas respectivas capitais, ordenados de forma crescente */
SELECT estado_nome AS Estado, capital 
FROM estados 
ORDER BY estado_nome ASC;





/* UM POUCO MAIS AVANÇADO */


/* Informar o registro de vendas, com o nome e sobrenomes dos compradores, juntamente com o id do produto */
SELECT clientes.cliente_nome, clientes.sobrenome, vendas.produto_id 
FROM vendas 
LEFT JOIN clientes 
	ON vendas.cliente_id = clientes.cliente_id;


/* Informar o lucro total na venda dos produtos */
SELECT SUM(produtos.preco) as 'Lucro Total'
FROM vendas LEFT JOIN produtos 
	ON vendas.produto_id = produtos.produto_id;


/* Informe o gasto de cada cliente que comprou algo */
SELECT 	clientes.cliente_id, 
        clientes.cliente_nome as 'Nome do comprador', 
        SUM(produtos.preco) AS 'Total gasto (em R$)'
FROM vendas
LEFT JOIN produtos
	ON vendas.produto_id = produtos.produto_id
LEFT JOIN clientes
	ON vendas.cliente_id = clientes.cliente_id
GROUP BY clientes.cliente_id
ORDER BY vendas.venda_id ASC;


/* Mostre a quantidade de cada um dos produtos vendidos */
SELECT produtos.produto_nome, COUNT(*) as 'Quantidades' 
FROM vendas RIGHT JOIN produtos 
	ON vendas.produto_id = produtos.produto_id 
GROUP BY produtos.produto_id 
ORDER BY COUNT(*) DESC;


/* Informe o produto mais vendido */
SELECT produtos.produto_nome as 'Produto mais vendido', COUNT(*) as 'Quantidade' 
FROM vendas 
RIGHT JOIN produtos 
	ON vendas.produto_id = produtos.produto_id 
GROUP BY produtos.produto_id 
ORDER BY COUNT(*) DESC
LIMIT 1;


/* Mostre o estado de cada cliente */
SELECT clientes.cliente_id, clientes.cliente_nome, estados.estado_nome
FROM clientes 
LEFT JOIN estados
	ON clientes.estado_id = estados.estado_id;


/* Mostre o estado de cada venda */
SELECT vendas.venda_id, estados.estado_nome FROM vendas 
LEFT JOIN clientes 
	ON vendas.cliente_id = clientes.cliente_id 
LEFT JOIN estados
	ON clientes.estado_id = estados.estado_id;

    
/* Mostre a região de cada venda */
SELECT vendas.venda_id, estados.regiao FROM vendas
LEFT JOIN clientes
	ON vendas.cliente_id = clientes.cliente_id
LEFT JOIN estados
	ON clientes.estado_id = estados.estado_id;

    
/* Mostre a quantidade de vendas de cada região */
SELECT estados.regiao AS 'Região', 
COUNT(*) AS 'Quantidades Vendidas'
FROM vendas
LEFT JOIN clientes
	ON vendas.cliente_id = clientes.cliente_id
LEFT JOIN estados
	ON clientes.estado_id = estados.estado_id
GROUP BY estados.regiao;

