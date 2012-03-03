<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<h3>New Post</h3>
<center>
    <form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
        <table width="80%">
            <tr>
                <td>Posted By:</td>
                <td align="left"><b><?php echo Auth::$userinfo->firstname.' '.Auth::$userinfo->lastname?></b></td>
            </tr>
            <tr>
                <td>RE: </td>
                <td align="left"><?php $topic = ForumData::get_topic_name($topic_id); $name = $topic->topic_title; echo $name; ?></td>
            </tr>
            <tr>
                <td>New Post</td>
                <td align="left"><textarea rows="10" cols="50" name="message" value=""></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="hidden" name="topic_id" value="<?php echo $topic_id; ?>" />
                    <input type="hidden" name="forum_id" value="<?php echo $forum_id; ?>" />
                    <input type="hidden" name="pilot_id" value="<?php echo Auth::$userinfo->pilotid; ?>" />
                    <input type="hidden" name="action" value="submit_new_post" />
                    <input type="submit" value="Submit Post">
                </td>
            </tr>
        </table>
    </form>
</center>