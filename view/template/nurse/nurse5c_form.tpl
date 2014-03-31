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
      <div id="tabs" class="htabs"><a href="#tab-nurse5c"><?php echo $tab_nurse5c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  
        <div id="tab-nurse5c">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-nurse5clist"><?php echo $tab_nurse5c; ?></a>
            <span id="nurse5c-add"><?php echo $button_add_nurse5c; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addNurse5c();" /></span>
			
			<?php if (count($nurse5cforms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>
			
            <?php $form_row = 1; ?>
            <?php foreach ($nurse5cforms as $nurse5cform) { ?>
            <a title="<?php echo $nurse5cform['date_added']; ?>" alt="<?php echo $nurse5cform['date_added']; ?>" href="#tab-nurse5cform-<?php echo $form_row; ?>" id="nurse5cform-<?php echo $form_row; ?>"><?php echo $tab_nurse5cform . ' ' . $form_row; ?><?php if ($this->user->hasPermission('delete', 'nurse/nurse5c')) { ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delNurse5c(<?php echo $nurse5cform['customer_nurse5c_id']; ?>, <?php echo $form_row; ?>);" /><?php } ?></a><img style="float:left;margin-top:-28.5px;margin-left:5px;*display:none;cursor:crosshair;" src="view/image/copy.png" title="複製此單新增" alt="複製此單新增" onclick="addNurse5c(null, <?php echo $form_row; ?>);"/>
            <?php $form_row++; ?>
            <?php } ?>

			<?php if (count($nurse5cforms) > 12) { ?>
			</div>
			<?php } ?>
			
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-nurse5clist" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($nurse5cforms as $nurse5cform) { ?>
		<div id="tab-nurse5cform-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $nurse5cform['date_added']; ?> <?php echo $tab_nurse5cform; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="nurse5cform[<?php echo $form_row; ?>][customer_nurse5c_id]" value="<?php echo $nurse5cform['customer_nurse5c_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">填表日期</td>
				<td width="35%"><input type="text" name="nurse5cform[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  $nurse5cform['date_added'] ;?>" size="12" /></td>
                <td width="15%">評估人員</td>
                <td width="35%"><select name="nurse5cform[<?php echo $form_row; ?>][nurse_id]">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse5cform['nurse_id']) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
		</table>
					
			<div id="tab-nurse5c-body-<?php echo $form_row;?>" >
			<table class="form list">
				<thead>
				  <tr>
					<td class="center" width="50%">哺乳順利之表現</td>
					<td class="center" width="50%">哺乳困難之表現</td>
				  </tr>
				</thead>
				  <tr>
					<td class="caption" colspan="2">Bodyposition 身體姿勢：</td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk1_a" name="nurse5cform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse5cform['chk1']=="text_chk1_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk1_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk1_b" name="nurse5cform[<?php echo $form_row; ?>][chk1]"  <?php echo ($nurse5cform['chk1']=="text_chk1_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk1_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk2_a" name="nurse5cform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse5cform['chk2']=="text_chk2_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk2_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk2_b" name="nurse5cform[<?php echo $form_row; ?>][chk2]"  <?php echo ($nurse5cform['chk2']=="text_chk2_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk2_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk3_a" name="nurse5cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse5cform['chk3']=="text_chk3_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk3_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk3_b" name="nurse5cform[<?php echo $form_row; ?>][chk3]"  <?php echo ($nurse5cform['chk3']=="text_chk3_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk3_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk4_a" name="nurse5cform[<?php echo $form_row; ?>][chk4]"  <?php echo ($nurse5cform['chk4']=="text_chk4_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk4_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk4_b" name="nurse5cform[<?php echo $form_row; ?>][chk4]"  <?php echo ($nurse5cform['chk4']=="text_chk4_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk4_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk5_a" name="nurse5cform[<?php echo $form_row; ?>][chk5]"  <?php echo ($nurse5cform['chk5']=="text_chk5_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk5_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk5_b" name="nurse5cform[<?php echo $form_row; ?>][chk5]"  <?php echo ($nurse5cform['chk5']=="text_chk5_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk5_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td class="caption" colspan="2">Responses 反應：</td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk6_a" name="nurse5cform[<?php echo $form_row; ?>][chk6]"  <?php echo ($nurse5cform['chk6']=="text_chk6_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk6_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk6_b" name="nurse5cform[<?php echo $form_row; ?>][chk6]"  <?php echo ($nurse5cform['chk6']=="text_chk6_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk6_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk7_a" name="nurse5cform[<?php echo $form_row; ?>][chk7]"  <?php echo ($nurse5cform['chk7']=="text_chk7_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk7_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk7_b" name="nurse5cform[<?php echo $form_row; ?>][chk7]"  <?php echo ($nurse5cform['chk7']=="text_chk7_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk7_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk8_a" name="nurse5cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse5cform['chk8']=="text_chk8_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk8_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk8_b" name="nurse5cform[<?php echo $form_row; ?>][chk8]"  <?php echo ($nurse5cform['chk8']=="text_chk8_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk8_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk9_a" name="nurse5cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse5cform['chk9']=="text_chk9_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk9_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk9_b" name="nurse5cform[<?php echo $form_row; ?>][chk9]"  <?php echo ($nurse5cform['chk9']=="text_chk9_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk9_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk10_a" name="nurse5cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse5cform['chk10']=="text_chk10_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk10_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk10_b" name="nurse5cform[<?php echo $form_row; ?>][chk10]"  <?php echo ($nurse5cform['chk10']=="text_chk10_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk10_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk11_a" name="nurse5cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse5cform['chk11']=="text_chk11_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk11_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk11_b" name="nurse5cform[<?php echo $form_row; ?>][chk11]"  <?php echo ($nurse5cform['chk11']=="text_chk11_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk11_b'); ?></div>
					</div></td>
				  </tr>			  
				  <tr>
					<td class="caption" colspan="2">Emotionalbonding 情感交流：</td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk12_a" name="nurse5cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse5cform['chk12']=="text_chk12_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk12_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk12_b" name="nurse5cform[<?php echo $form_row; ?>][chk12]"  <?php echo ($nurse5cform['chk12']=="text_chk12_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk12_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk13_a" name="nurse5cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($nurse5cform['chk13']=="text_chk13_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk13_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk13_b" name="nurse5cform[<?php echo $form_row; ?>][chk13]"  <?php echo ($nurse5cform['chk13']=="text_chk13_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk13_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk14_a" name="nurse5cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse5cform['chk14']=="text_chk14_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk14_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk14_b" name="nurse5cform[<?php echo $form_row; ?>][chk14]"  <?php echo ($nurse5cform['chk14']=="text_chk14_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk14_b'); ?></div>
					</div></td>
				  </tr>	
				  <tr>
					<td class="caption" colspan="2">Anatomy 解剖：</td>
				  </tr>	
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk15_a" name="nurse5cform[<?php echo $form_row; ?>][chk15]"  <?php echo ($nurse5cform['chk15']=="text_chk15_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk15_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk15_b" name="nurse5cform[<?php echo $form_row; ?>][chk15]"  <?php echo ($nurse5cform['chk15']=="text_chk15_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk15_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk16_a" name="nurse5cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse5cform['chk16']=="text_chk16_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk16_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk16_b" name="nurse5cform[<?php echo $form_row; ?>][chk16]"  <?php echo ($nurse5cform['chk16']=="text_chk16_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk16_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk17_a" name="nurse5cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($nurse5cform['chk17']=="text_chk17_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk17_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk17_b" name="nurse5cform[<?php echo $form_row; ?>][chk17]"  <?php echo ($nurse5cform['chk17']=="text_chk17_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk17_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk18_a" name="nurse5cform[<?php echo $form_row; ?>][chk18]"  <?php echo ($nurse5cform['chk18']=="text_chk18_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk18_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk18_b" name="nurse5cform[<?php echo $form_row; ?>][chk18]"  <?php echo ($nurse5cform['chk18']=="text_chk18_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk18_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td class="caption" colspan="2">Suckling 含乳房：</td>
				  </tr>	
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk19_a" name="nurse5cform[<?php echo $form_row; ?>][chk19]"  <?php echo ($nurse5cform['chk19']=="text_chk19_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk19_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk19_b" name="nurse5cform[<?php echo $form_row; ?>][chk19]"  <?php echo ($nurse5cform['chk19']=="text_chk19_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk19_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk20_a" name="nurse5cform[<?php echo $form_row; ?>][chk20]"  <?php echo ($nurse5cform['chk20']=="text_chk20_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk20_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk20_b" name="nurse5cform[<?php echo $form_row; ?>][chk20]"  <?php echo ($nurse5cform['chk20']=="text_chk20_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk20_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk21_a" name="nurse5cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse5cform['chk21']=="text_chk21_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk21_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk21_b" name="nurse5cform[<?php echo $form_row; ?>][chk21]"  <?php echo ($nurse5cform['chk21']=="text_chk21_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk21_b'); ?></div>
					</div></td>
				  </tr>					  
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk22_a" name="nurse5cform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse5cform['chk22']=="text_chk22_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk22_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk22_b" name="nurse5cform[<?php echo $form_row; ?>][chk22]"  <?php echo ($nurse5cform['chk22']=="text_chk22_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk22_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk23_a" name="nurse5cform[<?php echo $form_row; ?>][chk23]"  <?php echo ($nurse5cform['chk23']=="text_chk23_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk23_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk23_b" name="nurse5cform[<?php echo $form_row; ?>][chk23]"  <?php echo ($nurse5cform['chk23']=="text_chk23_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk23_b'); ?></div>
					</div></td>
				  </tr>
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk24_a" name="nurse5cform[<?php echo $form_row; ?>][chk24]"  <?php echo ($nurse5cform['chk24']=="text_chk24_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk24_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk24_b" name="nurse5cform[<?php echo $form_row; ?>][chk24]"  <?php echo ($nurse5cform['chk24']=="text_chk24_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk24_b'); ?></div>
					</div></td>
				  </tr>		
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk25_a" name="nurse5cform[<?php echo $form_row; ?>][chk25]"  <?php echo ($nurse5cform['chk25']=="text_chk25_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk25_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk25_b" name="nurse5cform[<?php echo $form_row; ?>][chk25]"  <?php echo ($nurse5cform['chk25']=="text_chk25_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk25_b'); ?></div>
					</div></td>
				  </tr>					  
				  <tr>
					<td class="caption" colspan="2">Timespentsuckling 含奶時間 / Termination 停止哺乳：</td>
				  </tr>	
				  <tr>
					<td><div class="mybox">
					  <div class="odd"><input type="radio"  value="text_chk26_a" name="nurse5cform[<?php echo $form_row; ?>][chk26]"  <?php echo ($nurse5cform['chk26']=="text_chk26_a")? "checked":""; ?>/> <?php echo $this->language->get('text_chk26_a'); ?></div>
					</div></td>
					<td><div class="mybox">
					  <div class="even"><input type="radio"  value="text_chk26_b" name="nurse5cform[<?php echo $form_row; ?>][chk26]"  <?php echo ($nurse5cform['chk26']=="text_chk26_b")? "checked":""; ?>/> <?php echo $this->language->get('text_chk26_b'); ?></div>
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
function delNurse5c(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=nurse/nurse5c/delete&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&id='+encodeURIComponent(id);
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
foreach ($nurse5cforms as $nurse5cform) { 
$date_assign = (isset($nurse5cform['date_added']))? $nurse5cform['date_added'] : date('Y-m-d');
?>
$('#tab-nurse5cform-<?php echo $bodydivrow; ?> #tabs2-<?php echo $bodydivrow; ?> a').tabs(); 
<?php 
$bodydivrow ++;
} 
?>
//--></script> 
<script type="text/javascript"><!--
var form_row = <?php echo $form_row; ?>;

function addNurse5c(date, tabid) {		
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
		html  = '<div id="tab-nurse5cform-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_nurse5cform; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="nurse5cform[' + form_row + '][customer_nurse5c_id]" value="" />';
		html += '          <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">填表日期</td>';
		html += '				<td width="35%"><input type="text" name="nurse5cform[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td width="15%">評估人員</td>';
		html += '                <td width="35%"><select name="nurse5cform[' + form_row + '][nurse_id]">';
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
					
		html += '			<div id="tab-nurse5c-body-' + form_row + '" >';
		html += '			<table class="form list">';
		html += '				<thead>';
		html += '				  <tr>';
		html += '					<td class="center" width="50%">哺乳順利之表現</td>';
		html += '					<td class="center" width="50%">哺乳困難之表現</td>';
		html += '				  </tr>';
		html += '				</thead>';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Bodyposition 身體姿勢：</td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk1_a" name="nurse5cform[' + form_row + '][chk1]" /> <?php echo $this->language->get('text_chk1_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk1_b" name="nurse5cform[' + form_row + '][chk1]" /> <?php echo $this->language->get('text_chk1_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk2_a" name="nurse5cform[' + form_row + '][chk2]" /> <?php echo $this->language->get('text_chk2_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk2_b" name="nurse5cform[' + form_row + '][chk2]" /> <?php echo $this->language->get('text_chk2_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk3_a" name="nurse5cform[' + form_row + '][chk3]" /> <?php echo $this->language->get('text_chk3_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk3_b" name="nurse5cform[' + form_row + '][chk3]" /> <?php echo $this->language->get('text_chk3_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk4_a" name="nurse5cform[' + form_row + '][chk4]" /> <?php echo $this->language->get('text_chk4_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk4_b" name="nurse5cform[' + form_row + '][chk4]" /> <?php echo $this->language->get('text_chk4_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk5_a" name="nurse5cform[' + form_row + '][chk5]" /> <?php echo $this->language->get('text_chk5_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk5_b" name="nurse5cform[' + form_row + '][chk5]" /> <?php echo $this->language->get('text_chk5_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Responses 反應：</td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk6_a" name="nurse5cform[' + form_row + '][chk6]" /> <?php echo $this->language->get('text_chk6_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk6_b" name="nurse5cform[' + form_row + '][chk6]" /> <?php echo $this->language->get('text_chk6_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk7_a" name="nurse5cform[' + form_row + '][chk7]" /> <?php echo $this->language->get('text_chk7_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk7_b" name="nurse5cform[' + form_row + '][chk7]" /> <?php echo $this->language->get('text_chk7_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk8_a" name="nurse5cform[' + form_row + '][chk8]" /> <?php echo $this->language->get('text_chk8_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk8_b" name="nurse5cform[' + form_row + '][chk8]" /> <?php echo $this->language->get('text_chk8_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk9_a" name="nurse5cform[' + form_row + '][chk9]" /> <?php echo $this->language->get('text_chk9_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk9_b" name="nurse5cform[' + form_row + '][chk9]" /> <?php echo $this->language->get('text_chk9_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk10_a" name="nurse5cform[' + form_row + '][chk10]" /> <?php echo $this->language->get('text_chk10_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk10_b" name="nurse5cform[' + form_row + '][chk10]" /> <?php echo $this->language->get('text_chk10_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk11_a" name="nurse5cform[' + form_row + '][chk11]" /> <?php echo $this->language->get('text_chk11_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk11_b" name="nurse5cform[' + form_row + '][chk11]" /> <?php echo $this->language->get('text_chk11_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>			  ';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Emotionalbonding 情感交流：</td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk12_a" name="nurse5cform[' + form_row + '][chk12]" /> <?php echo $this->language->get('text_chk12_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk12_b" name="nurse5cform[' + form_row + '][chk12]" /> <?php echo $this->language->get('text_chk12_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk13_a" name="nurse5cform[' + form_row + '][chk13]" /> <?php echo $this->language->get('text_chk13_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk13_b" name="nurse5cform[' + form_row + '][chk13]" /> <?php echo $this->language->get('text_chk13_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk14_a" name="nurse5cform[' + form_row + '][chk14]" /> <?php echo $this->language->get('text_chk14_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk14_b" name="nurse5cform[' + form_row + '][chk14]" /> <?php echo $this->language->get('text_chk14_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>	';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Anatomy 解剖：</td>';
		html += '				  </tr>	';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk15_a" name="nurse5cform[' + form_row + '][chk15]" /> <?php echo $this->language->get('text_chk15_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk15_b" name="nurse5cform[' + form_row + '][chk15]" /> <?php echo $this->language->get('text_chk15_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk16_a" name="nurse5cform[' + form_row + '][chk16]" /> <?php echo $this->language->get('text_chk16_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk16_b" name="nurse5cform[' + form_row + '][chk16]" /> <?php echo $this->language->get('text_chk16_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk17_a" name="nurse5cform[' + form_row + '][chk17]" /> <?php echo $this->language->get('text_chk17_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk17_b" name="nurse5cform[' + form_row + '][chk17]" /> <?php echo $this->language->get('text_chk17_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk18_a" name="nurse5cform[' + form_row + '][chk18]" /> <?php echo $this->language->get('text_chk18_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk18_b" name="nurse5cform[' + form_row + '][chk18]" /> <?php echo $this->language->get('text_chk18_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Suckling 含乳房：</td>';
		html += '				  </tr>	';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk19_a" name="nurse5cform[' + form_row + '][chk19]" /> <?php echo $this->language->get('text_chk19_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk19_b" name="nurse5cform[' + form_row + '][chk19]" /> <?php echo $this->language->get('text_chk19_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk20_a" name="nurse5cform[' + form_row + '][chk20]" /> <?php echo $this->language->get('text_chk20_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk20_b" name="nurse5cform[' + form_row + '][chk20]" /> <?php echo $this->language->get('text_chk20_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk21_a" name="nurse5cform[' + form_row + '][chk21]" /> <?php echo $this->language->get('text_chk21_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk21_b" name="nurse5cform[' + form_row + '][chk21]" /> <?php echo $this->language->get('text_chk21_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>					  ';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk22_a" name="nurse5cform[' + form_row + '][chk22]" /> <?php echo $this->language->get('text_chk22_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk22_b" name="nurse5cform[' + form_row + '][chk22]" /> <?php echo $this->language->get('text_chk22_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk23_a" name="nurse5cform[' + form_row + '][chk23]" /> <?php echo $this->language->get('text_chk23_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk23_b" name="nurse5cform[' + form_row + '][chk23]" /> <?php echo $this->language->get('text_chk23_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk24_a" name="nurse5cform[' + form_row + '][chk24]" /> <?php echo $this->language->get('text_chk24_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk24_b" name="nurse5cform[' + form_row + '][chk24]" /> <?php echo $this->language->get('text_chk24_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>		';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk25_a" name="nurse5cform[' + form_row + '][chk25]" /> <?php echo $this->language->get('text_chk25_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk25_b" name="nurse5cform[' + form_row + '][chk25]" /> <?php echo $this->language->get('text_chk25_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>					  ';
		html += '				  <tr>';
		html += '					<td class="caption" colspan="2">Timespentsuckling 含奶時間 / Termination 停止哺乳：</td>';
		html += '				  </tr>	';
		html += '				  <tr>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="odd"><input type="radio"  value="text_chk26_a" name="nurse5cform[' + form_row + '][chk26]" /> <?php echo $this->language->get('text_chk26_a'); ?></div>';
		html += '					</div></td>';
		html += '					<td><div class="mybox">';
		html += '					  <div class="even"><input type="radio"  value="text_chk26_b" name="nurse5cform[' + form_row + '][chk26]" /> <?php echo $this->language->get('text_chk26_b'); ?></div>';
		html += '					</div></td>';
		html += '				  </tr>				  ';
		html += '			  </table>';
		html += '			</div>';
		
		
		
	html += '		<div class="inner-footing">';
	html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
	html += '		</div>';
	html += '	</form>';			
	html += '</div>';

	
	$('#tab-nurse5c').append(html);
	
	if (tabid) {
	/*
			$('#tab-nurse5cform-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=days_livein]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk24]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk25]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk26]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk27a]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk27b]').val($('#tab-nurse5cform-'+ tabid + ' input[name*=chk27b]').val());
	*/
			<?php for ($i=1; $i<=26; $i++) { ?>
			$('#tab-nurse5cform-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-nurse5cform-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-nurse5cform-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-nurse5cform-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			//$('#tab-nurse5cform-'+ form_row + ' [name*=supplement]').text($('#tab-nurse5cform-'+ tabid + ' [name*=supplement]').val());
	}
	
	$('.backlist').show();
	
	$('#nurse5c-add').before('<a href="#tab-nurse5cform-' + form_row + '" id="nurse5cform-' + form_row + '"><?php echo $tab_nurse5cform; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#nurse5cform-' + form_row + '\').remove(); $(\'#tab-nurse5cform-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	$('#tabs2-'+ form_row +' a').tabs();
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('.time').timepicker({timeFormat: 'hh:mm'});
	
	$('#nurse5cform-' + form_row).trigger('click');
	
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
		$('[id^=nurse5cform]').click(function() {
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
foreach ($nurse5cforms as $nurse5cform) { 
		$time = strtotime($nurse5cform['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_nurse5cform ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#nurse5cform-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($nurse5cforms)) { ?>,<?php } ?>
				
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
				addNurse5c(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-nurse5cform-1]").live("click", function () {
			$('#nurse5cform-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>