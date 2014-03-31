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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button bklst">返回列表</a></div>
    </div>
    <div class="content">

        <div id="tab-customerleave">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs">
		  
			<?php if (count($customers) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($customers as $customer) { ?>
            <a title="<?php echo $customer['name']; ?>" alt="<?php echo $customer['name']; ?>" href="#tab-customerleaveform-<?php echo $form_row; ?>" id="customerleaveform-<?php echo $form_row; ?>"><?php echo ($datatables[$form_row-1]['customer_lastroom']) ? '['. $datatables[$form_row-1]['customer_lastroom'] .']&nbsp;' : ''; ?><?php echo $customer['name']; ?><?php if ($customer['customer_leave_id']) {  echo "&nbsp;<img src=\"view/image/success.png\" />"; } ?></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($customers) > 12) { ?>
			</div>
			<?php } ?>
		</div>

		
		<!-- vtabs menu -->
		
<!--		
		<div id="tab-customerleavelist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
-->		
		
		<?php $form_row = 1; ?>
        <?php foreach ($customers as $n => $customer) { ?>
		<div id="tab-customerleaveform-<?php echo $form_row; ?>" class="vtabs-content">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/customer.png" alt="" /> <?php echo $customer['name']; ?> <?php echo $tab_leaveform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button">確定退住<?php //echo $button_save; ?></a><!--<a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a>--></div>
			</div>
		  <input type="hidden" name="tab_id" value="<?php echo $form_row; ?>" />
		  <input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][customer_leave_id]" value="<?php echo $customer['customer_leave_id']; ?>" />
		  <input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][customer_id]" value="<?php echo $customer['customer_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">日期</td>
				<td width="35%"><input type="text" name="customerleaveform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  (($customer['date_added']=='') ? date('Y-m-d') : $customer['date_added'] );?>" size="12" /></td>
                <td>服務人員</td>
                <td><select name="customerleaveform[<?php echo $form_row; ?>][service_id]">
                    <?php foreach ($services as $service) { ?>
                    <?php if ($service['user_id'] == $customer['service_id']) { ?>
                    <option value="<?php echo $service['user_id']; ?>" selected="selected"><?php echo $service['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $service['user_id']; ?>"><?php echo $service['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
		  </table>
		  
		  	<div id="tabs2-<?php echo $form_row;?>" class="htabs"><a href="#tab-customerleave-<?php echo $form_row;?>"><?php echo $tab_leaveform; ?></a><a href="#tab-customerleave-datatable-<?php echo $form_row;?>"><?php echo $tab_datatable; ?></a></div>
			
		  <div id="tab-customerleave-<?php echo $form_row;?>">
		  <table class="list form">
			<thead>
			  <tr>
                <td class="center" colspan="2" width="90%">項目</td>
				<td class="center">完成打勾</td>
			 </tr>
			</thead>
			<?php $gck = (is_serialized($customer['groupchk']))? unserialize($customer['groupchk']) : array(); ?>
			<tr>
				<td class="center">表單資料</td>
				<td>寶寶生長評估表</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk1" <?php echo (!empty($gck) && in_array("gchk1", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td class="center" rowspan="6">產婦復舊狀況</td>
				<td>
					<div class="mybox">惡露量：
						<div class="odd"><input type="radio"  value="無" name="customerleaveform[<?php echo $form_row; ?>][chk2]"  <?php echo ($customer['chk2']=="無")? "checked":""; ?>/> 無</div>
						<div class="even"><input type="radio"  value="中量" name="customerleaveform[<?php echo $form_row; ?>][chk2]"  <?php echo ($customer['chk2']=="中量")? "checked":""; ?>/> 中量</div>
						<div class="odd"><input type="radio"  value="少量" name="customerleaveform[<?php echo $form_row; ?>][chk2]"  <?php echo ($customer['chk2']=="少量")? "checked":""; ?>/> 少量</div>
						<div class="even"><input type="radio"  value="中量" name="customerleaveform[<?php echo $form_row; ?>][chk2]"  <?php echo ($customer['chk2']=="中量")? "checked":""; ?>/> 中量</div>
						<div class="odd"><input type="radio"  value="多量" name="customerleaveform[<?php echo $form_row; ?>][chk2]"  <?php echo ($customer['chk2']=="多量")? "checked":""; ?>/> 多量</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk2" <?php echo (!empty($gck) && in_array("gchk2", $gck ))? "checked":""; ?>/></div>
				</div></td>
			 </tr>
			 <tr>
				<td>
					<div class="mybox">惡露顏色：
						<div class="odd"><input type="radio"  value="紅色" name="customerleaveform[<?php echo $form_row; ?>][chk3]"  <?php echo ($customer['chk3']=="紅色")? "checked":""; ?>/> 紅色</div>
						<div class="even"><input type="radio"  value="暗紅" name="customerleaveform[<?php echo $form_row; ?>][chk3]"  <?php echo ($customer['chk3']=="暗紅")? "checked":""; ?>/> 暗紅</div>
						<div class="odd"><input type="radio"  value="淡紅" name="customerleaveform[<?php echo $form_row; ?>][chk3]"  <?php echo ($customer['chk3']=="淡紅")? "checked":""; ?>/> 淡紅</div>
						<div class="even"><input type="radio"  value="褐色" name="customerleaveform[<?php echo $form_row; ?>][chk3]"  <?php echo ($customer['chk3']=="褐色")? "checked":""; ?>/> 褐色</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk3" <?php echo (!empty($gck) && in_array("gchk3", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			<tr>
				<td>
					<div class="mybox">惡露性質：
						<div class="odd"><input type="radio"  value="正常" name="customerleaveform[<?php echo $form_row; ?>][chk4]"  <?php echo ($customer['chk4']=="正常")? "checked":""; ?>/> 正常</div>
						<div class="even"><input type="radio"  value="血塊" name="customerleaveform[<?php echo $form_row; ?>][chk4]"  <?php echo ($customer['chk4']=="血塊")? "checked":""; ?>/> 血塊</div>
						<div class="odd"><input type="radio"  value="異味" name="customerleaveform[<?php echo $form_row; ?>][chk4]"  <?php echo ($customer['chk4']=="異味")? "checked":""; ?>/> 異味</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk4" <?php echo (!empty($gck) && in_array("gchk4", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			<tr>
				<td>子宮復舊評估</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk5" <?php echo (!empty($gck) && in_array("gchk5", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			<tr>
				<td>
					<div class="mybox">剖腹產傷口評估：
					<?php $c6 = (is_serialized($customer['chk6']))? unserialize($customer['chk6']) : array(); ?>
						<div class="odd"><input type="checkbox"  value="美容膠" name="customerleaveform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("美容膠", $c6 ))? "checked":""; ?>/> 美容膠</div>
						<div class="even"><input type="checkbox"  value="人工皮" name="customerleaveform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("人工皮", $c6 ))? "checked":""; ?>/> 人工皮</div>
						<div class="odd"><input type="checkbox"  value="紗布" name="customerleaveform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("紗布", $c6 ))? "checked":""; ?>/> 紗布</div>
						<div class="even"><input type="checkbox"  value="無滲液" name="customerleaveform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("無滲液", $c6 ))? "checked":""; ?>/> 無滲液</div>
						<div class="odd"><input type="checkbox"  value="有滲液" name="customerleaveform[<?php echo $form_row; ?>][chk6][]"  <?php echo (!empty($c6) && in_array("有滲液", $c6 ))? "checked":""; ?>/> 有滲液</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk6" <?php echo (!empty($gck) && in_array("gchk6", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			<tr>
				<td>
					<div class="mybox">自然產傷口評估：
					<?php $c7 = (is_serialized($customer['chk7']))? unserialize($customer['chk7']) : array(); ?>
						<div class="odd"><input type="checkbox"  value="無紅腫" name="customerleaveform[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("無紅腫", $c7 ))? "checked":""; ?>/> 無紅腫</div>
						<div class="even"><input type="checkbox"  value="癒合佳" name="customerleaveform[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("癒合佳", $c7 ))? "checked":""; ?>/> 癒合佳</div>
						<div class="odd"><input type="checkbox"  value="疼痛" name="customerleaveform[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("疼痛", $c7 ))? "checked":""; ?>/> 疼痛</div>
						<div class="even"><input type="checkbox"  value="紅腫" name="customerleaveform[<?php echo $form_row; ?>][chk7][]"  <?php echo (!empty($c7) && in_array("紅腫", $c7 ))? "checked":""; ?>/> 紅腫</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk7" <?php echo (!empty($gck) && in_array("gchk7", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td class="center" rowspan="2">居家注意事項護理指導<br />(媽媽指導項目)</td>
				<td>持續泌乳</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk8" <?php echo (!empty($gck) && in_array("gchk8", $gck ))? "checked":""; ?>/></div>
				</div></td>
			 </tr>
			 <tr>
				<td>感染症狀及需就醫的狀況</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk9" <?php echo (!empty($gck) && in_array("gchk9", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td class="center" rowspan="5">居家注意事項護理指導<br />(寶寶指導項目)</td>
				<td>預防注射的時程與反應</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk10" <?php echo (!empty($gck) && in_array("gchk10", $gck ))? "checked":""; ?>/></div>
				</div></td>
			 </tr>
			 <tr>
				<td>嬰兒吐嗆奶處理</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk11" <?php echo (!empty($gck) && in_array("gchk11", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>體溫的監測與維持</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk12" <?php echo (!empty($gck) && in_array("gchk12", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>嬰兒安撫技巧</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk13" <?php echo (!empty($gck) && in_array("gchk13", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>需就醫的狀況</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk14" <?php echo (!empty($gck) && in_array("gchk14", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
<?php foreach ($customer['child_leave'] as $c => $child) { ?>
<input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][customer_child_id]" value="<?php echo $child['customer_child_id']; ?>" />
<?php $child_gck = (is_serialized($child['groupchk']))? unserialize($child['groupchk']) : array(); ?>
			 <tr>
				<td class="center" rowspan="5">返家後母嬰個別性之注意事項護理指導<br /><?php echo $child['name']; ?></td>
				<td>
					<div class="mybox">臍帶：
						<div class="odd"><input type="radio"  value="已掉" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk1]"  <?php echo ($child['chk1']=="已掉")? "checked":""; ?>/> 已掉</div>
						<div class="even"><input type="radio"  value="未掉" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk1]"  <?php echo ($child['chk1']=="未掉")? "checked":""; ?>/> 未掉</div>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][groupchk][]"  value="gchk1" <?php echo (!empty($child_gck) && in_array("gchk1", $child_gck ))? "checked":""; ?>/></div>
				</div></td>
			 </tr>
			 <tr>
				<td>
					<div class="mybox">身體紀錄：
					<?php $child_c2 = (is_serialized($child['chk2']))? unserialize($child['chk2']) : array(); $child_otherchecked2 = false; $child_c2_other = '';?>
					<?php
					if (!empty($child_c2)) {
						foreach ($child_c2 as $cccc) {
							if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $child_otherchecked2= true;  $child_c2_other = (isset($car[1])) ? $car[1] : ''; } 
						} 
					}?>
						<div class="odd"><input type="checkbox"  value="紅臀" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("紅臀", $child_c2 ))? "checked":""; ?>/> 紅臀</div>
						<div class="even"><input type="checkbox"  value="鵝口瘡" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("鵝口瘡", $child_c2 ))? "checked":""; ?>/> 鵝口瘡</div>
						<div class="odd"><input type="checkbox"  value="眼睛分泌物" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("眼睛分泌物", $child_c2 ))? "checked":""; ?>/> 眼睛分泌物</div>
						<div class="even"><input type="checkbox"  value="脂漏性皮膚炎" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("脂漏性皮膚炎", $child_c2 ))? "checked":""; ?>/> 脂漏性皮膚炎</div>
						<div class="odd"><input type="checkbox"  value="毒性紅斑" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("毒性紅斑", $child_c2 ))? "checked":""; ?>/> 毒性紅斑</div>
						<div class="even"><input type="checkbox"  value="熱疹痱子" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("熱疹痱子", $child_c2 ))? "checked":""; ?>/> 熱疹痱子</div>
						<div class="odd"><input type="checkbox"  value="陰囊水腫" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("陰囊水腫", $child_c2 ))? "checked":""; ?>/> 陰囊水腫</div>
						<div class="even"><input type="checkbox"  value="腹股溝疝氣" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("腹股溝疝氣", $child_c2 ))? "checked":""; ?>/> 腹股溝疝氣</div>
						<div class="odd"><input type="checkbox"  value="臍疝氣" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("臍疝氣", $child_c2 ))? "checked":""; ?>/> 臍疝氣</div>
						<div class="even"><input type="checkbox"  value="鎖骨骨折" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("鎖骨骨折", $child_c2 ))? "checked":""; ?>/> 鎖骨骨折</div>
						<div class="odd"><input type="checkbox"  value="割包皮" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo (!empty($child_c2) && in_array("割包皮", $child_c2 ))? "checked":""; ?>/> 割包皮</div>
						<div class="even"><input type="checkbox"  value="其他" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2][]"  <?php echo ($child_otherchecked2)? "checked":""; ?>/> 其他</div><span id="chk2other"><input name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][chk2_other]" value="<?php echo $child_c2_other; ?>" size="12" /></span>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][groupchk][]"  value="gchk2" <?php echo (!empty($child_gck) && in_array("gchk2", $child_gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>黃疸檢測：<br />黃疸值：<input type="text" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][jaundice]" value="<?php echo $child['jaundice']; ?>" size="5" />mg/dl&nbsp;&nbsp;檢測日期：<input class="date" type="text" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][jaundice_chkdate]" value="<?php echo $child['jaundice_chkdate']; ?>" /></td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][groupchk][]"  value="gchk3" <?php echo (!empty($child_gck) && in_array("gchk3", $child_gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>使用藥物：
					<?php $child_medicine = (is_serialized($child['medicine']))? unserialize($child['medicine']) : array(); $child_otherchecked_medicine = false; $child_medicine_other = '';?>
					<?php
					if (!empty($child_medicine)) {
						foreach ($child_medicine as $mmm) {
							if (preg_match("/其他/i", $mmm)) { $mar = explode(':', $mmm); $child_otherchecked_medicine= true;  $child_medicine_other = (isset($mar[1])) ? $mar[1] : ''; } 
						} 
					}?>
					<div class="mybox">
						<div class="odd"><input type="checkbox"  value="Zno" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo (!empty($child_medicine) && in_array("Zno", $child_medicine ))? "checked":""; ?>/> Zno</div>
						<div class="even"><input type="checkbox"  value="Topidin(kanaｃomb)" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo (!empty($child_medicine) && in_array("Topidin(kanaｃomb)", $child_medicine ))? "checked":""; ?>/> Topidin(kanaｃomb)</div>
						<div class="odd"><input type="checkbox"  value="Neomycin  oph  oint" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo (!empty($child_medicine) && in_array("Neomycin  oph  oint", $child_medicine ))? "checked":""; ?>/> Neomycin  oph  oint</div>
						<div class="even"><input type="checkbox"  value="Mycostatin" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo (!empty($child_medicine) && in_array("Mycostatin", $child_medicine ))? "checked":""; ?>/> Mycostatin</div>
						<div class="odd"><input type="checkbox"  value="Cloba" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo (!empty($child_medicine) && in_array("Cloba", $child_medicine ))? "checked":""; ?>/> Cloba</div>
						<div class="even"><input type="checkbox"  value="其他" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine][]"  <?php echo ($child_otherchecked_medicine)? "checked":""; ?>/> 其他</div><span id="medicineother"><input name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][medicine_other]" value="<?php echo $child_medicine_other; ?>" size="12" /></span>
					</div>
				</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][groupchk][]"  value="gchk4" <?php echo (!empty($child_gck) && in_array("gchk4", $child_gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
			 <tr>
				<td>混合哺乳指導</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][child_leave][<?php echo $c; ?>][groupchk][]"  value="gchk5" <?php echo (!empty($child_gck) && in_array("gchk5", $child_gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
<?php } ?>
			 <tr>
				<td class="center" rowspan="2">社區資源或轉介</td>
				<td>回家後您有任何問題，請您打電話回本機構TEL：27055465轉9詢問，我們會盡力為您服務。</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk15" <?php echo (!empty($gck) && in_array("gchk15", $gck ))? "checked":""; ?>/></div>
				</div></td>
			 </tr>
			 <tr>
				<td>已告知母乳哺育轉介資源</td>
				<td><div class="mybox">
					  <div class="odd"><input type="checkbox" name="customerleaveform[<?php echo $form_row; ?>][groupchk][]"  value="gchk16" <?php echo (!empty($gck) && in_array("gchk16", $gck ))? "checked":""; ?>/></div>
				</div></td>
			</tr>
          </table>
		</div>
		
		<div id="tab-customerleave-datatable-<?php echo $form_row;?>" >
<?php if (!empty($bodyrecords[$n])) : ?>		
			<table class="form list">
				<tbody>
					<tr><td width="33%">嬰兒出生體重：<?php echo $datatables[$n]['birthweight']; ?> 公克</td><td width="33%">嬰兒目前體重：<?php echo ($bodyrecords[$n]['weight']) ? $bodyrecords[$n]['weight'] . " 公克 (" . $bodyrecords[$n]['weight_chkdate'] . ")" : '' ; ?><input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][weight]" value="<?php echo $bodyrecords[$n]['weight']; ?>" /><input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][weight_chkdate]" value="<?php echo $bodyrecords[$n]['weight_chkdate']; ?>" /></td><td width="33%">下降率：<?php echo $bodyrecords[$n]['weight_down']; ?> %<input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][weight_down]" value="<?php echo $bodyrecords[$n]['weight_down']; ?>" /></td></tr>
					<tr><td width="33%">嬰兒體溫：<?php echo ($bodyrecords[$n]['temperature']) ? $bodyrecords[$n]['temperature'] . " ℃ (" . $bodyrecords[$n]['temperature_chkdate'] . ")" : '' ; ?><input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][temperature]" value="<?php echo $bodyrecords[$n]['temperature']; ?>" /><input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][temperature_chkdate]" value="<?php echo $bodyrecords[$n]['temperature_chkdate']; ?>" /></td><?php if ($bodyrecords[$n]['jaundice']) { ?><td width="33%">黃疸數值：<?php echo $bodyrecords[$n]['jaundice']; ?> mg/dL<input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][jaundice]" value="<?php echo $bodyrecords[$n]['jaundice']; ?>" /></td><td width="33%">黃疸檢測日期：<?php echo $bodyrecords[$n]['jaundice_chkdate']; ?><input type="hidden" name="customerleaveform[<?php echo $form_row; ?>][jaundice_chkdate]" value="<?php echo $bodyrecords[$n]['jaundice_chkdate']; ?>" /></td><?php } else { ?><td></td><td></td><?php } ?></tr>
				</tdoby>
			</table>
<?php endif; ?>
<?php if (!empty($datatables[$n][0])) : ?>		
<?php foreach($datatables[$n][0] as $dtb) : ?>
			<table class="form list">
				<tbody>
					<tr><td width="33%">產婦姓名：<?php echo $dtb['customer_name']; ?></td><td width="33%">嬰兒姓名：<?php echo $dtb['name']; ?>，性別：<?php echo $dtb['gender']?></td><td width="33%">父親姓名：<?php echo $dtb['spouse_name']; ?></td></tr>
					<tr><td width="33%">房號：<?php echo $datatables[$n]['customer_firstroom']; ?></td>
					<td colspan="2" width="66%">
					<?php foreach ($datatables[$n]['customer_transfers'] as $transfer) { ?>
						轉床紀錄：<?php echo $transfer['date_added']; ?>&nbsp;轉為：<?php echo $transfer['customer_room_name']; ?><br />
					<?php } ?>
					</td></tr>
					<tr><td width="33%">嬰兒出生日期：<?php echo $dtb['birthdate']; ?></td><td width="33%">產婦入住日期：<?php echo $dtb['date_added']; ?></td><td width="33%">預定退住日期：<?php echo $dtb['date_leave']; ?></td></tr>
					<tr><td width="33%">生產方式：<?php echo $dtb['childbirth_method']; ?></td><td width="33%">生產醫院：<?php echo $dtb['childbirth_hospital']; ?></td><td width="33%">生產醫師：<?php echo $dtb['childbirth_doctor']; ?></td></tr>
					<tr><td width="33%">週數：<?php echo $dtb['pregnancy_weeks']; ?>週</td><td width="33%">胎兒產胎次：G:<?php echo $dtb['child_count_g']; ?>&nbsp;&nbsp;P:<?php echo $dtb['child_count_p']; ?></td><td width="33%">Apgar：<?php echo $dtb['apgar_score_1']; ?> (1min) --> <?php echo $dtb['apgar_score_5'];?> (5min)<br />乙型鏈球菌檢查：<?php echo $dtb['b_streptococcus_check']; ?></td></tr>
					<tr><td colspan="3">嬰兒出生時體重：<?php echo $dtb['birthweight']; ?> 公克 &nbsp;頭圍：<?php echo $dtb['birthhead']; ?> 公分 &nbsp;身長：<?php echo $dtb['birthlength']; ?> 公分，入住時體重：<?php echo $dtb['inweight']; ?> 公克</td></tr>
				</tdoby>
			</table>
<?php endforeach; ?>	
<?php endif; ?>			
		</div>
		
		<div class="inner-footing">
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button">確定退住<?php //echo $button_save; ?></a><!--<a  onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?>--></a></div>
		</div>
			
		</form>

		
		</div>
		<?php $form_row++; ?>
        <?php } ?>
	  </div>
      
    </div>

  </div>
</div>

<script type="text/javascript"><!--
<?php 
$iodivrow = 1;
foreach ($customers as $customer) : 
?>
	$('#tab-customerleaveform-<?php echo $iodivrow; ?> #tabs2-<?php echo $iodivrow; ?> a').tabs(); 
<?php 
$iodivrow ++;
endforeach; 
?>

$('#vtabs a').tabs();
//$('.backlist').hide();
$('#vtabs .scrolldiv').mCustomScrollbar();
//--></script> 
<script type="text/javascript"><!--
function setallnormal (obj,id) {
	if (obj.attr('checked') == 'checked') {
		$('#tab-customerleave-'+id+' table').find('input[name*=\'groupchk\']').attr('checked', '').trigger('click').attr('checked', 'checked');
	} else {
		$('#tab-customerleave-'+id+' table').find('input[name*=\'groupchk\']').attr('checked', '').trigger('click');
		$('#tab-customerleave-'+id+' table').find("input").removeAttr("disabled");
		$('#tab-customerleave-'+id+' table').find("textarea").removeAttr("disabled");
	}
}

$(function() {
  $("input[name*=groupchk]").live('click', function(){
	var cname = $(this).attr('id');
	  if (this.checked) {
		$("td." + cname + " input").attr({
			"checked": false,
			"disabled": true
		});
		$("td." + cname + " textarea").val('').attr('disabled', true);
		$("td." + cname + " select").val('').attr('disabled', true);
	  } else {
		$("td." + cname + " input").removeAttr("disabled");
		$("td." + cname + " textarea").removeAttr("disabled");
		$("td." + cname + " select").removeAttr("disabled");
	  }
  });
  $("td[class*=chkgroup] input, td[class*=chkgroup] textarea").live('click', function(){
	var cname = $(this).parent().parent('td').attr('class');
	$("input[id=" + cname + "]").attr("checked", false);
  });
});
//--></script> 
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

	});

//--></script> 
<script type="text/javascript"><!--
function delChildDoctor2(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=doctor/childdoctor2/delete&token=<?php echo $token; ?>&customer_child_id=<?php echo $customer_child_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}
//--></script>
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addChildDoctor2(date) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
		html  = '<div id="tab-customerleaveform-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_customerleaveform; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="customerleaveform[' + form_row + '][customer_child_doctor2_id]" value="" />';
		html += '  <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">實施日期</td>';
		html += '				<td width="35%"><input type="text" name="customerleaveform[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td>醫師</td>';
		html += '                <td><select name="customerleaveform[' + form_row + '][doctor_id]">';
<?php foreach ($doctors as $doctor) { ?>
	<?php if ($doctor['user_id'] == $logged_id) { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>';
	<?php } else { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>';
	<?php } ?>
<?php } ?>
		html += '                  </select></td>';
		html += '              </tr>';
		html += '  </table>';
		html += '		  <table class="form list">';
		html += '			<thead>';
		html += '			  <tr>';
		html += '                <td class="center" width="100px">項目</td>';
		html += '				<td class="center">正常</td>';
		html += '				<td class="center">異常狀況</td>';
		html += '			 </tr>';
		html += '			</thead>';
		html += '			 <tr>';
		html += '				<td class="center">一般表現</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup1" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup1">';
		html += '					<div>活動力：<input type="checkbox"  value="軟弱伸展" name="customerleaveform[' + form_row + '][chk1]"  /> 軟弱伸展</div>';
		html += '					';
		html += '					<div>膚色：<input type="checkbox"  value="微黃" name="customerleaveform[' + form_row + '][chk2]"  /> 微黃&nbsp;<input type="checkbox"  value="偏黃" name="customerleaveform[' + form_row + '][chk2]"  /> 偏黃&nbsp;<input type="checkbox"  value="蒼白" name="customerleaveform[' + form_row + '][chk2]"  /> 蒼白</div>';
		html += '					';
		html += '					<div>體溫：<input type="checkbox"  value="體溫過高" name="customerleaveform[' + form_row + '][chk3]"  /> 體溫過高&nbsp;<input type="checkbox"  value="體溫過低" name="customerleaveform[' + form_row + '][chk3]"  /> 體溫過低</div>';
		html += '					';
		html += '					<div>體重：<input type="checkbox"  value="體重增加緩慢" name="customerleaveform[' + form_row + '][chk4][]"  /> 體重增加緩慢&nbsp;<input type="checkbox"  value="體重過低" name="customerleaveform[' + form_row + '][chk4][]"  /> 體重過低</div>';
		html += '					';
		html += '					<div>大便：<input type="checkbox"  value="腹瀉" name="customerleaveform[' + form_row + '][chk5][]"  /> 腹瀉&nbsp;<input type="checkbox"  value="便祕" name="customerleaveform[' + form_row + '][chk5][]"  />便祕&nbsp;<input type="checkbox"  value="血便" name="customerleaveform[' + form_row + '][chk5][]"  /> 血便&nbsp;<input type="checkbox"  value="灰白便" name="customerleaveform[' + form_row + '][chk5][]"  /> 灰白便</div>';
		html += '					';
		html += '					<div>小便：<input type="checkbox"  value="少尿" name="customerleaveform[' + form_row + '][chk6]"  /> 少尿&nbsp;<input type="checkbox"  value="血尿" name="customerleaveform[' + form_row + '][chk6]"  /> 血尿&nbsp;<input type="checkbox"  value="尿酸結晶" name="customerleaveform[' + form_row + '][chk6]"  /> 尿酸結晶</div>';
		html += '					';
		html += '					<div>餵食：<input type="checkbox"  value="頻繁溢奶" name="customerleaveform[' + form_row + '][chk7]"  /> 頻繁溢奶&nbsp;<input type="checkbox"  value="噴射性吐奶" name="customerleaveform[' + form_row + '][chk7]"  /> 噴射性吐奶</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			 <tr>';
		html += '				<td class="center">皮膚</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup2" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup2">  ';
		html += '					<div>紅疹：<input type="checkbox"  value="臉部" name="customerleaveform[' + form_row + '][chk8][]"  /> 臉部&nbsp;<input type="checkbox"  value="頸部" name="customerleaveform[' + form_row + '][chk8][]"  /> 頸部&nbsp;<input type="checkbox"  value="身體" name="customerleaveform[' + form_row + '][chk8][]"  /> 身體&nbsp;<input type="checkbox"  value="四肢" name="customerleaveform[' + form_row + '][chk8][]"  /> 四肢&nbsp;<input type="checkbox"  value="脂漏性皮膚炎" name="customerleaveform[' + form_row + '][chk8][]"  /> 脂漏性皮膚炎&nbsp;<input type="checkbox"  value="毒性紅斑" name="customerleaveform[' + form_row + '][chk8][]"  /> 毒性紅斑</div>';
		html += '					';
		html += '					<div>血管瘤：<input type="checkbox"  value="額頭雙眉間" name="customerleaveform[' + form_row + '][chk9][]"  /> 額頭雙眉間&nbsp;<input type="checkbox"  value="左上眼瞼" name="customerleaveform[' + form_row + '][chk9][]"  /> 左上眼瞼&nbsp;<input type="checkbox"  value="右上眼瞼" name="customerleaveform[' + form_row + '][chk9][]"  /> 右上眼瞼&nbsp;<input type="checkbox"  value="頸背髮際處" name="customerleaveform[' + form_row + '][chk9][]"  /> 頸背髮際處</div>';
		html += '										';
		html += '					<div>其他：<input type="checkbox"  value="臉部皮下瘀血" name="customerleaveform[' + form_row + '][chk10]"  /> 臉部皮下瘀血</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '                <td class="center">眼</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup3" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup3">  ';
		html += '					<div>結膜炎：<input type="checkbox"  value="左眼" name="customerleaveform[' + form_row + '][chk11][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="customerleaveform[' + form_row + '][chk11][]"  /> 右眼</div>';
		html += '					';
		html += '					<div>血管瘤：<input type="checkbox"  value="左眼" name="customerleaveform[' + form_row + '][chk12][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="customerleaveform[' + form_row + '][chk12][]"  /> 右眼</div>';
		html += '										';
		html += '					<div>鼻淚管阻塞：<input type="checkbox"  value="左眼" name="customerleaveform[' + form_row + '][chk13][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="customerleaveform[' + form_row + '][chk13][]"  /> 右眼</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">耳</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup4" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup4">  ';
		html += '					<div>耳前息肉：<input type="checkbox"  value="左耳" name="customerleaveform[' + form_row + '][chk14][]" /> 左耳&nbsp;<input type="checkbox"  value="右耳" name="customerleaveform[' + form_row + '][chk14][]" /> 右耳&nbsp;<input type="checkbox"  value="耳前小竇" name="customerleaveform[' + form_row + '][chk14][]"  /> 耳前小竇</div>';
		html += '					';
		html += '					<div>耳道異常分泌物：<input type="checkbox"  value="左耳" name="customerleaveform[' + form_row + '][chk15][]"  /> 左耳&nbsp;<input type="checkbox"  value="右耳" name="customerleaveform[' + form_row + '][chk15][]"  /> 右耳</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">口腔</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup5" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup5">  ';
		html += '					<div><input type="checkbox"  value="鵝口瘡" name="customerleaveform[' + form_row + '][chk16][]" /> 鵝口瘡&nbsp;<input type="checkbox"  value="唇裂" name="customerleaveform[' + form_row + '][chk16][]" /> 唇裂&nbsp;<input type="checkbox"  value="顎裂" name="customerleaveform[' + form_row + '][chk16][]" /> 顎裂&nbsp;<input type="checkbox"  value="舌繫帶過短" name="customerleaveform[' + form_row + '][chk16][]" /> 舌繫帶過短</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">鼻咽喉部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup6" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup6">  ';
		html += '					<div><input type="checkbox"  value="上呼吸道感染" name="customerleaveform[' + form_row + '][chk17][]" /> 上呼吸道感染&nbsp;<input type="checkbox"  value="鼻塞" name="customerleaveform[' + form_row + '][chk17][]"  /> 鼻塞&nbsp;<input type="checkbox"  value="流鼻水" name="customerleaveform[' + form_row + '][chk17][]"  /> 流鼻水&nbsp;<input type="checkbox"  value="咳嗽" name="customerleaveform[' + form_row + '][chk17][]"  /> 咳嗽</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">喉</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup7" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup7">  ';
		html += '					<div><input type="checkbox"  value="呼吸雜音" name="customerleaveform[' + form_row + '][chk18][]" /> 呼吸雜音&nbsp;<input type="checkbox"  value="喉頭軟化" name="customerleaveform[' + form_row + '][chk18][]" /> 喉頭軟化</div>';
		html += '				</td>';
		html += '              </tr>			  ';
		html += '			  <tr>';
		html += '                <td class="center">頭頸部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup8" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup8">  ';
		html += '					<div>頭部：<input type="checkbox"  value="左側頭皮血腫" name="customerleaveform[' + form_row + '][chk19][]" /> 左側頭皮血腫&nbsp;<input type="checkbox"  value="右側頭皮血腫" name="customerleaveform[' + form_row + '][chk19][]" /> 右側頭皮血腫&nbsp;<input type="checkbox"  value="帽狀腱膜下出血" name="customerleaveform[' + form_row + '][chk19][]" /> 帽狀腱膜下出血&nbsp;<input type="checkbox"  value="產瘤" name="customerleaveform[' + form_row + '][chk19][]" /> 產瘤</div>';
		html += '					';
		html += '					<div>斜頸：<input type="checkbox"  value="左斜頸" name="customerleaveform[' + form_row + '][chk20]" /> 左斜頸&nbsp;<input type="checkbox"  value="右斜頸" name="customerleaveform[' + form_row + '][chk20]" /> 右斜頸</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">胸腔</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup9" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup9">  ';
		html += '					<div><input type="checkbox"  value="乳房肥大" name="customerleaveform[' + form_row + '][chk21][]" /> 乳房肥大&nbsp;<input type="checkbox"  value="乳頭分泌物" name="customerleaveform[' + form_row + '][chk21][]" /> 乳頭分泌物&nbsp;<input type="checkbox"  value="漏斗胸" name="customerleaveform[' + form_row + '][chk21][]" /> 漏斗胸&nbsp;<input type="checkbox"  value="雞胸" name="customerleaveform[' + form_row + '][chk21][]" /> 雞胸</div>';
		html += '				</td>';
		html += '              </tr>			  ';
		html += '			  <tr>';
		html += '                <td class="center">心</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup10" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup10">  ';
		html += '					<div><input type="checkbox"  value="心律不整" name="customerleaveform[' + form_row + '][chk22][]" /> 心律不整&nbsp;<input type="checkbox"  value="心雜音" name="customerleaveform[' + form_row + '][chk22][]" /> 心雜音</div>';
		html += '				</td>';
		html += '              </tr>						  ';
		html += '			  <tr>';
		html += '                <td class="center">肺</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup11" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup11">  ';
		html += '					<div>呼吸音：<input type="checkbox"  value="喘鳴" name="customerleaveform[' + form_row + '][chk23][]" /> 喘鳴&nbsp;<input type="checkbox"  value="囉音" name="customerleaveform[' + form_row + '][chk23][]"  /> 囉音&nbsp;&nbsp;<input type="checkbox"  value="肋凹" name="customerleaveform[' + form_row + '][chk23][]" /> 肋凹</div>';
		html += '				</td>';
		html += '              </tr>			';
		html += '			  <tr>';
		html += '                <td class="center">腹部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup12" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup12">  ';
		html += '					<div>腹部：<input type="checkbox"  value="腹脹" name="customerleaveform[' + form_row + '][chk24]"  /> 腹脹</div>';
		html += '					';
		html += '					<div>腸蠕動聲：<input type="checkbox"  value="蠕動過快" name="customerleaveform[' + form_row + '][chk25]"  /> 蠕動過快&nbsp;<input type="checkbox"  value="蠕動過慢" name="customerleaveform[' + form_row + '][chk25]"  /> 蠕動過慢</div>';
		html += '					';
		html += '					<div>肚臍：<input type="checkbox"  value="臍周圍紅腫" name="customerleaveform[' + form_row + '][chk26][]" /> 臍周圍紅腫&nbsp;<input type="checkbox"  value="臍瘜肉" name="customerleaveform[' + form_row + '][chk26][]"  /> 臍瘜肉&nbsp;<input type="checkbox"  value="分泌物異味" name="customerleaveform[' + form_row + '][chk26][]"  /> 分泌物異味&nbsp;<input type="checkbox"  value="臍疝氣" name="customerleaveform[' + form_row + '][chk26][]"  /> 臍疝氣</div>';
		html += '				</td>';
		html += '              </tr>				  ';
		html += '			  <tr>';
		html += '                <td class="center">四肢</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup13" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup13">  ';
		html += '					<div>上肢：<input type="checkbox"  value="無力" name="customerleaveform[' + form_row + '][chk27][]" /> 無力&nbsp;<input type="checkbox"  value="僵直" name="customerleaveform[' + form_row + '][chk27][]" /> 僵直&nbsp;<input type="checkbox"  value="爪狀手" name="customerleaveform[' + form_row + '][chk27][]" /> 爪狀手</div>';
		html += '					';
		html += '					<div>下肢：<input type="checkbox"  value="無力" name="customerleaveform[' + form_row + '][chk28][]" /> 無力&nbsp;<input type="checkbox"  value="僵直" name="customerleaveform[' + form_row + '][chk28][]" /> 僵直&nbsp;<input type="checkbox"  value="足內翻" name="customerleaveform[' + form_row + '][chk28][]" /> 足內翻&nbsp;<input type="checkbox"  value="足外翻" name="customerleaveform[' + form_row + '][chk28][]" /> 足外翻&nbsp;<input type="checkbox"  value="髖關節發育不全" name="customerleaveform[' + form_row + '][chk28][]" /> 髖關節發育不全</div>';
		html += '										';
		html += '					<div>鎖骨：<input type="checkbox"  value="左邊骨折" name="customerleaveform[' + form_row + '][chk29][]" /> 左邊骨折&nbsp;<input type="checkbox"  value="右邊骨折" name="customerleaveform[' + form_row + '][chk29][]" /> 右邊骨折</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">生殖器</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup14" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup14">  ';
		html += '				<?php if ($child_gender == '男') { ?>';
		html += '					<div>男：<input type="checkbox"  value="尿道下裂" name="customerleaveform[' + form_row + '][chk30][]"  /> 尿道下裂&nbsp;<input type="checkbox"  value="割包皮手術" name="customerleaveform[' + form_row + '][chk30][]" /> 割包皮手術</div>';
		html += '					';
		html += '					<div>疝氣：<input type="checkbox"  value="左邊" name="customerleaveform[' + form_row + '][chk31][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="customerleaveform[' + form_row + '][chk31][]" /> 右邊</div>';
		html += '					';
		html += '					<div>隱睪症：<input type="checkbox"  value="左邊" name="customerleaveform[' + form_row + '][chk32][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="customerleaveform[' + form_row + '][chk32][]" /> 右邊</div>';
		html += '					';
		html += '					<div>陰囊水腫：<input type="checkbox"  value="左邊" name="customerleaveform[' + form_row + '][chk33][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="customerleaveform[' + form_row + '][chk33][]" /> 右邊</div>';
		html += '				<?php } elseif ($child_gender == '女') { ?>';
		html += '					<div>女：<input type="checkbox"  value="假性月經" name="customerleaveform[' + form_row + '][chk30][]" /> 假性月經&nbsp;<input type="checkbox"  value="分泌物" name="customerleaveform[' + form_row + '][chk30][]" /> 分泌物</div>';
		html += '										';
		html += '					<div>疝氣：<input type="checkbox"  value="左邊" name="customerleaveform[' + form_row + '][chk31][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="customerleaveform[' + form_row + '][chk31][]" /> 右邊</div>';
		html += '					';
		html += '					<div>腹股溝：<input type="checkbox"  value="念珠菌感染" name="customerleaveform[' + form_row + '][chk34][]" /> 念珠菌感染&nbsp;<input type="checkbox"  value="紅疹" name="customerleaveform[' + form_row + '][chk34][]" /> 紅疹</div>';
		html += '				<?php } ?>';
		html += '				</td>';
		html += '              </tr>';
		html += '			 <tr>';
		html += '				<td class="center">臀部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup15" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup15">  ';
		html += '					<div>紅臀：<input type="checkbox"  value="輕" name="customerleaveform[' + form_row + '][chk35]" /> 輕&nbsp;<input type="checkbox"  value="中度" name="customerleaveform[' + form_row + '][chk35]" /> 中度&nbsp;<input type="checkbox"  value="重度" name="customerleaveform[' + form_row + '][chk35]" /> 重度</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			  <tr>';
		html += '				<td class="center">其他</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup16" name="customerleaveform[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup16"><textarea name="customerleaveform[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
		html += '			  </tr>';
		html += '          </table>';
		
		

		html += '		<div class="inner-footing">';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>';
		html += '	</form>';	
		html += '</div>';

	
	$('#tab-customerleave').append(html);
	
	/*
	if (tabid) {
			$('#tab-customerleaveform-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=days_livein]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk24]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk25]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk26]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk27a]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk27b]').val($('#tab-customerleaveform-'+ tabid + ' input[name*=chk27b]').val());
			<?php for ($i=1; $i<=23; $i++) { ?>
			$('#tab-customerleaveform-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-customerleaveform-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-customerleaveform-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-customerleaveform-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-customerleaveform-'+ form_row + ' [name*=supplement]').text($('#tab-customerleaveform-'+ tabid + ' [name*=supplement]').val());
	}
	*/
	
	$('.backlist').show();
	
	$('#childdoctor2-add').before('<a href="#tab-customerleaveform-' + form_row + '" id="customerleaveform-' + form_row + '"><?php echo $tab_customerleaveform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#customerleaveform-' + form_row + '\').remove(); $(\'#tab-customerleaveform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#customerleaveform-' + form_row).trigger('click');
	
	form_row++;
}
function savenew(form_row) {
	$('.success, .warning').remove();
	$('.content').hide();
	$('.bklst').hide();
	$('.prtbtn').hide();
	$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 保存中...</h2></center></div>');
	$('#form-'+form_row).submit();
}
//--></script> 
<script type='text/javascript'><!--
	$(document).ready(function() {	
<?php if (isset($this->request->get['tab_id']) && $this->request->get['tab_id']<> '1') { ?>
	$('#vtabs a[id=\'customerleaveform-<?php echo $this->request->get['tab_id']; ?>\']').trigger('click');
<?php } ?>
		/*
		$('.backlist').click(function() {
			$('#vtabs a:first').trigger('click');
			$('.backlist').hide();
			return false;
		});
		$('[id^=customerleaveform]').click(function() {
			$('.backlist').show();
		});
		*/
		$('form').submit(function() {
			$('.success, .warning').remove();
			$('.content').hide();
			$('.bklst').hide();
			$('.prtbtn').hide();
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
$('.colorbox').colorbox({
	width: 800,
	height: 600
});
//--></script> 

<?php echo $footer; ?>