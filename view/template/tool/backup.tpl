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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/backup.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
		<div id="tabs" class="htabs"><a href="#tab-backup"><?php echo $tab_backup; ?></a><a href="#tab-restore"><?php echo $tab_restore; ?></a></div>
		<div id="tab-backup">
		  <form action="<?php echo $backup; ?>" method="post" enctype="multipart/form-data" id="backup">
			<table class="form">
			  <tr>
				<td><?php echo $entry_backup; ?></td>
				<td><div class="scrollbox" style="margin-bottom: 5px;">
					<?php $class = 'odd'; ?>
					<?php foreach ($tables as $table) { ?>
					<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
					<div class="<?php echo $class; ?>">
					  <input type="checkbox" name="backup[]" value="<?php echo $table; ?>" checked="checked" />
					  <?php echo $table; ?></div>
					<?php } ?>
				  </div>
				  <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
			  </tr>
			</table>
		  </form>
		  <a onclick="$('#backup').submit();" class="button"><?php echo $button_backup; ?></a>
		</div>
		<div id="tab-restore">
		  <form action="<?php echo $restore; ?>" method="post" enctype="multipart/form-data" id="restore">
			<table class="form">
			  <tr>
				<td><?php echo $entry_restore; ?></td>
				<td><input type="file" name="import" /></td>
			  </tr>
			</table>
		  </form>
		  <a onclick="$('#restore').submit();" class="button"><?php echo $button_restore; ?></a>
		</div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<?php echo $footer; ?>