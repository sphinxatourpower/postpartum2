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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $customer_name;?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button">返回列表</a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-breast1c"><?php echo $tab_breast1c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-breast1c">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-breast1clist"><?php echo $tab_breast1c; ?></a>
            <span id="breast1c-add"><?php echo $button_add_breast1c; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addBreast1c();" /></span>
			
			<?php if (count($breast1cforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($breast1cforms as $breast1cform) { ?>
            <a title="<?php echo $breast1cform['date_added']; ?>" alt="<?php echo $breast1cform['date_added']; ?>" href="#tab-breast1cform-<?php echo $form_row; ?>" id="breast1cform-<?php echo $form_row; ?>"><?php echo $tab_breast1cform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'breast/breast1c')) { ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delBreast1c(<?php echo $breast1cform['customer_breast1c_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a><img style="float:left;margin-top:-28.5px;margin-left:5px;*display:none;cursor:crosshair;" src="view/image/copy.png" title="複製此單新增" alt="複製此單新增" onclick="addBreast1c(null, <?php echo $form_row; ?>);"/>
            <?php $form_row++; ?>
            <?php } ?>

			<?php if (count($breast1cforms) > 12) { ?>
			</div>
			<?php } ?>
			
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-breast1clist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($breast1cforms as $breast1cform) { ?>
		<div id="tab-breast1cform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $breast1cform['date_added']; ?> <?php echo $tab_breast1cform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="breast1cform[<?php echo $form_row; ?>][customer_breast1c_id]" value="<?php echo $breast1cform['customer_breast1c_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">填表日期</td>
				<td width="35%"><input type="text" name="breast1cform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  $breast1cform['date_added'] ;?>" size="12" /></td>
                <td width="15%">指導人員</td>
                <td width="35%"><select name="breast1cform[<?php echo $form_row; ?>][nurse_id]">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $breast1cform['nurse_id']) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
		</table>
					
			<div id="tab-breast1c-body-<?php echo $form_row;?>" >
			<table class="form list">
				<thead>
				  <tr>
					<td class="center" width="30%">項目</td>
					<td class="center" width="70%">內容</td>
				  </tr>
				</thead>
				  <tr>
					<td class="caption" rowspan="5">一、評估：</td>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk1]"  <?php echo ($breast1cform['chk1']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk1'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk2]"  <?php echo ($breast1cform['chk2']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk2'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($breast1cform['chk3']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk3'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk4]"  <?php echo ($breast1cform['chk4']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk4'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk5]"  <?php echo ($breast1cform['chk5']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk5'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td class="caption" rowspan="10">二、哺育知識：</td>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk6]"  <?php echo ($breast1cform['chk6']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk6'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk7]"  <?php echo ($breast1cform['chk7']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk7'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($breast1cform['chk8']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk8'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($breast1cform['chk9']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk9'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($breast1cform['chk10']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk10'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($breast1cform['chk11']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk11'); ?></div>
					</div></td>
				  </tr>			
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($breast1cform['chk12']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk12'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($breast1cform['chk13']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk13'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($breast1cform['chk14']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk14'); ?></div>
					</div></td>
				  </tr>		
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk15]"  <?php echo ($breast1cform['chk15']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk15'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td class="caption" rowspan="5">三、哺育母乳技能：</td>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($breast1cform['chk16']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk16'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($breast1cform['chk17']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk17'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk18]"  <?php echo ($breast1cform['chk18']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk18'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk19]"  <?php echo ($breast1cform['chk19']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk19'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[<?php echo $form_row; ?>][chk20]"  <?php echo ($breast1cform['chk20']=="1")? "checked":""; ?>/> <?php echo $this->language->get('text_chk20'); ?></div>
					</div></td>
				  </tr> 
			  </table>
			</div>
			
			
			<div class="inner-footing">
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a  onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		</form>	
		</div>
		<?php $form_row++; ?>
        <?php } ?>
	  </div>

	  
      <div id="tab-datatable"  style="display:none;">
		<?php if (!empty($dtab)) { ?>
		<?php 	foreach ($dtab as $db) { ?>
			<table class="form list">
				<tbody>
					<tr><td width="33%">產婦姓名：<?php echo $db['customer_name']; ?></td><td width="33%">嬰兒姓名：<?php echo $db['name']; ?></td><td width="33%">父親姓名：<?php echo $db['spouse_name']; ?></td></tr>
					<tr><td width="33%">房號：<?php echo $db['customer_firstroom']; ?></td>
					<td colspan="2" width="66%">
					<?php foreach ($db['customer_transfers'] as $transfer) { ?>
						轉床紀錄：<?php echo $transfer['date_added']; ?>&nbsp;轉為：<?php echo $transfer['customer_room_name']; ?><br />
					<?php } ?>
					</td></tr>
					<tr><td width="33%">嬰兒出生日期：<?php echo $db['birthdate']; ?></td><td width="33%">產婦入住日期：<?php echo $db['date_added']; ?></td><td width="33%">預定退住日期：<?php echo $db['date_leave']; ?></td></tr>
					<tr><td width="33%">生產方式：<?php echo $db['childbirth_method']; ?></td><td width="66%" colspan="2">生產醫院：<?php echo $db['childbirth_hospital']; ?></td></tr>
					<tr><td width="33%">週數：<?php echo $db['pregnancy_weeks']; ?>週<br />胎兒產胎次：G:<?php echo $db['child_count_g']; ?>&nbsp;&nbsp;P:<?php echo $db['child_count_p']; ?></td><td width="66%" colspan="2">生產醫師：<?php echo $db['childbirth_doctor']; ?><br />Apgar：<?php echo $db['apgar_score_1']; ?> (1min) --> <?php echo $db['apgar_score_5'];?> (5min)</</td></tr>
					<tr><td colspan="3">嬰兒出生時體重：<?php echo $db['birthweight']; ?> 公克 &nbsp;頭圍：<?php echo $db['birthhead']; ?> 公分 &nbsp;身長：<?php echo $db['birthlength']; ?> 公分，入住時體重：<?php echo $db['inweight']; ?> 公克</td></tr>
					<tr><td colspan="3">乙型鏈球菌檢查：<?php echo $db['b_streptococcus_check']; ?></td></tr>
				</tdoby>
			</table><br />
		<?php 	} ?> 
		<?php } ?>
      </div>
      
    </div>

  </div>
</div>

<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
function delBreast1c(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=breast/breast1c/delete&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}

	$('.mybox > div').on('click', function(event) { 
		if(event.target.type !== "checkbox") {
			$('input:checkbox', this).trigger('click');
		}
	});
//--></script>
<script type="text/javascript"><!--
<?php 
$bodydivrow = 1;
foreach ($breast1cforms as $breast1cform) { 
$date_assign = (isset($breast1cform['date_added']))? $breast1cform['date_added'] : date('Y-m-d');
?>
$('#tab-breast1cform-<?php echo $bodydivrow; ?> #tabs2-<?php echo $bodydivrow; ?> a').tabs(); 
<?php 
$bodydivrow ++;
} 
?>
//--></script> 
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addBreast1c(date, tabid) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
		html  = '<div id="tab-breast1cform-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_breast1cform; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="breast1cform[' + form_row + '][customer_breast1c_id]" value="" />';
		html += '          <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">填表日期</td>';
		html += '				<td width="35%"><input type="text" name="breast1cform[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td width="15%">指導人員</td>';
		html += '                <td width="35%"><select name="breast1cform[' + form_row + '][nurse_id]">';
	<?php foreach ($nurses as $nurse) { ?>
	<?php if ($nurse['user_id'] == $logged_id) { ?>
		html += '                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>';
	<?php } else { ?>
		html += '                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>';
	<?php } ?>
	<?php } ?>
		html += '                  </select></td>';
		html += '              </tr>';
		html += '		</table>';


		html += '			<div id="tab-breast1c-body-' + form_row + '" >';
		html += '			<table class="form list">';
		html += '				<thead>';
		html += '				  <tr>';
		html += '					<td class="center" width="30%">項目</td>';
		html += '					<td class="center" width="70%">內容</td>';
		html += '				  </tr>';
		html += '				</thead>';
		html += '				  <tr>';
		html += '					<td class="caption" rowspan="5">一、評估：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk1]"/> <?php echo $this->language->get('text_chk1'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk2]" /> <?php echo $this->language->get('text_chk2'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk3]" /> <?php echo $this->language->get('text_chk3'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk4]"/> <?php echo $this->language->get('text_chk4'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk5]" /> <?php echo $this->language->get('text_chk5'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td class="caption" rowspan="10">二、哺育知識：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk6]" /> <?php echo $this->language->get('text_chk6'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk7]" /> <?php echo $this->language->get('text_chk7'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk8]" /> <?php echo $this->language->get('text_chk8'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk9]" /> <?php echo $this->language->get('text_chk9'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk10]" /> <?php echo $this->language->get('text_chk10'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk11]" /> <?php echo $this->language->get('text_chk11'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>			';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk12]" /> <?php echo $this->language->get('text_chk12'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk13]" /> <?php echo $this->language->get('text_chk13'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk14]" /> <?php echo $this->language->get('text_chk14'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>		';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk15]" /> <?php echo $this->language->get('text_chk15'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td class="caption" rowspan="5">三、哺育母乳技能：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk16]" /> <?php echo $this->language->get('text_chk16'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk17]" /> <?php echo $this->language->get('text_chk17'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk18]" /> <?php echo $this->language->get('text_chk18'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk19]" /> <?php echo $this->language->get('text_chk19'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="checkbox"  value="1" name="breast1cform[' + form_row + '][chk20]" /> <?php echo $this->language->get('text_chk20'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr> ';
		html += '			  </table>';
		
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';			
	html += '</div>';

	
	$('#tab-breast1c').append(html);
	
	if (tabid) {
	/*
			$('#tab-breast1cform-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-breast1cform-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=days_livein]').val($('#tab-breast1cform-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=chk24]').val($('#tab-breast1cform-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=chk25]').val($('#tab-breast1cform-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=chk26]').val($('#tab-breast1cform-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=chk27a]').val($('#tab-breast1cform-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-breast1cform-'+ form_row + ' input[name*=chk27b]').val($('#tab-breast1cform-'+ tabid + ' input[name*=chk27b]').val());
	*/
			<?php for ($i=1; $i<=20; $i++) { ?>
					if ($('#tab-breast1cform-'+ tabid + ' input[name$="[chk<?php echo $i; ?>]"]').attr('checked')=='checked') {
						$('#tab-breast1cform-'+ form_row + ' input[name$="[chk<?php echo $i; ?>]"]').prop("checked", true);
					}
			<?php } ?>
			/*
			$('#tab-breast1cform-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-breast1cform-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			*/
			//$('#tab-breast1cform-'+ form_row + ' [name*=supplement]').text($('#tab-breast1cform-'+ tabid + ' [name*=supplement]').val());
	}
	
	$('.backlist').show();
	
	$('#breast1c-add').before('<a href="#tab-breast1cform-' + form_row + '" id="breast1cform-' + form_row + '"><?php echo $tab_breast1cform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#breast1cform-' + form_row + '\').remove(); $(\'#tab-breast1cform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	$('#tabs2-'+ form_row +' a').tabs();
	
	$('.mybox > div').on('click', function(event) { 
		if(event.target.type !== "checkbox") {
			$('input:checkbox', this).trigger('click');
		}
	});
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('.time').timepicker({timeFormat: 'hh:mm'});
	
	$('#breast1cform-' + form_row).trigger('click');
	
	form_row++;
}
function savenew(form_row) {
	$('.success, .warning').remove();
	$('.content').hide();
	$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 保存中...</h2></center></div>');
	$('#form-'+form_row).submit();
}
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#vtabs a').tabs();
$('.backlist').hide();
$('#vtabs .scrolldiv').mCustomScrollbar();
//--></script> 
<script type='text/javascript'><!--
	$(document).ready(function() {	
		$('.backlist').click(function() {
			$('#vtabs a:first').trigger('click');
			$('.backlist').hide();
			return false;
		});
		$('[id^=breast1cform]').click(function() {
			$('.backlist').show();
		});
		$('form').submit(function() {
			$('.success, .warning').remove();
			$('.content').hide();
			$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 保存中...</h2></center></div>');
		});
	});
//--></script> 
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	dateFormat: 'yy-mm-dd'
});
$('.time').live().timepicker({timeFormat: 'hh:mm'});
//--></script> 
<script type='text/javascript'><!--
	$(document).ready(function() {		
		$('#calendar').fullCalendar({
			header: {
				left: 'today',
				center: 'prev title next',
				right: 'basicWeek,month'
			},
			buttonText: {
			    today:    '返回今日',
				month:    '按月',
				week:     '按週'
			},
			height: 600,
			defaultView: 'basicWeek',
			editable: false,
			monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
			monthNamesShort: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
			dayNames: ['週日', '週一', '週二', '週三', '週四', '週五', '週六'],
			dayNamesShort: ['週日', '週一', '週二', '週三', '週四', '週五', '週六'],
			columnFormat: {    
					month: 'ddd', 
					week: 'MM/dd ddd', 
					day: 'M/d dddd' 
			},
			events: [
<?php 
$roww = 1;
foreach ($breast1cforms as $breast1cform) { 
		$time = strtotime($breast1cform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_breast1cform ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#breast1cform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($breast1cforms)) { ?>,<?php } ?>
				
<?php 
$roww ++;
} 
?>
			],
			eventClick: function(event) {
				if (event.url) {
					$(event.url).trigger('click');
					return false;
				}
			},
			dayClick: function(MyDate, event) {		
				myDateString = MyDate.getFullYear() + '-'
							 + ('0' + (MyDate.getMonth()+1)).slice(-2) + '-'
							 + ('0' + MyDate.getDate()).slice(-2);
				addBreast1c(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-breast1cform-1]").live("click", function () {
			$('#breast1cform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>