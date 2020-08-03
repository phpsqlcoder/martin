-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 03, 2020 at 03:47 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mikisan`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transition_in` int(11) NOT NULL DEFAULT 1,
  `transition_out` int(11) NOT NULL DEFAULT 2,
  `transition` int(11) NOT NULL DEFAULT 6,
  `type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sub_banner',
  `banner_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `user_id` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `name`, `transition_in`, `transition_out`, `transition`, `type`, `banner_type`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Home Banner', 1, 2, 6, 'main_banner', 'image', 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL),
(2, 'Sub Banner 1', 1, 2, 6, 'sub_banner', 'image', 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL);

--
-- Triggers `albums`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_album` AFTER INSERT ON `albums` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new album', concat('created the album ',NEW.name), NOW(), 'albums', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_album` AFTER UPDATE ON `albums` FOR EACH ROW BEGIN

                        DECLARE trans_in_old VARCHAR(200);
                        DECLARE trans_in_new VARCHAR(200);

                        DECLARE trans_out_old VARCHAR(200);
                        DECLARE trans_out_new VARCHAR(200);

                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the album name', concat('updated the album name of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'albums',  OLD.name, NEW.name, OLD.id);
                            END IF;

                            IF ((OLD.transition_in <=> NEW.transition_in) = 0) THEN
                            
                                SET trans_in_old = (SELECT name FROM options WHERE id = OLD.transition_in);
                                SET trans_in_new = (SELECT name FROM options WHERE id = NEW.transition_in);
 
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the album transition-in type', concat('updated the transition-in of ',OLD.name,' from ',trans_in_old,' to ',trans_in_new), NOW(), 'albums', 'trans_in_old', 'trans_in_new', OLD.id);
                            END IF;

                            IF ((OLD.transition_out <=> NEW.transition_out) = 0) THEN  

                                SET trans_out_old = (SELECT name FROM options WHERE id = OLD.transition_out);
                                SET trans_out_new = (SELECT name FROM options WHERE id = NEW.transition_out);

                                INSERT INTO cms_activity_logs (created_by, activity_type, activity_desc, dashboard_activity, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the album transition-out type', concat('updated the transition-out of ',OLD.name,' from ',trans_out_old,' to ',trans_out_new), NOW(), 'albums', 'trans_out_old', 'trans_out_new', OLD.id);
                            END IF;

                            IF ((OLD.transition <=> NEW.transition) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the album duration', concat('updated the transition duration of ',OLD.name,' from ',OLD.transition,' to ',NEW.transition, ' seconds'), NOW(), 'albums', OLD.transition, NEW.transition, OLD.id);
                            END IF;

                            IF ((OLD.type <=> NEW.type) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the album type', concat('updated the album type of ',OLD.name,' from ',OLD.type,' to ',NEW.type), NOW(), 'albums',  OLD.type, NEW.type, OLD.id);
                            END IF;

                            IF NEW.deleted_at IS NOT NULL THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'delete', 'deleted an album', concat('deleted the album ',OLD.name), NOW(), 'albums', OLD.name, '', OLD.id);
                            END IF;

                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL DEFAULT '2020-08-03',
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contents` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teaser` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `is_featured` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `image_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `category_id`, `slug`, `date`, `name`, `contents`, `teaser`, `status`, `is_featured`, `image_url`, `thumbnail_url`, `meta_title`, `meta_keyword`, `meta_description`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 0, 'lorem-ipsum-1', '2020-04-24', 'Lorem ipsum 1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Published', '1', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', NULL, 'title', 'keyword', 'description', '1', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(2, 0, 'lorem-ipsum-2', '2020-04-15', 'Lorem ipsum 2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Published', '1', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', NULL, 'title', 'keyword', 'description', '1', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(3, 0, 'lorem-ipsum-3', '2020-03-16', 'Lorem ipsum 3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Published', '1', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', NULL, 'title', 'keyword', 'description', '1', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(4, 0, 'lorem-ipsum-4', '2020-02-17', 'Lorem ipsum 4', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Published', '0', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', NULL, 'title', 'keyword', 'description', '1', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(5, 0, 'lorem-ipsum-5', '2020-01-18', 'Lorem ipsum 5', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Published', '0', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', NULL, 'title', 'keyword', 'description', '1', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL);

--
-- Triggers `articles`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_news` AFTER INSERT ON `articles` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new article', concat('created the news ',NEW.name), NOW(), 'articles', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_news` AFTER UPDATE ON `articles` FOR EACH ROW BEGIN
                        DECLARE cat_id_old VARCHAR(200);
                        DECLARE cat_id_new VARCHAR(200);

                        IF(NEW.category_id <> 0) THEN

                            IF ((OLD.category_id <=> NEW.category_id) = 0) THEN 
                                SET cat_id_old = (SELECT name FROM article_categories WHERE id = OLD.category_id);
                                SET cat_id_new = (SELECT name FROM article_categories WHERE id = NEW.category_id);

                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.category_id IS NULL THEN 'added' WHEN NEW.category_id <> 0 THEN 'update' ELSE 'remove'END, CASE WHEN OLD.category_id IS NULL THEN 'added a news category type' WHEN NEW.category_id <> 0 THEN 'updated the news category' ELSE 'removed the news category type' END, CASE WHEN OLD.category_id IS NULL THEN concat('added ',cat_id_new,' to the category of ',OLD.name) WHEN NEW.category_id <> 0 THEN concat('updated the news category of ',OLD.name,' from ', cat_id_old, ' to ',cat_id_new) ELSE concat('removed ',cat_id_old,' to the category of ',OLD.name) END, NOW(), 'articles', cat_id_old, cat_id_new, OLD.id);
                            END IF;

                        END IF;

                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the news name', concat('updated the article name of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'articles', OLD.name, NEW.name, OLD.id);
                            END IF;

                            IF ((OLD.deleted_at <=> NEW.deleted_at) = 0) THEN 
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'delete' ELSE 'restore' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'deleted a news' ELSE 'restore a news' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN concat('deleted the news ',OLD.name) ELSE concat('restores the news ', OLD.name) END, NOW(), 'articles', OLD.name, '', OLD.id);
                            END IF;

                            IF ((OLD.date <=> NEW.date) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the news date', concat('updated the date of ',OLD.name,' from ',OLD.date,' to ',NEW.date), NOW(), 'articles', OLD.date, NEW.date, OLD.id);
                            END IF;

                            IF ((OLD.image_url <=> NEW.image_url) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'upload', 'uploaded a new banner', concat('uploaded new banner of ',OLD.name), NOW(), 'articles', OLD.image_url, NEW.image_url, OLD.id);
                            END IF;

                            IF ((OLD.contents <=> NEW.contents) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the news content', 'updated the content from ', NOW(), 'articles', OLD.contents, NEW.contents, OLD.id);
                            END IF;

                            IF ((OLD.teaser <=> NEW.teaser) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.teaser IS NULL THEN 'insert' WHEN NEW.teaser IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.teaser IS NULL THEN 'added a news teaser' WHEN NEW.teaser IS NULL THEN 'removed the news teaser' ELSE 'updated the news teaser' END, CASE WHEN OLD.teaser IS NULL THEN concat('added ',NEW.teaser,' to teaser of ',OLD.name) WHEN NEW.teaser IS NULL THEN concat('removed ',OLD.teaser,' from teaser of ',OLD.name) ELSE concat('updated the teaser of ',OLD.name,' from ',OLD.teaser,' to ',NEW.teaser) END, NOW(), 'articles', OLD.teaser, NEW.teaser, OLD.id);
                            END IF;
                            
                            IF ((OLD.status <=> NEW.status) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the news status', concat('updated the status of ',OLD.name,' from ',OLD.status,' to ',NEW.status), NOW(), 'articles', OLD.status, NEW.status, OLD.id);
                            END IF;

                            IF ((OLD.is_featured <=> NEW.is_featured) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', concat('updated the news type into ',CASE WHEN NEW.is_featured = 1 THEN 'featured' ELSE 'unfeatured' END), concat('updated the news ',OLD.name,' into ',CASE WHEN NEW.is_featured = 1 THEN 'featured' ELSE 'unfeatured' END), NOW(), 'articles', OLD.is_featured, NEW.is_featured, OLD.id);
                            END IF;

                            IF ((OLD.meta_title <=> NEW.meta_title) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_title IS NULL THEN 'insert' WHEN NEW.meta_title IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_title IS NULL THEN 'added a news meta title' WHEN NEW.meta_title IS NULL THEN 'removed the news meta title' ELSE 'updated the news meta title' END, CASE WHEN OLD.meta_title IS NULL THEN concat('added ',NEW.meta_title,' to meta title of ',OLD.name) WHEN NEW.meta_title IS NULL THEN concat('removed ',OLD.meta_title,' from meta title of ',OLD.name) ELSE concat('updated the meta title of ',OLD.name,' from ',OLD.meta_title,' to ',NEW.meta_title) END, NOW(), 'articles', OLD.meta_title, NEW.meta_title, OLD.id);
                            END IF;

                            IF ((OLD.meta_keyword <=> NEW.meta_keyword) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_keyword IS NULL THEN 'insert' WHEN NEW.meta_keyword IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_keyword IS NULL THEN 'added a news meta keyword' WHEN NEW.meta_keyword IS NULL THEN 'removed the news meta keyword' ELSE 'updated the news meta keyword' END, CASE WHEN OLD.meta_keyword IS NULL THEN concat('added ',NEW.meta_keyword,' to meta keyword of ',OLD.name) WHEN NEW.meta_keyword IS NULL THEN concat('removed ',OLD.meta_keyword,' from meta keyword of ',OLD.name) ELSE concat('updated the meta keyword of ',OLD.name,' from ',OLD.meta_keyword,' to ',NEW.meta_keyword) END, NOW(), 'articles', OLD.meta_keyword, NEW.meta_keyword, OLD.id);
                            END IF;

                            IF ((OLD.meta_description <=> NEW.meta_description) = 0)  THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_description IS NULL THEN 'insert' WHEN NEW.meta_description IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_description IS NULL THEN 'added a news meta description' WHEN NEW.meta_description IS NULL THEN 'removed the news meta description' ELSE 'updated the news meta description' END, CASE WHEN OLD.meta_description IS NULL THEN concat('added ',NEW.meta_description,' to meta description of ',OLD.name) WHEN NEW.meta_description IS NULL THEN concat('removed ',OLD.meta_description,' from meta description of ',OLD.name) ELSE concat('updated the meta description of ',OLD.name,' from ',OLD.meta_description,' to ',NEW.meta_description) END, NOW(), 'articles', OLD.meta_description, NEW.meta_description, OLD.id);
                            END IF;
                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `article_categories`
--

CREATE TABLE `article_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `article_categories`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_category` AFTER INSERT ON `article_categories` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new article category', concat('created the news category ',NEW.name), NOW(), 'news category', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_news_category` AFTER UPDATE ON `article_categories` FOR EACH ROW BEGIN
                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the news category name', concat('updated the news category name of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'news category', OLD.name, NEW.name, OLD.id);
                            END IF;

                            IF ((OLD.deleted_at <=> NEW.deleted_at) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'delete' ELSE 'restore' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'deleted a news category' ELSE 'restores the news category' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN concat('deleted the news category ',OLD.name) ELSE concat('restores the news category ', OLD.name) END, NOW(), 'news category', OLD.name, '', OLD.id);
                            END IF;

                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(10) UNSIGNED NOT NULL,
  `album_id` int(11) NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `button_text` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `album_id`, `title`, `description`, `alt`, `image_path`, `button_text`, `url`, `order`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Lorem ipsum1', 'Lorem ipsum1 Lorem ipsum1 Lorem ipsum1 Lorem ipsum1', 'Banner 1', 'http://localhost/theme/richams/images/banners/image1.jpg', NULL, 'http://localhost', 1, 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL),
(2, 1, 'Lorem ipsum2', 'Lorem ipsum2 Lorem ipsum2 Lorem ipsum2 Lorem ipsum2', 'Banner 2', 'http://localhost/theme/richams/images/banners/image2.jpg', NULL, 'http://localhost', 2, 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL),
(3, 2, NULL, NULL, NULL, 'http://localhost/theme/richams/images/banners/sub-banner-bg.jpg', NULL, NULL, 1, 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL),
(4, 2, NULL, NULL, NULL, 'http://localhost/theme/richams/images/banners/sub-banner-bg.jpg', NULL, NULL, 2, 1, '2020-08-02 23:46:07', '2020-08-02 23:46:07', NULL);

--
-- Triggers `banners`
--
DELIMITER $$
CREATE TRIGGER `tr_update_banners` AFTER UPDATE ON `banners` FOR EACH ROW BEGIN
            
            IF ((OLD.title <=> NEW.title) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.title IS NULL THEN 'insert' WHEN NEW.title IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.title IS NULL THEN 'added a banner title' WHEN NEW.title IS NULL THEN 'removed a banner title' ELSE 'updated the banner title' END , CASE WHEN OLD.title IS NULL THEN concat('added the banner title ',NEW.title) WHEN NEW.title IS NULL THEN concat('removed a banner title ',OLD.title) ELSE concat('updated the banner title ',NEW.title,' from ',OLD.title,' to ',NEW.title) END, NOW(), 'banners', OLD.title, NEW.title, OLD.id);

            END IF;

            IF ((OLD.description <=> NEW.description) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.description IS NULL THEN 'insert' WHEN NEW.description IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.description IS NULL THEN 'added a banner description' WHEN NEW.description IS NULL THEN 'removed a banner description' ELSE 'updated the banner description' END , CASE WHEN OLD.description IS NULL THEN concat('added the banner description ',NEW.description) WHEN NEW.description IS NULL THEN concat('removed a banner description ',OLD.description) ELSE concat('updated the banner description ',NEW.description,' from ',OLD.description,' to ',NEW.description) END, NOW(), 'banners', OLD.description, NEW.description, OLD.id);

            END IF;

            IF ((OLD.alt <=> NEW.alt) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.alt IS NULL THEN 'insert' WHEN NEW.alt IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.alt IS NULL THEN 'added a banner alt' WHEN NEW.alt IS NULL THEN 'removed a banner alt' ELSE 'updated the banner alt' END , CASE WHEN OLD.alt IS NULL THEN concat('added the banner alt ',NEW.alt) WHEN NEW.alt IS NULL THEN concat('removed a banner alt ',OLD.alt) ELSE concat('updated the banner alt ',NEW.alt,' from ',OLD.alt,' to ',NEW.alt) END, NOW(), 'banners', OLD.alt, NEW.alt, OLD.id);

            END IF;

            IF ((OLD.button_text <=> NEW.button_text) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.button_text IS NULL THEN 'insert' WHEN NEW.button_text IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.button_text IS NULL THEN 'added a button text in a banner' WHEN NEW.button_text IS NULL THEN 'removed a button text of a banner' ELSE 'updated the button text of the banner' END , CASE WHEN OLD.button_text IS NULL THEN concat('added the button text ',NEW.button_text,' of ',OLD.title) WHEN NEW.button_text IS NULL THEN concat('removed the button text ',OLD.button_text,' of ',OLD.title) ELSE concat('updated the button text ',NEW.button_text,' from ',OLD.button_text,' to ',NEW.button_text) END, NOW(), 'banners', OLD.button_text, NEW.button_text, OLD.id);

            END IF;

            IF ((OLD.url <=> NEW.url) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.url IS NULL THEN 'insert' WHEN NEW.url IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.url IS NULL THEN 'added a banner url' WHEN NEW.url IS NULL THEN 'removed a banner url' ELSE 'updated the banner url' END , CASE WHEN OLD.url IS NULL THEN concat('added a banner url ',NEW.url,' of ',OLD.title) WHEN NEW.url IS NULL THEN concat('removed the banner url ',OLD.url,' of ',OLD.title) ELSE concat('updated the banner url ',NEW.url,' from ',OLD.url,' to ',NEW.url) END, NOW(), 'banners', OLD.url, NEW.url, OLD.id);

            END IF;

            IF ((OLD.order <=> NEW.order) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the banner order', concat('updated the banner order of ',OLD.title,' from ',OLD.order,' to ',NEW.order), NOW(), 'banners', OLD.order, NEW.order, OLD.id);

            END IF;

            IF ((OLD.deleted_at <=> NEW.deleted_at) = 0) THEN  
                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'delete', 'deleted a banner', concat('deleted the banner ',OLD.title), NOW(), 'banners', OLD.title, '', OLD.id);
            END IF;

        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_activity_logs`
--

CREATE TABLE `cms_activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_activity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_desc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_date` datetime DEFAULT NULL,
  `db_table` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cms_activity_logs`
--

INSERT INTO `cms_activity_logs` (`id`, `created_by`, `activity_type`, `dashboard_activity`, `activity_desc`, `activity_date`, `db_table`, `old_value`, `new_value`, `reference`) VALUES
(1, '1', 'insert', 'created a new album', 'created the album Home Banner', '2020-08-03 07:46:07', 'albums', NULL, 'Home Banner', NULL),
(2, '1', 'insert', 'created a new album', 'created the album Sub Banner 1', '2020-08-03 07:46:07', 'albums', NULL, 'Sub Banner 1', NULL),
(3, '1', 'insert', 'created a new page', 'created the page Home', '2020-08-03 07:46:08', 'pages', NULL, 'Home', NULL),
(4, '1', 'insert', 'created a new page', 'created the page About Us', '2020-08-03 07:46:08', 'pages', NULL, 'About Us', NULL),
(5, '1', 'insert', 'created a new page', 'created the page Contact Us', '2020-08-03 07:46:08', 'pages', NULL, 'Contact Us', NULL),
(6, '1', 'insert', 'created a new page', 'created the page News', '2020-08-03 07:46:08', 'pages', NULL, 'News', NULL),
(7, '1', 'insert', 'created a new page', 'created the page Footer', '2020-08-03 07:46:08', 'pages', NULL, 'Footer', NULL),
(8, '1', 'insert', 'created a new page', 'created the page Products', '2020-08-03 07:46:08', 'pages', NULL, 'Products', NULL),
(9, '1', 'insert', 'created a new article', 'created the news Lorem ipsum 1', '2020-08-03 07:46:08', 'articles', NULL, 'Lorem ipsum 1', NULL),
(10, '1', 'insert', 'created a new article', 'created the news Lorem ipsum 2', '2020-08-03 07:46:08', 'articles', NULL, 'Lorem ipsum 2', NULL),
(11, '1', 'insert', 'created a new article', 'created the news Lorem ipsum 3', '2020-08-03 07:46:08', 'articles', NULL, 'Lorem ipsum 3', NULL),
(12, '1', 'insert', 'created a new article', 'created the news Lorem ipsum 4', '2020-08-03 07:46:08', 'articles', NULL, 'Lorem ipsum 4', NULL),
(13, '1', 'insert', 'created a new article', 'created the news Lorem ipsum 5', '2020-08-03 07:46:08', 'articles', NULL, 'Lorem ipsum 5', NULL),
(14, '1', 'insert', 'created a new role', 'created the role Admin', '2020-08-03 07:46:08', 'role', NULL, 'Admin', NULL),
(15, '1', 'insert', 'created a new permission', 'created the permission View Page', '2020-08-03 07:46:08', 'permission', NULL, 'View Page', NULL),
(16, '1', 'insert', 'created a new permission', 'created the permission Create Page', '2020-08-03 07:46:08', 'permission', NULL, 'Create Page', NULL),
(17, '1', 'insert', 'created a new permission', 'created the permission Edit Page', '2020-08-03 07:46:08', 'permission', NULL, 'Edit Page', NULL),
(18, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore page', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore page', NULL),
(19, '1', 'insert', 'created a new permission', 'created the permission Change Status of Page', '2020-08-03 07:46:08', 'permission', NULL, 'Change Status of Page', NULL),
(20, '1', 'insert', 'created a new permission', 'created the permission View Album', '2020-08-03 07:46:08', 'permission', NULL, 'View Album', NULL),
(21, '1', 'insert', 'created a new permission', 'created the permission Create Album', '2020-08-03 07:46:08', 'permission', NULL, 'Create Album', NULL),
(22, '1', 'insert', 'created a new permission', 'created the permission Edit Album', '2020-08-03 07:46:08', 'permission', NULL, 'Edit Album', NULL),
(23, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore album', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore album', NULL),
(24, '1', 'insert', 'created a new permission', 'created the permission Manage File manager', '2020-08-03 07:46:08', 'permission', NULL, 'Manage File manager', NULL),
(25, '1', 'insert', 'created a new permission', 'created the permission View menu', '2020-08-03 07:46:08', 'permission', NULL, 'View menu', NULL),
(26, '1', 'insert', 'created a new permission', 'created the permission Create Menu', '2020-08-03 07:46:08', 'permission', NULL, 'Create Menu', NULL),
(27, '1', 'insert', 'created a new permission', 'created the permission Edit Menu', '2020-08-03 07:46:08', 'permission', NULL, 'Edit Menu', NULL),
(28, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore menu', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore menu', NULL),
(29, '1', 'insert', 'created a new permission', 'created the permission View news', '2020-08-03 07:46:08', 'permission', NULL, 'View news', NULL),
(30, '1', 'insert', 'created a new permission', 'created the permission Create News', '2020-08-03 07:46:08', 'permission', NULL, 'Create News', NULL),
(31, '1', 'insert', 'created a new permission', 'created the permission Edit news', '2020-08-03 07:46:08', 'permission', NULL, 'Edit news', NULL),
(32, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore News', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore News', NULL),
(33, '1', 'insert', 'created a new permission', 'created the permission Change Status of News', '2020-08-03 07:46:08', 'permission', NULL, 'Change Status of News', NULL),
(34, '1', 'insert', 'created a new permission', 'created the permission View News Category', '2020-08-03 07:46:08', 'permission', NULL, 'View News Category', NULL),
(35, '1', 'insert', 'created a new permission', 'created the permission Create news category', '2020-08-03 07:46:08', 'permission', NULL, 'Create news category', NULL),
(36, '1', 'insert', 'created a new permission', 'created the permission Edit news category', '2020-08-03 07:46:08', 'permission', NULL, 'Edit news category', NULL),
(37, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore news category', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore news category', NULL),
(38, '1', 'insert', 'created a new permission', 'created the permission Edit website settings', '2020-08-03 07:46:08', 'permission', NULL, 'Edit website settings', NULL),
(39, '1', 'insert', 'created a new permission', 'created the permission View audit logs', '2020-08-03 07:46:08', 'permission', NULL, 'View audit logs', NULL),
(40, '1', 'insert', 'created a new permission', 'created the permission View users', '2020-08-03 07:46:08', 'permission', NULL, 'View users', NULL),
(41, '1', 'insert', 'created a new permission', 'created the permission Create user', '2020-08-03 07:46:08', 'permission', NULL, 'Create user', NULL),
(42, '1', 'insert', 'created a new permission', 'created the permission Edit user', '2020-08-03 07:46:08', 'permission', NULL, 'Edit user', NULL),
(43, '1', 'insert', 'created a new permission', 'created the permission Change status of user', '2020-08-03 07:46:08', 'permission', NULL, 'Change status of user', NULL),
(44, '1', 'insert', 'created a new permission', 'created the permission View Product Category', '2020-08-03 07:46:08', 'permission', NULL, 'View Product Category', NULL),
(45, '1', 'insert', 'created a new permission', 'created the permission Create Product Category', '2020-08-03 07:46:08', 'permission', NULL, 'Create Product Category', NULL),
(46, '1', 'insert', 'created a new permission', 'created the permission Edit Product Category', '2020-08-03 07:46:08', 'permission', NULL, 'Edit Product Category', NULL),
(47, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore Product Category', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore Product Category', NULL),
(48, '1', 'insert', 'created a new permission', 'created the permission Change Status of Product Category', '2020-08-03 07:46:08', 'permission', NULL, 'Change Status of Product Category', NULL),
(49, '1', 'insert', 'created a new permission', 'created the permission View Product', '2020-08-03 07:46:08', 'permission', NULL, 'View Product', NULL),
(50, '1', 'insert', 'created a new permission', 'created the permission Create Product', '2020-08-03 07:46:08', 'permission', NULL, 'Create Product', NULL),
(51, '1', 'insert', 'created a new permission', 'created the permission Edit Product', '2020-08-03 07:46:08', 'permission', NULL, 'Edit Product', NULL),
(52, '1', 'insert', 'created a new permission', 'created the permission Delete/Restore Product', '2020-08-03 07:46:08', 'permission', NULL, 'Delete/Restore Product', NULL),
(53, '1', 'insert', 'created a new permission', 'created the permission Change Status of Product', '2020-08-03 07:46:08', 'permission', NULL, 'Change Status of Product', NULL),
(54, '1', 'insert', 'created a new user', 'created the user Admin', '2020-08-03 07:46:08', 'users', NULL, 'Admin', NULL),
(55, '1', 'remove', 'removed the website favicon', 'removed the website favicon', '2020-08-03 07:48:37', 'settings', 'favicon.ico', '', '1'),
(56, '1', 'upload', 'uploaded new website favicon', 'uploaded a new website favicon', '2020-08-03 07:48:51', 'settings', '', '1596412131_favicon.ico', '1'),
(57, '1', 'update', 'updated the company logo', 'updated the company logo', '2020-08-03 07:49:05', 'settings', '1596412131_favicon.ico', '1596412131_favicon.ico', '1'),
(58, '1', 'update_content', 'updated the page content', 'updated the page content from ', '2020-08-03 08:03:27', 'pages', '<section class=\"product-promo-wrapper wrapper\">\n            <div class=\"container\">\n                <div class=\"row\">\n                    <div class=\"col-lg-12\">\n                        <div class=\"product-promo-items\">\n                            <div class=\"product-promo-item\">\n                                <div class=\"product-promo-image\"><a href=\"http://localhost/products\"><img src=\"http://localhost/theme/richams/images/misc/promo1.jpg\" /></a></div>\n                            </div>\n                            <div class=\"product-promo-item\">\n                                <div class=\"product-promo-image\"><a href=\"http://localhost/products\"><img src=\"http://localhost/theme/richams/images/misc/promo2.jpg\" /></a></div>\n                            </div>\n                            <div class=\"product-promo-item\">\n                                <div class=\"product-promo-image\"><a href=\"http://localhost/products\"><img src=\"http://localhost/theme/richams/images/misc/promo3.jpg\" /></a></div>\n                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n        </section>\n        {Featured Products}\n        {Best Seller Products}\n        {Featured Articles}', '<div class=\"slick-slider\" id=\"banner\">\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image1.jpg\" /></div>\r\n            <!--<div class=\"banner-text pl-lg-5 ml-lg-5 p-md-5 d-flex align-items-center\">\r\n                <div class=\"jumbotron banner-welcome p-0 m-0\">\r\n                  <h2 class=\"display-4\">Team of Skilled Pros</h2>\r\n                  <p class=\"lead\">Led by few seasoned advertising industry pros, our agency delivers innovative <br>solutions across all the mediums available nowadays.</p>\r\n                  <a class=\"btn btn-primary btn-lg btn-main\" href=\"#\" role=\"button\">Learn more</a>\r\n                </div>\r\n            </div>-->\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image2.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image3.jpg\" /></div>\r\n          </div>\r\n        </div>', '1'),
(59, '1', 'update', 'updated the page meta keyword', 'updated the meta keyword of Home from home to Home page', '2020-08-03 08:03:27', 'pages', 'home', 'Home page', '1'),
(60, '1', 'update', 'updated the page meta description', 'updated the meta description of Home from Home page to home', '2020-08-03 08:03:27', 'pages', 'Home page', 'home', '1'),
(61, '1', 'update', 'updated the page meta keyword', 'updated the meta keyword of Home from Home page to home', '2020-08-03 08:04:16', 'pages', 'Home page', 'home', '1'),
(62, '1', 'update', 'updated the page meta description', 'updated the meta description of Home from home to Home page', '2020-08-03 08:04:16', 'pages', 'home', 'Home page', '1'),
(63, '1', 'update_content', 'updated the page content', 'updated the page content from ', '2020-08-03 08:05:38', 'pages', '<div class=\"slick-slider\" id=\"banner\">\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image1.jpg\" /></div>\r\n            <!--<div class=\"banner-text pl-lg-5 ml-lg-5 p-md-5 d-flex align-items-center\">\r\n                <div class=\"jumbotron banner-welcome p-0 m-0\">\r\n                  <h2 class=\"display-4\">Team of Skilled Pros</h2>\r\n                  <p class=\"lead\">Led by few seasoned advertising industry pros, our agency delivers innovative <br>solutions across all the mediums available nowadays.</p>\r\n                  <a class=\"btn btn-primary btn-lg btn-main\" href=\"#\" role=\"button\">Learn more</a>\r\n                </div>\r\n            </div>-->\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image2.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"images/banners/image3.jpg\" /></div>\r\n          </div>\r\n        </div>', '<div class=\"slick-slider\" id=\"banner\">\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image1.jpg\" /></div>\r\n<!--<div class=\"banner-text pl-lg-5 ml-lg-5 p-md-5 d-flex align-items-center\">\r\n                <div class=\"jumbotron banner-welcome p-0 m-0\">\r\n                  <h2 class=\"display-4\">Team of Skilled Pros</h2>\r\n                  <p class=\"lead\">Led by few seasoned advertising industry pros, our agency delivers innovative <br>solutions across all the mediums available nowadays.</p>\r\n                  <a class=\"btn btn-primary btn-lg btn-main\" href=\"#\" role=\"button\">Learn more</a>\r\n                </div>\r\n            </div>--></div>\r\n\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/images/banners/image2.jpg\" /></div>\r\n</div>\r\n\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/images/banners/image3.jpg\" /></div>\r\n</div>\r\n</div>', '1'),
(64, '1', 'update', 'updated the page meta keyword', 'updated the meta keyword of Home from home to Home page', '2020-08-03 08:05:38', 'pages', 'home', 'Home page', '1'),
(65, '1', 'update', 'updated the page meta description', 'updated the meta description of Home from Home page to home', '2020-08-03 08:05:38', 'pages', 'Home page', 'home', '1'),
(66, '1', 'update_content', 'updated the page content', 'updated the page content from ', '2020-08-03 08:07:27', 'pages', '<div class=\"slick-slider\" id=\"banner\">\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image1.jpg\" /></div>\r\n<!--<div class=\"banner-text pl-lg-5 ml-lg-5 p-md-5 d-flex align-items-center\">\r\n                <div class=\"jumbotron banner-welcome p-0 m-0\">\r\n                  <h2 class=\"display-4\">Team of Skilled Pros</h2>\r\n                  <p class=\"lead\">Led by few seasoned advertising industry pros, our agency delivers innovative <br>solutions across all the mediums available nowadays.</p>\r\n                  <a class=\"btn btn-primary btn-lg btn-main\" href=\"#\" role=\"button\">Learn more</a>\r\n                </div>\r\n            </div>--></div>\r\n\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/images/banners/image2.jpg\" /></div>\r\n</div>\r\n\r\n<div class=\"banner-wrapper\">\r\n<div class=\"banner-image\"><img src=\"theme/mikisan/images/images/banners/image3.jpg\" /></div>\r\n</div>\r\n</div>', 'aaa', '1'),
(67, '1', 'update', 'updated the page meta keyword', 'updated the meta keyword of Home from Home page to home', '2020-08-03 08:07:27', 'pages', 'Home page', 'home', '1'),
(68, '1', 'update', 'updated the page meta description', 'updated the meta description of Home from home to Home page', '2020-08-03 08:07:27', 'pages', 'home', 'Home page', '1'),
(69, '1', 'update_content', 'updated the page content', 'updated the page content from ', '2020-08-03 08:11:49', 'pages', 'aaa', '<div class=\"slick-slider\" id=\"banner\">\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image1.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image2.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image3.jpg\" /></div>\r\n          </div>\r\n        </div>', '1'),
(70, '1', 'update', 'updated the page meta keyword', 'updated the meta keyword of Home from home to Home page', '2020-08-03 08:11:49', 'pages', 'home', 'Home page', '1'),
(71, '1', 'update', 'updated the page meta description', 'updated the meta description of Home from Home page to home', '2020-08-03 08:11:49', 'pages', 'Home page', 'home', '1'),
(72, '1', 'update_content', 'updated the page content', 'updated the page content from ', '2020-08-03 08:16:05', 'pages', '<p>Sed quis iaculis risus, in dapibus nisi. Etiam dictum, ligula eget vehicula facilisis, turpis ipsum euismod tortor, at tristique lectus turpis vel lorem. Praesent in libero commodo dolor mollis consequat. Quisque in metus fringilla, aliquam sem eu, ornare ipsum. Donec commodo sagittis lacinia. Aenean elementum porttitor metus, ac rutrum ex condimentum eget. Ut est purus, interdum id sem nec, vehicula scelerisque purus. Quisque nec neque risus. Aliquam rhoncus lectus vitae massa imperdiet ullamcorper. Nunc sodales vehicula iaculis. </p>\n					<p>Sed vel placerat metus. Etiam consequat, nisi semper lobortis posuere, ex sem pretium lectus, ac pulvinar diam nibh tincidunt felis. Duis eget facilisis quam, in accumsan erat. Duis ornare ut augue nec efficitur. Donec in sem accumsan, dapibus magna vel, iaculis nisi. Duis sed ante vulputate, fermentum ligula eget, luctus nulla. Nunc sodales congue quam, non cursus elit pellentesque sed. Integer a congue sapien, vel pulvinar erat. Vestibulum eu ullamcorper nibh. Nullam euismod ex quis arcu fermentum molestie. Vivamus volutpat ut urna eget cursus. </p>', '<section class=\"bg-main wrapper\">\r\n        <div class=\"container\">\r\n            <div class=\"row\">\r\n                <div class=\"col-lg-5\">\r\n                    <h4 class=\"title-secondary\">get in touch with us</h4>\r\n                    <div class=\"gap-10\"></div>\r\n                    <form id=\"contactUsForm\" method=\"POST\" action=\"{{ route(\'contact-us\') }}\">\r\n                        @csrf\r\n                        @if(session()->has(\'success\') && session())\r\n                            <div class=\"alert alert-success\">\r\n                                {{ session()->get(\'success\') }}\r\n                            </div>\r\n                        @endif\r\n                        @if(session()->has(\'error\'))\r\n                            <div class=\"alert alert-danger\">\r\n                                {{ session()->get(\'error\') }}\r\n                            </div>\r\n                        @endif\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_name\">Name *</label>\r\n                            <input id=\"form_name\" type=\"text\" name=\"name\" class=\"form-control\" placeholder=\"Your name\" required=\"required\">\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_email\">Email *</label>\r\n                            <input id=\"form_email\" type=\"email\" name=\"email\" class=\"form-control\" placeholder=\"name@website.com\" required=\"required\">\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_number\">Contact Number *</label>\r\n                            <input id=\"form_number\" type=\"text\" name=\"contact\" class=\"form-control\" placeholder=\"Your contact number *\" required=\"required\">\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_message\">Message *</label>\r\n                            <textarea id=\"form_message\" name=\"message\" class=\"form-control\" placeholder=\"Message\" rows=\"4\" required=\"required\"></textarea>\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <script src=\"https://www.google.com/recaptcha/api.js?hl=en\" async=\"\" defer=\"\" ></script>\r\n                            <div class=\"g-recaptcha\" data-sitekey=\"{{ \\Setting::info()->google_recaptcha_sitekey }}\"></div>\r\n                            <label class=\"control-label text-danger\" for=\"g-recaptcha-response\" id=\"catpchaError\" style=\"display:none;\"><i class=\"fa fa-times-circle-o\"></i>The Captcha field is required.</label></br>\r\n                            @if($errors->has(\'g-recaptcha-response\'))\r\n                                @foreach($errors->get(\'g-recaptcha-response\') as $message)\r\n                                    <label class=\"control-label text-danger\" for=\"g-recaptcha-response\"><i class=\"fa fa-times-circle-o\"></i>{{ $message }}</label></br>\r\n                                @endforeach\r\n                            @endif\r\n                        </div>\r\n                        <button type=\"submit\" class=\"btn btn-primary btn-third\">Submit</button>\r\n                    </form>\r\n                    <div class=\"gap-50\"></div>\r\n                </div>\r\n                <div class=\"col-lg-7\">\r\n                    <h4 class=\"title-secondary\">find us on the map</h4>\r\n                    <div class=\"gap-10\"></div>\r\n                    <iframe class=\"mt-2 mb-4\" src=\"{{ \\Setting::info()->google_map }}\" width=\"100%\" height=\"500\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\" aria-hidden=\"false\" tabindex=\"0\"></iframe>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </section>', '2'),
(73, '1', 'update', 'updated the website name', 'updated the website name from WebFocus Solutions, Inc. to Mikisan Soap', '2020-08-03 09:04:24', 'settings', 'WebFocus Solutions, Inc.', 'Mikisan Soap', '1'),
(74, '1', 'update', 'updated the company name', 'updated the company name from WebFocus Solutions, Inc. to Mikisan Soap', '2020-08-03 09:04:24', 'settings', 'WebFocus Solutions, Inc.', 'Mikisan Soap', '1');

-- --------------------------------------------------------

--
-- Table structure for table `email_recipients`
--

CREATE TABLE `email_recipients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 0,
  `pages_json` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `is_active`, `pages_json`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Menu 1', 1, '[{\"label\":\"Home\",\"type\":\"page\",\"page_id\":1,\"id\":1}]', NULL, '2020-08-02 23:46:07', '2020-08-03 00:47:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menus_has_pages`
--

CREATE TABLE `menus_has_pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `page_order` int(11) NOT NULL,
  `label` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uri` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus_has_pages`
--

INSERT INTO `menus_has_pages` (`id`, `menu_id`, `parent_id`, `page_id`, `page_order`, `label`, `uri`, `target`, `type`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 0, 1, 1, 'Home', '', '', 'page', '2020-08-02 23:46:08', '2020-08-03 00:47:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_01_070553_create_banners_table', 1),
(4, '2019_08_01_074749_create_albums_table', 1),
(5, '2019_08_01_080124_create_pages_table', 1),
(6, '2019_08_01_081226_create_menus_table', 1),
(7, '2019_08_01_081727_create_menus_has_pages_table', 1),
(8, '2019_08_01_083635_create_settings_table', 1),
(9, '2019_08_02_023228_create_permission_table', 1),
(10, '2019_08_02_023316_create_role_table', 1),
(11, '2019_08_02_023344_create_role_permission_table', 1),
(12, '2019_08_07_085124_create_options_table', 1),
(13, '2019_09_06_001827_create_article_table', 1),
(14, '2019_09_06_014453_create_view_role_permission', 1),
(15, '2019_09_06_015345_create_view_access_permission_per_role', 1),
(16, '2019_09_06_061723_create_cms_activity_logs', 1),
(17, '2019_09_06_064837_create_insert_trigger_for_role_table', 1),
(18, '2019_09_06_074211_create_update_trigger_for_role_table', 1),
(19, '2019_09_06_074222_create_delete_trigger_for_role_table', 1),
(20, '2019_09_09_035417_create_insert_trigger_for_pages_table', 1),
(21, '2019_09_09_051253_create_update_trigger_for_pages_table', 1),
(22, '2019_09_10_060247_create_view_activity_logs', 1),
(23, '2019_09_11_033003_create_insert_trigger_for_permission_table', 1),
(24, '2019_09_12_070707_create_article_category_table', 1),
(25, '2019_10_03_101947_create_insert_trigger_for_album_table', 1),
(26, '2019_10_03_102338_create_update_trigger_for_album_table', 1),
(27, '2019_10_03_103225_create_insert_trigger_for_news_table', 1),
(28, '2019_10_03_103411_create_update_trigger_for_news_table', 1),
(29, '2019_11_07_084546_create_insert_trigger_for_news_category_table', 1),
(30, '2019_11_07_085006_create_update_trigger_for_news_category_table', 1),
(31, '2019_11_07_155340_create_update_trigger_for_users_table', 1),
(32, '2019_11_07_171058_create_update_trigger_for_settings_table', 1),
(33, '2019_11_08_084348_create_insert_trigger_for_users_table', 1),
(34, '2019_11_08_104730_create_update_trigger_for_permission_table', 1),
(35, '2019_11_17_102141_create_insert_trigger_for_access_permssion_table', 1),
(36, '2019_11_17_104718_create_update_trigger_for_access_permssion_table', 1),
(37, '2019_11_17_120625_create_social_media_accounts_table', 1),
(38, '2019_11_17_134938_create_delete_trigger_for_media_account_table', 1),
(39, '2019_11_17_140018_create_insert_trigger_for_media_account_table', 1),
(40, '2019_11_17_140350_create_update_trigger_for_media_account_table', 1),
(41, '2019_12_11_102219_create_update_trigger_for_banners_table', 1),
(42, '2020_04_15_192111_add_contact_us_email_layout_in_settings_table', 1),
(43, '2020_04_15_192215_create_email_recipients_table', 1),
(44, '2020_04_17_151740_add_banner_type_in_albums_table', 1),
(45, '2020_04_17_183608_add_thumbnail_in_articles_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `type`, `name`, `value`, `field_type`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'animation', 'Fade In', 'fadeIn', 'entrance', NULL, NULL, NULL),
(2, 'animation', 'Fade Out', 'fadeOut', 'exit', NULL, NULL, NULL),
(3, 'animation', 'Fade In Down', 'fadeInDown', 'entrance', NULL, NULL, NULL),
(4, 'animation', 'Fade Out Down', 'fadeOutDown', 'exit', NULL, NULL, NULL),
(5, 'animation', 'Fade In Down Big', 'fadeInDownBig', 'entrance', NULL, NULL, NULL),
(6, 'animation', 'Fade Out Down Big', 'fadeOutDownBig', 'exit', NULL, NULL, NULL),
(7, 'animation', 'Fade In Left', 'fadeInLeft', 'entrance', NULL, NULL, NULL),
(8, 'animation', 'Fade Out Left', 'fadeOutLeft', 'exit', NULL, NULL, NULL),
(9, 'animation', 'Fade In Left Big', 'fadeInLeftBig', 'entrance', NULL, NULL, NULL),
(10, 'animation', 'Fade Out Left Big', 'fadeOutDownBig', 'exit', NULL, NULL, NULL),
(11, 'animation', 'Fade In Right', 'fadeInRight', 'entrance', NULL, NULL, NULL),
(12, 'animation', 'Fade Out Right', 'fadeOutRight', 'exit', NULL, NULL, NULL),
(13, 'animation', 'Fade In Right Big', 'fadeInRightBig', 'entrance', NULL, NULL, NULL),
(14, 'animation', 'Fade Out Right Big', 'fadeInRightBig', 'exit', NULL, NULL, NULL),
(15, 'animation', 'Fade In Up', 'fadeInUp', 'entrance', NULL, NULL, NULL),
(16, 'animation', 'Fade Out Up', 'fadeOutUp', 'exit', NULL, NULL, NULL),
(17, 'animation', 'Fade In Up Big', 'fadeInUpBig', 'entrance', NULL, NULL, NULL),
(18, 'animation', 'Fade Out Up Big', 'fadeInUpBig', 'exit', NULL, NULL, NULL),
(19, 'animation', 'Bounce In', 'bounceIn', 'entrance', NULL, NULL, NULL),
(20, 'animation', 'Bounce Out', 'bounceOut', 'exit', NULL, NULL, NULL),
(21, 'animation', 'Bounce In Down', 'bounceInDown', 'entrance', NULL, NULL, NULL),
(22, 'animation', 'Bounce Out Down', 'bounceOutDown', 'exit', NULL, NULL, NULL),
(23, 'animation', 'Bounce In Left', 'bounceInLeft', 'entrance', NULL, NULL, NULL),
(24, 'animation', 'Bounce Out Left', 'bounceOutLeft', 'exit', NULL, NULL, NULL),
(25, 'animation', 'Bounce In Right', 'bounceInRight', 'entrance', NULL, NULL, NULL),
(26, 'animation', 'Bounce Out Right', 'bounceOutRight', 'exit', NULL, NULL, NULL),
(27, 'animation', 'Bounce In Up', 'bounceInUp', 'entrance', NULL, NULL, NULL),
(28, 'animation', 'Bounce Out Up', 'bounceOutUp', 'exit', NULL, NULL, NULL),
(29, 'animation', 'Route In', 'rotateIn', 'entrance', NULL, NULL, NULL),
(30, 'animation', 'Route Out', 'rotateOut', 'exit', NULL, NULL, NULL),
(31, 'animation', 'Route In Down Left', 'rotateInDownLeft', 'entrance', NULL, NULL, NULL),
(32, 'animation', 'Route Out Down Left', 'rotateOutDownLeft', 'exit', NULL, NULL, NULL),
(33, 'animation', 'Route In Down Right', 'rotateInDownRight', 'entrance', NULL, NULL, NULL),
(34, 'animation', 'Route Out Down Right', 'rotateOutDownRight', 'exit', NULL, NULL, NULL),
(35, 'animation', 'Route In Up Left', 'rotateInUpLeft', 'entrance', NULL, NULL, NULL),
(36, 'animation', 'Route Out Up Left', 'rotateOutUpLeft', 'exit', NULL, NULL, NULL),
(37, 'animation', 'Route In Up Right', 'rotateInUpRight', 'entrance', NULL, NULL, NULL),
(38, 'animation', 'Route Out Up Right', 'rotateOutUpRight', 'exit', NULL, NULL, NULL),
(39, 'animation', 'Slide In Up', 'slideInUp', 'entrance', NULL, NULL, NULL),
(40, 'animation', 'Slide Out Up', 'slideOutUp', 'exit', NULL, NULL, NULL),
(41, 'animation', 'Slide In Down', 'slideInDown', 'entrance', NULL, NULL, NULL),
(42, 'animation', 'Slide Out Down', 'slideOutDown', 'exit', NULL, NULL, NULL),
(43, 'animation', 'Slide In Left', 'slideInLeft', 'entrance', NULL, NULL, NULL),
(44, 'animation', 'Slide Out Left', 'slideOutLeft', 'exit', NULL, NULL, NULL),
(45, 'animation', 'Slide In Right', 'slideInRight', 'entrance', NULL, NULL, NULL),
(46, 'animation', 'Slide Out Right', 'slideOutRight', 'exit', NULL, NULL, NULL),
(47, 'animation', 'Zoom In', 'zoomIn', 'entrance', NULL, NULL, NULL),
(48, 'animation', 'Zoom Out', 'zoomOut', 'exit', NULL, NULL, NULL),
(49, 'animation', 'Zoom In Down', 'zoomInDown', 'entrance', NULL, NULL, NULL),
(50, 'animation', 'Zoom Out Down', 'zoomOutDown', 'exit', NULL, NULL, NULL),
(51, 'animation', 'Zoom In Left', 'zoomInLeft', 'entrance', NULL, NULL, NULL),
(52, 'animation', 'Zoom Out Left', 'zoomOutLeft', 'exit', NULL, NULL, NULL),
(53, 'animation', 'Zoom In Right', 'zoomInRight', 'entrance', NULL, NULL, NULL),
(54, 'animation', 'Zoom Out Right', 'zoomOutRight', 'exit', NULL, NULL, NULL),
(55, 'animation', 'Zoom In Up', 'zoomInUp', 'entrance', NULL, NULL, NULL),
(56, 'animation', 'Zoom Out Up', 'zoomOutUp', 'exit', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_page_id` int(11) NOT NULL DEFAULT 0,
  `album_id` int(11) DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contents` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `page_type` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `image_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `parent_page_id`, `album_id`, `slug`, `name`, `label`, `contents`, `status`, `page_type`, `image_url`, `meta_title`, `meta_keyword`, `meta_description`, `user_id`, `template`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 0, 1, 'home', 'Home', 'Home', '<div class=\"slick-slider\" id=\"banner\">\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image1.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image2.jpg\" /></div>\r\n          </div>\r\n          <div class=\"banner-wrapper\">\r\n            <div class=\"banner-image\"><img src=\"theme/mikisan/images/banners/image3.jpg\" /></div>\r\n          </div>\r\n        </div>', 'PUBLISHED', 'default', '', 'Home', 'Home page', 'home', '1', 'home', '2020-08-02 23:46:08', '2020-08-03 00:11:49', NULL),
(2, 0, 0, 'about-us', 'About Us', 'About Us', '<section class=\"bg-main wrapper\">\r\n        <div class=\"container\">\r\n            <div class=\"row\">\r\n                <div class=\"col-lg-5\">\r\n                    <h4 class=\"title-secondary\">get in touch with us</h4>\r\n                    <div class=\"gap-10\"></div>\r\n                    <form id=\"contactUsForm\" method=\"POST\" action=\"{{ route(\'contact-us\') }}\">\r\n                        @csrf\r\n                        @if(session()->has(\'success\') && session())\r\n                            <div class=\"alert alert-success\">\r\n                                {{ session()->get(\'success\') }}\r\n                            </div>\r\n                        @endif\r\n                        @if(session()->has(\'error\'))\r\n                            <div class=\"alert alert-danger\">\r\n                                {{ session()->get(\'error\') }}\r\n                            </div>\r\n                        @endif\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_name\">Name *</label>\r\n                            <input id=\"form_name\" type=\"text\" name=\"name\" class=\"form-control\" placeholder=\"Your name\" required=\"required\">\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_email\">Email *</label>\r\n                            <input id=\"form_email\" type=\"email\" name=\"email\" class=\"form-control\" placeholder=\"name@website.com\" required=\"required\">\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_number\">Contact Number *</label>\r\n                            <input id=\"form_number\" type=\"text\" name=\"contact\" class=\"form-control\" placeholder=\"Your contact number *\" required=\"required\">\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <label for=\"form_message\">Message *</label>\r\n                            <textarea id=\"form_message\" name=\"message\" class=\"form-control\" placeholder=\"Message\" rows=\"4\" required=\"required\"></textarea>\r\n                            <div class=\"help-block with-errors\"></div>\r\n                        </div>\r\n                        <div class=\"form-group\">\r\n                            <script src=\"https://www.google.com/recaptcha/api.js?hl=en\" async=\"\" defer=\"\" ></script>\r\n                            <div class=\"g-recaptcha\" data-sitekey=\"{{ \\Setting::info()->google_recaptcha_sitekey }}\"></div>\r\n                            <label class=\"control-label text-danger\" for=\"g-recaptcha-response\" id=\"catpchaError\" style=\"display:none;\"><i class=\"fa fa-times-circle-o\"></i>The Captcha field is required.</label></br>\r\n                            @if($errors->has(\'g-recaptcha-response\'))\r\n                                @foreach($errors->get(\'g-recaptcha-response\') as $message)\r\n                                    <label class=\"control-label text-danger\" for=\"g-recaptcha-response\"><i class=\"fa fa-times-circle-o\"></i>{{ $message }}</label></br>\r\n                                @endforeach\r\n                            @endif\r\n                        </div>\r\n                        <button type=\"submit\" class=\"btn btn-primary btn-third\">Submit</button>\r\n                    </form>\r\n                    <div class=\"gap-50\"></div>\r\n                </div>\r\n                <div class=\"col-lg-7\">\r\n                    <h4 class=\"title-secondary\">find us on the map</h4>\r\n                    <div class=\"gap-10\"></div>\r\n                    <iframe class=\"mt-2 mb-4\" src=\"{{ \\Setting::info()->google_map }}\" width=\"100%\" height=\"500\" frameborder=\"0\" style=\"border:0;\" allowfullscreen=\"\" aria-hidden=\"false\" tabindex=\"0\"></iframe>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </section>', 'PUBLISHED', 'standard', 'http://localhost/theme/mikisan/images/banners/sub-banner-bg.jpg', 'About Us', 'About Us', 'About Us page', '1', '', '2020-08-02 23:46:08', '2020-08-03 00:16:05', NULL),
(3, 0, 2, 'contact-us', 'Contact Us', 'Contact Us', '<div class=\"col-md-4\">\n                <div class=\"contact-details\">\n                    <h4 class=\"secondary-title\">Office Address</h4>\n                    <i class=\"fa fa-map-marker-alt fa-3x\"></i>\n                    <p>Aliquam iaculis metus eget magna feugiat hendrerit</p>\n                    <div class=\"gap-50\"></div>\n                </div>\n            </div>\n            <div class=\"col-md-4\">\n                <div class=\"contact-details\">\n                    <h4 class=\"secondary-title\">Contact Number</h4>\n                    <i class=\"fa fa-phone fa-3x\"></i>\n                    <p>+63 919 172 3412\n                        <br>+63 2 283 9047</p>\n                    <div class=\"gap-50\"></div>\n                </div>\n            </div>\n            <div class=\"col-md-4\">\n                <div class=\"contact-details\">\n                    <h4 class=\"secondary-title\">Email Address</h4>\n                    <i class=\"fa fa-envelope-open fa-3x\"></i>\n                    <p><a href=\"#\">name@website.com.ph</a></p>\n                    <p><a href=\"#\">othename@webstie.com.ph</a></p>\n                    <div class=\"gap-50\"></div>\n                </div>\n            </div>', 'PUBLISHED', 'customize', '', 'Contact Us', 'Contact Us', 'Contact Us page', '1', 'contact-us', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(4, 0, 0, 'news', 'News', 'News', '', 'PUBLISHED', 'customize', '', 'News', 'news', 'News page', '1', 'news', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(5, 0, 0, 'footer', 'Footer', 'footer', '<div class=\"container\">\n			<div class=\"row\">\n				<div class=\"col-md-6\">\n					<h3 class=\"footer-title\">About us</h3>\n					<p>Zenshop is a premium Templates theme with advanced admin module. It’s extremely customizable, easy to use and fully responsive and retina ready.</p>\n					<img src=\"http://localhost/theme/richams/images/rich-ams-logo-small.png\" />\n				</div>\n				<div class=\"col-md-2\">\n					<h3 class=\"footer-title\">Information</h3>\n					<ul>\n						<li><a href=\"http://localhost\">home</a></li>\n						<li><a href=\"http://localhost/about-us\">about us</a></li>\n						<li><a href=\"http://localhost/products\">our products</a></li>\n						<li><a href=\"http://localhost/contact-us\">contact us</a></li>\n					</ul>\n				</div>\n				<div class=\"col-md-4\">\n					<h3 class=\"footer-title\">Contact us</h3>\n					<ul>\n						<li>+84 3333 6789</li>\n						<li>262 Milacina Mrest Street Behansed, United State.</li>\n						<li class=\"social-media\"><a href=\"#\"><i class=\"fab fa-facebook-f\"></i></a><a href=\"#\"><i class=\"fab fa-twitter\"></i></a><a href=\"#\"><i class=\"fab fa-instagram\"></i></a></li>\n					</ul>\n				</div>\n				<div class=\"col-md-12\">\n					<div class=\"footer-copyright\">\n						Created by WebFocus Solutions, Inc. © 2019 - <span>Rich Ams Global</span>\n					</div>\n				</div>\n			</div>\n		</div>', 'PUBLISHED', 'default', '', '', '', '', '1', '', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL),
(6, 0, 0, 'products', 'Products', 'Products', '', 'PUBLISHED', 'customize', '', '', '', '', '1', '', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL);

--
-- Triggers `pages`
--
DELIMITER $$
CREATE TRIGGER `tr_pages_insert` AFTER INSERT ON `pages` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new page', concat('created the page ',NEW.name), NOW(), 'pages', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_pages_update` AFTER UPDATE ON `pages` FOR EACH ROW BEGIN

                        DECLARE album_id_old VARCHAR(200);
                        DECLARE album_id_new VARCHAR(200);

                        IF(NEW.parent_page_id > 0) THEN

                            IF ((OLD.parent_page_id <=> NEW.parent_page_id) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the parent id of the page', concat('updated the parent page id of ',OLD.name,' from ',OLD.parent_page_id,' to ',NEW.parent_page_id), NOW(), 'pages', OLD.parent_page_id, NEW.parent_page_id, OLD.id);
                            END IF;
                            
                        END IF;

                            IF ((OLD.image_url <=> NEW.image_url) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page banner type', CASE WHEN OLD.image_url = '' THEN concat('updated the page banner type of ',OLD.name,' from slider to image') ELSE concat('updated the page banner type of ',OLD.name,' from image to slider') END, NOW(), 'pages', CASE WHEN OLD.image_url = '' THEN 'slider' ELSE 'image' END, CASE WHEN NEW.image_url = '' THEN 'slider' ELSE 'image' END, OLD.id);
                            END IF;

                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page name', concat('updated the page title of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'pages', OLD.name, NEW.name, OLD.id);
                            END IF;

                            IF ((OLD.label <=> NEW.label) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page label', concat('updated the page label of ',OLD.name,' from ',OLD.label,' to ',NEW.label), NOW(), 'pages', OLD.label, NEW.label, OLD.id);
                            END IF;

                            IF ((OLD.contents <=> NEW.contents) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the page content', 'updated the page content from ', NOW(), 'pages', OLD.contents, NEW.contents, OLD.id);
                            END IF;

                            IF ((OLD.status <=> NEW.status) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page status', concat('updated the page status of ',OLD.name,' from ',OLD.status,' to ',NEW.status), NOW(), 'pages', OLD.status, NEW.status, OLD.id);
                            END IF;
                            
                            IF ((OLD.page_type <=> NEW.page_type) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page type', concat('updated the page banner type of ',OLD.name,' from ',OLD.page_type,' to ',NEW.page_type), NOW(), 'pages', OLD.page_type, NEW.page_type, OLD.id);
                            END IF;

                            IF ((OLD.meta_title <=> NEW.meta_title) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_title IS NULL THEN 'insert' WHEN NEW.meta_title IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_title IS NULL THEN 'added a page meta title' WHEN NEW.meta_title IS NULL THEN 'removed the page meta title' ELSE 'updated the page meta title' END, CASE WHEN OLD.meta_title IS NULL THEN concat('added ',NEW.meta_title,' to meta title of ',OLD.name) WHEN NEW.meta_title IS NULL THEN concat('removed ',OLD.meta_title,' from meta title of ',OLD.name) ELSE concat('updated the meta title of ',OLD.name,' from ',OLD.meta_title,' to ',NEW.meta_title) END, NOW(), 'pages', OLD.meta_title, NEW.meta_title, OLD.id);
                            END IF;

                            IF ((OLD.meta_keyword <=> NEW.meta_keyword) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_keyword IS NULL THEN 'insert' WHEN NEW.meta_keyword IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_keyword IS NULL THEN 'added the page meta keyword' WHEN NEW.meta_keyword IS NULL THEN 'removed the page meta keyword' ELSE 'updated the page meta keyword' END, CASE WHEN OLD.meta_keyword IS NULL THEN concat('added ',NEW.meta_keyword,' to meta keyword of ',OLD.name) WHEN NEW.meta_keyword IS NULL THEN concat('removed ',OLD.meta_keyword,' from meta keyword of ',OLD.name) ELSE concat('updated the meta keyword of ',OLD.name,' from ',OLD.meta_keyword,' to ',NEW.meta_keyword) END, NOW(), 'pages', OLD.meta_keyword, NEW.meta_keyword, OLD.id);
                            END IF;

                            IF ((OLD.meta_description <=> NEW.meta_description) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.meta_description IS NULL THEN 'insert' WHEN NEW.meta_description IS NULL THEN 'removed' ELSE 'update' END, CASE WHEN OLD.meta_description IS NULL THEN 'added the page meta description' WHEN NEW.meta_description IS NULL THEN 'removed the page meta description' ELSE 'updated the page meta description' END, CASE WHEN OLD.meta_description IS NULL THEN concat('added ',NEW.meta_description,' to meta description of ',OLD.name) WHEN NEW.meta_description IS NULL THEN concat('removed ',OLD.meta_description,' from meta description of ',OLD.name) ELSE concat('updated the meta description of ',OLD.name,' from ',OLD.meta_description,' to ',NEW.meta_description) END, NOW(), 'pages', OLD.meta_description, NEW.meta_description, OLD.id);
                            END IF;

                            IF ((OLD.template <=> NEW.template) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the page template', concat('updated the template of ',OLD.name,' from ',OLD.template,' to ',NEW.template), NOW(), 'pages', OLD.template, NEW.template, OLD.id);
                            END IF;

                            IF ((OLD.deleted_at <=> NEW.deleted_at) = 0) THEN 
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'delete' ELSE 'restore' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'deleted a page' ELSE 'restore a page' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN concat('deleted the page ',OLD.name) ELSE concat('restores the page ', OLD.name) END, NOW(), 'pages', OLD.name, '', OLD.id);
                            END IF;
                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `routes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `methods` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_view_page` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`id`, `name`, `module`, `description`, `routes`, `methods`, `user_id`, `is_view_page`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'View Page', 'page', 'User can view page list and detail', '[\"pages.index\",\"pages.show\",\"pages.index.advance-search\"]', '[\"index\",\"show\",\"advance_index\"]', 1, 1, NULL, NULL, NULL),
(2, 'Create Page', 'page', 'User can create pages', '[\"pages.create\",\"pages.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(3, 'Edit Page', 'page', 'User can edit pages', '[\"pages.edit\",\"pages.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(4, 'Delete/Restore page', 'page', 'User can delete and restore pages', '[\"pages.destroy\",\"pages.delete\",\"pages.restore\"]', '[\"destroy\",\"delete\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(5, 'Change Status of Page', 'page', 'User can change status of pages', '[\"pages.change.status\"]', '[\"change_status\"]', 1, 0, NULL, NULL, NULL),
(6, 'View Album', 'banner', 'User can view album list and detail', '[\"albums.index\",\"albums.show\"]', '[\"index\",\"show\"]', 1, 1, NULL, NULL, NULL),
(7, 'Create Album', 'banner', 'User can create albums', '[\"albums.create\",\"albums.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(8, 'Edit Album', 'banner', 'User can edit albums', '[\"albums.edit\",\"albums.update\",\"albums.quick_update\"]', '[\"edit\",\"update\",\"quick_update\"]', 1, 0, NULL, NULL, NULL),
(9, 'Delete/Restore album', 'banner', 'User can delete and restore albums', '[\"albums.destroy\",\"albums.destroy_many\",\"albums.restore\"]', '[\"destroy\",\"destroy_many\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(10, 'Manage File manager', 'file_manager', 'User can manage file manager', '[\"file-manager.show\",\"file-manager.upload\",\"file-manager.index\"]', '[\"show\",\"upload\",\"index\"]', 1, 0, NULL, NULL, NULL),
(11, 'View menu', 'menu', 'User can view menu list and detail', '[\"menus.index\",\"menus.show\"]', '[\"index\",\"show\"]', 1, 1, NULL, NULL, NULL),
(12, 'Create Menu', 'menu', 'User can create menus', '[\"menus.create\",\"menus.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(13, 'Edit Menu', 'menu', 'User can edit menus', '[\"menus.edit\",\"menus.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(14, 'Delete/Restore menu', 'menu', 'User can delete and restore menus', '[\"menus.destroy\",\"menus.destroy_many\",\"menus.restore\"]', '[\"destroy\",\"destroy_many\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(15, 'View news', 'news', 'User can view news list and detail', '[\"news.index\",\"news.show\",\"news.index.advance-search\"]', '[\"index\",\"show\",\"advance_index\"]', 1, 1, NULL, NULL, NULL),
(16, 'Create News', 'news', 'User can create news', '[\"news.create\",\"news.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(17, 'Edit news', 'news', 'User can edit news', '[\"news.edit\",\"news.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(18, 'Delete/Restore News', 'news', 'User can delete and restore news', '[\"news.destroy\",\"news.delete\",\"news.restore\"]', '[\"destroy\",\"delete\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(19, 'Change Status of News', 'news', 'User can change status of news', '[\"news.change.status\"]', '[\"change_status\"]', 1, 0, NULL, NULL, NULL),
(20, 'View News Category', 'news_category', 'User can view news category list and details', '[\"news-categories.index\",\"news-categories.show\"]', '[\"index\",\"show\"]', 1, 1, NULL, NULL, NULL),
(21, 'Create news category', 'news_category', 'User can create news categories', '[\"news-categories.create\",\"news-categories.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(22, 'Edit news category', 'news_category', 'User can edit news categories', '[\"news-categories.edit\",\"news-categories.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(23, 'Delete/Restore news category', 'news_category', 'User can delete and restore news categories', '[\"news-categories.destroy\",\"news-categories.delete\",\"news-categories.restore\"]', '[\"destroy\",\"delete\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(24, 'Edit website settings', 'website_settings', 'User can edit website settings', '[\"website-settings.edit\",\"website-settings.update\",\"website-settings.update-contacts\",\"website-settings.update-media-accounts\",\"website-settings.update-data-privacy\",\"website-settings.remove-logo\",\"website-settings.remove-icon\",\"website-settings.remove-media\"]', '[\"edit\",\"update\",\"update_contacts\",\"update_media_accounts\",\"update_data_privacy\",\"remove_logo\",\"remove_icon\",\"remove_media\"]', 1, 1, NULL, NULL, NULL),
(25, 'View audit logs', 'audit_logs', 'User can view audit logs', '[\"audit-logs.index\"]', '[\"index\"]', 1, 1, NULL, NULL, NULL),
(26, 'View users', 'user', 'User can view user list and detail', '[\"users.index\",\"users.show\",\"user.search\",\"user.activity.search\"]', '[\"index\",\"show\",\"search\",\"filter\"]', 1, 1, NULL, NULL, NULL),
(27, 'Create user', 'user', 'User can create users', '[\"users.create\",\"users.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(28, 'Edit user', 'user', 'User can edit users', '[\"users.edit\",\"users.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(29, 'Change status of user', 'user', 'User can change status of users', '[\"users.deactivate\",\"users.activate\"]', '[\"deactivate\",\"activate\"]', 1, 0, NULL, NULL, NULL),
(30, 'View Product Category', 'product_category', 'User can view product category list and details', '[\"product-categories.index\",\"product-categories.show\"]', '[\"index\",\"show\"]', 1, 1, NULL, NULL, NULL),
(31, 'Create Product Category', 'product_category', 'User can create product categories', '[\"product-categories.create\",\"product-categories.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(32, 'Edit Product Category', 'product_category', 'User can edit product categories', '[\"product-categories.edit\",\"product-categories.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(33, 'Delete/Restore Product Category', 'product_category', 'User can delete and restore product categories', '[\"product-categories.destroy\",\"product-categories.destroy_many\",\"product-categories.restore\"]', '[\"destroy\",\"destroy_many\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(34, 'Change Status of Product Category', 'product_category', 'User can change status of product categories', '[\"product-categories.change.status\"]', '[\"change_status\"]', 1, 0, NULL, NULL, NULL),
(35, 'View Product', 'products', 'User can view product listing and details', '[\"products.index\",\"products.show\"]', '[\"index\",\"show\"]', 1, 1, NULL, NULL, NULL),
(36, 'Create Product', 'products', 'User can create products', '[\"products.create\",\"products.store\"]', '[\"create\",\"store\"]', 1, 0, NULL, NULL, NULL),
(37, 'Edit Product', 'products', 'User can edit products', '[\"products.edit\",\"products.update\"]', '[\"edit\",\"update\"]', 1, 0, NULL, NULL, NULL),
(38, 'Delete/Restore Product', 'products', 'User can delete and restore products', '[\"products.destroy\",\"products.destroy_many\",\"products.restore\"]', '[\"destroy\",\"destroy_many\",\"restore\"]', 1, 0, NULL, NULL, NULL),
(39, 'Change Status of Product', 'products', 'User can change status of products', '[\"products.change.status\"]', '[\"change_status\"]', 1, 0, NULL, NULL, NULL);

--
-- Triggers `permission`
--
DELIMITER $$
CREATE TRIGGER `tr_permission_insert` AFTER INSERT ON `permission` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new permission', concat('created the permission ',NEW.name), NOW(), 'permission', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_permission` AFTER UPDATE ON `permission` FOR EACH ROW BEGIN
                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the permission name', concat('updated the permission route of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'permission', OLD.name, NEW.name, OLD.id);
                            END IF;

                            IF ((OLD.module <=> NEW.module) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the permission`s module', concat('updated the permisson module of ',OLD.name,' from ',OLD.module,' to ',NEW.module), NOW(), 'permission', OLD.module, NEW.module, OLD.id);
                            END IF;

                            IF ((OLD.is_view_page <=> NEW.is_view_page) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN NEW.is_view_page > 0 THEN 'update' ELSE 'removed' END, CASE WHEN NEW.is_view_page > 0 THEN 'updated the permission into a view/listing page' ELSE 'removed the view/listing page category of the permission' END, CASE WHEN NEW.is_view_page > 0 THEN concat(OLD.description,' was set to a view/listing page') ELSE concat('removed the view/listing page category of permission ',OLD.description) END, NOW(), 'permission', CASE WHEN OLD.is_view_page > 0 THEN 'disable' ELSE 'enable' END, CASE WHEN NEW.is_view_page > 0 THEN 'disable' ELSE 'enable' END, OLD.id);
                            END IF;
                                
                            IF ((OLD.description <=> NEW.description) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the permission description', concat('updated the permission description of ',NEW.description,' from ',OLD.description,' to ',NEW.description), NOW(), 'permission', OLD.description, NEW.description, OLD.id);
                            END IF;

                            IF ((OLD.deleted_at <=> NEW.deleted_at) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'delete' ELSE 'restore' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN 'deleted a pemission' ELSE 'restore a permssion' END, CASE WHEN NEW.deleted_at IS NOT NULL THEN concat('deleted the permission ',OLD.description) ELSE concat('restores the permission ', OLD.description) END, NOW(), 'permission', OLD.description, '', OLD.id);
                            END IF;

                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`, `description`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 'Administrator of the system', 1, '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL);

--
-- Triggers `role`
--
DELIMITER $$
CREATE TRIGGER `tr_role` AFTER INSERT ON `role` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.created_by, 'insert', 'created a new role', concat('created the role ',NEW.name), NOW(), 'role', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_role_delete` AFTER DELETE ON `role` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value)
                            VALUES (OLD.created_by, 'delete', 'deleted a role', concat('deleted the role ',OLD.name), NOW(), 'role', OLD.name);
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_role_update` AFTER UPDATE ON `role` FOR EACH ROW BEGIN
                            IF ((OLD.name <=> NEW.name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value) VALUES(NEW.created_by, 'update', 'updated the role name', concat('updated the role name of ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'role', OLD.name, NEW.name);
                            END IF;

                            IF ((OLD.description <=> NEW.description) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value) VALUES(NEW.created_by, 'update', 'updated the role description', concat('updated the role description of ',OLD.name,' from ',OLD.description,' to ',NEW.description), NOW(), 'role', OLD.description, NEW.description);
                            END IF;
                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `isAllowed` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `role_permission`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_access_permission` AFTER INSERT ON `role_permission` FOR EACH ROW BEGIN

                            DECLARE role_name VARCHAR(200);
                            DECLARE perm_name VARCHAR(200);

                            IF(NEW.isAllowed = 1) THEN
                                SET role_name = (SELECT name FROM role WHERE id = NEW.role_id);
                                SET perm_name = (SELECT description FROM permission WHERE id = NEW.permission_id);
                            
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                                Values (new.user_id, 'insert_access', 'updated the access permission', concat('permission name ',perm_name,' was set to ',role_name,' role'), NOW(), 'Access Rights', NEW.id); 
                            END IF;  
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_access_permission` AFTER UPDATE ON `role_permission` FOR EACH ROW BEGIN
            
            DECLARE role_name VARCHAR(200);
            DECLARE perm_name VARCHAR(200);
            
            IF ((OLD.isAllowed <=> NEW.isAllowed) = 0) THEN 

                SET role_name = (SELECT name FROM role WHERE id = NEW.role_id);
                SET perm_name = (SELECT description FROM permission WHERE id = NEW.permission_id);

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.isAllowed = 0 THEN 'insert_access' ELSE 'remove_access' END, CASE WHEN OLD.isAllowed = 0 THEN 'set an access permission in a role' ELSE 'removed an access permission in a role' END, CASE WHEN OLD.isAllowed = 0 THEN concat('permission name ',perm_name,' was set to ',role_name,' role') ELSE concat('permission name ',perm_name,' was removed in ',role_name,' role') END, NOW(), 'Access Right', OLD.isAllowed, NEW.isAllowed, OLD.id);
            END IF;

        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `api_key` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website_favicon` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_logo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_favicon` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_about` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_analytics` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_map` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_recaptcha_sitekey` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_privacy_title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_privacy_popup_content` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_privacy_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tel_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_accounts` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copyright` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `contact_us_email_layout` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `api_key`, `website_name`, `website_favicon`, `company_logo`, `company_favicon`, `company_name`, `company_about`, `company_address`, `google_analytics`, `google_map`, `google_recaptcha_sitekey`, `google_recaptcha_secret`, `data_privacy_title`, `data_privacy_popup_content`, `data_privacy_content`, `mobile_no`, `fax_no`, `tel_no`, `email`, `social_media_accounts`, `copyright`, `user_id`, `created_at`, `updated_at`, `deleted_at`, `contact_us_email_layout`) VALUES
(1, '', 'Mikisan Soap', '1596412131_favicon.ico', '1596412145_nikisan-logo.jpg', '', 'Mikisan Soap', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '907-909 Antel Global Corporate, Brgy. San Antonio, Pasig City, Metro Manila', NULL, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3861.2714876990763!2d121.05972724792107!3d14.583599997065233!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3397c869d9acf3bd%3A0x3d08a34bc750b469!2sWebFocus%20Solutions%2C%20Inc.!5e0!3m2!1sen!2sph!4v1568093056927!5m2!1sen!2sph', '6Lfgj7cUAAAAAJfCgUcLg4pjlAOddrmRPt86tkQK', '6Lfgj7cUAAAAALOaFTbSFgCXpJldFkG8nFET9eRx', 'Privacy-Policy', 'This website uses cookies to ensure you get the best experience.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '09123456789', '13232107114', '(044) 795-1234', 'support@webfocus.ph', '', '2019-2020', 1, NULL, '2020-08-03 01:04:24', NULL, '<style>\n                    body {\n                        font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif;\n                        background: #f0f0f0;\n                    }\n                \n                    h1,\n                    h2,\n                    h3,\n                    h4,\n                    h5,\n                    h6,\n                    p {\n                        margin: 10px 0;\n                        padding: 0;\n                        font-weight: normal;\n                    }\n                \n                    p {\n                        font-size: 13px;\n                    }\n                </style>\n                \n                <!-- BODY-->\n                <div style=\"max-width: 700px; width: 100%; background: #fff;margin: 30px auto;\">\n                \n                    <div style=\"padding:30px 60px;\">\n                        <div style=\"text-align: center;padding: 20px 0;\">\n                            {company_logo}\n                        </div>\n                \n                        <p style=\"margin-top: 30px;\"><strong>Dear {name},</strong></p>\n                \n                        <p>\n                            This is to inform you that your inquiry has been sent to our Admin for action.\n                        </p>\n                \n                        <p>\n                            For your reference, please see details of your inquiry below.\n                        </p>\n                \n                        <br />\n                \n                        <table style=\"width:100%; padding: 20px;background: #f0f0f0;font-size: 14px;\">\n                            <tbody>\n                            <tr>\n                                <td width=\"30%\"><strong>Name</strong></td>\n                                <td>{name}</td>\n                            </tr>\n                            <tr>\n                                <td><strong>Email</strong></td>\n                                <td>{email}</td>\n                            </tr>\n                            <tr>\n                                <td><strong>Contact Number</strong></td>\n                                <td>{contact}</td>\n                            </tr>\n                            <tr>\n                                <td><strong>Message</strong></td>\n                                <td>{message}</td>\n                            </tr>\n                            </tbody>\n                        </table>\n                \n                        <br />\n                \n                        <br />\n                \n                        <p>\n                            <strong>\n                                Regards, \n                                <br />\n                                {company_name}\n                            </strong>\n                        </p>\n                    </div>\n                \n                    <div style=\"padding: 30px;background: #fff;margin-top: 20px;border-top: solid 1px #eee;text-align: center;color: #aaa;\">\n                        <p style=\"font-size: 12px;\">\n                            <strong>{company_name}</strong> \n                            <br /> \n                            {company_address}\n                            <br /> \n                            {company_telephone_no} | {company_mobile_no}\n                            <br />\n                            <br /> \n                            {website_url}\n                        </p>\n                    </div>\n                </div>');

--
-- Triggers `settings`
--
DELIMITER $$
CREATE TRIGGER `tr_update_settings` AFTER UPDATE ON `settings` FOR EACH ROW BEGIN

                        DECLARE new_social VARCHAR(200);
                        DECLARE old_social VARCHAR(200);

                            IF ((OLD.website_name <=> NEW.website_name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the website name', concat('updated the website name from ',OLD.website_name,' to ',NEW.website_name), NOW(), 'settings', OLD.website_name, NEW.website_name, OLD.id);
                            END IF;

                            IF ((OLD.company_name <=> NEW.company_name) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company name', concat('updated the company name from ',OLD.company_name,' to ',NEW.company_name), NOW(), 'settings', OLD.company_name, NEW.company_name, OLD.id);
                            END IF;

                            IF ((OLD.company_about <=> NEW.company_about) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company`s content', concat('updated the company content from ',OLD.company_about,' to ',NEW.company_about), NOW(), 'settings', OLD.company_about, NEW.company_about, OLD.id);
                            END IF;

                            IF ((OLD.company_address <=> NEW.company_address) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company address', concat('updated the company address from ',OLD.company_address,' to ',NEW.company_address), NOW(), 'settings', OLD.company_address, NEW.company_address, OLD.id);
                            END IF;

                            IF ((OLD.google_map <=> NEW.google_map) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the company`s google map location', 'updated the company google map location from', NOW(), 'settings', OLD.google_map, NEW.google_map, OLD.id);
                            END IF;

                            IF ((OLD.google_recaptcha_sitekey <=> NEW.google_recaptcha_sitekey) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the recaptcha key', 'updated the recaptcha key from', NOW(), 'settings', OLD.google_recaptcha_sitekey, NEW.google_recaptcha_sitekey, OLD.id);
                            END IF;

                            IF ((OLD.google_recaptcha_secret <=> NEW.google_recaptcha_secret) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the google recaptcha secret', 'updated the recaptcha secret from', NOW(), 'settings', OLD.google_recaptcha_secret, NEW.google_recaptcha_secret, OLD.id);
                            END IF;

                            IF ((OLD.data_privacy_title <=> NEW.data_privacy_title) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the data privacy title', concat('updated the data privacy title from ',OLD.data_privacy_title,' to ',NEW.data_privacy_title), NOW(), 'settings', OLD.data_privacy_title, NEW.data_privacy_title, OLD.id);
                            END IF;

                            IF ((OLD.data_privacy_popup_content <=> NEW.data_privacy_popup_content) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the data privacy popup content', 'updated the data privacy popup content from', NOW(), 'settings', OLD.data_privacy_popup_content, NEW.data_privacy_popup_content, OLD.id);
                            END IF;

                            IF ((OLD.data_privacy_content <=> NEW.data_privacy_content) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update_content', 'updated the data privacy content', 'updated the data privacy content from', NOW(), 'settings', OLD.data_privacy_content, NEW.data_privacy_content, OLD.id);
                            END IF;

                            IF ((OLD.mobile_no <=> NEW.mobile_no) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company`s mobile number', concat('updated the company mobile number from ',OLD.mobile_no,' to ',NEW.mobile_no), NOW(), 'settings', OLD.mobile_no, NEW.mobile_no, OLD.id);
                            END IF;

                            IF ((OLD.fax_no <=> NEW.fax_no) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company`s fax number', concat('updated the company fax number from ',OLD.fax_no,' to ',NEW.fax_no), NOW(), 'settings', OLD.fax_no, NEW.fax_no, OLD.id);
                            END IF;

                            IF ((OLD.tel_no <=> NEW.tel_no) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company`s telephone number', concat('updated the company telephone number from ',OLD.tel_no,' to ',NEW.tel_no), NOW(), 'settings', OLD.tel_no, NEW.tel_no, OLD.id);
                            END IF;

                            IF ((OLD.email <=> NEW.email) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the company`s email address', concat('updated the company email from ',OLD.email,' to ',NEW.email), NOW(), 'settings', OLD.email, NEW.email, OLD.id);
                            END IF;

                            IF ((OLD.copyright <=> NEW.copyright) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.copyright = '' THEN 'insert' ELSE 'update' END, CASE WHEN OLD.copyright = '' THEN 'added a copyright year' ELSE 'updated the copyright year' END, CASE WHEN OLD.copyright = '' THEN 'added a copyright year' ELSE concat('updated the copyright from ',OLD.copyright,' to ',NEW.copyright) END, NOW(), 'settings', OLD.copyright, NEW.copyright, OLD.id);
                            END IF;

                            IF ((OLD.website_favicon <=> NEW.website_favicon) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.website_favicon = '' THEN 'upload' WHEN NEW.website_favicon = '' THEN 'remove' ELSE 'update' END, CASE WHEN OLD.website_favicon = '' THEN 'uploaded new website favicon' WHEN NEW.website_favicon = '' THEN 'removed the website favicon' ELSE 'updated the website favicon' END, CASE WHEN OLD.website_favicon = '' THEN 'uploaded a new website favicon' WHEN NEW.website_favicon = '' THEN 'removed the website favicon' ELSE 'updated the website favicon' END, NOW(), 'settings', OLD.website_favicon, NEW.website_favicon, OLD.id);
                            END IF;

                            IF ((OLD.company_logo <=> NEW.company_logo) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.company_logo = '' THEN 'upload' WHEN NEW.company_logo = '' THEN 'remove' ELSE 'update' END, CASE WHEN OLD.company_logo = '' THEN 'uploaded new company logo' WHEN NEW.company_logo = '' THEN 'removed the company logo' ELSE 'updated the company logo' END, CASE WHEN OLD.company_logo = '' THEN 'uploaded a new company logo' WHEN NEW.company_logo = '' THEN 'removed the company logo' ELSE 'updated the company logo' END, NOW(), 'settings', OLD.website_favicon, NEW.website_favicon, OLD.id);
                            END IF;

                            IF ((OLD.company_favicon <=> NEW.company_favicon) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, CASE WHEN OLD.company_favicon = '' THEN 'upload' WHEN NEW.company_favicon = '' THEN 'remove' ELSE 'update' END, CASE WHEN OLD.company_favicon = '' THEN 'uploaded new company favicon' WHEN NEW.company_favicon = '' THEN 'removed the company favicon' ELSE 'updated company favicon' END, CASE WHEN OLD.company_favicon = '' THEN 'uploaded a new company favicon' WHEN NEW.company_favicon = '' THEN 'removed the company favicon' ELSE 'updated the company favicon' END, NOW(), 'settings', OLD.company_favicon, NEW.company_favicon, OLD.id);
                            END IF;

                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `social_media`
--

CREATE TABLE `social_media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_account` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `social_media`
--
DELIMITER $$
CREATE TRIGGER `tr_delete_media_account` AFTER DELETE ON `social_media` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value)
                            VALUES (OLD.user_id, 'remove', 'removed the social media account', concat('removed the social media account ',OLD.media_account), NOW(), 'social media account', OLD.media_account);
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_insert_media_account` AFTER INSERT ON `social_media` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'added new social media account', concat('added new social media account ',NEW.media_account), NOW(), 'social media account', NEW.media_account);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_media_account` AFTER UPDATE ON `social_media` FOR EACH ROW BEGIN
            
            IF ((OLD.name <=> NEW.name) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the social media account type', concat('updated the social media type ',NEW.name,' from ',OLD.name,' to ',NEW.name), NOW(), 'social media account', OLD.name, NEW.name, OLD.id);

            END IF;

            IF ((OLD.media_account <=> NEW.media_account) = 0) THEN 

                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the social media account', concat('updated the social media acount ',NEW.media_account,' from ',OLD.media_account,' to ',NEW.media_account), NOW(), 'social media account', OLD.media_account, NEW.media_account, OLD.id);
                
            END IF;

        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `firstname`, `lastname`, `avatar`, `email_verified_at`, `password`, `role_id`, `is_active`, `user_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 'wsiprod.demo@gmail.com', 'admin', 'istrator', NULL, '2020-08-02 23:46:08', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 1, 1, 'or7Lv5DT2T', '2020-08-02 23:46:08', '2020-08-02 23:46:08', NULL);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_user` AFTER INSERT ON `users` FOR EACH ROW BEGIN
                            INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, new_value)
                            Values (new.user_id, 'insert', 'created a new user', concat('created the user ',NEW.name), NOW(), 'users', NEW.name);    
                        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_update_users` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
                        
                        DECLARE role_old VARCHAR(200);
                        DECLARE role_new VARCHAR(200);
                        

                            IF ((OLD.role_id <=> NEW.role_id) = 0) THEN 

                                SET role_old = (SELECT name FROM role WHERE id = OLD.role_id);
                                SET role_new = (SELECT name FROM role WHERE id = NEW.role_id);

                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the user`s role', concat('updated the role of ',OLD.name,' from ',role_old,' to ',role_new), NOW(), 'users', role_old, role_new, OLD.id);
                            END IF;

                            IF ((OLD.firstname <=> NEW.firstname) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the user`s firstname', concat('updated the firstname of ',OLD.name,' from ',OLD.firstname,' to ',NEW.firstname), NOW(), 'users', OLD.firstname, NEW.firstname, OLD.id);
                            END IF;

                            IF ((OLD.lastname <=> NEW.lastname) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the user`s lastname', concat('updated the lastname of ',OLD.name,' from ',OLD.lastname,' to ',NEW.lastname), NOW(), 'users', OLD.lastname, NEW.lastname, OLD.id);
                            END IF;

                            IF ((OLD.email <=> NEW.email) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated the user`s email', concat('updated the email of ',OLD.name,' from ',OLD.email,' to ',NEW.email), NOW(), 'users', OLD.email, NEW.email, OLD.id);
                            END IF;

                            IF ((OLD.password <=> NEW.password) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', 'updated his/her password', concat('updated the password of ',OLD.firstname,' ',OLD.lastname), NOW(), 'users', OLD.password, NEW.password, OLD.id);
                            END IF;

                            IF ((OLD.avatar <=> NEW.avatar) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table) VALUES(NEW.user_id, CASE WHEN OLD.avatar IS NULL THEN 'upload' ELSE 'update' END, CASE WHEN OLD.avatar IS NULL THEN 'upload a new avatar' ELSE 'updated his/her avatar ' END, CASE WHEN OLD.avatar IS NULL THEN 'uploaded new avatar' ELSE 'updated the avatar' END, NOW(), 'users');
                            END IF;

                            IF ((OLD.is_active <=> NEW.is_active) = 0) THEN  
                                INSERT INTO cms_activity_logs (created_by, activity_type, dashboard_activity, activity_desc, activity_date, db_table, old_value, new_value, reference) VALUES(NEW.user_id, 'update', CASE WHEN NEW.is_active = 1 THEN 'activated a user' ELSE 'deactivated a user' END, CASE WHEN NEW.is_active = 1 THEN concat('activate the user name ',OLD.name) ELSE concat('deactivate the user name ', OLD.name) END, NOW(), 'users', OLD.is_active, NEW.is_active, OLD.id);
                            END IF;
                            

                        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_access_permission_per_role`
-- (See below for the actual view)
--
CREATE TABLE `view_access_permission_per_role` (
`user_id` int(11)
,`role` int(11)
,`permissions` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_activity_logs`
-- (See below for the actual view)
--
CREATE TABLE `view_activity_logs` (
`id` bigint(20) unsigned
,`created_by` varchar(191)
,`activity_type` varchar(191)
,`dashboard_activity` varchar(191)
,`activity_desc` text
,`activity_date` datetime
,`db_table` varchar(191)
,`old_value` text
,`new_value` text
,`reference` text
,`email` varchar(191)
,`firstname` varchar(191)
,`lastname` varchar(191)
,`role_name` varchar(191)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_role_permission`
-- (See below for the actual view)
--
CREATE TABLE `view_role_permission` (
`user_id` int(11)
,`role` int(11)
,`name` varchar(191)
,`permission_module` varchar(191)
);

-- --------------------------------------------------------

--
-- Structure for view `view_access_permission_per_role`
--
DROP TABLE IF EXISTS `view_access_permission_per_role`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_access_permission_per_role`  AS  select `view_role_permission`.`user_id` AS `user_id`,`view_role_permission`.`role` AS `role`,group_concat(`view_role_permission`.`name` separator '|') AS `permissions` from `view_role_permission` group by `view_role_permission`.`user_id`,`view_role_permission`.`role` ;

-- --------------------------------------------------------

--
-- Structure for view `view_activity_logs`
--
DROP TABLE IF EXISTS `view_activity_logs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_activity_logs`  AS  select `l`.`id` AS `id`,`l`.`created_by` AS `created_by`,`l`.`activity_type` AS `activity_type`,`l`.`dashboard_activity` AS `dashboard_activity`,`l`.`activity_desc` AS `activity_desc`,`l`.`activity_date` AS `activity_date`,`l`.`db_table` AS `db_table`,`l`.`old_value` AS `old_value`,`l`.`new_value` AS `new_value`,`l`.`reference` AS `reference`,`u`.`email` AS `email`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname`,`r`.`name` AS `role_name` from ((`cms_activity_logs` `l` left join `users` `u` on(`u`.`id` = `l`.`created_by`)) left join `role` `r` on(`r`.`id` = `u`.`role_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_role_permission`
--
DROP TABLE IF EXISTS `view_role_permission`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_role_permission`  AS  select `role_permission`.`user_id` AS `user_id`,`role_permission`.`role_id` AS `role`,`permission`.`name` AS `name`,`permission`.`module` AS `permission_module` from (`role_permission` join `permission` on(`role_permission`.`permission_id` = `permission`.`id`)) where `role_permission`.`isAllowed` = 1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `articles_slug_unique` (`slug`);

--
-- Indexes for table `article_categories`
--
ALTER TABLE `article_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cms_activity_logs`
--
ALTER TABLE `cms_activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_recipients`
--
ALTER TABLE `email_recipients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus_has_pages`
--
ALTER TABLE `menus_has_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media`
--
ALTER TABLE `social_media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `article_categories`
--
ALTER TABLE `article_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cms_activity_logs`
--
ALTER TABLE `cms_activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `email_recipients`
--
ALTER TABLE `email_recipients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menus_has_pages`
--
ALTER TABLE `menus_has_pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_media`
--
ALTER TABLE `social_media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
