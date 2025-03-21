UPDATE `sso`.`organizations` SET `updated_at` = `created_at` WHERE `updated_at` IS NULL;

ALTER TABLE `sso`.`organizations` 
CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

UPDATE `sso`.`users` SET `updated_at` = `created_at` WHERE `updated_at` IS NULL;

ALTER TABLE `sso`.`users` 
CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;