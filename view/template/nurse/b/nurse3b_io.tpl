<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr class="filter">
      <td>時間</td>
      <td>嬰兒室 I/O 紀錄</td>
	   <td></td>
    </tr>
  </thead>
    <?php if ($iotables) { ?>
	<?php $io_row = 0; ?>
    <?php foreach ($iotables as $iotable) { ?>
	<input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][child_nurse3b_id]" value="<?php echo $iotable['child_nurse3b_id']; ?>" />
	<tbody id="io-row<?php echo $io_row; ?>">
    <tr>
      <td class="center"><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][child_nurse3b_io_id]" value="<?php echo $iotable['child_nurse3b_io_id']; ?>" /><input type="text" class="time" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][io_time_added]" value="<?php echo $iotable['io_datetime_added_short']; ?>" size="5" /></td>
      <td class="center">
	  <?php 
		if ($iotable['babymoveto']<>'' AND $iotable['babymovewith']<>'') {
			if ($iotable['babymoveto'] == '回嬰兒室') {
				print "寶寶".$iotable['babymoveto']."，由".$iotable['babymovewith']."推回";
			} else {
				print "寶寶".$iotable['babymoveto']."，有".$iotable['babymovewith']."陪同";
			}
		}
	  ?>
	  <input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][babymovewith]" value="<?php echo $iotable['babymovewith']; ?>" /><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][babymoveto]" value="<?php echo $iotable['babymoveto']; ?>" />
	  <?php echo ($iotable['mommilk']) ? "母奶餵食 ".$iotable['mommilk']." CC" : "" ; ?><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][mommilk]" value="<?php echo $iotable['mommilk']; ?>" />
	  <?php echo ($iotable['bottlemilk']) ? "配方奶餵食 ".$iotable['bottlemilk']." CC" : "" ; ?><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][bottlemilk]" value="<?php echo $iotable['bottlemilk']; ?>" />
	  <?php echo $iotable['stoolorurine']; ?><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][stoolorurine]" value="<?php echo $iotable['stoolorurine']; ?>" />
	  <?php echo $iotable['wash']; ?><input type="hidden" name="iotable[<?php echo $iotable['tabid']; ?>][<?php echo $io_row; ?>][wash]" value="<?php echo $iotable['wash']; ?>" />
	  </td>
<?php
	if ($iotable['mommilk']) { 
		$act = "deletemilk('". $iotable['tabid']. "', 'chk7', '". $iotable['mommilk']. "');";
	} elseif ($iotable['bottlemilk']) {
		$act = "deletemilk('". $iotable['tabid']. "', 'chk6', '". $iotable['bottlemilk']. "');";
	} elseif ($iotable['stoolorurine']=="大便") {
		$act = "deletestoolurine('". $iotable['tabid']. "', 'chk12', '1');";
	} elseif ($iotable['stoolorurine']=="小便") {
		$act = "deletestoolurine('". $iotable['tabid']. "', 'chk11', '1');";
	} else {
		$act = "";
	}
?>
	  <td class="right"><a onclick="$(this).parent().parent().parent().remove();removeIO(<?php echo $iotable['child_nurse3b_io_id'];?>, <?php echo $iotable['child_nurse3b_id'];?>, <?php echo $iotable['tabid'];?>);<?php echo $act; ?>" class="button">刪除紀錄</a></td>
    </tr>
	</tbody>
	 <?php $io_row++; ?>
    <?php } ?>
    <?php } else { ?>
	<tbody>
    <tr>
      <td class="center" colspan="3"><?php echo $text_no_results; ?></td>
    </tr>
	</tbody>
    <?php } ?>
  
</table>
<script type="text/javascript"><!--
$('.time').live().timepicker({timeFormat: 'hh:mm'});
//--></script> 