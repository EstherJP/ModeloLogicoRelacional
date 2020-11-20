-- MySQL Script generated by MySQL Workbench
-- Mon Nov 16 23:06:40 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Catastro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Catastro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Catastro` DEFAULT CHARACTER SET utf8 ;
USE `Catastro` ;

-- -----------------------------------------------------
-- Table `Catastro`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`ZONA` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Área` VARCHAR(45) NULL,
  `Código postal` INT NULL,
  `Concejal` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`CALLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`CALLE` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Número` INT NULL,
  `Tipo` VARCHAR(45) NULL,
  `ZONA_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_CALLE_ZONA1_idx` (`ZONA_Nombre` ASC),
  CONSTRAINT `fk_CALLE_ZONA1`
    FOREIGN KEY (`ZONA_Nombre`)
    REFERENCES `Catastro`.`ZONA` (`Nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`CONSTRUCCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`CONSTRUCCION` (
  `Coordendas geograficas` INT NOT NULL,
  `idConstruccion` INT NOT NULL,
  `Direccion` VARCHAR(45) NULL,
  `NumeroPisos` INT NULL,
  `NumeroPersonas` INT NULL,
  `CALLE_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idConstruccion`, `CALLE_Nombre`),
  INDEX `fk_CONSTRUCCION_CALLE1_idx` (`CALLE_Nombre` ASC) ,
  CONSTRAINT `fk_CONSTRUCCION_CALLE1`
    FOREIGN KEY (`CALLE_Nombre`)
    REFERENCES `Catastro`.`CALLE` (`Nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`BLOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`BLOQUE` (
  `Aforo` INT NULL,
  `MetrosCuadradosPiso` INT NULL,
  `CONSTRUCCION_idConstruccion` INT NOT NULL,
  `CONSTRUCCION_CALLE_Nombre` VARCHAR(45) NOT NULL,
  INDEX `fk_BLOQUE_CONSTRUCCION1_idx` (`CONSTRUCCION_idConstruccion` ASC, `CONSTRUCCION_CALLE_Nombre` ASC) ,
  PRIMARY KEY (`CONSTRUCCION_CALLE_Nombre`, `CONSTRUCCION_idConstruccion`),
  CONSTRAINT `fk_BLOQUE_CONSTRUCCION1`
    FOREIGN KEY (`CONSTRUCCION_idConstruccion` , `CONSTRUCCION_CALLE_Nombre`)
    REFERENCES `Catastro`.`CONSTRUCCION` (`idConstruccion` , `CALLE_Nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`PISO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`PISO` (
  `Letra` INT NOT NULL,
  `Planta` INT NOT NULL,
  `BLOQUE_CONSTRUCCION_idConstruccion` VARCHAR(45) NOT NULL,
  `BLOQUE_CONSTRUCCION_CALLE_Nombre` VARCHAR(45) NOT NULL,
  `BLOQUE_CONSTRUCCION_idConstruccion1` INT NOT NULL,
  `PERSONA_DNI` INT NOT NULL,
  PRIMARY KEY (`Letra`, `BLOQUE_CONSTRUCCION_idConstruccion`, `Planta`),
  UNIQUE INDEX `Planta_UNIQUE` (`Planta` ASC) ,
  INDEX `fk_PISO_BLOQUE1_idx` (`BLOQUE_CONSTRUCCION_CALLE_Nombre` ASC, `BLOQUE_CONSTRUCCION_idConstruccion1` ASC) ,
  INDEX `fk_PISO_PERSONA1_idx` (`PERSONA_DNI` ASC) ,
  CONSTRAINT `fk_PISO_BLOQUE1`
    FOREIGN KEY (`BLOQUE_CONSTRUCCION_CALLE_Nombre` , `BLOQUE_CONSTRUCCION_idConstruccion1`)
    REFERENCES `Catastro`.`BLOQUE` (`CONSTRUCCION_CALLE_Nombre` , `CONSTRUCCION_idConstruccion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PISO_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `Catastro`.`PERSONA` (`DNI`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`PERSONA` (
  `DNI` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `PERSONA_DNI` INT NOT NULL,
  `unifamiliar` VARCHAR(45) NULL,
  `PISO_Letra` INT NULL,
  `PISO_BLOQUE_CONSTRUCCION_idConstruccion` VARCHAR(45) NULL,
  `PISO_Planta` INT NULL,
  `UNIFAMILIAR_CONSTRUCCION_idConstruccion` INT NULL,
  `UNIFAMILIAR_CONSTRUCCION_CALLE_Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_PERSONA_PERSONA1_idx` (`PERSONA_DNI` ASC) ,
  INDEX `fk_PERSONA_PISO1_idx` (`PISO_Letra` ASC, `PISO_BLOQUE_CONSTRUCCION_idConstruccion` ASC, `PISO_Planta` ASC) ,
  INDEX `fk_PERSONA_UNIFAMILIAR1_idx` (`UNIFAMILIAR_CONSTRUCCION_idConstruccion` ASC, `UNIFAMILIAR_CONSTRUCCION_CALLE_Nombre` ASC) ,
  CONSTRAINT `fk_PERSONA_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `Catastro`.`PERSONA` (`DNI`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PERSONA_PISO1`
    FOREIGN KEY (`PISO_Letra` , `PISO_BLOQUE_CONSTRUCCION_idConstruccion` , `PISO_Planta`)
    REFERENCES `Catastro`.`PISO` (`Letra` , `BLOQUE_CONSTRUCCION_idConstruccion` , `Planta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PERSONA_UNIFAMILIAR1`
    FOREIGN KEY (`UNIFAMILIAR_CONSTRUCCION_idConstruccion` , `UNIFAMILIAR_CONSTRUCCION_CALLE_Nombre`)
    REFERENCES `Catastro`.`UNIFAMILIAR` (`CONSTRUCCION_idConstruccion` , `CONSTRUCCION_CALLE_Nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Catastro`.`UNIFAMILIAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Catastro`.`UNIFAMILIAR` (
  `NumeroPisos` INT NOT NULL,
  `CONSTRUCCION_idConstruccion` INT NOT NULL,
  `CONSTRUCCION_CALLE_Nombre` VARCHAR(45) NOT NULL,
  `PERSONA_DNI` INT NOT NULL,
  PRIMARY KEY (`CONSTRUCCION_idConstruccion`, `CONSTRUCCION_CALLE_Nombre`),
  INDEX `fk_UNIFAMILIAR_CONSTRUCCION1_idx` (`CONSTRUCCION_idConstruccion` ASC, `CONSTRUCCION_CALLE_Nombre` ASC) ,
  INDEX `fk_UNIFAMILIAR_PERSONA1_idx` (`PERSONA_DNI` ASC) ,
  CONSTRAINT `fk_UNIFAMILIAR_CONSTRUCCION1`
    FOREIGN KEY (`CONSTRUCCION_idConstruccion` , `CONSTRUCCION_CALLE_Nombre`)
    REFERENCES `Catastro`.`CONSTRUCCION` (`idConstruccion` , `CALLE_Nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_UNIFAMILIAR_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `Catastro`.`PERSONA` (`DNI`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;