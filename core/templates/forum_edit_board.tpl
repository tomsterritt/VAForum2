<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt

$this->show('forum_nav.tpl');
?>
<h3>Edit Forum Board</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    Board Name:<br />
    <input type="text" name="forum_name" value="<?php echo $forum->forum_name; ?>" /><br /><br />
    Board Description:<br />
    <input type="text" name="forum_desc" value="<?php echo $forum->forum_desc; ?>" /><br /><br />
    Board Category:<br />
	<? 
            $results = ForumData::get_cats();
			if(!$results){$return = "There are no categories! Please make one.";}
			else{
			$return = '<select name="forum_category">';
			foreach($results as $cat){ $return.='<option value="'.$cat->id.'">'.$cat->cat_title.'</option>'; }
			$return.='</select>';
			}
			echo $return;
            ?><br /><br />
    Board Order Position:<br />
    <input type="text" name="forum_order" value="<?php echo $forum->forum_order; ?>" /><br /><br />

    <input type="hidden" name="forum_id" value="<?php echo $forum->id; ?>" />
    <input type="hidden" name="action" value="edit_old_board" />
    <input type="submit" value="Edit Board">
</form>
<br />
<h3>Delete Forum Board</h3>
This is an unrecoverable action. The board and all topics and posts contained in the board will be permently deleted.<br />
<form method="post" action="<?php echo SITE_URL ?>/index.php/Forum/delete_board">
    <input type="hidden" name="id" value="<?php echo $forum->id; ?>" />
    <input type="submit" value="Delete Board" />
</form>