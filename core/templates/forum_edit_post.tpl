<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<h3>Edit Post</h3>

<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    <table width="80%">
        <?php $postedby=PilotData::GetPilotData($post->author_id); ?>
        <tr>
            <td>Posted By:</td>
            <td align="left"><b><?php echo $postedby->firstname.' '.$postedby->lastname.' - '.PilotData::GetPilotCode($postedby->code, $post->author_id); ?></b></td>
        </tr>
        <tr>
            <td>RE: </td>
            <td align="left"><?php $topic = ForumData::get_topic_name($post->topic_id); $name = $topic->topic_title; echo $name; ?></td>
        </tr>
        <tr>
            <td>Message</td>
            <td align="left"><textarea rows="10" cols="50" name="message" value=""><?php echo ForumData::unbb(ForumData::br2nl($post->body)); ?></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="hidden" name="post_id" value="<?php echo $post->id; ?>" />
                <input type="hidden" name="topic_id" value="<?php echo $post->topic_id; ?>" />
                <input type="hidden" name="forum_id" value="<?php echo $post->forum_id; ?>" />
                <input type="hidden" name="action" value="edit_old_post" />
                <input type="submit" value="Edit Post">
            </td>
        </tr>
    </table>
</form>

<h3>Delete Post</h3>
This is an unrecoverable action. The post will be permently deleted.<br />
<form method="post" action="<?php echo SITE_URL ?>/index.php/Forum/delete_post">
    <input type="hidden" name="id" value="<?php echo $post->id; ?>" />
    <input type="hidden" name="topic_id" value="<?php echo $post->topic_id; ?>" />
    <input type="hidden" name="forum_id" value="<?php echo $post->forum_id; ?>" />
    <input type="submit" value="Delete Post" />
</form>