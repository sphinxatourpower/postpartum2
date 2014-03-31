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
      <div id="tabs" class="htabs"><a href="#tab-childdoctor3"><?php echo $tab_childdoctor3; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>

	  <div id="tab-childdoctor3">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-childdoctor3list"><?php echo $tab_childdoctor3; ?></a>
			<span id="childdoctor3-add"><?php echo $button_add_childdoctor3; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addChildDoctor3();" /></span>
			
			<?php if (count($childdoctor3forms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($childdoctor3forms as $childdoctor3form) { ?>
            <a title="<?php echo $childdoctor3form['date_added']; ?>" alt="<?php echo $childdoctor3form['date_added']; ?>" href="#tab-childdoctor3form-<?php echo $form_row; ?>" id="childdoctor3form-<?php echo $form_row; ?>"><?php echo $tab_childdoctor3form . ' ' . $form_row; ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delChildDoctor3(<?php echo $childdoctor3form['customer_child_doctor3_id']; ?>, <?php echo $form_row; ?>);" /></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($childdoctor3forms) > 12) { ?>
			</div>
			<?php } ?>
            
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-childdoctor3list" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($childdoctor3forms as $childdoctor3form) { ?>
		<div id="tab-childdoctor3form-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $childdoctor3form['date_added']; ?> <?php echo $tab_childdoctor3form; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="childdoctor3form[<?php echo $form_row; ?>][customer_child_doctor3_id]" value="<?php echo $childdoctor3form['customer_child_doctor3_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">實施日期</td>
				<td width="35%"><input type="text" name="childdoctor3form[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  (($childdoctor3form['date_added']=='') ? date('Y-m-d') : $childdoctor3form['date_added'] );?>" size="12" /></td>
                <td>醫師</td>
                <td><select name="childdoctor3form[<?php echo $form_row; ?>][doctor_id]">
                    <?php foreach ($doctors as $doctor) { ?>
                    <?php if ($doctor['user_id'] == $childdoctor3form['doctor_id']) { ?>
                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
                <td>產婦意識狀況為：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="清楚" name="childdoctor3form[<?php echo $form_row; ?>][chk1]"  <?php echo ($childdoctor3form['chk1']=="清楚")? "checked":""; ?>/> 清楚</div>
				  <div class="even"><input type="radio"  value="普通" name="childdoctor3form[<?php echo $form_row; ?>][chk1]"  <?php echo ($childdoctor3form['chk1']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="odd"><input type="radio"  value="欠佳" name="childdoctor3form[<?php echo $form_row; ?>][chk1]"  <?php echo ($childdoctor3form['chk1']=="欠佳")? "checked":""; ?>/> 欠佳</div>
				  <div class="even"><input type="radio"  value="昏迷" name="childdoctor3form[<?php echo $form_row; ?>][chk1]"  <?php echo ($childdoctor3form['chk1']=="昏迷")? "checked":""; ?>/> 昏迷</div>
                </div></td>
                <td>產婦乳房狀況為：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="很好" name="childdoctor3form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor3form['chk2']=="很好")? "checked":""; ?>/> 很好</div>
				  <div class="even"><input type="radio"  value="好" name="childdoctor3form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor3form['chk2']=="好")? "checked":""; ?>/> 好</div>
				  <div class="odd"><input type="radio"  value="普通" name="childdoctor3form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor3form['chk2']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="even"><input type="radio"  value="欠佳" name="childdoctor3form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor3form['chk2']=="欠佳")? "checked":""; ?>/> 欠佳</div>
				  <div class="odd"><input type="radio"  value="不好" name="childdoctor3form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor3form['chk2']=="不好")? "checked":""; ?>/> 不好</div>
                </div></td>
              </tr>
			  <tr>
                <td>產婦乳暈狀況為：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="很好" name="childdoctor3form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor3form['chk3']=="很好")? "checked":""; ?>/> 很好</div>
				  <div class="even"><input type="radio"  value="好" name="childdoctor3form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor3form['chk3']=="好")? "checked":""; ?>/> 好</div>
				  <div class="odd"><input type="radio"  value="普通" name="childdoctor3form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor3form['chk3']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="even"><input type="radio"  value="欠佳" name="childdoctor3form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor3form['chk3']=="欠佳")? "checked":""; ?>/> 欠佳</div>
				  <div class="odd"><input type="radio"  value="不好" name="childdoctor3form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor3form['chk3']=="不好")? "checked":""; ?>/> 不好</div>
                </div></td>
                <td>宮底位置為：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="u-1fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-1fb")? "checked":""; ?>/> u-1fb</div>
				  <div class="even"><input type="radio"  value="u-2fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-2fb")? "checked":""; ?>/> u-2fb</div>
				  <div class="odd"><input type="radio"  value="u-3fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-3fb")? "checked":""; ?>/> u-3fb</div>
				  <div class="even"><input type="radio"  value="u-4fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-4fb")? "checked":""; ?>/> u-4fb</div>
				  <div class="odd"><input type="radio"  value="u-5fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-5fb")? "checked":""; ?>/> u-5fb</div>
				  <div class="even"><input type="radio"  value="u-6fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-6fb")? "checked":""; ?>/> u-6fb</div>
				  <div class="odd"><input type="radio"  value="u-7fb" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="u-7fb")? "checked":""; ?>/> u-7fb</div>
				  <div class="even"><input type="radio"  value="回骨盆腔" name="childdoctor3form[<?php echo $form_row; ?>][chk4]"  <?php echo ($childdoctor3form['chk4']=="回骨盆腔")? "checked":""; ?>/> 回骨盆腔</div>
                </div></td>
              </tr>
			  <tr>
                <td>產婦生產方式為：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="C/S" name="childdoctor3form[<?php echo $form_row; ?>][chk5]"  <?php echo ($childdoctor3form['chk5']=="C/S")? "checked":""; ?>/> C/S</div>
				  <div class="even"><input type="radio"  value="NSD" name="childdoctor3form[<?php echo $form_row; ?>][chk5]"  <?php echo ($childdoctor3form['chk5']=="NSD")? "checked":""; ?>/> NSD</div>
                </div></td>
                <td>傷口狀況為：</td>
				<?php $c6 = (!empty($childdoctor3form['chk6']))? unserialize($childdoctor3form['chk6']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="正常" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("正常", $c6 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="發紅" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("發紅", $c6 ))? "checked":""; ?>/> 發紅</div>
				  <div class="odd"><input type="checkbox"  value="腫脹" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("腫脹", $c6 ))? "checked":""; ?>/> 腫脹</div>
				  <div class="even"><input type="checkbox"  value="疼痛" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("疼痛", $c6 ))? "checked":""; ?>/> 疼痛</div>
				  <div class="odd"><input type="checkbox"  value="分泌物" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("分泌物", $c6 ))? "checked":""; ?>/> 分泌物</div>
				  <div class="even"><input type="checkbox"  value="血腫" name="childdoctor3form[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("血腫", $c6 ))? "checked":""; ?>/> 血腫</div>
                </div></td>
              </tr>
			  <tr>
                <td>產婦本日感冒症狀為：</td>
				<?php $c7 = (!empty($childdoctor3form['chk7']))? unserialize($childdoctor3form['chk7']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="咳嗽" name="childdoctor3form[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("咳嗽", $c7 ))? "checked":""; ?>/> 咳嗽</div>
				  <div class="even"><input type="checkbox"  value="打噴嚏" name="childdoctor3form[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("打噴嚏", $c7 ))? "checked":""; ?>/> 打噴嚏</div>
				  <div class="odd"><input type="checkbox"  value="流鼻水" name="childdoctor3form[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("流鼻水", $c7 ))? "checked":""; ?>/> 流鼻水</div>
				  <div class="even"><input type="checkbox"  value="發燒" name="childdoctor3form[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("發燒", $c7 ))? "checked":""; ?>/> 發燒</div>
                </div></td>
                <td>產婦本日有腸胃炎症狀為：</td>
				<?php $c8 = (!empty($childdoctor3form['chk8']))? unserialize($childdoctor3form['chk8']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="拉肚子" name="childdoctor3form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("拉肚子", $c8 ))? "checked":""; ?>/> 拉肚子</div>
				  <div class="even"><input type="checkbox"  value="嘔吐" name="childdoctor3form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("嘔吐", $c8 ))? "checked":""; ?>/> 嘔吐</div>
				  <div class="odd"><input type="checkbox"  value="發燒" name="childdoctor3form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("發燒", $c8 ))? "checked":""; ?>/> 發燒</div>
				  <div class="even"><input type="checkbox"  value="食慾不佳" name="childdoctor3form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("食慾不佳", $c8 ))? "checked":""; ?>/> 食慾不佳</div>
                </div></td>
              </tr>
			  <tr>
                <td>產婦皮膚有紅疹部位為：</td>
				<?php $c9 = (!empty($childdoctor3form['chk9']))? unserialize($childdoctor3form['chk9']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="肛門口" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("肛門口", $c9 ))? "checked":""; ?>/> 肛門口</div>
				  <div class="even"><input type="checkbox"  value="臀部" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("臀部", $c9 ))? "checked":""; ?>/> 臀部</div>
				  <div class="odd"><input type="checkbox"  value="臉部" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("臉部", $c9 ))? "checked":""; ?>/> 臉部</div>
				  <div class="even"><input type="checkbox"  value="前背" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("前背", $c9 ))? "checked":""; ?>/> 前背</div>
				  <div class="odd"><input type="checkbox"  value="後背" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("後背", $c9 ))? "checked":""; ?>/> 後背</div>
				  <div class="even"><input type="checkbox"  value="上肢" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("上肢", $c9 ))? "checked":""; ?>/> 上肢</div>
				  <div class="odd"><input type="checkbox"  value="下肢" name="childdoctor3form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("下肢", $c9 ))? "checked":""; ?>/> 下肢</div>
                </div></td>
                <td>產婦有服藥，藥物為：</td>
				<td><input type="text"  name="childdoctor3form[<?php echo $form_row; ?>][chk10]"  value="<?php echo $childdoctor3form['chk10']; ?>" size="60" /></td>
              </tr>
			  <tr>
				<td>特別補充事項：</td>
				<td><textarea name="childdoctor3form[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $childdoctor3form['supplement']; ?></textarea></td>
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

<script type="text/javascript"><!--
function delChildDoctor3(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=doctor/childdoctor3/delete&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}
//--></script>
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addChildDoctor3(date) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
		html  = '<div id="tab-childdoctor3form-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_childdoctor3form; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="childdoctor3form[' + form_row + '][customer_child_doctor3_id]" value="" />';
		html += '  <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">實施日期</td>';
		html += '				<td width="35%"><input type="text" name="childdoctor3form[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td>醫師</td>';
		html += '                <td><select name="childdoctor3form[' + form_row + '][doctor_id]">';
<?php foreach ($doctors as $doctor) { ?>
	<?php if ($doctor['user_id'] == $logged_id) { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>';
	<?php } else { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>';
	<?php } ?>
<?php } ?>
		html += '                  </select></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td>產婦意識狀況為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="radio"  value="清楚" name="childdoctor3form[' + form_row + '][chk1]"/> 清楚</div>';
		html += '				  <div class="even"><input type="radio"  value="普通" name="childdoctor3form[' + form_row + '][chk1]"/> 普通</div>';
		html += '				  <div class="odd"><input type="radio"  value="欠佳" name="childdoctor3form[' + form_row + '][chk1]" /> 欠佳</div>';
		html += '				  <div class="even"><input type="radio"  value="昏迷" name="childdoctor3form[' + form_row + '][chk1]" /> 昏迷</div>';
		html += '                </div></td>';
		html += '                <td>產婦乳房狀況為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="radio"  value="很好" name="childdoctor3form[' + form_row + '][chk2]"/> 很好</div>';
		html += '				  <div class="even"><input type="radio"  value="好" name="childdoctor3form[' + form_row + '][chk2]" /> 好</div>';
		html += '				  <div class="odd"><input type="radio"  value="普通" name="childdoctor3form[' + form_row + '][chk2]"  /> 普通</div>';
		html += '				  <div class="even"><input type="radio"  value="欠佳" name="childdoctor3form[' + form_row + '][chk2]"  /> 欠佳</div>';
		html += '				  <div class="odd"><input type="radio"  value="不好" name="childdoctor3form[' + form_row + '][chk2]" /> 不好</div>';
		html += '                </div></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td>產婦乳暈狀況為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="radio"  value="很好" name="childdoctor3form[' + form_row + '][chk3]" /> 很好</div>';
		html += '				  <div class="even"><input type="radio"  value="好" name="childdoctor3form[' + form_row + '][chk3]"  /> 好</div>';
		html += '				  <div class="odd"><input type="radio"  value="普通" name="childdoctor3form[' + form_row + '][chk3]"  /> 普通</div>';
		html += '				  <div class="even"><input type="radio"  value="欠佳" name="childdoctor3form[' + form_row + '][chk3]"/> 欠佳</div>';
		html += '				  <div class="odd"><input type="radio"  value="不好" name="childdoctor3form[' + form_row + '][chk3]"  /> 不好</div>';
		html += '                </div></td>';
		html += '                <td>宮底位置為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="radio"  value="u-1fb" name="childdoctor3form[' + form_row + '][chk4]"  /> u-1fb</div>';
		html += '				  <div class="even"><input type="radio"  value="u-2fb" name="childdoctor3form[' + form_row + '][chk4]"  /> u-2fb</div>';
		html += '				  <div class="odd"><input type="radio"  value="u-3fb" name="childdoctor3form[' + form_row + '][chk4]" /> u-3fb</div>';
		html += '				  <div class="even"><input type="radio"  value="u-4fb" name="childdoctor3form[' + form_row + '][chk4]"  /> u-4fb</div>';
		html += '				  <div class="odd"><input type="radio"  value="u-5fb" name="childdoctor3form[' + form_row + '][chk4]"  /> u-5fb</div>';
		html += '				  <div class="even"><input type="radio"  value="u-6fb" name="childdoctor3form[' + form_row + '][chk4]"  /> u-6fb</div>';
		html += '				  <div class="odd"><input type="radio"  value="u-7fb" name="childdoctor3form[' + form_row + '][chk4]" /> u-7fb</div>';
		html += '				  <div class="even"><input type="radio"  value="回骨盆腔" name="childdoctor3form[' + form_row + '][chk4]"  /> 回骨盆腔</div>';
		html += '                </div></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td>產婦生產方式為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="radio"  value="C/S" name="childdoctor3form[' + form_row + '][chk5]"  /> C/S</div>';
		html += '				  <div class="even"><input type="radio"  value="NSD" name="childdoctor3form[' + form_row + '][chk5]"  /> NSD</div>';
		html += '                </div></td>';
		html += '                <td>傷口狀況為：</td>';
		html += '				<?php $c6 = (!empty($childdoctor3form['chk6']))? unserialize($childdoctor3form['chk6']) : array(); ?>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="checkbox"  value="正常" name="childdoctor3form[' + form_row + '][chk6][]"  /> 正常</div>';
		html += '				  <div class="even"><input type="checkbox"  value="發紅" name="childdoctor3form[' + form_row + '][chk6][]"  /> 發紅</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="腫脹" name="childdoctor3form[' + form_row + '][chk6][]" /> 腫脹</div>';
		html += '				  <div class="even"><input type="checkbox"  value="疼痛" name="childdoctor3form[' + form_row + '][chk6][]"  /> 疼痛</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="分泌物" name="childdoctor3form[' + form_row + '][chk6][]"  /> 分泌物</div>';
		html += '				  <div class="even"><input type="checkbox"  value="血腫" name="childdoctor3form[' + form_row + '][chk6][]" /> 血腫</div>';
		html += '                </div></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td>產婦本日感冒症狀為：</td>';
		html += '				<?php $c7 = (!empty($childdoctor3form['chk7']))? unserialize($childdoctor3form['chk7']) : array(); ?>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="checkbox"  value="咳嗽" name="childdoctor3form[' + form_row + '][chk7][]"  /> 咳嗽</div>';
		html += '				  <div class="even"><input type="checkbox"  value="打噴嚏" name="childdoctor3form[' + form_row + '][chk7][]"  /> 打噴嚏</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="流鼻水" name="childdoctor3form[' + form_row + '][chk7][]" /> 流鼻水</div>';
		html += '				  <div class="even"><input type="checkbox"  value="發燒" name="childdoctor3form[' + form_row + '][chk7][]"/> 發燒</div>';
		html += '                </div></td>';
		html += '                <td>產婦本日有腸胃炎症狀為：</td>';
		html += '				<?php $c8 = (!empty($childdoctor3form['chk8']))? unserialize($childdoctor3form['chk8']) : array(); ?>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="checkbox"  value="拉肚子" name="childdoctor3form[' + form_row + '][chk8][]" /> 拉肚子</div>';
		html += '				  <div class="even"><input type="checkbox"  value="嘔吐" name="childdoctor3form[' + form_row + '][chk8][]"  /> 嘔吐</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="發燒" name="childdoctor3form[' + form_row + '][chk8][]"  /> 發燒</div>';
		html += '				  <div class="even"><input type="checkbox"  value="食慾不佳" name="childdoctor3form[' + form_row + '][chk8][]" /> 食慾不佳</div>';
		html += '                </div></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td>產婦皮膚有紅疹部位為：</td>';
		html += '				<td><div class="scrollbox">';
		html += '				  <div class="odd"><input type="checkbox"  value="肛門口" name="childdoctor3form[' + form_row + '][chk9][]"  /> 肛門口</div>';
		html += '				  <div class="even"><input type="checkbox"  value="臀部" name="childdoctor3form[' + form_row + '][chk9][]"  /> 臀部</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="臉部" name="childdoctor3form[' + form_row + '][chk9][]"  /> 臉部</div>';
		html += '				  <div class="even"><input type="checkbox"  value="前背" name="childdoctor3form[' + form_row + '][chk9][]" /> 前背</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="後背" name="childdoctor3form[' + form_row + '][chk9][]"  /> 後背</div>';
		html += '				  <div class="even"><input type="checkbox"  value="上肢" name="childdoctor3form[' + form_row + '][chk9][]"  /> 上肢</div>';
		html += '				  <div class="odd"><input type="checkbox"  value="下肢" name="childdoctor3form[' + form_row + '][chk9][]"  /> 下肢</div>';
		html += '                </div></td>';
		html += '                <td>產婦有服藥，藥物為：</td>';
		html += '				<td><input type="text"  name="childdoctor3form[' + form_row + '][chk10]"  value="" size="60" /></td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '				<td>特別補充事項：</td>';
		html += '				<td><textarea name="childdoctor3form[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
		html += '				<td></td>';
		html += '				<td></td>';
		html += '			  </tr>';
		html += '  </table>';
		html += '		<div class="inner-footing">';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>';
		html += '	</form>';	
		html += '</div>';

	
	$('#tab-childdoctor3').append(html);
	
	/*
	if (tabid) {
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=days_livein]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk24]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk25]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk26]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk27a]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk27b]').val($('#tab-childdoctor3form-'+ tabid + ' input[name*=chk27b]').val());
			<?php for ($i=1; $i<=23; $i++) { ?>
			$('#tab-childdoctor3form-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-childdoctor3form-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-childdoctor3form-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-childdoctor3form-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-childdoctor3form-'+ form_row + ' [name*=supplement]').text($('#tab-childdoctor3form-'+ tabid + ' [name*=supplement]').val());
	}
	*/
	
	$('.backlist').show();
	
	$('#childdoctor3-add').before('<a href="#tab-childdoctor3form-' + form_row + '" id="childdoctor3form-' + form_row + '"><?php echo $tab_childdoctor3form; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#childdoctor3form-' + form_row + '\').remove(); $(\'#tab-childdoctor3form-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#childdoctor3form-' + form_row).trigger('click');
	
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
		$('[id^=childdoctor3form]').click(function() {
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
foreach ($childdoctor3forms as $childdoctor3form) { 
		$time = strtotime($childdoctor3form['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_childdoctor3form ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#childdoctor3form-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($childdoctor3forms)) { ?>,<?php } ?>
				
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
				addChildDoctor3(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-childdoctor3form-1]").live("click", function () {
			$('#childdoctor3form-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>