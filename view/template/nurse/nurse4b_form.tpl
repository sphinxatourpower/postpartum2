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
      <div id="tabs" class="htabs"><a href="#tab-nurse4b"><?php echo $tab_nurse4b; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-nurse4b">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-nurse4blist"><?php echo $tab_nurse4b; ?></a>		
            <span id="nurse4b-add"><?php echo $button_add_nurse4b; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addNurse4b();" /></span>
			
			<?php if (count($nurse4bforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($nurse4bforms as $nurse4bform) { ?>
            <a title="<?php echo $nurse4bform['date_added']."[". $nurse4bform['arrangement'] ."]"; ?>" alt="<?php echo $nurse4bform['date_added']."[". $nurse4bform['arrangement'] ."]"; ?>" href="#tab-nurse4bform-<?php echo $form_row; ?>" id="nurse4bform-<?php echo $form_row; ?>"><?php echo $tab_nurse4bform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'nurse/nurse4b')) { ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="delNurse4b(<?php echo $nurse4bform['child_nurse4b_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($nurse4bforms) > 12) { ?>
			</div>
			<?php } ?>

		</div>
		<!-- vtabs menu -->
		
		<div id="tab-nurse4blist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($nurse4bforms as $nurse4bform) { ?>
		<div id="tab-nurse4bform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $nurse4bform['date_added']; ?> <?php echo $nurse4bform['arrangement'];?> <?php echo $tab_nurse4bform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="nurse4bform[<?php echo $form_row; ?>][child_nurse4b_id]" value="<?php echo $nurse4bform['child_nurse4b_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">日期與班別</td>
				<td width="35%"><input type="text" name="nurse4bform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo $nurse4bform['date_added']; ?>" size="12" />
				<select name="nurse4bform[<?php echo $form_row; ?>][arrangement]">
					<option value=""></option>
					<option value="白班" <?php echo ($nurse4bform['arrangement']=="白班")? "selected=\"selected\"":""; ?>>白班</option>
					<option value="小夜" <?php echo ($nurse4bform['arrangement']=="小夜")? "selected=\"selected\"":""; ?>>小夜</option>
					<option value="大夜" <?php echo ($nurse4bform['arrangement']=="大夜")? "selected=\"selected\"":""; ?>>大夜</option>
				</select>
				</td>
                <td width="15%">護理人員</td>
                <td width="35%"><select name="nurse4bform[<?php echo $form_row; ?>][nurse_id]">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse4bform['nurse_id']) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
                <td>項目一</td>
				<td>本班次，寶寶自解小便<input type="text" name="nurse4bform[<?php echo $form_row; ?>][chk1]" value="<?php echo $nurse4bform['chk1']; ?>" size="5" />次，予以更換尿布完成。<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk1supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk1supplement']; ?></textarea></td>
                <td>項目二</td>
				<td>本班次，寶寶自解大便<input type="text" name="nurse4bform[<?php echo $form_row; ?>][chk2]" value="<?php echo $nurse4bform['chk2']; ?>" size="5" />次，予以更換尿布完成。<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk2supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk2supplement']; ?></textarea></td>
			  </tr>
			  <tr>
                <td>項目三</td>
				<td>本班次瓶餵母奶<input type="text" name="nurse4bform[<?php echo $form_row; ?>][chk3]" value="<?php echo $nurse4bform['chk3']; ?>" size="5" />cc，並給予拍背打嗝。<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk3supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk3supplement']; ?></textarea></td>
                <td>項目四</td>
				<td>本班次瓶餵配方奶<input type="text" name="nurse4bform[<?php echo $form_row; ?>][chk4]" value="<?php echo $nurse4bform['chk4']; ?>" size="5" />cc，並給予拍背打嗝。<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk4supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk4supplement']; ?></textarea></td>
			</tr>
			  <tr>
				<td>項目五</td>
                <td>大便狀況為：<select name="nurse4bform[<?php echo $form_row; ?>][chk5]">
				<option value=""></option>
				<option value="正常" <?php echo ($nurse4bform['chk5']=="正常")? "selected='selected'":""; ?>>正常</option>
				<option value="略便" <?php echo ($nurse4bform['chk5']=="略便")? "selected='selected'":""; ?>>略便</option>
				<option value="糊便" <?php echo ($nurse4bform['chk5']=="糊便")? "selected='selected'":""; ?>>糊便</option>
				<option value="水便" <?php echo ($nurse4bform['chk5']=="水便")? "selected='selected'":""; ?>>水便</option>
				</select>
				<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk5supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk5supplement']; ?></textarea>
				</td>
                <td>項目六</td>
                <td>寶寶目前於：<select name="nurse4bform[<?php echo $form_row; ?>][chk6]">
				<option value=""></option>
				<option value="媽媽房" <?php echo ($nurse4bform['chk6']=="媽媽房")? "selected='selected'":""; ?>>媽媽房</option>
				<option value="大床安睡中" <?php echo ($nurse4bform['chk6']=="大床安睡中")? "selected='selected'":""; ?>>大床安睡中</option>
				<option value="小床安睡中" <?php echo ($nurse4bform['chk6']=="小床安睡中")? "selected='selected'":""; ?>>小床安睡中</option>
				<option value="外出就醫" <?php echo ($nurse4bform['chk6']=="外出就醫")? "selected='selected'":""; ?>>外出就醫</option>
				<option value="住院中" <?php echo ($nurse4bform['chk6']=="住院中")? "selected='selected'":""; ?>>住院中</option>
				</select>
				<br /><br /><textarea name="nurse4bform[<?php echo $form_row; ?>][chk6supplement]" cols="65" rows="3"><?php echo $nurse4bform['chk6supplement']; ?></textarea></td>
			</tr>
			  <tr>
				<td>補充說明</td>
				<td><textarea name="nurse4bform[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $nurse4bform['supplement']; ?></textarea></td>
                <td></td>
				<td></td>
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
function delNurse4b(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=nurse/nurse4b/delete&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}
//--></script>
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addNurse4b(date) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
	html  = '<div id="tab-nurse4bform-' + form_row + '" class="vtabs-content">';
	html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
	html += '	    <div class="inner-heading">';
	html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_nurse4bform; ?></h1>';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>	';
	html += '  <input type="hidden" name="nurse4bform[' + form_row + '][child_nurse4b_id]" value="" />';	
	html += '          <table class="form list">';
	html += '			  <tr>';
	html += '				<td width="15%">日期與班別</td>';
	html += '				<td width="35%"><input type="text" name="nurse4bform['+ form_row +'][date_added]" class="date" value="' + date + '" size="12" />';

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
	
	html += '				<select name="nurse4bform['+ form_row +'][arrangement]">';
	html += '					<option value=""></option>';
	html += '						<option value="白班" <?php echo ($arra=='白班')? "selected=\"selected\"" : ""; ?>>白班</option>';
	html += '						<option value="小夜" <?php echo ($arra=='小夜')? "selected=\"selected\"" : ""; ?>>小夜</option>';
	html += '						<option value="大夜" <?php echo ($arra=='大夜')? "selected=\"selected\"" : ""; ?>>大夜</option>';
	html += '				</select>';
	html += '				</td>';
	html += '                <td width="15%">護理人員</td>';
	html += '                <td width="35%"><select name="nurse4bform['+ form_row +'][nurse_id]">';
<?php foreach ($nurses as $nurse) { ?>
<?php if ($nurse['user_id'] == $logged_id) { ?>
    html += '                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>';
<?php } else { ?>
	html += '                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>';
<?php } ?>
<?php } ?>
	html += '                  </select></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>項目一</td>';
	html += '				<td>本班次，寶寶自解小便<input type="text" name="nurse4bform['+ form_row +'][chk1]" value="" size="5" />次，予以更換尿布完成。<br /><br /><textarea name="nurse4bform['+ form_row +'][chk1supplement]" cols="65" rows="3"></textarea></td>';
	html += '                <td>項目二</td>';
	html += '				<td>本班次，寶寶自解大便<input type="text" name="nurse4bform['+ form_row +'][chk2]" value="" size="5" />次，予以更換尿布完成。<br /><br /><textarea name="nurse4bform['+ form_row +'][chk2supplement]" cols="65" rows="3"></textarea></td>';
	html += '			  </tr>';
	html += '			  <tr>';
	html += '                <td>項目三</td>';
	html += '				<td>本班次瓶餵母奶<input type="text" name="nurse4bform['+ form_row +'][chk3]" value="" size="5" />cc，並給予拍背打嗝。<br /><br /><textarea name="nurse4bform['+ form_row +'][chk3supplement]" cols="65" rows="3"></textarea></td>';
	html += '                <td>項目四</td>';
	html += '				<td>本班次瓶餵配方奶<input type="text" name="nurse4bform['+ form_row +'][chk4]" value="" size="5" />cc，並給予拍背打嗝。<br /><br /><textarea name="nurse4bform['+ form_row +'][chk4supplement]" cols="65" rows="3"></textarea></td>';
	html += '			</tr>';
	html += '			  <tr>';
	html += '				<td>項目五</td>';
	html += '                <td>大便狀況為：<select name="nurse4bform['+ form_row +'][chk5]">';
	html += '				<option value=""></option>';
	html += '				<option value="正常">正常</option>';
	html += '				<option value="略便">略便</option>';
	html += '				<option value="糊便">糊便</option>';
	html += '				<option value="水便">水便</option>';
	html += '				</select>';
	html += '				<br /><br /><textarea name="nurse4bform['+ form_row +'][chk5supplement]" cols="65" rows="3"></textarea>';
	html += '				</td>';
	html += '                <td>項目六</td>';
	html += '                <td>寶寶目前於：<select name="nurse4bform['+ form_row +'][chk6]">';
	html += '				<option value=""></option>';
	html += '				<option value="媽媽房">媽媽房</option>';
	html += '				<option value="大床安睡中">大床安睡中</option>';
	html += '				<option value="小床安睡中">小床安睡中</option>';
	html += '				<option value="外出就醫">外出就醫</option>';
	html += '				<option value="住院中">住院中</option>';
	html += '				</select>';
	html += '				<br /><br /><textarea name="nurse4bform['+ form_row +'][chk6supplement]" cols="65" rows="3"></textarea></td>';
	html += '			</tr>';
	html += '			  <tr>';
	html += '				<td>補充說明</td>';
	html += '				<td><textarea name="nurse4bform['+ form_row +'][supplement]" cols="65" rows="10"></textarea></td>';
	html += '                <td></td>';
	html += '				<td></td>';
	html += '			  </tr>';
	html += '          </table>';
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';	
    html += '</div>';
	
	$('#tab-nurse4b').append(html);
	$('.backlist').show();
	
	$('#nurse4b-add').before('<a href="#tab-nurse4bform-' + form_row + '" id="nurse4bform-' + form_row + '"><img src="view/image/new.png" /> <?php echo $tab_nurse4bform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#nurse4bform-' + form_row + '\').remove(); $(\'#tab-nurse4bform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#nurse4bform-' + form_row).trigger('click');
	
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
		$('[id^=nurse4bform]').click(function() {
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
foreach ($nurse4bforms as $nurse4bform) { 
		$time = strtotime($nurse4bform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_nurse4bform ?>[<?php echo $nurse4bform['arrangement'] ?>]',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#nurse4bform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($nurse4bforms)) { ?>,<?php } ?>
				
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
				addNurse4b(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-nurse4bform-1]").live("click", function () {
			$('#nurse4bform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>