phpVMS VAForum2 Addon
=====================

###Update from VAForum1/VAForum2 Pre-release:
- Import "update.sql" file to database
- Upload all files provided in core/ folder (necessary changes to all templates)
- Add the following somewhere between your `<head>` and `</head>` tags in layout.tpl: `<? Template::Show('forum_style.tpl'); ?>`

###Fresh install:
- Import "install.sql" file to database
- Upload all files provided in core/ folder
- Add the following somewhere between your `<head>` and `</head>` tags in layout.tpl: `<? Template::Show('forum_style.tpl'); ?>`

Credit to simpilot for the VAForum original on which this is based.
Code is provided "as is", all the same rules & licenses apply:

> *This addon will not work with the 700 version or beta's less than version 785
> 
> A simple forum board system that is contained within your phpVMS install.
> 
> To Install:
> 
> 1 - download attached package and unzip
> 2 - place the folders/files in your phpVMS install as they are structured in the package
> 3 - use the forum.sql file to create the new db tables using phpmyadmin or the like
> 4 - you are done!
> 
> The system makes the pilot with id #1 in the db the main forum admin and can not be changed unless you do it through the db. There are four levels of user for the board:
> 
> 1 - User - has rights to post messages
> 2 - Moderator - User permissions plus the ability to edit topics and posts
> 3 - Admin - User & Moderator permissions plus rights to create new boards and set user permissions.
> 4 - Banned - Can see boards but no posting permissions.
> 
> To link to the forum index use ->
> 
> ```<a href="<?php echo url('/Forum'); ?>">Forum</a>```
> 
> 
> Moderator editing links are located within the topics and posts
> 
> Admin board creation and user administration links are at the bottom of the forum index
> 
> EDIT - *Do not delete the sample board before creating another one or just edit the sample board to fit your needs. Will be updating the code to avoid this in the next version.

--------------------------------

###Changelog:

####2.0:
- Further improved security
- Addition of forum categories & admin-only categories
- Addition of category and board ordering
- Addition of user signatures (phpVMS Signatures)
- Images wider than post container automatically resized
- Improved post layout
- Added support for the following HTML tags: `<p><a><b><i><em><strong><ul><ol><li>`
- Added support for the following "BBCode style" codes (they're slightly different): `[b][/b], [u][/u], [i][/i], [p][/p], [img][/img], [url][/url], [list][/list], [*][/*]`


####Pre-release:
- Disallows the use of Admin pages to non-Administrator ranks (Prevents banning of members by non-Admins & guests).
- All posting, editing, deleting etc pages are restricted to logged in users (Prevents guests posting).
- Disallows all HTML from topic/board titles and descriptions.
- Limits HTML in posts to the following tags: `<p>, <a>, <b>, <strong>, <i>, <em>, <ul>, <ol>, <li> and <img>`