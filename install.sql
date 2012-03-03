-- --------------------------------------------------------

--
-- Table structure for table `forum_categories`

-- 

CREATE TABLE IF NOT EXISTS `forum_categories` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,

  `cat_title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,

  `cat_ispublic` int(1) NOT NULL,

  `cat_order` int(11) NOT NULL,

  PRIMARY KEY (`id`)

) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;



--

-- Dumping data for table `forum_categories`

--



INSERT INTO `forum_categories` (`id`, `cat_title`, `cat_ispublic`, `cat_order`) VALUES
(1, 'My First Category', 1, 0);



-- --------------------------------------------------------



--

-- Table structure for table `forum_forum`

--



CREATE TABLE IF NOT EXISTS `forum_forum` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `forum_name` varchar(100) NOT NULL DEFAULT '',

  `forum_desc` varchar(255) NOT NULL DEFAULT '',
    `forum_cat` int(11) NOT NULL DEFAULT '1',

  `forum_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;



--

-- Dumping data for table `forum_forum`

--



INSERT INTO `forum_forum` (`id`, `forum_name`, `forum_desc`, `forum_cat`, `forum_order`) VALUES
(1, 'My First Forum', 'Edit me! Do not delete!', 1, 0);



-- --------------------------------------------------------



--

-- Table structure for table `forum_moderators`

--



CREATE TABLE IF NOT EXISTS `forum_moderators` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `pilot_id` int(4) NOT NULL,

  `mod_level` int(1) NOT NULL DEFAULT '0',

  PRIMARY KEY (`id`)

) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;



--

-- Dumping data for table `forum_moderators`

--



INSERT INTO `forum_moderators` (`id`, `pilot_id`, `mod_level`) VALUES
(1, 1, 2);



-- --------------------------------------------------------



--

-- Table structure for table `forum_posts`

--



CREATE TABLE IF NOT EXISTS `forum_posts` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `topic_id` int(11) NOT NULL DEFAULT '0',

  `forum_id` int(11) NOT NULL DEFAULT '0',

  `author_id` int(11) NOT NULL DEFAULT '0',

  `update_id` int(11) NOT NULL DEFAULT '0',

  `date_posted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',

  `subject` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',

  `body` mediumtext CHARACTER SET ascii NOT NULL,

  PRIMARY KEY (`id`),

  KEY `IdxArticle` (`forum_id`,`topic_id`,`author_id`,`date_posted`),

  FULLTEXT KEY `IdxText` (`subject`,`body`)

) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=73 ;




--

-- Dumping data for table `forum_posts`

--



INSERT INTO `forum_posts` (`id`, `topic_id`, `forum_id`, `author_id`, `update_id`, `date_posted`, `subject`, `body`) VALUES
(1, 1, 1, 1, 0, '2009-12-21 15:23:21', 'Your First Topic', 'Your First Post!');

-- --------------------------------------------------------


--

-- Table structure for table `forum_topics`

--



CREATE TABLE IF NOT EXISTS `forum_topics` (

  `id` int(11) NOT NULL AUTO_INCREMENT,

  `topic_title` varchar(50) NOT NULL,

  `topic_description` varchar(200) NOT NULL,

  `topic_forumid` int(5) NOT NULL,

  `topic_starter` int(4) NOT NULL,

  `topic_datestarted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',

  `topic_dateupdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',

  `topic_updatedby` int(4) NOT NULL,

  `topic_locked` int(1) NOT NULL DEFAULT '0',

  PRIMARY KEY (`id`)

) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;


--
-- Dumping data for table `forum_topics`
--

INSERT INTO `forum_topics` (`id`, `topic_title`, `topic_description`, `topic_forumid`, `topic_starter`, `topic_datestarted`, `topic_dateupdated`, `topic_updatedby`, `topic_locked`) VALUES
(1, 'Your First Topic', 'Your Topic Description', 1, 1, '2009-12-21 15:23:21', '2009-12-21 15:23:21', 1, 0);