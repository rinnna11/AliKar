
CREATE SCHEMA IF NOT EXISTS `shoeshop`;
USE `shoeshop` ;

CREATE TABLE IF NOT EXISTS `shoeshop`.`brand` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`orderestatus` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`pvzshka` (
  `id` INT NOT NULL,
  `postcode` VARCHAR(20) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `street` VARCHAR(150) NOT NULL,
  `house` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `shoeshop`.`roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`users` (
  `id` INT NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `login` VARCHAR(150) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login` (`login` ASC) VISIBLE,
  INDEX `fk_users_role` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `shoeshop`.`roles` (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`orders` (
  `id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `delivery_date` DATE NOT NULL,
  `pvzshka_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `receive_code` INT NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_pvz` (`pvzshka_id` ASC),
  INDEX `fk_orders_user` (`user_id` ASC),
  INDEX `fk_orders_status` (`status_id` ASC),
  CONSTRAINT `fk_orders_pvz`
    FOREIGN KEY (`pvzshka_id`)
    REFERENCES `shoeshop`.`pvzshka` (`id`),
  CONSTRAINT `fk_orders_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `shoeshop`.`orderestatus` (`id`),
  CONSTRAINT `fk_orders_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `shoeshop`.`users` (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`sotrudniki` (
  `id` INT NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`products` (
  `id` INT NOT NULL,
  `article` VARCHAR(50) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `unit` VARCHAR(20) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` INT NULL DEFAULT '0',
  `stock_qty` INT NULL DEFAULT '0',
  `description` TEXT NULL DEFAULT NULL,
  `photo` VARCHAR(255) NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  `manufacturer_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `article` (`article` ASC),
  INDEX `fk_products_category` (`category_id` ASC),
  INDEX `fk_products_manufacturer` (`manufacturer_id` ASC),
  INDEX `fk_products_supplier` (`supplier_id` ASC),
  CONSTRAINT `fk_products_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `shoeshop`.`category` (`id`),
  CONSTRAINT `fk_products_manufacturer`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `shoeshop`.`brand` (`id`),
  CONSTRAINT `fk_products_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `shoeshop`.`sotrudniki` (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoeshop`.`productorders` (
  `id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productorders_order` (`order_id` ASC),
  INDEX `fk_productorders_product` (`product_id` ASC),
  CONSTRAINT `fk_productorders_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `shoeshop`.`orders` (`id`),
  CONSTRAINT `fk_productorders_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `shoeshop`.`products` (`id`))
ENGINE = InnoDB;


