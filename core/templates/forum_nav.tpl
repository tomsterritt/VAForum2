<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<table width="100%" cellspacing="0" cellpadding="0">
    <?php
    if(isset($message)) { echo '<tr><td align="left"><b>'.$message.'</b></td></tr>'; }
    ?>
</table>

<a href="<?php echo url('/Forum'); ?>">Forum Index</a>
<?php
if (isset($board_name)) {echo ' > <a href="'.url('/Forum/get_topics?id='.$board_name->id.'').'">'.$board_name->forum_name.'</a>';}
if (isset($topic_name)) {echo ' > <a href="'.url('/Forum/get_topic_posts?id='.$topic_name->id.'&forum_id='.$topic_name->topic_forumid.'').'">'.$topic_name->topic_title.'</a>';}
?>
<br />