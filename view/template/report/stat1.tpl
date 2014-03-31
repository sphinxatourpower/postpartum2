<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?><?php echo (isset($customer_name)) ? "－".$customer_name : ""; ?></h1>
	  <?php if (isset($nurse2cs)) { ?>
	  <div class="buttons"><a onclick="location = '<?php echo $viewchart; ?>'" class="button" id="viewchart">觀看統計圖</a></div>
	  <?php } ?>
    </div>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_date_start; ?><br />
            <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" size="12" /></td>
          <td><?php echo $entry_date_end; ?><br />
            <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" size="12" /></td>
          <td>按產婦搜尋<br />
            <select name="filter_customer">
			  <option value="">請選擇</option>
              <?php foreach ($customers as $customer) { ?>
              <?php if ($customer['value'] == $filter_customer_id) { ?>
              <option value="<?php echo $customer['value']; ?>" selected="selected"><?php echo $customer['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $customer['value']; ?>"><?php echo $customer['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>	
          <td style="text-align: right;"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
        </tr>
      </table>
	  <?php //print"<pre>";print_r($nurse2cs);print"</pre>";?>
	  
<?php if (isset($nurse2cs)) { ?>
      <table class="list">
        <thead>
          <tr>
            <td class="left">編號</td>
            <td class="left">項目</td>
			<?php foreach ($nurse2cs as $nurse2c) { ?>
            <td class="center"><?php print $nurse2c['date_added'];  ?></td>
			<?php } ?>
          </tr>
        </thead>
        <tbody>
		<?php foreach ($roo as $rk => $ro) { ?>
          <tr>
            <td class="left"><?php print $rk+1;?></td>
            <td class="left"><?php print $ro; ?></td>
			<?php foreach ($nurse2cs as $nk => $nurse2c) { ?>
            <td class="center"><?php print $nurse2c[$rk+1];?></td>
			<?php } ?>
          </tr>
		<?php } ?>
        </tbody>
      </table>
      <div class="pagination"><?php echo $pagination; ?></div>
<?php } ?>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/stat1&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_customer_id = $('select[name=\'filter_customer\']').attr('value');
	
	if (filter_customer_id) {
		url += '&filter_customer_id=' + encodeURIComponent(filter_customer_id);
	}
	

	location = url;
}
$(function () {
	$("select[name=filter_customer]").change(function () {
		$("#viewchart").hide();
		$("table.list").hide();
		$(".pagination").hide();
	});
});
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<?php echo $footer; ?>