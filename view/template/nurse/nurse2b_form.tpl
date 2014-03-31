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
      <div id="tabs" class="htabs"><a href="#tab-nurse2b"><?php echo $tab_nurse2b; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-nurse2b">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-nurse2blist"><?php echo $tab_nurse2b; ?></a>
            <span id="nurse2b-add"><?php echo $button_add_nurse2b; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addNurse2b();" /></span>
			
			<?php if (count($nurse2bforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($nurse2bforms as $nurse2bform) { ?>
            <a title="<?php echo $nurse2bform['date_added']."[". $nurse2bform['arrangement'] ."]"; ?>" alt="<?php echo $nurse2bform['date_added']."[". $nurse2bform['arrangement'] ."]"; ?>" href="#tab-nurse2bform-<?php echo $form_row; ?>" id="nurse2bform-<?php echo $form_row; ?>"><?php echo $tab_nurse2bform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'nurse/nurse2b')) { ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delNurse2b(<?php echo $nurse2bform['child_nurse2b_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a><img style="float:left;margin-top:-28.5px;margin-left:5px;*display:none;" src="view/image/copy.png" title="複製此單新增" alt="複製此單新增" onclick="addNurse2b(null, <?php echo $form_row; ?>);"/>
            <?php $form_row++; ?>
            <?php } ?>

			<?php if (count($nurse2bforms) > 12) { ?>
			</div>
			<?php } ?>
			
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-nurse2blist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($nurse2bforms as $nurse2bform) { ?>
		<div id="tab-nurse2bform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $nurse2bform['date_added']; ?> <?php echo $nurse2bform['arrangement'];?> <?php echo $tab_nurse2bform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="nurse2bform[<?php echo $form_row; ?>][child_nurse2b_id]" value="<?php echo $nurse2bform['child_nurse2b_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">日期與班別</td>
				<td width="35%"><input type="text" name="nurse2bform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  $nurse2bform['date_added'] ;?>" size="12" />
				<select name="nurse2bform[<?php echo $form_row; ?>][arrangement]">
					<option value=""></option>
					<option value="白班" <?php echo ($nurse2bform['arrangement']=="白班")? "selected=\"selected\"":""; ?>>白班</option>
					<option value="小夜" <?php echo ($nurse2bform['arrangement']=="小夜")? "selected=\"selected\"":""; ?>>小夜</option>
					<option value="大夜" <?php echo ($nurse2bform['arrangement']=="大夜")? "selected=\"selected\"":""; ?>>大夜</option>
				</select>
				</td>
                <td width="15%">護理人員</td>
                <td width="35%"><select name="nurse2bform[<?php echo $form_row; ?>][nurse_id]">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse2bform['nurse_id']) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
                <td rowspan="2">寶寶一般情形：</td>
				<td rowspan="2"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="良好")? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="radio"  value="好" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="好")? "checked":""; ?>/> 好</div>
				  <div class="odd"><input type="radio"  value="穩定" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="穩定")? "checked":""; ?>/> 穩定</div>
				  <div class="even"><input type="radio"  value="尚可" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="尚可")? "checked":""; ?>/> 尚可</div>
				  <div class="odd"><input type="radio"  value="不佳" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="不佳")? "checked":""; ?>/> 不佳</div>
				  <div class="even"><input type="radio"  value="危急" name="nurse2bform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse2bform['chk1']=="危急")? "checked":""; ?>/> 危急</div>
                </div></td>
                <td>體溫：</td>
                <td><input type="text" name="nurse2bform[<?php echo $form_row; ?>][chk4]" value="<?php echo $nurse2bform['chk4']; ?>" size="12" /> ℃</td>
			</tr>
			  <tr>
                <td>心跳：</td>
                <td><input type="text" name="nurse2bform[<?php echo $form_row; ?>][chk5]" value="<?php echo $nurse2bform['chk5']; ?>" size="12" /> (每分鐘)</td>
			</tr>
			<tr>
                <td rowspan="2">活動力：</td>
				<td rowspan="2"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="良好")? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="radio"  value="好" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="好")? "checked":""; ?>/> 好</div>
				  <div class="odd"><input type="radio"  value="尚可" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="尚可")? "checked":""; ?>/> 尚可</div>
				  <div class="even"><input type="radio"  value="普通" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="odd"><input type="radio"  value="減弱" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="減弱")? "checked":""; ?>/> 減弱</div>
				  <div class="even"><input type="radio"  value="不好" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="不好")? "checked":""; ?>/> 不好</div>
				  <div class="odd"><input type="radio"  value="很差" name="nurse2bform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse2bform['chk2']=="很差")? "checked":""; ?>/> 很差</div>
                </div></td>
				<td>呼吸：</td>
                <td><input type="text" name="nurse2bform[<?php echo $form_row; ?>][chk6]" value="<?php echo $nurse2bform['chk6']; ?>" size="12" /> (每分鐘)</td>
              </tr>
			  <tr>
                <td>黃疸數值為：</td>
                <td><input type="text" name="nurse2bform[<?php echo $form_row; ?>][chk7]" value="<?php echo $nurse2bform['chk7']; ?>" size="12" /> mg/dL</td>
              </tr>
			  <tr>
                <td>食慾：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="良好")? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="radio"  value="好" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="好")? "checked":""; ?>/> 好</div>
				  <div class="odd"><input type="radio"  value="尚可" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="尚可")? "checked":""; ?>/> 尚可</div>
				  <div class="even"><input type="radio"  value="普通" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="odd"><input type="radio"  value="不好" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="不好")? "checked":""; ?>/> 不好</div>
				  <div class="even"><input type="radio"  value="很差" name="nurse2bform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse2bform['chk3']=="很差")? "checked":""; ?>/> 很差</div>
                </div></td>
				<td>血氧飽和濃度為：</td>
				<td><input type="text" name="nurse2bform[<?php echo $form_row; ?>][chk8]" value="<?php echo $nurse2bform['chk8']; ?>" size="12" /> %</td>
              </tr>

			<tr>
                <td>嘴唇顏色：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="粉紅" name="nurse2bform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2bform['chk9']=="粉紅")? "checked":""; ?>/> 粉紅</div>
				  <div class="even"><input type="radio"  value="紅" name="nurse2bform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2bform['chk9']=="紅")? "checked":""; ?>/> 紅</div>
				  <div class="odd"><input type="radio"  value="蒼白" name="nurse2bform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2bform['chk9']=="蒼白")? "checked":""; ?>/> 蒼白</div>
				  <div class="even"><input type="radio"  value="發紺" name="nurse2bform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2bform['chk9']=="發紺")? "checked":""; ?>/> 發紺</div>
				  <div class="odd"><input type="radio"  value="發黑" name="nurse2bform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse2bform['chk9']=="發黑")? "checked":""; ?>/> 發黑</div>
                </div></td>
                <td>四肢活動力：</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="良好")? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="radio"  value="好" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="好")? "checked":""; ?>/> 好</div>
				  <div class="even"><input type="radio"  value="尚可" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="尚可")? "checked":""; ?>/> 尚可</div>
				  <div class="odd"><input type="radio"  value="普通" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="普通")? "checked":""; ?>/> 普通</div>
				  <div class="even"><input type="radio"  value="不好" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="不好")? "checked":""; ?>/> 不好</div>
				  <div class="odd"><input type="radio"  value="很差" name="nurse2bform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse2bform['chk10']=="很差")? "checked":""; ?>/> 很差</div>
                </div></td>
              </tr>
			  <tr>
                <td>外觀情形為：</td>
				<?php $c11 = (!empty($nurse2bform['chk11']))? unserialize($nurse2bform['chk11']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("正常", $c11 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="頭皮血腫" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("頭皮血腫", $c11 ))? "checked":""; ?>/> 頭皮血腫</div>
				  <div class="even"><input type="checkbox"  value="產瘤" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("產瘤", $c11 ))? "checked":""; ?>/> 產瘤</div>
				  <div class="odd"><input type="checkbox"  value="微血管瘤" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("微血管瘤", $c11 ))? "checked":""; ?>/> 微血管瘤</div>
				  <div class="even"><input type="checkbox"  value="粟粒疹" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("粟粒疹", $c11 ))? "checked":""; ?>/> 粟粒疹</div>
				  <div class="odd"><input type="checkbox"  value="皮膚脫皮" name="nurse2bform[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("皮膚脫皮", $c11 ))? "checked":""; ?>/> 皮膚脫皮</div>
                </div></td>
                <td>眼睛狀況為：</td>
				<?php $c12 = (!empty($nurse2bform['chk12']))? unserialize($nurse2bform['chk12']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("良好", $c12 ))? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="checkbox"  value="左側結膜出血" name="nurse2bform[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("左側結膜出血", $c12 ))? "checked":""; ?>/> 左側結膜出血</div>
				  <div class="even"><input type="checkbox"  value="左側結膜出血及分泌物" name="nurse2bform[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("左側結膜出血及分泌物", $c12 ))? "checked":""; ?>/> 左側結膜出血及分泌物</div>
				  <div class="odd"><input type="checkbox"  value="右側結膜出血" name="nurse2bform[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("右側結膜出血", $c12 ))? "checked":""; ?>/> 右側結膜出血</div>
				  <div class="even"><input type="checkbox"  value="右側結膜出血及分泌物" name="nurse2bform[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("右側結膜出血及分泌物", $c12 ))? "checked":""; ?>/> 右側結膜出血及分泌物</div>
                </div></td>
              </tr>
			  <tr>
			    <td>口腔情形為：</td>
				<?php $c13 = (!empty($nurse2bform['chk13']))? unserialize($nurse2bform['chk13']) : array(); $otherchecked13 = false; $chk13_other = '';
				if (!empty($c13)) {
					foreach ($c13 as $cccc) {
						if (preg_match("/先天畸形/i", $cccc)) { $car = explode(':', $cccc); $otherchecked13= true;  $chk13_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="良好" name="nurse2bform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("良好", $c13 ))? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="checkbox"  value="有鵝口瘡" name="nurse2bform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("有鵝口瘡", $c13 ))? "checked":""; ?>/> 有鵝口瘡</div>
				  <div class="odd"><input type="checkbox"  value="牙齦腫脹" name="nurse2bform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("牙齦腫脹", $c13 ))? "checked":""; ?>/> 牙齦腫脹</div>
				  <div class="even"><input type="checkbox"  value="草莓舌" name="nurse2bform[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("草莓舌", $c13 ))? "checked":""; ?>/> 草莓舌</div>
				  <div class="odd"><input type="checkbox" value="先天畸形" name="nurse2bform[<?php echo $form_row; ?>][chk13][]"  <?php echo ($otherchecked13)? "checked":""; ?>/> 先天畸形&nbsp;&nbsp;<input name="nurse2bform[<?php echo $form_row; ?>][chk13_other]" value="<?php echo $chk13_other; ?>" size="12" /></div>
                </div></td>
                <td>皮膚狀況為：</td>
				<?php $c14 = (!empty($nurse2bform['chk14']))? unserialize($nurse2bform['chk14']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="紅潤" name="nurse2bform[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("紅潤", $c14 ))? "checked":""; ?>/> 紅潤</div>
				  <div class="even"><input type="checkbox"  value="乾燥" name="nurse2bform[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("乾燥", $c14 ))? "checked":""; ?>/> 乾燥</div>
				  <div class="even"><input type="checkbox"  value="脫皮" name="nurse2bform[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("脫皮", $c14 ))? "checked":""; ?>/> 脫皮</div>
				  <div class="odd"><input type="checkbox"  value="有異位性皮膚炎" name="nurse2bform[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("有異位性皮膚炎", $c14 ))? "checked":""; ?>/> 有異位性皮膚炎</div>
				  <div class="even"><input type="checkbox"  value="有傷痕" name="nurse2bform[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("有傷痕", $c14 ))? "checked":""; ?>/> 有傷痕</div>
                </div></td>
              </tr>
			  <tr>
                <td>腹部外觀：</td>
				<?php $c15 = (!empty($nurse2bform['chk15']))? unserialize($nurse2bform['chk15']) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("正常", $c15 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="微脹" name="nurse2bform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("微脹", $c15 ))? "checked":""; ?>/> 微脹</div>
				  <div class="even"><input type="checkbox"  value="很脹" name="nurse2bform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("很脹", $c15 ))? "checked":""; ?>/> 很脹</div>
				  <div class="odd"><input type="checkbox"  value="有大理石皮膚" name="nurse2bform[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("有大理石皮膚", $c15 ))? "checked":""; ?>/> 有大理石皮膚</div>
                </div></td>
                <td>臍帶：</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="尚存" name="nurse2bform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse2bform['chk16']=="尚存")? "checked":""; ?>/> 尚存</div>
				  <div class="even"><input type="radio"  value="已掉" name="nurse2bform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse2bform['chk16']=="已掉")? "checked":""; ?>/> 已掉</div>
                </div></td>
              </tr>
			  <tr>
                <td>臍帶分泌物為：</td>
				<?php $c17 = (!empty($nurse2bform['chk17']))? unserialize($nurse2bform['chk17']) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("正常", $c17 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="白色" name="nurse2bform[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("白色", $c17 ))? "checked":""; ?>/> 白色</div>
				  <div class="even"><input type="checkbox"  value="黃色" name="nurse2bform[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("黃色", $c17 ))? "checked":""; ?>/> 黃色</div>
				  <div class="odd"><input type="checkbox"  value="血色" name="nurse2bform[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("血色", $c17 ))? "checked":""; ?>/> 血色</div>
                </div></td>
                <td>陰部狀況為：</td>
				<?php $c18 = (!empty($nurse2bform['chk18']))? unserialize($nurse2bform['chk18']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("正常", $c18 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="大陰唇紅腫" name="nurse2bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("大陰唇紅腫", $c18 ))? "checked":""; ?>/> 大陰唇紅腫</div>
				  <div class="even"><input type="checkbox"  value="陰唇紅腫已消" name="nurse2bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("陰唇紅腫已消", $c18 ))? "checked":""; ?>/> 陰唇紅腫已消</div>
				  <div class="odd"><input type="checkbox"  value="假性月經" name="nurse2bform[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("假性月經", $c18 ))? "checked":""; ?>/> 假性月經</div>
                </div></td>
              </tr>
			  <tr>
                <td>睪丸狀況為：</td>
				<?php $c19 = (!empty($nurse2bform['chk19']))? unserialize($nurse2bform['chk19']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("正常", $c19 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="陰囊水腫" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("陰囊水腫", $c19 ))? "checked":""; ?>/> 陰囊水腫</div>
				  <div class="even"><input type="checkbox"  value="左側疝氣" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("左側疝氣", $c19 ))? "checked":""; ?>/> 左側疝氣</div>
				  <div class="odd"><input type="checkbox"  value="右側疝氣" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("右側疝氣", $c19 ))? "checked":""; ?>/> 右側疝氣</div>
				  <div class="even"><input type="checkbox"  value="左側隱睪" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("左側隱睪", $c19 ))? "checked":""; ?>/> 左側隱睪</div>
				  <div class="odd"><input type="checkbox"  value="右側隱睪" name="nurse2bform[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("右側隱睪", $c19 ))? "checked":""; ?>/> 右側隱睪</div>
                </div></td>
                <td>肛門口附近：</td>
				<?php $c20 = (!empty($nurse2bform['chk20']))? unserialize($nurse2bform['chk20']) : array(); ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[<?php echo $form_row; ?>][chk20][]"  <?php echo (!empty($c20) && in_array("正常", $c20 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="微紅" name="nurse2bform[<?php echo $form_row; ?>][chk20][]"  <?php echo (!empty($c20) && in_array("微紅", $c20 ))? "checked":""; ?>/> 微紅</div>
				  <div class="even"><input type="checkbox"  value="紅腫" name="nurse2bform[<?php echo $form_row; ?>][chk20][]"  <?php echo (!empty($c20) && in_array("紅腫", $c20 ))? "checked":""; ?>/> 紅腫</div>
				  <div class="odd"><input type="checkbox"  value="破皮" name="nurse2bform[<?php echo $form_row; ?>][chk20][]"  <?php echo (!empty($c20) && in_array("破皮", $c20 ))? "checked":""; ?>/> 破皮</div>
				  <div class="even"><input type="checkbox"  value="發炎" name="nurse2bform[<?php echo $form_row; ?>][chk20][]"  <?php echo (!empty($c20) && in_array("發炎", $c20 ))? "checked":""; ?>/> 發炎</div>
                </div></td>
			  </tr>
			  <tr>
                <td>尿布疹：</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="nurse2bform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2bform['chk21']=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="nurse2bform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2bform['chk21']=="有")? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="radio"  value="嚴重" name="nurse2bform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse2bform['chk21']=="嚴重")? "checked":""; ?>/> 嚴重</div>
                </div></td>
                <td>寶寶目前在：</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="媽媽房" name="nurse2bform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2bform['chk22']=="媽媽房")? "checked":""; ?>/> 媽媽房</div>
				  <div class="even"><input type="radio"  value="安睡中" name="nurse2bform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2bform['chk22']=="安睡中")? "checked":""; ?>/> 安睡中</div>
				  <div class="odd"><input type="radio"  value="曝臀中" name="nurse2bform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2bform['chk22']=="曝臀中")? "checked":""; ?>/> 曝臀中</div>
				  <div class="even"><input type="radio"  value="喝奶中" name="nurse2bform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2bform['chk22']=="喝奶中")? "checked":""; ?>/> 喝奶中</div>
				  <div class="odd"><input type="radio"  value="哭鬧中" name="nurse2bform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse2bform['chk22']=="哭鬧中")? "checked":""; ?>/> 哭鬧中</div>
                </div></td>
			  </tr>
			  <tr>
				<td>特別補充：</td>
				<td><textarea name="nurse2bform[<?php echo $form_row; ?>][chk23]" cols="65" rows="10"><?php echo $nurse2bform['chk23']; ?></textarea></td>
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
function delNurse2b(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=nurse/nurse2b/delete&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}
//--></script>
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addNurse2b(date, tabid) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
	html  = '<div id="tab-nurse2bform-' + form_row + '" class="vtabs-content">';
	html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
	html += '	    <div class="inner-heading">';
	html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_nurse2bform; ?></h1>';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>	';
	html += '  <input type="hidden" name="nurse2bform[' + form_row + '][child_nurse2b_id]" value="" />';
	html += '          <table class="form list">';
	html += '			  <tr>';
	html += '				<td width="15%">日期與班別</td>';
	html += '				<td width="35%"><input type="text" name="nurse2bform[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" />';
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
	html += '				<select name="nurse2bform[' + form_row + '][arrangement]">';
	html += '					<option value=""></option>';
	html += '						<option value="白班" <?php echo ($arra=='白班')? "selected=\"selected\"" : ""; ?>>白班</option>';
	html += '						<option value="小夜" <?php echo ($arra=='小夜')? "selected=\"selected\"" : ""; ?>>小夜</option>';
	html += '						<option value="大夜" <?php echo ($arra=='大夜')? "selected=\"selected\"" : ""; ?>>大夜</option>';
	html += '				</select>';
	html += '				</td>';
	html += '                <td width="15%">護理人員</td>';
	html += '                <td width="35%"><select name="nurse2bform[' + form_row + '][nurse_id]">';
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
	html += '                <td rowspan="2">寶寶一般情形：</td>';
	html += '				<td rowspan="2"><div class="scrollbox">';
	html += '				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[' + form_row + '][chk1]"  /> 良好</div>';
	html += '				  <div class="even"><input type="radio"  value="好" name="nurse2bform[' + form_row + '][chk1]"  /> 好</div>';
	html += '				  <div class="odd"><input type="radio"  value="穩定" name="nurse2bform[' + form_row + '][chk1]"  /> 穩定</div>';
	html += '				  <div class="even"><input type="radio"  value="尚可" name="nurse2bform[' + form_row + '][chk1]"  /> 尚可</div>';
	html += '				  <div class="odd"><input type="radio"  value="不佳" name="nurse2bform[' + form_row + '][chk1]"  /> 不佳</div>';
	html += '				  <div class="even"><input type="radio"  value="危急" name="nurse2bform[' + form_row + '][chk1]"  /> 危急</div>';
	html += '                </div></td>';
	html += '                <td>體溫：</td>';
	html += '                <td><input type="text" name="nurse2bform[' + form_row + '][chk4]" value="" size="12" /> ℃</td>';
	html += '			</tr>';
	html += '			  <tr>';
	html += '                <td>心跳：</td>';
	html += '                <td><input type="text" name="nurse2bform[' + form_row + '][chk5]" value="" size="12" /> (每分鐘)</td>';
	html += '			</tr>';
	html += '			<tr>';
	html += '                <td rowspan="2">活動力：</td>';
	html += '				<td rowspan="2"><div class="scrollbox">';
	html += '				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[' + form_row + '][chk2]" /> 良好</div>';
	html += '				  <div class="even"><input type="radio"  value="好" name="nurse2bform[' + form_row + '][chk2]"  /> 好</div>';
	html += '				  <div class="odd"><input type="radio"  value="尚可" name="nurse2bform[' + form_row + '][chk2]"  /> 尚可</div>';
	html += '				  <div class="even"><input type="radio"  value="普通" name="nurse2bform[' + form_row + '][chk2]" /> 普通</div>';
	html += '				  <div class="odd"><input type="radio"  value="減弱" name="nurse2bform[' + form_row + '][chk2]"  /> 減弱</div>';
	html += '				  <div class="even"><input type="radio"  value="不好" name="nurse2bform[' + form_row + '][chk2]" /> 不好</div>';
	html += '				  <div class="odd"><input type="radio"  value="很差" name="nurse2bform[' + form_row + '][chk2]"  /> 很差</div>';
	html += '                </div></td>';
	html += '				<td>呼吸：</td>';
	html += '                <td><input type="text" name="nurse2bform[' + form_row + '][chk6]" value="" size="12" /> (每分鐘)</td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>黃疸數值為：</td>';
	html += '                <td><input type="text" name="nurse2bform[' + form_row + '][chk7]" value="" size="12" /> mg/dL</td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>食慾：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[' + form_row + '][chk3]" /> 良好</div>';
	html += '				  <div class="even"><input type="radio"  value="好" name="nurse2bform[' + form_row + '][chk3]"  /> 好</div>';
	html += '				  <div class="odd"><input type="radio"  value="尚可" name="nurse2bform[' + form_row + '][chk3]"  /> 尚可</div>';
	html += '				  <div class="even"><input type="radio"  value="普通" name="nurse2bform[' + form_row + '][chk3]"  /> 普通</div>';
	html += '				  <div class="odd"><input type="radio"  value="不好" name="nurse2bform[' + form_row + '][chk3]"  /> 不好</div>';
	html += '				  <div class="even"><input type="radio"  value="很差" name="nurse2bform[' + form_row + '][chk3]"  /> 很差</div>';
	html += '                </div></td>';
	html += '				<td>血氧飽和濃度為：</td>';
	html += '				<td><input type="text" name="nurse2bform[' + form_row + '][chk8]" value="" size="12" /> %</td>';
	html += '              </tr>';
	html += '';
	html += '			<tr>';
	html += '                <td>嘴唇顏色：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="radio"  value="粉紅" name="nurse2bform[' + form_row + '][chk9]" /> 粉紅</div>';
	html += '				  <div class="even"><input type="radio"  value="紅" name="nurse2bform[' + form_row + '][chk9]"  /> 紅</div>';
	html += '				  <div class="odd"><input type="radio"  value="蒼白" name="nurse2bform[' + form_row + '][chk9]"  /> 蒼白</div>';
	html += '				  <div class="even"><input type="radio"  value="發紺" name="nurse2bform[' + form_row + '][chk9]" /> 發紺</div>';
	html += '				  <div class="odd"><input type="radio"  value="發黑" name="nurse2bform[' + form_row + '][chk9]"  /> 發黑</div>';
	html += '                </div></td>';
	html += '                <td>四肢活動力：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="radio"  value="良好" name="nurse2bform[' + form_row + '][chk10]"  /> 良好</div>';
	html += '				  <div class="even"><input type="radio"  value="好" name="nurse2bform[' + form_row + '][chk10]"  /> 好</div>';
	html += '				  <div class="even"><input type="radio"  value="尚可" name="nurse2bform[' + form_row + '][chk10]"  /> 尚可</div>';
	html += '				  <div class="odd"><input type="radio"  value="普通" name="nurse2bform[' + form_row + '][chk10]"  /> 普通</div>';
	html += '				  <div class="even"><input type="radio"  value="不好" name="nurse2bform[' + form_row + '][chk10]" /> 不好</div>';
	html += '				  <div class="odd"><input type="radio"  value="很差" name="nurse2bform[' + form_row + '][chk10]"  /> 很差</div>';
	html += '                </div></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>外觀情形為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk11][]"  /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="頭皮血腫" name="nurse2bform[' + form_row + '][chk11][]"  /> 頭皮血腫</div>';
	html += '				  <div class="even"><input type="checkbox"  value="產瘤" name="nurse2bform[' + form_row + '][chk11][]"  /> 產瘤</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="微血管瘤" name="nurse2bform[' + form_row + '][chk11][]"  /> 微血管瘤</div>';
	html += '				  <div class="even"><input type="checkbox"  value="粟粒疹" name="nurse2bform[' + form_row + '][chk11][]" /> 粟粒疹</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="皮膚脫皮" name="nurse2bform[' + form_row + '][chk11][]"  /> 皮膚脫皮</div>';
	html += '                </div></td>';
	html += '                <td>眼睛狀況為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="良好" name="nurse2bform[' + form_row + '][chk12][]"  /> 良好</div>';
	html += '				  <div class="even"><input type="checkbox"  value="左側結膜出血" name="nurse2bform[' + form_row + '][chk12][]"  /> 左側結膜出血</div>';
	html += '				  <div class="even"><input type="checkbox"  value="左側結膜出血及分泌物" name="nurse2bform[' + form_row + '][chk12][]"  /> 左側結膜出血及分泌物</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="右側結膜出血" name="nurse2bform[' + form_row + '][chk12][]"  /> 右側結膜出血</div>';
	html += '				  <div class="even"><input type="checkbox"  value="右側結膜出血及分泌物" name="nurse2bform[' + form_row + '][chk12][]"  /> 右側結膜出血及分泌物</div>';
	html += '                </div></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '			    <td>口腔情形為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="checkbox"  value="良好" name="nurse2bform[' + form_row + '][chk13][]" /> 良好</div>';
	html += '				  <div class="even"><input type="checkbox"  value="有鵝口瘡" name="nurse2bform[' + form_row + '][chk13][]"  /> 有鵝口瘡</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="牙齦腫脹" name="nurse2bform[' + form_row + '][chk13][]"  /> 牙齦腫脹</div>';
	html += '				  <div class="even"><input type="checkbox"  value="草莓舌" name="nurse2bform[' + form_row + '][chk13][]"  /> 草莓舌</div>';
	html += '				  <div class="odd"><input type="checkbox" value="先天畸形" name="nurse2bform[' + form_row + '][chk13][]"  /> 先天畸形&nbsp;&nbsp;<input name="nurse2bform[' + form_row + '][chk13_other]" value="" size="12" /></div>';
	html += '                </div></td>';
	html += '                <td>皮膚狀況為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="紅潤" name="nurse2bform[' + form_row + '][chk14][]"  /> 紅潤</div>';
	html += '				  <div class="even"><input type="checkbox"  value="乾燥" name="nurse2bform[' + form_row + '][chk14][]"  /> 乾燥</div>';
	html += '				  <div class="even"><input type="checkbox"  value="脫皮" name="nurse2bform[' + form_row + '][chk14][]"  /> 脫皮</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="有異位性皮膚炎" name="nurse2bform[' + form_row + '][chk14][]" /> 有異位性皮膚炎</div>';
	html += '				  <div class="even"><input type="checkbox"  value="有傷痕" name="nurse2bform[' + form_row + '][chk14][]"  /> 有傷痕</div>';
	html += '                </div></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>腹部外觀：</td>';
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk15][]" /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="微脹" name="nurse2bform[' + form_row + '][chk15][]"  /> 微脹</div>';
	html += '				  <div class="even"><input type="checkbox"  value="很脹" name="nurse2bform[' + form_row + '][chk15][]"  /> 很脹</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="有大理石皮膚" name="nurse2bform[' + form_row + '][chk15][]"  /> 有大理石皮膚</div>';
	html += '                </div></td>';
	html += '                <td>臍帶：</td>';
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="radio"  value="尚存" name="nurse2bform[' + form_row + '][chk16]"  /> 尚存</div>';
	html += '				  <div class="even"><input type="radio"  value="已掉" name="nurse2bform[' + form_row + '][chk16]"  /> 已掉</div>';
	html += '                </div></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>臍帶分泌物為：</td>';	
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk17][]"  /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="白色" name="nurse2bform[' + form_row + '][chk17][]"  /> 白色</div>';
	html += '				  <div class="even"><input type="checkbox"  value="黃色" name="nurse2bform[' + form_row + '][chk17][]"  /> 黃色</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="血色" name="nurse2bform[' + form_row + '][chk17][]"  /> 血色</div>';
	html += '                </div></td>';
	html += '                <td>陰部狀況為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk18][]"  /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="大陰唇紅腫" name="nurse2bform[' + form_row + '][chk18][]"  /> 大陰唇紅腫</div>';
	html += '				  <div class="even"><input type="checkbox"  value="陰唇紅腫已消" name="nurse2bform[' + form_row + '][chk18][]"  /> 陰唇紅腫已消</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="假性月經" name="nurse2bform[' + form_row + '][chk18][]"  /> 假性月經</div>';
	html += '                </div></td>';
	html += '              </tr>';
	html += '			  <tr>';
	html += '                <td>睪丸狀況為：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk19][]"  /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="陰囊水腫" name="nurse2bform[' + form_row + '][chk19][]"  /> 陰囊水腫</div>';
	html += '				  <div class="even"><input type="checkbox"  value="左側疝氣" name="nurse2bform[' + form_row + '][chk19][]"  /> 左側疝氣</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="右側疝氣" name="nurse2bform[' + form_row + '][chk19][]"  /> 右側疝氣</div>';
	html += '				  <div class="even"><input type="checkbox"  value="左側隱睪" name="nurse2bform[' + form_row + '][chk19][]"  /> 左側隱睪</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="右側隱睪" name="nurse2bform[' + form_row + '][chk19][]"  /> 右側隱睪</div>';
	html += '                </div></td>';
	html += '                <td>肛門口附近：</td>';
	html += '				<td><div class="scrollbox">';
	html += '				  <div class="odd"><input type="checkbox"  value="正常" name="nurse2bform[' + form_row + '][chk20][]"  /> 正常</div>';
	html += '				  <div class="even"><input type="checkbox"  value="微紅" name="nurse2bform[' + form_row + '][chk20][]"  /> 微紅</div>';
	html += '				  <div class="even"><input type="checkbox"  value="紅腫" name="nurse2bform[' + form_row + '][chk20][]"  /> 紅腫</div>';
	html += '				  <div class="odd"><input type="checkbox"  value="破皮" name="nurse2bform[' + form_row + '][chk20][]"  /> 破皮</div>';
	html += '				  <div class="even"><input type="checkbox"  value="發炎" name="nurse2bform[' + form_row + '][chk20][]"  /> 發炎</div>';
	html += '                </div></td>';
	html += '			  </tr>';
	html += '			  <tr>';
	html += '                <td>尿布疹：</td>';
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="radio"  value="無" name="nurse2bform[' + form_row + '][chk21]"/> 無</div>';
	html += '				  <div class="even"><input type="radio"  value="有" name="nurse2bform[' + form_row + '][chk21]" /> 有</div>';
	html += '				  <div class="odd"><input type="radio"  value="嚴重" name="nurse2bform[' + form_row + '][chk21]"/> 嚴重</div>';
	html += '                </div></td>';
	html += '                <td>寶寶目前在：</td>';
	html += '				<td><div class="scrollbox">';
	html += '                  <div class="odd"><input type="radio"  value="媽媽房" name="nurse2bform[' + form_row + '][chk22]"  /> 媽媽房</div>';
	html += '				  <div class="even"><input type="radio"  value="安睡中" name="nurse2bform[' + form_row + '][chk22]"  /> 安睡中</div>';
	html += '				  <div class="odd"><input type="radio"  value="曝臀中" name="nurse2bform[' + form_row + '][chk22]"  /> 曝臀中</div>';
	html += '				  <div class="even"><input type="radio"  value="喝奶中" name="nurse2bform[' + form_row + '][chk22]"  /> 喝奶中</div>';
	html += '				  <div class="odd"><input type="radio"  value="哭鬧中" name="nurse2bform[' + form_row + '][chk22]"  /> 哭鬧中</div>';
	html += '                </div></td>';
	html += '			  </tr>';
	html += '			  <tr>';
	html += '				<td>特別補充：</td>';
	html += '				<td><textarea name="nurse2bform[' + form_row + '][chk23]" cols="65" rows="10"></textarea></td>';
	html += '                <td></td>';
	html += '				<td></td>';
	html += '			  </tr>';
	html += '          </table>';
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';	
    html += '</div>';
	
	$('#tab-nurse2b').append(html);
	
	if (tabid) {
			<?php for ($i=4; $i<=8; $i++) { ?>
			$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $i; ?>]').val($('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $i; ?>]').val());
			<?php } ?>
			<?php for ($j=1; $j<=3; $j++) { ?>
			$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $j; ?>][value=' + $('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $j; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			<?php for ($k=9; $k<=10; $k++) { ?>
			$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $k; ?>][value=' + $('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $k; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			<?php for ($l=11; $l<=15; $l++) { ?>
			$('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $l; ?>]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $l; ?>][value=' + $(this).val() + ']').attr("checked", "checked");
				}
				<?php if ($l == "13") { ?>
					$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $l; ?>_other]').val($('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $l; ?>_other]').val());
				<?php } ?>
			});
			<?php } ?>
			$('#tab-nurse2bform-'+ form_row + ' input[name*=chk16][value=' + $('#tab-nurse2bform-'+ tabid + ' input[name*=chk16]:checked').val() + ']').attr("checked", "checked");
			<?php for ($l=17; $l<=20; $l++) { ?>
			$('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $l; ?>]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $l; ?>][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			<?php } ?>
			<?php for ($k=21; $k<=22; $k++) { ?>
			$('#tab-nurse2bform-'+ form_row + ' input[name*=chk<?php echo $k; ?>][value=' + $('#tab-nurse2bform-'+ tabid + ' input[name*=chk<?php echo $k; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-nurse2bform-'+ form_row + ' [name*=chk23]').text($('#tab-nurse2bform-'+ tabid + ' [name*=chk23]').val());
	}
	
	$('.backlist').show();
	
	$('#nurse2b-add').before('<a href="#tab-nurse2bform-' + form_row + '" id="nurse2bform-' + form_row + '"><img src="view/image/new.png" /> <?php echo $tab_nurse2bform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#nurse2bform-' + form_row + '\').remove(); $(\'#tab-nurse2bform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#nurse2bform-' + form_row).trigger('click');
	
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
		$('[id^=nurse2bform]').click(function() {
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
foreach ($nurse2bforms as $nurse2bform) { 
		$time = strtotime($nurse2bform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_nurse2bform ?>[<?php echo $nurse2bform['arrangement'] ?>]',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#nurse2bform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($nurse2bforms)) { ?>,<?php } ?>
				
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
				addNurse2b(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-nurse2bform-1]").live("click", function () {
			$('#nurse2bform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>