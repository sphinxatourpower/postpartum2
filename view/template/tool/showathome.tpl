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
      <h1><img src="view/image/setting.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('form').attr('action', '<?php echo $hideathome; ?>'); $('form').submit();" class="button"><?php echo $button_hideathome; ?></a><a onclick="$('form').attr('action', '<?php echo $showathome; ?>'); $('form').submit();" class="button"><?php echo $button_showathome; ?></a></div>
    </div>
    <div class="content">
      <form action="" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'room_id') { ?>
                <a href="<?php echo $sort_room_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_room; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_room_id; ?>"><?php echo $column_room; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'c.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'c.showathome') { ?>
                <a href="<?php echo $sort_showathome; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_showathome; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_showathome; ?>"><?php echo $column_showathome; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'c.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
			<td class="left"><?php if ($sort == 'c.date_leave') { ?>
                <a href="<?php echo $sort_date_leave; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_leave; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_leave; ?>"><?php echo $column_date_leave; ?></a>
                <?php } ?></td>
			<td class="left"><?php if ($sort == 'service') { ?>
                <a href="<?php echo $sort_service; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_service; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_service; ?>"><?php echo $column_service; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" size="15" /></td>
			  <td><select name="filter_room_id">
                  <option value="*"></option>
                  <?php foreach ($rooms as $room) { ?>
                  <?php if ($room['customer_room_id'] == $filter_room_id) { ?>
                  <option value="<?php echo $room['customer_room_id']; ?>" selected="selected"><?php echo $room['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $room['customer_room_id']; ?>"><?php echo $room['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_livein; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_livein; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_leave; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_leave; ?></option>
                  <?php } ?>
                </select></td>
              <td><select name="filter_showathome">
                  <option value="*"></option>
                  <?php if ($filter_showathome) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_showathome) && !$filter_showathome) { ?>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
              <td><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="15" id="datein" /></td>
			  <td><input type="text" name="filter_date_leave" value="<?php echo $filter_date_leave; ?>" size="15" id="dateleave" /></td>
			  <td><select name="filter_service_id">
                  <option value="*"></option>
                  <?php foreach ($services as $service) { ?>
                  <?php if ($service['user_id'] == $filter_service_id) { ?>
                  <option value="<?php echo $service['user_id']; ?>" selected="selected"><?php echo $service['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $service['user_id']; ?>"><?php echo $service['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a> <a onclick="reset_filter();" class="button"><?php echo $button_reset_filter; ?></a></td>
            </tr>
            <?php if ($customers) { ?>
            <?php foreach ($customers as $customer) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($customer['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $customer['customer_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $customer['customer_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $customer['name']; ?></td>
              <td class="left"><?php echo $customer['room']; ?></td>
              <td class="left"><?php echo $customer['status']; ?></td>
              <td class="left"><?php echo $customer['showathome']; ?></td>
              <td class="left"><?php echo $customer['date_added']; ?></td>
			  <td class="left"><?php echo $customer['date_leave']; ?></td>
			  <td class="left"><?php echo $customer['service']; ?></td>
              <td class="right">
			  <?php foreach ($customer['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?>
			  </td>
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
	url = 'index.php?route=tool/showathome&token=<?php echo $token; ?>';
	location = url;
}
function filter() {
	url = 'index.php?route=tool/showathome&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_room_id = $('select[name=\'filter_room_id\']').attr('value');
	
	if (filter_room_id != '*') {
		url += '&filter_room_id=' + encodeURIComponent(filter_room_id);
	}
	
	var filter_service_id = $('select[name=\'filter_service_id\']').attr('value');
	
	if (filter_service_id != '*') {
		url += '&filter_service_id=' + encodeURIComponent(filter_service_id);
	}	
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status); 
	}	
	
	var filter_showathome = $('select[name=\'filter_showathome\']').attr('value');
	
	if (filter_showathome != '*') {
		url += '&filter_showathome=' + encodeURIComponent(filter_showathome);
	}	
		
	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
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