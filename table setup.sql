use crochet_dev;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema amigurumi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `website`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `website` ;

CREATE TABLE IF NOT EXISTS `website` (
  `idwebsite` INT NOT NULL AUTO_INCREMENT,
  `web_address` VARCHAR(75) NOT NULL,
  `author` VARCHAR(75) NULL,
  PRIMARY KEY (`idwebsite`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `idbook` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `publisher` VARCHAR(45) NULL,
  PRIMARY KEY (`idbook`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `source` ;

CREATE TABLE IF NOT EXISTS `source` (
  `idsource` INT NOT NULL AUTO_INCREMENT,
  `website_idwebsite` INT NULL,
  `book_idbook` INT NULL,
  PRIMARY KEY (`idsource`),
  INDEX `fk_source_website1_idx` (`website_idwebsite` ASC) VISIBLE,
  INDEX `fk_source_book1_idx` (`book_idbook` ASC) VISIBLE,
  CONSTRAINT `fk_source_website1`
    FOREIGN KEY (`website_idwebsite`)
    REFERENCES `website` (`idwebsite`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_source_book1`
    FOREIGN KEY (`book_idbook`)
    REFERENCES `book` (`idbook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pattern`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pattern` ;

CREATE TABLE IF NOT EXISTS `pattern` (
  `idpattern` INT NOT NULL AUTO_INCREMENT,
  `instructions` VARCHAR(500) NOT NULL,
  `size` INT NOT NULL,
  `genre` VARCHAR(45) NULL,
  `source_idsource` INT NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idpattern`, `source_idsource`),
  INDEX `fk_pattern_source1_idx` (`source_idsource` ASC) VISIBLE,
  CONSTRAINT `fk_pattern_source1`
    FOREIGN KEY (`source_idsource`)
    REFERENCES `source` (`idsource`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `idcustomer` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `street_address` VARCHAR(75) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ship` ;

CREATE TABLE IF NOT EXISTS `ship` (
  `idship` INT NOT NULL AUTO_INCREMENT,
  `shipping_company` VARCHAR(20) NOT NULL,
  `cost` DECIMAL(5,2) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`idship`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sale` ;

CREATE TABLE IF NOT EXISTS `sale` (
  `idsale` INT NOT NULL AUTO_INCREMENT,
  `customer_idcustomer` INT NOT NULL,
  `ship_idship` INT NOT NULL,
  PRIMARY KEY (`idsale`, `customer_idcustomer`, `ship_idship`),
  INDEX `fk_sale_customer1_idx` (`customer_idcustomer` ASC) VISIBLE,
  INDEX `fk_sale_ship1_idx` (`ship_idship` ASC) VISIBLE,
  CONSTRAINT `fk_sale_customer1`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_ship1`
    FOREIGN KEY (`ship_idship`)
    REFERENCES `ship` (`idship`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plush`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `plush` ;

CREATE TABLE IF NOT EXISTS `plush` (
  `idplush` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `pattern_idpattern` INT NOT NULL,
  `sale_idsale` INT NULL,
  `price` DECIMAL(5,2) NULL,
  `image` VARCHAR(75) NULL,
  PRIMARY KEY (`idplush`, `pattern_idpattern`),
  UNIQUE INDEX `idplush_UNIQUE` (`idplush` ASC) VISIBLE,
  INDEX `fk_plush_pattern1_idx` (`pattern_idpattern` ASC) VISIBLE,
  INDEX `fk_plush_sale1_idx` (`sale_idsale` ASC) VISIBLE,
  CONSTRAINT `fk_plush_pattern1`
    FOREIGN KEY (`pattern_idpattern`)
    REFERENCES `pattern` (`idpattern`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plush_sale1`
    FOREIGN KEY (`sale_idsale`)
    REFERENCES `sale` (`idsale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yarn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yarn` ;

CREATE TABLE IF NOT EXISTS `yarn` (
  `idyarn` INT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NOT NULL,
  `weight` INT NOT NULL,
  `material` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idyarn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plush yarn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `plush yarn` ;

CREATE TABLE IF NOT EXISTS `plush yarn` (
  `idplush_yarn` INT NOT NULL AUTO_INCREMENT,
  `plush_idplush` INT NOT NULL,
  `yarn_idyarn` INT NOT NULL,
  PRIMARY KEY (`idplush_yarn`, `plush_idplush`, `yarn_idyarn`),
  INDEX `fk_plush yarn_yarn1_idx` (`yarn_idyarn` ASC) VISIBLE,
  CONSTRAINT `fk_plush yarn_plush`
    FOREIGN KEY (`plush_idplush`)
    REFERENCES `plush` (`idplush`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plush yarn_yarn1`
    FOREIGN KEY (`yarn_idyarn`)
    REFERENCES `yarn` (`idyarn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hook` ;

CREATE TABLE IF NOT EXISTS `hook` (
  `idhook` INT NOT NULL AUTO_INCREMENT,
  `size` VARCHAR(5) NOT NULL,
  `material` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idhook`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pattern hook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pattern hook` ;

CREATE TABLE IF NOT EXISTS `pattern hook` (
  `idpattern_hook` INT NOT NULL AUTO_INCREMENT,
  `hook_idhook` INT NOT NULL,
  `pattern_idpattern` INT NOT NULL,
  PRIMARY KEY (`idpattern_hook`, `hook_idhook`, `pattern_idpattern`),
  INDEX `fk_table1_hook1_idx` (`hook_idhook` ASC) VISIBLE,
  INDEX `fk_table1_pattern1_idx` (`pattern_idpattern` ASC) VISIBLE,
  CONSTRAINT `fk_table1_hook1`
    FOREIGN KEY (`hook_idhook`)
    REFERENCES `hook` (`idhook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_pattern1`
    FOREIGN KEY (`pattern_idpattern`)
    REFERENCES `pattern` (`idpattern`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
