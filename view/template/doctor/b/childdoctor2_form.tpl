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
      <div id="tabs" class="htabs"><a href="#tab-childdoctor2"><?php echo $tab_childdoctor2; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>

        <div id="tab-childdoctor2">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-childdoctor2list"><?php echo $tab_childdoctor2; ?></a>
		   <span id="childdoctor2-add"><?php echo $button_add_childdoctor2; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addChildDoctor2();" /></span>
		  
			<?php if (count($childdoctor2forms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($childdoctor2forms as $childdoctor2form) { ?>
            <a title="<?php echo $childdoctor2form['date_added']; ?>" alt="<?php echo $childdoctor2form['date_added']; ?>" href="#tab-childdoctor2form-<?php echo $form_row; ?>" id="childdoctor2form-<?php echo $form_row; ?>"><?php echo $tab_childdoctor2form . ' ' . $form_row; ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delChildDoctor2(<?php echo $childdoctor2form['customer_child_doctor2_id']; ?>, <?php echo $form_row; ?>);" /></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($childdoctor2forms) > 12) { ?>
			</div>
			<?php } ?>
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-childdoctor2list" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($childdoctor2forms as $childdoctor2form) { ?>
		<div id="tab-childdoctor2form-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $childdoctor2form['date_added']; ?> <?php echo $tab_childdoctor2form; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="childdoctor2form[<?php echo $form_row; ?>][customer_child_doctor2_id]" value="<?php echo $childdoctor2form['customer_child_doctor2_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">實施日期</td>
				<td width="35%"><input type="text" name="childdoctor2form[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  (($childdoctor2form['date_added']=='') ? date('Y-m-d') : $childdoctor2form['date_added'] );?>" size="12" /></td>
                <td>醫師</td>
                <td><select name="childdoctor2form[<?php echo $form_row; ?>][doctor_id]">
                    <?php foreach ($doctors as $doctor) { ?>
                    <?php if ($doctor['user_id'] == $childdoctor2form['doctor_id']) { ?>
                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
		  </table>
		  
		  <table class="list form">
			<thead>
			  <tr>
                <td class="center" width="100px">項目</td>
				<td class="center">正常</td>
				<td class="center">異常狀況</td>
			 </tr>
			</thead>
			 <tr>
				<td class="center">一般表現</td>
				<?php $gck = (!empty($childdoctor2form['groupchk']))? unserialize($childdoctor2form['groupchk']) : array(); ?>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup1" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="一般表現" <?php echo (!empty($gck) && in_array("一般表現", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup1">
					<div>活動力：<input type="checkbox"  value="軟弱伸展" name="childdoctor2form[<?php echo $form_row; ?>][chk1]"  <?php echo ($childdoctor2form['chk1']=="軟弱伸展")? "checked":""; ?>/> 軟弱伸展</div>
					
					<div>膚色：<input type="checkbox"  value="微黃" name="childdoctor2form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor2form['chk2']=="微黃")? "checked":""; ?>/> 微黃&nbsp;<input type="checkbox"  value="偏黃" name="childdoctor2form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor2form['chk2']=="偏黃")? "checked":""; ?>/> 偏黃&nbsp;<input type="checkbox"  value="蒼白" name="childdoctor2form[<?php echo $form_row; ?>][chk2]"  <?php echo ($childdoctor2form['chk2']=="蒼白")? "checked":""; ?>/> 蒼白</div>
					
					<div>體溫：<input type="checkbox"  value="體溫過高" name="childdoctor2form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor2form['chk3']=="體溫過高")? "checked":""; ?>/> 體溫過高&nbsp;<input type="checkbox"  value="體溫過低" name="childdoctor2form[<?php echo $form_row; ?>][chk3]"  <?php echo ($childdoctor2form['chk3']=="體溫過低")? "checked":""; ?>/> 體溫過低</div>
					
					<?php $c4 = (!empty($childdoctor2form['chk4']))? unserialize($childdoctor2form['chk4']) : array(); ?>
					<div>體重：<input type="checkbox"  value="體重增加緩慢" name="childdoctor2form[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("體重增加緩慢", $c4 ))? "checked":""; ?>/> 體重增加緩慢&nbsp;<input type="checkbox"  value="體重過低" name="childdoctor2form[<?php echo $form_row; ?>][chk4][]"  <?php echo (!empty($c4) && in_array("體重過低", $c4 ))? "checked":""; ?>/> 體重過低</div>
					
					<?php $c5 = (!empty($childdoctor2form['chk5']))? unserialize($childdoctor2form['chk5']) : array(); ?>
					<div>大便：<input type="checkbox"  value="腹瀉" name="childdoctor2form[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("腹瀉", $c5 ))? "checked":""; ?>/> 腹瀉&nbsp;<input type="checkbox"  value="便祕" name="childdoctor2form[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("便祕", $c5 ))? "checked":""; ?>/>便祕&nbsp;<input type="checkbox"  value="血便" name="childdoctor2form[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("血便", $c5 ))? "checked":""; ?>/> 血便&nbsp;<input type="checkbox"  value="灰白便" name="childdoctor2form[<?php echo $form_row; ?>][chk5][]"  <?php echo (!empty($c5) && in_array("灰白便", $c5 ))? "checked":""; ?>/> 灰白便</div>
					
					<div>小便：<input type="checkbox"  value="少尿" name="childdoctor2form[<?php echo $form_row; ?>][chk6]"  <?php echo ($childdoctor2form['chk6']=="少尿")? "checked":""; ?>/> 少尿&nbsp;<input type="checkbox"  value="血尿" name="childdoctor2form[<?php echo $form_row; ?>][chk6]"  <?php echo ($childdoctor2form['chk6']=="血尿")? "checked":""; ?>/> 血尿&nbsp;<input type="checkbox"  value="尿酸結晶" name="childdoctor2form[<?php echo $form_row; ?>][chk6]"  <?php echo ($childdoctor2form['chk6']=="尿酸結晶")? "checked":""; ?>/> 尿酸結晶</div>
					
					<div>餵食：<input type="checkbox"  value="頻繁溢奶" name="childdoctor2form[<?php echo $form_row; ?>][chk7]"  <?php echo ($childdoctor2form['chk7']=="頻繁溢奶")? "checked":""; ?>/> 頻繁溢奶&nbsp;<input type="checkbox"  value="噴射性吐奶" name="childdoctor2form[<?php echo $form_row; ?>][chk7]"  <?php echo ($childdoctor2form['chk7']=="噴射性吐奶")? "checked":""; ?>/> 噴射性吐奶</div>
				</td>
			</tr>
			 <tr>
				<td class="center">皮膚</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup2" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="皮膚" <?php echo (!empty($gck) && in_array("皮膚", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup2">  
					<?php $c8 = (!empty($childdoctor2form['chk8']))? unserialize($childdoctor2form['chk8']) : array(); ?>
					<div>紅疹：<input type="checkbox"  value="臉部" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("臉部", $c8 ))? "checked":""; ?>/> 臉部&nbsp;<input type="checkbox"  value="頸部" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("頸部", $c8 ))? "checked":""; ?>/> 頸部&nbsp;<input type="checkbox"  value="身體" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("身體", $c8 ))? "checked":""; ?>/> 身體&nbsp;<input type="checkbox"  value="四肢" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("四肢", $c8 ))? "checked":""; ?>/> 四肢&nbsp;<input type="checkbox"  value="脂漏性皮膚炎" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("脂漏性皮膚炎", $c8 ))? "checked":""; ?>/> 脂漏性皮膚炎&nbsp;<input type="checkbox"  value="毒性紅斑" name="childdoctor2form[<?php echo $form_row; ?>][chk8][]"  <?php echo (!empty($c8) && in_array("毒性紅斑", $c8 ))? "checked":""; ?>/> 毒性紅斑</div>
					
					<?php $c9 = (!empty($childdoctor2form['chk9']))? unserialize($childdoctor2form['chk9']) : array(); ?>
					<div>血管瘤：<input type="checkbox"  value="額頭雙眉間" name="childdoctor2form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("額頭雙眉間", $c9 ))? "checked":""; ?>/> 額頭雙眉間&nbsp;<input type="checkbox"  value="左上眼瞼" name="childdoctor2form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("左上眼瞼", $c9 ))? "checked":""; ?>/> 左上眼瞼&nbsp;<input type="checkbox"  value="右上眼瞼" name="childdoctor2form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("右上眼瞼", $c9 ))? "checked":""; ?>/> 右上眼瞼&nbsp;<input type="checkbox"  value="頸背髮際處" name="childdoctor2form[<?php echo $form_row; ?>][chk9][]"  <?php echo (!empty($c9) && in_array("頸背髮際處", $c9 ))? "checked":""; ?>/> 頸背髮際處</div>
										
					<div>其他：<input type="checkbox"  value="臉部皮下瘀血" name="childdoctor2form[<?php echo $form_row; ?>][chk10]"  <?php echo ($childdoctor2form['chk10']=="臉部皮下瘀血")? "checked":""; ?>/> 臉部皮下瘀血</div>
				</td>
			</tr>
			<tr>
                <td class="center">眼</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup3" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="眼" <?php echo (!empty($gck) && in_array("眼", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup3">  
					<?php $c11 = (!empty($childdoctor2form['chk11']))? unserialize($childdoctor2form['chk11']) : array(); ?>
					<div>結膜炎：<input type="checkbox"  value="左眼" name="childdoctor2form[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("左眼", $c11 ))? "checked":""; ?>/> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[<?php echo $form_row; ?>][chk11][]"  <?php echo (!empty($c11) && in_array("右眼", $c11 ))? "checked":""; ?>/> 右眼</div>
					
					<?php $c12 = (!empty($childdoctor2form['chk12']))? unserialize($childdoctor2form['chk12']) : array(); ?>
					<div>血管瘤：<input type="checkbox"  value="左眼" name="childdoctor2form[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("左眼", $c12 ))? "checked":""; ?>/> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[<?php echo $form_row; ?>][chk12][]"  <?php echo (!empty($c12) && in_array("右眼", $c12 ))? "checked":""; ?>/> 右眼</div>
										
					<?php $c13 = (!empty($childdoctor2form['chk13']))? unserialize($childdoctor2form['chk13']) : array(); ?>
					<div>鼻淚管阻塞：<input type="checkbox"  value="左眼" name="childdoctor2form[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("左眼", $c13 ))? "checked":""; ?>/> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[<?php echo $form_row; ?>][chk13][]"  <?php echo (!empty($c13) && in_array("右眼", $c13 ))? "checked":""; ?>/> 右眼</div>
				</td>
              </tr>
			  <tr>
                <td class="center">耳</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup4" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="耳" <?php echo (!empty($gck) && in_array("耳", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup4">  
					<?php $c14 = (!empty($childdoctor2form['chk14']))? unserialize($childdoctor2form['chk14']) : array(); ?>
					<div>耳前息肉：<input type="checkbox"  value="左耳" name="childdoctor2form[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("左耳", $c14 ))? "checked":""; ?>/> 左耳&nbsp;<input type="checkbox"  value="右耳" name="childdoctor2form[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("右耳", $c14 ))? "checked":""; ?>/> 右耳&nbsp;<input type="checkbox"  value="耳前小竇" name="childdoctor2form[<?php echo $form_row; ?>][chk14][]"  <?php echo (!empty($c14) && in_array("耳前小竇", $c14 ))? "checked":""; ?>/> 耳前小竇</div>
					
					<?php $c15 = (!empty($childdoctor2form['chk15']))? unserialize($childdoctor2form['chk15']) : array(); ?>
					<div>耳道異常分泌物：<input type="checkbox"  value="左耳" name="childdoctor2form[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("左耳", $c15 ))? "checked":""; ?>/> 左耳&nbsp;<input type="checkbox"  value="右耳" name="childdoctor2form[<?php echo $form_row; ?>][chk15][]"  <?php echo (!empty($c15) && in_array("右耳", $c15 ))? "checked":""; ?>/> 右耳</div>
				</td>
              </tr>
			  <tr>
                <td class="center">口腔</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup5" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="口腔" <?php echo (!empty($gck) && in_array("口腔", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup5">  
					<?php $c16 = (!empty($childdoctor2form['chk16']))? unserialize($childdoctor2form['chk16']) : array(); ?>
					<div><input type="checkbox"  value="鵝口瘡" name="childdoctor2form[<?php echo $form_row; ?>][chk16][]"  <?php echo (!empty($c16) && in_array("鵝口瘡", $c16 ))? "checked":""; ?>/> 鵝口瘡&nbsp;<input type="checkbox"  value="唇裂" name="childdoctor2form[<?php echo $form_row; ?>][chk16][]"  <?php echo (!empty($c16) && in_array("唇裂", $c16 ))? "checked":""; ?>/> 唇裂&nbsp;<input type="checkbox"  value="顎裂" name="childdoctor2form[<?php echo $form_row; ?>][chk16][]"  <?php echo (!empty($c16) && in_array("顎裂", $c16 ))? "checked":""; ?>/> 顎裂&nbsp;<input type="checkbox"  value="舌繫帶過短" name="childdoctor2form[<?php echo $form_row; ?>][chk16][]"  <?php echo (!empty($c16) && in_array("舌繫帶過短", $c16 ))? "checked":""; ?>/> 舌繫帶過短</div>
				</td>
              </tr>
			  <tr>
                <td class="center">鼻咽喉部</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup6" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="鼻咽喉部" <?php echo (!empty($gck) && in_array("鼻咽喉部", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup6">  
					<?php $c17 = (!empty($childdoctor2form['chk17']))? unserialize($childdoctor2form['chk17']) : array(); ?>
					<div><input type="checkbox"  value="上呼吸道感染" name="childdoctor2form[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("上呼吸道感染", $c17 ))? "checked":""; ?>/> 上呼吸道感染&nbsp;<input type="checkbox"  value="鼻塞" name="childdoctor2form[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("鼻塞", $c17 ))? "checked":""; ?>/> 鼻塞&nbsp;<input type="checkbox"  value="流鼻水" name="childdoctor2form[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("流鼻水", $c17 ))? "checked":""; ?>/> 流鼻水&nbsp;<input type="checkbox"  value="咳嗽" name="childdoctor2form[<?php echo $form_row; ?>][chk17][]"  <?php echo (!empty($c17) && in_array("咳嗽", $c17 ))? "checked":""; ?>/> 咳嗽</div>
				</td>
              </tr>
			  <tr>
                <td class="center">喉</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup7" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="喉" <?php echo (!empty($gck) && in_array("喉", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup7">  
					<?php $c18 = (!empty($childdoctor2form['chk18']))? unserialize($childdoctor2form['chk18']) : array(); ?>
					<div><input type="checkbox"  value="呼吸雜音" name="childdoctor2form[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("呼吸雜音", $c18 ))? "checked":""; ?>/> 呼吸雜音&nbsp;<input type="checkbox"  value="喉頭軟化" name="childdoctor2form[<?php echo $form_row; ?>][chk18][]"  <?php echo (!empty($c18) && in_array("喉頭軟化", $c18 ))? "checked":""; ?>/> 喉頭軟化</div>
				</td>
              </tr>			  
			  <tr>
                <td class="center">頭頸部</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup8" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="頭頸部" <?php echo (!empty($gck) && in_array("頭頸部", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup8">  
					<?php $c19 = (!empty($childdoctor2form['chk19']))? unserialize($childdoctor2form['chk19']) : array(); ?>
					<div>頭部：<input type="checkbox"  value="左側頭皮血腫" name="childdoctor2form[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("左側頭皮血腫", $c19 ))? "checked":""; ?>/> 左側頭皮血腫&nbsp;<input type="checkbox"  value="右側頭皮血腫" name="childdoctor2form[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("右側頭皮血腫", $c19 ))? "checked":""; ?>/> 右側頭皮血腫&nbsp;<input type="checkbox"  value="帽狀腱膜下出血" name="childdoctor2form[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("帽狀腱膜下出血", $c19 ))? "checked":""; ?>/> 帽狀腱膜下出血&nbsp;<input type="checkbox"  value="產瘤" name="childdoctor2form[<?php echo $form_row; ?>][chk19][]"  <?php echo (!empty($c19) && in_array("產瘤", $c19 ))? "checked":""; ?>/> 產瘤</div>
					
					<div>斜頸：<input type="checkbox"  value="左斜頸" name="childdoctor2form[<?php echo $form_row; ?>][chk20]"  <?php echo ($childdoctor2form['chk20']=="左斜頸")? "checked":""; ?>/> 左斜頸&nbsp;<input type="checkbox"  value="右斜頸" name="childdoctor2form[<?php echo $form_row; ?>][chk20]"  <?php echo ($childdoctor2form['chk20']=="右斜頸")? "checked":""; ?>/> 右斜頸</div>
				</td>
              </tr>
			  <tr>
                <td class="center">胸腔</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup9" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="胸腔" <?php echo (!empty($gck) && in_array("胸腔", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup9">  
					<?php $c21 = (!empty($childdoctor2form['chk21']))? unserialize($childdoctor2form['chk21']) : array(); ?>
					<div><input type="checkbox"  value="乳房肥大" name="childdoctor2form[<?php echo $form_row; ?>][chk21][]"  <?php echo (!empty($c21) && in_array("乳房肥大", $c21 ))? "checked":""; ?>/> 乳房肥大&nbsp;<input type="checkbox"  value="乳頭分泌物" name="childdoctor2form[<?php echo $form_row; ?>][chk21][]"  <?php echo (!empty($c21) && in_array("乳頭分泌物", $c21 ))? "checked":""; ?>/> 乳頭分泌物&nbsp;<input type="checkbox"  value="漏斗胸" name="childdoctor2form[<?php echo $form_row; ?>][chk21][]"  <?php echo (!empty($c21) && in_array("漏斗胸", $c21 ))? "checked":""; ?>/> 漏斗胸&nbsp;<input type="checkbox"  value="雞胸" name="childdoctor2form[<?php echo $form_row; ?>][chk21][]"  <?php echo (!empty($c21) && in_array("雞胸", $c21 ))? "checked":""; ?>/> 雞胸</div>
				</td>
              </tr>			  
			  <tr>
                <td class="center">心</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup10" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="心" <?php echo (!empty($gck) && in_array("心", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup10">  
					<?php $c22 = (!empty($childdoctor2form['chk22']))? unserialize($childdoctor2form['chk22']) : array(); ?>
					<div><input type="checkbox"  value="心律不整" name="childdoctor2form[<?php echo $form_row; ?>][chk22][]"  <?php echo (!empty($c22) && in_array("心律不整", $c22 ))? "checked":""; ?>/> 心律不整&nbsp;<input type="checkbox"  value="心雜音" name="childdoctor2form[<?php echo $form_row; ?>][chk22][]"  <?php echo (!empty($c22) && in_array("心雜音", $c22 ))? "checked":""; ?>/> 心雜音</div>
				</td>
              </tr>						  
			  <tr>
                <td class="center">肺</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup11" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="肺" <?php echo (!empty($gck) && in_array("肺", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup11">  
					<?php $c23 = (!empty($childdoctor2form['chk23']))? unserialize($childdoctor2form['chk23']) : array(); ?>
					<div>呼吸音：<input type="checkbox"  value="喘鳴" name="childdoctor2form[<?php echo $form_row; ?>][chk23][]"  <?php echo (!empty($c23) && in_array("喘鳴", $c23 ))? "checked":""; ?>/> 喘鳴&nbsp;<input type="checkbox"  value="囉音" name="childdoctor2form[<?php echo $form_row; ?>][chk23][]"  <?php echo (!empty($c23) && in_array("囉音", $c23 ))? "checked":""; ?>/> 囉音&nbsp;&nbsp;<input type="checkbox"  value="肋凹" name="childdoctor2form[<?php echo $form_row; ?>][chk23][]"  <?php echo (!empty($c23) && in_array("肋凹", $c23 ))? "checked":""; ?>/> 肋凹</div>
				</td>
              </tr>			
			  <tr>
                <td class="center">腹部</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup12" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="腹部" <?php echo (!empty($gck) && in_array("腹部", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup12">  
					<div>腹部：<input type="checkbox"  value="腹脹" name="childdoctor2form[<?php echo $form_row; ?>][chk24]"  <?php echo ($childdoctor2form['chk24']=="腹脹")? "checked":""; ?>/> 腹脹</div>
					
					<div>腸蠕動聲：<input type="checkbox"  value="蠕動過快" name="childdoctor2form[<?php echo $form_row; ?>][chk25]"  <?php echo ($childdoctor2form['chk25']=="蠕動過快")? "checked":""; ?>/> 蠕動過快&nbsp;<input type="checkbox"  value="蠕動過慢" name="childdoctor2form[<?php echo $form_row; ?>][chk25]"  <?php echo ($childdoctor2form['chk25']=="蠕動過慢")? "checked":""; ?>/> 蠕動過慢</div>
					
					<?php $c26 = (!empty($childdoctor2form['chk26']))? unserialize($childdoctor2form['chk26']) : array(); ?>
					<div>肚臍：<input type="checkbox"  value="臍周圍紅腫" name="childdoctor2form[<?php echo $form_row; ?>][chk26][]"  <?php echo (!empty($c26) && in_array("臍周圍紅腫", $c26 ))? "checked":""; ?>/> 臍周圍紅腫&nbsp;<input type="checkbox"  value="臍瘜肉" name="childdoctor2form[<?php echo $form_row; ?>][chk26][]"  <?php echo (!empty($c26) && in_array("臍瘜肉", $c26 ))? "checked":""; ?>/> 臍瘜肉&nbsp;<input type="checkbox"  value="分泌物異味" name="childdoctor2form[<?php echo $form_row; ?>][chk26][]"  <?php echo (!empty($c26) && in_array("分泌物異味", $c26 ))? "checked":""; ?>/> 分泌物異味&nbsp;<input type="checkbox"  value="臍疝氣" name="childdoctor2form[<?php echo $form_row; ?>][chk26][]"  <?php echo (!empty($c26) && in_array("臍疝氣", $c26 ))? "checked":""; ?>/> 臍疝氣</div>
				</td>
              </tr>				  
			  <tr>
                <td class="center">四肢</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup13" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="四肢" <?php echo (!empty($gck) && in_array("四肢", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup13">  
					<?php $c27 = (!empty($childdoctor2form['chk27']))? unserialize($childdoctor2form['chk27']) : array(); ?>
					<div>上肢：<input type="checkbox"  value="無力" name="childdoctor2form[<?php echo $form_row; ?>][chk27][]"  <?php echo (!empty($c27) && in_array("無力", $c27 ))? "checked":""; ?>/> 無力&nbsp;<input type="checkbox"  value="僵直" name="childdoctor2form[<?php echo $form_row; ?>][chk27][]"  <?php echo (!empty($c27) && in_array("僵直", $c27 ))? "checked":""; ?>/> 僵直&nbsp;<input type="checkbox"  value="爪狀手" name="childdoctor2form[<?php echo $form_row; ?>][chk27][]"  <?php echo (!empty($c27) && in_array("爪狀手", $c27 ))? "checked":""; ?>/> 爪狀手</div>
					
					<?php $c28 = (!empty($childdoctor2form['chk28']))? unserialize($childdoctor2form['chk28']) : array(); ?>
					<div>下肢：<input type="checkbox"  value="無力" name="childdoctor2form[<?php echo $form_row; ?>][chk28][]"  <?php echo (!empty($c28) && in_array("無力", $c28 ))? "checked":""; ?>/> 無力&nbsp;<input type="checkbox"  value="僵直" name="childdoctor2form[<?php echo $form_row; ?>][chk28][]"  <?php echo (!empty($c28) && in_array("僵直", $c28 ))? "checked":""; ?>/> 僵直&nbsp;<input type="checkbox"  value="足內翻" name="childdoctor2form[<?php echo $form_row; ?>][chk28][]"  <?php echo (!empty($c28) && in_array("足內翻", $c28 ))? "checked":""; ?>/> 足內翻&nbsp;<input type="checkbox"  value="足外翻" name="childdoctor2form[<?php echo $form_row; ?>][chk28][]"  <?php echo (!empty($c28) && in_array("足外翻", $c28 ))? "checked":""; ?>/> 足外翻&nbsp;<input type="checkbox"  value="髖關節發育不全" name="childdoctor2form[<?php echo $form_row; ?>][chk28][]"  <?php echo (!empty($c28) && in_array("髖關節發育不全", $c28 ))? "checked":""; ?>/> 髖關節發育不全</div>
										
					<?php $c29 = (!empty($childdoctor2form['chk29']))? unserialize($childdoctor2form['chk29']) : array(); ?>
					<div>鎖骨：<input type="checkbox"  value="左邊骨折" name="childdoctor2form[<?php echo $form_row; ?>][chk29][]"  <?php echo (!empty($c29) && in_array("左邊骨折", $c29 ))? "checked":""; ?>/> 左邊骨折&nbsp;<input type="checkbox"  value="右邊骨折" name="childdoctor2form[<?php echo $form_row; ?>][chk29][]"  <?php echo (!empty($c29) && in_array("右邊骨折", $c29 ))? "checked":""; ?>/> 右邊骨折</div>
				</td>
              </tr>
			  <tr>
                <td class="center">生殖器</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup14" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="生殖器" <?php echo (!empty($gck) && in_array("生殖器", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup14">  
				<?php if ($child_gender == '男') { ?>
					<?php $c30 = (!empty($childdoctor2form['chk30']))? unserialize($childdoctor2form['chk30']) : array(); ?>
					<div>男：<input type="checkbox"  value="尿道下裂" name="childdoctor2form[<?php echo $form_row; ?>][chk30][]"  <?php echo (!empty($c30) && in_array("尿道下裂", $c30 ))? "checked":""; ?>/> 尿道下裂&nbsp;<input type="checkbox"  value="割包皮手術" name="childdoctor2form[<?php echo $form_row; ?>][chk30][]"  <?php echo (!empty($c30) && in_array("割包皮手術", $c30 ))? "checked":""; ?>/> 割包皮手術</div>
					
					<?php $c31 = (!empty($childdoctor2form['chk31']))? unserialize($childdoctor2form['chk31']) : array(); ?>
					<div>疝氣：<input type="checkbox"  value="左邊" name="childdoctor2form[<?php echo $form_row; ?>][chk31][]"  <?php echo (!empty($c31) && in_array("左邊", $c31 ))? "checked":""; ?>/> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[<?php echo $form_row; ?>][chk31][]"  <?php echo (!empty($c31) && in_array("右邊", $c31 ))? "checked":""; ?>/> 右邊</div>
					
					<?php $c32 = (!empty($childdoctor2form['chk32']))? unserialize($childdoctor2form['chk32']) : array(); ?>
					<div>隱睪症：<input type="checkbox"  value="左邊" name="childdoctor2form[<?php echo $form_row; ?>][chk32][]"  <?php echo (!empty($c32) && in_array("左邊", $c32 ))? "checked":""; ?>/> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[<?php echo $form_row; ?>][chk32][]"  <?php echo (!empty($c32) && in_array("右邊", $c32 ))? "checked":""; ?>/> 右邊</div>
					
					<?php $c33 = (!empty($childdoctor2form['chk33']))? unserialize($childdoctor2form['chk33']) : array(); ?>
					<div>陰囊水腫：<input type="checkbox"  value="左邊" name="childdoctor2form[<?php echo $form_row; ?>][chk33][]"  <?php echo (!empty($c33) && in_array("左邊", $c33 ))? "checked":""; ?>/> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[<?php echo $form_row; ?>][chk33][]"  <?php echo (!empty($c33) && in_array("右邊", $c33 ))? "checked":""; ?>/> 右邊</div>
				<?php } elseif ($child_gender == '女') { ?>
					<?php $c30 = (!empty($childdoctor2form['chk30']))? unserialize($childdoctor2form['chk30']) : array(); ?>
					<div>女：<input type="checkbox"  value="假性月經" name="childdoctor2form[<?php echo $form_row; ?>][chk30][]"  <?php echo (!empty($c30) && in_array("假性月經", $c30 ))? "checked":""; ?>/> 假性月經&nbsp;<input type="checkbox"  value="分泌物" name="childdoctor2form[<?php echo $form_row; ?>][chk30][]"  <?php echo (!empty($c30) && in_array("分泌物", $c30 ))? "checked":""; ?>/> 分泌物</div>
										
					<?php $c31 = (!empty($childdoctor2form['chk31']))? unserialize($childdoctor2form['chk31']) : array(); ?>
					<div>疝氣：<input type="checkbox"  value="左邊" name="childdoctor2form[<?php echo $form_row; ?>][chk31][]"  <?php echo (!empty($c31) && in_array("左邊", $c31 ))? "checked":""; ?>/> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[<?php echo $form_row; ?>][chk31][]"  <?php echo (!empty($c31) && in_array("右邊", $c31 ))? "checked":""; ?>/> 右邊</div>
					
					<?php $c34 = (!empty($childdoctor2form['chk34']))? unserialize($childdoctor2form['chk34']) : array(); ?>
					<div>腹股溝：<input type="checkbox"  value="念珠菌感染" name="childdoctor2form[<?php echo $form_row; ?>][chk34][]"  <?php echo (!empty($c34) && in_array("念珠菌感染", $c34 ))? "checked":""; ?>/> 念珠菌感染&nbsp;<input type="checkbox"  value="紅疹" name="childdoctor2form[<?php echo $form_row; ?>][chk34][]"  <?php echo (!empty($c34) && in_array("紅疹", $c34 ))? "checked":""; ?>/> 紅疹</div>
				<?php } ?>
				</td>
              </tr>
			 <tr>
				<td class="center">臀部</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup15" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="臀部" <?php echo (!empty($gck) && in_array("臀部", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup15">  
					<div>紅臀：<input type="checkbox"  value="輕" name="childdoctor2form[<?php echo $form_row; ?>][chk35]"  <?php echo ($childdoctor2form['chk35']=="輕")? "checked":""; ?>/> 輕&nbsp;<input type="checkbox"  value="中度" name="childdoctor2form[<?php echo $form_row; ?>][chk35]"  <?php echo ($childdoctor2form['chk35']=="中度")? "checked":""; ?>/> 中度&nbsp;<input type="checkbox"  value="重度" name="childdoctor2form[<?php echo $form_row; ?>][chk35]"  <?php echo ($childdoctor2form['chk35']=="重度")? "checked":""; ?>/> 重度</div>
				</td>
			</tr>
			  <tr>
				<td class="center">其他</td>
				<td class="center"><input type="checkbox" id="<?php echo $form_row; ?>_chkgroup16" name="childdoctor2form[<?php echo $form_row; ?>][groupchk][]" value="其他" <?php echo (!empty($gck) && in_array("其他", $gck ))? "checked":""; ?>/></td>
				<td class="<?php echo $form_row; ?>_chkgroup16"><textarea name="childdoctor2form[<?php echo $form_row; ?>][supplement]" cols="65" rows="10"><?php echo $childdoctor2form['supplement']; ?></textarea></td>
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
$(function() {
  $("input[name*=groupchk]").live('click', function(){
	var cname = $(this).attr('id');
	  if (this.checked) {
		$("td." + cname + " input").attr({
			"checked": false,
			"disabled": true
		});
		$("td." + cname + " textarea").val('').attr('disabled', true);
	  } else {
		$("td." + cname + " input").removeAttr("disabled");
		$("td." + cname + " textarea").removeAttr("disabled");
	  }
  });
  $("td[class*=chkgroup] input, td[class*=chkgroup] textarea").live('click', function(){
	var cname = $(this).parent().parent('td').attr('class');
	$("input[id=" + cname + "]").attr("checked", false);
  });
});
</script>

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
	
		html  = '<div id="tab-childdoctor2form-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_childdoctor2form; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="childdoctor2form[' + form_row + '][customer_child_doctor2_id]" value="" />';
		html += '  <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">實施日期</td>';
		html += '				<td width="35%"><input type="text" name="childdoctor2form[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td>醫師</td>';
		html += '                <td><select name="childdoctor2form[' + form_row + '][doctor_id]">';
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
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup1" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup1">';
		html += '					<div>活動力：<input type="checkbox"  value="軟弱伸展" name="childdoctor2form[' + form_row + '][chk1]"  /> 軟弱伸展</div>';
		html += '					';
		html += '					<div>膚色：<input type="checkbox"  value="微黃" name="childdoctor2form[' + form_row + '][chk2]"  /> 微黃&nbsp;<input type="checkbox"  value="偏黃" name="childdoctor2form[' + form_row + '][chk2]"  /> 偏黃&nbsp;<input type="checkbox"  value="蒼白" name="childdoctor2form[' + form_row + '][chk2]"  /> 蒼白</div>';
		html += '					';
		html += '					<div>體溫：<input type="checkbox"  value="體溫過高" name="childdoctor2form[' + form_row + '][chk3]"  /> 體溫過高&nbsp;<input type="checkbox"  value="體溫過低" name="childdoctor2form[' + form_row + '][chk3]"  /> 體溫過低</div>';
		html += '					';
		html += '					<div>體重：<input type="checkbox"  value="體重增加緩慢" name="childdoctor2form[' + form_row + '][chk4][]"  /> 體重增加緩慢&nbsp;<input type="checkbox"  value="體重過低" name="childdoctor2form[' + form_row + '][chk4][]"  /> 體重過低</div>';
		html += '					';
		html += '					<div>大便：<input type="checkbox"  value="腹瀉" name="childdoctor2form[' + form_row + '][chk5][]"  /> 腹瀉&nbsp;<input type="checkbox"  value="便祕" name="childdoctor2form[' + form_row + '][chk5][]"  />便祕&nbsp;<input type="checkbox"  value="血便" name="childdoctor2form[' + form_row + '][chk5][]"  /> 血便&nbsp;<input type="checkbox"  value="灰白便" name="childdoctor2form[' + form_row + '][chk5][]"  /> 灰白便</div>';
		html += '					';
		html += '					<div>小便：<input type="checkbox"  value="少尿" name="childdoctor2form[' + form_row + '][chk6]"  /> 少尿&nbsp;<input type="checkbox"  value="血尿" name="childdoctor2form[' + form_row + '][chk6]"  /> 血尿&nbsp;<input type="checkbox"  value="尿酸結晶" name="childdoctor2form[' + form_row + '][chk6]"  /> 尿酸結晶</div>';
		html += '					';
		html += '					<div>餵食：<input type="checkbox"  value="頻繁溢奶" name="childdoctor2form[' + form_row + '][chk7]"  /> 頻繁溢奶&nbsp;<input type="checkbox"  value="噴射性吐奶" name="childdoctor2form[' + form_row + '][chk7]"  /> 噴射性吐奶</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			 <tr>';
		html += '				<td class="center">皮膚</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup2" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup2">  ';
		html += '					<div>紅疹：<input type="checkbox"  value="臉部" name="childdoctor2form[' + form_row + '][chk8][]"  /> 臉部&nbsp;<input type="checkbox"  value="頸部" name="childdoctor2form[' + form_row + '][chk8][]"  /> 頸部&nbsp;<input type="checkbox"  value="身體" name="childdoctor2form[' + form_row + '][chk8][]"  /> 身體&nbsp;<input type="checkbox"  value="四肢" name="childdoctor2form[' + form_row + '][chk8][]"  /> 四肢&nbsp;<input type="checkbox"  value="脂漏性皮膚炎" name="childdoctor2form[' + form_row + '][chk8][]"  /> 脂漏性皮膚炎&nbsp;<input type="checkbox"  value="毒性紅斑" name="childdoctor2form[' + form_row + '][chk8][]"  /> 毒性紅斑</div>';
		html += '					';
		html += '					<div>血管瘤：<input type="checkbox"  value="額頭雙眉間" name="childdoctor2form[' + form_row + '][chk9][]"  /> 額頭雙眉間&nbsp;<input type="checkbox"  value="左上眼瞼" name="childdoctor2form[' + form_row + '][chk9][]"  /> 左上眼瞼&nbsp;<input type="checkbox"  value="右上眼瞼" name="childdoctor2form[' + form_row + '][chk9][]"  /> 右上眼瞼&nbsp;<input type="checkbox"  value="頸背髮際處" name="childdoctor2form[' + form_row + '][chk9][]"  /> 頸背髮際處</div>';
		html += '										';
		html += '					<div>其他：<input type="checkbox"  value="臉部皮下瘀血" name="childdoctor2form[' + form_row + '][chk10]"  /> 臉部皮下瘀血</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '                <td class="center">眼</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup3" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup3">  ';
		html += '					<div>結膜炎：<input type="checkbox"  value="左眼" name="childdoctor2form[' + form_row + '][chk11][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[' + form_row + '][chk11][]"  /> 右眼</div>';
		html += '					';
		html += '					<div>血管瘤：<input type="checkbox"  value="左眼" name="childdoctor2form[' + form_row + '][chk12][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[' + form_row + '][chk12][]"  /> 右眼</div>';
		html += '										';
		html += '					<div>鼻淚管阻塞：<input type="checkbox"  value="左眼" name="childdoctor2form[' + form_row + '][chk13][]"  /> 左眼&nbsp;<input type="checkbox"  value="右眼" name="childdoctor2form[' + form_row + '][chk13][]"  /> 右眼</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">耳</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup4" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup4">  ';
		html += '					<div>耳前息肉：<input type="checkbox"  value="左耳" name="childdoctor2form[' + form_row + '][chk14][]" /> 左耳&nbsp;<input type="checkbox"  value="右耳" name="childdoctor2form[' + form_row + '][chk14][]" /> 右耳&nbsp;<input type="checkbox"  value="耳前小竇" name="childdoctor2form[' + form_row + '][chk14][]"  /> 耳前小竇</div>';
		html += '					';
		html += '					<div>耳道異常分泌物：<input type="checkbox"  value="左耳" name="childdoctor2form[' + form_row + '][chk15][]"  /> 左耳&nbsp;<input type="checkbox"  value="右耳" name="childdoctor2form[' + form_row + '][chk15][]"  /> 右耳</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">口腔</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup5" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup5">  ';
		html += '					<div><input type="checkbox"  value="鵝口瘡" name="childdoctor2form[' + form_row + '][chk16][]" /> 鵝口瘡&nbsp;<input type="checkbox"  value="唇裂" name="childdoctor2form[' + form_row + '][chk16][]" /> 唇裂&nbsp;<input type="checkbox"  value="顎裂" name="childdoctor2form[' + form_row + '][chk16][]" /> 顎裂&nbsp;<input type="checkbox"  value="舌繫帶過短" name="childdoctor2form[' + form_row + '][chk16][]" /> 舌繫帶過短</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">鼻咽喉部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup6" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup6">  ';
		html += '					<div><input type="checkbox"  value="上呼吸道感染" name="childdoctor2form[' + form_row + '][chk17][]" /> 上呼吸道感染&nbsp;<input type="checkbox"  value="鼻塞" name="childdoctor2form[' + form_row + '][chk17][]"  /> 鼻塞&nbsp;<input type="checkbox"  value="流鼻水" name="childdoctor2form[' + form_row + '][chk17][]"  /> 流鼻水&nbsp;<input type="checkbox"  value="咳嗽" name="childdoctor2form[' + form_row + '][chk17][]"  /> 咳嗽</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">喉</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup7" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup7">  ';
		html += '					<div><input type="checkbox"  value="呼吸雜音" name="childdoctor2form[' + form_row + '][chk18][]" /> 呼吸雜音&nbsp;<input type="checkbox"  value="喉頭軟化" name="childdoctor2form[' + form_row + '][chk18][]" /> 喉頭軟化</div>';
		html += '				</td>';
		html += '              </tr>			  ';
		html += '			  <tr>';
		html += '                <td class="center">頭頸部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup8" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup8">  ';
		html += '					<div>頭部：<input type="checkbox"  value="左側頭皮血腫" name="childdoctor2form[' + form_row + '][chk19][]" /> 左側頭皮血腫&nbsp;<input type="checkbox"  value="右側頭皮血腫" name="childdoctor2form[' + form_row + '][chk19][]" /> 右側頭皮血腫&nbsp;<input type="checkbox"  value="帽狀腱膜下出血" name="childdoctor2form[' + form_row + '][chk19][]" /> 帽狀腱膜下出血&nbsp;<input type="checkbox"  value="產瘤" name="childdoctor2form[' + form_row + '][chk19][]" /> 產瘤</div>';
		html += '					';
		html += '					<div>斜頸：<input type="checkbox"  value="左斜頸" name="childdoctor2form[' + form_row + '][chk20]" /> 左斜頸&nbsp;<input type="checkbox"  value="右斜頸" name="childdoctor2form[' + form_row + '][chk20]" /> 右斜頸</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">胸腔</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup9" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup9">  ';
		html += '					<div><input type="checkbox"  value="乳房肥大" name="childdoctor2form[' + form_row + '][chk21][]" /> 乳房肥大&nbsp;<input type="checkbox"  value="乳頭分泌物" name="childdoctor2form[' + form_row + '][chk21][]" /> 乳頭分泌物&nbsp;<input type="checkbox"  value="漏斗胸" name="childdoctor2form[' + form_row + '][chk21][]" /> 漏斗胸&nbsp;<input type="checkbox"  value="雞胸" name="childdoctor2form[' + form_row + '][chk21][]" /> 雞胸</div>';
		html += '				</td>';
		html += '              </tr>			  ';
		html += '			  <tr>';
		html += '                <td class="center">心</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup10" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup10">  ';
		html += '					<div><input type="checkbox"  value="心律不整" name="childdoctor2form[' + form_row + '][chk22][]" /> 心律不整&nbsp;<input type="checkbox"  value="心雜音" name="childdoctor2form[' + form_row + '][chk22][]" /> 心雜音</div>';
		html += '				</td>';
		html += '              </tr>						  ';
		html += '			  <tr>';
		html += '                <td class="center">肺</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup11" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup11">  ';
		html += '					<div>呼吸音：<input type="checkbox"  value="喘鳴" name="childdoctor2form[' + form_row + '][chk23][]" /> 喘鳴&nbsp;<input type="checkbox"  value="囉音" name="childdoctor2form[' + form_row + '][chk23][]"  /> 囉音&nbsp;&nbsp;<input type="checkbox"  value="肋凹" name="childdoctor2form[' + form_row + '][chk23][]" /> 肋凹</div>';
		html += '				</td>';
		html += '              </tr>			';
		html += '			  <tr>';
		html += '                <td class="center">腹部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup12" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup12">  ';
		html += '					<div>腹部：<input type="checkbox"  value="腹脹" name="childdoctor2form[' + form_row + '][chk24]"  /> 腹脹</div>';
		html += '					';
		html += '					<div>腸蠕動聲：<input type="checkbox"  value="蠕動過快" name="childdoctor2form[' + form_row + '][chk25]"  /> 蠕動過快&nbsp;<input type="checkbox"  value="蠕動過慢" name="childdoctor2form[' + form_row + '][chk25]"  /> 蠕動過慢</div>';
		html += '					';
		html += '					<div>肚臍：<input type="checkbox"  value="臍周圍紅腫" name="childdoctor2form[' + form_row + '][chk26][]" /> 臍周圍紅腫&nbsp;<input type="checkbox"  value="臍瘜肉" name="childdoctor2form[' + form_row + '][chk26][]"  /> 臍瘜肉&nbsp;<input type="checkbox"  value="分泌物異味" name="childdoctor2form[' + form_row + '][chk26][]"  /> 分泌物異味&nbsp;<input type="checkbox"  value="臍疝氣" name="childdoctor2form[' + form_row + '][chk26][]"  /> 臍疝氣</div>';
		html += '				</td>';
		html += '              </tr>				  ';
		html += '			  <tr>';
		html += '                <td class="center">四肢</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup13" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup13">  ';
		html += '					<div>上肢：<input type="checkbox"  value="無力" name="childdoctor2form[' + form_row + '][chk27][]" /> 無力&nbsp;<input type="checkbox"  value="僵直" name="childdoctor2form[' + form_row + '][chk27][]" /> 僵直&nbsp;<input type="checkbox"  value="爪狀手" name="childdoctor2form[' + form_row + '][chk27][]" /> 爪狀手</div>';
		html += '					';
		html += '					<div>下肢：<input type="checkbox"  value="無力" name="childdoctor2form[' + form_row + '][chk28][]" /> 無力&nbsp;<input type="checkbox"  value="僵直" name="childdoctor2form[' + form_row + '][chk28][]" /> 僵直&nbsp;<input type="checkbox"  value="足內翻" name="childdoctor2form[' + form_row + '][chk28][]" /> 足內翻&nbsp;<input type="checkbox"  value="足外翻" name="childdoctor2form[' + form_row + '][chk28][]" /> 足外翻&nbsp;<input type="checkbox"  value="髖關節發育不全" name="childdoctor2form[' + form_row + '][chk28][]" /> 髖關節發育不全</div>';
		html += '										';
		html += '					<div>鎖骨：<input type="checkbox"  value="左邊骨折" name="childdoctor2form[' + form_row + '][chk29][]" /> 左邊骨折&nbsp;<input type="checkbox"  value="右邊骨折" name="childdoctor2form[' + form_row + '][chk29][]" /> 右邊骨折</div>';
		html += '				</td>';
		html += '              </tr>';
		html += '			  <tr>';
		html += '                <td class="center">生殖器</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup14" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup14">  ';
		html += '				<?php if ($child_gender == '男') { ?>';
		html += '					<div>男：<input type="checkbox"  value="尿道下裂" name="childdoctor2form[' + form_row + '][chk30][]"  /> 尿道下裂&nbsp;<input type="checkbox"  value="割包皮手術" name="childdoctor2form[' + form_row + '][chk30][]" /> 割包皮手術</div>';
		html += '					';
		html += '					<div>疝氣：<input type="checkbox"  value="左邊" name="childdoctor2form[' + form_row + '][chk31][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[' + form_row + '][chk31][]" /> 右邊</div>';
		html += '					';
		html += '					<div>隱睪症：<input type="checkbox"  value="左邊" name="childdoctor2form[' + form_row + '][chk32][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[' + form_row + '][chk32][]" /> 右邊</div>';
		html += '					';
		html += '					<div>陰囊水腫：<input type="checkbox"  value="左邊" name="childdoctor2form[' + form_row + '][chk33][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[' + form_row + '][chk33][]" /> 右邊</div>';
		html += '				<?php } elseif ($child_gender == '女') { ?>';
		html += '					<div>女：<input type="checkbox"  value="假性月經" name="childdoctor2form[' + form_row + '][chk30][]" /> 假性月經&nbsp;<input type="checkbox"  value="分泌物" name="childdoctor2form[' + form_row + '][chk30][]" /> 分泌物</div>';
		html += '										';
		html += '					<div>疝氣：<input type="checkbox"  value="左邊" name="childdoctor2form[' + form_row + '][chk31][]" /> 左邊&nbsp;<input type="checkbox"  value="右邊" name="childdoctor2form[' + form_row + '][chk31][]" /> 右邊</div>';
		html += '					';
		html += '					<div>腹股溝：<input type="checkbox"  value="念珠菌感染" name="childdoctor2form[' + form_row + '][chk34][]" /> 念珠菌感染&nbsp;<input type="checkbox"  value="紅疹" name="childdoctor2form[' + form_row + '][chk34][]" /> 紅疹</div>';
		html += '				<?php } ?>';
		html += '				</td>';
		html += '              </tr>';
		html += '			 <tr>';
		html += '				<td class="center">臀部</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup15" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup15">  ';
		html += '					<div>紅臀：<input type="checkbox"  value="輕" name="childdoctor2form[' + form_row + '][chk35]" /> 輕&nbsp;<input type="checkbox"  value="中度" name="childdoctor2form[' + form_row + '][chk35]" /> 中度&nbsp;<input type="checkbox"  value="重度" name="childdoctor2form[' + form_row + '][chk35]" /> 重度</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			  <tr>';
		html += '				<td class="center">其他</td>';
		html += '				<td class="center"><input type="checkbox" id="' + form_row + '_chkgroup16" name="childdoctor2form[' + form_row + '][groupchk][]" /></td>';
		html += '				<td class="' + form_row + '_chkgroup16"><textarea name="childdoctor2form[' + form_row + '][supplement]" cols="65" rows="10"></textarea></td>';
		html += '			  </tr>';
		html += '          </table>';
		
		

		html += '		<div class="inner-footing">';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>';
		html += '	</form>';	
		html += '</div>';

	
	$('#tab-childdoctor2').append(html);
	
	/*
	if (tabid) {
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=days_livein]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk24]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk25]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk26]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk27a]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk27b]').val($('#tab-childdoctor2form-'+ tabid + ' input[name*=chk27b]').val());
			<?php for ($i=1; $i<=23; $i++) { ?>
			$('#tab-childdoctor2form-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-childdoctor2form-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-childdoctor2form-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-childdoctor2form-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-childdoctor2form-'+ form_row + ' [name*=supplement]').text($('#tab-childdoctor2form-'+ tabid + ' [name*=supplement]').val());
	}
	*/
	
	$('.backlist').show();
	
	$('#childdoctor2-add').before('<a href="#tab-childdoctor2form-' + form_row + '" id="childdoctor2form-' + form_row + '"><?php echo $tab_childdoctor2form; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#childdoctor2form-' + form_row + '\').remove(); $(\'#tab-childdoctor2form-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#childdoctor2form-' + form_row).trigger('click');
	
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
		$('[id^=childdoctor2form]').click(function() {
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
foreach ($childdoctor2forms as $childdoctor2form) { 
		$time = strtotime($childdoctor2form['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_childdoctor2form ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#childdoctor2form-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($childdoctor2forms)) { ?>,<?php } ?>
				
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
				addChildDoctor2(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-childdoctor2form-1]").live("click", function () {
			$('#childdoctor2form-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>