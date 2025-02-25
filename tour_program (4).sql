-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 25 Şub 2025, 19:50:59
-- Sunucu sürümü: 8.0.41-0ubuntu0.24.04.1
-- PHP Sürümü: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `tour_program`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agencyguide`
--

CREATE TABLE `agencyguide` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `is_login` tinyint(1) NOT NULL,
  `guide_group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languages` json DEFAULT NULL,
  `other_languages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sifre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `agencyguide`
--

INSERT INTO `agencyguide` (`id`, `name`, `surname`, `is_active`, `is_login`, `guide_group`, `nickname`, `languages`, `other_languages`, `phone`, `code`, `sifre`, `company_id`, `created_at`, `updated_at`) VALUES
(338, 'Şahin', 'Yücel', 1, 1, 'yeniler', 'Guide', '{\"rusca\": false, \"arapca\": false, \"almanca\": false, \"fransizca\": false, \"ingilizce\": true}', '', '05052325082', 'E6XN7N87', '123123', 114, '2025-02-24 19:18:20', '2025-02-24 19:18:20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agencyprovider`
--

CREATE TABLE `agencyprovider` (
  `id` int NOT NULL,
  `companyRef` varchar(50) NOT NULL,
  `company_name` varchar(50) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `status` int NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `agencyprovider`
--

INSERT INTO `agencyprovider` (`id`, `companyRef`, `company_name`, `phone_number`, `status`, `company_id`) VALUES
(700, 'V9674F0D', 'bulent', '505 232 5040', 0, 114),
(701, 'ATXS0BWD', 'correct', '505 232 5082', 0, 114),
(702, 'M77AQ75O', 'paco', '53095171', 0, 114),
(703, 'YPT88YZI', 'oncu', '505 232 5082', 0, 114);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agencyrolemembers`
--

CREATE TABLE `agencyrolemembers` (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `agencyrolemembers`
--

INSERT INTO `agencyrolemembers` (`id`, `username`, `position`, `password`, `company_id`, `created_at`) VALUES
(124, 'admin', 'admin', '$2b$10$v9g5DxuCwucr7ERd0GmlRuP2b5gReLMK8bxZ5wNpEQFvG5tmeWVOC', 114, '2025-02-24 14:14:49'),
(125, 'yusuf', 'operasyon', '$2b$10$nvCH8mp3L.XGkOA8ybZ5pevjj.lICqiAeUwSb2xXoQlMGxgfRXfci', 114, '2025-02-24 15:00:36'),
(126, 'zemzem', 'muhasebe', '$2b$10$m4OJnb06iK6s0xKSXCp3ReHdOdC99I5CKl169aOUVFHyIeEZpTBNm', 114, '2025-02-24 15:02:49');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agency_guide_accounts`
--

CREATE TABLE `agency_guide_accounts` (
  `id` int NOT NULL,
  `guide_id` int NOT NULL,
  `earnings` decimal(10,2) DEFAULT '0.00',
  `promotion_rate` decimal(5,2) DEFAULT '0.00',
  `revenue` decimal(10,2) DEFAULT '0.00',
  `pax_adult` int DEFAULT '0',
  `pax_child` int DEFAULT '0',
  `pax_free` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `agency_guide_accounts`
--

INSERT INTO `agency_guide_accounts` (`id`, `guide_id`, `earnings`, `promotion_rate`, `revenue`, `pax_adult`, `pax_child`, `pax_free`, `created_at`, `updated_at`) VALUES
(319, 338, 0.00, 40.00, 0.00, 0, 0, 0, '2025-02-24 19:18:20', '2025-02-24 19:18:20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `areaslist`
--

CREATE TABLE `areaslist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `region_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `areaslist`
--

INSERT INTO `areaslist` (`id`, `name`, `region_id`, `company_id`, `created_at`, `updated_at`) VALUES
(2743, 'MAHMUTLAR', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2744, 'OBA', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2745, 'ALANYA', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2746, 'KONAKLI', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2747, 'TURKLER', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2748, 'AVSALLAR', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2749, 'OKURCALAR', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2750, 'CENGER', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2751, 'KIZILOT', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2752, 'KIZILAGAC', 876, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2753, 'COLAKLI', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2754, 'KUMKOY', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2755, 'EVRENSEKI', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2756, 'GUNDOGMUS', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2757, 'TITREYENGOL', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2758, 'SORGUN', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2759, 'KIZILOT-S', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2760, 'KIZILAGAC-S', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(2761, 'SIDE', 877, 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `companyusers`
--

CREATE TABLE `companyusers` (
  `id` int NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `position` varchar(50) NOT NULL,
  `ref_code` varchar(50) NOT NULL,
  `company_user` varchar(100) NOT NULL,
  `company_pass` varchar(100) NOT NULL,
  `duration_use` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `verification` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `companyusers`
--

INSERT INTO `companyusers` (`id`, `company_name`, `position`, `ref_code`, `company_user`, `company_pass`, `duration_use`, `created_at`, `verification`) VALUES
(114, 'maxtoria', 'Agency', 'MAX5378', 'maxtoria', '$2b$10$rNNgpELIraJ1Sbu3ymz8QOk.7fyGqChZgCK9pJ2hE1l5TPPYyQFWe', '1', '2025-02-24 14:13:49', 'R2CWCP'),
(115, 'w2meet', 'Agency', 'W2M4657', 'w2meet', '$2b$10$hF0TADP1sYGfV3TSTwTXuux/yJMsZRDiR/ARqDGLAVV0u3qzSv08m', '1', '2025-02-24 14:13:57', 'WPRG20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `create_areaslist`
--

CREATE TABLE `create_areaslist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `create_areaslist`
--

INSERT INTO `create_areaslist` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(1445, 'ALANYA', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1446, 'SIDE', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1447, 'ANTALYA', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guide_regions`
--

CREATE TABLE `guide_regions` (
  `id` int NOT NULL,
  `guide_id` int NOT NULL,
  `company_id` int NOT NULL,
  `region_name` varchar(255) NOT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `guide_regions`
--

INSERT INTO `guide_regions` (`id`, `guide_id`, `company_id`, `region_name`, `CREATED_AT`) VALUES
(460, 338, 114, 'ALANYA', '2025-02-24 19:18:20'),
(461, 338, 114, 'SIDE', '2025-02-24 19:18:20'),
(462, 338, 114, 'ANTALYA', '2025-02-24 19:18:20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `main_tours`
--

CREATE TABLE `main_tours` (
  `id` int NOT NULL,
  `company_ref` varchar(255) NOT NULL,
  `tour_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `main_tours`
--

INSERT INTO `main_tours` (`id`, `company_ref`, `tour_name`, `created_at`, `updated_at`) VALUES
(1223, '114', 'BUGGY-QUAD-AVSALLAR', '2025-02-25 19:49:07', '2025-02-25 19:49:07'),
(1224, '114', 'BUGGY-QUAD', '2025-02-25 19:49:07', '2025-02-25 19:49:07'),
(1225, '114', 'ANTALYA-CITY-TOUR', '2025-02-25 19:49:07', '2025-02-25 19:49:07'),
(1226, '114', 'PINK-PANTER', '2025-02-25 19:49:07', '2025-02-25 19:49:07');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `regionslist`
--

CREATE TABLE `regionslist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `regionslist`
--

INSERT INTO `regionslist` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(876, 'ALANYA', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(877, 'SIDE', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int NOT NULL,
  `company_id` int NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `page_id` varchar(50) NOT NULL,
  `has_permission` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `company_id`, `role_name`, `page_id`, `has_permission`, `created_at`, `updated_at`) VALUES
(18893, 114, 'muhasebe', 'dashboard', 1, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18894, 114, 'muhasebe', 'definitions', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18895, 114, 'muhasebe', 'companies', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18896, 114, 'muhasebe', 'guides', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18897, 114, 'muhasebe', 'create-tour', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18898, 114, 'muhasebe', 'tour-lists', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18899, 114, 'muhasebe', 'reservations', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18900, 114, 'muhasebe', 'reports', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18901, 114, 'muhasebe', 'safe', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18902, 114, 'muhasebe', 'safe-management', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18903, 114, 'muhasebe', 'safe-collection', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18904, 114, 'muhasebe', 'backup', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18905, 114, 'muhasebe', 'settings', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18906, 114, 'operasyon', 'dashboard', 1, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18907, 114, 'operasyon', 'definitions', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18908, 114, 'operasyon', 'companies', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18909, 114, 'operasyon', 'guides', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18910, 114, 'operasyon', 'create-tour', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18911, 114, 'operasyon', 'tour-lists', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18912, 114, 'operasyon', 'reservations', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18913, 114, 'operasyon', 'reports', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18914, 114, 'operasyon', 'safe', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18915, 114, 'operasyon', 'safe-management', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18916, 114, 'operasyon', 'safe-collection', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18917, 114, 'operasyon', 'backup', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02'),
(18918, 114, 'operasyon', 'settings', 0, '2025-02-24 17:25:02', '2025-02-24 17:25:02');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `safe`
--

CREATE TABLE `safe` (
  `id` int NOT NULL,
  `company_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('cash','pos') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pos_commission_rate` decimal(5,2) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `safe`
--

INSERT INTO `safe` (`id`, `company_id`, `name`, `type`, `pos_commission_rate`, `balance`, `created_at`, `updated_at`) VALUES
(20, 114, 'TL', 'cash', NULL, 0.00, '2025-02-24 14:15:42', '2025-02-24 14:15:42');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sub_tours`
--

CREATE TABLE `sub_tours` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `tour_id` int NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `sub_tours`
--

INSERT INTO `sub_tours` (`id`, `name`, `tour_id`, `company_id`) VALUES
(1979, 'BUGGY-DBL-BLT', 1971, 114),
(1980, 'BUGGY-SNL-BLT', 1971, 114),
(1981, 'QUAD-DBL-BLT', 1971, 114),
(1982, 'QUAD-SNL-BLT', 1971, 114),
(1983, 'BUGGY-DBL-FCS', 1972, 114),
(1984, 'BUGGY-SNL-FCS', 1972, 114),
(1985, 'QUAD-QUAD-FCS', 1972, 114),
(1986, 'QUAD-SNL-FCS', 1972, 114),
(1987, 'BUGGY-DBL-CRT', 1973, 114),
(1988, 'BUGGY-SNL-CRT', 1973, 114),
(1989, 'QUAD-DBL-CRT', 1973, 114),
(1990, 'QUAD-SNL-CRT', 1973, 114),
(1991, 'ANTALYA-CRT-SD', 1974, 114),
(1992, 'ANTALYA-PC', 1974, 114),
(1993, 'ANTALYA-ONC', 1974, 114),
(1994, 'PINK-PANTER', 1975, 114),
(1995, 'PINK-PANTER-ALY', 1975, 114);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tourlist`
--

CREATE TABLE `tourlist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `tourlist`
--

INSERT INTO `tourlist` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(1971, 'BUGGY-QUAD-AVSALLAR', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1972, 'BUGGY-QUAD-ALANYA', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1973, 'BUGGY-QUAD', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1974, 'ANTALYA-CITY-TOUR', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58'),
(1975, 'PINK-PANTER', 114, '2025-02-24 19:16:58', '2025-02-24 19:16:58');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tours`
--

CREATE TABLE `tours` (
  `id` int NOT NULL,
  `company_ref` int NOT NULL,
  `tour_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adult_price` decimal(10,2) DEFAULT '0.00',
  `guide_adult_price` decimal(10,2) DEFAULT '0.00',
  `child_price` decimal(10,2) DEFAULT '0.00',
  `guide_child_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `priority` int DEFAULT '3',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'EUR',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `main_tour_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tours`
--

INSERT INTO `tours` (`id`, `company_ref`, `tour_name`, `operator`, `operator_id`, `adult_price`, `guide_adult_price`, `child_price`, `guide_child_price`, `is_active`, `created_at`, `updated_at`, `priority`, `description`, `currency`, `start_date`, `end_date`, `main_tour_id`) VALUES
(5757, 114, 'BUGGY-DBL-BLT', 'bulent', 'V9674F0D', 30.00, 30.00, 30.00, 30.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, '', 'EUR', NULL, NULL, 1223),
(5758, 114, 'BUGGY-SNL-BLT', 'bulent', 'V9674F0D', 30.00, 30.00, 30.00, 30.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, '', 'EUR', NULL, NULL, 1223),
(5759, 114, 'BUGGY-DBL-CRT', 'correct', 'ATXS0BWD', 30.00, 30.00, 30.00, 30.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, '', 'EUR', NULL, NULL, 1224),
(5760, 114, 'ANTALYA-CRT-SD', 'correct', 'ATXS0BWD', 25.00, 30.00, 15.00, 20.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, 'yemek şelale bot', 'EUR', NULL, NULL, 1225),
(5761, 114, 'ANTALYA-ONC', 'oncu', 'YPT88YZI', 25.00, 30.00, 15.00, 20.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, 'yemek şelale bot. Su ekstra', 'EUR', NULL, NULL, 1225),
(5762, 114, 'PINK-PANTER', 'oncu', 'YPT88YZI', 25.00, 30.00, 15.00, 20.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, 'yemek şelale bot', 'EUR', NULL, NULL, 1226),
(5763, 114, 'PINK-PANTER-ALY', 'oncu', 'YPT88YZI', 25.00, 30.00, 15.00, 20.00, 1, '2025-02-25 19:49:07', '2025-02-25 19:49:07', 0, 'yemek şelale bot', 'EUR', NULL, NULL, 1226);

--
-- Tetikleyiciler `tours`
--
DELIMITER $$
CREATE TRIGGER `delete_main_tour_after_tour_delete` AFTER DELETE ON `tours` FOR EACH ROW BEGIN
    DELETE FROM main_tours
    WHERE id = OLD.main_tour_id
    AND NOT EXISTS (
        SELECT 1 FROM tours WHERE main_tour_id = OLD.main_tour_id
    )$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_days`
--

CREATE TABLE `tour_days` (
  `id` int NOT NULL,
  `tour_id` int NOT NULL,
  `day_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `tour_days`
--

INSERT INTO `tour_days` (`id`, `tour_id`, `day_number`, `created_at`) VALUES
(40075, 5757, 1, '2025-02-25 19:49:07'),
(40076, 5757, 0, '2025-02-25 19:49:07'),
(40077, 5757, 3, '2025-02-25 19:49:07'),
(40078, 5757, 0, '2025-02-25 19:49:07'),
(40079, 5757, 5, '2025-02-25 19:49:07'),
(40080, 5757, 0, '2025-02-25 19:49:07'),
(40081, 5757, 7, '2025-02-25 19:49:07'),
(40082, 5758, 1, '2025-02-25 19:49:07'),
(40083, 5758, 0, '2025-02-25 19:49:07'),
(40084, 5758, 3, '2025-02-25 19:49:07'),
(40085, 5758, 0, '2025-02-25 19:49:07'),
(40086, 5758, 5, '2025-02-25 19:49:07'),
(40087, 5758, 0, '2025-02-25 19:49:07'),
(40088, 5758, 7, '2025-02-25 19:49:07'),
(40089, 5759, 1, '2025-02-25 19:49:07'),
(40090, 5759, 0, '2025-02-25 19:49:07'),
(40091, 5759, 3, '2025-02-25 19:49:07'),
(40092, 5759, 0, '2025-02-25 19:49:07'),
(40093, 5759, 5, '2025-02-25 19:49:07'),
(40094, 5759, 0, '2025-02-25 19:49:07'),
(40095, 5759, 7, '2025-02-25 19:49:07'),
(40096, 5760, 0, '2025-02-25 19:49:07'),
(40097, 5760, 2, '2025-02-25 19:49:07'),
(40098, 5760, 0, '2025-02-25 19:49:07'),
(40099, 5760, 4, '2025-02-25 19:49:07'),
(40100, 5760, 0, '2025-02-25 19:49:07'),
(40101, 5760, 6, '2025-02-25 19:49:07'),
(40102, 5760, 0, '2025-02-25 19:49:07'),
(40103, 5761, 1, '2025-02-25 19:49:07'),
(40104, 5761, 2, '2025-02-25 19:49:07'),
(40105, 5761, 3, '2025-02-25 19:49:07'),
(40106, 5761, 4, '2025-02-25 19:49:07'),
(40107, 5761, 5, '2025-02-25 19:49:07'),
(40108, 5761, 6, '2025-02-25 19:49:07'),
(40109, 5761, 7, '2025-02-25 19:49:07'),
(40110, 5762, 1, '2025-02-25 19:49:07'),
(40111, 5762, 2, '2025-02-25 19:49:07'),
(40112, 5762, 0, '2025-02-25 19:49:07'),
(40113, 5762, 4, '2025-02-25 19:49:07'),
(40114, 5762, 0, '2025-02-25 19:49:07'),
(40115, 5762, 6, '2025-02-25 19:49:07'),
(40116, 5762, 0, '2025-02-25 19:49:07'),
(40117, 5763, 1, '2025-02-25 19:49:07'),
(40118, 5763, 0, '2025-02-25 19:49:07'),
(40119, 5763, 3, '2025-02-25 19:49:07'),
(40120, 5763, 0, '2025-02-25 19:49:07'),
(40121, 5763, 5, '2025-02-25 19:49:07'),
(40122, 5763, 0, '2025-02-25 19:49:07'),
(40123, 5763, 0, '2025-02-25 19:49:07');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_options`
--

CREATE TABLE `tour_options` (
  `id` int NOT NULL,
  `tour_id` int NOT NULL,
  `option_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_options`
--

INSERT INTO `tour_options` (`id`, `tour_id`, `option_name`, `price`, `created_at`) VALUES
(1492, 5760, 'waterfall', 3.00, '2025-02-25 19:49:07'),
(1493, 5760, 'cave', 2.00, '2025-02-25 19:49:07'),
(1494, 5761, 'waterfall', 1.00, '2025-02-25 19:49:07'),
(1495, 5761, 'cave', 5.00, '2025-02-25 19:49:07'),
(1496, 5762, 'waterfall', 1.00, '2025-02-25 19:49:07'),
(1497, 5763, 'waterfall', 1.00, '2025-02-25 19:49:07');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_pickup_times`
--

CREATE TABLE `tour_pickup_times` (
  `id` int NOT NULL,
  `tour_id` int NOT NULL,
  `hour` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minute` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_active` tinyint(1) DEFAULT '0',
  `period` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `start_pickup_date` date DEFAULT NULL,
  `end_pickup_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_pickup_times`
--

INSERT INTO `tour_pickup_times` (`id`, `tour_id`, `hour`, `minute`, `region`, `area`, `period_active`, `period`, `company_id`, `created_at`, `start_pickup_date`, `end_pickup_date`) VALUES
(21954, 5757, '07', '30', 'ALANYA', 'MAHMUTLAR', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21955, 5757, '12', '52', 'ALANYA', 'MAHMUTLAR', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21956, 5757, '08', '20', 'ALANYA', 'ALANYA', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21957, 5757, '13', '20', 'ALANYA', 'ALANYA', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21958, 5757, '15', '32', 'ALANYA', 'ALANYA', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21959, 5757, '08', '45', 'ALANYA', 'KONAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21960, 5757, '13', '45', 'ALANYA', 'KONAKLI', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21961, 5757, '15', '52', 'ALANYA', 'KONAKLI', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21962, 5757, '09', '00', 'ALANYA', 'TURKLER', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21963, 5757, '14', '00', 'ALANYA', 'TURKLER', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21964, 5757, '16', '17', 'ALANYA', 'TURKLER', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21965, 5757, '08', '30', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21966, 5758, '07', '30', 'ALANYA', 'MAHMUTLAR', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21967, 5758, '12', '52', 'ALANYA', 'MAHMUTLAR', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21968, 5758, '08', '20', 'ALANYA', 'ALANYA', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21969, 5758, '13', '20', 'ALANYA', 'ALANYA', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21970, 5758, '15', '32', 'ALANYA', 'ALANYA', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21971, 5758, '08', '45', 'ALANYA', 'KONAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21972, 5758, '13', '45', 'ALANYA', 'KONAKLI', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21973, 5758, '15', '52', 'ALANYA', 'KONAKLI', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21974, 5759, '07', '30', 'ALANYA', 'MAHMUTLAR', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21975, 5759, '12', '52', 'ALANYA', 'MAHMUTLAR', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21976, 5759, '08', '20', 'ALANYA', 'ALANYA', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21977, 5759, '13', '20', 'ALANYA', 'ALANYA', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21978, 5759, '15', '32', 'ALANYA', 'ALANYA', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21979, 5759, '08', '45', 'ALANYA', 'KONAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21980, 5759, '13', '45', 'ALANYA', 'KONAKLI', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21981, 5759, '15', '52', 'ALANYA', 'KONAKLI', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21982, 5759, '09', '00', 'ALANYA', 'TURKLER', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21983, 5759, '14', '00', 'ALANYA', 'TURKLER', 1, '2', 114, '2025-02-25 19:49:07', NULL, NULL),
(21984, 5759, '16', '17', 'ALANYA', 'TURKLER', 1, '3', 114, '2025-02-25 19:49:07', NULL, NULL),
(21985, 5760, '11', '35', 'SIDE', 'KIZILOT-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21986, 5760, '11', '50', 'SIDE', 'KIZILAGAC-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21987, 5760, '13', '00', 'SIDE', 'GUNDOGMUS', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21988, 5760, '12', '45', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21989, 5760, '12', '40', 'SIDE', 'EVRENSEKI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21990, 5760, '12', '30', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21991, 5760, '12', '00', 'SIDE', 'TITREYENGOL', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21992, 5760, '12', '15', 'SIDE', 'SIDE', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21993, 5760, '12', '00', 'SIDE', 'SORGUN', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21994, 5761, '11', '35', 'SIDE', 'KIZILOT-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21995, 5761, '11', '50', 'SIDE', 'KIZILAGAC-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21996, 5761, '13', '00', 'SIDE', 'GUNDOGMUS', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21997, 5761, '12', '45', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21998, 5761, '12', '40', 'SIDE', 'EVRENSEKI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(21999, 5761, '12', '30', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22000, 5761, '12', '00', 'SIDE', 'TITREYENGOL', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22001, 5761, '12', '15', 'SIDE', 'SIDE', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22002, 5761, '12', '00', 'SIDE', 'SORGUN', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22003, 5762, '11', '35', 'SIDE', 'KIZILOT-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22004, 5762, '11', '50', 'SIDE', 'KIZILAGAC-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22005, 5762, '13', '00', 'SIDE', 'GUNDOGMUS', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22006, 5762, '12', '45', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22007, 5762, '12', '40', 'SIDE', 'EVRENSEKI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22008, 5762, '12', '30', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22009, 5762, '12', '00', 'SIDE', 'TITREYENGOL', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22010, 5762, '12', '15', 'SIDE', 'SIDE', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22011, 5762, '12', '00', 'SIDE', 'SORGUN', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22012, 5763, '11', '35', 'SIDE', 'KIZILOT-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22013, 5763, '11', '50', 'SIDE', 'KIZILAGAC-S', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22014, 5763, '13', '00', 'SIDE', 'GUNDOGMUS', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22015, 5763, '12', '45', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22016, 5763, '12', '40', 'SIDE', 'EVRENSEKI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22017, 5763, '12', '30', 'SIDE', 'COLAKLI', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22018, 5763, '12', '00', 'SIDE', 'TITREYENGOL', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22019, 5763, '12', '15', 'SIDE', 'SIDE', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL),
(22020, 5763, '12', '00', 'SIDE', 'SORGUN', 1, '1', 114, '2025-02-25 19:49:07', NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_regions`
--

CREATE TABLE `tour_regions` (
  `tour_id` int NOT NULL,
  `company_id` int NOT NULL,
  `region_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `tour_regions`
--

INSERT INTO `tour_regions` (`tour_id`, `company_id`, `region_name`) VALUES
(5757, 114, 'ALANYA'),
(5758, 114, 'ALANYA'),
(5759, 114, 'SIDE'),
(5760, 114, 'ANTALYA'),
(5761, 114, 'ALANYA'),
(5762, 114, 'ALANYA'),
(5762, 114, 'SIDE'),
(5763, 114, 'ALANYA'),
(5763, 114, 'SIDE');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(34, 'sahin', 'sahinyucel@yandex.com', '$2b$10$HxPEFsFq.6VPFSkBZ3dNXu2Z45R1BLtqLT.UNN5bfO4StdQFD78om');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `agencyguide`
--
ALTER TABLE `agencyguide`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company` (`company_id`);

--
-- Tablo için indeksler `agencyprovider`
--
ALTER TABLE `agencyprovider`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `idx_companyRef` (`companyRef`) USING BTREE;

--
-- Tablo için indeksler `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `agency_guide_accounts`
--
ALTER TABLE `agency_guide_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_guide` (`guide_id`);

--
-- Tablo için indeksler `areaslist`
--
ALTER TABLE `areaslist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `companyusers`
--
ALTER TABLE `companyusers`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `create_areaslist`
--
ALTER TABLE `create_areaslist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `create_areaslist_1` (`company_id`);

--
-- Tablo için indeksler `guide_regions`
--
ALTER TABLE `guide_regions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guide_id` (`guide_id`);

--
-- Tablo için indeksler `main_tours`
--
ALTER TABLE `main_tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_tour` (`company_ref`,`tour_name`);

--
-- Tablo için indeksler `regionslist`
--
ALTER TABLE `regionslist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_permission` (`company_id`,`role_name`,`page_id`);

--
-- Tablo için indeksler `safe`
--
ALTER TABLE `safe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company` (`company_id`);

--
-- Tablo için indeksler `sub_tours`
--
ALTER TABLE `sub_tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tour_id` (`tour_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `tourlist`
--
ALTER TABLE `tourlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_company_ref` (`company_ref`),
  ADD KEY `idx_operator_id` (`operator_id`),
  ADD KEY `fk_main_tour` (`main_tour_id`);

--
-- Tablo için indeksler `tour_days`
--
ALTER TABLE `tour_days`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tour_id` (`tour_id`);

--
-- Tablo için indeksler `tour_options`
--
ALTER TABLE `tour_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tour_id` (`tour_id`);

--
-- Tablo için indeksler `tour_pickup_times`
--
ALTER TABLE `tour_pickup_times`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tour_id` (`tour_id`),
  ADD KEY `fk_pickup_times_company` (`company_id`);

--
-- Tablo için indeksler `tour_regions`
--
ALTER TABLE `tour_regions`
  ADD PRIMARY KEY (`tour_id`,`region_name`) USING BTREE;

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `agencyguide`
--
ALTER TABLE `agencyguide`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- Tablo için AUTO_INCREMENT değeri `agencyprovider`
--
ALTER TABLE `agencyprovider`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=704;

--
-- Tablo için AUTO_INCREMENT değeri `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- Tablo için AUTO_INCREMENT değeri `agency_guide_accounts`
--
ALTER TABLE `agency_guide_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- Tablo için AUTO_INCREMENT değeri `areaslist`
--
ALTER TABLE `areaslist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2762;

--
-- Tablo için AUTO_INCREMENT değeri `companyusers`
--
ALTER TABLE `companyusers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- Tablo için AUTO_INCREMENT değeri `create_areaslist`
--
ALTER TABLE `create_areaslist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1448;

--
-- Tablo için AUTO_INCREMENT değeri `guide_regions`
--
ALTER TABLE `guide_regions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=463;

--
-- Tablo için AUTO_INCREMENT değeri `main_tours`
--
ALTER TABLE `main_tours`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1227;

--
-- Tablo için AUTO_INCREMENT değeri `regionslist`
--
ALTER TABLE `regionslist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=878;

--
-- Tablo için AUTO_INCREMENT değeri `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18919;

--
-- Tablo için AUTO_INCREMENT değeri `safe`
--
ALTER TABLE `safe`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Tablo için AUTO_INCREMENT değeri `sub_tours`
--
ALTER TABLE `sub_tours`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1996;

--
-- Tablo için AUTO_INCREMENT değeri `tourlist`
--
ALTER TABLE `tourlist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1976;

--
-- Tablo için AUTO_INCREMENT değeri `tours`
--
ALTER TABLE `tours`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5764;

--
-- Tablo için AUTO_INCREMENT değeri `tour_days`
--
ALTER TABLE `tour_days`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40124;

--
-- Tablo için AUTO_INCREMENT değeri `tour_options`
--
ALTER TABLE `tour_options`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1498;

--
-- Tablo için AUTO_INCREMENT değeri `tour_pickup_times`
--
ALTER TABLE `tour_pickup_times`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22021;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `agencyguide`
--
ALTER TABLE `agencyguide`
  ADD CONSTRAINT `agencyguide_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `agencyprovider`
--
ALTER TABLE `agencyprovider`
  ADD CONSTRAINT `agencyprovidertour` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  ADD CONSTRAINT `agencyrolemembers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`);

--
-- Tablo kısıtlamaları `agency_guide_accounts`
--
ALTER TABLE `agency_guide_accounts`
  ADD CONSTRAINT `agency_guide_accounts_ibfk_1` FOREIGN KEY (`guide_id`) REFERENCES `agencyguide` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `areaslist`
--
ALTER TABLE `areaslist`
  ADD CONSTRAINT `areaslist_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regionslist` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `areaslist_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `create_areaslist`
--
ALTER TABLE `create_areaslist`
  ADD CONSTRAINT `create_areaslist_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `guide_regions`
--
ALTER TABLE `guide_regions`
  ADD CONSTRAINT `guide_regions_ibfk_1` FOREIGN KEY (`guide_id`) REFERENCES `agencyguide` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `regionslist`
--
ALTER TABLE `regionslist`
  ADD CONSTRAINT `regionlist1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`);

--
-- Tablo kısıtlamaları `safe`
--
ALTER TABLE `safe`
  ADD CONSTRAINT `safe_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `sub_tours`
--
ALTER TABLE `sub_tours`
  ADD CONSTRAINT `sub_tours_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tourlist` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_tours_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tourlist`
--
ALTER TABLE `tourlist`
  ADD CONSTRAINT `tourlist_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `fk_main_tour` FOREIGN KEY (`main_tour_id`) REFERENCES `main_tours` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `tourlist_ibfk_2` FOREIGN KEY (`company_ref`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tour_days`
--
ALTER TABLE `tour_days`
  ADD CONSTRAINT `tour_days_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tour_options`
--
ALTER TABLE `tour_options`
  ADD CONSTRAINT `tour_options_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tour_pickup_times`
--
ALTER TABLE `tour_pickup_times`
  ADD CONSTRAINT `tour_pickup_times_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tour_regions`
--
ALTER TABLE `tour_regions`
  ADD CONSTRAINT `tour_regions_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
