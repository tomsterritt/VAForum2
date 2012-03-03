<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php
$this->show('forum_nav.tpl');
?>
<h3>Edit User</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    <?php
    if ($modinfo->mod_level == 1) {$user_level = '<font color="#FF9900">Moderator</font>';}
    elseif ($modinfo->mod_level == 2) {$user_level = '<font color="#FF0000">Administrator</font>';}
    elseif ($modinfo->mod_level == 3) {$user_level = '<font color="#FF0000">Banned</font>';}
    else {$user_level= '<font color="#009933">User</font>'; }
    echo 'User:<br /><b>'.$userinfo->firstname.' '.$userinfo->lastname.'</b><br /><br />';
    echo 'Current Status:<br /><b>'.$user_level.'</b><br /><br />';
    ?>
    New Status:<br />
    <select name="status">
        <option value="0">User</option>
        <option value="1" <? if($modinfo->mod_level == 1){ ?> selected="selected" <? } ?>>Moderator</option>
        <option value="2" <? if($modinfo->mod_level == 2){ ?> selected="selected" <? } ?>>Administrator</option>
        <option value="3" <? if($modinfo->mod_level == 3){ ?> selected="selected" <? } ?>>Banned</option>
    </select>
    <br /><br />
    <input type="hidden" name="old_status" value="<?php echo $modinfo->mod_level; ?>" />
    <input type="hidden" name="pilot_id" value="<?php echo $userinfo->pilotid; ?>" />
    <input type="hidden" name="action" value="edit_user_status" />
    <input type="submit" value="Save User Status">
</form>