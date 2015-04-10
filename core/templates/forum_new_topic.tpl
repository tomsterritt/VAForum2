<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<? $forumdata = ForumData::get_forum_name($forum_id); ?>
<h3>Post New Topic in <? echo $forumdata->forum_name; ?></h3>
<script src="/lib/js/ckeditor/ckeditor.js"></script>
<center>
    <form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
        <table width="80%">
            <tr>
                <td align="right">Posted By: </td>
                <td align="left"><b><?php echo Auth::$userinfo->firstname.' '.Auth::$userinfo->lastname; ?></b></td>
            </tr>
            <tr>
                <td width="25%" align="right">New Topic Title: </td>
                <td align="left"><input name="title" value="" /></td>
            </tr>
            <tr>
                <td align="right">New Topic Description: </td>
                <td align="left"><input name="description" value="" /></td>
            </tr>
            <tr>
                <td align="right">Message: </td>
                <td align="left"><textarea class="ckeditor" rows="10" cols="50" name="message" value=""></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="hidden" name="forum_id" value="<?php echo $forum_id; ?>" />
                    <input type="hidden" name="pilot_id" value="<?php echo Auth::$userinfo->pilotid; ?>" />
                    <input type="hidden" name="action" value="post_new_topic" />
                    <input type="submit" value="Post New Topic">
                </td>
            </tr>
        </table>
    </form>
</center>
