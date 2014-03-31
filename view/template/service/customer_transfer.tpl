<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr>
      <td class="center"><?php echo $column_date_added; ?></td>
      <td class="center"><?php echo $column_customer_room; ?></td>
	  <td class="center"><?php echo $column_description; ?></td>
	  <td class="center"><?php echo $column_extra_period; ?></td>
	   <td width="135"></td>
    </tr>
  </thead>
    <?php if ($transfers) { ?>
	<?php $transfer_row = 0; ?>
    <?php foreach ($transfers as $transfer) { ?>
	<tbody id="transfer-row<?php echo $transfer_row; ?>">
    <tr>
      <td class="center"><input type="hidden" name="transfer[<?php echo $transfer_row; ?>][customer_transfer_id]" value="<?php echo $transfer['customer_transfer_id']; ?>" /><?php echo $transfer['date_added']; ?><input type="hidden" name="transfer[<?php echo $transfer_row; ?>][date_added]" value="<?php echo $transfer['date_added']; ?>" /></td>
      <td class="center"><?php echo $transfer['customer_room_name']; ?><input type="hidden" name="transfer[<?php echo $transfer_row; ?>][customer_room_id]" value="<?php echo $transfer['customer_room_id']; ?>" /></td>
	  <td class="center"><?php echo $transfer['description']; ?><input type="hidden" name="transfer[<?php echo $transfer_row; ?>][description]" value="<?php echo $transfer['description']; ?>" /></td>
	  <td class="center"><?php echo ($transfer['extra_period']) ? $text_yes : '' ; ?><input type="hidden" name="transfer[<?php echo $transfer_row; ?>][extra_period]" value="<?php echo $transfer['extra_period']; ?>" /></td>
	  <td class="right"><a onclick="$('#transfer-row<?php echo $transfer_row; ?>').remove();removeTransfer(<?php echo $transfer['customer_transfer_id']?>);" class="button"><?php echo $button_delete_transfer; ?></a></td>
    </tr>
	</tbody>
	 <?php $transfer_row++; ?>
    <?php } ?>
    <?php } else { ?>
	<tbody>
    <tr>
      <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
    </tr>
	</tbody>
    <?php } ?>
  
</table>
<div class="pagination"><?php echo $pagination; ?></div>