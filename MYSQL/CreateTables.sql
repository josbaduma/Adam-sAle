SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Escuela`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Escuela` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Escuela` (
  `EscuelaId` SMALLINT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`EscuelaId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Carrera` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Carrera` (
  `CarreraId` INT NOT NULL ,
  `Nombre` VARCHAR(128) NOT NULL ,
  `EscuelaId` SMALLINT NULL ,
  PRIMARY KEY (`CarreraId`) ,
  INDEX `fk_Carrera_1_idx` (`EscuelaId` ASC) ,
  CONSTRAINT `fk_Carrera_1`
    FOREIGN KEY (`EscuelaId` )
    REFERENCES `mydb`.`Escuela` (`EscuelaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Plan` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Plan` (
  `PlanId` INT NOT NULL ,
  `CodigoPlan` VARCHAR(32) NOT NULL ,
  `CarreraId` INT NULL ,
  PRIMARY KEY (`PlanId`) ,
  UNIQUE INDEX `CodigoPlan_UNIQUE` (`CodigoPlan` ASC) ,
  INDEX `fk_Plan_1_idx` (`CarreraId` ASC) ,
  CONSTRAINT `fk_Plan_1`
    FOREIGN KEY (`CarreraId` )
    REFERENCES `mydb`.`Carrera` (`CarreraId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Curso` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Curso` (
  `CursoId` INT NOT NULL ,
  `CodigoCurso` VARCHAR(16) NOT NULL ,
  `NombreCurso` VARCHAR(128) NULL ,
  `EscuelaId` SMALLINT NULL ,
  PRIMARY KEY (`CursoId`) ,
  UNIQUE INDEX `CodigoCurso_UNIQUE` (`CodigoCurso` ASC) ,
  INDEX `fk_Curso_1_idx` (`EscuelaId` ASC) ,
  CONSTRAINT `fk_Curso_1`
    FOREIGN KEY (`EscuelaId` )
    REFERENCES `mydb`.`Escuela` (`EscuelaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CursoEnPlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CursoEnPlan` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`CursoEnPlan` (
  `CursoId` INT NULL ,
  `PlanId` INT NULL ,
  INDEX `fk_CursoEnPlan_1_idx` (`CursoId` ASC) ,
  INDEX `fk_CursoEnPlan_2_idx` (`PlanId` ASC) ,
  CONSTRAINT `fk_CursoEnPlan_1`
    FOREIGN KEY (`CursoId` )
    REFERENCES `mydb`.`Curso` (`CursoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CursoEnPlan_2`
    FOREIGN KEY (`PlanId` )
    REFERENCES `mydb`.`Plan` (`PlanId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Requisitos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Requisitos` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Requisitos` (
  `CursoId` INT NULL ,
  `CursoRequisitoId` INT NULL ,
  `Tipo` TINYINT(1) NULL ,
  `PlanId` INT NULL ,
  INDEX `fk_Requisitos_1_idx` (`CursoId` ASC) ,
  INDEX `fk_Requisitos_2_idx` (`CursoRequisitoId` ASC) ,
  INDEX `fk_Requisitos_3_idx` (`PlanId` ASC) ,
  CONSTRAINT `fk_Requisitos_1`
    FOREIGN KEY (`CursoId` )
    REFERENCES `mydb`.`Curso` (`CursoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Requisitos_2`
    FOREIGN KEY (`CursoRequisitoId` )
    REFERENCES `mydb`.`Curso` (`CursoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Requisitos_3`
    FOREIGN KEY (`PlanId` )
    REFERENCES `mydb`.`Plan` (`PlanId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Persona` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Persona` (
  `PersonaId` INT NOT NULL AUTO_INCREMENT ,
  `Cedula` VARCHAR(45) NOT NULL ,
  `Clave` VARCHAR(16) NOT NULL ,
  PRIMARY KEY (`PersonaId`) ,
  UNIQUE INDEX `Cedula_UNIQUE` (`Cedula` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Rol` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Rol` (
  `RolId` SMALLINT NOT NULL ,
  `Nombre` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`RolId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PersonaEnRol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PersonaEnRol` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`PersonaEnRol` (
  `PersonaId` INT NULL ,
  `RolId` SMALLINT NULL ,
  `Informacion` VARCHAR(128) NULL ,
  INDEX `fk_PersonaEnRol_1_idx` (`PersonaId` ASC) ,
  INDEX `fk_PersonaEnRol_2_idx` (`RolId` ASC) ,
  CONSTRAINT `fk_PersonaEnRol_1`
    FOREIGN KEY (`PersonaId` )
    REFERENCES `mydb`.`Persona` (`PersonaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonaEnRol_2`
    FOREIGN KEY (`RolId` )
    REFERENCES `mydb`.`Rol` (`RolId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Periodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Periodo` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Periodo` (
  `PeriodoId` INT NOT NULL ,
  `Descripcion` VARCHAR(128) NULL ,
  `Cerrado` TINYINT(1) NULL ,
  PRIMARY KEY (`PeriodoId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prematricula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prematricula` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Prematricula` (
  `CursoId` INT NULL ,
  `PeriodoId` INT NULL ,
  `Cantidad` INT NULL ,
  `PrematriculaId` INT NOT NULL ,
  PRIMARY KEY (`PrematriculaId`) ,
  INDEX `fk_Prematricula_1_idx` (`PeriodoId` ASC) ,
  INDEX `fk_Prematricula_2_idx` (`CursoId` ASC) ,
  CONSTRAINT `fk_Prematricula_1`
    FOREIGN KEY (`PeriodoId` )
    REFERENCES `mydb`.`Periodo` (`PeriodoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prematricula_2`
    FOREIGN KEY (`CursoId` )
    REFERENCES `mydb`.`Curso` (`CursoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oferta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Oferta` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Oferta` (
  `OfertaId` INT NOT NULL ,
  `CursoId` INT NULL ,
  `PeriodoId` INT NULL ,
  `Cantidad` VARCHAR(45) NULL ,
  PRIMARY KEY (`OfertaId`) ,
  INDEX `fk_CursoAbiertoPorPeriodo_1_idx` (`CursoId` ASC) ,
  INDEX `fk_CursoAbiertoPorPeriodo_2_idx` (`PeriodoId` ASC) ,
  CONSTRAINT `fk_CursoAbiertoPorPeriodo_1`
    FOREIGN KEY (`CursoId` )
    REFERENCES `mydb`.`Curso` (`CursoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CursoAbiertoPorPeriodo_2`
    FOREIGN KEY (`PeriodoId` )
    REFERENCES `mydb`.`Periodo` (`PeriodoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PreMatriculaEstudiante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PreMatriculaEstudiante` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`PreMatriculaEstudiante` (
  `PrematriculaId` INT NULL ,
  `PersonaId` INT NULL ,
  INDEX `fk_PreMatriculaEstudiante_1_idx` (`PersonaId` ASC) ,
  INDEX `fk_PreMatriculaEstudiante_2_idx` (`PrematriculaId` ASC) ,
  CONSTRAINT `fk_PreMatriculaEstudiante_1`
    FOREIGN KEY (`PersonaId` )
    REFERENCES `mydb`.`Persona` (`PersonaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PreMatriculaEstudiante_2`
    FOREIGN KEY (`PrematriculaId` )
    REFERENCES `mydb`.`Prematricula` (`PrematriculaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estados` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Estados` (
  `EstadoId` TINYINT NOT NULL ,
  `Nombre` VARCHAR(128) NULL ,
  PRIMARY KEY (`EstadoId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Matricula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Matricula` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Matricula` (
  `PersonaId` INT NULL ,
  `OfertaId` INT NULL ,
  `Nota` INT NULL ,
  `EstadoId` TINYINT NULL ,
  INDEX `fk_Matricula_1_idx` (`OfertaId` ASC) ,
  INDEX `fk_Matricula_2_idx` (`PersonaId` ASC) ,
  INDEX `fk_Matricula_3_idx` (`EstadoId` ASC) ,
  CONSTRAINT `fk_Matricula_1`
    FOREIGN KEY (`OfertaId` )
    REFERENCES `mydb`.`Oferta` (`OfertaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matricula_2`
    FOREIGN KEY (`PersonaId` )
    REFERENCES `mydb`.`Persona` (`PersonaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Matricula_3`
    FOREIGN KEY (`EstadoId` )
    REFERENCES `mydb`.`Estados` (`EstadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PersonaEnPlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PersonaEnPlan` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`PersonaEnPlan` (
  `PersonaId` INT NOT NULL ,
  `PlanId` INT NOT NULL ,
  INDEX `fk_PersonaEnPlan_PersonaId_idx` (`PersonaId` ASC) ,
  INDEX `fk_PersonaEnPlan_PlanId_idx` (`PlanId` ASC) ,
  CONSTRAINT `fk_PersonaEnPlan_PersonaId`
    FOREIGN KEY (`PersonaId` )
    REFERENCES `mydb`.`Persona` (`PersonaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonaEnPlan_PlanId`
    FOREIGN KEY (`PlanId` )
    REFERENCES `mydb`.`Plan` (`PlanId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
