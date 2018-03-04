-- MySQL Script generated by MySQL Workbench
-- Fri Mar  2 16:01:29 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employees` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
  `PersID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Surname` VARCHAR(45) NULL,
  `Position` VARCHAR(45) NULL,
  `Active` TINYINT NOT NULL,
  PRIMARY KEY (`PersID`),
  UNIQUE INDEX `PersID_UNIQUE` (`PersID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Partners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Partners` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Partners` (
  `PartnerID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Org` VARCHAR(45) NULL,
  `Position` VARCHAR(45) NULL,
  `Active` TINYINT NOT NULL,
  PRIMARY KEY (`PartnerID`),
  UNIQUE INDEX `PartnerID_UNIQUE` (`PartnerID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Rooms` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Rooms` (
  `name` VARCHAR(45) NOT NULL,
  `hourly_price` INT NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));


-- -----------------------------------------------------
-- Table `mydb`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Teams` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Teams` (
  `GroupID` INT NOT NULL,
  `Name` VARCHAR(12) NOT NULL,
  `Employees_PersID` INT NOT NULL,
  `Active` TINYINT NOT NULL,
  PRIMARY KEY (`GroupID`, `Employees_PersID`),
  CONSTRAINT `fk_Teams_Employees1`
    FOREIGN KEY (`Employees_PersID`)
    REFERENCES `mydb`.`Employees` (`PersID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meeting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Meeting` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Meeting` (
  `MeetID` INT NOT NULL,
  `Rooms_name` VARCHAR(45) NOT NULL,
  `BookedBy` INT NOT NULL,
  `Team` INT NOT NULL,
  `timeStart` DATETIME NOT NULL,
  `timeENd` DATETIME NOT NULL,
  `Duration` DECIMAL(4) NOT NULL,
  `Cost` DECIMAL(4) NOT NULL,
  PRIMARY KEY (`MeetID`),
  INDEX `fk_Meetings_Rooms1_idx` (`Rooms_name` ASC),
  INDEX `fk_Meeting_Employees1_idx` (`BookedBy` ASC),
  INDEX `fk_Meeting_Teams_idx` (`Team` ASC),
  UNIQUE INDEX `MeetID_UNIQUE` (`MeetID` ASC),
  CONSTRAINT `fk_Meetings_Rooms1`
    FOREIGN KEY (`Rooms_name`)
    REFERENCES `mydb`.`Rooms` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Meeting_Employees1`
    FOREIGN KEY (`BookedBy`)
    REFERENCES `mydb`.`Employees` (`PersID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Meeting_Teams`
    FOREIGN KEY (`Team`)
    REFERENCES `mydb`.`Teams` (`GroupID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Participants_int`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Participants_int` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Participants_int` (
  `Meeting` INT NULL,
  `Employees_PersID` INT NULL,
  INDEX `fk_Participants_Employees1_idx` (`Employees_PersID` ASC),
  INDEX `fk_MeetID_idx` (`Meeting` ASC),
  CONSTRAINT `fk_Participants_Employees1`
    FOREIGN KEY (`Employees_PersID`)
    REFERENCES `mydb`.`Employees` (`PersID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MeetID`
    FOREIGN KEY (`Meeting`)
    REFERENCES `mydb`.`Meeting` (`MeetID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meet_time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Meet_time` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Meet_time` (
  `MeetID` INT NOT NULL,
  `timeStart` DATETIME NOT NULL,
  `timeEnd` DATETIME NOT NULL,
  `Duration` DECIMAL(4) NOT NULL,
  PRIMARY KEY (`MeetID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Participants_ext`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Participants_ext` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Participants_ext` (
  `Meeting` INT NULL,
  `Partners_PartnerID` INT NULL,
  INDEX `fk_Participants_Partners1_idx` (`Partners_PartnerID` ASC),
  INDEX `fk_MeetID_idx` (`Meeting` ASC),
  CONSTRAINT `fk_Participants_Partners10`
    FOREIGN KEY (`Partners_PartnerID`)
    REFERENCES `mydb`.`Partners` (`PartnerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MeetID0`
    FOREIGN KEY (`Meeting`)
    REFERENCES `mydb`.`Meeting` (`MeetID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Facilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Facilities` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Facilities` (
  `Rooms_name` VARCHAR(45) NOT NULL,
  `Facility` VARCHAR(45) NULL,
  INDEX `fk_Facilities_Rooms1_idx` (`Rooms_name` ASC),
  CONSTRAINT `fk_Facilities_Rooms1`
    FOREIGN KEY (`Rooms_name`)
    REFERENCES `mydb`.`Rooms` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meet_time_copy1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Meet_time_copy1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Meet_time_copy1` (
  `MeetID` INT NOT NULL,
  `timeStart` DATETIME NOT NULL,
  `timeEnd` DATETIME NOT NULL,
  `Duration` DECIMAL(4) NOT NULL,
  PRIMARY KEY (`MeetID`))
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Employees_BEFORE_DELETE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Employees_BEFORE_DELETE` BEFORE DELETE ON `Employees` FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
      -- Here comes your custom error message that will be returned by MySQL
      SET MESSAGE_TEXT = 'You are not allowed to remove it!! Use Active key';

END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Partners_BEFORE_DELETE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Partners_BEFORE_DELETE` BEFORE DELETE ON `Partners` FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
      -- Here comes your custom error message that will be returned by MySQL
      SET MESSAGE_TEXT = 'You are not allowed to remove it!! Use Active key';
END
$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Teams_BEFORE_DELETE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Teams_BEFORE_DELETE` BEFORE DELETE ON `Teams` FOR EACH ROW
BEGIN
 SIGNAL SQLSTATE '45000' -- "unhandled user-defined exception"
      -- Here comes your custom error message that will be returned by MySQL
      SET MESSAGE_TEXT = 'You are not allowed to remove it!! Use Active key';

END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1001, 'Kalle', 'Anka', 'CEO', 1);
INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1002, 'Tjalle', 'Bonke', 'CFO', 1);
INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1003, 'Usrula', 'Fulle', 'Social media', 1);
INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1004, 'Ariel', 'Seaweed', 'worker', 1);
INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1005, 'Bob', 'Saget', 'CEO', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Partners`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Partners` (`PartnerID`, `Name`, `Org`, `Position`, `Active`) VALUES (101, 'Dinkie', 'BigGlobal', 'CEO', 1);
INSERT INTO `mydb`.`Partners` (`PartnerID`, `Name`, `Org`, `Position`, `Active`) VALUES (102, 'Stinkie', 'BigCorp', 'CFO', 1);
INSERT INTO `mydb`.`Partners` (`PartnerID`, `Name`, `Org`, `Position`, `Active`) VALUES (103, 'Pinkie', 'Cornershop', 'Owner', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Rooms`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Rooms` (`name`, `hourly_price`) VALUES ('Stockholm', 300);
INSERT INTO `mydb`.`Rooms` (`name`, `hourly_price`) VALUES ('Gotheborg', 200);
INSERT INTO `mydb`.`Rooms` (`name`, `hourly_price`) VALUES ('Malmo', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Teams`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (10, 'Alpha', 1001, 1);
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (11, 'Bravo', 1002, 1);
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (12, 'Charlie', 1003, 1);
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (10, 'Alpha', 1004, 1);
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (11, 'Bravo', 1005, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Meeting`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Meeting` (`MeetID`, `Rooms_name`, `BookedBy`, `Team`, `timeStart`, `timeENd`, `Duration`, `Cost`) VALUES (1, 'Stockholm', 1001, 10, '2018-01-01 12:00', '2018-01-01 14:00', 2, 600);
INSERT INTO `mydb`.`Meeting` (`MeetID`, `Rooms_name`, `BookedBy`, `Team`, `timeStart`, `timeENd`, `Duration`, `Cost`) VALUES (3, 'Stockholm', 1001, 10, '2018-03-01 12:00', '2018-03-01 14:00', 2, 600);
INSERT INTO `mydb`.`Meeting` (`MeetID`, `Rooms_name`, `BookedBy`, `Team`, `timeStart`, `timeENd`, `Duration`, `Cost`) VALUES (4, 'Stockholm', 1001, 10, '2018-04-01 12:00', '2018-04-01 14:00', 2, 600);
INSERT INTO `mydb`.`Meeting` (`MeetID`, `Rooms_name`, `BookedBy`, `Team`, `timeStart`, `timeENd`, `Duration`, `Cost`) VALUES (2, 'Stockholm', 1001, 10, '2018-02-01 12:00', '2018-02-01 14:00', 2, 600);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Participants_int`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Participants_int` (`Meeting`, `Employees_PersID`) VALUES (1, 1002);
INSERT INTO `mydb`.`Participants_int` (`Meeting`, `Employees_PersID`) VALUES (1, 1003);
INSERT INTO `mydb`.`Participants_int` (`Meeting`, `Employees_PersID`) VALUES (2, 1004);
INSERT INTO `mydb`.`Participants_int` (`Meeting`, `Employees_PersID`) VALUES (3, 1005);
INSERT INTO `mydb`.`Participants_int` (`Meeting`, `Employees_PersID`) VALUES (4, 1003);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Meet_time`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Meet_time` (`MeetID`, `timeStart`, `timeEnd`, `Duration`) VALUES (1, '2018-02-25 12:00:00', '2018-02-25 13:00:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Participants_ext`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Participants_ext` (`Meeting`, `Partners_PartnerID`) VALUES (1, 101);
INSERT INTO `mydb`.`Participants_ext` (`Meeting`, `Partners_PartnerID`) VALUES (2, 101);
INSERT INTO `mydb`.`Participants_ext` (`Meeting`, `Partners_PartnerID`) VALUES (3, 101);
INSERT INTO `mydb`.`Participants_ext` (`Meeting`, `Partners_PartnerID`) VALUES (3, 102);
INSERT INTO `mydb`.`Participants_ext` (`Meeting`, `Partners_PartnerID`) VALUES (4, 103);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Facilities`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Facilities` (`Rooms_name`, `Facility`) VALUES ('Stockholm', 'Chair');
INSERT INTO `mydb`.`Facilities` (`Rooms_name`, `Facility`) VALUES ('Stockholm', 'Table');
INSERT INTO `mydb`.`Facilities` (`Rooms_name`, `Facility`) VALUES ('Gotheborg', 'Lamp');
INSERT INTO `mydb`.`Facilities` (`Rooms_name`, `Facility`) VALUES ('Malmo', 'TP');

COMMIT;

