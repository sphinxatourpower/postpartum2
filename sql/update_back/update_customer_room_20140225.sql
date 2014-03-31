ALTER TABLE `customer_room` ADD `price` INT NULL DEFAULT NULL AFTER `sort_order`, ADD `spec` TEXT NOT NULL AFTER `price`, ADD `equip` TEXT NOT NULL AFTER `spec`;

ALTER TABLE `customer_room` ADD `floor` VARCHAR(32) NOT NULL AFTER `sort_order`;