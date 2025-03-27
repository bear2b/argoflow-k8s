CREATE TABLE IF NOT EXISTS `sso`.`users_mfa_codes` (
	`user_id` INT UNSIGNED NOT NULL,
	`code` VARCHAR(6) COLLATE utf8_unicode_ci NOT NULL,
	`attempt_cnt` INT NOT NULL DEFAULT 0,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`user_id`),
	CONSTRAINT `users_mfa_codes__user_id` FOREIGN KEY (`user_id`) REFERENCES `sso`.`users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE);