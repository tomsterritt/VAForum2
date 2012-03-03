<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt

class ForumData extends Codondata {

    public static $forumrows;
    
    public static function forumrows() {
    $forumrows=ForumData::count_rows('forum');
    self::$forumrows = $forumrows;
    }

//categories

	public function create_cat($cat_title, $cat_ispublic, $cat_order)  {
        $query = "INSERT INTO forum_categories (cat_title, cat_ispublic, cat_order) VALUES ('$cat_title', '$cat_ispublic', '$cat_order')";
        
        DB::query($query);
    }
	
	public function get_cats() {
        $query = "SELECT *
                 FROM forum_categories ORDER BY cat_order ASC";

        return DB::get_results($query);
    }
	
	public function get_cat_name($id) {
        $query = "SELECT *
                  FROM forum_categories
                  WHERE id = '$id'";
        return DB::get_row($query);
    }


	
	
	public function delete_cat($id)   {
        $query = "DELETE FROM forum_categories WHERE id='$id'";
        DB::query($query);
    }
	
	public function edit_old_cat($cat_id, $cat_title, $cat_ispublic, $cat_order) {
        $query = "UPDATE forum_categories SET cat_title='$cat_title', cat_ispublic='$cat_ispublic', cat_order='$cat_order' WHERE id='$cat_id'";

        DB::query($query);
    }
	
	


//forums

    public function create_board($forum_title, $forum_description, $forum_cat, $forum_order)  {
        $query = "INSERT INTO forum_forum (forum_name, forum_desc, forum_cat, forum_order)
                VALUES ('$forum_title', '$forum_description', '$forum_cat', '$forum_order')";
        
        DB::query($query);
    }
	
	public function edit_old_board($forum_id, $forum_name, $forum_desc, $forum_cat, $forum_order) {
        $query = "UPDATE forum_forum SET forum_name='$forum_name', forum_desc='$forum_desc', forum_cat='$forum_cat', forum_order='$forum_order' WHERE id='$forum_id'";

        DB::query($query);
    }

    public function delete_board($id)   {
        $query = "DELETE FROM forum_forum WHERE id='$id'";
        DB::query($query);
        $query2 ="DELETE FROM forum_topics WHERE topic_forumid='$id'";
        DB::query($query2);
        $query3 = "DELETE FROM forum_posts WHERE forum_id='$id'";
        DB::query($query3);
    }

    public function count_rows($tablename) {
        $query = 'SELECT COUNT(`id`) AS `total`
		FROM forum_'.$tablename.'';
        $result=DB::get_row($query);
        return $result->total;
    }

    public function get_forum() {
        $query = "SELECT *
                 FROM forum_forum WHERE forum_cat = '".$catid."'";

        return DB::get_results($query);
    }
	
	public function get_forums_cat($catid) {
        $query = "SELECT *
                 FROM forum_forum WHERE forum_cat = '".$catid."'";

        return DB::get_results($query);
    }

    public function get_forum_name($id) {
        $query = "SELECT *
                  FROM forum_forum
                  WHERE id = '$id'";
        return DB::get_row($query);
    }

    public function get_posts($forum) {
        $query = "SELECT *
                 FROM forum_posts
                 WHERE forum_id='$forum'
                 ORDER BY id ASC";

        return DB::get_results($query);
    }

    //topics

    public function get_topic_count($forum) {
        $query = 'SELECT COUNT(`id`) AS `total`
		FROM forum_topics
                WHERE topic_forumid='.$forum.'';
        $result=DB::get_row($query);
        return $result->total;
    }

    public function get_topics($id) {
        $query = "SELECT *
                 FROM forum_topics
                 WHERE topic_forumid='$id'
                ORDER BY topic_dateupdated DESC";

        return DB::get_results($query);
    }

    public function is_topic_locked($id)    {
        $query = "SELECT topic_locked
                FROM forum_topics
                WHERE id='$id'";

        return DB::get_row($query);
        
    }

    public function lock_topic($id) {
        $query = "UPDATE forum_topics SET topic_locked='1' WHERE id='$id'";

        DB::query($query);
    }

    public function unlock_topic($id) {
        $query = "UPDATE forum_topics SET topic_locked='0' WHERE id='$id'";

        DB::query($query);
    }

    public function delete_topic($id) {
        $query = "DELETE FROM forum_topics WHERE id='$id'";

        DB::query($query);

        $query2 = "DELETE FROM forum_posts WHERE topic_id='$id'";

        DB::query($query2);
	}

    public function get_topic_subject($id) {
        $query = "SELECT topic_title
                FROM forum_topics
                WHERE id='$id'";

        return DB::get_row($query);
    }

    public function get_topic_name($id) {
        $query = "SELECT *
                  FROM forum_topics
                  WHERE id = '$id'";

        return DB::get_row($query);
    }

    public function edit_old_topic($topic_id, $topic_title, $topic_description)  {
        $query = "UPDATE forum_topics SET topic_title='$topic_title', topic_description='$topic_description' WHERE id='$topic_id'";

        DB::query($query);
    }

    public function move_old_topic($topic_id, $topic_forumid)   {
        $query = "UPDATE forum_topics SET topic_forumid='$topic_forumid' WHERE id='$topic_id'";

        DB::query($query);

        $query2 = "UPDATE forum_posts SET forum_id='$topic_forumid' WHERE topic_id='$topic_id'";

        DB::query($query2);
    }

    public function post_new_topic($forum_id, $pilot_id, $title, $message, $description) {
        $query= "INSERT INTO forum_topics (topic_title, topic_description, topic_forumid, topic_starter, topic_datestarted, topic_dateupdated, topic_updatedby)
                VALUES ('$title', '$description', '$forum_id', '$pilot_id', now(), now(), '$pilot_id')";

        DB::query($query);

        $query2 = "SELECT *
                FROM forum_topics
                WHERE topic_title='$title' ORDER BY id DESC LIMIT 0,1";
		
        $topic_id = DB::get_row($query2);
		
        $query3= "INSERT INTO forum_posts (topic_id, forum_id, author_id, date_posted, subject, body)
                        VALUES ('$topic_id->id', '$forum_id', '$pilot_id', now(), '$title', '$message')";

        DB::query($query3);
    }
	
	public function get_new_topics($limit){
		$query = 'SELECT * FROM forum_topics ORDER BY topic_dateupdated DESC LIMIT 0, '.$limit;	
		return DB::get_results($query);
	}

    //posts
	public function br2nl($string) { 
    	return preg_replace('`<br(?: /)?>([\\n\\r])`', '$1', $string); 
	}

	public function bb($text) { 
		$array=array( 
			"[b]" => "<b>", 
			"[/b]" => "</b>", 
			"[i]" => "<i>", 
			"[/i]" => "</i>", 
			"[u]" => "<u>",
			"[/u]" => "</u>",
			"[p]" => "<p>",
			"[/p]" => "</p>",
			"[img]" => "<img class=\"forum_img\" src=\"",
			"[/img]" => "\" img />",
			"[url]" => "<a href=\"",
			"[/url]" => "\" target=\"_blank\">Click here</a>",
			"[list]" => "<ul>",
			"[/list]" => "</ul>",
			"[*]" => "<li>",
			"[/*]" => "</li>"
		);
		$newtext = str_replace(array_keys($array), array_values($array), $text);
		return $newtext;
	} 
	
	public function unbb($text){
		$array = array(
			"<b>" => "[b]",
			"</b>" => "[/b]",
			"<i>" => "[i]",
			"</i>" => "[/i]",
			"<u>" => "[u]",
			"</u>" => "[/u]",
			"<p>" => "[p]",
			"</p>" => "[/p]",
			"<img class=\"forum_img\" src=\"" => "[img]",
			"\" img />" => "[/img]",
			"<a href=\"" => "[url]",
			"\" target=\"_blank\">Click here</a>" => "[/url]",
			"<ul>" => "[list]",
			"</ul>" => "[/list]",
			"<li>" => "[*]",
			"</li>" => "[/*]"
		);
		$newtext = str_replace(array_keys($array), array_values($array), $text);
		return $newtext;
	}
			

    public function get_post_count($forum) {
        $query = 'SELECT COUNT(`id`) AS `total`
		FROM forum_posts
                WHERE forum_id='.$forum.'';
        $result=DB::get_row($query);
        return $result->total;
    }

    public function get_post_count_topic($id) {
        $query = 'SELECT COUNT(`id`) AS `total`
		FROM forum_posts
                WHERE topic_id='.$id.'';
        $result=DB::get_row($query);
        return $result->total;
    }

    public function get_topic_posts($id) {
        $query= 'SELECT *
                FROM forum_posts
                WHERE topic_id='.$id.'
                ORDER BY date_posted ASC';

        return DB::get_results($query);
    }

    public function submit_post($topic_id, $forum_id, $pilot_id, $subject, $message) {
		date_default_timezone_set('Europe/London');
        $query= "INSERT INTO forum_posts (topic_id, forum_id, author_id, date_posted, subject, body)
                  VALUES ('$topic_id', '$forum_id', '$pilot_id', now(), 'RE: $subject', '$message')";

        DB::query($query);

        $query2 = "UPDATE forum_topics SET topic_dateupdated=now(), topic_updatedby='$pilot_id' WHERE id='$topic_id'";

        DB::query($query2);
    }

    public function get_post($id)   {
        $query = "SELECT *
                 FROM forum_posts
                 WHERE id = '$id'";

        return DB::get_row($query);
    }

    public function edit_old_post($post_id, $message)   {
        $query = "UPDATE forum_posts SET body='$message' WHERE id='$post_id'";

        DB::query($query);
    }

    public function delete_post($id)    {
        $query = "DELETE FROM forum_posts WHERE id='$id'";

        DB::query($query);
    }



    //pilots

    public function get_pilot_post_count($id) {
        $query = 'SELECT COUNT(`id`) AS `total`
		FROM forum_posts
                WHERE author_id='.$id.'';
        $result=DB::get_row($query);
        return $result->total;
    }

    public function is_moderator($id)   {
        $query = "SELECT *
                FROM forum_moderators
                WHERE pilot_id='$id' AND (mod_level='1' OR mod_level='2')";
        return DB::get_row($query);
    }
	
	public function is_admin($id){
		$query = "SELECT * FROM forum_moderators WHERE pilot_id='$id' AND mod_level='2'";
		return DB::get_row($query);
	}

    public function delete_status($id)  {
        $query = "DELETE FROM forum_moderators WHERE pilot_id='$id'";

        DB::query($query);
    }

    public function new_user_status($pilot_id, $status)   {
        $query = "INSERT INTO forum_moderators (pilot_id, mod_level)
                VALUES ('$pilot_id', '$status')";

        DB::query($query);
    }

    public function update_user_status($pilot_id, $status)  {
        $query = "UPDATE forum_moderators SET mod_level='$status' WHERE pilot_id='$pilot_id'";

        DB::query($query);
    }

}
