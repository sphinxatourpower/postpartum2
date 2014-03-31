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
			
			<input type="hidden" name="nurse3bform[<?php echo $form_row; ?>][child_nurse3b_id]" value="<?php echo $nurse3bform['child_nurse3b_id']; ?>" />
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
				  <tr>
					<td width="15%">體溫</td>
					<td width="35%"><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk1]" value="<?php echo $nurse3bform['chk1']; ?>" size="5" /> ℃</td>
					<td width="15%">體重</td>
					<td width="35%"><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk10]" value="<?php echo $nurse3bform['chk10']; ?>" size="5" /> 公克</td>
				  </tr>
				  <tr>
					<td width="15%">黃疸值</td>
					<td width="35%"><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk13]" value="<?php echo $nurse3bform['chk13']; ?>" size="5" /> mg/dL</td>
					<td width="15%">嬰兒護理</td>
					<?php $c23 = (is_serialized($nurse3bform['chk23supplement']))? unserialize($nurse3bform['chk23supplement']) : array(); ?>
					<td width="35%"><div class="mybox">
						  <div class="odd"><input type="checkbox"  value="新生兒沐浴" name="nurse3bform[<?php echo $form_row; ?>][chk23supplement][]"  <?php echo (!empty($c23) && in_array("新生兒沐浴", $c23 ))? "checked":""; ?>/> 新生兒沐浴</div>
						  <div class="even"><input type="checkbox"  value="臍帶護理" name="nurse3bform[<?php echo $form_row; ?>][chk23supplement][]"  <?php echo (!empty($c23) && in_array("臍帶護理", $c23 ))? "checked":""; ?>/> 臍帶護理</div>
					</div></td>
				  </tr>
				  <tr>
						<td>小便累積次數</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk11]" value="<?php echo $nurse3bform['chk11']; ?>" size="3" /> 次</td>
						<td>大便累積次數</td>
						<td><input type="text" name="nurse3bform[<?php echo $form_row; ?>][chk12]" value="<?php echo $nurse3bform['chk12']; ?>" size="3" /> 次</td>
				  </tr>
			</table>
			
			<table class="form list">
				 <tr>
				  <td class="center caption" width="150px">精神狀況</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk24]" value="佳" <?php echo ($nurse3bform['chk24']=="佳")? "checked=\"checked\"":""; ?> /> 佳</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk24]" value="可"  <?php echo ($nurse3bform['chk24']=="可")? "checked=\"checked\"":""; ?>/> 可</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk24]" value="差"  <?php echo ($nurse3bform['chk24']=="差")? "checked=\"checked\"":""; ?>/> 差</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption" width="150px">吸吮力</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk25]" value="佳" <?php echo ($nurse3bform['chk25']=="佳")? "checked=\"checked\"":""; ?> /> 佳</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk25]" value="可"  <?php echo ($nurse3bform['chk25']=="可")? "checked=\"checked\"":""; ?>/> 可</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk25]" value="差"  <?php echo ($nurse3bform['chk25']=="差")? "checked=\"checked\"":""; ?>/> 差</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption" width="150px">活動力</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk26]" value="佳" <?php echo ($nurse3bform['chk26']=="佳")? "checked=\"checked\"":""; ?> /> 佳</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk26]" value="可"  <?php echo ($nurse3bform['chk26']=="可")? "checked=\"checked\"":""; ?>/> 可</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk26]" value="差"  <?php echo ($nurse3bform['chk26']=="差")? "checked=\"checked\"":""; ?>/> 差</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption" width="150px">紅臀</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk22]" value="正常" <?php echo ($nurse3bform['chk22']=="正常")? "checked=\"checked\"":""; ?> /> 正常</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk22]" value="輕度"  <?php echo ($nurse3bform['chk22']=="輕度")? "checked=\"checked\"":""; ?>/> 輕度</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk22]" value="中度"  <?php echo ($nurse3bform['chk22']=="中度")? "checked=\"checked\"":""; ?>/> 中度</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk22]" value="重度"  <?php echo ($nurse3bform['chk22']=="重度")? "checked=\"checked\"":""; ?>/> 重度</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption" width="150px">膚色</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk20]" value="紅潤" <?php echo ($nurse3bform['chk20']=="紅潤")? "checked=\"checked\"":""; ?> /> 紅潤</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk20]" value="微黃"  <?php echo ($nurse3bform['chk20']=="微黃")? "checked=\"checked\"":""; ?>/> 微黃</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk20]" value="黃"  <?php echo ($nurse3bform['chk20']=="黃")? "checked=\"checked\"":""; ?>/> 黃</div>
				  </div></td>
				</tr>
				<tr>
					<td class="center caption">皮膚狀況</td>
					<?php $c20 = (is_serialized($nurse3bform['chk20supplement']))? unserialize($nurse3bform['chk20supplement']) : array(); ?>
					<td><div class="mybox">
						  <div class="odd"><input type="checkbox"  value="正常" name="nurse3bform[<?php echo $form_row; ?>][chk20supplement][]"  <?php echo (!empty($c20) && in_array("正常", $c20 ))? "checked":""; ?>/> 正常</div>
						  <div class="even"><input type="checkbox"  value="乾燥脫皮" name="nurse3bform[<?php echo $form_row; ?>][chk20supplement][]"  <?php echo (!empty($c20) && in_array("乾燥脫皮", $c20 ))? "checked":""; ?>/> 乾燥脫皮</div>
						  <div class="odd"><input type="checkbox"  value="紅疹" name="nurse3bform[<?php echo $form_row; ?>][chk20supplement][]"  <?php echo (!empty($c20) && in_array("紅疹", $c20 ))? "checked":""; ?>/> 紅疹</div>
					</div></td>
				</tr>
				 <tr>
				  <td class="center caption">小便狀況</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk21]" value="正常" <?php echo ($nurse3bform['chk21']=="正常")? "checked=\"checked\"":""; ?> /> 正常</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk21]" value="結晶尿"  <?php echo ($nurse3bform['chk21']=="結晶尿")? "checked=\"checked\"":""; ?>/> 結晶尿</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption">大便顏色</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk15]" value="黃" <?php echo ($nurse3bform['chk15']=="黃")? "checked=\"checked\"":""; ?> /> 黃</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk15]" value="黃綠"  <?php echo ($nurse3bform['chk15']=="黃綠")? "checked=\"checked\"":""; ?>/> 黃綠</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk15]" value="綠"  <?php echo ($nurse3bform['chk15']=="綠")? "checked=\"checked\"":""; ?>/> 綠</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption">大便性質</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk16]" value="糊便" <?php echo ($nurse3bform['chk16']=="糊便")? "checked=\"checked\"":""; ?> /> 糊便</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk16]" value="軟便"  <?php echo ($nurse3bform['chk16']=="軟便")? "checked=\"checked\"":""; ?>/> 軟便</div>
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk16]" value="水便"  <?php echo ($nurse3bform['chk16']=="水便")? "checked=\"checked\"":""; ?>/> 水便</div>
				  </div></td>
				</tr>
				 <tr>
				  <td class="center caption">肚臍狀況</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk17]" value="已掉" <?php echo ($nurse3bform['chk17']=="已掉")? "checked=\"checked\"":""; ?> /> 已掉</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk17]" value="未掉"  <?php echo ($nurse3bform['chk17']=="未掉")? "checked=\"checked\"":""; ?>/> 未掉</div>
				  </div></td>
				</tr>
				<tr>
					<td class="center caption">肚臍外觀</td>
					<?php $c18 = (is_serialized($nurse3bform['chk18']))? unserialize($nurse3bform['chk18']) : array(); ?>
					<td><div class="mybox">
						  <div class="odd"><input type="checkbox"  value="正常" name="nurse3bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("正常", $c18 ))? "checked":""; ?>/> 正常</div>
						  <div class="even"><input type="checkbox"  value="無滲血" name="nurse3bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("無滲血", $c18 ))? "checked":""; ?>/> 無滲血</div>
						  <div class="odd"><input type="checkbox"  value="有滲血" name="nurse3bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("有滲血", $c18 ))? "checked":""; ?>/> 有滲血</div>
						  <div class="even"><input type="checkbox"  value="有分泌物" name="nurse3bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("有分泌物", $c18 ))? "checked":""; ?>/> 有分泌物</div>
					</div></td>
				</tr>
				 <tr>
				  <td class="center caption">卡介苗</td>
				  <td><div class="mybox">
					<div class="odd"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk19]" value="未注射" <?php echo ($nurse3bform['chk19']=="未注射")? "checked=\"checked\"":""; ?> /> 未注射</div>
					<div class="even"><input type="radio" name="nurse3bform[<?php echo $form_row; ?>][chk19]" value="已注射"  <?php echo ($nurse3bform['chk19']=="已注射")? "checked=\"checked\"":""; ?>/> 已注射</div>
					<span id="chk19other">
					<?php $c19 = (is_serialized($nurse3bform['chk19supplement']))? unserialize($nurse3bform['chk19supplement']) : array(); ?>
						<div class="mybox">
							  <div class="odd"><input type="checkbox"  value="紅" name="nurse3bform[<?php echo $form_row; ?>][chk19supplement][]"  <?php echo (!empty($c19) && in_array("紅", $c19 ))? "checked":""; ?>/> 紅</div>
							  <div class="even"><input type="checkbox"  value="化膿" name="nurse3bform[<?php echo $form_row; ?>][chk19supplement][]"  <?php echo (!empty($c19) && in_array("化膿", $c19 ))? "checked":""; ?>/> 化膿</div>
							  <div class="odd"><input type="checkbox"  value="結痂" name="nurse3bform[<?php echo $form_row; ?>][chk19supplement][]"  <?php echo (!empty($c19) && in_array("結痂", $c19 ))? "checked":""; ?>/> 結痂</div>
						</div>
					</span>
				  </div></td>
				</tr>
				<tr>
					<td class="center caption">補充說明</td>
					<td><textarea name="nurse3bform[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $nurse3bform['supplement']; ?></textarea></td>
				</tr>
			</table>
			
			
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
	$('.mybox > div').on('click', function(event) { 
		if(event.target.type !== "checkbox" && event.target.type !== "radio") {
			if ($('input:checkbox', this).is(':checked')) {
				$('input:checkbox', this).attr('checked', false);
			} else {
				$('input:checkbox', this).attr('checked', true);
			}
			if ($('input:radio', this).is(':checked')) {
				$('input:radio', this).attr('checked', false);
			} else {
				$('input:radio', this).attr('checked', true);
			}
		}
		
			if ($("input[name$='[chk19]']:checked", this).val() == '已注射') {
				$(this).parent().parent().find('span#chk19other').show();
			} else {
				$(this).parent().parent().find('span#chk19other').hide();
			}
			$("input[name$='[chk19]']", this).on('click', function(){
				v = $(this).val();
				
				if (v == '已注射') {
					$(this).parent().parent().find('span#chk19other').show();
				} else {
					$(this).parent().parent().find('span#chk19other').hide();
				}
			});
		
	});
	
	
	$("div[id^='tab-nurse3bform']").each(function() {
			if ($(this).find("input[name$='[chk19]']:checked").val() == '已注射') {
				$(this).find('span#chk19other').show();
			} else {
				$(this).find('span#chk19other').hide();
			}
	});
//--></script> 		
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

	html += '			<input type="hidden" name="nurse3bform[' + form_row + '][child_nurse3b_id]" value="" />';
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
	html += '				  <tr>';
	html += '					<td width="15%">體溫</td>';
	html += '					<td width="35%"><input type="text" name="nurse3bform[' + form_row + '][chk1]" value="" size="5" /> ℃</td>';
	html += '					<td width="15%">體重</td>';
	html += '					<td width="35%"><input type="text" name="nurse3bform[' + form_row + '][chk10]" value="" size="5" /> 公克</td>';
	html += '				  </tr>';
	html += '				  <tr>';
	html += '					<td width="15%">黃疸值</td>';
	html += '					<td width="35%"><input type="text" name="nurse3bform[' + form_row + '][chk13]" value="" size="5" /> mg/dL</td>';
	html += '					<td width="15%">嬰兒護理</td>';
	html += '					<td width="35%"><div class="mybox">';
	html += '						  <div class="odd"><input type="checkbox"  value="新生兒沐浴" name="nurse3bform[' + form_row + '][chk23supplement][]" /> 新生兒沐浴</div>';
	html += '						  <div class="even"><input type="checkbox"  value="臍帶護理" name="nurse3bform[' + form_row + '][chk23supplement][]" /> 臍帶護理</div>';
	html += '					</div></td>';
	html += '				  </tr>';
	html += '				  <tr>';
	html += '						<td>小便累積次數</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk11]" value="" size="3" /> 次</td>';
	html += '						<td>大便累積次數</td>';
	html += '						<td><input type="text" name="nurse3bform[' + form_row + '][chk12]" value="" size="3" /> 次</td>';
	html += '				  </tr>';
	html += '			</table>';
	html += '			';
	html += '			<table class="form list">';
	html += '				 <tr>';
	html += '				  <td class="center caption" width="150px">精神狀況</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk24]" value="佳" /> 佳</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk24]" value="可" /> 可</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk24]" value="差" /> 差</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption" width="150px">吸吮力</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk25]" value="佳" /> 佳</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk25]" value="可" /> 可</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk25]" value="差" /> 差</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption" width="150px">活動力</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk26]" value="佳" /> 佳</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk26]" value="可" /> 可</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk26]" value="差" /> 差</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption" width="150px">紅臀</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk22]" value="正常" /> 正常</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk22]" value="輕度" /> 輕度</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk22]" value="中度" /> 中度</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk22]" value="重度" /> 重度</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption" width="150px">膚色</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk20]" value="紅潤" /> 紅潤</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk20]" value="微黃" /> 微黃</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk20]" value="黃" /> 黃</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				<tr>';
	html += '					<td class="center caption">皮膚狀況</td>';
	html += '					<td><div class="mybox">';
	html += '						  <div class="odd"><input type="checkbox"  value="正常" name="nurse3bform[' + form_row + '][chk20supplement][]" /> 正常</div>';
	html += '						  <div class="even"><input type="checkbox"  value="乾燥脫皮" name="nurse3bform[' + form_row + '][chk20supplement][]" /> 乾燥脫皮</div>';
	html += '						  <div class="odd"><input type="checkbox"  value="紅疹" name="nurse3bform[' + form_row + '][chk20supplement][]" /> 紅疹</div>';
	html += '					</div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption">小便狀況</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk21]" value="正常" /> 正常</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk21]" value="結晶尿" /> 結晶尿</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption">大便顏色</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk15]" value="黃" /> 黃</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk15]" value="黃綠" /> 黃綠</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk15]" value="綠" /> 綠</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption">大便性質</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk16]" value="糊便" /> 糊便</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk16]" value="軟便" /> 軟便</div>';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk16]" value="水便" /> 水便</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption">肚臍狀況</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk17]" value="已掉" /> 已掉</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk17]" value="未掉" /> 未掉</div>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				<tr>';
	html += '					<td class="center caption">肚臍外觀</td>';
	html += '					<td><div class="mybox">';
	html += '						  <div class="odd"><input type="checkbox"  value="正常" name="nurse3bform[' + form_row + '][chk18][]" /> 正常</div>';
	html += '						  <div class="even"><input type="checkbox"  value="無滲血" name="nurse3bform[' + form_row + '][chk18][]" /> 無滲血</div>';
	html += '						  <div class="odd"><input type="checkbox"  value="有滲血" name="nurse3bform[' + form_row + '][chk18][]" /> 有滲血</div>';
	html += '						  <div class="even"><input type="checkbox"  value="有分泌物" name="nurse3bform[' + form_row + '][chk18][]" /> 有分泌物</div>';
	html += '					</div></td>';
	html += '				</tr>';
	html += '				 <tr>';
	html += '				  <td class="center caption">卡介苗</td>';
	html += '				  <td><div class="mybox">';
	html += '					<div class="odd"><input type="radio" name="nurse3bform[' + form_row + '][chk19]" value="未注射" /> 未注射</div>';
	html += '					<div class="even"><input type="radio" name="nurse3bform[' + form_row + '][chk19]" value="已注射" /> 已注射</div>';
	html += '					<span id="chk19other">';
	html += '						<div class="mybox">';
	html += '							  <div class="odd"><input type="checkbox"  value="紅" name="nurse3bform[' + form_row + '][chk19supplement][]" /> 紅</div>';
	html += '							  <div class="even"><input type="checkbox"  value="化膿" name="nurse3bform[' + form_row + '][chk19supplement][]" /> 化膿</div>';
	html += '							  <div class="odd"><input type="checkbox"  value="結痂" name="nurse3bform[' + form_row + '][chk19supplement][]" /> 結痂</div>';
	html += '						</div>';
	html += '					</span>';
	html += '				  </div></td>';
	html += '				</tr>';
	html += '				<tr>';
	html += '					<td class="center caption">補充說明</td>';
	html += '					<td><textarea name="nurse3bform[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
	html += '				</tr>';
	html += '			</table>';	
	
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
	//$('#tab-nurse3bform-' + form_row).find('.htabs a').tabs();
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('.time').timepicker({timeFormat: 'hh:mm'});
	
	$('.mybox > div').on('click', function(event) { 
		if(event.target.type !== "checkbox" && event.target.type !== "radio") {
			if ($('input:checkbox', this).is(':checked')) {
				$('input:checkbox', this).attr('checked', false);
			} else {
				$('input:checkbox', this).attr('checked', true);
			}
			if ($('input:radio', this).is(':checked')) {
				$('input:radio', this).attr('checked', false);
			} else {
				$('input:radio', this).attr('checked', true);
			}
		}		
		
			if ($("input[name$='[chk19]']:checked", this).val() == '已注射') {
				$(this).parent().parent().find('span#chk19other').show();
			} else {
				$(this).parent().parent().find('span#chk19other').hide();
			}
			$("input[name$='[chk19]']", this).on('click', function(){
				v = $(this).val();
				
				if (v == '已注射') {
					$(this).parent().parent().find('span#chk19other').show();
				} else {
					$(this).parent().parent().find('span#chk19other').hide();
				}
			});
	});
	
	$('#tab-nurse3bform-' + form_row).find('span#chk19other').hide();
	if ($('#tab-nurse3bform-' + form_row).find("input[name$='[chk19]']:checked").val() == '已注射') {
		$('#tab-nurse3bform-' + form_row).find('span#chk19other').show();
	} else {
		$('#tab-nurse3bform-' + form_row).find('span#chk19other').hide();
	}

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

//$('#tab-nurse3bform-<?php echo $iodivrow; ?> #tabs2-<?php echo $iodivrow; ?> a').tabs(); 
//$('#tab-nurse3bform-<?php echo $iodivrow; ?>').find('#nurse3bio').load('index.php?route=nurse/nurse3b/io&token=<?php echo $token; ?><?php echo (isset($nurse3bform['child_nurse3b_id'])) ? "&child_nurse3b_id=".$nurse3bform['child_nurse3b_id'] : 0; ?>&customer_child_id=<?php echo $customer_child_id; ?>&date=<?php echo $date_assign; ?>&arrangement=<?php echo $arrangement_assign; ?>&tabid=<?php echo $iodivrow; ?>');

<?php 
$iodivrow ++;
} 
?>
//--></script> 
<script type="text/javascript"><!--
/*
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
*/
//--></script>  
<?php echo $footer; ?>