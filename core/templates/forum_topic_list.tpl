<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
    <?php
    $this->show('forum_nav.tpl');
    if (!$topics) {echo '<div id="error">There are currently no topics in this forum!</div>';}
    else {
        echo '<table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">';
        echo '<tr align="left"><td width="40%">Subject</td><td width="30%">Started</td><td width="10%">Posts</td><td width="20%">Last Post</td></tr>';
        echo '</table>';
        $row = 1;
        foreach ($topics as $topic) {
            $starter=PilotData::GetPilotData($topic->topic_starter);
            echo '<table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">';
            echo '<tr class="row'.$row.'">';
            echo '<td width="40%" align="left"> <a href="'.url('Forum/get_topic_posts?id='.$topic->id).'&forum_id='.$topic->topic_forumid.'"><font size="3px"><b>'.$topic->topic_title.'</b></font></a>';
            $locked = ForumData::is_topic_locked($topic->id);
            if ($locked->topic_locked == 1) {echo '<font color="#FF0000">[Locked]</font>';}
            echo '<br />'.$topic->topic_description.'<br />';
            //moderator actions
            $mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
            if (!$mod) {echo ''; }
            elseif ($mod->mod_level <> 3) {
                echo '<a href="'.url('Forum/edit_topic?id='.$topic->id.'').'">Edit Topic</a>';
            }
            echo '</td>';
            echo '<td width="30%" align="left">'.date('d/m/Y - g:i a', strtotime($topic->topic_datestarted));
            echo '<br />'.PilotData::GetPilotCode($starter->code, $topic->topic_starter);
            echo '<td width="10%" align="left"><b>'.ForumData::get_post_count_topic($topic->id).'</td>';
            echo '<td width="20%" align="left">';
            echo date('m/d/Y - g:i a', strtotime($topic->topic_dateupdated));
            $updatedby=PilotData::GetPilotData($topic->topic_updatedby);
            echo '<br />'.PilotData::GetPilotCode($updatedby->code, $topic->topic_updatedby);
            echo '</td></tr>';

            $row = 1 - $row;
            echo '</table>';
        }
    }
    if (Auth::LoggedIn()) {
        if ($mod->mod_level == 3) { ?>
    <table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">
        <tr>
            <td align="left"><font color="#FF0000"><b>You Are Banned From Posting In This Forum Board</b></font></td>
        </tr>
    </table>
    <?php }
    else {?>
    <table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">
        <tr>
            <td align="left"><a href="<?php echo url('Forum/new_topic?forum_id='.$forum_id.''); ?>">Post New Topic</a></td>
        </tr>
    </table>
    <?php }
}?>