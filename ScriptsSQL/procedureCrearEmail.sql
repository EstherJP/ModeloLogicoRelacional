DELIMITER //

CREATE PROCEDURE `crear_email` (nombre VARCHAR(45), apellido1 VARCHAR(45), apellido2 VARCHAR(45), 
dominio VARCHAR(45), OUT email VARCHAR(45))
BEGIN
    SET email = CONCAT(nombre, apellido1);
    SET email = CONCAT(email, apellido2);
    SET email = CONCAT(email, '@');
	SET email = CONCAT(email, dominio);
END //

DELIMITER ;