-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table podcast2.albums
CREATE TABLE IF NOT EXISTS `albums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_date` date NOT NULL,
  `artist_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68789 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.albums: ~0 rows (approximately)
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;

-- Dumping structure for table podcast2.album_likes
CREATE TABLE IF NOT EXISTS `album_likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `album_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.album_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `album_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_likes` ENABLE KEYS */;

-- Dumping structure for table podcast2.artists
CREATE TABLE IF NOT EXISTS `artists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `displayname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `available_disk_space` bigint(20) NOT NULL DEFAULT '500',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4797 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.artists: ~0 rows (approximately)
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;

-- Dumping structure for table podcast2.artist_follows
CREATE TABLE IF NOT EXISTS `artist_follows` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `artist_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.artist_follows: ~0 rows (approximately)
/*!40000 ALTER TABLE `artist_follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `artist_follows` ENABLE KEYS */;

-- Dumping structure for table podcast2.chats
CREATE TABLE IF NOT EXISTS `chats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL,
  `session_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `read_at` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.chats: ~0 rows (approximately)
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;

-- Dumping structure for table podcast2.episodes
CREATE TABLE IF NOT EXISTS `episodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` json NOT NULL,
  `download_count` bigint(20) NOT NULL DEFAULT '0',
  `source_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `podcast_id` int(11) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.episodes: ~0 rows (approximately)
/*!40000 ALTER TABLE `episodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `episodes` ENABLE KEYS */;

-- Dumping structure for table podcast2.episode_likes
CREATE TABLE IF NOT EXISTS `episode_likes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `episode_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.episode_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `episode_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_likes` ENABLE KEYS */;

-- Dumping structure for table podcast2.episode_plays
CREATE TABLE IF NOT EXISTS `episode_plays` (
  `episode_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.episode_plays: ~0 rows (approximately)
/*!40000 ALTER TABLE `episode_plays` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_plays` ENABLE KEYS */;

-- Dumping structure for table podcast2.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table podcast2.friendships
CREATE TABLE IF NOT EXISTS `friendships` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `friend_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `friendships_friend_id_index` (`friend_id`),
  KEY `friendships_user_id_index` (`user_id`),
  CONSTRAINT `friendships_friend_id_foreign` FOREIGN KEY (`friend_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `friendships_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.friendships: ~0 rows (approximately)
/*!40000 ALTER TABLE `friendships` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendships` ENABLE KEYS */;

-- Dumping structure for table podcast2.genres
CREATE TABLE IF NOT EXISTS `genres` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.genres: ~9 rows (approximately)
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` (`id`, `name`, `slug`, `cover`, `icon`, `created_at`, `updated_at`) VALUES
	(1, 'Electronic', 'electronic', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/electronic.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/dj.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(2, 'Gaming', 'gaming', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/gaming.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/controller.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(3, 'Piano', 'piano', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/piano.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/piano.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(4, 'Chill', 'chill', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/chill.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/relax.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(5, 'Jazz', 'jazz', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/jazz.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/horn.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(6, 'K Pop', 'k-pop', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/k-pop.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/headphone.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(7, 'Classical', 'classical', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/classical.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/guitar.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(8, 'Hip Hop', 'hip-hop', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/hip-hop.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/radio.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(9, 'Indie', 'indie', '{"path":"\\/storage\\/defaults\\/images\\/genres\\/indie.png","disk":"public","url":null}', '{"path":"\\/storage\\/defaults\\/icons\\/microphone.svg","disk":"public","url":null}', '2021-09-14 13:14:52', '2021-09-14 13:14:52');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;

-- Dumping structure for table podcast2.genre_podcast
CREATE TABLE IF NOT EXISTS `genre_podcast` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `podcast_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.genre_podcast: ~0 rows (approximately)
/*!40000 ALTER TABLE `genre_podcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `genre_podcast` ENABLE KEYS */;

-- Dumping structure for table podcast2.genre_song
CREATE TABLE IF NOT EXISTS `genre_song` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `song_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.genre_song: ~0 rows (approximately)
/*!40000 ALTER TABLE `genre_song` DISABLE KEYS */;
/*!40000 ALTER TABLE `genre_song` ENABLE KEYS */;

-- Dumping structure for table podcast2.home_sections
CREATE TABLE IF NOT EXISTS `home_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.home_sections: ~0 rows (approximately)
/*!40000 ALTER TABLE `home_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `home_sections` ENABLE KEYS */;

-- Dumping structure for table podcast2.languages
CREATE TABLE IF NOT EXISTS `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `flag` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeletable` tinyint(1) NOT NULL DEFAULT '1',
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `languages_locale_unique` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.languages: ~7 rows (approximately)
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` (`id`, `name`, `locale`, `status`, `flag`, `isDeletable`, `isDefault`, `created_at`, `updated_at`) VALUES
	(1, 'English', 'en', 1, 'usa', 0, 1, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(2, 'Español', 'es', -1, 'spain', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(3, 'Français', 'fr', -1, 'france', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(4, 'Deutsch', 'de', -1, 'germany', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(5, 'العربية', 'ar', -1, 'uae', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(6, 'हिंदी', 'hi', -1, 'india', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(7, 'Italiano', 'it', -1, 'italy', 0, 0, '2021-09-14 13:14:54', '2021-09-14 13:14:54');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;

-- Dumping structure for table podcast2.ltm_translations
CREATE TABLE IF NOT EXISTS `ltm_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_bin NOT NULL,
  `key` text COLLATE utf8mb4_bin NOT NULL,
  `value` text COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=720 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table podcast2.ltm_translations: ~719 rows (approximately)
/*!40000 ALTER TABLE `ltm_translations` DISABLE KEYS */;
INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
	(1, 1, 'en', '_json', 'Monetizing', 'Monetizing', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(2, 1, 'en', '_json', 'Content', 'Content', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(3, 1, 'en', '_json', 'Analytics', 'Analytics', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(4, 1, 'en', '_json', 'Translations', 'Translations', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(5, 1, 'en', '_json', 'Settings', 'Settings', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(6, 1, 'en', '_json', 'Members', 'Members', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(7, 1, 'en', '_json', 'Indie', 'Indie', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(8, 1, 'en', '_json', 'Hip Hop', 'Hip Hop', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(9, 1, 'en', '_json', 'Classical', 'Classical', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(10, 1, 'en', '_json', 'K Pop', 'K Pop', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(11, 1, 'en', '_json', 'Jazz', 'Jazz', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(12, 1, 'en', '_json', 'Chill', 'Chill', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(13, 1, 'en', '_json', 'Piano', 'Piano', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(14, 1, 'en', '_json', 'Gaming', 'Gaming', '2021-09-14 13:14:17', '2021-09-14 13:14:17'),
	(15, 1, 'en', '_json', 'Electronic', 'Electronic', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(16, 1, 'en', '_json', 'Charts', 'Charts', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(17, 1, 'en', '_json', 'Genres & Moods', 'Genres & Moods', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(18, 1, 'en', '_json', 'Explore and listen to various genres & moods', 'Explore and listen to various genres & moods', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(19, 1, 'en', '_json', 'Search', 'Search', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(20, 1, 'en', '_json', 'There is no content to be displayed', 'There is no content to be displayed', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(21, 1, 'en', '_json', 'No content!', 'No content!', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(22, 1, 'en', '_json', 'Friends', 'Friends', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(23, 1, 'en', '_json', 'Explore', 'Explore', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(24, 1, 'en', '_json', 'Explore & enjoy listening to music', 'Explore & enjoy listening to music', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(25, 1, 'en', '_json', 'Most played songs', 'Most played songs', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(26, 1, 'en', '_json', 'No data to show yet!', 'No data to show yet!', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(27, 1, 'en', '_json', 'Top Visiting Countries', 'Top Visiting Countries', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(28, 1, 'en', '_json', 'Interval', 'Interval', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(29, 1, 'en', '_json', 'Number of plays per interval', 'Number of plays per interval', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(30, 1, 'en', '_json', 'New this month', 'New this month', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(31, 1, 'en', '_json', 'Save Changes', 'Save Changes', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(32, 1, 'en', '_json', 'Appearance', 'Appearance', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(33, 1, 'en', '_json', 'Configuration', 'Configuration', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(34, 1, 'en', '_json', 'Podcast Genres', 'Podcast Genres', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(35, 1, 'en', '_json', 'Song Genres', 'Song Genres', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(36, 1, 'en', '_json', 'Podcasts', 'Podcasts', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(37, 1, 'en', '_json', 'Playlists', 'Playlists', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(38, 1, 'en', '_json', 'Songs', 'Songs', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(39, 1, 'en', '_json', 'Albums', 'Albums', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(40, 1, 'en', '_json', 'Pages', 'Pages', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(41, 1, 'en', '_json', 'Your credentials are incorrect. Please try again', 'Your credentials are incorrect. Please try again.', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(42, 1, 'en', '_json', 'Account already exists', 'Account already exists.', '2021-09-14 13:14:18', '2021-09-14 13:14:18'),
	(43, 1, 'en', '_json', 'Logged out successfully', 'Logged out successfully.', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(44, 1, 'en', '_json', 'Latest Podcasts', 'Latest Podcasts', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(45, 1, 'en', '_json', 'Popular Podcasts', 'Popular Podcasts', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(46, 1, 'en', '_json', 'Login', 'Login', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(47, 1, 'en', '_json', 'Logout', 'Logout', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(48, 1, 'en', '_json', 'Light Mode', 'Light Mode', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(49, 1, 'en', '_json', 'Dark Mode', 'Dark Mode', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(50, 1, 'en', '_json', 'Upgrade', 'Upgrade', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(51, 1, 'en', '_json', 'Friend Requests', 'Friend Requests', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(52, 1, 'en', '_json', 'New Releases', 'New Releases', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(53, 1, 'en', '_json', 'Plans', 'Plans', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(54, 1, 'en', '_json', 'Subscriptions', 'Subscriptions', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(55, 1, 'en', '_json', 'Advertisements', 'Advertisements', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(56, 1, 'en', '_json', 'New Translation', 'New Translation', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(57, 1, 'en', '_json', 'Add', 'Add', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(58, 1, 'en', '_json', 'Top', 'Top', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(59, 1, 'en', '_json', 'Artists', 'Artists', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(60, 1, 'en', '_json', 'Users', 'Users', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(61, 1, 'en', '_json', 'Roles', 'Roles', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(62, 1, 'en', '_json', 'Last Year', 'Last Year', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(63, 1, 'en', '_json', 'Last Month', 'Last Month', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(64, 1, 'en', '_json', 'Last 7 days', 'Last 7 days', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(65, 1, 'en', '_json', 'Popular', 'Popular', '2021-09-14 13:14:19', '2021-09-14 13:14:19'),
	(66, 1, 'en', '_json', 'Top Visiting Browsers', 'Top Visiting Browsers', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(67, 1, 'en', '_json', 'Queue', 'Queue', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(68, 1, 'en', '_json', 'Download', 'Download', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(69, 1, 'en', '_json', 'Play Speed', 'Play Speed', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(70, 1, 'en', '_json', 'Next', 'Next', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(71, 1, 'en', '_json', 'Pause', 'Pause', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(72, 1, 'en', '_json', 'Rewind', 'Rewind', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(73, 1, 'en', '_json', 'Previous', 'Previous', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(74, 1, 'en', '_json', 'Shuffle', 'Shuffle', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(75, 1, 'en', '_json', 'Loop', 'Loop', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(76, 1, 'en', '_json', 'Play', 'Play', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(77, 1, 'en', '_json', 'Dislike', 'Dislike', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(78, 1, 'en', '_json', 'No', 'No', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(79, 1, 'en', '_json', 'Yes', 'Yes', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(80, 1, 'en', '_json', 'podcast', 'podcast', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(81, 1, 'en', '_json', 'episode', 'episode', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(82, 1, 'en', '_json', 'album', 'album', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(83, 1, 'en', '_json', 'Listening to', 'Listening to', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(84, 1, 'en', '_json', 'from', 'from', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(85, 1, 'en', '_json', 'by', 'by', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(86, 1, 'en', '_json', 'Are you sure you wanna be a friend with', 'Are you sure you wanna be a friend with', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(87, 1, 'en', '_json', 'You seem to be having no friends. Add some!', 'You seem to be having no friends. Add some!', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(88, 1, 'en', '_json', 'No Friends!', 'No Friends!', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(89, 1, 'en', '_json', 'Unfriend', 'Unfriend', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(90, 1, 'en', '_json', 'Listen', 'Listen', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(91, 1, 'en', '_json', 'Chat', 'Chat', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(92, 1, 'en', '_json', 'Profile', 'Profile', '2021-09-14 13:14:20', '2021-09-14 13:14:20'),
	(93, 1, 'en', '_json', 'Are you sure you wanna block', 'Are you sure you wanna block', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(94, 1, 'en', '_json', 'Block', 'Block', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(95, 1, 'en', '_json', 'Cancel', 'Cancel', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(96, 1, 'en', '_json', 'Seen', 'Seen', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(97, 1, 'en', '_json', 'Unblock', 'Unblock', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(98, 1, 'en', '_json', 'You can no longer chat with this person.', 'You can no longer chat with this person.', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(99, 1, 'en', '_json', 'Just Now', 'Just Now', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(100, 1, 'en', '_json', 'Sign Up', 'Sign Up', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(101, 1, 'en', '_json', 'Name', 'Name', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(102, 1, 'en', '_json', 'Password', 'Password', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(103, 1, 'en', '_json', 'Reset your password', 'Reset your password', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(104, 1, 'en', '_json', 'Enter your login email', 'Enter your login email', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(105, 1, 'en', '_json', 'Login to your account', 'Login to your account', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(106, 1, 'en', '_json', 'Remember you password?', 'Remember you password?', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(107, 1, 'en', '_json', 'Email', 'Email', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(108, 1, 'en', '_json', 'Logging in...', 'Logging in...', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(109, 1, 'en', '_json', 'Password does not match!', 'Password does not match!', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(110, 1, 'en', '_json', 'Please enter a valid email.', 'Please enter a valid email.', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(111, 1, 'en', '_json', 'Min 6 characters.', 'Min 6 characters.', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(112, 1, 'en', '_json', 'Required.', 'Required.', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(113, 1, 'en', '_json', 'Confirm Password', 'Confirm Password', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(114, 1, 'en', '_json', 'At least 6 characters', 'At least 6 characters', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(115, 1, 'en', '_json', 'Create An Account', 'Create An Account', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(116, 1, 'en', '_json', 'Forgot your password?', 'Forgot your password?', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(117, 1, 'en', '_json', 'Open New Account', 'Open New Account', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(118, 1, 'en', '_json', 'Complete Sign Up', 'Complete Sign Up', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(119, 1, 'en', '_json', 'Or', 'Or', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(120, 1, 'en', '_json', 'Account created successfully. You can login now.', 'Account created successfully. You can login now.', '2021-09-14 13:14:21', '2021-09-14 13:14:21'),
	(121, 1, 'en', '_json', 'Already have an account?', 'Already have an account?', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(122, 1, 'en', '_json', 'Sign In', 'Sign In', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(123, 1, 'en', '_json', 'You do not have an account yet?', 'You do not have an account yet?', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(124, 1, 'en', '_json', 'Password reset successfully. Redirecting to login...', 'Password reset successfully. Redirecting to login...', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(125, 1, 'en', '_json', 'Reset', 'Reset', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(126, 1, 'en', '_json', 'Private', 'Private', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(127, 1, 'en', '_json', 'Public', 'Public', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(128, 1, 'en', '_json', 'Playlist Name', 'Playlist Name', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(129, 1, 'en', '_json', 'Edit Playlist', 'Edit Playlist', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(130, 1, 'en', '_json', 'Pick', 'Pick', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(131, 1, 'en', '_json', 'Crop Image', 'Crop Image', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(132, 1, 'en', '_json', 'Create Playlist', 'Create Playlist', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(133, 1, 'en', '_json', 'Create', 'Create', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(134, 1, 'en', '_json', 'Start typing to search', 'Start typing to search', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(135, 1, 'en', '_json', 'Search Song', 'Search Song', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(136, 1, 'en', '_json', 'No playlists!', 'No playlists!', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(137, 1, 'en', '_json', 'New Playlist', 'New Playlist', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(138, 1, 'en', '_json', 'Choose Playlist', 'Choose Playlist', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(139, 1, 'en', '_json', 'updated successfully!', 'updated successfully!', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(140, 1, 'en', '_json', 'Song Deleted!', 'Song Deleted!', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(141, 1, 'en', '_json', 'Are you sure you wanna delete this song?', 'Are you sure you wanna delete this song?', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(142, 1, 'en', '_json', 'Delete', 'Delete', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(143, 1, 'en', '_json', 'Make Private', 'Make Private', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(144, 1, 'en', '_json', 'Make Public', 'Make Public', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(145, 1, 'en', '_json', 'Title', 'Title', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(146, 1, 'en', '_json', 'Are you sure you wanna make this song private? This means that it\'s gonna be visible only for you.', 'Are you sure you wanna make this song private? This means that it\'s gonna be visible only for you.', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(147, 1, 'en', '_json', 'Are you sure you wanna make this song public? This means that it\'s gonna be visible on your profile.', 'Are you sure you wanna make this song public? This means that it\'s gonna be visible on your profile.', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(148, 1, 'en', '_json', 'has been removed from playlist successfully!', 'has been removed from playlist successfully!', '2021-09-14 13:14:22', '2021-09-14 13:14:22'),
	(149, 1, 'en', '_json', 'Are you sure you wanna remove this song from this playlist?', 'Are you sure you wanna remove this song from this playlist?', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(150, 1, 'en', '_json', 'Remove song from playlist', 'Remove song from playlist', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(151, 1, 'en', '_json', 'Song already exists on this playlist!', 'Song already exists on this playlist!', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(152, 1, 'en', '_json', 'Already There!', 'Already There!', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(153, 1, 'en', '_json', 'New', 'New', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(154, 1, 'en', '_json', 'There are no results found for this search keyword.', 'There are no results found for this search keyword.', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(155, 1, 'en', '_json', 'Logo Image', 'Logo Image', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(156, 1, 'en', '_json', 'Please choose an image', 'Please choose an image', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(157, 1, 'en', '_json', 'Image must be less then', 'Image must be less then', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(158, 1, 'en', '_json', 'Choose Image', 'Choose Image', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(159, 1, 'en', '_json', 'Latest Song', 'Latest Song', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(160, 1, 'en', '_json', 'By', 'By', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(161, 1, 'en', '_json', 'Empty!', 'Empty!', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(162, 1, 'en', '_json', 'This playlist has no songs.', 'This playlist has no songs.', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(163, 1, 'en', '_json', 'You need to copy the URL manually.', 'You need to copy the URL manually.', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(164, 1, 'en', '_json', 'Oops!', 'Oops!', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(165, 1, 'en', '_json', 'URL copied to clipboard.', 'URL copied to clipboard.', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(166, 1, 'en', '_json', 'Add To Playlist', 'Add To Playlist', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(167, 1, 'en', '_json', 'Add To Queue', 'Add To Queue', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(168, 1, 'en', '_json', 'Go To Artist', 'Go To Artist', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(169, 1, 'en', '_json', 'Share', 'Share', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(170, 1, 'en', '_json', 'Copy URL', 'Copy URL', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(171, 1, 'en', '_json', 'Copy to clipboard', 'Copy to clipboard', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(172, 1, 'en', '_json', 'Total Plays', 'Total Plays', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(173, 1, 'en', '_json', 'Followers', 'Followers', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(174, 1, 'en', '_json', 'Cover', 'Cover', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(175, 1, 'en', '_json', 'Plays', 'Plays', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(176, 1, 'en', '_json', 'Created At', 'Created At', '2021-09-14 13:14:23', '2021-09-14 13:14:23'),
	(177, 1, 'en', '_json', 'Likes', 'Likes', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(178, 1, 'en', '_json', 'Updated', 'Updated', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(179, 1, 'en', '_json', 'Created', 'Created', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(180, 1, 'en', '_json', 'Saved', 'Saved', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(181, 1, 'en', '_json', 'Deleted.', 'Deleted.', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(182, 1, 'en', '_json', 'Are you sure you wanna delete this', 'Are you sure you wanna delete this', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(183, 1, 'en', '_json', 'Fetching data...', 'Fetching data...', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(184, 1, 'en', '_json', 'Error', 'Error', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(185, 1, 'en', '_json', 'Success', 'Success', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(186, 1, 'en', '_json', 'Artist account', 'Artist account', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(187, 1, 'en', '_json', 'This name will be displayed on your profile.', 'This name will be displayed on your profile.', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(188, 1, 'en', '_json', 'Displayname', 'Displayname', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(189, 1, 'en', '_json', 'Lastname', 'Lastname', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(190, 1, 'en', '_json', 'This is a private information.', 'This is a private information.', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(191, 1, 'en', '_json', 'Firstname', 'Firstname', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(192, 1, 'en', '_json', 'Firstly, fill your information', 'Firstly, fill your information', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(193, 1, 'en', '_json', 'Welcome to your artist account', 'Welcome to your artist account', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(194, 1, 'en', '_json', 'Rank', 'Rank', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(195, 1, 'en', '_json', 'Empty Section', 'Empty Section', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(196, 1, 'en', '_json', 'No Data!', 'No Data!', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(197, 1, 'en', '_json', 'Use Default', 'Use Default', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(198, 1, 'en', '_json', 'Deleted', 'Deleted', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(199, 1, 'en', '_json', 'Operations', 'Operations', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(200, 1, 'en', '_json', 'Podcasts are disabled.', 'Podcasts are disabled.', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(201, 1, 'en', '_json', 'Edit Personal Information', 'Edit Personal Information', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(202, 1, 'en', '_json', 'Released At', 'Released At', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(203, 1, 'en', '_json', 'Personal Information', 'Personal Information', '2021-09-14 13:14:24', '2021-09-14 13:14:24'),
	(204, 1, 'en', '_json', 'Nothing New!', 'Nothing New!', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(205, 1, 'en', '_json', 'You do not have any new notifications.', 'You do not have any new notifications.', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(206, 1, 'en', '_json', 'Settings reset successfully!', 'Settings reset successfully!', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(207, 1, 'en', '_json', 'Are you sure you wanna reset to the default settings?', 'Are you sure you wanna reset to the default settings?', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(208, 1, 'en', '_json', 'You need to enter your Google OAuth client ID.', 'You need to enter your Google OAuth client ID.', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(209, 1, 'en', '_json', 'You need to add your Pusher credentials if you enable chatting.', 'You need to add your Pusher credentials if you enable chatting.', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(210, 1, 'en', '_json', 'Are you sure you wanna change to the current settings?', 'Are you sure you wanna change to the current settings?', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(211, 1, 'en', '_json', 'SEO', 'SEO', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(212, 1, 'en', '_json', 'Auth', 'Auth', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(213, 1, 'en', '_json', 'Storage', 'Storage', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(214, 1, 'en', '_json', 'Billing', 'Billing', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(215, 1, 'en', '_json', 'General', 'General', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(216, 1, 'en', '_json', 'Preview', 'Preview', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(217, 1, 'en', '_json', 'Positions', 'Positions', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(218, 1, 'en', '_json', 'Outlined', 'Outlined', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(219, 1, 'en', '_json', 'Must be a material design icon', 'Must be a material design icon', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(220, 1, 'en', '_json', 'Subscription Button', 'Subscription Button', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(221, 1, 'en', '_json', 'Images & Icons', 'Images & Icons', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(222, 1, 'en', '_json', 'Dark', 'Dark', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(223, 1, 'en', '_json', 'Light', 'Light', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(224, 1, 'en', '_json', 'Default Theme', 'Default Theme', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(225, 1, 'en', '_json', 'Home Page', 'Home Page', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(226, 1, 'en', '_json', 'Themes', 'Themes', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(227, 1, 'en', '_json', 'Navigation', 'Navigation', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(228, 1, 'en', '_json', 'Landing', 'Landing', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(229, 1, 'en', '_json', 'Call to action button', 'Call to action button', '2021-09-14 13:14:25', '2021-09-14 13:14:25'),
	(230, 1, 'en', '_json', 'Header Title', 'Header Title', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(231, 1, 'en', '_json', 'Header Subtitle', 'Header Subtitle', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(232, 1, 'en', '_json', 'Background Image', 'Background Image', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(233, 1, 'en', '_json', 'Change', 'Change', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(234, 1, 'en', '_json', 'Image', 'Image', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(235, 1, 'en', '_json', 'Show Contact Us form', 'Show Contact Us form', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(236, 1, 'en', '_json', 'Description', 'Description', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(237, 1, 'en', '_json', 'Footer Background', 'Footer Background', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(238, 1, 'en', '_json', 'Use a custom landing header', 'Use a custom landing header', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(239, 1, 'en', '_json', 'Use Muzzie\'s default landing header', 'Use Muzzie\'s default landing header', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(240, 1, 'en', '_json', 'Are you sure you wanna reset to default settings?', 'Are you sure you wanna reset to default settings?', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(241, 1, 'en', '_json', 'Sections', 'Sections', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(242, 1, 'en', '_json', 'Header', 'Header', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(243, 1, 'en', '_json', 'Footer', 'Footer', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(244, 1, 'en', '_json', 'Make sure to add your SMTP credentials in the Email settings.', 'Make sure to add your SMTP credentials in the Email settings.', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(245, 1, 'en', '_json', 'Background Layer Color', 'Background Layer Color', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(246, 1, 'en', '_json', 'Landing Page', 'Landing Page', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(247, 1, 'en', '_json', 'Enable Landing Page', 'Enable Landing Page', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(248, 1, 'en', '_json', 'The welcome page. Disable if you want the visitors to access the player directly.', 'The welcome page. Disable if you want the visitors to access the player directly.', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(249, 1, 'en', '_json', 'New Item', 'New Item', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(250, 1, 'en', '_json', 'This is the sidebar of the player. You can customize almost everything: Icon, text, and destination.', 'This is the sidebar of the player. You can customize almost everything: Icon, text, and destination.', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(251, 1, 'en', '_json', 'Sidebar', 'Sidebar', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(252, 1, 'en', '_json', 'Select Page', 'Select Page', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(253, 1, 'en', '_json', 'Navigates to', 'Navigates to', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(254, 1, 'en', '_json', 'Text Color', 'Text Color', '2021-09-14 13:14:26', '2021-09-14 13:14:26'),
	(255, 1, 'en', '_json', 'Chat, Friendlist...etc', 'Chat, Friendlist...etc', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(256, 1, 'en', '_json', 'Panel Color', 'Panel Color', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(257, 1, 'en', '_json', 'For gradients with Prim. Color( Ex: progress bar of the player)', 'For gradients with Prim. Color( Ex: progress bar of the player)', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(258, 1, 'en', '_json', 'Secondary Color', 'Secondary Color', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(259, 1, 'en', '_json', 'For buttons,icons, nav items, active items...', 'For buttons,icons, nav items, active items...', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(260, 1, 'en', '_json', 'Primary Color', 'Primary Color', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(261, 1, 'en', '_json', 'Colors', 'Colors', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(262, 1, 'en', '_json', 'Gateway', 'Gateway', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(263, 1, 'en', '_json', 'Enable Billing', 'Enable Billing', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(264, 1, 'en', '_json', 'Authentication', 'Authentication', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(265, 1, 'en', '_json', 'Require authentication will force visitors to authenticate.', 'Require authentication will force visitors to authenticate.', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(266, 1, 'en', '_json', 'Last Update', 'Last Update', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(267, 1, 'en', '_json', 'Plan', 'Plan', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(268, 1, 'en', '_json', 'Avatar', 'Avatar', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(269, 1, 'en', '_json', 'User Account', 'User Account', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(270, 1, 'en', '_json', 'Saved successfully.', 'Saved successfully.', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(271, 1, 'en', '_json', 'Bottom of right-sidebar', 'Bottom of right-sidebar', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(272, 1, 'en', '_json', 'Top of the right-sidebar', 'Top of the right-sidebar', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(273, 1, 'en', '_json', 'Top of content pages', 'Top of content pages', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(274, 1, 'en', '_json', 'Bottom of content pages', 'Bottom of content pages', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(275, 1, 'en', '_json', 'Generated', 'Generated', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(276, 1, 'en', '_json', 'Generate', 'Generate', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(277, 1, 'en', '_json', 'Page', 'Page', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(278, 1, 'en', '_json', 'Site Description', 'Site Description', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(279, 1, 'en', '_json', 'Site Title', 'Site Title', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(280, 1, 'en', '_json', 'will be replaced with', 'will be replaced with', '2021-09-14 13:14:27', '2021-09-14 13:14:27'),
	(281, 1, 'en', '_json', 'Quick Guide', 'Quick Guide', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(282, 1, 'en', '_json', 'reset successfully.', 'reset successfully.', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(283, 1, 'en', '_json', 'Please add a valid Google OAuth Client ID.', 'Please add a valid Google OAuth Client ID.', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(284, 1, 'en', '_json', 'Please add your billing credentials.', 'Please add your billing credentials.', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(285, 1, 'en', '_json', 'You need to add your SMTP information.', 'You need to add your SMTP information.', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(286, 1, 'en', '_json', 'Mail From Name', 'Mail From Name', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(287, 1, 'en', '_json', 'Mail From Address', 'Mail From Address', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(288, 1, 'en', '_json', 'Contact Email Address', 'Contact Email Address', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(289, 1, 'en', '_json', 'Enable Emails', 'Enable Emails', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(290, 1, 'en', '_json', 'Max file size allowed', 'Max file size allowed', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(291, 1, 'en', '_json', 'Max image size allowed', 'Max image size allowed', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(292, 1, 'en', '_json', 'Available disk space for users', 'Available disk space for users', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(293, 1, 'en', '_json', 'Available disk space for artists', 'Available disk space for artists', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(294, 1, 'en', '_json', 'Local Storage', 'Local Storage', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(295, 1, 'en', '_json', 'Default Artist Disk Space', 'Default Artist Disk Space', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(296, 1, 'en', '_json', 'Max Image Size', 'Max Image Size', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(297, 1, 'en', '_json', 'Default User Disk Space', 'Default User Disk Space', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(298, 1, 'en', '_json', 'Credentials', 'Credentials', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(299, 1, 'en', '_json', 'Storage Disk', 'Storage Disk', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(300, 1, 'en', '_json', 'Key', 'Key', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(301, 1, 'en', '_json', 'Translation', 'Translation', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(302, 1, 'en', '_json', 'Select a similar language to fill the translations. You can leave it empty.', 'Select a similar language to fill the translations. You can leave it empty.', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(303, 1, 'en', '_json', 'Select Similar Language', 'Select Similar Language', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(304, 1, 'en', '_json', 'Add New Language', 'Add New Language', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(305, 1, 'en', '_json', 'Edit Language', 'Edit Language', '2021-09-14 13:14:28', '2021-09-14 13:14:28'),
	(306, 1, 'en', '_json', 'Update', 'Update', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(307, 1, 'en', '_json', 'Deactivated', 'Deactivated', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(308, 1, 'en', '_json', 'Activated', 'Activated', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(309, 1, 'en', '_json', 'Default', 'Default', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(310, 1, 'en', '_json', 'New Language', 'New Language', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(311, 1, 'en', '_json', 'Subscription cancelled successfully.', 'Subscription cancelled successfully.', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(312, 1, 'en', '_json', 'Cancelled', 'Cancelled', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(313, 1, 'en', '_json', 'Subscription', 'Subscription', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(314, 1, 'en', '_json', 'Owner', 'Owner', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(315, 1, 'en', '_json', 'Status', 'Status', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(316, 1, 'en', '_json', 'Renews At', 'Renews At', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(317, 1, 'en', '_json', 'Downloads', 'Downloads', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(318, 1, 'en', '_json', 'Are you sure you wanna save the current permissions?', 'Are you sure you wanna save the current permissions?', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(319, 1, 'en', '_json', 'Edit', 'Edit', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(320, 1, 'en', '_json', 'Permission', 'Permission', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(321, 1, 'en', '_json', 'Permissions', 'Permissions', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(322, 1, 'en', '_json', 'Roles reset successfully.', 'Roles reset successfully.', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(323, 1, 'en', '_json', 'Podcast', 'Podcast', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(324, 1, 'en', '_json', 'Playlist', 'Playlist', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(325, 1, 'en', '_json', 'Chats', 'Chats', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(326, 1, 'en', '_json', 'Opening chat...Please wait!', 'Opening chat...Please wait!', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(327, 1, 'en', '_json', 'No chats to show!', 'No chats to show!', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(328, 1, 'en', '_json', 'Add some friends and start chatting!', 'Add some friends and start chatting!', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(329, 1, 'en', '_json', 'Discard', 'Discard', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(330, 1, 'en', '_json', 'Are you sure you wanna quit without saving the changes?', 'Are you sure you wanna quit without saving the changes?', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(331, 1, 'en', '_json', 'used already.', 'used already.', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(332, 1, 'en', '_json', 'Amount', 'Amount', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(333, 1, 'en', '_json', 'Storage Space', 'Storage Space', '2021-09-14 13:14:29', '2021-09-14 13:14:29'),
	(334, 1, 'en', '_json', 'Background Color', 'Background Color', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(335, 1, 'en', '_json', 'You do not have any new requests.', 'You do not have any new requests.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(336, 1, 'en', '_json', 'Are you sure you wanna unfriend', 'Are you sure you wanna unfriend', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(337, 1, 'en', '_json', 'Are you sure you wanna make this playlist private? This means that it\'s gonna be visible only for you.', 'Are you sure you wanna make this playlist private? This means that it\'s gonna be visible only for you.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(338, 1, 'en', '_json', 'Are you sure you wanna make this playlist public? This means that it\'s gonna be visible on your profile.', 'Are you sure you wanna make this playlist public? This means that it\'s gonna be visible on your profile.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(339, 1, 'en', '_json', 'Are you sure you wanna delete this playlist?', 'Are you sure you wanna delete this playlist?', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(340, 1, 'en', '_json', 'My followed Playlists', 'My followed Playlists', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(341, 1, 'en', '_json', 'My Playlists', 'My Playlists', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(342, 1, 'en', '_json', 'No Playlists!', 'No Playlists!', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(343, 1, 'en', '_json', 'This page is empty.', 'This page is empty.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(344, 1, 'en', '_json', 'My Likes', 'My Likes', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(345, 1, 'en', '_json', 'You did not follow any artist yet!', 'You did not follow any artist yet!', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(346, 1, 'en', '_json', 'No artists!', 'No artists!', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(347, 1, 'en', '_json', 'Followed Artists', 'Followed Artists', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(348, 1, 'en', '_json', 'No likes yet!', 'No likes yet!', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(349, 1, 'en', '_json', 'Liked Albums', 'Liked Albums', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(350, 1, 'en', '_json', 'Explore and listen to various genres & moods.', 'Explore and listen to various genres & moods.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(351, 1, 'en', '_json', 'Browse', 'Browse', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(352, 1, 'en', '_json', 'Looks like there is no content yet for this genre.', 'Looks like there is no content yet for this genre.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(353, 1, 'en', '_json', 'Some server error has occurred. Try again later.', 'Some server error has occurred. Try again later.', '2021-09-14 13:14:30', '2021-09-14 13:14:30'),
	(354, 1, 'en', '_json', 'Something wrong happened!', 'Something wrong happened!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(355, 1, 'en', '_json', 'Go Back', 'Go Back', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(356, 1, 'en', '_json', 'Genre does not exist!', 'Genre does not exist!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(357, 1, 'en', '_json', 'Not available!', 'Not available!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(358, 1, 'en', '_json', 'Here you can explore all', 'Here you can explore all', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(359, 1, 'en', '_json', 'Music', 'Music', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(360, 1, 'en', '_json', 'There is content yet!', 'There is content yet!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(361, 1, 'en', '_json', 'No Content!', 'No Content!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(362, 1, 'en', '_json', 'Manage your music', 'Manage your music', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(363, 1, 'en', '_json', 'My Songs', 'My Songs', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(364, 1, 'en', '_json', 'of space used', 'of space used', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(365, 1, 'en', '_json', 'Upload', 'Upload', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(366, 1, 'en', '_json', 'No songs yet!', 'No songs yet!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(367, 1, 'en', '_json', 'Your history is empty.', 'Your history is empty.', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(368, 1, 'en', '_json', 'Recently Played', 'Recently Played', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(369, 1, 'en', '_json', 'You did not follow any podcasts yet!', 'You did not follow any podcasts yet!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(370, 1, 'en', '_json', 'No Podcasts!', 'No Podcasts!', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(371, 1, 'en', '_json', 'Followed Podcasts', 'Followed Podcasts', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(372, 1, 'en', '_json', 'updated successfully.', 'updated successfully.', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(373, 1, 'en', '_json', 'Request submitted to admins successfully.', 'Request submitted to admins successfully.', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(374, 1, 'en', '_json', 'Submitting...', 'Submitting...', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(375, 1, 'en', '_json', 'Confirm password does not match.', 'Confirm password does not match.', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(376, 1, 'en', '_json', 'Are you sure you wanna cancel your subscription?', 'Are you sure you wanna cancel your subscription?', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(377, 1, 'en', '_json', 'Submit', 'Submit', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(378, 1, 'en', '_json', 'Requested', 'Requested', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(379, 1, 'en', '_json', 'This request can only be submitted ones.', 'This request can only be submitted ones.', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(380, 1, 'en', '_json', 'Fill your information', 'Fill your information', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(381, 1, 'en', '_json', 'Features', 'Features', '2021-09-14 13:14:31', '2021-09-14 13:14:31'),
	(382, 1, 'en', '_json', 'Subscribed to', 'Subscribed to', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(383, 1, 'en', '_json', 'Request Artist Account', 'Request Artist Account', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(384, 1, 'en', '_json', 'Artist Account Request sent', 'Artist Account Request sent', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(385, 1, 'en', '_json', 'Do not show what I am currently playing to friends.', 'Do not show what I am currently playing to friends.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(386, 1, 'en', '_json', 'Privacy', 'Privacy', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(387, 1, 'en', '_json', 'New Password', 'New Password', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(388, 1, 'en', '_json', 'Update Password', 'Update Password', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(389, 1, 'en', '_json', 'Current password', 'Current password', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(390, 1, 'en', '_json', 'Language', 'Language', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(391, 1, 'en', '_json', 'Account Settings', 'Account Settings', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(392, 1, 'en', '_json', 'Start typing to search for a genre.', 'Start typing to search for a genre.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(393, 1, 'en', '_json', 'No results found for', 'No results found for', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(394, 1, 'en', '_json', 'Link To Artist', 'Link To Artist', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(395, 1, 'en', '_json', 'Attach this song to an existing artist', 'Attach this song to an existing artist', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(396, 1, 'en', '_json', 'Insert the name of the artist and press the Enter key.', 'Insert the name of the artist and press the Enter key.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(397, 1, 'en', '_json', 'Hide', 'Hide', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(398, 1, 'en', '_json', 'Please add a valid source file.', 'Please add a valid source file.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(399, 1, 'en', '_json', 'Please add a valid YouTube video ID or URL.', 'Please add a valid YouTube video ID or URL.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(400, 1, 'en', '_json', 'Attach', 'Attach', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(401, 1, 'en', '_json', 'Friend Request sent successfully.', 'Friend Request sent successfully.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(402, 1, 'en', '_json', 'Friend removed successfully.', 'Friend removed successfully.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(403, 1, 'en', '_json', 'User does not exist.', 'User does not exist.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(404, 1, 'en', '_json', 'Not Available!', 'Not Available!', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(405, 1, 'en', '_json', 'Looks like this account is still new!', 'Looks like this account is still new!', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(406, 1, 'en', '_json', 'This album is empty.', 'This album is empty.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(407, 1, 'en', '_json', 'Reject', 'Reject', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(408, 1, 'en', '_json', 'artist account request has been rejected.', 'artist account request has been rejected.', '2021-09-14 13:14:32', '2021-09-14 13:14:32'),
	(409, 1, 'en', '_json', 'has an artist account now.', 'has an artist account now.', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(410, 1, 'en', '_json', 'Approve', 'Approve', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(411, 1, 'en', '_json', 'Friend request by', 'Friend request by', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(412, 1, 'en', '_json', 'was rejected.', 'was rejected.', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(413, 1, 'en', '_json', 'Request Rejected', 'Request Rejected', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(414, 1, 'en', '_json', 'Request Accepted', 'Request Accepted', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(415, 1, 'en', '_json', 'has been added to your friend list', 'has been added to your friend list', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(416, 1, 'en', '_json', 'Artist Request', 'Artist Request', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(417, 1, 'en', '_json', 'Click to see details', 'Click to see details', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(418, 1, 'en', '_json', 'Subject is required', 'Subject is required', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(419, 1, 'en', '_json', 'Subject must contain be at least 4 characters', 'Subject must contain be at least 4 characters', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(420, 1, 'en', '_json', 'E-mail must be valid', 'E-mail must be valid', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(421, 1, 'en', '_json', 'E-mail is required', 'E-mail is required', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(422, 1, 'en', '_json', 'anytime', 'anytime', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(423, 1, 'en', '_json', 'anywhere', 'anywhere', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(424, 1, 'en', '_json', 'Email sent successfully.', 'Email sent successfully.', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(425, 1, 'en', '_json', 'Send', 'Send', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(426, 1, 'en', '_json', 'Choose', 'Choose', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(427, 1, 'en', '_json', 'Free', 'Free', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(428, 1, 'en', '_json', 'Recommended', 'Recommended', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(429, 1, 'en', '_json', 'Payment', 'Payment', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(430, 1, 'en', '_json', 'Complete', 'Complete', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(431, 1, 'en', '_json', 'Choose your plan', 'Choose your plan', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(432, 1, 'en', '_json', 'Oops! Some error occurred. Try again later.', 'Oops! Some error occurred. Try again later.', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(433, 1, 'en', '_json', 'Subscribe', 'Subscribe', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(434, 1, 'en', '_json', 'Accepted Payment Methods', 'Accepted Payment Methods', '2021-09-14 13:14:33', '2021-09-14 13:14:33'),
	(435, 1, 'en', '_json', 'Reloading', 'Reloading', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(436, 1, 'en', '_json', 'Congratulation! Subscription was successful.', 'Congratulation! Subscription was successful.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(437, 1, 'en', '_json', 'Credit Card', 'Credit Card', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(438, 1, 'en', '_json', 'Year', 'Year', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(439, 1, 'en', '_json', 'Month', 'Month', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(440, 1, 'en', '_json', 'Week', 'Week', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(441, 1, 'en', '_json', 'Day', 'Day', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(442, 1, 'en', '_json', 'You already have a subscription. Do you want to cancel the current one and switch to a new subscription?', 'You already have a subscription. Do you want to cancel the current one and switch to a new subscription?', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(443, 1, 'en', '_json', 'Your Library', 'Your Library', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(444, 1, 'en', '_json', 'Podcast genre does not exist.', 'Podcast genre does not exist.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(445, 1, 'en', '_json', 'This genre has no podcasts yet.', 'This genre has no podcasts yet.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(446, 1, 'en', '_json', 'Tracks', 'Tracks', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(447, 1, 'en', '_json', 'This artist profile is empty.', 'This artist profile is empty.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(448, 1, 'en', '_json', 'Following', 'Following', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(449, 1, 'en', '_json', 'Page Not Found', 'Page Not Found', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(450, 1, 'en', '_json', 'There is no content to be displayed.', 'There is no content to be displayed.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(451, 1, 'en', '_json', 'has been deleted successfully.', 'has been deleted successfully.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(452, 1, 'en', '_json', 'deleted successfully.', 'deleted successfully.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(453, 1, 'en', '_json', 'Something went wrong. Please try again.', 'Something went wrong. Please try again.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(454, 1, 'en', '_json', 'Playlist does not exist or maybe it is not available for public access. who knows!', 'Playlist does not exist or maybe it is not available for public access. who knows!', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(455, 1, 'en', '_json', 'This playlist is empty.', 'This playlist is empty.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(456, 1, 'en', '_json', 'No Songs!', 'No Songs!', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(457, 1, 'en', '_json', 'Private playlist', 'Private playlist', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(458, 1, 'en', '_json', 'does no exist.', 'does no exist.', '2021-09-14 13:14:34', '2021-09-14 13:14:34'),
	(459, 1, 'en', '_json', 'No Episodes!', 'No Episodes!', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(460, 1, 'en', '_json', 'Looks like this podcast has no episodes yet.', 'Looks like this podcast has no episodes yet.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(461, 1, 'en', '_json', 'From', 'From', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(462, 1, 'en', '_json', 'Ft.', 'Ft.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(463, 1, 'en', '_json', 'More from', 'More from', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(464, 1, 'en', '_json', 'Song does not exist or maybe it is not available for public access. Who knows!', 'Song does not exist or maybe it is not available for public access. Who knows!', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(465, 1, 'en', '_json', 'has been removed from playlist successfully.', 'has been removed from playlist successfully.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(466, 1, 'en', '_json', 'Song Removed', 'Song Removed', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(467, 1, 'en', '_json', 'There is content yet.', 'There is content yet.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(468, 1, 'en', '_json', 'Small Window', 'Small Window', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(469, 1, 'en', '_json', 'Radio Station', 'Radio Station', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(470, 1, 'en', '_json', 'Copied', 'Copied', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(471, 1, 'en', '_json', 'Song has been deleted successfully.', 'Song has been deleted successfully.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(472, 1, 'en', '_json', 'No Results!', 'No Results!', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(473, 1, 'en', '_json', 'used', 'used', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(474, 1, 'en', '_json', 'Space Used', 'Space Used', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(475, 1, 'en', '_json', 'Song added to playlist successfully.', 'Song added to playlist successfully.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(476, 1, 'en', '_json', 'Added', 'Added', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(477, 1, 'en', '_json', 'Looks like you do not have any playlists yet.', 'Looks like you do not have any playlists yet.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(478, 1, 'en', '_json', 'validation.distinct', 'The :attribute field has a duplicate value.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(479, 1, 'en', '_json', 'validation.email', 'The :attribute must be a valid email address.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(480, 1, 'en', '_json', 'validation.ends_with', 'The :attribute must end with one of the following: :values.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(481, 1, 'en', '_json', 'validation.exists', 'The selected :attribute is invalid.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(482, 1, 'en', '_json', 'validation.file', 'The :attribute must be a file.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(483, 1, 'en', '_json', 'validation.filled', 'The :attribute field must have a value.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(484, 1, 'en', '_json', 'validation.gt.numeric', 'The :attribute must be greater than :value.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(485, 1, 'en', '_json', 'validation.accepted', 'The :attribute must be accepted.', '2021-09-14 13:14:35', '2021-09-14 13:14:35'),
	(486, 1, 'en', '_json', 'validation.date', 'The :attribute is not a valid date.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(487, 1, 'en', '_json', 'validation.date_equals', 'The :attribute must be a date equal to :date.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(488, 1, 'en', '_json', 'validation.date_format', 'The :attribute does not match the format :format.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(489, 1, 'en', '_json', 'validation.different', 'The :attribute and :other must be different.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(490, 1, 'en', '_json', 'validation.digits', 'The :attribute must be :digits digits.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(491, 1, 'en', '_json', 'validation.size.array', 'The :attribute must contain :size items.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(492, 1, 'en', '_json', 'validation.starts_with', 'The :attribute must start with one of the following: :values.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(493, 1, 'en', '_json', 'validation.string', 'The :attribute must be a string.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(494, 1, 'en', '_json', 'validation.timezone', 'The :attribute must be a valid zone.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(495, 1, 'en', '_json', 'validation.unique', 'The :attribute has already been taken.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(496, 1, 'en', '_json', 'validation.uploaded', 'The :attribute failed to upload.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(497, 1, 'en', '_json', 'validation.url', 'The :attribute format is invalid.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(498, 1, 'en', '_json', 'validation.uuid', 'The :attribute must be a valid UUID.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(499, 1, 'en', '_json', 'validation.custom.attribute-name.rule-name', 'custom-message', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(500, 1, 'en', '_json', 'validation.max.file', 'The :attribute may not be greater than :max kilobytes.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(501, 1, 'en', '_json', 'validation.max.string', 'The :attribute may not be greater than :max characters.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(502, 1, 'en', '_json', 'validation.max.array', 'The :attribute may not have more than :max items.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(503, 1, 'en', '_json', 'validation.mimes', 'The :attribute must be a file of type: :values.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(504, 1, 'en', '_json', 'validation.mimetypes', 'The :attribute must be a file of type: :values.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(505, 1, 'en', '_json', 'validation.min.numeric', 'The :attribute must be at least :min.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(506, 1, 'en', '_json', 'validation.min.file', 'The :attribute must be at least :min kilobytes.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(507, 1, 'en', '_json', 'validation.min.string', 'The :attribute must be at least :min characters.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(508, 1, 'en', '_json', 'validation.min.array', 'The :attribute must have at least :min items.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(509, 1, 'en', '_json', 'validation.not_in', 'The selected :attribute is invalid.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(510, 1, 'en', '_json', 'validation.not_regex', 'The :attribute format is invalid.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(511, 1, 'en', '_json', 'validation.numeric', 'The :attribute must be a number.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(512, 1, 'en', '_json', 'validation.password', 'The password is incorrect.', '2021-09-14 13:14:36', '2021-09-14 13:14:36'),
	(513, 1, 'en', '_json', 'validation.present', 'The :attribute field must be present.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(514, 1, 'en', '_json', 'validation.regex', 'The :attribute format is invalid.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(515, 1, 'en', '_json', 'validation.required', 'The :attribute field is required.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(516, 1, 'en', '_json', 'validation.required_if', 'The :attribute field is required when :other is :value.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(517, 1, 'en', '_json', 'validation.required_unless', 'The :attribute field is required unless :other is in :values.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(518, 1, 'en', '_json', 'validation.required_with', 'The :attribute field is required when :values is present.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(519, 1, 'en', '_json', 'validation.required_with_all', 'The :attribute field is required when :values are present.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(520, 1, 'en', '_json', 'validation.required_without', 'The :attribute field is required when :values is not present.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(521, 1, 'en', '_json', 'validation.required_without_all', 'The :attribute field is required when none of :values are present.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(522, 1, 'en', '_json', 'validation.same', 'The :attribute and :other must match.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(523, 1, 'en', '_json', 'validation.size.numeric', 'The :attribute must be :size.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(524, 1, 'en', '_json', 'validation.size.file', 'The :attribute must be :size kilobytes.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(525, 1, 'en', '_json', 'validation.size.string', 'The :attribute must be :size characters.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(526, 1, 'en', '_json', 'validation.gte.numeric', 'The :attribute must be greater than or equal :value.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(527, 1, 'en', '_json', 'validation.gte.file', 'The :attribute must be greater than or equal :value kilobytes.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(528, 1, 'en', '_json', 'validation.gte.string', 'The :attribute must be greater than or equal :value characters.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(529, 1, 'en', '_json', 'validation.gte.array', 'The :attribute must have :value items or more.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(530, 1, 'en', '_json', 'validation.image', 'The :attribute must be an image.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(531, 1, 'en', '_json', 'validation.in', 'The selected :attribute is invalid.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(532, 1, 'en', '_json', 'validation.active_url', 'The :attribute is not a valid URL.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(533, 1, 'en', '_json', 'validation.after', 'The :attribute must be a date after :date.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(534, 1, 'en', '_json', 'validation.after_or_equal', 'The :attribute must be a date after or equal to :date.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(535, 1, 'en', '_json', 'validation.boolean', 'The :attribute field must be true or false.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(536, 1, 'en', '_json', 'validation.confirmed', 'The :attribute confirmation does not match.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(537, 1, 'en', '_json', 'validation.in_array', 'The :attribute field does not exist in :other.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(538, 1, 'en', '_json', 'validation.integer', 'The :attribute must be an integer.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(539, 1, 'en', '_json', 'validation.ip', 'The :attribute must be a valid IP address.', '2021-09-14 13:14:37', '2021-09-14 13:14:37'),
	(540, 1, 'en', '_json', 'validation.ipv4', 'The :attribute must be a valid IPv4 address.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(541, 1, 'en', '_json', 'validation.ipv6', 'The :attribute must be a valid IPv6 address.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(542, 1, 'en', '_json', 'validation.json', 'The :attribute must be a valid JSON string.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(543, 1, 'en', '_json', 'validation.lt.numeric', 'The :attribute must be less than :value.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(544, 1, 'en', '_json', 'validation.lt.file', 'The :attribute must be less than :value kilobytes.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(545, 1, 'en', '_json', 'validation.lt.string', 'The :attribute must be less than :value characters.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(546, 1, 'en', '_json', 'validation.lt.array', 'The :attribute must have less than :value items.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(547, 1, 'en', '_json', 'validation.lte.numeric', 'The :attribute must be less than or equal :value.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(548, 1, 'en', '_json', 'validation.lte.file', 'The :attribute must be less than or equal :value kilobytes.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(549, 1, 'en', '_json', 'validation.lte.string', 'The :attribute must be less than or equal :value characters.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(550, 1, 'en', '_json', 'validation.lte.array', 'The :attribute must not have more than :value items.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(551, 1, 'en', '_json', 'validation.max.numeric', 'The :attribute may not be greater than :max.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(552, 1, 'en', '_json', 'validation.digits_between', 'The :attribute must be between :min and :max digits.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(553, 1, 'en', '_json', 'validation.dimensions', 'The :attribute has invalid image dimensions.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(554, 1, 'en', '_json', 'validation.alpha', 'The :attribute may only contain letters.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(555, 1, 'en', '_json', 'validation.alpha_dash', 'The :attribute may only contain letters, numbers, dashes and underscores.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(556, 1, 'en', '_json', 'validation.alpha_num', 'The :attribute may only contain letters and numbers.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(557, 1, 'en', '_json', 'validation.array', 'The :attribute must be an array.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(558, 1, 'en', '_json', 'validation.before', 'The :attribute must be a date before :date.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(559, 1, 'en', '_json', 'validation.before_or_equal', 'The :attribute must be a date before or equal to :date.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(560, 1, 'en', '_json', 'validation.between.numeric', 'The :attribute must be between :min and :max.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(561, 1, 'en', '_json', 'validation.between.file', 'The :attribute must be between :min and :max kilobytes.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(562, 1, 'en', '_json', 'validation.between.string', 'The :attribute must be between :min and :max characters.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(563, 1, 'en', '_json', 'validation.between.array', 'The :attribute must have between :min and :max items.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(564, 1, 'en', '_json', 'validation.gt.file', 'The :attribute must be greater than :value kilobytes.', '2021-09-14 13:14:38', '2021-09-14 13:14:38'),
	(565, 1, 'en', '_json', 'validation.gt.string', 'The :attribute must be greater than :value characters.', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(566, 1, 'en', '_json', 'validation.gt.array', 'The :attribute must have more than :value items.', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(567, 1, 'en', '_json', 'Save', 'Save', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(568, 1, 'en', '_json', 'Register', 'Register', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(569, 1, 'en', '_json', 'Upgrade Account', 'Upgrade Account', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(570, 1, 'en', '_json', 'File corrupted!', 'File corrupted!', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(571, 1, 'en', '_json', 'The source file you are trying to upload is corrupted.', 'The source file you are trying to upload is corrupted.', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(572, 1, 'en', '_json', 'Max file size is', 'Max file size is', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(573, 1, 'en', '_json', 'TB', 'TB', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(574, 1, 'en', '_json', 'GB', 'GB', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(575, 1, 'en', '_json', 'MB', 'MB', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(576, 1, 'en', '_json', 'Radio Stations', 'Radio Stations', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(577, 1, 'en', '_json', 'YouTube Video', 'YouTube Video', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(578, 1, 'en', '_json', 'Audio File', 'Audio File', '2021-09-14 13:14:39', '2021-09-14 13:14:39'),
	(579, 1, 'en', '_json', 'Auto Duration', 'Auto Duration', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(580, 1, 'en', '_json', 'Duration in seconds', 'Duration in seconds', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(581, 1, 'en', '_json', 'Duration', 'Duration', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(582, 1, 'en', '_json', 'You can add the video ID, but It must be valid.', 'You can add the video ID, but It must be valid.', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(583, 1, 'en', '_json', 'Attach Audio File', 'Attach Audio File', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(584, 1, 'en', '_json', 'Artist Area', 'Artist Area', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(585, 1, 'en', '_json', 'Admin Area', 'Admin Area', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(586, 1, 'en', '_json', 'Song', 'Song', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(587, 1, 'en', '_json', 'Genres', 'Genres', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(588, 1, 'en', '_json', 'Player', 'Player', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(589, 1, 'en', '_json', 'Library', 'Library', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(590, 1, 'en', '_json', 'Plays Chart', 'Plays Chart', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(591, 1, 'en', '_json', 'Delete Song', 'Delete Song', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(592, 1, 'en', '_json', 'Detach song from this album', 'Detach song from this album', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(593, 1, 'en', '_json', 'Song attached to album.', 'Song attached to album.', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(594, 1, 'en', '_json', 'Release Date', 'Release Date', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(595, 1, 'en', '_json', 'Start typing to search to an artist.', 'Start typing to search to an artist.', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(596, 1, 'en', '_json', 'saved successfully', 'saved successfully', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(597, 1, 'en', '_json', 'Badge', 'Badge', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(598, 1, 'en', '_json', 'Show the upgrade button after subscription. Switch on if there is a better plan than this.', 'Show the upgrade button after subscription. Switch on if there is a better plan than this.', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(599, 1, 'en', '_json', 'Interface', 'Interface', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(600, 1, 'en', '_json', 'Add displayed feature', 'Add displayed feature', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(601, 1, 'en', '_json', 'This does not affect the script', 'This does not affect the script', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(602, 1, 'en', '_json', 'Features that will display on the plan card', 'Features that will display on the plan card', '2021-09-14 13:14:40', '2021-09-14 13:14:40'),
	(603, 1, 'en', '_json', 'Card Features', 'Card Features', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(604, 1, 'en', '_json', 'Artist Permissions', 'Artist Permissions', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(605, 1, 'en', '_json', 'Permissions to grant for subscribed users', 'Permissions to grant for subscribed users', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(606, 1, 'en', '_json', 'Display order of the plans(lower first)', 'Display order of the plans(lower first)', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(607, 1, 'en', '_json', 'Position', 'Position', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(608, 1, 'en', '_json', 'The frequency of the subscription billing', 'The frequency of the subscription billing', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(609, 1, 'en', '_json', 'Amount in cents (can not be changed later)', 'Amount in cents (can not be changed later)', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(610, 1, 'en', '_json', 'Currency', 'Currency', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(611, 1, 'en', '_json', 'Enable billing to create non-free plans', 'Enable billing to create non-free plans', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(612, 1, 'en', '_json', 'Some values can not be updated after the plan creation', 'Some values can not be updated after the plan creation', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(613, 1, 'en', '_json', 'Search Translation', 'Search Translation', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(614, 1, 'en', '_json', 'Price', 'Price', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(615, 1, 'en', '_json', 'Inactive', 'Inactive', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(616, 1, 'en', '_json', 'Active', 'Active', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(617, 1, 'en', '_json', 'Upgradable', 'Upgradable', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(618, 1, 'en', '_json', 'week', 'week', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(619, 1, 'en', '_json', 'day', 'day', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(620, 1, 'en', '_json', 'month', 'month', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(621, 1, 'en', '_json', 'year', 'year', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(622, 1, 'en', '_json', 'Password reset successfully.', 'Password reset successfully.', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(623, 1, 'en', '_json', 'Email verification link sent on your Email.', 'Email verification link sent on your Email.', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(624, 1, 'en', '_json', 'Invalid/Expired url provided.', 'Invalid/Expired url provided.', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(625, 1, 'en', '_json', 'Current password does not match', 'Current password does not match', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(626, 1, 'en', '_json', 'Failed to delete subscription from PayPal.', 'Failed to delete subscription from PayPal.', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(627, 1, 'en', '_json', 'Failed to delete subscription from Stripe.', 'Failed to delete subscription from Stripe.', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(628, 1, 'en', '_json', 'Failed, Invalid Token', 'Failed, Invalid Token', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(629, 1, 'en', '_json', 'Email could not be sent to this email address', 'Email could not be sent to this email address', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(630, 1, 'en', '_json', 'You have exceeded your space limit', 'You have exceeded your space limit', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(631, 1, 'en', '_json', 'No ads', 'No ads', '2021-09-14 13:14:41', '2021-09-14 13:14:41'),
	(632, 1, 'en', '_json', 'Publish playlists', 'Publish playlists', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(633, 1, 'en', '_json', 'Publish songs', 'Publish songs', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(634, 1, 'en', '_json', 'Listen with friends', 'Listen with friends', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(635, 1, 'en', '_json', 'Chat with friends', 'Chat with friends', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(636, 1, 'en', '_json', 'Download songs', 'Download songs', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(637, 1, 'en', '_json', 'Upload songs', 'Upload songs', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(638, 1, 'en', '_json', 'No data available', 'No data available', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(639, 1, 'en', '_json', 'Home', 'Home', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(640, 1, 'en', '_json', 'You can check your subscription on your account settings', 'You can check your subscription on your account settings', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(641, 1, 'en', '_json', 'The name that the users will see when they receive an Email from you.', 'The name that the users will see when they receive an Email from you.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(642, 1, 'en', '_json', 'The address that the users will see when they receive an Email from you.', 'The address that the users will see when they receive an Email from you.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(643, 1, 'en', '_json', 'Require Authentication', 'Require Authentication', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(644, 1, 'en', '_json', 'Does not see advertisements.', 'Does not see advertisements.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(645, 1, 'en', '_json', 'Ability to change playlists privacy to public.', 'Ability to change playlists privacy to public.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(646, 1, 'en', '_json', 'Ability to change songs privacy to public.', 'Ability to change songs privacy to public.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(647, 1, 'en', '_json', 'Listen with friends to the same song at the same time.', 'Listen with friends to the same song at the same time.', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(648, 1, 'en', '_json', 'Live Radio', 'Live Radio', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(649, 1, 'en', '_json', 'Episodes', 'Episodes', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(650, 1, 'en', '_json', 'Number of plays', 'Number of plays', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(651, 1, 'en', '_json', 'Localization', 'Localization', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(652, 1, 'en', '_json', 'Platform Name', 'Platform Name', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(653, 1, 'en', '_json', 'Disabling podcasts will remove anything related to podcasts on the application', 'Disabling podcasts will remove anything related to podcasts on the application', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(654, 1, 'en', '_json', 'Community', 'Community', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(655, 1, 'en', '_json', 'Friendship System', 'Friendship System', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(656, 1, 'en', '_json', 'Disable this functionality if you do not want users to be friends with each other', 'Disable this functionality if you do not want users to be friends with each other', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(657, 1, 'en', '_json', 'This will allow live chat and what the users are currently playing', 'This will allow live chat and what the users are currently playing', '2021-09-14 13:14:42', '2021-09-14 13:14:42'),
	(658, 1, 'en', '_json', 'Enable chat between friends', 'Enable chat between friends', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(659, 1, 'en', '_json', 'Allow users to request an artist account by sending their information to the admins', 'Allow users to request an artist account by sending their information to the admins', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(660, 1, 'en', '_json', 'Download Button', 'Download Button', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(661, 1, 'en', '_json', 'Show the download button on the player(if the audio has a file)', 'Show the download button on the player(if the audio has a file)', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(662, 1, 'en', '_json', 'Default Volume', 'Default Volume', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(663, 1, 'en', '_json', 'No Sections!', 'No Sections!', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(664, 1, 'en', '_json', 'Page empty. Add some sections.', 'Page empty. Add some sections.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(665, 1, 'en', '_json', 'Add Section', 'Add Section', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(666, 1, 'en', '_json', 'Enable to receive Emails from users. Enable to verify users Email addresses.', 'Enable to receive Emails from users. Enable to verify users Email addresses.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(667, 1, 'en', '_json', 'Show on the live radio section on the right-sidebar', 'Show on the live radio section on the right-sidebar', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(668, 1, 'en', '_json', 'Highlight', 'Highlight', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(669, 1, 'en', '_json', 'Remove user registration on the application', 'Remove user registration on the application', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(670, 1, 'en', '_json', 'Select the landing page of your platform. You can create custom pages.', 'Select the landing page of your platform. You can create custom pages.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(671, 1, 'en', '_json', 'Platform', 'Platform', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(672, 1, 'en', '_json', 'Locale', 'Locale', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(673, 1, 'en', '_json', 'Enable Realtime', 'Enable Realtime', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(674, 1, 'en', '_json', 'About Us', 'About Us', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(675, 1, 'en', '_json', 'Disabling podcasts will remove anything related to podcasts on the application.', 'Disabling podcasts will remove anything related to podcasts on the application.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(676, 1, 'en', '_json', 'This will allow live chat and shows what the users are currently playing.', 'This will allow live chat and shows what the users are currently playing.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(677, 1, 'en', '_json', 'Disable this functionality if you do not want users to be friends with each other.', 'Disable this functionality if you do not want users to be friends with each other.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(678, 1, 'en', '_json', 'Describe your platform', 'Describe your platform', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(679, 1, 'en', '_json', 'You can add HTML code', 'You can add HTML code', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(680, 1, 'en', '_json', 'Enable Chat', 'Enable Chat', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(681, 1, 'en', '_json', 'Allow artist account requests', 'Allow artist account requests', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(682, 1, 'en', '_json', 'Choose Roles', 'Choose Roles', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(683, 1, 'en', '_json', 'Podcaster', 'Podcaster', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(684, 1, 'en', '_json', 'Sorry, you can not play YouTube videos.', 'Sorry, you can not play YouTube videos.', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(685, 1, 'en', '_json', 'Yearly', 'Yearly', '2021-09-14 13:14:43', '2021-09-14 13:14:43'),
	(686, 1, 'en', '_json', 'Weekly', 'Weekly', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(687, 1, 'en', '_json', 'Monthly', 'Monthly', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(688, 1, 'en', '_json', 'Daily', 'Daily', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(689, 1, 'en', '_json', 'Please wait', 'Please wait', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(690, 1, 'en', '_json', 'Activate', 'Activate', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(691, 1, 'en', '_json', 'Artist', 'Artist', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(692, 1, 'en', '_json', 'Custom', 'Custom', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(693, 1, 'en', '_json', 'Comedy', 'Comedy', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(694, 1, 'en', '_json', 'Arts', 'Arts', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(695, 1, 'en', '_json', 'Disable Registration', 'Disable Registration', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(696, 1, 'en', '_json', 'Max File Size', 'Max File Size', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(697, 1, 'en', '_json', 'Number of labels', 'Number of labels', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(698, 1, 'en', '_json', 'Select', 'Select', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(699, 1, 'en', '_json', 'Path', 'Path', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(700, 1, 'en', '_json', 'Icon', 'Icon', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(701, 1, 'en', '_json', 'No streaming source found.', 'No streaming source found.', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(702, 1, 'en', '_json', 'Could not be played!', 'Could not be played!', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(703, 1, 'en', '_json', 'Enable Ads', 'Enable Ads', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(704, 1, 'en', '_json', 'Logo', 'Logo', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(705, 1, 'en', '_json', 'Size', 'Size', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(706, 1, 'en', '_json', 'Now Playing', 'Now Playing', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(707, 1, 'en', '_json', 'Followed artists', 'Followed artists', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(708, 1, 'en', '_json', 'Followed playlists', 'Followed playlists', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(709, 1, 'en', '_json', 'Contact Us', 'Contact Us', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(710, 1, 'en', '_json', 'Sent', 'Sent', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(711, 1, 'en', '_json', 'User already has an active subscription.', 'User already has an active subscription.', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(712, 1, 'en', '_json', 'Hide Right-sidebar', 'Hide Right-sidebar', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(713, 1, 'en', '_json', 'Content type', 'Content type', '2021-09-14 13:14:44', '2021-09-14 13:14:44'),
	(714, 1, 'en', '_json', 'Default Language', 'Default Language', '2021-09-14 13:14:45', '2021-09-14 13:14:45'),
	(715, 1, 'en', '_json', 'Source Format', 'Source Format', '2021-09-14 13:14:45', '2021-09-14 13:14:45'),
	(716, 1, 'en', '_json', 'Icon file', 'Icon file', '2021-09-14 13:14:45', '2021-09-14 13:14:45'),
	(717, 1, 'en', '_json', 'Show', 'Show', '2021-09-14 13:14:45', '2021-09-14 13:14:45'),
	(718, 1, 'en', '_json', 'Browse Page', 'Browse Page', '2021-09-14 13:14:45', '2021-09-14 13:14:45'),
	(719, 1, 'en', '_json', 'Remove the browse page which includes music genres & charts.', 'Remove the browse page which includes music genres & charts.', '2021-09-14 13:14:45', '2021-09-14 13:14:45');
/*!40000 ALTER TABLE `ltm_translations` ENABLE KEYS */;

-- Dumping structure for table podcast2.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Dumping structure for table podcast2.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.migrations: ~50 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_04_02_193005_create_translations_table', 1),
	(2, '2014_10_12_000000_create_users_table', 1),
	(3, '2014_10_12_100000_create_password_resets_table', 1),
	(4, '2018_05_13_084701_create_session_table', 1),
	(5, '2018_05_13_085121_create_messages_table', 1),
	(6, '2018_05_13_085415_create_chats_table', 1),
	(7, '2019_05_03_000001_create_customer_columns', 1),
	(8, '2019_05_03_000002_create_subscriptions_table', 1),
	(9, '2019_08_19_000000_create_failed_jobs_table', 1),
	(10, '2020_05_13_145928_create_playlists_table', 1),
	(11, '2020_05_13_184903_create_albums_table', 1),
	(12, '2020_05_14_181224_create_genres_table', 1),
	(13, '2020_05_17_074954_create_episodes_table', 1),
	(14, '2020_05_17_081741_create_podcasts_table', 1),
	(15, '2020_05_17_085409_create_podcast_genres_table', 1),
	(16, '2020_06_02_194725_create_podcast_follows_table', 1),
	(17, '2020_06_12_125224_create_artists_table', 1),
	(18, '2020_06_12_130029_create_song_likes_table', 1),
	(19, '2020_06_13_080301_create_song_plays_table', 1),
	(20, '2020_06_21_112902_create_song_playlist_table', 1),
	(21, '2020_06_22_232106_create_album_likes_table', 1),
	(22, '2020_06_22_235703_create_playlist_follows_table', 1),
	(23, '2020_06_23_102926_create_notifications_table', 1),
	(24, '2020_06_23_155743_create_roles_table', 1),
	(25, '2020_06_23_181713_create_role_user_table', 1),
	(26, '2020_06_23_215231_create_artist_follows_table', 1),
	(27, '2020_07_20_203234_create_friendships_table', 1),
	(28, '2020_07_27_105801_create_genre_song_table', 1),
	(29, '2020_08_09_202913_create_genre_podcast_table', 1),
	(30, '2020_08_10_134300_create_episode_plays_table', 1),
	(31, '2020_08_18_160041_create_visiting_countries_table', 1),
	(32, '2020_08_18_160415_create_visiting_browsers_table', 1),
	(33, '2020_09_02_210451_create_settings_table', 1),
	(34, '2020_09_21_145056_create_permissions_table', 1),
	(35, '2020_09_21_214630_create_user_permission_table', 1),
	(36, '2020_09_21_234427_create_role_permission_table', 1),
	(37, '2020_10_13_100426_cr_home_sections_table', 1),
	(38, '2020_11_05_125035_create_songs_table', 1),
	(39, '2020_11_05_131453_create_sections_table', 1),
	(40, '2020_11_06_143029_create_navigation_items_table', 1),
	(41, '2020_12_18_135630_create_pages_table', 1),
	(42, '2020_12_24_072721_cr_episode_likes', 1),
	(43, '2021_04_17_121458_create_plans_table', 1),
	(44, '2021_04_17_151121_create_plan_permission', 1),
	(45, '2021_04_21_222735_create_plan_role', 1),
	(46, '2021_04_28_230048_create_plays_table', 1),
	(47, '2021_05_01_214304_create_languages_table', 1),
	(48, '2021_05_06_010614_create_radio_stations_table', 1),
	(49, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
	(50, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
	(51, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
	(52, '2016_06_01_000004_create_oauth_clients_table', 2),
	(53, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table podcast2.navigation_items
CREATE TABLE IF NOT EXISTS `navigation_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `navigatesTo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_id` bigint(20) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `rank` int(11) NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.navigation_items: ~4 rows (approximately)
/*!40000 ALTER TABLE `navigation_items` DISABLE KEYS */;
INSERT INTO `navigation_items` (`id`, `name`, `icon`, `navigatesTo`, `page_id`, `visibility`, `custom`, `rank`, `path`, `created_at`, `updated_at`) VALUES
	(1, 'Home', 'home', 'Custom page', 1, 1, 1, 1, '/home', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(2, 'Browse', 'compass', NULL, NULL, 1, 0, 2, '/browse', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(3, 'Podcasts', 'microphone', NULL, NULL, 1, 0, 3, '/podcasts', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(4, 'Library', 'music-box-multiple', NULL, NULL, 1, 0, 4, '/library/my-songs', '2021-09-14 13:14:53', '2021-09-14 13:14:53');
/*!40000 ALTER TABLE `navigation_items` ENABLE KEYS */;

-- Dumping structure for table podcast2.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.notifications: ~0 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table podcast2.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.oauth_access_tokens: ~2 rows (approximately)
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('7a9b0cb11bff3fd1390a2a16c49641dbf75ec362d67ef4f50d63400425f6be9a45f814e4f12d938a', 1, 1, 'access_token', '["user_scope","manage_own_content","manage_everything"]', 1, '2021-09-14 13:19:22', '2021-09-14 13:19:22', '2022-09-14 13:19:22'),
	('7d0c94bec846b333a4c3edd4244cab9c187eb7f997e1e98ca4e8f0878b81ad025a529892a8b15d29', 2, 1, 'access_token', '["user_scope"]', 0, '2021-09-14 13:26:14', '2021-09-14 13:26:14', '2022-09-14 13:26:14');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table podcast2.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.oauth_auth_codes: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table podcast2.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.oauth_clients: ~2 rows (approximately)
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'EvotechMusic Personal Access Client', 'o5S3xJxrvHoQyNgzTy4yg3y3X0EfZtHY66CGghOq', NULL, 'http://localhost', 1, 0, 0, '2021-09-14 13:14:16', '2021-09-14 13:14:16'),
	(2, NULL, 'EvotechMusic Password Grant Client', 'ssSIMGvNIPM9GioOZXpMgBfdtkOOyeSlbWwj8ZLv', 'users', 'http://localhost', 0, 1, 0, '2021-09-14 13:14:17', '2021-09-14 13:14:17');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table podcast2.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.oauth_personal_access_clients: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2021-09-14 13:14:17', '2021-09-14 13:14:17');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table podcast2.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.oauth_refresh_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table podcast2.pages
CREATE TABLE IF NOT EXISTS `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.pages: ~2 rows (approximately)
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` (`id`, `name`, `icon`, `title`, `path`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'charts', '', 'Charts', '/browse/charts', '', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(2, 'home', 'home', 'Explore', '/home', 'Explore & enjoy listening to music', '2021-09-14 13:14:53', '2021-09-14 13:14:53');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;

-- Dumping structure for table podcast2.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table podcast2.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.permissions: ~37 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `description`, `role_id`, `created_at`, `updated_at`) VALUES
	(1, 'Upload songs', '', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(2, 'Download songs', 'download songs & podcast episodes.', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(3, 'Chat with friends', '', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(4, 'Listen with friends', 'Listen with friends to the same song at the same time.', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(5, 'Publish songs', 'Ability to change songs privacy to public.', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(6, 'Publish playlists', 'Ability to change playlists privacy to public.', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(7, 'No ads', 'Does not see advertisements.', 3, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(8, 'CED songs(artist)', 'Create, edit and delete songs.', 2, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(9, 'CED albums(artist)', 'Create, edit and delete albums.', 2, '2021-09-14 13:14:48', '2021-09-14 13:14:48'),
	(10, 'CED podcasts(artist)', 'Create, edit and delete podcasts.', 2, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(11, 'CED translations', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(12, 'Edit appearance', 'Ability to change how the player interface appearance @admin/appearance.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(13, 'Edit settings', 'Change the settings of the application @admin/settings.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(14, 'Edit advertisements', 'Change the advertisements settings.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(15, 'CED pages', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(16, 'CED radio_stations', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(17, 'CED plans', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(18, 'CED subscriptions', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(19, 'Create users', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(20, 'Edit users', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(21, 'Read users', 'Can see the users data.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(22, 'Delete users', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(23, 'Create artists', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(24, 'Edit artists', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(25, 'Read artists', 'Can see the artists data.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(26, 'Delete artists', '', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(27, 'CED songs', 'Create, edit and delete songs.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(28, 'CED playlists', 'Create, edit and delete playlists.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(29, 'CED song_genres', 'Create, edit and delete song genres.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(30, 'CED podcast_genres', 'Create, edit and delete podcast genres.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(31, 'CED radio stations', 'Create, edit and delete radio stations.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(32, 'CED albums', 'Create, edit and delete albums.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(33, 'CED podcasts', 'Create, edit and delete podcasts.', 1, '2021-09-14 13:14:49', '2021-09-14 13:14:49'),
	(34, 'Read roles', 'Can see the roles and their permissions.', 1, '2021-09-14 13:14:50', '2021-09-14 13:14:50'),
	(35, 'Edit roles', 'Edit or Delete role permissions.', 1, '2021-09-14 13:14:50', '2021-09-14 13:14:50'),
	(36, 'Edit user roles', 'Edit or Delete roles for a user.', 1, '2021-09-14 13:14:50', '2021-09-14 13:14:50'),
	(37, 'Edit user permissions', 'Edit or Delete permissions for a user.', 1, '2021-09-14 13:14:50', '2021-09-14 13:14:50');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table podcast2.plans
CREATE TABLE IF NOT EXISTS `plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `upgradable` tinyint(1) NOT NULL DEFAULT '1',
  `badge` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL,
  `free` tinyint(1) NOT NULL DEFAULT '1',
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval_count` int(11) NOT NULL,
  `recommended` tinyint(1) NOT NULL,
  `displayed_features` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_space` bigint(20) NOT NULL DEFAULT '100',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.plans: ~1 rows (approximately)
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` (`id`, `name`, `active`, `upgradable`, `badge`, `amount`, `position`, `free`, `currency`, `currency_symbol`, `interval`, `stripe_id`, `paypal_id`, `interval_count`, `recommended`, `displayed_features`, `storage_space`, `created_at`, `updated_at`) VALUES
	(1, 'Basic', 1, 1, NULL, 0, 1, 1, 'USD', NULL, 'month', NULL, NULL, 1, 0, '["Up to 100MB of storage","Create Playlists & Share","Unlimited Downloads"]', 100, '2021-09-14 13:14:52', '2021-09-14 13:14:52');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;

-- Dumping structure for table podcast2.plan_permission
CREATE TABLE IF NOT EXISTS `plan_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned NOT NULL,
  `plan_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.plan_permission: ~0 rows (approximately)
/*!40000 ALTER TABLE `plan_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_permission` ENABLE KEYS */;

-- Dumping structure for table podcast2.plan_role
CREATE TABLE IF NOT EXISTS `plan_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `plan_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.plan_role: ~0 rows (approximately)
/*!40000 ALTER TABLE `plan_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_role` ENABLE KEYS */;

-- Dumping structure for table podcast2.playlists
CREATE TABLE IF NOT EXISTS `playlists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17415 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.playlists: ~0 rows (approximately)
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;

-- Dumping structure for table podcast2.playlist_follows
CREATE TABLE IF NOT EXISTS `playlist_follows` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `playlist_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.playlist_follows: ~0 rows (approximately)
/*!40000 ALTER TABLE `playlist_follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_follows` ENABLE KEYS */;

-- Dumping structure for table podcast2.playlist_song
CREATE TABLE IF NOT EXISTS `playlist_song` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `song_id` int(11) NOT NULL,
  `playlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.playlist_song: ~0 rows (approximately)
/*!40000 ALTER TABLE `playlist_song` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_song` ENABLE KEYS */;

-- Dumping structure for table podcast2.plays
CREATE TABLE IF NOT EXISTS `plays` (
  `content_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.plays: ~0 rows (approximately)
/*!40000 ALTER TABLE `plays` DISABLE KEYS */;
/*!40000 ALTER TABLE `plays` ENABLE KEYS */;

-- Dumping structure for table podcast2.podcasts
CREATE TABLE IF NOT EXISTS `podcasts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `artist_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre_id` int(10) unsigned DEFAULT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54564 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.podcasts: ~0 rows (approximately)
/*!40000 ALTER TABLE `podcasts` DISABLE KEYS */;
/*!40000 ALTER TABLE `podcasts` ENABLE KEYS */;

-- Dumping structure for table podcast2.podcast_follows
CREATE TABLE IF NOT EXISTS `podcast_follows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `podcast_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.podcast_follows: ~0 rows (approximately)
/*!40000 ALTER TABLE `podcast_follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `podcast_follows` ENABLE KEYS */;

-- Dumping structure for table podcast2.podcast_genres
CREATE TABLE IF NOT EXISTS `podcast_genres` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.podcast_genres: ~6 rows (approximately)
/*!40000 ALTER TABLE `podcast_genres` DISABLE KEYS */;
INSERT INTO `podcast_genres` (`id`, `name`, `cover`, `slug`, `created_at`, `updated_at`) VALUES
	(1, 'Education', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-education.png","disk":"public","url":null}', 'education', '2021-09-14 13:14:52', '2021-09-14 13:14:52'),
	(2, 'Gaming', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-gaming.png","disk":"public","url":null}', 'gaming', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(3, 'Comedy', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-comedy.png","disk":"public","url":null}', 'comedy', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(4, 'Health', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-health.png","disk":"public","url":null}', 'health', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(5, 'Technology', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-technology.png","disk":"public","url":null}', 'technology', '2021-09-14 13:14:53', '2021-09-14 13:14:53'),
	(6, 'Arts', '{"path":"\\/storage\\/defaults\\/images\\/podcast_genres\\/podcast-art.png","disk":"public","url":null}', 'arts', '2021-09-14 13:14:53', '2021-09-14 13:14:53');
/*!40000 ALTER TABLE `podcast_genres` ENABLE KEYS */;

-- Dumping structure for table podcast2.radio_stations
CREATE TABLE IF NOT EXISTS `radio_stations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` json NOT NULL,
  `endpoint` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `highlight` tinyint(1) NOT NULL DEFAULT '0',
  `metadata_types` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icy_detection_timeout` bigint(20) NOT NULL,
  `retry_timeout` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.radio_stations: ~0 rows (approximately)
/*!40000 ALTER TABLE `radio_stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `radio_stations` ENABLE KEYS */;

-- Dumping structure for table podcast2.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.roles: ~3 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2021-09-14 13:14:50', '2021-09-14 13:14:50'),
	(2, 'artist', '2021-09-14 13:14:50', '2021-09-14 13:14:50'),
	(3, 'user', '2021-09-14 13:14:50', '2021-09-14 13:14:50');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table podcast2.role_permission
CREATE TABLE IF NOT EXISTS `role_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.role_permission: ~37 rows (approximately)
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` (`id`, `permission_id`, `role_id`) VALUES
	(1, 11, 1),
	(2, 12, 1),
	(3, 13, 1),
	(4, 14, 1),
	(5, 15, 1),
	(6, 16, 1),
	(7, 17, 1),
	(8, 18, 1),
	(9, 19, 1),
	(10, 20, 1),
	(11, 21, 1),
	(12, 22, 1),
	(13, 23, 1),
	(14, 24, 1),
	(15, 25, 1),
	(16, 26, 1),
	(17, 27, 1),
	(18, 28, 1),
	(19, 29, 1),
	(20, 30, 1),
	(21, 31, 1),
	(22, 32, 1),
	(23, 33, 1),
	(24, 34, 1),
	(25, 35, 1),
	(26, 36, 1),
	(27, 37, 1),
	(28, 8, 2),
	(29, 9, 2),
	(30, 10, 2),
	(31, 1, 3),
	(32, 2, 3),
	(33, 3, 3),
	(34, 4, 3),
	(35, 5, 3),
	(36, 6, 3),
	(37, 7, 3);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;

-- Dumping structure for table podcast2.role_user
CREATE TABLE IF NOT EXISTS `role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.role_user: ~3 rows (approximately)
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 3, NULL, NULL),
	(2, 1, 1, NULL, NULL),
	(3, 2, 3, NULL, NULL);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;

-- Dumping structure for table podcast2.sections
CREATE TABLE IF NOT EXISTS `sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_id` bigint(20) NOT NULL,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `endpoint` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT '0',
  `nb_labels` int(11) NOT NULL DEFAULT '5',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.sections: ~6 rows (approximately)
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` (`id`, `content_type`, `title`, `page_id`, `content`, `endpoint`, `rank`, `nb_labels`, `created_at`, `updated_at`) VALUES
	(1, 'songs', 'Most played songs', 1, '', 'popular-songs', 0, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(2, 'songs', 'New Releases', 1, '', 'new-releases', 1, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(3, 'songs', 'Most liked songs', 1, '', 'most-liked-songs', 2, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(4, 'albums', 'Latest Albums', 1, '', 'latest-albums', 3, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(5, 'podcasts', 'Popular Podcasts', 1, '', 'popular-podcasts', 3, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54'),
	(6, 'podcasts', 'Latest Podcasts', 1, '', 'latest-podcasts', 3, 6, '2021-09-14 13:14:54', '2021-09-14 13:14:54');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;

-- Dumping structure for table podcast2.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user1_id` int(10) unsigned NOT NULL,
  `user2_id` int(10) unsigned NOT NULL,
  `block` tinyint(1) NOT NULL DEFAULT '0',
  `blocked_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sessions_user1_id_user2_id_unique` (`user1_id`,`user2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.sessions: ~0 rows (approximately)
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Dumping structure for table podcast2.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.settings: ~76 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `key`, `value`, `public`) VALUES
	(1, 'appName', 'EvotechMusic', 1),
	(2, 'locale', 'en', 1),
	(3, 'appUrl', 'http://127.0.0.1:8000', 1),
	(4, 'appLogoLight', '/storage/defaults/images/logo_light.png', 1),
	(5, 'appLogoDark', '/storage/defaults/images/logo_dark.png', 1),
	(6, 'allowThemeChange', '1', 1),
	(7, 'enableLandingPage', '0', 1),
	(8, 'enablePodcasts', '1', 1),
	(9, 'enableBrowse', '1', 1),
	(10, 'enableAds', '0', 1),
	(11, 'allowArtistAccountRequests', '1', 1),
	(12, 'requireAuth', '0', 1),
	(13, 'disableRegistration', '0', 1),
	(14, 'allowVideos', '1', 1),
	(15, 'hideRightSidebar', '0', 1),
	(16, 'playerVolume', '50', 1),
	(17, 'aboutUs', '', 1),
	(18, 'requireEmailConfirmation', '0', 1),
	(19, 'enableGoogleLogin', '0', 1),
	(20, 'google_oauth_client_id', '', 1),
	(21, 'enableFacebookLogin', '0', 1),
	(22, 'allowUserDownloads', '1', 1),
	(23, 'downloadButton', '1', 1),
	(24, 'allowUserUploads', '1', 1),
	(25, 'enableFriendshipSystem', '1', 1),
	(26, 'enableRealtime', '0', 1),
	(27, 'pusherAppId', '', 1),
	(28, 'pusherKey', '', 1),
	(29, 'pusherCluster', '', 1),
	(30, 'pusherSecret', '', 1),
	(31, 'enableChat', '0', 1),
	(32, 'enableMail', '0', 1),
	(33, 'enableCharts', '1', 1),
	(34, 'defaultTheme', 'Light', 1),
	(35, 'square_ad', '{"code":"","position":"trs"}', 1),
	(36, 'rect_ad', '{"code":"","position":"tcp"}', 1),
	(37, 'paypalSandboxMode', '1', 0),
	(38, 'themes', '{"primary":"#4245a8","secondary":"#8C366C","dark":{"background":"#010d1f","text":"#ebebeb","panel":"#182131"},"light":{"background":"#ffffff","text":"#09021d","panel":"#f7f7f7"}}', 1),
	(39, 'landingPage', '{"sections":[{"title":"Explore & listen","description":"You can discover a variety of music & podcast genres, the artists you like, the music you vibe with, and more.","background":"\\/storage\\/defaults\\/images\\/landing\\/explore_and_listen.png"},{"title":"Listen with friends","description":"You can invite your friends to muzzie, chat with them and hear the same song at the same time. Cool isn\'t it?","background":"\\/storage\\/defaults\\/images\\/landing\\/listen_with_friends.png"},{"title":"Create your library","description":"You can upload your own beloved songs, create your best playlists, follow your favored artists, and more.","background":"\\/storage\\/defaults\\/images\\/landing\\/create_your_library.png"}],"callToAction":"Play now","showContactUs":1,"headerTitle":"Welcome to EvotechMusic","headerDescription":"Listen to music anytime & anywhere","headerBackground":"\\/images\\/landing-background.jpg","headerBackgroundLayerColor":"#9B79135E","customLandingPageHeader":1,"footerTitle":"Are you an Artist and you want to share your content ?","footerDescription":"Sign up on Muzzie now and request an Artist account, get up to 500 MB of free space and more!","footerBackground":"\\/images\\/landing-background.jpg"}', 1),
	(40, 'subscriptionButtonColor', '#FF8F00', 1),
	(41, 'subscriptionButtonText', 'upgrade', 1),
	(42, 'subscriptionButtonOutlined', '1', 1),
	(43, 'subscriptionButtonIcon', 'star', 1),
	(44, 'enableBilling', '0', 1),
	(45, 'stripeGateway', '0', 1),
	(46, 'paypalGateway', '0', 1),
	(47, 'storageDisk', '{"name":"Local Storage","disk":"public"}', 1),
	(48, 'playerLanding', '/home', 1),
	(49, 'availableUserDiskSpace', '10', 1),
	(50, 'availableArtistDiskSpace', '500', 1),
	(51, 'maxFileSize', '5', 1),
	(52, 'maxImageSize', '2', 1),
	(53, 'siteTitle', '%site_name — Play Music Anywhere & Anytime', 1),
	(54, 'siteDescription', '%site_name — Play Music Anywhere & Anytime', 1),
	(55, 'homePageTitle', 'Explore & listen | %site_name', 1),
	(56, 'homePageDescription', 'Explore & start listening to pure music on %site_name', 1),
	(57, 'browsePageTitle', 'Browse & discover music | %site_name', 1),
	(58, 'browsePageDescription', 'Discover & enjoy listening to pure music on %site_name', 1),
	(59, 'podcastsPageTitle', 'Podcasts | %site_name', 1),
	(60, 'podcastsPageDescription', 'Discover & enjoy listening to podcasts on %site_name', 1),
	(61, 'artistPageDescription', 'Enjoy hearing %artist_name  on %site_name for free', 1),
	(62, 'artistPageTitle', '%artist_name | Play on %site_name', 1),
	(63, 'songPageTitle', '%song_title — %artist_name | Play On %site_name', 1),
	(64, 'songPageDescription', '%creation_date — Play %song_name on %site_name for free', 1),
	(65, 'albumPageTitle', '%artist_name — %album_title | Play on %site_name', 1),
	(66, 'albumPageDescription', 'Play & enjoy %album_title album by %artist_name on %site_name', 1),
	(67, 'podcastPageTitle', '%artist_name — %podcast_title | Play on %site_name', 1),
	(68, 'podcastPageDescription', 'Play & enjoy %podcast_title podcast by %artist_name on %site_name', 1),
	(69, 'playlistPageTitle', '%playlist_title | Play on %site_name', 1),
	(70, 'playlistPageDescription', 'Play & enjoy %playlist_title playlist by %user_name on %site_name', 1),
	(71, 'genrePageTitle', 'Top %genre_name music | Play on %site_name', 1),
	(72, 'genrePageDescription', 'Play & enjoy %genre_name music on %site_name', 1),
	(73, 'podcastGenrePageTitle', 'Top %podcast-genre_name podcasts | Play on %site_name', 1),
	(74, 'podcastGenrePageDescription', 'Play & enjoy %podcast-genre_name podcasts on %site_name', 1),
	(75, 'userProfilePageTitle', '%user_name | %site_name', 1),
	(76, 'userProfilePageDescription', 'Check %user_name profile on %site_name', 1);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table podcast2.songs
CREATE TABLE IF NOT EXISTS `songs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` json NOT NULL,
  `download_count` bigint(20) NOT NULL DEFAULT '0',
  `source` json NOT NULL,
  `source_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `artists` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `rank_on_album` tinyint(1) DEFAULT NULL,
  `artist_id` int(11) DEFAULT NULL,
  `album_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1687415 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.songs: ~0 rows (approximately)
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;

-- Dumping structure for table podcast2.song_likes
CREATE TABLE IF NOT EXISTS `song_likes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `song_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.song_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `song_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `song_likes` ENABLE KEYS */;

-- Dumping structure for table podcast2.song_plays
CREATE TABLE IF NOT EXISTS `song_plays` (
  `song_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.song_plays: ~0 rows (approximately)
/*!40000 ALTER TABLE `song_plays` DISABLE KEYS */;
/*!40000 ALTER TABLE `song_plays` ENABLE KEYS */;

-- Dumping structure for table podcast2.subscriptions
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `renews_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_user_id_plan_id_index` (`user_id`,`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.subscriptions: ~1 rows (approximately)
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` (`id`, `user_id`, `plan_id`, `name`, `gateway_id`, `gateway`, `status`, `renews_at`, `created_at`, `updated_at`) VALUES
	(1, 2, 1, 'default', NULL, 'local', 'active', NULL, '2021-09-14 13:25:55', '2021-09-14 13:25:55');
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;

-- Dumping structure for table podcast2.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default.png',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_id` int(11) DEFAULT NULL,
  `available_disk_space` double(8,2) NOT NULL DEFAULT '0.00',
  `is_playing` text COLLATE utf8mb4_unicode_ci,
  `requested_artist_account` tinyint(1) NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `hide_activity` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_stripe_id_index` (`stripe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `avatar`, `email`, `password`, `lang`, `payment_method`, `facebook_id`, `available_disk_space`, `is_playing`, `requested_artist_account`, `is_admin`, `hide_activity`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`, `stripe_id`, `card_brand`, `card_last_four`, `trial_ends_at`) VALUES
	(1, 'Admin', '{"path":"\\/storage\\/defaults\\/images\\/user_avatar.png","disk":"public","url":null}', 'ken.vilgax@gmail.com', '$2y$10$gBA2hTs/pIM91UJLIcEiGuZ9l55Y2KCb/G5/myNafLDfqYl8zJaXS', 'en', NULL, NULL, 100.00, NULL, 0, 1, 0, NULL, NULL, '2021-09-14 13:14:55', '2021-09-14 13:14:55', NULL, NULL, NULL, NULL),
	(2, 'kenb', '{"path":"\\/storage\\/defaults\\/images\\/user_avatar.png","disk":"public","url":null}', 'kenb@gmail.com', '$2y$10$Wbcd8rlMjcJzCzAs./x6UOdc1LZFsZu0.YrBmo8CUN/a9l8.q.ukS', 'en', NULL, NULL, 10.00, NULL, 0, 0, 0, NULL, NULL, '2021-09-14 13:25:55', '2021-09-14 13:25:55', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table podcast2.user_permission
CREATE TABLE IF NOT EXISTS `user_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.user_permission: ~41 rows (approximately)
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` (`id`, `permission_id`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, NULL, NULL),
	(2, 2, 1, NULL, NULL),
	(3, 3, 1, NULL, NULL),
	(4, 4, 1, NULL, NULL),
	(5, 5, 1, NULL, NULL),
	(6, 6, 1, NULL, NULL),
	(7, 7, 1, NULL, NULL),
	(8, 11, 1, NULL, NULL),
	(9, 12, 1, NULL, NULL),
	(10, 13, 1, NULL, NULL),
	(11, 14, 1, NULL, NULL),
	(12, 15, 1, NULL, NULL),
	(13, 16, 1, NULL, NULL),
	(14, 17, 1, NULL, NULL),
	(15, 18, 1, NULL, NULL),
	(16, 19, 1, NULL, NULL),
	(17, 20, 1, NULL, NULL),
	(18, 21, 1, NULL, NULL),
	(19, 22, 1, NULL, NULL),
	(20, 23, 1, NULL, NULL),
	(21, 24, 1, NULL, NULL),
	(22, 25, 1, NULL, NULL),
	(23, 26, 1, NULL, NULL),
	(24, 27, 1, NULL, NULL),
	(25, 28, 1, NULL, NULL),
	(26, 29, 1, NULL, NULL),
	(27, 30, 1, NULL, NULL),
	(28, 31, 1, NULL, NULL),
	(29, 32, 1, NULL, NULL),
	(30, 33, 1, NULL, NULL),
	(31, 34, 1, NULL, NULL),
	(32, 35, 1, NULL, NULL),
	(33, 36, 1, NULL, NULL),
	(34, 37, 1, NULL, NULL),
	(35, 1, 2, NULL, NULL),
	(36, 2, 2, NULL, NULL),
	(37, 3, 2, NULL, NULL),
	(38, 4, 2, NULL, NULL),
	(39, 5, 2, NULL, NULL),
	(40, 6, 2, NULL, NULL),
	(41, 7, 2, NULL, NULL);
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;

-- Dumping structure for table podcast2.visiting_browsers
CREATE TABLE IF NOT EXISTS `visiting_browsers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visitors` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.visiting_browsers: ~0 rows (approximately)
/*!40000 ALTER TABLE `visiting_browsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `visiting_browsers` ENABLE KEYS */;

-- Dumping structure for table podcast2.visiting_countries
CREATE TABLE IF NOT EXISTS `visiting_countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visitors` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table podcast2.visiting_countries: ~0 rows (approximately)
/*!40000 ALTER TABLE `visiting_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `visiting_countries` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
