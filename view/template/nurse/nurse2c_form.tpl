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
					<td colspan="2" width="150px">活動狀況：</td>
					<?php $c1 = (is_serialized($nurse2cform['chk1']))? unserialize($nurse2cform['chk1']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="協助下床" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("協助下床", $c1 ))? "checked":""; ?>/> 協助下床</div>
					  <div class="even"><input type="checkbox"  value="坐輪椅" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("坐輪椅", $c1 ))? "checked":""; ?>/> 坐輪椅</div>
					  <div class="odd"><input type="checkbox"  value="自由活動" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("自由活動", $c1 ))? "checked":""; ?>/> 自由活動</div>
					  <div class="even"><input type="checkbox"  value="暈眩" name="nurse2cform[<?php echo $form_row; ?>][chk1][]"  <?php echo (!empty($c1) && in_array("暈眩", $c1 ))? "checked":""; ?>/> 暈眩</div>
					</div></td>
				  </tr>
				  <tr>
					<td colspan="2">大便狀況：</td>
					<?php $c2 = (is_serialized($nurse2cform['chk2']))? unserialize($nurse2cform['chk2']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="軟便" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("軟便", $c2 ))? "checked":""; ?>/> 軟便</div>
					  <div class="even"><input type="checkbox"  value="硬便" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("硬便", $c2 ))? "checked":""; ?>/> 硬便</div>
					  <div class="odd"><input type="checkbox"  value="便秘" name="nurse2cform[<?php echo $form_row; ?>][chk2][]"  <?php echo (!empty($c2) && in_array("便秘", $c2 ))? "checked":""; ?>/> 便秘</div>
					</div></td>
				  </tr>
				  <tr>
					<td rowspan="2">子宮復舊評估：</td>
					<td width="120px">宮縮情形：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="硬" name="nurse2cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2cform['chk3']=="硬")? "checked":""; ?>/> 硬</div>
					  <div class="even"><input type="radio"  value="按摩後變硬" name="nurse2cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2cform['chk3']=="按摩後變硬")? "checked":""; ?>/> 按摩後變硬</div>
					  <div class="odd"><input type="radio"  value="鬆軟" name="nurse2cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2cform['chk3']=="鬆軟")? "checked":""; ?>/> 鬆軟</div>					  
					</div></td>
				  </tr>
				  <tr>
					<td>宮底高度：</td>
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
					<td rowspan="2">惡露評估：</td>
					<td>量：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="少" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="少")? "checked":""; ?>/> 少</div>
					  <div class="even"><input type="radio"  value="中" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="中")? "checked":""; ?>/> 中</div>
					  <div class="odd"><input type="radio"  value="多" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="多")? "checked":""; ?>/> 多</div>
					  <div class="even"><input type="radio"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="無")? "checked":""; ?>/> 無</div>	
					  <div class="odd"><input type="radio"  value="血塊" name="nurse2cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2cform['chk9']=="血塊")? "checked":""; ?>/> 血塊</div>
					  
					</div></td>
				  </tr>
				  <tr>
					<td>顏色：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="暗紅" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="暗紅")? "checked":""; ?>/> 暗紅</div>
					  <div class="even"><input type="radio"  value="褐色" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="褐色")? "checked":""; ?>/> 褐色</div>
					  <div class="odd"><input type="radio"  value="淡紅" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="淡紅")? "checked":""; ?>/> 淡紅</div>
					  
					  <div class="even"><input type="radio"  value="鮮紅" name="nurse2cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2cform['chk10']=="鮮紅")? "checked":""; ?>/> 鮮紅</div>
					</div></td>
				  </tr>
				  <tr>
					<td rowspan="2" colspan="2">傷口：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="會陰" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="會陰")? "checked":""; ?>/> 會陰</div>
					  <div class="even"><input type="radio"  value="C／S傷口" name="nurse2cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse2cform['chk12']=="C／S傷口")? "checked":""; ?>/> C／S傷口</div>
					</div></td>
				  </tr>
				  <tr>
				<?php $c13 = (is_serialized($chk13))? unserialize($chk13) : array(); $otherchecked13 = false; $chk13_other = '';
					if (!empty($c13)) {
						foreach ($c13 as $cccc) {
							if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked13 = true;  $chk13_other = (isset($car[1])) ? $car[1] : ''; } 
						} 
					}?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="發紅" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("發紅", $c13 ))? "checked":""; ?>/> 發紅</div>
					  <div class="even"><input type="checkbox"  value="水腫" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("水腫", $c13 ))? "checked":""; ?>/> 水腫</div>
					  <div class="odd"><input type="checkbox"  value="瘀血" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("瘀血", $c13 ))? "checked":""; ?>/> 瘀血</div>
					  <div class="even"><input type="checkbox"  value="分泌物" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("分泌物", $c13 ))? "checked":""; ?>/> 分泌物</div>
					  <div class="odd"><input type="checkbox"  value="疼痛" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("疼痛", $c13 ))? "checked":""; ?>/> 疼痛</div>
					  <div class="even"><input type="checkbox"  value="其他" name="nurse2cform[<?php echo $form_row; ?>][chk13][]"  <?php echo ($otherchecked13)? "checked":""; ?>/> 其他</div><span id="chk13other"><input name="chk13_other" value="<?php echo $chk13_other; ?>" size="30" /></span>
					</div></td>
				  </tr>
				  <tr>
					<td rowspan="2" colspan="2">痔瘡評估：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="有" name="nurse2cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse2cform['chk14']=="有")? "checked":""; ?>/> 有</div>
					  <div class="even"><input type="radio"  value="無" name="nurse2cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse2cform['chk14']=="無")? "checked":""; ?>/> 無</div>
					</div></td>
				  </tr>
				  <tr>
					<?php $c15 = (is_serialized($nurse2cform['chk15']))? unserialize($nurse2cform['chk15']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="無不適" name="nurse2cform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("無不適", $c15 ))? "checked":""; ?>/> 無不適</div>
					  <div class="even"><input type="checkbox"  value="輕微腫痛" name="nurse2cform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("輕微腫痛", $c15 ))? "checked":""; ?>/> 輕微腫痛</div>
					  <div class="odd"><input type="checkbox"  value="疼痛紅腫" name="nurse2cform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("疼痛紅腫", $c15 ))? "checked":""; ?>/> 疼痛紅腫</div>
					  <div class="even"><input type="checkbox"  value="排便出血" name="nurse2cform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("排便出血", $c15 ))? "checked":""; ?>/> 排便出血</div>
					</div></td>
				  </tr>
				  <tr>
					<td rowspan="3">母乳哺餵：</td>
					<td>哺餵方式：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="純母奶" name="nurse2cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse2cform['chk16']=="純母奶")? "checked":""; ?>/> 純母奶</div>
					  <div class="even"><input type="radio"  value="配方奶" name="nurse2cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse2cform['chk16']=="配方奶")? "checked":""; ?>/> 配方奶</div>
					  <div class="odd"><input type="radio"  value="混合哺乳" name="nurse2cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse2cform['chk16']=="混合哺乳")? "checked":""; ?>/> 混合哺乳</div>
					</div>
				  </tr>
				  <tr>
					<td>乳頭評估：</td>
					<?php $c4 = (is_serialized($nurse2cform['chk4']))? unserialize($nurse2cform['chk4']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="完整" name="nurse2cform[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("完整", $c4 ))? "checked":""; ?>/> 完整</div>
					  <div class="even"><input type="checkbox"  value="發紅或疼痛" name="nurse2cform[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("發紅或疼痛", $c4 ))? "checked":""; ?>/> 發紅或疼痛</div>
					  <div class="odd"><input type="checkbox"  value="破裂" name="nurse2cform[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("破裂", $c4 ))? "checked":""; ?>/> 破裂</div>
					  <div class="even"><input type="checkbox"  value="乾燥或結痂" name="nurse2cform[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("乾燥或結痂", $c4 ))? "checked":""; ?>/> 乾燥或結痂</div>
					  <div class="odd"><input type="checkbox"  value="凹陷" name="nurse2cform[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("凹陷", $c4 ))? "checked":""; ?>/> 凹陷</div>
					</div></td>
				  </tr>
				  <tr>
					<td>乳汁排出情形：</td>
					<?php $c6 = (is_serialized($nurse2cform['chk6']))? unserialize($nurse2cform['chk6']) : array(); ?>
					<td><div class="mybox">
					  <div class="odd"><input type="checkbox"  value="順利排出" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("順利排出", $c6 ))? "checked":""; ?>/> 順利排出</div>
					  <div class="even"><input type="checkbox"  value="脹奶" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("脹奶", $c6 ))? "checked":""; ?>/> 脹奶</div>
					  <div class="odd"><input type="checkbox"  value="有部份阻塞（有硬塊）" name="nurse2cform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("有部份阻塞（有硬塊）", $c6 ))? "checked":""; ?>/> 有部份阻塞（有硬塊）</div>
					</div></td>
				  </tr>
				  <tr>
					<td colspan="2">產後心理調適過程：</td>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="接受期" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="接受期")? "checked":""; ?>/> 接受期</div>
					  <div class="even"><input type="radio"  value="緊執期" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="緊執期")? "checked":""; ?>/> 緊執期</div>
					  <div class="odd"><input type="radio"  value="放手期" name="nurse2cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2cform['chk21']=="放手期")? "checked":""; ?>/> 放手期</div>
					</div></td>
				  </tr>
				  <tr>
					<td colspan="2">醫囑：</td>
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

<style>
	.mybox div.odd, .mybox div.even {
		cursor:default;
	}
</style>
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

/*
$('.mybox > div').live('click', function() {
	if ($(this).find('input').attr('checked')) {
		$(this).find('input').attr('checked', false);
	} else {
		$(this).find('input').attr('checked', true);
	}
});
*/
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
		html += '					<td colspan="2" width="150px">活動狀況：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="協助下床" name="nurse2cform[' + form_row + '][chk1][]" /> 協助下床</div>';
		html += '					  <div class="even"><input type="checkbox"  value="坐輪椅" name="nurse2cform[' + form_row + '][chk1][]" /> 坐輪椅</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="自由活動" name="nurse2cform[' + form_row + '][chk1][]" /> 自由活動</div>';
		html += '					  <div class="even"><input type="checkbox"  value="暈眩" name="nurse2cform[' + form_row + '][chk1][]" /> 暈眩</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td colspan="2">大便狀況：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="軟便" name="nurse2cform[' + form_row + '][chk2][]" /> 軟便</div>';
		html += '					  <div class="even"><input type="checkbox"  value="硬便" name="nurse2cform[' + form_row + '][chk2][]" /> 硬便</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="便秘" name="nurse2cform[' + form_row + '][chk2][]" /> 便秘</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td rowspan="2">子宮復舊評估：</td>';
		html += '					<td width="120px">宮縮情形：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="硬" name="nurse2cform[' + form_row + '][chk3]" /> 硬</div>';
		html += '					  <div class="even"><input type="radio"  value="按摩後變硬" name="nurse2cform[' + form_row + '][chk3]" /> 按摩後變硬</div>';
		html += '					  <div class="odd"><input type="radio"  value="鬆軟" name="nurse2cform[' + form_row + '][chk3]" /> 鬆軟</div>					  ';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>宮底高度：</td>';
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
		html += '					<td rowspan="2">惡露評估：</td>';
		html += '					<td>量：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="少" name="nurse2cform[' + form_row + '][chk9]" /> 少</div>';
		html += '					  <div class="even"><input type="radio"  value="中" name="nurse2cform[' + form_row + '][chk9]" /> 中</div>';
		html += '					  <div class="odd"><input type="radio"  value="多" name="nurse2cform[' + form_row + '][chk9]" /> 多</div>';
		html += '					  <div class="even"><input type="radio"  value="無" name="nurse2cform[' + form_row + '][chk9]" /> 無</div>	';
		html += '					  <div class="odd"><input type="radio"  value="血塊" name="nurse2cform[' + form_row + '][chk9]" /> 血塊</div>';
		html += '					  ';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>顏色：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="暗紅" name="nurse2cform[' + form_row + '][chk10]" /> 暗紅</div>';
		html += '					  <div class="even"><input type="radio"  value="褐色" name="nurse2cform[' + form_row + '][chk10]" /> 褐色</div>';
		html += '					  <div class="odd"><input type="radio"  value="淡紅" name="nurse2cform[' + form_row + '][chk10]" /> 淡紅</div>';
		html += '					  ';
		html += '					  <div class="even"><input type="radio"  value="鮮紅" name="nurse2cform[' + form_row + '][chk10]" /> 鮮紅</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td rowspan="2" colspan="2">傷口：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="會陰" name="nurse2cform[' + form_row + '][chk12]" /> 會陰</div>';
		html += '					  <div class="even"><input type="radio"  value="C／S傷口" name="nurse2cform[' + form_row + '][chk12]" /> C／S傷口</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="發紅" name="nurse2cform[' + form_row + '][chk13][]" /> 發紅</div>';
		html += '					  <div class="even"><input type="checkbox"  value="水腫" name="nurse2cform[' + form_row + '][chk13][]" /> 水腫</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="瘀血" name="nurse2cform[' + form_row + '][chk13][]" /> 瘀血</div>';
		html += '					  <div class="even"><input type="checkbox"  value="分泌物" name="nurse2cform[' + form_row + '][chk13][]" /> 分泌物</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="疼痛" name="nurse2cform[' + form_row + '][chk13][]" /> 疼痛</div>';
		html += '					  <div class="even"><input type="checkbox"  value="其他" name="nurse2cform[' + form_row + '][chk13][]" /> 其他</div><span id="chk13other"><input name="chk13_other" value="<?php echo $chk13_other; ?>" size="30" /></span>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td rowspan="2" colspan="2">痔瘡評估：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="有" name="nurse2cform[' + form_row + '][chk14]" /> 有</div>';
		html += '					  <div class="even"><input type="radio"  value="無" name="nurse2cform[' + form_row + '][chk14]" /> 無</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="無不適" name="nurse2cform[' + form_row + '][chk15][]" /> 無不適</div>';
		html += '					  <div class="even"><input type="checkbox"  value="輕微腫痛" name="nurse2cform[' + form_row + '][chk15][]" /> 輕微腫痛</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="疼痛紅腫" name="nurse2cform[' + form_row + '][chk15][]" /> 疼痛紅腫</div>';
		html += '					  <div class="even"><input type="checkbox"  value="排便出血" name="nurse2cform[' + form_row + '][chk15][]" /> 排便出血</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td rowspan="3">母乳哺餵：</td>';
		html += '					<td>哺餵方式：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="純母奶" name="nurse2cform[' + form_row + '][chk16]" /> 純母奶</div>';
		html += '					  <div class="even"><input type="radio"  value="配方奶" name="nurse2cform[' + form_row + '][chk16]" /> 配方奶</div>';
		html += '					  <div class="odd"><input type="radio"  value="混合哺乳" name="nurse2cform[' + form_row + '][chk16]" /> 混合哺乳</div>';
		html += '					</div>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳頭評估：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="完整" name="nurse2cform[' + form_row + '][chk4][]" /> 完整</div>';
		html += '					  <div class="even"><input type="checkbox"  value="發紅或疼痛" name="nurse2cform[' + form_row + '][chk4][]" /> 發紅或疼痛</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="破裂" name="nurse2cform[' + form_row + '][chk4][]" /> 破裂</div>';
		html += '					  <div class="even"><input type="checkbox"  value="乾燥或結痂" name="nurse2cform[' + form_row + '][chk4][]" /> 乾燥或結痂</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="凹陷" name="nurse2cform[' + form_row + '][chk4][]" /> 凹陷</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td>乳汁排出情形：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="checkbox"  value="順利排出" name="nurse2cform[' + form_row + '][chk6][]" /> 順利排出</div>';
		html += '					  <div class="even"><input type="checkbox"  value="脹奶" name="nurse2cform[' + form_row + '][chk6][]" /> 脹奶</div>';
		html += '					  <div class="odd"><input type="checkbox"  value="有部份阻塞（有硬塊）" name="nurse2cform[' + form_row + '][chk6][]" /> 有部份阻塞（有硬塊）</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td colspan="2">產後心理調適過程：</td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="接受期" name="nurse2cform[' + form_row + '][chk21]" /> 接受期</div>';
		html += '					  <div class="even"><input type="radio"  value="緊執期" name="nurse2cform[' + form_row + '][chk21]" /> 緊執期</div>';
		html += '					  <div class="odd"><input type="radio"  value="放手期" name="nurse2cform[' + form_row + '][chk21]" /> 放手期</div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td colspan="2">醫囑：</td>';
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