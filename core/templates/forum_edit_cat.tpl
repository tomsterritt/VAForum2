<?php
//VAForum Original by:simpilot
//VAForum Security updates + VAForum 2.0 onwards by: Tom Sterritt
?>
<?php
$this->show('forum_nav.tpl');
?>
<h3>Edit Forum Category</h3>
<form action="<?php echo url('/Forum');?>" method="post" enctype="multipart/form-data">
    Category Name:<br />
    <input type="text" name="cat_title" value="<?php echo $cat->cat_title; ?>" /><br /><br />
    Category Order Position: 
    <input type="text" name="cat_order" value="<? echo $cat->cat_order; ?>" /><br /><br />
    Public Category?<br />
    <select name="cat_ispublic"><option value="1">Yes</option><option value="0">No</option></select><br /><br />

    <input type="hidden" name="cat_id" value="<?php echo $cat->id; ?>" />
    <input type="hidden" name="action" value="edit_old_cat" />
    <input type="submit" value="Edit Category">
</form>
<br />
<h3>Delete Forum Category</h3>
This is an unrecoverable action. The category will be permently deleted. Ensure all boards currently in this category are removed first, otherwise you will not be able to find them!<br />
<form method="post" action="<?php echo SITE_URL ?>/index.php/Forum/delete_cat">
    <input type="hidden" name="id" value="<?php echo $cat->id; ?>" />
    <input type="submit" value="Delete Category" />
</form>