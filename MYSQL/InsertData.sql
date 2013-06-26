SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Escuela`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Escuela` (
  `EscuelaId` SMALLINT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`EscuelaId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrera`
-- -----------------------------------------------------
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
CREATE  TABLE IF NOT EXISTS `mydb`.`Rol` (
  `RolId` SMALLINT NOT NULL ,
  `Nombre` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`RolId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PersonaEnRol`
-- -----------------------------------------------------
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
CREATE  TABLE IF NOT EXISTS `mydb`.`Periodo` (
  `PeriodoId` INT NOT NULL ,
  `Descripcion` VARCHAR(128) NULL ,
  `Cerrado` TINYINT(1) NULL ,
  PRIMARY KEY (`PeriodoId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prematricula`
-- -----------------------------------------------------
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
CREATE  TABLE IF NOT EXISTS `mydb`.`Estados` (
  `EstadoId` TINYINT NOT NULL ,
  `Nombre` VARCHAR(128) NULL ,
  PRIMARY KEY (`EstadoId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Matricula`
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Data for table `mydb`.`Escuela`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (1, 'Escuela de Administración de Empresas');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (2, 'Escuela de Biología');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (3, 'Escuela de Ciencia e Ingeniería de los Materiales');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (4, 'Escuela de Ciencias del Lenguaje');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (5, 'Escuela de Ciencias Sociales');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (6, 'Escuela de Cultura y Deporte');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (7, 'Escuela de Educación Técnica');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (8, 'Escuela de Física');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (9, 'Escuela de Ingeniería Agrícola');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (10, 'Escuela de Ingeniería Agropecuaria Administrativa');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (11, 'Escuela de Ingeniería Electromecánica');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (12, 'Escuela de Ingeniería Electrónica');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (13, 'Escuela de Ingeniería en Computación');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (14, 'Escuela de Ingeniería en Construcción');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (15, 'Escuela de Ingeniería en Diseño Industrial');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (16, 'Escuela de Ingeniería en Producción Industrial');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (17, 'Escuela de Ingeniería en Seguridad Laboral e Higiene Ambiental');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (18, 'Escuela de Ingeniería Forestal');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (19, 'Escuela de Matemática');
INSERT INTO `mydb`.`Escuela` (`EscuelaId`, `Nombre`) VALUES (20, 'Escuela de Química');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Carrera`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (1, 'Administración de Empresas', 1);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (2, 'Administración de Tecnologías de Información', 13);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (3, 'Educación Técnica', 7);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (4, 'Enseñanza de la Matemática asistida por computadora', 19);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (5, 'Gestión de Turismo Sostenible', 5);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (6, 'Ingeniería Agrícola', 9);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (7, 'Ingeniería Agronegocios', 10);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (8, 'Ingeniería Ambiental', 20);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (9, 'Ingeniería en Biotecnología', 2);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (10, 'Ingeniería en Computación', 13);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (11, 'Ingeniería en Computadores', 12);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (12, 'Ingeniería en Construcción', 14);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (13, 'Ingeniería en Diseño Industrial', 15);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (14, 'Ingeniería en Electrónica', 12);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (15, 'Ingeniería en Mantenimiento Industrial', 11);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (16, 'Ingeniería en Materiales', 3);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (17, 'Ingeniería en Producción Industrial', 16);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (18, 'Ingeniería en Seguridad Laboral e Higiene Ambiental', 17);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (19, 'Ingeniería Forestal', 18);
INSERT INTO `mydb`.`Carrera` (`CarreraId`, `Nombre`, `EscuelaId`) VALUES (20, 'Ingeniería Mecatrónica', 11);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Plan` (`PlanId`, `CodigoPlan`, `CarreraId`) VALUES (1, '2100', 11);
INSERT INTO `mydb`.`Plan` (`PlanId`, `CodigoPlan`, `CarreraId`) VALUES (2, '808', 14);
INSERT INTO `mydb`.`Plan` (`PlanId`, `CodigoPlan`, `CarreraId`) VALUES (3, '1411', 18);
INSERT INTO `mydb`.`Plan` (`PlanId`, `CodigoPlan`, `CarreraId`) VALUES (4, '231', 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Curso`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (1, 'CI0205', 'Prueba Avanzada Ingles', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (2, 'MA0101', 'Matematica General', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (3, 'CE1101', 'Introduccion a la Programacion', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (4, 'CE1102', 'Taller de Programacion', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (5, 'CS1502', 'Intr. Tec. Ciencia y Tecnologia', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (6, 'MA1102', 'Calculo Diferencial e Integral', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (7, 'MA1403', 'Matematica Discreta', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (8, 'QU1102', 'Laboratorio de Quimica Basica I', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (9, 'QU1106', 'Quimica Basica I', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (10, 'SE1100', 'Actividad Cultural I', 6);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (11, 'SE1200', 'Actividad Deportiva I', 6);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (12, 'CE1103', 'Algoritmos y Estructuras de Datos I', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (13, 'CI1403', 'Comunicación Técnica', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (14, 'FH1000', 'Centros de Formación Humanística', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (15, 'FI1101', 'Física General I', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (16, 'FI1201', 'Laboratorio de Física General I', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (17, 'MA1103', 'Cálculo y Álgebra Lineal', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (18, 'QU1104', 'Laboratorio de Química Básica II', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (19, 'QU1107', 'Química Básica II', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (20, 'SE1400', 'Actividad Cultural-Deportiva', 6);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (21, 'CE2103', 'Algoritmos y Estructuras de Datos II', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (22, 'CS2101', 'Ambiente Humano', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (23, 'EL2113', 'Circuitos Eléctricos en Corriente Continua', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (24, 'FI1102', 'Física General II', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (25, 'FI1202', 'Laboratorio de Física General II', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (26, 'MA2104', 'Cálculo Superior', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (27, 'CE2201', 'Laboratorio de Circuitos Eléctricos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (28, 'EL2114', 'Circuitos Eléctricos en Corriente Alterna', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (29, 'EL2207', 'Elementos Activos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (30, 'FI2103', 'Física General III', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (31, 'MA2105', 'Ecuaciones Diferenciales', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (32, 'CE3104', 'Lenguajes, Compiladores e Interpretes', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (33, 'CI3201', 'Inglés Especializado para Electrónica y Computación', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (34, 'EL2206', 'Laboratorio de Elementos Activos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (35, 'EL3212', 'Circuitos Discretos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (36, 'EL3307', 'Diseño Lógico', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (37, 'FI2104', 'Física General IV', 8);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (38, 'CE3101', 'Bases de Datos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (39, 'CE3102', 'Análisis Numéricos para Ingeniería', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (40, 'CE3201', 'Taller de Diseño Digital', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (41, 'EL3213', 'Circuitos Integrados Lineales', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (42, 'EL3310', 'Diseño de Sistemas Digitales', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (43, 'CE4101', 'Especificación y Diseño de Software', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (44, 'CE4202', 'Taller de Diseño Analógico', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (45, 'CE4301', 'Arquitectura de Computadores I', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (46, 'EL4701', 'Modelos de Sistemas', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (47, 'EL4702', 'Probabilidad y Estadística', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (48, 'AE4208', 'Desarrollo de Emprendedores', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (49, 'CE4302', 'Arquitectura de Computadores II', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (50, 'CE4303', 'Principios de Sistemas Operativos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (51, 'CE4501', 'Electiva CE 1', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (52, 'CS3401', 'Seminario de Estudios Filosóficos Históricos', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (53, 'CE5301', 'Redes de Computadores', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (54, 'CE5302', 'Proyecto de Diseño de Ingeniería en Computadores', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (55, 'CE5401', 'Formulación y Administración de Proyectos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (56, 'CE5501', 'Electiva CE 2', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (57, 'CE5502', 'Electiva CE 3', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (58, 'CE5600', 'Trabajo Final de Graduación', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (59, 'CS4402', 'Seminario de Estudios Costarricenses', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (60, 'CI0200', 'Examen Diagnóstico', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (61, 'CI0202', 'Inglés Básico', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (62, 'CI1106', 'Comunicación Escrita', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (63, 'CI1230', 'Inglés I', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (64, 'MI2102', 'Dibujo Técnico', 11);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (65, 'CA2125', 'Elementos de Computación', 13);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (66, 'CI1107', 'Comunicación Oral', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (67, 'CI1231', 'Inglés II', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (68, 'CA3125', 'Análisis y Diseño de Algoritmos', 13);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (69, 'EL2107', 'Laboratorio Circuitos Eléctricos en Corriente Continua', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (70, 'CS2303', 'Relaciones Laborales', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (71, 'EL2108', 'Laboratorio Circuitos Eléctricos en Corriente Alterna', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (72, 'CS3404', 'Seminario de Ética en la ingeniería', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (73, 'EL3205', 'Laboratorio de Circuitos Discretos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (74, 'EL3308', 'Laboratorio de Diseño Lógico', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (75, 'CM3207', 'Métodos numéricos para Ingeniería', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (76, 'EL3111', 'Transformadores y Máquinas Eléctricas', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (77, 'EL3214', 'Laboratorio de Circuitos Integrados Lineales', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (78, 'EL3312', 'Laboratorio de Diseño de sistemas Digitales', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (79, 'EL4311', 'Estructura de Microprocesadores', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (80, 'EL4313', 'Laboratorio Estructura de Microprocesadores', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (81, 'EL4513', 'Teoría Electromagnética', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (82, 'EL4409', 'Análisis de Sistemas Lineales', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (83, 'EL4514', 'Teoría Electromagnética II', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (84, 'EL4515', 'Laboratorio de teoría Electromagnética II', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (86, 'PI5516', 'Ingeniería Económica', 16);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (87, 'SO4604', 'Seguridad y Salud Ocupacional', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (88, 'EL5408', 'Control Automático', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (89, 'CS5300', 'Desarrollo Tecnológico y Sostenibilidad', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (90, 'EL5409', 'Laboratorio de Control Automático', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (91, 'EL5511', 'Comunicaciones Eléctricas', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (92, 'EL5512', 'Laboratorio de Comunicaciones Eléctricas', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (93, 'EL5609', 'Formulación de Proyectos', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (94, 'EL5801', 'Electiva', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (95, 'EL5616', 'Proyecto de Graduación', 12);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (96, 'PI2407', 'Aplicaciones Computacionales', 16);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (97, 'SO1407', 'Introcucción a las Condiciones de Trabajo y Salud', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (98, 'QU2402', 'Lab. Fundamentos Química Orgánica', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (99, 'QU2407', 'Fundamentos de Química Orgánica', 20);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (100, 'SO1501', 'Fundamentos de Anatomía y Fisiología Humana', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (101, 'SO2205', 'Riesgos en Instalaciones Maquinaria y Equipo', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (102, 'PI2608', 'Análisis Estadístico', 16);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (103, 'SO2204', 'Taller Riesgos en Instalaciones Maquinaria y Equipo', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (104, 'SO2307', 'Agentes Ambientales Físicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (105, 'SO3503', 'Fundamentos de Medicina y Toxicología Laboral', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (106, 'BI3509', 'Fundamentos de Ecología y Problemática Ambiental', 2);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (107, 'SO2308', 'Taller de Agentes Ambientales Físicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (108, 'SO2502', 'Psicología de la Prevención', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (109, 'SO3203', 'Igneología de Riesgos Eléctricos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (110, 'SO3303', 'Agentes Ambientales Químicos y Biológicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (111, 'SO3504', 'Legislación en Salud Ocupacional y Ambiental', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (112, 'SO3202', 'Taller de Igneología y Riesgos Eléctricos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (113, 'SO3304', 'Taller de Agentes Ambientales Químicos y Biológicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (114, 'SO3306', 'Control de Agentes Físicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (115, 'SO3502', 'Pedagogía Laboral', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (116, 'SO4508', 'Protección del Ambiente', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (117, 'SO2403', 'Riesgos en Actividades Específicas', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (118, 'SO3506', 'Metodología Investigación', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (119, 'SO4305', 'Control de Agentes Químicos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (120, 'SO4402', 'Gerencia de Riesgos', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (121, 'SO4504', 'Epidemiología', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (122, 'SO4412', 'Administración de la Prevención', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (123, 'SO4413', 'Proyecto de Graduación', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (124, 'SO4505', 'Ergonomía', 17);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (125, 'AE1122', 'Contabilidad I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (126, 'AE1217', 'Teoría Administrativa I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (127, 'CI1305', 'Inglés I para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (128, 'CS1308', 'Derecho Comercial', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (129, 'MA1301', 'Matemática Básica para Administración', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (130, 'AE1123', 'Contabilidad II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (131, 'AE1218', 'Teoría Administrativa II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (132, 'AE2125', 'Matemática Financiera', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (133, 'CI1306', 'Inglés II para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (134, 'MA1302', 'Cálculo para Administración', 19);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (135, 'AE2124', 'Contabilidad III', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (136, 'AE2219', 'Comportamiento Organizacional', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (137, 'AE2308', 'Microeconomía', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (138, 'AE2703', 'Computación para Administración', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (139, 'CI2307', 'Inglés III para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (140, 'AE2126', 'Contabilidad de Costos I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (141, 'AE2311', 'Macroeconomía', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (142, 'AE2506', 'Estadística II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (143, 'AE2505', 'Estadística I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (144, 'AE2708', 'Sistemas de Información para Administración', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (145, 'CI2308', 'Inglés IV para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (146, 'CS2304', 'Derecho Laboral', 5);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (147, 'AE2220', 'Análisis Administrativo', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (148, 'AE3127', 'Administración Financiera I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (149, 'AE3312', 'Negocios Internacionales', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (150, 'AE3411', 'Mercadotecnia I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (151, 'AE3505', 'Metodología de la Investigación', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (152, 'CI3309', 'Inglés V para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (153, 'AE3128', 'Administración Financiera II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (154, 'AE3222', 'Administración de Recursos Humanos I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (155, 'AE3413', 'Mercadotecnia II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (156, 'AE3506', 'Productividad Empresarial', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (157, 'CI3310', 'Inglés VI para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (158, 'AE4128', 'Auditoria I', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (159, 'AE4130', 'Formulación y Evaluación Proyectos', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (160, 'AE4223', ' Administración de Recursos Humanos II', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (161, 'AE4226', 'Estrategia Empresarial', 1);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (162, 'CI4312', 'Inglés VII para Administración', 4);
INSERT INTO `mydb`.`Curso` (`CursoId`, `CodigoCurso`, `NombreCurso`, `EscuelaId`) VALUES (163, 'AE4602', 'Práctica', 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`CursoEnPlan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (1, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (2, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (3, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (4, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (5, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (6, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (7, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (8, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (9, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (10, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (11, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (12, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (13, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (14, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (15, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (16, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (17, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (18, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (19, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (20, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (21, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (22, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (23, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (24, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (25, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (26, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (27, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (28, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (29, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (30, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (31, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (32, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (33, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (34, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (35, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (36, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (37, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (38, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (39, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (40, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (41, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (42, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (43, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (44, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (45, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (46, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (47, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (48, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (49, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (50, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (51, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (52, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (53, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (54, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (55, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (56, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (57, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (58, 1);
INSERT INTO `mydb`.`CursoEnPlan` (`CursoId`, `PlanId`) VALUES (59, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Requisitos`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (4, 5, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (6, 2, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (8, 9, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (9, 8, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (12, 3, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (12, 4, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (15, 6, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (16, 15, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (17, 6, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (18, 8, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (18, 9, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (19, 9, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (12, 3, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (21, 12, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (12, 4, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (23, 6, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (23, 15, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (24, 6, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (24, 15, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (25, 24, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (26, 17, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (25, 16, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (27, 18, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (27, 23, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (28, 23, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (29, 27, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (30, 15, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (30, 6, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (31, 17, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (32, 21, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (33, 1, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (34, 27, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (34, 29, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (35, 28, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (35, 29, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (36, 21, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (36, 35, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (37, 24, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (37, 26, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (38, 32, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (39, 36, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (39, 31, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (40, 34, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (40, 42, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (41, 35, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (42, 32, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (42, 36, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (43, 38, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (44, 40, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (44, 41, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (45, 40, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (45, 42, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (46, 28, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (46, 31, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (47, 39, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (48, 44, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (49, 43, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (49, 45, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (50, 43, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (50, 47, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (50, 33, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (59, 46, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (53, 50, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (52, 22, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (51, 40, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (51, 46, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (54, 44, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (54, 49, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (55, 50, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (55, 54, 0, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (56, 51, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (57, 51, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 48, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 53, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 54, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 55, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 56, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 57, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 30, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 37, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 26, 1, 1);
INSERT INTO `mydb`.`Requisitos` (`CursoId`, `CursoRequisitoId`, `Tipo`, `PlanId`) VALUES (58, 59, 1, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Persona`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (1, '111200900', '1234');
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (2, '101118705', '1234');
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (3, '203530423', '1234');
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (4, '700230785', '1234');
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (5, '304630535', '1234');
INSERT INTO `mydb`.`Persona` (`PersonaId`, `Cedula`, `Clave`) VALUES (6, '207080807', '1234');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Rol` (`RolId`, `Nombre`) VALUES (1, 'Estudiante');
INSERT INTO `mydb`.`Rol` (`RolId`, `Nombre`) VALUES (2, 'Profesor');
INSERT INTO `mydb`.`Rol` (`RolId`, `Nombre`) VALUES (3, 'Director de Carrera');
INSERT INTO `mydb`.`Rol` (`RolId`, `Nombre`) VALUES (4, 'Coordinador de Escuela');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`PersonaEnRol`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (1, 2, 'Profesor Electronica');
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (2, 2, 'Profesor Computacion');
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (3, 2, 'Profesor Matematicas');
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (4, 1, 'Estudiante Regular');
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (5, 1, 'Ingeniero en Computadores');
INSERT INTO `mydb`.`PersonaEnRol` (`PersonaId`, `RolId`, `Informacion`) VALUES (6, 1, 'Ingeniero en Computadores');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Periodo`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Periodo` (`PeriodoId`, `Descripcion`, `Cerrado`) VALUES (1, 'Primer Semestre 2012', 1);
INSERT INTO `mydb`.`Periodo` (`PeriodoId`, `Descripcion`, `Cerrado`) VALUES (2, 'Segundo Semestre 2012', 1);
INSERT INTO `mydb`.`Periodo` (`PeriodoId`, `Descripcion`, `Cerrado`) VALUES (3, 'Primer Semestre 2013', 0);
INSERT INTO `mydb`.`Periodo` (`PeriodoId`, `Descripcion`, `Cerrado`) VALUES (4, 'Segundo Semestre 2013', 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Prematricula`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (23, 2, 4, 1);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (24, 2, 3, 2);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (25, 2, 1, 3);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (26, 2, 4, 4);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (30, 2, 3, 5);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (31, 2, 4, 6);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (32, 2, 4, 7);
INSERT INTO `mydb`.`Prematricula` (`CursoId`, `PeriodoId`, `Cantidad`, `PrematriculaId`) VALUES (33, 2, 2, 8);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Oferta`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (1, 1, 3, '0');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (2, 2, 1, '2');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (3, 3, 1, '2');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (4, 4, 1, '3');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (5, 5, 1, '1');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (6, 6, 2, '4');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (7, 7, 1, '4');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (8, 8, 1, '1');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (9, 9, 1, '3');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (10, 10, 2, '0');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (11, 11, 1, '0');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (12, 12, 2, '4');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (13, 13, 2, '2');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (14, 14, 2, '0');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (15, 15, 3, '3');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (16, 16, 3, '1');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (17, 17, 3, '4');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (18, 18, 2, '1');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (19, 19, 2, '3');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (20, 20, 2, '0');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (21, 21, 3, '4');
INSERT INTO `mydb`.`Oferta` (`OfertaId`, `CursoId`, `PeriodoId`, `Cantidad`) VALUES (22, 22, 3, '2');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`PreMatriculaEstudiante`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (1, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (2, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (3, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (4, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (5, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (6, 6);
INSERT INTO `mydb`.`PreMatriculaEstudiante` (`PrematriculaId`, `PersonaId`) VALUES (7, 6);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Estados`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Estados` (`EstadoId`, `Nombre`) VALUES (1, 'Aprobado');
INSERT INTO `mydb`.`Estados` (`EstadoId`, `Nombre`) VALUES (2, 'Reprobado');
INSERT INTO `mydb`.`Estados` (`EstadoId`, `Nombre`) VALUES (3, 'En Curso');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`Matricula`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 1, 75, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 2, 75, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 3, 75, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 4, 85, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 5, 85, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 6, 75, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 7, 70, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 8, 80, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 9, 75, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 10, 95, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 11, 100, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 12, 70, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 13, 85, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 14, 0, 2);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 15, 0, 2);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 16, 85, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 17, 80, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 18, 70, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 19, 70, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 20, 90, 1);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 21, 0, 2);
INSERT INTO `mydb`.`Matricula` (`PersonaId`, `OfertaId`, `Nota`, `EstadoId`) VALUES (6, 22, 75, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`PersonaEnPlan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (1, 3);
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (2, 4);
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (3, 2);
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (4, 2);
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (5, 1);
INSERT INTO `mydb`.`PersonaEnPlan` (`PersonaId`, `PlanId`) VALUES (6, 1);

COMMIT;
