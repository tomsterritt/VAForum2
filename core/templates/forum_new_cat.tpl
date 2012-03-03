<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php $this->show('forum_nav.tpl'); ?>
<h3>Create New Forum Category</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    <table width="80%">
        <tr>
            <td width="25%" align="left">New Category Title: </td>
            <td align="left"><input type="text" name="cat_title" /></td>
        </tr>
        <tr>
        	<td align="left">Category Order Position: </td>
            <td align="left"><input type="text" name="cat_order" /></td>
        </tr>
        <tr>
        	<td align="left">Public Category? </td>
            <td align="left"><select name="cat_ispublic"><option value="1">Yes</option><option value="0">No</option></select></td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <input type="hidden" name="action" value="post_new_cat" />
                <input type="submit" value="Create New Forum Category">
            </td>
        </tr>
    </table>
</form>