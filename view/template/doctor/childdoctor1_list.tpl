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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form action="" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'c.birthdate') { ?>
                <a href="<?php echo $sort_birthdate; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_birthdate; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_birthdate; ?>"><?php echo $column_birthdate; ?></a>
                <?php } ?></td> 
              <td class="left"><?php if ($sort == 'c.date_leave') { ?>
                <a href="<?php echo $sort_date_leave; ?>" class="<?php echo strtolower($order); ?>">寶寶預計退住時間</a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_leave; ?>">寶寶預計退住時間</a>
                <?php } ?></td> 
			  <td class="left"><?php if ($sort == 'customer_name') { ?>
                <a href="<?php echo $sort_customer_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_customer_name; ?>"><?php echo $column_customer_name; ?></a>
                <?php } ?></td>
			  <td class="left"><?php echo $column_customer_room; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" size="15" /></td>
			  <td><input type="text" name="filter_birthdate" value="<?php echo $filter_birthdate; ?>" size="15"  id="datebirth" /></td>
			  <td><input type="text" name="filter_date_leave" value="<?php echo $filter_date_leave; ?>" size="15"  id="dateleave" />(以前未退住)</td>
			  <td><input type="text" name="filter_customer_name" value="<?php echo $filter_customer_name; ?>" size="15" /></td>
			  <td></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a> <a onclick="reset_filter();" class="button"><?php echo $button_reset_filter; ?></a></td>
            </tr>
            <?php if ($childs) { ?>
            <?php foreach ($childs as $child) { ?>
            <tr>
              <td class="left"><?php echo $child['name'];?></td>
			  <td class="left"><?php echo $child['birthdate']; ?></td>
			  <td class="left"><?php echo $child['date_leave']; ?></td>
			  <td class="left"><?php echo $child['customer_name']; ?></td>
			  <td class="left"><?php echo $child['customer_room']; ?></td>
              <td class="right"><?php foreach ($child['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="10"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function reset_filter() {
	url = 'index.php?route=doctor/childdoctor1&token=<?php echo $token; ?>';
	location = url;
}
function filter() {
	url = 'index.php?route=doctor/childdoctor1&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_customer_name = $('input[name=\'filter_customer_name\']').attr('value');
	
	if (filter_customer_name) {
		url += '&filter_customer_name=' + encodeURIComponent(filter_customer_name);
	}
		
	var filter_birthdate = $('input[name=\'filter_birthdate\']').attr('value');
	
	if (filter_birthdate) {
		url += '&filter_birthdate=' + encodeURIComponent(filter_birthdate);
	}
	
	var filter_date_leave = $('input[name=\'filter_date_leave\']').attr('value');
	
	if (filter_date_leave) {
		url += '&filter_date_leave=' + encodeURIComponent(filter_date_leave);
	}
	
	location = url;
}
//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('[id^=date]').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script>
<?php echo $footer; ?> 