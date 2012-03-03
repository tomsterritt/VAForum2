<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
    <?php
    $this->show('forum_nav.tpl');
    $mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
    $cats = ForumData::get_cats();
    foreach($cats as $cat){
    	if($cat->cat_ispublic == '0'){
    		if($mod){
            	$row = 1;
            	echo '<div class="cat"><h4>'.$cat->cat_title.'</h4>';
                if(ForumData::is_admin(Auth::$userinfo->pilotid)){
                	echo '<a class="editcat" href="'.url('Forum/edit_cat?id='.$cat->id.'').'">Edit Category</a>';
                }
                echo '<table width="100%" cellspacing="0" cellpadding="2">';
                $forums = ForumData::get_forums_cat($cat->id);
                if(!$forums){ echo '<tr>There are no forums in this category</tr>';}else{
                	foreach ($forums as $forum) {
       					echo '<tr class="row'.$row.'">';
        				echo '<td width="25%" align="left"> <a href="'.url('Forum/get_topics?id='.$forum->id).'">'.$forum->forum_name.'</a></td>';
        				echo '<td width="55%" align="left">'.$forum->forum_desc.'</td>';
        				echo '<td width="5%" align="right">Topics:<br />Posts:</td>';
        				echo '<td width="15%" align="left"><b>'.ForumData::get_topic_count($forum->id).'<br />'.ForumData::get_post_count($forum->id);
        				echo '</b></td>';
        				if (isset($mod)) { if($mod->mod_level == '2') {echo '<td><a href="'.url('Forum/edit_board?id='.$forum->id.'').'">Edit</a></td>';}
        				}
        				echo '</tr>';
        				$row = 1 - $row;
                	}
                }  echo '</table></div>';
            }
        }
        else 
        {
        	$row = 1;
            echo '<div class="cat"><h4>'.$cat->cat_title.'</h4>';
            if(ForumData::is_admin(Auth::$userinfo->pilotid)) {
            	echo '<a class="editcat" href="'.url('Forum/edit_cat?id='.$cat->id.'').'">Edit Category</a>';
        	}
            echo '<table width="100%" cellspacing="0" cellpadding="2">';
            $forums = ForumData::get_forums_cat($cat->id);
            if(!$forums) { 
            	echo '<tr>There are no forums in this category.</tr>'; 
            } else {
            	foreach ($forums as $forum) {
       				echo '<tr class="row'.$row.'">';
        			echo '<td width="25%" align="left"> <a href="'.url('Forum/get_topics?id='.$forum->id).'">'.$forum->forum_name.'</a></td>';
        			echo '<td width="55%" align="left">'.$forum->forum_desc.'</td>';
        			echo '<td width="5%" align="right">Topics:<br />Posts:</td>';
        			echo '<td width="15%" align="left"><b>'.ForumData::get_topic_count($forum->id).'<br />'.ForumData::get_post_count($forum->id);
        			echo '</b></td>';
        			if (isset($mod)) {
                    	if($mod->mod_level == '2') {
                        	echo '<td><a href="'.url('Forum/edit_board?id='.$forum->id.'').'">Edit</a></td>';
                        }
        			}
        			echo '</tr>';
        			$row = 1 - $row;
				}
            } echo '</table></div>'; 
        }
    }
	
    $admin = ForumData::is_admin(Auth::$userinfo->pilotid);
    if ($admin) {$this->show("forum_adminnav.tpl");}
    
    ?>