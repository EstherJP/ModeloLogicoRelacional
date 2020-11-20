CREATE DEFINER=`esther`@`localhost` TRIGGER `EmpresaViveros`.`trigger_actualizar_stock_after_insert` AFTER INSERT ON `PEDIDO_has_PRODUCTO` FOR EACH ROW
BEGIN
	IF EXISTS(SELECT 1 FROM PRODUCTO WHERE PRODUCTO.CodigoBarras = NEW.PRODUCTO_CodigoBarras) THEN
		SET @updateStock = (SELECT Stock FROM PRODUCTO WHERE PRODUCTO.CodigoBarras = NEW.PRODUCTO_CodigoBarras) - NEW.Cantidad;
		IF @updateStock < 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insuficiente stock para realizar el pedido';
        ELSE 
			UPDATE PRODUCTO SET Stock = @updateStock WHERE PRODUCTO.CodigoBarras = NEW.PRODUCTO_CodigoBarras;
        END IF;
	ELSE
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe el producto solicitado'; 
    END IF;
END