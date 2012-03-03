<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<h3>Edit Topic</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    <table width="80%">
        <?php $startedby=PilotData::GetPilotData($topic->topic_starter); ?>
        <tr>
            <td>Topic Started By:</td>
            <td align="left"><b><?php echo $startedby->firstname.' '.$startedby->lastname.' - '.PilotData::GetPilotCode($startedby->code, $topic->topic_starter); ?></b></td>
        </tr>
        <tr>
            <td>Topic Title: </td>
            <td align="left"><input type="text" name="topic_title" value="<?php echo $topic->topic_title; ?>" /></td>
        </tr>
        <tr>
            <td>Topic Description: </td>
            <td align="left"><textarea rows="2" cols="50" name="topic_description"><?php echo $topic->topic_description; ?></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="hidden" name="topic_id" value="<?php echo $topic->id; ?>" />
                <input type="hidden" name="topic_forumid" value="<?php echo $topic->topic_forumid; ?>" />
                <input type="hidden" name="action" value="edit_old_topic" />
                <input type="submit" value="Edit Topic">
            </td>
        </tr>
    </table>
</form>
<h3>Move Topic</h3>
Topic Name: <b><?php echo $topic->topic_title; ?></b><br />
Topic Description: <b><?php echo $topic->topic_description; ?></b><br />
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    Move Topic To:
    <select name="topic_forumid">
        <option value="<?php $cur_forum = ForumData::get_forum_name($topic->topic_forumid); echo $cur_forum->id; ?>"><?php echo $cur_forum->forum_name; ?></option>
        <?php
        foreach ($forums as $forum) {echo '<option value="'.$forum->id.'">'.$forum->forum_name.'</option>'; }
        ?>
    </select>
    <br /><br />
    <input type="hidden" name="topic_id" value="<?php echo $topic->id; ?>" />
    <input type="hidden" name="action" value="move_old_topic" />
    <input type="submit" value="Move Topic">
</form>
<?php
$locked = ForumData::is_topic_locked($topic->id);
if ($locked->topic_locked == '0') {
    echo '<h3>Lock Topic</h3>';
    echo '<form method="post" action="'.SITE_URL.'/index.php/Forum/lock_topic">';
    echo '<input type="hidden" name="forum_id" value="'.$topic->topic_forumid.'" />';
    echo '<input type="hidden" name="id" value="'.$topic->id.'" />';
    echo '<input type="submit" value="Lock Topic"></form>';
}
else {
    echo '<h3>Unlock Topic</h3>';
    echo '<form method="post" action="'.SITE_URL.'/index.php/Forum/unlock_topic">';
    echo '<input type="hidden" name="forum_id" value="'.$topic->topic_forumid.'" />';
    echo '<input type="hidden" name="id" value="'.$topic->id.'" />';
    echo '<input type="submit" value="Unlock Topic"></form>';
}
?>
<h3>Delete Topic</h3>
This is an unrecoverable action. The topic and all posts contained in the topic will be permently deleted.<br />
<form method="post" action="<?php echo SITE_URL ?>/index.php/Forum/delete_topic">
    <input type="hidden" name="id" value="<?php echo $topic->id; ?>" />
    <input type="submit" value="Delete Topic" /></form>