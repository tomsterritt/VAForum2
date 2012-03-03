<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
    <?php
    $this->show('forum_nav.tpl');
    $forums = ForumData::get_forum();
    $row = 1;
    foreach ($posts as $post) {
        echo '<table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">';
        echo '<tr class="row'.$row.'">';
        echo '<td align="left"><b>'.$post->subject.'</b></td>';
        //moderator options
        $mod = ForumData::is_moderator(Auth::$userinfo->pilotid);
        if ($mod) {
            if ($mod->mod_level <> 3){
                echo '<td><small>Posted: '.date('d/m/Y - g:i a', strtotime($post->date_posted)).'</small></td>';
                echo '<td style="text-align:right;"><a href="'.url('Forum/edit_post?id='.$post->id.'').'">Edit Post</a></td>';
            }
        } elseif($post->author_id == Auth::$userinfo->pilotid){
        	 echo '<td><small>Posted: '.date('d/m/Y - g:i a', strtotime($post->date_posted)).'</small></td>';
             echo '<td style="text-align:right;"><a href="'.url('Forum/edit_post?id='.$post->id.'').'">Edit Post</a></td>';
        } else {
            	echo '<td align="left"><small>Posted: '.date('d/m/Y - g:i a', strtotime($post->date_posted)).'</small></td>';
                echo '<td>&nbsp;</td>';
        }
        echo '</tr>';
        echo '<tr class="row'.$row.'"><td rowspan="2" width="25%">';
        $starter=PilotData::GetPilotData($post->author_id);
        echo "<a href=\"".url('/profile/view/'.$starter->pilotid)."\">".$starter->firstname." ".$starter->lastname."</a>";
        echo '<br /><br /><img src="'.PilotData::GetPilotAvatar($post->author_id).'" />';
        echo ForumData::get_post_count_topic($topic->id).'<br />';
        echo '<br />'.$starter->rank;
        echo '<br />'.ForumData::get_pilot_post_count($post->author_id).' Post(s)';
        echo '<br />'.$starter->hub;
        echo ' - <img src="'.SITE_URL.'/lib/images/countries/'.strtolower($starter->location).'.png" alt="Flag" /></td>';
        echo '<td align="left" colspan="2" width="75%">'.$post->body.'</td>';
        echo '</tr>';
        $signature = fileurl(SIGNATURE_PATH.'/'.PilotData::GetPilotCode($starter->code, $starter->pilotid).'.png');
        echo '<tr class="row'.$row.'"><td colspan="2"><br /><hr class="forum_sighr" /><img class="forum_signature" src="'.$signature.'" /><br /></td></tr>';
        $row = 1 - $row;
        echo '</table>';
    }
    if (Auth::LoggedIn()) {
        if ($mod->mod_level == 3) { ?>
            <table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">
                <tr>
                    <td align="left"><font color="#FF0000"><b>You Are Banned From Posting In This Forum</b></font></td>
                </tr>
            </table>
    <?php }
        else {?><br />
            <table width="100%" cellspacing="0" cellpadding="2" border="1px" rules="none" frame="box">
                <tr>
                <?php $locked = ForumData::is_topic_locked($post->topic_id);
                if ($locked->topic_locked == 1) {echo '<td align="right"><font color="#FF0000">Topic Locked</font><td>';}
                else { echo '<td align="left"><a href="'.url('Forum/create_new_post?topic_id='.$post->topic_id.'&forum_id='.$post->forum_id.'').'"><b>POST REPLY</b></a></td>'; }
                ?>
                </tr>
            </table>
    <?php }
} ?>
</center>