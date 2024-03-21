-- -----------------------------------------------------
-- Schema sqldm
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sqldm` ;

-- -----------------------------------------------------
-- Schema sqldm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sqldm` DEFAULT CHARACTER SET utf8 ;
USE `sqldm` ;

-- -----------------------------------------------------
-- Table `sqldm`.`Cinema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Cinema` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Cinema` (
  `idCinema` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCinema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Person` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Prenom` VARCHAR(45) NOT NULL,
  `DateNaissance` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`Realisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Realisateur` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Realisateur` (
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`Person_idPerson`),
  CONSTRAINT `fk_Realisateur_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `sqldm`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`LimiteAge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`LimiteAge` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`LimiteAge` (
  `idLimiteAge` INT NOT NULL AUTO_INCREMENT,
  `Libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLimiteAge`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Film` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Film` (
  `idFilm` INT NOT NULL AUTO_INCREMENT,
  `Titre` VARCHAR(100) NOT NULL,
  `Duree` INT NOT NULL,
  `Commentaire` Text(500),
  `StartExploitation` DATE NOT NULL,
  `EndExploitation` DATE NOT NULL,
  `DateDeSortie` DATE NOT NULL,
  `Synopsis` TEXT(500) NOT NULL,
  `AvantPremiere` TINYINT NOT NULL,
  `Realisateur_Person_idPerson` INT NOT NULL,
  `LimiteAge_idLimiteAge` INT NOT NULL,
  PRIMARY KEY (`idFilm`),
  CONSTRAINT `fk_Film_Realisateur1`
    FOREIGN KEY (`Realisateur_Person_idPerson`)
    REFERENCES `sqldm`.`Realisateur` (`Person_idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_LimiteAge1`
    FOREIGN KEY (`LimiteAge_idLimiteAge`)
    REFERENCES `sqldm`.`LimiteAge` (`idLimiteAge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`Salle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Salle` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Salle` (
  `idSalle` INT NOT NULL AUTO_INCREMENT,
  `nombrePlace` INT NOT NULL,
  `numeroSalle` INT NOT NULL,
  `Cinema_idCinema` INT NOT NULL,
  PRIMARY KEY (`idSalle`),
  CONSTRAINT `fk_Salle_Cinema1`
    FOREIGN KEY (`Cinema_idCinema`)
    REFERENCES `sqldm`.`Cinema` (`idCinema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`Tarif`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Tarif` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Tarif` (
  `idTarif` INT NOT NULL AUTO_INCREMENT,
  `Prix` INT NOT NULL,
  `Libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTarif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`Acteur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Acteur` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Acteur` (
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`Person_idPerson`),
  CONSTRAINT `fk_Acteur_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `sqldm`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`JoueDans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`JoueDans` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`JoueDans` (
  `Acteur_Person_idPerson` INT NOT NULL,
  `Film_idFilm` INT NOT NULL,
  CONSTRAINT `fk_JoueDans_Acteur1`
    FOREIGN KEY (`Acteur_Person_idPerson`)
    REFERENCES `sqldm`.`Acteur` (`Person_idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JoueDans_Film1`
    FOREIGN KEY (`Film_idFilm`)
    REFERENCES `sqldm`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`PeriodeJournee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`PeriodeJournee` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`PeriodeJournee` (
  `idPeriodeJournee` INT NOT NULL AUTO_INCREMENT,
  `libelle` VARCHAR(45) NOT NULL,
  `heure` TIME NOT NULL,
  PRIMARY KEY (`idPeriodeJournee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`PlanSeance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`PlanSeance` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`PlanSeance` (
  `idPlanSeance` INT NOT NULL AUTO_INCREMENT,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPlanSeance`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`SalleDiffusePeriode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`SalleDiffusePeriode` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`SalleDiffusePeriode` (
  `idSalleDiffusePeriode` INT NOT NULL AUTO_INCREMENT,
  `PeriodeJournee_idPeriodeJournee` INT NOT NULL,
  `Salle_idSalle` INT NOT NULL,
  `PlanSeance_idPlanSeance` INT NOT NULL,
  PRIMARY KEY (`idSalleDiffusePeriode`),
  CONSTRAINT `fk_SalleDiffusePeriode_PeriodeJournee1`
    FOREIGN KEY (`PeriodeJournee_idPeriodeJournee`)
    REFERENCES `sqldm`.`PeriodeJournee` (`idPeriodeJournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalleDiffusePeriode_Salle1`
    FOREIGN KEY (`Salle_idSalle`)
    REFERENCES `sqldm`.`Salle` (`idSalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalleDiffusePeriode_PlanSaence1`
    FOREIGN KEY (`PlanSeance_idPlanSeance`)
    REFERENCES `sqldm`.`PlanSeance` (`idPlanSeance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Genre` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `Libelle` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idGenre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sqldm`.`EstUn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`EstUn` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`EstUn` (
  `Genre_idGenre` INT NOT NULL,
  `Film_idFilm` INT NOT NULL,
  CONSTRAINT `fk_EstUn_Genre1`
    FOREIGN KEY (`Genre_idGenre`)
    REFERENCES `sqldm`.`Genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstUn_Film1`
    FOREIGN KEY (`Film_idFilm`)
    REFERENCES `sqldm`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`FilmEstDiffuseDansSalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`FilmEstDiffuseDansSalle` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`FilmEstDiffuseDansSalle` (
  `FilmEstDiffuseDansSalleId` INT NOT NULL AUTO_INCREMENT,
  `Langue` CHAR(2) NOT NULL,
  `Film_idFilm` INT NOT NULL,
  `SalleDiffusePeriode_idSalleDiffusePeriode` INT NOT NULL,
  PRIMARY KEY (`FilmEstDiffuseDansSalleId`),
  CONSTRAINT `fk_FilmEstDiffuseDansSalle_Film1`
    FOREIGN KEY (`Film_idFilm`)
    REFERENCES `sqldm`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FilmEstDiffuseDansSalle_SalleDiffusePeriode1`
    FOREIGN KEY (`SalleDiffusePeriode_idSalleDiffusePeriode`)
    REFERENCES `sqldm`.`SalleDiffusePeriode` (`idSalleDiffusePeriode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sqldm`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sqldm`.`Ticket` ;

CREATE TABLE IF NOT EXISTS `sqldm`.`Ticket` (
  `numeroTicket` INT NOT NULL AUTO_INCREMENT,
  `Seance` DATE NOT NULL,
  `Tarif_idTarif` INT NOT NULL,
  `FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId` INT NOT NULL,
  PRIMARY KEY (`numeroTicket`),
  CONSTRAINT `fk_Ticket_Tarif1`
    FOREIGN KEY (`Tarif_idTarif`)
    REFERENCES `sqldm`.`Tarif` (`idTarif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_FilmEstDiffuseDansSalle1`
    FOREIGN KEY (`FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId`)
    REFERENCES `sqldm`.`FilmEstDiffuseDansSalle` (`FilmEstDiffuseDansSalleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


USE `sqldm`;

DELIMITER $$

USE `sqldm`$$
DROP TRIGGER IF EXISTS `sqldm`.`Film_BEFORE_INSERT` $$
USE `sqldm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `sqldm`.`Film_BEFORE_INSERT` BEFORE INSERT ON `Film` FOR EACH ROW
BEGIN
	if new.EndExploitation is null 
    then set new.EndExploitation = date_add(NEW.StartExploitation, interval 8 week);
	END if;
end$$

DELIMITER ;

-- Question 7 --
DELIMITER $$
CREATE FUNCTION format_movie_duration(duree INT)
RETURNS CHAR(5)
BEGIN
    DECLARE dureeHeureMinute CHAR(5);
    SET dureeHeureMinute = CONCAT(FLOOR(duree / 60), "h", LPAD(duree % 60, 2, '0'));
    RETURN dureeHeureMinute;
END$$
DELIMITER ;

-- Question 9 --
DELIMITER $$
CREATE PROCEDURE print_movie_summary(in titreFilm VARCHAR(100))
begin
	select Titre, format_movie_duration(Duree), Synopsis,  Concat(p.prenom, " ", p.nom) as "Real.",
	group_concat(distinct concat(p2.prenom, " ", p2.nom) order by p2.idPerson) as acteur,
	group_concat(distinct g.libelle) as "Genre", Commentaire  
from film f 
inner join person p on f.Realisateur_Person_idPerson = p.idPerson 
inner join estun e on e.Film_idFilm = idFilm 
inner join genre g on e.Genre_idGenre = g.idGenre
inner join jouedans j on j.Film_idFilm = f.idFilm 
inner join acteur a on a.Person_idPerson = j.Acteur_Person_idPerson
inner join person p2 on p2.idPerson = a.Person_idPerson 
where Titre = titreFilm
GROUP BY 
    Titre, format_movie_duration(Duree), Synopsis, CONCAT(p.prenom, ' ', p.nom), Commentaire;   
end$$
DELIMITER ;