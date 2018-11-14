USE lojinha;

/* CRIANDO PROCEDURES */

DELIMITER //


/* Busca o id do estado através do nome */
CREATE PROCEDURE getEstadoId(IN nome VARCHAR(50))
BEGIN
	SELECT estado_id FROM estados WHERE estado_nome = nome LIMIT 1;
END //


/* Cria um novo usuário na tabela clientes */
CREATE PROCEDURE CriarCliente(
	IN nome VARCHAR(50),
    IN sobrenome VARCHAR(50),
    IN email VARCHAR(50),
    IN sexo CHAR(1),
    IN premium BOOLEAN,
    IN estado VARCHAR(50)
)
BEGIN
	INSERT INTO clientes(cliente_nome, sobrenome, email, sexo, premium, estado_id)
    VALUES(
		nome, sobrenome, email, sexo, premium,
        (SELECT estado_id FROM estados WHERE estado_nome = estado LIMIT 1)
    );
END //


DELIMITER ;





/* TESTANDO PROCEDURES */
CALL getEstadoId('Maranhão');

CALL CriarCliente(
	'Cleberson',
    'Junior',
    'cleberson.dev@gmail.com',
    'M',
    TRUE,
    'Maranhão'
);