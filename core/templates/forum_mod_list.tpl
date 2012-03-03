<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php
$this->show('forum_nav.tpl');
echo '<h3>User Administration</h3>';
echo '<center>';
echo '<table width="100%" cellspacing="0" cellpadding="2" class="forumtable">';
echo '<tr>';
echo '<td><b>Current Status</b></td><td><b>Pilot</b></td><td><b>Edit Status</b></td>';
echo '</tr>';
foreach ($moderators as $moderator) {
    echo '<tr>';
    $current = ForumData::is_moderator($moderator->pilotid);
    if ($current->mod_level == 1) {$user_level = '<font color="#FF9900">Moderator</font>';}
    elseif ($current->mod_level == 2) {$user_level = '<font color="#FF0000">Administrator</font>';}
    elseif ($current->mod_level == 3) {$user_level = '<font color="#FF0000">Banned</font>';}
    else {$user_level= '<font color="#009933">User</font>'; }
    echo '<td>'.$user_level.'</td>';
    echo '<td>'.PilotData::GetPilotCode($moderator->code, $moderator->pilotid).' - '.$moderator->firstname.' '.$moderator->lastname.'</td>';
    echo '<td>';
    if ($moderator->pilotid == 1) {echo '&nbsp';}
    else {echo '<a href="'.url('Forum/edit_user?id='.$moderator->pilotid.'').'">Edit</a></td>';}
    echo '</tr>';
}
echo '</table>';
echo '</center>';
?>