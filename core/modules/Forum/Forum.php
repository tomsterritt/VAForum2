<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt

class Forum extends CodonModule {

    public function index() {
		if(!Auth::LoggedIn())
		{
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		}
        
        if($this->post->action == 'post_new_topic') {
            $this->post_new_topic();
        }
        if($this->post->action == 'submit_new_post') {
            $this->submit_new_post();
        }
        if($this->post->action == 'edit_old_post') {
            $this->edit_old_post();
        }
        if($this->post->action == 'edit_old_topic') {
            $this->edit_old_topic();
        }
        if($this->post->action == 'move_old_topic') {
            $this->move_old_topic();
        }
        if($this->post->action == 'post_new_board') {
            $this->post_new_board();
        }
		if($this->post->action == 'post_new_cat') {
            $this->post_new_cat();
        }
        if($this->post->action == 'edit_user_status') {
            $this->edit_user_status();
        }
        if($this->post->action == 'edit_old_board') {
            $this->edit_old_board();
        }
		if($this->post->action == 'edit_old_cat') {
            $this->edit_old_cat();
        }

        else {
            $this->render('forum_index.tpl');
        }
    }
    

    public function get_topics() {
        $id = $_GET['id'];
        $this->set('topics', ForumData::get_topics($id));
        $this->set('forum_id', $id);
        $this->set('board_name', ForumData::get_forum_name($id));
        $this->render('forum_topic_list.tpl');
    }

    public function get_topic_posts() {
        $id = $_GET['id'];
        $forum_id = $_GET['forum_id'];
        $this->set('board_name', ForumData::get_forum_name($forum_id));
        $this->set('topic_name', ForumData::get_topic_name($id));
        $this->set('posts', ForumData::get_topic_posts($id));
        $this->render('forum_post_list.tpl');
    }

    public function new_topic() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $forum_id= $_GET['forum_id'];
        $this->set('forum_id', $forum_id);
        $this->render('forum_new_topic.tpl');
    }

    //posts

    protected function post_new_topic() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $forum_id= DB::escape($this->post->forum_id);
        $title = DB::escape(strip_tags($this->post->title));
        $message = DB::escape(nl2br(ForumData::bb(strip_tags($this->post->message, '<p><a><b><i><em><strong><ul><ol><li>'))));
        $pilot_id = DB::escape($this->post->pilot_id);
        $description = DB::escape(strip_tags($this->post->description));
        ForumData::post_new_topic($forum_id, $pilot_id, $title, $message, $description);

        header('Location: '.url('/Forum/get_topics?id='.$forum_id));
    }

    public function edit_topic()    {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $topic_id = $_GET['id'];
        $this->set('forums', ForumData::get_forum());
        $this->set('topic', ForumData::get_topic_name($topic_id));
        $this->show('forum_edit_topic.tpl');
    }

    protected function edit_old_topic() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $topic_id = DB::escape($this->post->topic_id);
        $topic_title = DB::escape(strip_tags($this->post->topic_title));
        $topic_description = DB::escape(strip_tags($this->post->topic_description));
        $topic_forumid = DB::escape($this->post->topic_forumid);

        ForumData::edit_old_topic($topic_id, $topic_title, $topic_description);
        
        header('Location: '.url('/Forum/get_topics?id='.$topic_forumid));
        
    }

    public function lock_topic()    {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) { 
        	$id = DB::escape($this->post->id);
        	$forum_id = DB::escape($this->post->forum_id);
        	ForumData::lock_topic($id);
        	header('Location: '.url('/Forum/get_topics?id='.$forum_id));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    public function unlock_topic()    {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) { 
        	$id = DB::escape($this->post->id);
        	$forum_id = DB::escape($this->post->forum_id);
        	ForumData::unlock_topic($id);
        	header('Location: '.url('/Forum/get_topics?id='.$forum_id));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}	
    }

    public function delete_topic()    {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$id = DB::escape($this->post->id);
        	ForumData::delete_topic($id);
        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function move_old_topic() {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$topic_id = DB::escape($this->post->topic_id);
        	$topic_forumid = DB::escape($this->post->topic_forumid);

        	ForumData::move_old_topic($topic_id, $topic_forumid);

        	header('Location: '.url('/Forum/get_topics?id='.$topic_forumid));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    public function create_new_post() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $topic_id= $_GET['topic_id'];
        $forum_id= $_GET['forum_id'];
        $this->set('topic_id', $topic_id);
        $this->set('forum_id', $forum_id);
        $this->show('forum_new_post.tpl');
    }

    protected function submit_new_post() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $forum_id= DB::escape($this->post->forum_id);
        $topic_id = DB::escape($this->post->topic_id);
        $message = DB::escape(nl2br(ForumData::bb(strip_tags($this->post->message, '<p><a><b><i><em><strong><br><ul><ol><li>'))));
        $pilot_id = DB::escape($this->post->pilot_id);

        $subjects = ForumData::get_topic_subject($topic_id);//wrong class
        $subject = $subjects->topic_title;

        ForumData::submit_post($topic_id, $forum_id, $pilot_id, $subject, $message);

        header('Location: '.url('/Forum/get_topic_posts?id='.$topic_id.'&forum_id='.$forum_id));
    }

    public function edit_post() {
		if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $id= $_GET['id'];
        $post = ForumData::get_post($id);
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if($mod == false && $post->author_id != Auth::$userinfo->pilotid){
			$this->set('message', 'You are not permitted to edit this post!');
			$this->render('core_error.tpl');
			return;
		}
        $this->set('post', $post);
        $this->show('forum_edit_post.tpl');
    }

     protected function edit_old_post() {
		 if(!Auth::LoggedIn()) {
            $this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
        }
        $forum_id= DB::escape($this->post->forum_id);
        $topic_id= DB::escape($this->post->topic_id);
        $post_id= DB::escape($this->post->post_id);
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		$post = ForumData::get_post($post_id);
		if($mod == false && $post->author_id != Auth::$userinfo->pilotid){
			$this->set('message', 'You are not permitted to edit this post!');
			$this->render('core_error.tpl');
			return;
		}
        $message = DB::escape(nl2br(ForumData::bb(strip_tags($this->post->message, '<p><a><b><i><em><strong><br><ul><ol><li>'))));
        ForumData::edit_old_post($post_id, $message);

        header('Location: '.url('/Forum/get_topic_posts?id='.$topic_id.'&forum_id='.$forum_id.''));
    }

    public function delete_post()    {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$post_id = DB::escape($this->post->id);
        	$forum_id = DB::escape($this->post->forum_id);
        	$topic_id = DB::escape($this->post->topic_id);
        	ForumData::delete_post($post_id);
			
        	header('Location: '.url('/Forum/get_topic_posts?id='.$topic_id.'&forum_id='.$forum_id.''));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    //admin
	
	//categories
	public function create_new_cat()  {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$this->show('forum_new_cat.tpl');
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function post_new_cat() {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$cat_title = DB::escape($this->post->cat_title);
        	$cat_ispublic = DB::escape($this->post->cat_ispublic);
			$cat_order =  DB::escape($this->post->cat_order);

        	ForumData::create_cat($cat_title, $cat_ispublic, $cat_order);

        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }
	
	public function edit_cat()    {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$cat_id = $_GET['id'];
        	$this->set('cat', ForumData::get_cat_name($cat_id));
        	$this->show('forum_edit_cat.tpl');
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    public function delete_cat()    {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$id = DB::escape($this->post->id);
        	ForumData::delete_cat($id);
        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function edit_old_cat() {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$cat_id = DB::escape($this->post->cat_id);
        	$cat_title = DB::escape($this->post->cat_title);
        	$cat_ispublic = DB::escape($this->post->cat_ispublic);
			$cat_order = DB::escape($this->post->cat_order);

        	ForumData::edit_old_cat($cat_id, $cat_title, $cat_ispublic, $cat_order);

        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

	//boards

    public function create_new_board()  {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$this->show('forum_new_board.tpl');
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function post_new_board() {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$forum_title = DB::escape($this->post->forum_title);
        	$forum_description = DB::escape($this->post->forum_description);
			$forum_cat = DB::escape($this->post->forum_category);
	
    	    ForumData::create_board($forum_title, $forum_description, $forum_cat);

        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }


	//users
	
    public function moderators()    {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) { 
        	$this->set('moderators', PilotData::GetAllPilots(''));
        	$this->show('forum_mod_list.tpl');
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		} 
    }

    public function edit_user() {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$pilot_id = $_GET['id'];
			if($pilot_id == 1){
				$this->set('message', 'You are not allowed to edit user 1!');
    			$this->render('core_error.tpl');
			} else {
        		$this->set('userinfo', PilotData::getPilotData($pilot_id));
        		$this->set('modinfo', ForumData::is_moderator($pilot_id));
        		$this->show('forum_edit_user.tpl');
			}
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function edit_user_status()    {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
			if($pilot_id == 1){
				$this->set('message', 'You are not allowed to edit user 1!');
    			$this->render('core_error.tpl');
			} else {
        		$pilot_id = DB::escape($this->post->pilot_id);
        		$status = DB::escape($this->post->status);
        		$old_status = DB::escape($this->post->old_status);
		
    	    	if ($status == 0){
					ForumData::delete_status($pilot_id);
				}
        		elseif ($status >= 1){
            	 	if ($old_status == 0){
						ForumData::new_user_status($pilot_id, $status);
					}
            	 	else{
						ForumData::update_user_status($pilot_id, $status);
					}
            	} else {
					echo 'ERROR!';
				}
				header('Location: '.url('/Forum/moderators'));
			}
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    public function edit_board()    {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$forum_id = $_GET['id'];
        	$this->set('forum', ForumData::get_forum_name($forum_id));
        	$this->show('forum_edit_board.tpl');
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    public function delete_board()    {
		$mod = ForumData::is_admin(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$id = DB::escape($this->post->id);
        	ForumData::delete_board($id);
        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }

    protected function edit_old_board() {
		$mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
		if(!Auth::LoggedIn()){
			$this->set('message', 'You must be logged in to access this feature!');
            $this->render('core_error.tpl');
            return;
		} elseif ($mod) {
        	$forum_id = DB::escape($this->post->forum_id);
        	$forum_name = DB::escape($this->post->forum_name);
        	$forum_desc = DB::escape($this->post->forum_desc);
			$forum_cat = DB::escape($this->post->forum_category);
		
        	ForumData::edit_old_board($forum_id, $forum_name, $forum_desc, $forum_cat);

        	header('Location: '.url('/Forum'));
		} else {
			$this->set('message', 'You do not have permission to access this page!');
			$this->render('core_error.tpl');
			return;
		}
    }
}