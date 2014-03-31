<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?><?php echo (isset($child_name)) ? "－".$child_name : ""; ?></h1>
	  <?php if (isset($nurse3bs)) { ?>
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
          <td>按嬰兒搜尋<br />
            <select name="filter_child">
			  <option value="">請選擇</option>
              <?php foreach ($childs as $child) { ?>
              <?php if ($child['value'] == $filter_child_id) { ?>
              <option value="<?php echo $child['value']; ?>" selected="selected"><?php echo $child['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $child['value']; ?>"><?php echo $child['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>			
          <td style="text-align: right;"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
        </tr>
      </table>
	  <?php //print"<pre>";print_r($nurse3bs);print"</pre>";?>

	  <?php if (isset($nurse3bs)) { ?>
      <table class="list">
        <thead>
          <tr>
            <td class="left" rowspan="2">項目</td>

		  <?php 
		  $ccc = array();
		  foreach ($nurse3bs as $d) {
			$dd[] = $d['date_added'];
		  }
		  $cdv = array_count_values($dd);
		  foreach ($nurse3bs as $m => $nurse3b) {
			if ($m==0) {
				$ccc[0]['date'] = $nurse3bs[$m]['date_added'];
				$ccc[0]['span'] = $cdv[$nurse3bs[$m]['date_added']];
				$c = $cdv[$nurse3bs[$m]['date_added']];
			}
			if ($m<>0 AND ($m-$c)%3==0) {
					$ccc[$m]['date'] = $nurse3bs[$m]['date_added'];
					if (count($nurse3bs)-$m<3) {
						$ccc[$m]['span'] = count($nurse3bs)-$m;
					} else {
						$ccc[$m]['span'] = 3;
					}
			}
		  /*
			  if ($m==0) {
					if ($nurse3b['arrangement']=="白班") {
						$ccc[0]['date'] = $nurse3bs[$m]['date_added'];
						$ccc[0]['span'] = 3;
						$c = 3;
					} elseif ($nurse3b['arrangement']=="小夜") {
						$ccc[0]['date'] = $nurse3bs[$m]['date_added'];
						$ccc[0]['span'] = 2;
						$c = 2;
					} elseif ($nurse3b['arrangement']=="大夜") {
						//$yest = date('Y-m-d', strtotime( $nurse3bs[$m]['date_added'] ) - 86400 );
						//$ccc[0]['date'] = $yest;
						$ccc[0]['date'] = $nurse3bs[$m]['date_added'];
						$ccc[0]['span'] = 1;
						$c = 1;
					}
			   }
			
				
				if ($m<>0 AND ($m-$c)%3==0) {
						$ccc[$m]['date'] = $nurse3bs[$m]['date_added'];
						if (count($nurse3bs)-$m<3) {
							$ccc[$m]['span'] = count($nurse3bs)-$m;
						} else {
							$ccc[$m]['span'] = 3;
						}
				}
				*/
				
			}
			//print"<pre>";print_r($ccc);print"</pre>";
			?>
			
		  <?php foreach ($ccc as $cc) { ?>
            <td class="center" colspan="<?php echo $cc['span']; ?>"><?php print $cc['date'];  ?></td>
		  <?php } ?>
		  			
          </tr>
		  <tr>
		  <?php foreach ($nurse3bs as $nurse3b) { ?>
            <td class="center"><?php echo $nurse3b['arrangement']; ?></td>
			<?php } ?>
		  </tr>

        </thead>
        <tbody>
		<?php foreach ($roo as $rk => $ro) { ?>
          <tr>
            <td class="left"><?php print $ro; ?></td>
			<?php foreach ($nurse3bs as $nk => $nurse3b) { ?>
            <td class="center"><?php print $nurse3b[$rk+1];?></td>
			<?php } ?>
          </tr>
		<?php } ?>
        </tbody>
      </table>
      <div class="pagination"><?php echo $pagination; ?></div>
<?php }  ?>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/stat2&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_child_id = $('select[name=\'filter_child\']').attr('value');
	
	if (filter_child_id) {
		url += '&filter_child_id=' + encodeURIComponent(filter_child_id);
	}
	
	/*
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');
	
	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	
	*/

	location = url;
}
$(function () {
	$("select[name=filter_child]").change(function () {
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