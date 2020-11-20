CREATE DEFINER = CURRENT_USER TRIGGER `EmpresaViveros`.`trigger_crear_email_before_insert` BEFORE INSERT ON `CLIENTES_FIDELIZADOS` FOR EACH ROW
BEGIN
	IF NEW.email IS NULL THEN 
		CALL crear_email(NEW.Nombre, NEW.Apellido1, NEW.Apellido2, 'gmail.com', @emailOut);
        SET NEW.email = @emailOut;
    END IF;
END