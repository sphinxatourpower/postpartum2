<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
<div class="box">    
    <div class="heading">
		<h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
    <div class="content">	
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">								
			<table class="form">
				<tr>
					<td><span class="required">*</span> <?php echo $entry_title; ?></td>
					<td>
						<select name="news_category_id">
						<?php foreach ($news_categories as $news_category) { ?>
						  <?php if ($news_category['news_category_id'] == $news_category_id) { ?>
						  <option value="<?php echo $news_category['news_category_id']; ?>" selected="selected"><?php echo $news_category['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $news_category['news_category_id']; ?>"><?php echo $news_category['name']; ?></option>
						  <?php } ?>
						<?php } ?>
						</select>&nbsp;<input name="title" size="80" value="<?php echo $title; ?>" /><?php if (isset($error_news_category)) { ?>
									<span class="error"><?php echo $error_news_category; ?></span>
								<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_date_added; ?></td>
					<td><input type="text" class="date" name="date_added" value="<?php echo $date_added<>'0000-00-00 00:00:00' && $date_added<>'' ? date('Y-m-d', strtotime($date_added)) : ''; ?>" /> <input type="text" class="time" name="date_added_time" value="<?php echo $date_added<>'0000-00-00 00:00:00' && $date_added<>'' ? date('H:i:s', strtotime($date_added)) : ''; ?>" />
					<?php if (isset($error_date_added)) { ?>
					<span class="error"><?php echo $error_date_added; ?></span>
					<?php } ?>
					</td>
				</tr>
				<tr>
					<td><span class="required">*</span> <?php echo $entry_service; ?></td>
					<td><select name="user_id">
						<?php foreach ($nurses as $nurse) { ?>
						  <?php if ($nurse['user_id'] == $logged_id) { ?>
						  <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
						  <?php } elseif ($nurse['user_id'] == $user_id) { ?>
						  <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
						  <?php } ?>
						<?php } ?>
					</select>
					<?php if (isset($error_user)) { ?>
					<span class="error"><?php echo $error_user; ?></span>
					<?php } ?></td>
				</tr>
				<tr>
					<td><span class="required">*</span> <?php echo $entry_description; ?></td>
					<td>
						<textarea name="description" cols="90" rows="5"><?php echo $description; ?></textarea>
								<?php if (isset($error_description)) { ?>
									<span class="error"><?php echo $error_description; ?></span>
								<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_comment; ?></td>
					<td><textarea name="comment" cols="90" rows="5"><?php echo $comment; ?></textarea></td>
				</tr>
<!--				
				<tr>
					<td><?php echo $entry_image; ?></td>
					<td valign="top">
						<div class="image">
							<img src="<?php echo $preview; ?>" alt="" id="thumb" />
							<input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
							<br /><a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a>
						</div>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_status; ?></td>
					<td><select name="status">
						<?php if ($status) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					  </select></td>
				  </tr>
-->				
      </table>
    </form>
  </div>
 </div>
</div>


<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/ui/i18n/jquery.ui.timepicker-zh-TW.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery.ui.timepicker-addon.css" />
<script type="text/javascript"><!--
$('input.date').datepicker({
	dateFormat: 'yy-mm-dd'
});
$('.time').timepicker({timeFormat: 'HH:mm:ss'});
//--></script>
<?php echo $footer; ?>