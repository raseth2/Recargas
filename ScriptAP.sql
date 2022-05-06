-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla apuestatotal.banks
CREATE TABLE IF NOT EXISTS `banks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.banks: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` (`id`, `active`, `description`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Banco de Credito', NULL, NULL),
	(2, 1, 'Banco de Interbank', NULL, NULL),
	(3, 1, 'Banco Scotiabank', '2022-05-06 07:55:30', '2022-05-06 07:55:30');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `player_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` int(11) NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_api_token_unique` (`api_token`),
  KEY `clients_document_type_id_foreign` (`document_type_id`),
  CONSTRAINT `clients_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `document_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.clients: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` (`id`, `email`, `name`, `last_name`, `number`, `player_id`, `document_type_id`, `state`, `password`, `api_token`, `created_at`, `updated_at`) VALUES
	(1, 'cliente@gmail.com', 'Cesar', 'Apellido', '45713875', '45713875AC', '1', 1, '$2y$10$jVwc3JH6Hl2/KKwd8cPxyeBYCoWMM4bRSfaQJ0ecwSxotZCfhOFNq', 'Y9xmVHc3EHtCEXZOwy7R0t2DMwwrZu1dnQAIFNTOKNBYPDTTpdPDSjSFnUEw', NULL, NULL),
	(2, 'cliente2@gmail.com', 'Jose', 'Garcia', '54545555', '54545555OO', '1', 1, '$10$jVwc3JH6Hl2/KKwd8cPxyeBYCoWMM4bRSfaQJ0ecwSxotZCfhOFNq', 'sdsds', '2022-05-04 19:12:02', '2022-05-04 19:12:03');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.document_types
CREATE TABLE IF NOT EXISTS `document_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `document_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.document_types: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `document_types` DISABLE KEYS */;
INSERT INTO `document_types` (`id`, `active`, `description`) VALUES
	('1', 1, 'DNI'),
	('6', 1, 'RUC');
/*!40000 ALTER TABLE `document_types` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.history_wallets
CREATE TABLE IF NOT EXISTS `history_wallets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `fecha` date NOT NULL,
  `state` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  `recharge_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `history_wallets_cliente_id_foreign` (`cliente_id`),
  KEY `FK_history_wallets_recharges` (`recharge_id`),
  CONSTRAINT `FK_history_wallets_recharges` FOREIGN KEY (`recharge_id`) REFERENCES `recharges` (`id`),
  CONSTRAINT `history_wallets_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.history_wallets: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `history_wallets` DISABLE KEYS */;
INSERT INTO `history_wallets` (`id`, `amount`, `fecha`, `state`, `created_at`, `updated_at`, `cliente_id`, `recharge_id`) VALUES
	(1, 12.00, '2022-05-04', '0', '2022-05-04 23:03:08', '2022-05-04 23:03:08', 1, 1),
	(2, 50.00, '2022-05-04', '0', '2022-05-04 23:10:33', '2022-05-04 23:10:33', 2, 2),
	(3, 20.00, '2022-05-05', '0', '2022-05-05 00:08:40', '2022-05-05 00:08:40', 1, 3),
	(4, 50.00, '2022-05-05', '0', '2022-05-05 15:28:41', '2022-05-05 15:28:41', 1, 6),
	(5, 20.00, '2022-05-05', '0', '2022-05-05 15:32:29', '2022-05-05 15:32:29', 1, 8),
	(6, 50.00, '2022-05-05', '0', '2022-05-05 19:54:14', '2022-05-05 19:54:14', 1, 9),
	(7, 10.00, '2022-05-05', '0', '2022-05-05 20:04:26', '2022-05-05 20:04:26', 1, 10),
	(8, 10.00, '2022-05-05', '1', '2022-05-05 20:16:58', '2022-05-05 20:16:58', 2, 11),
	(9, 10.00, '2022-05-05', '1', '2022-05-05 20:18:52', '2022-05-05 20:18:52', 1, 12);
/*!40000 ALTER TABLE `history_wallets` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.migrations: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2022_05_04_210250_create_tipe_users_table', 1),
	(2, '2022_05_04_210301_create_users_table', 1),
	(3, '2022_05_04_210907_create_social_networks_table', 1),
	(4, '2022_05_04_211108_create_clientes_table', 1),
	(5, '2022_05_04_212300_create_number_clients_table', 1),
	(6, '2022_05_04_213234_create_wallets_table', 1),
	(7, '2022_05_04_215040_create_history_wallets_table', 1),
	(8, '2022_05_04_215954_create_recharges_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.number_clients
CREATE TABLE IF NOT EXISTS `number_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `number_clients_cliente_id_foreign` (`cliente_id`),
  CONSTRAINT `number_clients_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.number_clients: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `number_clients` DISABLE KEYS */;
INSERT INTO `number_clients` (`id`, `number`, `state`, `cliente_id`, `created_at`, `updated_at`) VALUES
	(1, '970780836', NULL, 1, '2022-05-04 18:50:05', '2022-05-05 20:04:26'),
	(2, '545454555', NULL, 1, '2022-05-04 18:52:20', '2022-05-05 20:04:26'),
	(3, '545454555', 'default', 2, '2022-05-04 21:09:36', '2022-05-04 21:09:36'),
	(4, '11111111', NULL, 1, '2022-05-04 22:34:16', '2022-05-05 20:04:26'),
	(5, '22222222', NULL, 1, '2022-05-04 22:34:29', '2022-05-05 20:04:26'),
	(6, '88888888', 'default', 1, '2022-05-05 20:04:26', '2022-05-05 20:04:26');
/*!40000 ALTER TABLE `number_clients` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.recharges
CREATE TABLE IF NOT EXISTS `recharges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `state` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  `bank_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `social_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recharges_cliente_id_foreign` (`cliente_id`),
  KEY `recharges_bank_id_foreign` (`bank_id`),
  KEY `recharges_user_id_foreign` (`user_id`),
  KEY `FK_recharges_social_networks` (`social_id`),
  CONSTRAINT `FK_recharges_social_networks` FOREIGN KEY (`social_id`) REFERENCES `social_networks` (`id`),
  CONSTRAINT `recharges_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  CONSTRAINT `recharges_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `recharges_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.recharges: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `recharges` DISABLE KEYS */;
INSERT INTO `recharges` (`id`, `amount`, `state`, `date`, `photo`, `comment`, `number`, `created_at`, `updated_at`, `cliente_id`, `bank_id`, `user_id`, `social_id`) VALUES
	(1, 12.00, '0', '2022-01-04', 'uploads/vouchers/LjNQB-1651723388-1651723388.png', NULL, '22222222', '2022-05-04 23:03:08', '2022-05-04 23:03:08', 1, 2, 1, 2),
	(2, 50.00, '0', '2022-01-04', 'uploads/vouchers/NZX0S-1651723833-1651723833.jpg', NULL, '545454555', '2022-05-04 23:10:33', '2022-05-04 23:10:33', 2, 2, 1, 2),
	(3, 50.00, '1', '2022-02-05', 'uploads/vouchers/3EpSF-1651727320-1651727320.jpg', 'Aprobado', '22222222', '2022-05-05 00:08:40', '2022-05-05 01:59:07', 1, 1, 1, 2),
	(4, 50.00, '0', '2022-02-05', 'uploads/vouchers/2PHck-1651782344-1651782344.png', NULL, '22222222', '2022-05-05 15:25:44', '2022-05-05 15:25:44', 1, 2, 1, 2),
	(5, 50.00, '0', '2022-02-05', 'uploads/vouchers/QvN0Z-1651782418-1651782418.png', NULL, '22222222', '2022-05-05 15:26:58', '2022-05-05 15:26:58', 1, 1, 1, 2),
	(6, 50.00, '0', '2022-02-05', 'uploads/vouchers/jY5Zv-1651782521-1651782521.png', NULL, '22222222', '2022-05-05 15:28:41', '2022-05-05 15:28:41', 1, 1, 1, 1),
	(7, 20.00, '0', '2022-02-05', 'uploads/vouchers/mhPoZ-1651782586-1651782586.jpg', NULL, '22222222', '2022-05-05 15:29:46', '2022-05-05 15:29:46', 1, 2, 1, 2),
	(8, 20.00, '0', '2022-02-05', 'uploads/vouchers/acl6q-1651782749-1651782749.jpg', NULL, '22222222', '2022-05-05 15:32:29', '2022-05-05 15:32:29', 1, 2, 1, 2),
	(9, 10.00, '0', '2022-05-05', 'uploads/vouchers/jF97Q-1651798453-1651798453.jpg', 'te equicas gilaso', '22222222', '2022-05-05 19:54:13', '2022-05-05 20:00:37', 1, 2, 1, 1),
	(10, 10.00, '0', '2022-05-05', 'uploads/vouchers/ma0zk-1651799066-1651799066.png', NULL, '88888888', '2022-05-05 20:04:26', '2022-05-05 20:04:26', 1, 2, 1, 2),
	(11, 10.00, '1', '2022-05-05', 'uploads/vouchers/EcdKQ-1651799713-1651799713.png', 'Aprobado', '545454555', '2022-05-05 20:15:13', '2022-05-05 20:16:58', 2, 2, 1, 2),
	(12, 10.00, '1', '2022-05-05', 'uploads/vouchers/cyqhN-1651799914-1651799914.png', 'Aprobado', '88888888', '2022-05-05 20:18:34', '2022-05-05 20:18:52', 1, 1, 1, 2);
/*!40000 ALTER TABLE `recharges` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.social_networks
CREATE TABLE IF NOT EXISTS `social_networks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.social_networks: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `social_networks` DISABLE KEYS */;
INSERT INTO `social_networks` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'WhatsApp', '2022-05-04 17:36:45', '2022-05-04 17:36:48'),
	(2, 'Telegram', '2022-05-04 17:36:46', '2022-05-04 17:36:47');
/*!40000 ALTER TABLE `social_networks` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.type_users
CREATE TABLE IF NOT EXISTS `type_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.type_users: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `type_users` DISABLE KEYS */;
INSERT INTO `type_users` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Promotor', '2022-05-05 15:45:24', '2022-05-05 15:45:25'),
	(2, 'Administrador', '2022-05-05 15:45:25', '2022-05-05 15:45:26');
/*!40000 ALTER TABLE `type_users` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`),
  KEY `users_type_user_id_foreign` (`type_user_id`),
  CONSTRAINT `users_type_user_id_foreign` FOREIGN KEY (`type_user_id`) REFERENCES `type_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.users: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`, `type_user_id`) VALUES
	(1, 'Ussuario 1', 'promotor@gmail.com', NULL, '$2y$10$Vk6TMuSQDdrYIXMtIhin/./23xmXLa.SphVHLv9fhTHl2m3IuI59W', 'b3H8xxT1e48lDoF5OnrwfYBlEDJPXamxj4iMHn2mzyyDqw0nz2OvNFyXkAx0', NULL, NULL, NULL, 1),
	(2, 'Administrador', 'admin@gmail.com', NULL, '$2y$10$qQqsZbijHL7IaqieShfzGeSmAVBh7ElZe8Qvh7dwXu/l6IE/8rsqm', 't2P2Fg7XbvugqXlbnyubRdoEvrWFU5wNFAQ6VzItWP8GjSTwY9sjSrO4EoVq', NULL, NULL, NULL, 2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla apuestatotal.wallets
CREATE TABLE IF NOT EXISTS `wallets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `type_currency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_recharge` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wallets_cliente_id_foreign` (`cliente_id`),
  CONSTRAINT `wallets_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla apuestatotal.wallets: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` (`id`, `total`, `type_currency`, `state`, `last_recharge`, `created_at`, `updated_at`, `cliente_id`) VALUES
	(1, 140.00, 'S/', '1', '2022-05-05', '2022-05-05 15:28:41', '2022-05-05 20:18:52', 1),
	(2, 10.00, 'S/', '1', '2022-05-05', '2022-05-05 20:16:58', '2022-05-05 20:16:58', 2);
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
