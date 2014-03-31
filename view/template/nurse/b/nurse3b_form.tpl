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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $child_name.'('.$customer_name.'的寶寶)';?></h1>
	  <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button">返回列表</a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-nurse3b"><?php echo $tab_nurse3b; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-nurse3b">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a id="nurse3blist" href="#tab-nurse3blist"><?php echo $tab_nurse3b; ?></a>
            <span id="nurse3b-add"><?php echo $button_add_nurse3b; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addNurse3b();" /></span>
			
			<?php if (count($nurse3bforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($nurse3bforms as $nurse3bform) { ?>
            <a title="<?php echo $nurse3bform['date_added']."[". $nurse3bform['arrangement'] ."]"; ?>" alt="<?php echo $nurse3bform['date_added']."[". $nurse3bform['arrangement'] ."]"; ?>" href="#tab-nurse3bform-<?php echo $form_row; ?>" id="nurse3bform-<?php echo $form_row; ?>"><?php echo $tab_nurse3bform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'nurse/nurse3b')) { ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="delNurse3b(<?php echo $nurse3bform['child_nurse3b_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($nurse3bforms) > 12) { ?>
			</div>
			<?php } ?>
			
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-nurse3blist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($nurse3bforms as $nurse3bform) { ?>
		
		<div id="tab-nurse3bform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
		    <div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $nurse3bform['date_added']; ?> <?php echo $nurse3bform['arrangement'];?> <?php echo $tab_nurse3bform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
			
			<table class="form list">
				  <tr>
					<td width="15%">日期與班別</td>
					<td width="35%"><input type="text" name="nurse3bform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo $nurse3bform['date_added']; //echo  (($nurse3bform['date_added']=='') ? date('Y-m-d') : $nurse3bform['date_added'] );?>" size="12" />
					<select name="nurse3bform[<?php echo $form_row; ?>][arrangement]">
						<option value=""></option>
						<option value="白班" <?php echo ($nurse3bform['arrangement']=="白班")? "selected=\"selected\"":""; ?>>白班</option>
						<option value="小夜" <?php echo ($nurse3bform['arrangement']=="小夜")? "selected=\"selected\"":""; ?>>小夜</option>
						<option value="大夜" <?php echo ($nurse3bform['arrangement']=="大夜")? "selected=\"selected\"":""; ?>>大夜</option>
					</select>
					</td>
					<td width="15%">護理人員</td>
					<td width="35%"><select name="nurse3bform[<?php echo $form_row; ?>][nurse_id]">
						<?php foreach ($nurses as $nurse) { ?>
						<?php if ($nurse['user_id'] == $nurse3bform['nurse_id']) { ?>
						<option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
						<?php } ?>
						<?php } ?>
					  </select></td>
				  </tr>
			</table>
			
			<div id="tabs2-<?php echo $form_row;?>" class="htabs"><a href="#tab-nurse3b-io-<?php echo $form_row;?>">I/O 紀錄單</a><a href="#tab-nurse3b-record-<?php echo $form_row;?>">資料紀錄單</a></div>
		
			<div id="tab-nurse3b-io-<?php echo $form_row;?>"  style="display:none;">
			  <input type="hidden" name="nurse3bform[<?php echo $form_row; ?>][child_nurse3b_id]" value="<?php echo $nurse3bform['child_nurse3b_id']; ?>" />
				<div style="float:left;display:inline-block;vertical-align:top;width:25%;">
				  <table class="list">
					<thead>
					  <tr class="filter">
						<td>項目</td>
						<td></td>
					</tr>
					</thead>
					<tbody>
					  <tr>
						<td>1. T 體溫/℃</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk1]" value="<?php echo $nurse3bform['chk1']; ?>" size="3" /></td>
					</tr>
					  <tr>
						<td>2. P 脈搏/每分鐘</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk2]" value="<?php echo $nurse3bform['chk2']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>3. R 呼吸/每分鐘</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk3]" value="<?php echo $nurse3bform['chk3']; ?>" size="3" /></td>
					</tr>
					  <tr>
						<td>4. 親餵時間：分鐘</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk4]" value="<?php echo $nurse3bform['chk4']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>5. 瓶餵食量：CC</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk5]" value="<?php echo $nurse3bform['chk5']; ?>" size="3" disabled="disabled"/></td>
					</tr>
					  <tr>
						<td>6. 瓶餵配方奶量：CC</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk6]" value="<?php echo $nurse3bform['chk6']; ?>" onkeyup="countTotal(<?php echo $form_row;?>);" size="3" /></td>
					  </tr>
					  <tr>
						<td>７. 瓶餵母奶量：CC</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk7]" value="<?php echo $nurse3bform['chk7']; ?>" onkeyup="countTotal(<?php echo $form_row;?>);" size="3" /></td>
					</tr>
					  <tr>
						<td>8. 母奶點班庫存量：CC</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk8]" value="<?php echo $nurse3bform['chk8']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>9. 母奶交班庫存量：CC</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk9]" value="<?php echo $nurse3bform['chk9']; ?>" size="3" /></td>
					</tr>
					  <tr>
						<td>10. 體重：公克</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk10]" value="<?php echo $nurse3bform['chk10']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>11. 小便次數</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk11]" value="<?php echo $nurse3bform['chk11']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>12. 大便次數</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk12]" value="<?php echo $nurse3bform['chk12']; ?>" size="3" /></td>
					</tr>
					  <tr>
						<td>13. 黃疸值：mg/dL</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk13]" value="<?php echo $nurse3bform['chk13']; ?>" size="3" /></td>
					  </tr>
					  <tr>
						<td>14. 母嬰同室時間：分鐘</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk14]" value="<?php echo $nurse3bform['chk14']; ?>" size="3" /></td>
					</tr>
					<tr>
						<td colspan="2">備註：<input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk15]" value="<?php echo $nurse3bform['chk15']; ?>" size="18" /></td>
					</tr>
					</tbody>
				  </table>
				</div>
				<div style="float:right;display:inline-block;vertical-align:top;min-width:72%">
				  <table class="form list">
					<thead>
					<tr class="filter">
						<td width="50%">母奶餵食紀錄：CC</td>
						<td width="50%">配方奶餵食紀錄：CC</td>
					</tr>
					</thead>
					<tr>
						<td class="center"><input type="text" name="mommilk" value="" size="5" />&nbsp;<a id="button-mommilk" class="button" onclick="addMommilk(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>);">母奶紀錄</a></td>
						<td class="center"><input type="text" name="bottlemilk" value="" size="5" />&nbsp;<a id="button-bottlemilk" class="button" onclick="addBottlemilk(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>);">配方奶紀錄</a></td>
					</tr>
					<thead>
					<tr class="filter">
						<td colspan="2">寶寶出入紀錄</td>
					</tr>
					</thead>
					<tr>
						<td class="center" colspan="2" style="width:100%;">陪同者：<select name="babymovewith"><option value=""></option><option value="母">母</option><option value="父">父</option><option value="父母">父母</option><option value="親友">親友</option><option value="長輩">長輩</option></select>&nbsp;&nbsp;<a id="button-hospital" class="button" onclick="addBabyMove(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>, 'hospital');">外出就醫</a>&nbsp;<a id="button-momroom" class="button" onclick="addBabyMove(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>,'momroom');">到媽媽房</a>&nbsp;<a id="button-babyroom" class="button" onclick="addBabyMove(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>,'babyroom');">回嬰兒室</a></td>
					</tr>
					<thead>
					<tr class="filter">
						<td colspan="2">大小便、洗澡紀錄</td>
					</tr>
					</thead>
					<tr>
						<td class="center" colspan="2" style="width:100%;"><a id="button-stool" class="button" onclick="addStool(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>);">大便紀錄</a>&nbsp;<a id="button-urine" class="button" onclick="addUrine(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>);">小便紀錄</a>&nbsp;<a id="button-wash" class="button" onclick="addWash(<?php echo $nurse3bform['child_nurse3b_id'];?>,<?php echo $form_row;?>);">洗澡紀錄</a></td>
					</tr>
				  </table>
				  <div id="nurse3bio"></div>
				</div>
			</div>
			
			<div id="tab-nurse3b-record-<?php echo $form_row;?>"  style="display:none;">
			  <table class="form list">
				  <tr>
					<td width="15%">項目一</td>
					<td width="35%">大便性質：
					<input type="radio" value="正常" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="正常")? "checked='checked'":""; ?>/>正常
					<input type="radio" value="硬便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="硬便")? "checked='checked'":""; ?>/>硬便
					<input type="radio" value="黃糊便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="黃糊便")? "checked='checked'":""; ?>/>黃糊便
					<input type="radio" value="墨綠便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="墨綠便")? "checked='checked'":""; ?>/>墨綠便
					<input type="radio" value="水便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="水便")? "checked='checked'":""; ?>/>水便
					<input type="radio" value="白色便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="白色便")? "checked='checked'":""; ?>/>白色便
					<input type="radio" value="紅色便" name="nurse3bform[<?php echo $form_row; ?>][chk16]" <?php echo ($nurse3bform['chk16']=="紅色便")? "checked='checked'":""; ?>/>紅色便
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk16supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk16supplement']; ?></textarea></td>
					<td width="15%">項目二</td>
					<td width="35%">臍帶脫落：
					<input type="radio" value="已脫落" name="nurse3bform[<?php echo $form_row; ?>][chk17]" <?php echo ($nurse3bform['chk17']=="已脫落")? "checked='checked'":""; ?>/>已脫落
					<input type="radio" value="未脫落" name="nurse3bform[<?php echo $form_row; ?>][chk17]" <?php echo ($nurse3bform['chk17']=="未脫落")? "checked='checked'":""; ?>/>未脫落
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk17supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk17supplement']; ?></textarea></td>
				 </tr>		
				  <tr>
					<td>項目三</td>
					<?php $c18 = (!empty($nurse3bform['chk18']))? unserialize($nurse3bform['chk18']) : array(); ?>
					<td>於媽媽房內
					親餵<input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk18][a]" value="<?php echo (!empty($c18)) ? $c18['a'] : "" ; ?>" size="5"/>分鐘，
					更換尿布<input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk18][b]" value="<?php echo (!empty($c18)) ? $c18['b'] : ""; ?>" size="5"/>次，
					有大小便<input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk18][c]" value="<?php echo (!empty($c18)) ? $c18['c'] : ""; ?>" size="5"/>次
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk18supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk18supplement']; ?></textarea></td>
					<td>項目四</td>
					<td><input type="checkbox" value="寶寶小便顏色異常，密切注意觀察中" name="nurse3bform[<?php echo $form_row; ?>][chk19]" <?php echo ($nurse3bform['chk19']=="寶寶小便顏色異常，密切注意觀察中")? "checked='checked'":""; ?>/>寶寶小便顏色異常，密切注意觀察中
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk19supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk19supplement']; ?></textarea></td>
				</tr>
				  <tr>
					<td>項目五</td>
					<td><input type="checkbox" value="寶寶糞便為水便，密切注意觀察中" name="nurse3bform[<?php echo $form_row; ?>][chk20]" <?php echo ($nurse3bform['chk20']=="寶寶糞便為水便，密切注意觀察中")? "checked='checked'":""; ?>/>寶寶糞便為水便，密切注意觀察中
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk20supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk20supplement']; ?></textarea></td>
					<td>項目六</td>
					<td><input type="checkbox" value="寶寶哭鬧中，給予安撫" name="nurse3bform[<?php echo $form_row; ?>][chk21]" <?php echo ($nurse3bform['chk21']=="寶寶哭鬧中，給予安撫")? "checked='checked'":""; ?>/>寶寶哭鬧中，給予安撫
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk21supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk21supplement']; ?></textarea></td>
				</tr>
				  <tr>
					<td>項目七</td>
					<td><input type="checkbox" value="寶寶紅臀，曝臀中，並密切注意呼吸狀態" name="nurse3bform[<?php echo $form_row; ?>][chk22]" <?php echo ($nurse3bform['chk22']=="寶寶紅臀，曝臀中，並密切注意呼吸狀態")? "checked='checked'":""; ?>/>寶寶紅臀，曝臀中，並密切注意呼吸狀態
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk22supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk22supplement']; ?></textarea></td>
					<td>項目八</td>
					<td>母嬰同室時間為 <input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk23]" value="<?php echo $nurse3bform['chk23']; ?>" size="5" /> 小時
					<br /><br /><textarea name="nurse3bform[<?php echo $form_row; ?>][chk23supplement]" cols="65" rows="3"><?php echo $nurse3bform['chk23supplement']; ?></textarea></td>
				</tr>
				  <tr>
					<td>補充文字</td>
					<td><textarea name="nurse3bform[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $nurse3bform['supplement']; ?></textarea></td>
					<td></td>
					<td></td>
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
			<table class="form list">
				<tbody>
					<tr><td width="33%">產婦姓名：<?php echo $customer_name; ?></td><td width="33%">嬰兒姓名：<?php echo $name; ?></td><td width="33%">父親姓名：<?php echo $spouse_name; ?></td></tr>
					<tr><td width="33%">房號：<?php echo $customer_firstroom; ?></td>
					<td colspan="2" width="66%">
					<?php foreach ($customer_transfers as $transfer) { ?>
						轉床紀錄：<?php echo $transfer['date_added']; ?>&nbsp;轉為：<?php echo $transfer['customer_room_name']; ?><br />
					<?php } ?>
					</td></tr>
					<tr><td width="33%">嬰兒出生日期：<?php echo $birthdate; ?></td><td width="33%">產婦入住日期：<?php echo $date_added; ?></td><td width="33%">預定退住日期：<?php echo $date_leave; ?></td></tr>
					<tr><td width="33%">生產方式：<?php echo $childbirth_method; ?></td><td width="66%" colspan="2">生產醫院：<?php echo $childbirth_hospital; ?></td></tr>
					<tr><td width="33%">週數：<?php echo $pregnancy_weeks; ?>週<br />胎兒產胎次：G:<?php echo $child_count_g; ?>&nbsp;&nbsp;P:<?php echo $child_count_p; ?></td><td width="66%" colspan="2">生產醫師：<?php echo $childbirth_doctor; ?><br />Apgar：<?php echo $apgar_score_1; ?> (1min) --> <?php echo $apgar_score_5;?> (5min)</</td></tr>
					<tr><td colspan="3">嬰兒出生時體重：<?php echo $birthweight; ?> 公克 &nbsp;頭圍：<?php echo $birthhead; ?> 公分 &nbsp;身長：<?php echo $birthlength; ?> 公分，入住時體重：<?php echo $inweight; ?> 公克</td></tr>
					<tr><td colspan="3">乙型鏈球菌檢查：<?php echo $b_streptococcus_check; ?></td></tr>
				</tdoby>
			</table>
        </div>
      
    </div>

  </div>
</div>

<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#vtabs a').tabs();
$('.backlist').hide();
$('#vtabs .scrolldiv').mCustomScrollbar();
//--></script> 
<script type="text/javascript"><!--
function delNurse3b(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=nurse/nurse3b/delete&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
		/*
		$('.backlist').trigger('click'); 
		$('#nurse3bform-' + row).remove(); 
		$('#tab-nurse3bform-' + row).remove();
		*/
	}
}
//--></script>
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addNurse3b(date) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
	html  = '<div id="tab-nurse3bform-' + form_row + '" class="vtabs-content">';
	html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
	html += '	    <div class="inner-heading">';
	html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_nurse3bform; ?></h1>';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>	';
	html += '  <input type="hidden" name="nurse3bform[' + form_row + '][child_nurse3b_id]" value="" />';
	html += '			<table class="form list">';
	html += '				  <tr>';
	html += '					<td width="15%">日期與班別</td>';
	html += '					<td width="35%"><input type="text" name="nurse3bform[' + form_row + '][date_added]" class="date" value="'+ date +'" size="12" />';

<?php
	$nowhr = date('H');
	if ($nowhr >= 0 AND $nowhr <= 7) {
		$arra = "大夜";
	} elseif ($nowhr >= 8 AND $nowhr <= 15) {
		$arra = "白班";
	} elseif ($nowhr >= 16 AND $nowhr <= 23) {
		$arra = "小夜";
	}
?>
	
	html += '					<select name="nurse3bform[' + form_row + '][arrangement]">';
	html += '						<option value=""></option>';
	html += '						<option value="白班" <?php echo ($arra=='白班')? "selected=\"selected\"" : ""; ?>>白班</option>';
	html += '						<option value="小夜" <?php echo ($arra=='小夜')? "selected=\"selected\"" : ""; ?>>小夜</option>';
	html += '						<option value="大夜" <?php echo ($arra=='大夜')? "selected=\"selected\"" : ""; ?>>大夜</option>';
	html += '					</select>';
	html += '					</td>';
	html += '					<td width="15%">護理人員</td>';
	html += '					<td width="35%"><select name="nurse3bform[' + form_row + '][nurse_id]">';
<?php foreach ($nurses as $nurse) { ?>
<?php if ($nurse['user_id'] == $logged_id) { ?>
    html += '                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>';
<?php } else { ?>
	html += '                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>';
<?php } ?>
<?php } ?>
	html += '					  </select></td>';
	html += '				  </tr>';
	html += '			</table>';
	html += '			';
	html += '			<div id="tabs2-'+ form_row +'" class="htabs"><a href="#tab-nurse3b-io-'+ form_row +'">I/O 紀錄單</a><a href="#tab-nurse3b-record-'+ form_row +'">資料紀錄單</a></div>';
	html += '		';
	html += '			<div id="tab-nurse3b-io-'+ form_row +'">';
	html += '			  <input type="hidden" name="nurse3bform[' + form_row + '][child_nurse3b_id]" value="" />';
	html += '				<div style="float:left;display:inline-block;vertical-align:top;width:25%;">';
	html += '				  <table class="list">';
	html += '					<thead>';
	html += '					  <tr class="filter">';
	html += '						<td>項目</td>';
	html += '						<td></td>';
	html += '					</tr>';
	html += '					</thead>';
	html += '					<tbody>';
	html += '					  <tr>';
	html += '						<td>1. T 體溫/℃</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk1]" value="" size="3" /></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>2. P 脈搏/每分鐘</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk2]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>3. R 呼吸/每分鐘</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk3]" value="" size="3" /></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>4. 親餵時間：分鐘</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk4]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>5. 瓶餵食量：CC</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk5]" value="" size="3" disabled="disabled"/></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>6. 瓶餵配方奶量：CC</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk6]" value="" size="3" onkeyup="countTotal(' + form_row + ');"/></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>７. 瓶餵母奶量：CC</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk7]" value="" size="3" onkeyup="countTotal(' + form_row + ');"/></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>8. 母奶點班庫存量：CC</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk8]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>9. 母奶交班庫存量：CC</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk9]" value="" size="3" /></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>10. 體重：公克</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk10]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>11. 小便次數</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk11]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>12. 大便次數</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk12]" value="" size="3" /></td>';
	html += '					</tr>';
	html += '					  <tr>';
	html += '						<td>13. 黃疸值：mg/dL</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk13]" value="" size="3" /></td>';
	html += '					  </tr>';
	html += '					  <tr>';
	html += '						<td>14. 母嬰同室時間：分鐘</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk14]" value="" size="3" /></td>';
	html += '					</tr>';
	html += '					<tr>';
	html += '						<td colspan="2">備註：<input type="text" name="nurse3bform[' + form_row + '][chk15]" value="" size="18" /></td>';
	html += '					</tr>';
	html += '					</tbody>';
	html += '				  </table>';
	html += '				</div>';
	html += '				<div style="float:right;display:inline-block;vertical-align:top;min-width:72%">';
	html += '				  <table class="form list">';
	html += '					<thead>';
	html += '					<tr class="filter">';
	html += '						<td width="50%">母奶餵食紀錄：CC</td>';
	html += '						<td width="50%">配方奶餵食紀錄：CC</td>';
	html += '					</tr>';
	html += '					</thead>';
	html += '					<tr>';
	html += '						<td class="center"><input type="text" name="mommilk" value="" size="5" />&nbsp;<a id="button-mommilk" class="button" onclick="addMommilk(\'\',' + form_row + ');">母奶紀錄</a></td>';
	html += '						<td class="center"><input type="text" name="bottlemilk" value="" size="5" />&nbsp;<a id="button-bottlemilk" class="button" onclick="addBottlemilk(\'\',' + form_row + ');">配方奶紀錄</a></td>';
	html += '					</tr>';
	html += '					<thead>';
	html += '					<tr class="filter">';
	html += '						<td colspan="2">寶寶出入紀錄</td>';
	html += '					</tr>';
	html += '					</thead>';
	html += '					<tr>';
	html += '						<td class="center" colspan="2"  style="width:100%;">陪同者：<select name="babymovewith"><option value=""></option><option value="母">母</option><option value="父">父</option><option value="父母">父母</option><option value="親友">親友</option><option value="長輩">長輩</option></select>&nbsp;&nbsp;<a id="button-hospital" class="button" onclick="addBabyMove(\'\',' + form_row + ', \'hospital\');">外出就醫</a>&nbsp;<a id="button-momroom" class="button" onclick="addBabyMove(\'\',' + form_row + ',\'momroom\');">到媽媽房</a>&nbsp;<a id="button-babyroom" class="button" onclick="addBabyMove(\'\',' + form_row + ',\'babyroom\');">回嬰兒室</a></td>';
	html += '					</tr>';
	html += '					<thead>';
	html += '					<tr class="filter">';
	html += '						<td colspan="2">大小便、洗澡紀錄</td>';
	html += '					</tr>';
	html += '					</thead>';
	html += '					<tr>';
	html += '						<td class="center" colspan="2"  style="width:100%;"><a id="button-stool" class="button" onclick="addStool(\'\',' + form_row + ');">大便紀錄</a>&nbsp;<a id="button-urine" class="button" onclick="addUrine(\'\',' + form_row + ');">小便紀錄</a>&nbsp;<a id="button-wash" class="button" onclick="addWash(\'\',' + form_row + ');">洗澡紀錄</a></td>';
	html += '					</tr>';
	html += '				  </table>';
	html += '				  <div id="nurse3bio"></div>';
	html += '				</div>';
	html += '			</div>';
	html += '			';
	html += '			<div id="tab-nurse3b-record-'+ form_row +'">';
	html += '			  <table class="form list">';
	html += '				  <tr>';
	html += '					<td width="15%">項目一</td>';
	html += '					<td width="35%">大便性質：';
	html += '					<input type="radio" value="正常" name="nurse3bform[' + form_row + '][chk16]"/>正常';
	html += '					<input type="radio" value="硬便" name="nurse3bform[' + form_row + '][chk16]"/>硬便';
	html += '					<input type="radio" value="黃糊便" name="nurse3bform[' + form_row + '][chk16]"/>黃糊便';
	html += '					<input type="radio" value="墨綠便" name="nurse3bform[' + form_row + '][chk16]"/>墨綠便';
	html += '					<input type="radio" value="水便" name="nurse3bform[' + form_row + '][chk16]" />水便';
	html += '					<input type="radio" value="白色便" name="nurse3bform[' + form_row + '][chk16]"/>白色便';
	html += '					<input type="radio" value="紅色便" name="nurse3bform[' + form_row + '][chk16]"/>紅色便';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk16supplement]" cols="65" rows="3"></textarea></td>';
	html += '					<td width="15%">項目二</td>';
	html += '					<td width="35%">臍帶脫落：';
	html += '					<input type="radio" value="已脫落" name="nurse3bform[' + form_row + '][chk17]"/>已脫落';
	html += '					<input type="radio" value="未脫落" name="nurse3bform[' + form_row + '][chk17]" />未脫落';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk17supplement]" cols="65" rows="3"></textarea></td>';
	html += '				 </tr>		';
	html += '				  <tr>';
	html += '					<td>項目三</td>';
	html += '					<td>於媽媽房內';
	html += '					親餵<input type="text" name="nurse3bform[' + form_row + '][chk18][a]" value="" size="5"/>分鐘，';
	html += '					更換尿布<input type="text" name="nurse3bform[' + form_row + '][chk18][b]" value="" size="5"/>次，';
	html += '					有大小便<input type="text" name="nurse3bform[' + form_row + '][chk18][c]" value="" size="5"/>次';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk18supplement]" cols="65" rows="3"></textarea></td>';
	html += '					<td>項目四</td>';
	html += '					<td><input type="checkbox" value="寶寶小便顏色異常，密切注意觀察中" name="nurse3bform[' + form_row + '][chk19]" />寶寶小便顏色異常，密切注意觀察中';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk19supplement]" cols="65" rows="3"></textarea></td>';
	html += '				</tr>';
	html += '				  <tr>';
	html += '					<td>項目五</td>';
	html += '					<td><input type="checkbox" value="寶寶糞便為水便，密切注意觀察中" name="nurse3bform[' + form_row + '][chk20]" />寶寶糞便為水便，密切注意觀察中';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk20supplement]" cols="65" rows="3"></textarea></td>';
	html += '					<td>項目六</td>';
	html += '					<td><input type="checkbox" value="寶寶哭鬧中，給予安撫" name="nurse3bform[' + form_row + '][chk21]" />寶寶哭鬧中，給予安撫';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk21supplement]" cols="65" rows="3"></textarea></td>';
	html += '				</tr>';
	html += '				  <tr>';
	html += '					<td>項目七</td>';
	html += '					<td><input type="checkbox" value="寶寶紅臀，曝臀中，並密切注意呼吸狀態" name="nurse3bform[' + form_row + '][chk22]" />寶寶紅臀，曝臀中，並密切注意呼吸狀態';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk22supplement]" cols="65" rows="3"></textarea></td>';
	html += '					<td>項目八</td>';
	html += '					<td>母嬰同室時間為 <input type="text" name="nurse3bform[' + form_row + '][chk23]" value="" size="5" /> 小時';
	html += '					<br /><br /><textarea name="nurse3bform[' + form_row + '][chk23supplement]" cols="65" rows="3"></textarea></td>';
	html += '				</tr>';
	html += '				  <tr>';
	html += '					<td>補充文字</td>';
	html += '					<td><textarea name="nurse3bform[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
	html += '					<td></td>';
	html += '					<td></td>';
	html += '				  </tr>';
	html += '			  </table>';
	html += '			</div>';
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';	
	html += '	</div>';	
	
	$('#tab-nurse3b').append(html);
	$('.backlist').show();
	
	$('#nurse3b-add').before('<a href="#tab-nurse3bform-' + form_row + '" id="nurse3bform-' + form_row + '"><img src="view/image/new.png" /> <?php echo $tab_nurse3bform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#nurse3bform-' + form_row + '\').remove(); $(\'#tab-nurse3bform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	$('#tab-nurse3bform-' + form_row).find('.htabs a').tabs();
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('.time').timepicker({timeFormat: 'hh:mm'});

	$('#nurse3bform-' + form_row).trigger('click');
	
	form_row++;
}
//--></script> 
<script type='text/javascript'><!--
function savenew(form_row) {
	$('.success, .warning').remove();
	$('.content').hide();
	$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 保存中...</h2></center></div>');
	$('#form-'+form_row).submit();
}
//--></script> 
<script type='text/javascript'><!--
	$(document).ready(function() {	
		$('.backlist').click(function() {
			$('#vtabs a:first').trigger('click');
			$('.backlist').hide();
			return false;
		});
		$('[id^=nurse3bform]').click(function() {
			$('.backlist').show();
		});
		$('form').submit(function() {
			$('.success, .warning').remove();
			$('.content').hide();
			$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 保存中...</h2></center></div>');
		});
	});
//--></script> 
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	dateFormat: 'yy-mm-dd'
});
$('.time').timepicker({timeFormat: 'hh:mm'});
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
foreach ($nurse3bforms as $nurse3bform) { 
		$time = strtotime($nurse3bform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_nurse3bform ?>[<?php echo $nurse3bform['arrangement'] ?>]',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#nurse3bform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($nurse3bforms)) { ?>,<?php } ?>
				
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
				addNurse3b(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-nurse3bform-1]").live("click", function () {
			$('#nurse3bform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<script type="text/javascript"><!--
<?php 
$iodivrow = 1;
foreach ($nurse3bforms as $nurse3bform) { 
$nowhr = date('H');
if ($nowhr >= 0 AND $nowhr <= 7) {
	$arra = "大夜";
} elseif ($nowhr >= 8 AND $nowhr <= 15) {
	$arra = "白班";
} elseif ($nowhr >= 16 AND $nowhr <= 23) {
	$arra = "小夜";
}
$date_assign = (isset($nurse3bform['date_added']))? $nurse3bform['date_added'] : date('Y-m-d');
$arrangement_assign = (isset($nurse3bform['arrangement'])) ? $nurse3bform['arrangement'] : $arra;
?>

$('#tab-nurse3bform-<?php echo $iodivrow; ?> #tabs2-<?php echo $iodivrow; ?> a').tabs(); 
$('#tab-nurse3bform-<?php echo $iodivrow; ?>').find('#nurse3bio').load('index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?><?php echo (isset($nurse3bform['child_nurse3b_id'])) ? "&child_nurse3b_id=".$nurse3bform['child_nurse3b_id'] : 0; ?>&customer_child_id=<?php echo $customer_child_id; ?>&date=<?php echo $date_assign; ?>&arrangement=<?php echo $arrangement_assign; ?>&tabid=<?php echo $iodivrow; ?>');

<?php 
$iodivrow ++;
} 
?>
//--></script> 
<script type="text/javascript"><!--
function addMommilk(nurse3bid,tabid) {
	var o = ($('#tab-nurse3bform-'+ tabid).find('input[name*=chk7]').val()) ? $('#tab-nurse3bform-'+ tabid).find('input[name*=chk7]').val() : 0;
	var n = ($('#tab-nurse3bform-'+ tabid + ' input[name=\'mommilk\']').val()) ? $('#tab-nurse3bform-'+ tabid + ' input[name=\'mommilk\']').val() : 0;
	$('#tab-nurse3bform-'+ tabid).find('input[name*=chk7]').val(parseInt(o) + parseInt(n));
	countTotal(tabid);
	
	if (n) {
		$.ajax({
			url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
			type: 'post',
			dataType: 'html',
			data: 'mommilk=' + encodeURIComponent($('#tab-nurse3bform-'+ tabid + ' input[name=\'mommilk\']').val()) + '&addmommilk=true',
			beforeSend: function() {
				$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
				$('#tab-nurse3bform-'+ tabid + ' #button-mommilk').attr('disabled', true);
				$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
			},
			complete: function() {
				$('#tab-nurse3bform-'+ tabid + ' #button-mommilk').attr('disabled', false);
				$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
			},
			success: function(html) {
				$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
				$('#tab-nurse3bform-' + tabid +' input[name=\'mommilk\']').val('');
			}
		});
	}
}
function addBottlemilk(nurse3bid,tabid) {
	var o = ($('#tab-nurse3bform-'+ tabid).find('input[name*=chk6]').val()) ? $('#tab-nurse3bform-'+ tabid).find('input[name*=chk6]').val() : 0;
	var n = ($('#tab-nurse3bform-'+ tabid + ' input[name=\'bottlemilk\']').val()) ? $('#tab-nurse3bform-'+ tabid + ' input[name=\'bottlemilk\']').val() : 0;
	$('#tab-nurse3bform-'+ tabid).find('input[name*=chk6]').val(parseInt(o) + parseInt(n));
	countTotal(tabid);

	if (n) {
		$.ajax({
			url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
			type: 'post',
			dataType: 'html',
			data: 'bottlemilk=' + encodeURIComponent($('#tab-nurse3bform-'+ tabid + ' input[name=\'bottlemilk\']').val()) + '&addbottlemilk=true',
			beforeSend: function() {
				$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
				$('#tab-nurse3bform-'+ tabid + ' #button-bottlemilk').attr('disabled', true);
				$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
			},
			complete: function() {
				$('#tab-nurse3bform-'+ tabid + ' #button-bottlemilk').attr('disabled', false);
				$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
			},
			success: function(html) {
				$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
				$('#tab-nurse3bform-' + tabid +' input[name=\'bottlemilk\']').val('');
			}
		});
	}
}
function addBabyMove(nurse3bid,tabid,moveto) {
	$.ajax({
		url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
		type: 'post',
		dataType: 'html',
		data: 'babymovewith=' + encodeURIComponent($('#tab-nurse3bform-'+ tabid + ' select[name=\'babymovewith\']').val()) + '&addbabymove=true&babymoveto=' + moveto,
		beforeSend: function() {
			$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
			$('#tab-nurse3bform-'+ tabid + ' #button-'+ moveto).attr('disabled', true);
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#tab-nurse3bform-'+ tabid + ' #button-'+ moveto).attr('disabled', false);
			$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
		},
		success: function(html) {
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
			$('#tab-nurse3bform-' + tabid +' select[name=\'babymovewith\']').val('');
		}
	});
}
function addStool(nurse3bid,tabid) {
	var o = ($('#tab-nurse3bform-'+ tabid).find('input[name*=chk12]').val()) ? $('#tab-nurse3bform-'+ tabid).find('input[name*=chk12]').val() : 0;
	$('#tab-nurse3bform-'+ tabid).find('input[name*=chk12]').val(parseInt(o) + 1);

	$.ajax({
		url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
		type: 'post',
		dataType: 'html',
		data: 'stool=' + encodeURIComponent('大便'),
		beforeSend: function() {
			$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
			$('#tab-nurse3bform-'+ tabid + ' #button-stool').attr('disabled', true);
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#tab-nurse3bform-'+ tabid + ' #button-stool').attr('disabled', false);
			$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
		},
		success: function(html) {
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
		}
	});
}
function addUrine(nurse3bid,tabid) {
	var o = ($('#tab-nurse3bform-'+ tabid).find('input[name*=chk11]').val()) ? $('#tab-nurse3bform-'+ tabid).find('input[name*=chk11]').val() : 0;
	$('#tab-nurse3bform-'+ tabid).find('input[name*=chk11]').val(parseInt(o) + 1);
	
	$.ajax({
		url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
		type: 'post',
		dataType: 'html',
		data: 'urine=' + encodeURIComponent('小便'),
		beforeSend: function() {
			$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
			$('#tab-nurse3bform-'+ tabid + ' #button-urine').attr('disabled', true);
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#tab-nurse3bform-'+ tabid + ' #button-urine').attr('disabled', false);
			$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
		},
		success: function(html) {
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
		}
	});
}
function addWash(nurse3bid,tabid) {
	$.ajax({
		url: 'index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
		type: 'post',
		dataType: 'html',
		data: 'wash=' + encodeURIComponent('洗澡'),
		beforeSend: function() {
			$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
			$('#tab-nurse3bform-'+ tabid + ' #button-wash').attr('disabled', true);
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#tab-nurse3bform-'+ tabid + ' #button-wash').attr('disabled', false);
			$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
		},
		success: function(html) {
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
		}
	});
}
function removeIO(ioid,nurse3bid,tabid) {
	$.ajax({
		url: 'index.php?route=nurse/nurse3b/delio&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&child_nurse3b_io_id='+ ioid +'&child_nurse3b_id='+ nurse3bid + '&tabid=' + tabid+ '',
		type: 'post',
		dataType: 'html',
		beforeSend: function() {
			$('#tab-nurse3bform-'+ tabid).find('.success, .warning').remove();
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#tab-nurse3bform-' + tabid+ ' .attention').remove();
		},
		success: function(html) {
			$('#tab-nurse3bform-' + tabid+ ' #nurse3bio').html(html);
		}
	});
}
function deletestoolurine(tabid,field,num) {
	var o = ($('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val()) ? $('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val() : 0;
	var n = (parseInt(o) - 1 < 0) ? 0 : parseInt(o) - 1;
	$('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val(n);
}
function deletemilk(tabid,field,num) {
	var o = ($('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val()) ? $('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val() : 0;
	var n = (parseInt(o) - parseInt(num) < 0) ? 0 : parseInt(o) - parseInt(num);
	$('#tab-nurse3bform-'+ tabid+' input[name*=' + field + ']').val(n);
	
	countTotal(tabid);
}
function countTotal(tabid) {
	var c6v = ($('#tab-nurse3bform-'+ tabid+' input[name*=chk6]').val()) ? $('#tab-nurse3bform-'+ tabid+' input[name*=chk6]').val() : 0;
	var c7v = ($('#tab-nurse3bform-'+ tabid+' input[name*=chk7]').val()) ? $('#tab-nurse3bform-'+ tabid+' input[name*=chk7]').val() : 0;
	if (c6v && c7v) {
		$('#tab-nurse3bform-'+ tabid+' input[name*=chk5]').val(parseInt(c6v)+parseInt(c7v));
	}
}
//--></script>  
<?php echo $footer; ?>