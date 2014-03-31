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
      <div id="tabs" class="htabs"><a href="#tab-nurse2c"><?php echo $tab_nurse2c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-nurse2c">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-nurse2clist"><?php echo $tab_nurse2c; ?></a>
            <span id="nurse2c-add"><?php echo $button_add_nurse2c; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addNurse2c();" /></span>
			
			<?php if (count($nurse2cforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($nurse2cforms as $nurse2cform) { ?>
            <a title="<?php echo $nurse2cform['date_added']; ?>" alt="<?php echo $nurse2cform['date_added']; ?>" href="#tab-nurse2cform-<?php echo $form_row; ?>" id="nurse2cform-<?php echo $form_row; ?>"><?php echo $tab_nurse2cform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'nurse/nurse2c')) { ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delNurse2c(<?php echo $nurse2cform['customer_nurse2c_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a><img style="float:left;margin-top:-28.5px;margin-left:5px;*display:none;cursor:crosshair;" src="view/image/copy.png" title="複製此單新增" alt="複製此單新增" onclick="addNurse2c(null, <?php echo $form_row; ?>);"/>
            <?php $form_row++; ?>
            <?php } ?>

			<?php if (count($nurse2cforms) > 12) { ?>
			</div>
			<?php } ?>
			
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-nurse2clist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($nurse2cforms as $nurse2cform) { ?>
		<div id="tab-nurse2cform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $nurse2cform['date_added']; ?> <?php echo $tab_nurse2cform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="nurse2cform[<?php echo $form_row; ?>][customer_nurse2c_id]" value="<?php echo $nurse2cform['customer_nurse2c_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">實施日期</td>
				<td width="35%"><input type="text" name="nurse2cform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  $nurse2cform['date_added'] ;?>" size="12" /></td>
                <td width="15%">護理人員</td>
                <td width="35%"><select name="nurse2cform[<?php echo $form_row; ?>][nurse_id]">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse2cform['nurse_id']) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
                <td>產後天數</td>
                <td><input type="text" name="nurse2cform[<?php echo $form_row; ?>][days_afterbirth]" value="<?php echo $nurse2cform['days_afterbirth']; ?>" size="12" /> 天</td>
				<td width="100px">體溫</td>
				<td><input type="text" name="nurse2cform[<?php echo $form_row; ?>][chk24]" value="<?php echo $nurse2cform['chk24']; ?>" size="12" /> ℃</td>
              </tr>
		</table>
					
			<div id="tab-nurse2c-body-<?php echo $form_row;?>" >
			<table class="form list">
				  <tr>
					<td  width="150px">精神狀況：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="佳" name="nurse2cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($nurse2cform['chk17']=="佳")? "checked":""; ?>/> 佳</div>
					  <div class="even"><input type="radio"  value="可" name="nurse2cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($nurse2cform['chk17']=="可")? "checked":""; ?>/> 可</div>
					  <div class="odd"><input type="radio"  value="差" name="nurse2cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($nurse2cform['chk17']=="差")? "checked":""; ?>/> 差</div>
					</div></td>
				  </tr>
				  <tr>
					<td>惡露量：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="無")? "checked":""; ?>/> 無</div>	
					  <div class="even"><input type="radio"  value="微量" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="微量")? "checked":""; ?>/> 微量</div>
					  <div class="odd"><input type="radio"  value="少量" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="少量")? "checked":""; ?>/> 少量</div>
					  <div class="even"><input type="radio"  value="中量" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="中量")? "checked":""; ?>/> 中量</div>
					  <div class="odd"><input type="radio"  value="多量" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="多量")? "checked":""; ?>/> 多量</div>
					</div></td>
				  </tr>
				  <tr>
					<td>惡露顏色：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="無")? "checked":""; ?>/> 無</div>
					  <div class="even"><input type="radio"  value="褐色" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="褐色")? "checked":""; ?>/> 褐色</div>
					  <div class="odd"><input type="radio"  value="淡紅" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="淡紅")? "checked":""; ?>/> 淡紅</div>
					  <div class="even"><input type="radio"  value="暗紅" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="暗紅")? "checked":""; ?>/> 暗紅</div>
					  <div class="odd"><input type="radio"  value="紅色" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="紅色")? "checked":""; ?>/> 紅色</div>
					</div></td>
				  </tr>
				  <tr>
					<td>惡露性質：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse2cform['chk11']=="無")? "checked":""; ?>/> 無</div>
					  <div class="even"><input type="radio"  value="正常" name="nurse2cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse2cform['chk11']=="正常")? "checked":""; ?>/> 正常</div>
					  <div class="odd"><input type="radio"  value="血塊" name="nurse2cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse2cform['chk11']=="血塊")? "checked":""; ?>/> 血塊</div>
					  <div class="even"><input type="radio"  value="異味" name="nurse2cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse2cform['chk11']=="異味")? "checked":""; ?>/> 異味</div>
					</div></td>
				  </tr>
				  <tr>
					<td>乳房－左側：</td>
					<?php $c5 = (is_serialized($nurse2cform['chk5']))? unserialize($nurse2cform['chk5']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="軟" name="nurse2cform[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("軟", $c5 ))? "checked":""; ?>/> 軟</div>
					  <div class="even"><input type="checkbox"  value="微脹" name="nurse2cform[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("微脹", $c5 ))? "checked":""; ?>/> 微脹</div>
					  <div class="odd"><input type="checkbox"  value="脹" name="nurse2cform[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("脹", $c5 ))? "checked":""; ?>/> 脹</div>
					  <div class="even"><input type="checkbox"  value="硬塊" name="nurse2cform[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("硬塊", $c5 ))? "checked":""; ?>/> 硬塊</div>
					</div></td>
				  </tr>
				  <tr>
					<td>乳房－右側：</td>
					<?php $c6 = (is_serialized($nurse2cform['chk6']))? unserialize($nurse2cform['chk6']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="軟" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("軟", $c6 ))? "checked":""; ?>/> 軟</div>
					  <div class="even"><input type="checkbox"  value="微脹" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("微脹", $c6 ))? "checked":""; ?>/> 微脹</div>
					  <div class="odd"><input type="checkbox"  value="脹" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("脹", $c6 ))? "checked":""; ?>/> 脹</div>
					  <div class="even"><input type="checkbox"  value="硬塊" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("硬塊", $c6 ))? "checked":""; ?>/> 硬塊</div>
					</div></td>
				  </tr>
				  <tr>
					<td>乳頭－左側：</td>
					<?php $c1 = (is_serialized($nurse2cform['chk1']))? unserialize($nurse2cform['chk1']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("無", $c1 ))? "checked":""; ?>/> 無</div>
					  <div class="even"><input type="checkbox"  value="破皮" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("破皮", $c1 ))? "checked":""; ?>/> 破皮</div>
					  <div class="odd"><input type="checkbox"  value="結痂" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("結痂", $c1 ))? "checked":""; ?>/> 結痂</div>
					  <div class="even"><input type="checkbox"  value="凹陷" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("凹陷", $c1 ))? "checked":""; ?>/> 凹陷</div>
					  <div class="odd"><input type="checkbox"  value="扁平" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("扁平", $c1 ))? "checked":""; ?>/> 扁平</div>
					  <div class="even"><input type="checkbox"  value="小白點" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("小白點", $c1 ))? "checked":""; ?>/> 小白點</div>
					</div></td>
				  </tr>
				  <tr>
					<td>乳頭－右側：</td>
					<?php $c2 = (is_serialized($nurse2cform['chk2']))? unserialize($nurse2cform['chk2']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("無", $c2 ))? "checked":""; ?>/> 無</div>
					  <div class="even"><input type="checkbox"  value="破皮" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("破皮", $c2 ))? "checked":""; ?>/> 破皮</div>
					  <div class="odd"><input type="checkbox"  value="結痂" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("結痂", $c2 ))? "checked":""; ?>/> 結痂</div>
					  <div class="even"><input type="checkbox"  value="凹陷" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("凹陷", $c2 ))? "checked":""; ?>/> 凹陷</div>
					  <div class="odd"><input type="checkbox"  value="扁平" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("扁平", $c2 ))? "checked":""; ?>/> 扁平</div>
					  <div class="even"><input type="checkbox"  value="小白點" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("小白點", $c2 ))? "checked":""; ?>/> 小白點</div>
					</div></td>
				  </tr>
				  <tr>
					<td>宮底位置：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="U-1fb" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="U-1fb")? "checked":""; ?>/> U-1fb</div>
					  <div class="even"><input type="radio"  value="U-2fb" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="U-2fb")? "checked":""; ?>/> U-2fb</div>
					  <div class="odd"><input type="radio"  value="U-3fb" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="U-3fb")? "checked":""; ?>/> U-3fb</div>
					  <div class="even"><input type="radio"  value="U-4fb" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="U-4fb")? "checked":""; ?>/> U-4fb</div>
					  <div class="odd"><input type="radio"  value="U-5fb" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="U-5fb")? "checked":""; ?>/> U-5fb</div>	  
					  <div class="even"><input type="radio"  value="回骨盆腔" name="nurse2cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse2cform['chk8']=="回骨盆腔")? "checked":""; ?>/> 回骨盆腔</div>
					</div></td>
				  </tr>
				  <tr>
					<td>會陰傷口：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="無紅腫" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="無紅腫")? "checked":""; ?>/> 無紅腫</div>
					  <div class="even"><input type="radio"  value="癒合佳" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="癒合佳")? "checked":""; ?>/> 癒合佳</div>
					  <div class="odd"><input type="radio"  value="紅腫" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="紅腫")? "checked":""; ?>/> 紅腫</div>
					  <div class="even"><input type="radio"  value="疼痛" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="疼痛")? "checked":""; ?>/> 疼痛</div>
					</div></td>
				  </tr>
				  <tr>
					<td>C/S傷口 COVER：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="美容膠" name="nurse2cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($nurse2cform['chk13']=="美容膠")? "checked":""; ?>/> 美容膠</div>
					  <div class="even"><input type="radio"  value="人工皮" name="nurse2cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($nurse2cform['chk13']=="人工皮")? "checked":""; ?>/> 人工皮</div>
					  <div class="odd"><input type="radio"  value="紗布" name="nurse2cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($nurse2cform['chk13']=="紗布")? "checked":""; ?>/> 紗布</div>
					</div></td>
				  </tr>
				  <tr>
					<td>C/S傷口外觀：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="無滲液" name="nurse2cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse2cform['chk14']=="無滲液")? "checked":""; ?>/> 無滲液</div>
					  <div class="even"><input type="radio"  value="有滲液" name="nurse2cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse2cform['chk14']=="有滲液")? "checked":""; ?>/> 有滲液</div>
					</div></td>
				  </tr>
				  <tr>
					<td>排泄情形：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="正常" name="nurse2cform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2cform['chk22']=="正常")? "checked":""; ?>/> 正常</div>
					  <div class="even"><input type="radio"  value="便秘" name="nurse2cform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2cform['chk22']=="便秘")? "checked":""; ?>/> 便秘</div>
					  <div class="odd"><input type="radio"  value="腹瀉" name="nurse2cform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2cform['chk22']=="腹瀉")? "checked":""; ?>/> 腹瀉</div>
					</div></td>
				  </tr>  
				  <tr>
					<td>疼痛情形：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="恢復佳" name="nurse2cform[<?php echo $form_row; ?>][chk23]"  <?php echo ($nurse2cform['chk23']=="恢復佳")? "checked":""; ?>/> 恢復佳</div>
					  <div class="even"><input type="radio"  value="尚可" name="nurse2cform[<?php echo $form_row; ?>][chk23]"  <?php echo ($nurse2cform['chk23']=="尚可")? "checked":""; ?>/> 尚可</div>
					  <div class="odd"><input type="radio"  value="疼痛" name="nurse2cform[<?php echo $form_row; ?>][chk23]"  <?php echo ($nurse2cform['chk23']=="疼痛")? "checked":""; ?>/> 疼痛</div>
					</div></td>
				  </tr>
				  <tr>
					<td>活動情形：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="常有活動" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="常有活動")? "checked":""; ?>/> 常有活動</div>
					  <div class="even"><input type="radio"  value="偶有活動" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="偶有活動")? "checked":""; ?>/> 偶有活動</div>
					  <div class="odd"><input type="radio"  value="少有活動" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="少有活動")? "checked":""; ?>/> 少有活動</div>
					</div></td>
				  </tr>
				  <tr>
					<td>本日補充說明：</td>
					<td><textarea name="nurse2cform[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $nurse2cform['supplement']; ?></textarea></td>
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
function delNurse2c(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=nurse/nurse2c/delete&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}

$('.mybox > div').live('click', function() {
	$(this).find('input').attr('checked', true);
});
//--></script>
<script type="text/javascript"><!--
<?php 
$bodydivrow = 1;
foreach ($nurse2cforms as $nurse2cform) { 
$date_assign = (isset($nurse2cform['date_added']))? $nurse2cform['date_added'] : date('Y-m-d');
?>
$('#tab-nurse2cform-<?php echo $bodydivrow; ?> #tabs2-<?php echo $bodydivrow; ?> a').tabs(); 
<?php 
$bodydivrow ++;
} 
?>
//--></script> 
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addNurse2c(date, tabid) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
	var pDays;
	var bDate = '<?php echo $partumdate; ?>';
    pDays =  DateDiff(bDate, date);
	
		html  = '<div id="tab-nurse2cform-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_nurse2cform; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="nurse2cform[' + form_row + '][customer_nurse2c_id]" value="" />';
		html += '  <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">實施日期</td>';
		html += '				<td width="35%"><input type="text" name="nurse2cform[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td width="15%">護理人員</td>';
		html += '                <td width="35%"><select name="nurse2cform[' + form_row + '][nurse_id]">';
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
		html += '                <td>產後天數</td>';
		html += '                <td><input type="text" name="nurse2cform[' + form_row + '][days_afterbirth]" value="'+pDays+'" size="12" /> 天</td>';
		html += '                <td>體溫</td>';
		html += '                <td><input type="text" name="nurse2cform[' + form_row + '][chk24]" value="" size="12" /> ℃</td>';
		html += '              </tr>';
		html += '  </table>';
		
		html += '			<div id="tab-nurse2c-body-' + form_row + '" >';
		html += '			<table class="form list">';
		html += '				  <tr>';
		html += '					<td  width="150px">精神狀況：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="佳" name="nurse2cform[' + form_row + '][chk17]" /> 佳</div>';
		html += '					  <div class="even"><input type="radio"  value="可" name="nurse2cform[' + form_row + '][chk17]" /> 可</div>';
		html += '					  <div class="odd"><input type="radio"  value="差" name="nurse2cform[' + form_row + '][chk17]" /> 差</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>惡露量：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[' + form_row + '][chk9]" /> 無</div>	';
		html += '					  <div class="even"><input type="radio"  value="微量" name="nurse2cform[' + form_row + '][chk9]" /> 微量</div>';
		html += '					  <div class="odd"><input type="radio"  value="少量" name="nurse2cform[' + form_row + '][chk9]"  /> 少量</div>';
		html += '					  <div class="even"><input type="radio"  value="中量" name="nurse2cform[' + form_row + '][chk9]"  /> 中量</div>';
		html += '					  <div class="odd"><input type="radio"  value="多量" name="nurse2cform[' + form_row + '][chk9]"  /> 多量</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>惡露顏色：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[' + form_row + '][chk10]" /> 無</div>';
		html += '					  <div class="even"><input type="radio"  value="褐色" name="nurse2cform[' + form_row + '][chk10]" /> 褐色</div>';
		html += '					  <div class="odd"><input type="radio"  value="淡紅" name="nurse2cform[' + form_row + '][chk10]" /> 淡紅</div>';
		html += '					  <div class="even"><input type="radio"  value="暗紅" name="nurse2cform[' + form_row + '][chk10]" /> 暗紅</div>';
		html += '					  <div class="odd"><input type="radio"  value="紅色" name="nurse2cform[' + form_row + '][chk10]" /> 紅色</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>惡露性質：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="無" name="nurse2cform[' + form_row + '][chk11]" /> 無</div>';
		html += '					  <div class="odd"><input type="radio"  value="正常" name="nurse2cform[' + form_row + '][chk11]" /> 正常</div>';
		html += '					  <div class="even"><input type="radio"  value="血塊" name="nurse2cform[' + form_row + '][chk11]" /> 血塊</div>';
		html += '					  <div class="odd"><input type="radio"  value="異味" name="nurse2cform[' + form_row + '][chk11]" /> 異味</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳房－左側：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="軟" name="nurse2cform[' + form_row + '][chk5][]" /> 軟</div>';
		html += '					  <div class="even"><input type="checkbox"  value="微脹" name="nurse2cform[' + form_row + '][chk5][]" /> 微脹</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="脹" name="nurse2cform[' + form_row + '][chk5][]" /> 脹</div>';
		html += '					  <div class="even"><input type="checkbox"  value="硬塊" name="nurse2cform[' + form_row + '][chk5][]" /> 硬塊</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳房－右側：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="軟" name="nurse2cform[' + form_row + '][chk6][]" /> 軟</div>';
		html += '					  <div class="even"><input type="checkbox"  value="微脹" name="nurse2cform[' + form_row + '][chk6][]" /> 微脹</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="脹" name="nurse2cform[' + form_row + '][chk6][]" /> 脹</div>';
		html += '					  <div class="even"><input type="checkbox"  value="硬塊" name="nurse2cform[' + form_row + '][chk6][]" /> 硬塊</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳頭－左側：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="無" name="nurse2cform[' + form_row + '][chk1][]" /> 無</div>';
		html += '					  <div class="even"><input type="checkbox"  value="破皮" name="nurse2cform[' + form_row + '][chk1][]" /> 破皮</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="結痂" name="nurse2cform[' + form_row + '][chk1][]" /> 結痂</div>';
		html += '					  <div class="even"><input type="checkbox"  value="凹陷" name="nurse2cform[' + form_row + '][chk1][]" /> 凹陷</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="扁平" name="nurse2cform[' + form_row + '][chk1][]" /> 扁平</div>';
		html += '					  <div class="even"><input type="checkbox"  value="小白點" name="nurse2cform[' + form_row + '][chk1][]" /> 小白點</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳頭－右側：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="無" name="nurse2cform[' + form_row + '][chk2][]" /> 無</div>';
		html += '					  <div class="even"><input type="checkbox"  value="破皮" name="nurse2cform[' + form_row + '][chk2][]" /> 破皮</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="結痂" name="nurse2cform[' + form_row + '][chk2][]" /> 結痂</div>';
		html += '					  <div class="even"><input type="checkbox"  value="凹陷" name="nurse2cform[' + form_row + '][chk2][]" /> 凹陷</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="扁平" name="nurse2cform[' + form_row + '][chk2][]" /> 扁平</div>';
		html += '					  <div class="even"><input type="checkbox"  value="小白點" name="nurse2cform[' + form_row + '][chk2][]" /> 小白點</div>';
		html += '					</div></td>';
		html += '				  </tr>';

		html += '				  <tr>';
		html += '					<td>宮底位置：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="U-1fb" name="nurse2cform[' + form_row + '][chk8]" /> U-1fb</div>';
		html += '					  <div class="even"><input type="radio"  value="U-2fb" name="nurse2cform[' + form_row + '][chk8]" /> U-2fb</div>';
		html += '					  <div class="odd"><input type="radio"  value="U-3fb" name="nurse2cform[' + form_row + '][chk8]" /> U-3fb</div>';
		html += '					  <div class="even"><input type="radio"  value="U-4fb" name="nurse2cform[' + form_row + '][chk8]" /> U-4fb</div>';
		html += '					  <div class="odd"><input type="radio"  value="U-5fb" name="nurse2cform[' + form_row + '][chk8]" /> U-5fb</div>	  ';
		html += '					  <div class="even"><input type="radio"  value="回骨盆腔" name="nurse2cform[' + form_row + '][chk8]" /> 回骨盆腔</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>會陰傷口：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="無紅腫" name="nurse2cform[' + form_row + '][chk12]" /> 無紅腫</div>';
		html += '					  <div class="even"><input type="radio"  value="癒合佳" name="nurse2cform[' + form_row + '][chk12]" /> 癒合佳</div>';
		html += '					  <div class="odd"><input type="radio"  value="紅腫" name="nurse2cform[' + form_row + '][chk12]" /> 紅腫</div>';
		html += '					  <div class="even"><input type="radio"  value="疼痛" name="nurse2cform[' + form_row + '][chk12]" /> 疼痛</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>C/S傷口 COVER：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="美容膠" name="nurse2cform[' + form_row + '][chk13]" /> 美容膠</div>';
		html += '					  <div class="even"><input type="radio"  value="人工皮" name="nurse2cform[' + form_row + '][chk13]" /> 人工皮</div>';
		html += '					  <div class="odd"><input type="radio"  value="紗布" name="nurse2cform[' + form_row + '][chk13]" /> 紗布</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>C/S傷口外觀：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="無滲液" name="nurse2cform[' + form_row + '][chk14]" /> 無滲液</div>';
		html += '					  <div class="even"><input type="radio"  value="有滲液" name="nurse2cform[' + form_row + '][chk14]" /> 有滲液</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>排泄情形：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="正常" name="nurse2cform[' + form_row + '][chk22]" /> 正常</div>';
		html += '					  <div class="even"><input type="radio"  value="便秘" name="nurse2cform[' + form_row + '][chk22]" /> 便秘</div>';
		html += '					  <div class="odd"><input type="radio"  value="腹瀉" name="nurse2cform[' + form_row + '][chk22]" /> 腹瀉</div>';
		html += '					</div></td>';
		html += '				  </tr>  ';
		html += '				  <tr>';
		html += '					<td>疼痛情形：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="恢復佳" name="nurse2cform[' + form_row + '][chk23]" /> 恢復佳</div>';
		html += '					  <div class="even"><input type="radio"  value="尚可" name="nurse2cform[' + form_row + '][chk23]" /> 尚可</div>';
		html += '					  <div class="odd"><input type="radio"  value="疼痛" name="nurse2cform[' + form_row + '][chk23]" /> 疼痛</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>活動情形：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="常有活動" name="nurse2cform[' + form_row + '][chk21]" /> 常有活動</div>';
		html += '					  <div class="even"><input type="radio"  value="偶有活動" name="nurse2cform[' + form_row + '][chk21]" /> 偶有活動</div>';
		html += '					  <div class="odd"><input type="radio"  value="少有活動" name="nurse2cform[' + form_row + '][chk21]" /> 少有活動</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>本日補充說明：</td>';
		html += '					<td><textarea name="nurse2cform[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
		html += '				  </tr>  ';
		html += '			  </table>';
		html += '			</div>';
		
		
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';			
	html += '</div>';

	$('#tab-nurse2c').append(html);
	
	if (tabid) {
			$('#tab-nurse2cform-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=days_livein]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk24]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk25]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk26]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk27a]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk27b]').val($('#tab-nurse2cform-'+ tabid + ' input[name*=chk27b]').val());
			<?php for ($i=1; $i<=23; $i++) { ?>
			$('#tab-nurse2cform-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-nurse2cform-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-nurse2cform-'+ tabid + ' input[name*=chk1]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2cform-'+ form_row + ' input[name*=chk1][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-nurse2cform-'+ tabid + ' input[name*=chk2]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2cform-'+ form_row + ' input[name*=chk2][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-nurse2cform-'+ tabid + ' input[name*=chk5]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2cform-'+ form_row + ' input[name*=chk5][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-nurse2cform-'+ tabid + ' input[name*=chk6]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2cform-'+ form_row + ' input[name*=chk6][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-nurse2cform-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2cform-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			//$('#tab-nurse2cform-'+ form_row + ' [name*=supplement]').text($('#tab-nurse2cform-'+ tabid + ' [name*=supplement]').val());
	}
	
	$('.backlist').show();
	
	$('#nurse2c-add').before('<a href="#tab-nurse2cform-' + form_row + '" id="nurse2cform-' + form_row + '"><?php echo $tab_nurse2cform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#nurse2cform-' + form_row + '\').remove(); $(\'#tab-nurse2cform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	$('#tabs2-'+ form_row +' a').tabs();
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('.time').timepicker({timeFormat: 'hh:mm'});
	
	$('#nurse2cform-' + form_row).trigger('click');
	
   $(".date").on('change', function() {
	   var eDate = $(this).parent().parent().parent().find(".date").val();
       var iDays ;
       iDays  = DateDiff(bDate, eDate) ;
	   $(this).parent().parent().parent().find("input[name*='days_afterbirth']").val(iDays);
   });
	
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
		$('[id^=nurse2cform]').click(function() {
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
foreach ($nurse2cforms as $nurse2cform) { 
		$time = strtotime($nurse2cform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_nurse2cform ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#nurse2cform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($nurse2cforms)) { ?>,<?php } ?>
				
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
				addNurse2c(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-nurse2cform-1]").live("click", function () {
			$('#nurse2cform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script>
<script type="text/javascript"><!--  
   var bDate = '<?php echo $partumdate; ?>';
   
   $(".date").on('change', function() {
	   var eDate = $(this).parent().parent().parent().find(".date").val();
       var iDays ;
       iDays  =  DateDiff(bDate, eDate) ;
	   $(this).parent().parent().parent().find("input[name*='days_afterbirth']").val(iDays);
   });
   
    //計算天數的函數
   function  DateDiff(beginDate,  endDate){    //beginDate和endDate都是2007-8-10格式
       var  arrbeginDate,  Date1,  Date2, arrendDate,  iDays  
       arrbeginDate=  beginDate.split("-")  
       Date1=  new  Date(arrbeginDate[1]  +  '-'  +  arrbeginDate[2]  +  '-'  +  arrbeginDate[0])    //轉換為2007-8-10格式
      arrendDate=  endDate.split("-")  
       Date2=  new  Date(arrendDate[1]  +  '-'  +  arrendDate[2]  +  '-'  +  arrendDate[0])  
       iDays  =  parseInt(Math.abs(Date1-  Date2)  /  1000  /  60  /  60  /24)    //轉換為天數 
       return  iDays  
   }   
//--></script>
<?php echo $footer; ?>