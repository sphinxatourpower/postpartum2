ALTER TABLE  `customer` ADD  `sick_history` VARCHAR( 255 ) NOT NULL AFTER  `language` ,
ADD  `complications` VARCHAR( 255 ) NOT NULL AFTER  `sick_history` ,
ADD  `food` VARCHAR( 255 ) NOT NULL AFTER  `complications` ,
ADD  `memo` VARCHAR( 255 ) NOT NULL AFTER  `food` ;