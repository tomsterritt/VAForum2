<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<h3>Create New Forum Board</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    <table width="80%">
        <tr>
            <td width="25%" align="left">New Board Title: </td>
            <td align="left"><input type="text" name="forum_title" value="" /></td>
        </tr>
        <tr>
            <td align="left">New Board Description: </td>
            <td align="left"><input type="text" name="forum_description" value="" /></td>
        </tr>
        <tr>
        	<td align="left">New Board Category: </td>
            <td align="left"><? 
            $results = ForumData::get_cats();
			if(!$results){$return = "There are no categories! Please make one.";}
			else{
			$return = '<select name="forum_category">';
			foreach($results as $cat){ $return.='<option value="'.$cat->id.'">'.$cat->cat_title.'</option>'; }
			$return.='</select>';
			}
			echo $return;
            ?></td>
        </tr>
        <tr>
            <td align="left">New Board Order Position: </td>
            <td align="left"><input type="text" name="forum_order" value="" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <input type="hidden" name="action" value="post_new_board" />
                <input type="submit" value="Create New Forum Board">
            </td>
        </tr>
    </table>
</form>