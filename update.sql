CREATE TABLE IF NOT EXISTS `forum_categories` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,

  `cat_title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,

  `cat_ispublic` int(1) NOT NULL,

  `cat_order` int(11) NOT NULL,

  PRIMARY KEY (`id`)

) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;



INSERT INTO `forum_categories` (`id`, `cat_title`, `cat_ispublic`, `cat_order`) VALUES
(1, 'My First Category', 1, 0);




ALTER TABLE `forum_forum` ADD (`forum_order` int(11) NOT NULL,
 `forum_cat` int(11) NOT NULL DEFAULT '1');