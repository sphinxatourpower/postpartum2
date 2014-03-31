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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?><?php echo (isset($name) AND $name<>'') ? "－".$name : ""; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a>
        <?php if ($customer_id) { ?>
        <a href="#tab-moredata"><?php echo $tab_moredata; ?></a><a href="#tab-transfer"><?php echo $tab_transfer; ?></a>
        <?php } ?>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-customer"><?php echo $tab_general; ?></a>
            <?php $contact_row = 1; ?>
            <?php foreach ($contacts as $contact) { ?>
            <a href="#tab-contact-<?php echo $contact_row; ?>" id="contact-<?php echo $contact_row; ?>"><?php echo $tab_contact . ' ' . $contact_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#vtabs a:first').trigger('click'); $('#contact-<?php echo $contact_row; ?>').remove(); $('#tab-contact-<?php echo $contact_row; ?>').remove(); return false;" /></a>
            <?php $contact_row++; ?>
            <?php } ?>
            <span id="contact-add"><?php echo $button_add_contact; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addContact();" /></span>
			
            <?php $child_row = 1; ?>
            <?php foreach ($childs as $child) { ?>
            <a href="#tab-child-<?php echo $child_row; ?>" id="child-<?php echo $child_row; ?>"><?php echo $tab_childdata . ' ' . $child_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#vtabs a:first').trigger('click'); $('#child-<?php echo $child_row; ?>').remove(); $('#tab-child-<?php echo $child_row; ?>').remove(); return false;" /></a>
            <?php $child_row++; ?>
            <?php } ?>
            <span id="child-add"><?php echo $button_add_child; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addChild();" /></span>
		</div>
		<!-- vtabs menu -->
		
		<!-- vtab1 -->
          <div id="tab-customer" class="vtabs-content" style="display:none;">
            <table class="form list">
			   <tr>
                <td width="15%"><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td width="35%"><input type="text" name="name" value="<?php echo $name; ?>" />
                  <?php if ($error_name) { ?>
                  <span class="error"><?php echo $error_name; ?></span>
                  <?php } ?></td>
                <td width="15%"><span class="required">*</span> <?php echo $entry_idnumber; ?></td>
                <td width="35%"><input type="text" name="idnumber" value="<?php echo $idnumber; ?>" />
                  <?php if ($error_idnumber) { ?>
                  <span class="error"><?php echo $error_idnumber; ?></span>
                  <?php } ?></td>
			   <tr>
			     <td><?php echo $entry_birthdate; ?></td>
                <td><input type="text" name="birthdate" size="12" class="date"  value="<?php echo $birthdate; ?>"/></td>
                <td><?php echo $entry_service; ?></td>
                <td><select name="service_id">
                    <?php foreach ($services as $service) { ?>
                    <?php if ($service['user_id'] == $service_id) { ?>
                    <option value="<?php echo $service['user_id']; ?>" selected="selected"><?php echo $service['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $service['user_id']; ?>"><?php echo $service['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
<!--			  
                <td><?php echo $entry_status; ?></td>
                <td><select name="status">
                    <?php if ($status) { ?>
                    <option value="1" selected="selected"><?php echo $text_livein; ?></option>
                    <option value="0"><?php echo $text_leave; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_livein; ?></option>
                    <option value="0" selected="selected"><?php echo $text_leave; ?></option>
                    <?php } ?>
                  </select></td>
-->			
                <td><?php echo $entry_status; ?></td>
                <td><?php echo ($status) ? $text_livein : $text_leave; ?></td>	  
                <td><span class="required">*</span> <?php echo $entry_date_added; ?></td>
                <td><input type="text" name="date_added" value="<?php echo (isset($date_added) AND $date_added<>'') ? date($this->language->get('date_format_short'), strtotime($date_added)) : ""; ?>"/> <input class="time" type="text" name="date_added_time" value="<?php echo (isset($date_added) AND $date_added<>'') ? date($this->language->get('time_format_shortest'), strtotime($date_added)) : ""; ?>"/>
				<?php if ($error_date_added) { ?>
                  <span class="error"><?php echo $error_date_added; ?></span>
                  <?php  } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                  <?php if ($error_telephone) { ?>
                  <span class="error"><?php echo $error_telephone; ?></span>
                  <?php  } ?></td>
                <td><?php echo $entry_date_leave; ?></td>
                <td><input type="text" name="date_leave"  value="<?php echo (isset($date_leave) AND $date_leave<>'') ? date($this->language->get('date_format_short'), strtotime($date_leave)) : ""; ?>"/> <input class="time" type="text" name="date_leave_time" value="<?php echo (isset($date_leave) AND $date_leave<>'') ? date($this->language->get('time_format_shortest'), strtotime($date_leave)) : ""; ?>"/></td>
			  </tr>
			  <tr>
                <td><?php echo $entry_email; ?></td>
                <td><input type="text" name="email" value="<?php echo $email; ?>" />
                  <?php if ($error_email) { ?>
                  <span class="error"><?php echo $error_email; ?></span>
                  <?php  } ?></td>
                <td>地址</td>
                <td colspan="3"><input type="text" name="address" value="<?php echo $address; ?>" size="62" /></td>
              </tr>
<!--			  
			  <tr>
                <td><?php echo $entry_showathome; ?></td>
                <td><select name="showathome">
                    <?php if ($showathome) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select></td>
			  </tr>
-->			  
            </table>
          </div>
		  <!-- vtab1 -->
		  
		  <!-- vtab2 -->
          <?php $contact_row = 1; ?>
          <?php foreach ($contacts as $contact) { ?>
          <div id="tab-contact-<?php echo $contact_row; ?>" class="vtabs-content" style="display:none;">
            <input type="hidden" name="contact[<?php echo $contact_row; ?>][contact_id]" value="<?php echo $contact['contact_id']; ?>" />
            <table class="form">
			   <tr>
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td><input type="text" name="contact[<?php echo $contact_row; ?>][name]" value="<?php echo $contact['name']; ?>" />
                  <?php if (isset($error_contact_name[$contact_row])) { ?>
                  <span class="error"><?php echo $error_contact_name[$contact_row]; ?></span>
                  <?php } ?></td>
              </tr>
			  <tr>
                <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                <td><input type="text" name="contact[<?php echo $contact_row; ?>][telephone]" value="<?php echo $contact['telephone']; ?>" />
                  <?php if (isset($error_contact_telephone[$contact_row])) { ?>
                  <span class="error"><?php echo $error_contact_telephone[$contact_row]; ?></span>
                  <?php } ?></td>
              </tr>
			  <tr>
			  <?php if (!isset($contact['relationship'])) $contact['relationship'] = ''; ?>
                <td><span class="required">*</span> 關係</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="夫" name="contact[<?php echo $contact_row; ?>][relationship]"  <?php echo ($contact['relationship']=="夫")? "checked":""; ?>/> 夫</div>
				  <div class="even"><input type="radio"  value="父母" name="contact[<?php echo $contact_row; ?>][relationship]"  <?php echo ($contact['relationship']=="父母")? "checked":""; ?>/> 父母</div>
				  <div class="odd"><input type="radio"  value="兄弟姐妹" name="contact[<?php echo $contact_row; ?>][relationship]"  <?php echo ($contact['relationship']=="兄弟姐妹")? "checked":""; ?>/> 兄弟姐妹</div>
				  <div class="even"><input type="radio"  value="其他" name="contact[<?php echo $contact_row; ?>][relationship]"  <?php echo ($contact['relationship']=="其他")? "checked":""; ?>/> 其他</div>
                </div>
				  <?php if (isset($error_contact_relationship[$contact_row])) { ?>
                  <span class="error"><?php echo $error_contact_relationship[$contact_row]; ?></span>
                  <?php } ?></td>
              </tr>
<!--			  
              <tr>
                <td><?php echo $entry_default; ?></td>
                <td><?php if (($contact['contact_id'] == $contact_id) || !$contacts) { ?>
                  <input type="radio" name="contact[<?php echo $contact_row; ?>][default]" value="<?php echo $contact_row; ?>" checked="checked" /></td>
                <?php } else { ?>
                <input type="radio" name="contact[<?php echo $contact_row; ?>][default]" value="<?php echo $contact_row; ?>" />
				<?php } ?>
                  </td>
              </tr>
-->
            </table>
          </div>
		  <?php $contact_row++; ?>
          <?php } ?>
		  <!-- vtab2 -->
		  
		  <!-- vtab3 -->
		  <?php $child_row = 1; ?>
          <?php foreach ($childs as $child) { ?>
          <div id="tab-child-<?php echo $child_row; ?>" class="vtabs-content" style="display:none;">
            <input type="hidden" name="child[<?php echo $child_row; ?>][child_id]" value="<?php echo $child['child_id']; ?>" />
			<input type="hidden" name="child[<?php echo $child_row; ?>][image]" value="<?php echo $child['image']; ?>" />
            <table class="form">
			   <tr>
                <td><?php echo $entry_name; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][name]" value="<?php echo $child['name']; ?>" />
                  <?php if (isset($error_child_name[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_name[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><span class="required">*</span> <?php echo $entry_gender; ?></td>
                <td><select name="child[<?php echo $child_row; ?>][gender]">
					<option value=""></option>
                    <option value="男" <?php echo ($child['gender'] == "男") ? "selected=\"selected\"" : ""; ?>>男</option>
					<option value="女" <?php echo ($child['gender'] == "女") ? "selected=\"selected\"" : ""; ?>>女</option>
				</select>
				<?php if (isset($error_child_gender[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_gender[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><span class="required">*</span> <?php echo $entry_birthdate; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthdate]" class="date" value="<?php echo $child['birthdate']; ?>" /> <input type="text" name="child[<?php echo $child_row; ?>][birthdate_time]" class="time" value="<?php echo $child['birthdate_time']; ?>" />
                  <?php if (isset($error_child_birthdate[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthdate[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			  <tr>
                <td><?php echo $entry_birthhospital; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthhospital]" value="<?php echo $child['birthhospital']; ?>" />
                  <?php if (isset($error_child_birthhospital[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthhospital[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><?php echo $entry_birthweight; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthweight]" value="<?php echo $child['birthweight']; ?>" /> 公克
                  <?php if (isset($error_child_birthweight[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthweight[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><?php echo $entry_birthhead; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthhead]" value="<?php echo $child['birthhead']; ?>" /> 公分
                  <?php if (isset($error_child_birthhead[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthhead[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><?php echo $entry_birthchest; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthchest]" value="<?php echo $child['birthchest']; ?>" /> 公分
                  <?php if (isset($error_child_birthchest[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthchest[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><?php echo $entry_birthlength; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][birthlength]" value="<?php echo $child['birthlength']; ?>" /> 公分
                  <?php if (isset($error_child_birthlength[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_birthlength[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td><?php echo $entry_inweight; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][inweight]" value="<?php echo $child['inweight']; ?>" /> 公克
                  <?php if (isset($error_child_inweight[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_inweight[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr style="display:none;">
                <td><?php echo $entry_inlength; ?></td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][inlength]" value="<?php echo $child['inlength']; ?>" /> 公分
                  <?php if (isset($error_child_inlength[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_inlength[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
<!--			  
			   <tr>
			   <?php if (!isset($child['b_streptococcus_check'])) $child['b_streptococcus_check'] = ''; ?>
                <td><?php echo $entry_b_streptococcus_check; ?></td>
                <td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="陰性" name="child[<?php echo $child_row; ?>][b_streptococcus_check]"  <?php echo ($child['b_streptococcus_check']=="陰性")? "checked":""; ?>/> 陰性</div>
				  <div class="even"><input type="radio"  value="陽性" name="child[<?php echo $child_row; ?>][b_streptococcus_check]"  <?php echo ($child['b_streptococcus_check']=="陽性")? "checked":""; ?>/> 陽性</div>
				  <div class="odd"><input type="radio"  value="未做" name="child[<?php echo $child_row; ?>][b_streptococcus_check]"  <?php echo ($child['b_streptococcus_check']=="未做")? "checked":""; ?>/> 未做</div>
                </div>
                  <?php if (isset($error_child_b_streptococcus_check[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_b_streptococcus_check[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
-->			  
			   <tr>
                <td><?php echo $entry_apgar_score; ?></td>
                <td>一分鐘：<input type="text" name="child[<?php echo $child_row; ?>][apgar_score_1]" value="<?php echo $child['apgar_score_1']; ?>" />
                  <?php if (isset($error_child_apgar_score_1[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_apgar_score_1[$child_row]; ?></span>
                  <?php } ?>&nbsp;&raquo;&raquo;&nbsp;五分鐘：<input type="text" name="child[<?php echo $child_row; ?>][apgar_score_5]" value="<?php echo $child['apgar_score_5']; ?>" />
                  <?php if (isset($error_child_apgar_score_5[$child_row])) { ?>
                  <span class="error"><?php echo $error_child_apgar_score_5[$child_row]; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td>寶寶床位</td>
                <td><select name="child[<?php echo $child_row; ?>][bed_id]">
					<option value=""></option>
                    <?php foreach ($child_beds as $childbed) { ?>
					<?php if ($child['bed_id'] == $childbed['bed_id']) { ?>
                    <option value="<?php echo $childbed['bed_id']; ?>" selected="selected"><?php echo $childbed['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $childbed['bed_id']; ?>"><?php echo $childbed['name']; ?></option>
					<?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
<!--			  
			   <tr>
                <td>寶寶預計離院時間</td>
                <td><input type="text" name="child[<?php echo $child_row; ?>][date_leave]" class="childdateleave" value="<?php echo date($this->language->get('date_format_short'), strtotime($child['date_leave'])); ?>" /><input type="text" name="child[<?php echo $child_row; ?>][date_leave_time]" class="time" value="<?php echo date($this->language->get('time_format_shortest'), strtotime($child['date_leave'])); ?>" /></td>
              </tr>
-->			  
            </table>
          </div>
		  <?php $child_row++; ?>
          <?php } ?>
		  <!-- vtab3 -->
		  
        </div>
		
		
		
        <?php if ($customer_id) { ?>
		<div id="tab-moredata" style="display:none;">
          <table class="form list">
<!--		  
			  <tr>
                <td width="15%">產婦跌倒評估分數</td>
                <td width="35%"><input type="text" name="fall_score" value="<?php echo $fall_score; ?>" size="12" /></td>
                <td width="15%">產婦憂鬱評估分數</td>
                <td width="35%"><input type="text" name="depression_score" value="<?php echo $depression_score; ?>" size="12" /></td>
              </tr>
-->			  
            <tr>
              <td><?php echo $entry_childbirth_hospital; ?></td>
			  <?php  $cbh = explode(':', $childbirth_hospital);
			  if ($cbh[0] == "其他" && isset($cbh[1])) { $childbirth_hospital = $cbh[0];  $childbirth_hospital_other = $cbh[1]; } 
			  else { $childbirth_hospital = $cbh[0];  $childbirth_hospital_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="羅東博愛" name="childbirth_hospital"  <?php echo ($childbirth_hospital=="羅東博愛")? "checked":""; ?>/> 羅東博愛</div>
				  <div class="even"><input type="radio"  value="陽大" name="childbirth_hospital"  <?php echo ($childbirth_hospital=="陽大")? "checked":""; ?>/> 陽大</div>
				  <div class="odd"><input type="radio"  value="羅東聖母" name="childbirth_hospital"  <?php echo ($childbirth_hospital=="羅東聖母")? "checked":""; ?>/> 羅東聖母</div>
				  <div class="even"><input type="radio"  value="其他" name="childbirth_hospital"  <?php echo ($childbirth_hospital=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="childbirth_hospital_other" value="<?php echo $childbirth_hospital_other; ?>" size="12" /></div>
                </div></td>
<!--				
              <td><?php echo $entry_childbirth_doctor; ?></td>
			  <td><input type="text" name="childbirth_doctor" value="<?php echo $childbirth_doctor; ?>" size="12" /></td>
-->			  
            </tr>
            <tr>
              <td><?php echo $entry_childbirth_method; ?></td>
              <td>
                <input type="radio" name="childbirth_method" value="NSD" <?php echo ($childbirth_method=="NSD")? "checked=\"checked\"":""; ?> /> NSD
                <input type="radio" name="childbirth_method" value="C/S"  <?php echo ($childbirth_method=="C/S")? "checked=\"checked\"":""; ?>/> C/S
				<input type="radio" name="childbirth_method" value="VED"  <?php echo ($childbirth_method=="VED")? "checked=\"checked\"":""; ?>/> VED
			  </td>
            </tr>
            <tr>
              <td><?php echo $entry_pregnancy_weeks; ?></td>
              <td><input type="text" name="pregnancy_weeks" value="<?php echo $pregnancy_weeks; ?>" size="2" /> 週</td>
<!--			  
              <td><?php echo $entry_child_count; ?></td>
              <td>G：<input type="text" name="child_count_g" value="<?php echo $child_count_g; ?>" size="2" />&nbsp;&nbsp;P：<input type="text" name="child_count_p" value="<?php echo $child_count_p; ?>" size="2" /></td>
-->			  
            </tr>
			 <tr>
<!--			 
				<td width="15%">最高學歷</td>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="博士" name="degree"  <?php echo ($degree=="博士")? "checked":""; ?>/> 博士</div>
				  <div class="even"><input type="radio"  value="碩士" name="degree"  <?php echo ($degree=="碩士")? "checked":""; ?>/> 碩士</div>
				  <div class="odd"><input type="radio"  value="大學" name="degree"  <?php echo ($degree=="大學")? "checked":""; ?>/> 大學</div>
				  <div class="even"><input type="radio"  value="高中以下" name="degree"  <?php echo ($degree=="高中以下")? "checked":""; ?>/> 高中以下</div>
                </div></td>
-->				
                <td>職業</td>
			<?php  $pro = explode(':', $profession);
			  if ($pro[0] == "其他") { $profession = $pro[0];  $profession_other = $pro[1]; } 
			  else { $profession = $pro[0];  $profession_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="家管" name="profession"  <?php echo ($profession=="家管")? "checked":""; ?>/> 家管</div>
				  <div class="even"><input type="radio"  value="公教" name="profession"  <?php echo ($profession=="公教")? "checked":""; ?>/> 公教</div>
				  <div class="odd"><input type="radio"  value="私企" name="profession"  <?php echo ($profession=="私企")? "checked":""; ?>/> 私企</div>
				  <div class="even"><input type="radio"  value="其他" name="profession"  <?php echo ($profession=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="profession_other" value="<?php echo $profession_other; ?>" size="12" /></div>
                </div></td>
			 </tr>
<!--			  
			 <tr>
                <td width="15%">語言溝通</td>
			<?php  $lng = explode(':', $language);
			  if ($lng[0] == "其他") { $language = $lng[0];  $language_other = $lng[1]; } 
			  else { $language = $lng[0];  $language_other = ''; } ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="國語" name="language"  <?php echo ($language=="國語")? "checked":""; ?>/> 國語</div>
				  <div class="even"><input type="radio"  value="台語" name="language"  <?php echo ($language=="台語")? "checked":""; ?>/> 台語</div>
				  <div class="odd"><input type="radio"  value="英語" name="language"  <?php echo ($language=="英語")? "checked":""; ?>/> 英語</div>
				  <div class="even"><input type="radio"  value="其他" name="language"  <?php echo ($language=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="language_other" value="<?php echo $language_other; ?>" size="12" /></div>
                </div></td>				
                <td width="15%">後送醫院</td>
			<?php  $evh = explode(':', $evacuation_hospital);
			  if ($evh[0] == "其他") { $evacuation_hospital = $evh[0];  $evacuation_hospital_other = $evh[1]; } 
			  else { $evacuation_hospital = $evh[0];  $evacuation_hospital_other = ''; } ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="羅東博愛" name="evacuation_hospital"  <?php echo ($evacuation_hospital=="羅東博愛")? "checked":""; ?>/> 羅東博愛</div>
				  <div class="even"><input type="radio"  value="陽大" name="evacuation_hospital"  <?php echo ($evacuation_hospital=="陽大")? "checked":""; ?>/> 陽大</div>
				  <div class="odd"><input type="radio"  value="羅東聖母" name="evacuation_hospital"  <?php echo ($evacuation_hospital=="羅東聖母")? "checked":""; ?>/> 羅東聖母</div>
				  <div class="even"><input type="radio"  value="其他" name="evacuation_hospital"  <?php echo ($evacuation_hospital=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="evacuation_hospital_other" value="<?php echo $evacuation_hospital_other; ?>" size="12" /></div>
                </div></td>
              </tr>
-->			  
            <tr>
              <td><?php echo $entry_spouse_name; ?></td>
			  <td><input type="text" name="spouse_name" value="<?php echo $spouse_name; ?>" size="12" /></td>
<!--			  
			  <td></td>
			  <td></td>
-->			  
            </tr>
          </table>
        </div>
		
        <div id="tab-transfer" style="display:none;">
          <table class="form">
            <tr>
                <td width="200"><?php echo $entry_customer_room; ?></td>
                <td><select name="customer_room_id">
                    <?php foreach ($customer_rooms as $customer_room) { ?>
                    <option value="<?php echo $customer_room['customer_room_id']; ?>"><?php echo $customer_room['name']; ?></option>
                    <?php } ?>
                  </select></td>
            </tr>
			<tr>
              <td><?php echo $entry_description; ?></td>
              <td><input type="text" name="description" value="" size="40"/></td>
            </tr>
			<tr>
              <td><?php echo $entry_extra_period; ?></td>
              <td><input type="radio" name="extra_period" value="1" /> <?php echo $text_yes; ?></td>
            </tr>
            <tr>
			  <td><a id="button-transfer" class="button" onclick="addTransfer();"><span><?php echo $button_add_transfer; ?></span></a></td>
              <td></td>
            </tr>
          </table>
          <div id="transfer"></div>
        </div>
        <?php } ?>
		</div>
      </form>

	  <div class="footing"><div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>

   </div>
</div>


<script type="text/javascript"><!--
var contact_row = <?php echo $contact_row; ?>;

function addContact() {	
	html  = '<div id="tab-contact-' + contact_row + '" class="vtabs-content">';
	html += '  <input type="hidden" name="contact[' + contact_row + '][contact_id]" value="" />';
	html += '  <table class="form">'; 
	html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_name; ?></td>';
    html += '      <td><input type="text" name="contact[' + contact_row + '][name]" value="" /></td>';
    html += '    </tr>';	
	html += '	  <tr>';
    html += '		<td><span class="required">*</span> <?php echo $entry_telephone; ?></td>';
    html += '      <td><input type="text" name="contact[' + contact_row + '][telephone]" value="" /></td>';
    html += '    </tr>';
	html += '	  <tr>';
    html += '       <td><span class="required">*</span> 關係</td>';
	html += '  	 <td><div class="scrollbox">';
    html += '                 <div class="odd"><input type="radio"  value="夫" name="contact[' + contact_row + '][relationship]" /> 夫</div>';
	html += '     			   <div class="even"><input type="radio"  value="父母" name="contact[' + contact_row + '][relationship]" /> 父母</div>';
	html += '    			   <div class="odd"><input type="radio"  value="兄弟姐妹" name="contact[' + contact_row + '][relationship]"/> 兄弟姐妹</div>';
	html += '    			   <div class="even"><input type="radio"  value="其他" name="contact[' + contact_row + '][relationship]"/> 其他</div>';
    html += '        </div></td>';
    html += '    </tr>';
	//html += '    <tr>';
    //html += '      <td><?php echo $entry_default; ?></td>';
    //html += '      <td><input type="radio" name="contact[' + contact_row + '][default]" value="1" /></td>';
    //html += '    </tr>';
    html += '  </table>';
    html += '</div>';
	
	$('#tab-general').append(html);
	
	$('#contact-add').before('<a href="#tab-contact-' + contact_row + '" id="contact-' + contact_row + '"><?php echo $tab_contact; ?> ' + contact_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#vtabs a:first\').trigger(\'click\'); $(\'#contact-' + contact_row + '\').remove(); $(\'#tab-contact-' + contact_row + '\').remove(); return false;" /></a>');
		 
	$('.vtabs a').tabs();
	
	$('#contact-' + contact_row).trigger('click');
	
	contact_row++;
}

var child_row = <?php echo $child_row; ?>;

function addChild() {	
	html  = '<div id="tab-child-' + child_row + '" class="vtabs-content">';
	html += '  <input type="hidden" name="child[' + child_row + '][child_id]" value="" />';
	html += '  <table class="form">'; 
	html += '    <tr>';
    html += '      <td><?php echo $entry_name; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][name]" value=""  /></td>';
    html += '    </tr>';	
	html += '	  <tr>';
	html += '       <td><span class="required">*</span> <?php echo $entry_gender; ?></td>';
	html += '       <td><select name="child[' + child_row + '][gender]">';
	html += '		   <option value=""></option>';
	html += '         <option value="男">男</option>';
	html += '			<option value="女">女</option>';
	html += '		   </select></td>';
	html += '    </tr>';
	html += '    <tr>';
    html += '      <td><span class="required">*</span> <?php echo $entry_birthdate; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][birthdate]" value="" class="datepick" /><input type="text" name="child[' + child_row + '][birthdate_time]" class="time" value="" /></td>';
    html += '    </tr>';	
	html += '			  <tr>';
	html += '                <td><?php echo $entry_birthhospital; ?></td>';
	html += '                <td><input type="text" name="child[' + child_row + '][birthhospital]" value="" /></td>';
	html += '              </tr>';
	html += '    <tr>';
    html += '      <td><?php echo $entry_birthweight; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][birthweight]" value="" /> 公克</td>';
    html += '    </tr>';	
	html += '    <tr>';
    html += '      <td><?php echo $entry_birthhead; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][birthhead]" value="" /> 公分</td>';
    html += '    </tr>';	
	html += '			   <tr>';
	html += '                <td><?php echo $entry_birthchest; ?></td>';
	html += '                <td><input type="text" name="child[' + child_row + '][birthchest]" value="" /> 公分</td>';
	html += '              </tr>';
	html += '    <tr>';
    html += '      <td><?php echo $entry_birthlength; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][birthlength]" value="" /> 公分</td>';
    html += '    </tr>';	
	html += '    <tr>';
    html += '      <td><?php echo $entry_inweight; ?></td>';
    html += '      <td><input type="text" name="child[' + child_row + '][inweight]" value="" /> 公克</td>';
    html += '    </tr>';	
//	html += '    <tr>';
//    html += '      <td><?php echo $entry_inlength; ?></td>';
//    html += '      <td><input type="text" name="child[' + child_row + '][inlength]" value="" /> 公分</td>';
//    html += '    </tr>';	
//	html += '    <tr>';
//    html += '      <td><?php echo $entry_b_streptococcus_check; ?></td>';
//    html += '      <td><div class="scrollbox">';
//	html += '		           <div class="odd"><input type="radio"  value="陰性" name="child[' + child_row + '][b_streptococcus_check]" /> 陰性</div>';
//	html += '					<div class="even"><input type="radio"  value="陽性" name="child[' + child_row +'][b_streptococcus_check]" /> 陽性</div>';
//	html += '					<div class="odd"><input type="radio"  value="未做" name="child[' + child_row +'][b_streptococcus_check]" /> 未做</div>';
//	html += '					</div></td>';
//    html += '    </tr>';	
	html += '    <tr>';
    html += '      <td><?php echo $entry_apgar_score; ?></td>';
    html += '      <td>一分鐘：<input type="text" name="child[' + child_row + '][apgar_score_1]" value="" />&nbsp;&raquo;&raquo;&nbsp;五分鐘：<input type="text" name="child[' + child_row + '][apgar_score_5]" value="" /></td>';
    html += '    </tr>';	
<?php if ($customer_id) { ?>
	html += '	  <tr>';
	html += '       <td>寶寶床位</td>';
	html += '       <td><select name="child[<?php echo $child_row; ?>][bed_id]">';
	html += '	  	 <option value=""></option>';
<?php foreach ($child_beds as $childbed) { ?>
	html += '					<option value="<?php echo $childbed['bed_id']; ?>"><?php echo $childbed['name']; ?></option>';
<?php } ?>
	html += '       </select></td>';
	html += '    </tr>';
<?php } ?>
//	html += '    <tr>';
//    html += '      <td>寶寶預計離院時間</td>';
//    html += '    	<td><input type="text" name="child[' + child_row + '][date_leave]" class="childdateleave" value="" /><input type="text" name="child[' + child_row + '][date_leave_time]" class="time" value="" /></td>';
//    html += '    </tr>';
    html += '  </table>';
    html += '</div>';
	
	$('#tab-general').append(html);
	
	$('#child-add').before('<a href="#tab-child-' + child_row + '" id="child-' + child_row + '"><?php echo $tab_childdata; ?> ' + child_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#vtabs a:first\').trigger(\'click\'); $(\'#child-' + child_row + '\').remove(); $(\'#tab-child-' + child_row + '\').remove(); return false;" /></a>');
		 
	$('#tab-child-' + child_row + ' .datepick').datepicker({
		changeMonth: true,
		changeYear: true,
		minDate: "-80Y",
		maxDate: "+0D",
		dateFormat: 'yy-mm-dd'
	});

	$('#tab-child-' + child_row + ' .childdateleave').datepicker({
			dateFormat: 'yy-mm-dd'
	});
	$('#tab-child-' + child_row + ' .time').timepicker({
			timeFormat: 'hh:mm'
	});

	$('.vtabs a').tabs();
	
	$('#child-' + child_row).trigger('click');
	
	child_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('#transfer .pagination a').live('click', function() {
	$('#transfer').load(this.href);
	
	return false;
});			

$('#transfer').load('index.php?route=service/customer/transfer&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

function addTransfer() {
	$.ajax({
		url: 'index.php?route=service/customer/transfer&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-transfer input[name=\'description\']').val()) + '&customer_room_id=' + encodeURIComponent($('#tab-transfer select[name=\'customer_room_id\']').val()) + '&extra_period=' + encodeURIComponent($('#tab-transfer input[name=\'extra_period\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-transfer').attr('disabled', true);
			$('#transfer').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-transfer').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#transfer').html(html);
			
			$('#tab-transfer select[name=\'customer_room_id\']').val('');
			$('#tab-transfer input[name=\'description\']').val('');
			$('#tab-transfer input[name=\'extra_period\']').val('');
		}
	});
}

function removeTransfer(tid) {
	$.ajax({
		url: 'index.php?route=service/customer/deltransfer&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&customer_transfer_id='+ tid +'',
		type: 'post',
		dataType: 'html',
		//data: 'description=' + encodeURIComponent($('#tab-transfer input[name=\'description\']').val()) + '&customer_room_id=' + encodeURIComponent($('#tab-transfer select[name=\'customer_room_id\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			//$('#button-transfer').attr('disabled', true);
			$('#transfer').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			//$('#button-transfer').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#transfer').html(html);
			
			//$('#tab-transfer select[name=\'customer_room_id\']').val('');
			//$('#tab-transfer input[name=\'description\']').val('');
		}
	});
}
//--></script> 
<script type="text/javascript"><!--
$('.htabs a').tabs();
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--	
	if ($('input[name=profession]:checked').val() == '其他') {
		$('input[name=profession_other]').show();
	} else {
		$('input[name=profession_other]').hide();
	}
	$('input[name=profession]').click(function(){
		if ($('input[name=profession]:checked').val() == '其他') {
			$('input[name=profession_other]').show();
		} else {
			$('input[name=profession_other]').hide();
		}
	});	
	
	//-------------------------------//
	if ($('input[name=language]:checked').val() == '其他') {
		$('input[name=language_other]').show();
	} else {
		$('input[name=language_other]').hide();
	}
	$('input[name=language]').click(function(){
		if ($('input[name=language]:checked').val() == '其他') {
			$('input[name=language_other]').show();
		} else {
			$('input[name=language_other]').hide();
		}
	});
	
	//-----------------------------//
	if ($('input[name=evacuation_hospital]:checked').val() == '其他') {
		$('input[name=evacuation_hospital_other]').show();
	} else {
		$('input[name=evacuation_hospital_other]').hide();
	}
	$('input[name=evacuation_hospital]').click(function(){
		if ($('input[name=evacuation_hospital]:checked').val() == '其他') {
			$('input[name=evacuation_hospital_other]').show();
		} else {
			$('input[name=evacuation_hospital_other]').hide();
		}
	});	
	
	//---------------------------//
	if ($('input[name=childbirth_hospital]:checked').val() == '其他') {
		$('input[name=childbirth_hospital_other]').show();
	} else {
		$('input[name=childbirth_hospital_other]').hide();
	}
	$('input[name=childbirth_hospital]').click(function(){
		if ($('input[name=childbirth_hospital]:checked').val() == '其他') {
			$('input[name=childbirth_hospital_other]').show();
		} else {
			$('input[name=childbirth_hospital_other]').hide();
		}
	});	
//--></script> 
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	minDate: "-80Y",
	maxDate: "+0D",
	dateFormat: 'yy-mm-dd'
});
$('input[name=date_added], input[name=date_leave]').datepicker({
	changeMonth: true,
	changeYear: true,
	dateFormat: 'yy-mm-dd'
});
$('.time').timepicker({timeFormat: 'hh:mm'});
$('.childdateleave').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
});
//--></script> 
<?php echo $footer; ?>