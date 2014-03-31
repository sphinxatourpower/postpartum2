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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $child_name.'('.$customer_name.'的寶寶)';?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-nurse1b"><?php echo $tab_nurse1b; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse1b">
		<h3>一、基本資料</h3>
          <table class="form list">
			  <tr>
                <td class="center caption" width="120px">評估人員</td>
                <td><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
		      </tr>
			  <tr>
                <td class="center caption"><span class="required">*</span> 入住日期</td>
                <td><input type="text" name="date_added" value="<?php echo (isset($date_added) AND $date_added<>'') ? date($this->language->get('date_format_short'), strtotime($date_added)) : ""; ?>"/> <input class="time" type="text" name="date_added_time" value="<?php echo (isset($date_added) AND $date_added<>'') ? date($this->language->get('time_format_shortest'), strtotime($date_added)) : ""; ?>"/>
				<?php if (isset($error_date_added)) { ?>
                  <span class="error"><?php echo $error_date_added; ?></span>
                  <?php  } ?></td>
			<tr>
			</tr>
                <td class="center caption"><span class="required">*</span> 性別</td>
                <td><select name="gender">
					<option value=""></option>
                    <option value="男" <?php echo ($gender == "男") ? "selected=\"selected\"" : ""; ?>>男</option>
					<option value="女" <?php echo ($gender == "女") ? "selected=\"selected\"" : ""; ?>>女</option>
				</select>
				<?php if (isset($error_child_gender)) { ?>
                  <span class="error"><?php echo $error_child_gender; ?></span>
                  <?php } ?></td>
		     </tr>
			 <tr>
              <td class="center caption">生產方式</td>
              <td><div class="mybox">
                <div class="odd"><input type="radio" name="childbirth_method" value="NSD" <?php echo ($childbirth_method=="NSD")? "checked=\"checked\"":""; ?> /> NSD</div>
                <div class="even"><input type="radio" name="childbirth_method" value="C/S"  <?php echo ($childbirth_method=="C/S")? "checked=\"checked\"":""; ?>/> C/S</div>
				<div class="odd"><input type="radio" name="childbirth_method" value="VED"  <?php echo ($childbirth_method=="VED")? "checked=\"checked\"":""; ?>/> VED</div>
			  </div></td>
            </tr>
			<tr>
              <td class="center caption">出生醫院</td>
			  <td><input type="text"  value="<?php echo $birthhospital; ?>" name="birthhospital" size="30" /></td>
             </tr>
			 <tr>
				<td class="center caption"><span class="required">*</span> <?php echo $entry_birthdate; ?></td>
                <td><input type="text" name="birthdate" class="date" value="<?php echo $birthdate; ?>" />&nbsp;時間：<input type="text" name="birthdate_time" class="time" value="<?php echo $birthdate_time; ?>" />
                  <?php if (isset($error_child_birthdate)) { ?>
                  <span class="error"><?php echo $error_child_birthdate; ?></span>
                  <?php } ?></td>
			</tr>
			   <tr>
                <td class="center caption"><?php echo $entry_apgar_score; ?></td>
                <td>一分鐘：<input type="text" name="apgar_score_1" value="<?php echo $apgar_score_1; ?>" />
                  <?php if (isset($error_child_apgar_score_1)) { ?>
                  <span class="error"><?php echo $error_child_apgar_score_1; ?></span>
                  <?php } ?>&nbsp;&raquo;&raquo;&nbsp;五分鐘：<input type="text" name="apgar_score_5" value="<?php echo $apgar_score_5; ?>" />
                  <?php if (isset($error_child_apgar_score_5)) { ?>
                  <span class="error"><?php echo $error_child_apgar_score_5; ?></span>
                  <?php } ?></td>
			</tr>
			<tr>
                <td class="center caption">出生身高</td>
                <td><input type="text" name="birthlength" value="<?php echo $birthlength; ?>" /> 公分
                  <?php if (isset($error_child_birthlength)) { ?>
                  <span class="error"><?php echo $error_child_birthlength; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td class="center caption">出生頭圍</td>
                <td><input type="text" name="birthhead" value="<?php echo $birthhead; ?>" /> 公分
                  <?php if (isset($error_child_birthhead)) { ?>
                  <span class="error"><?php echo $error_child_birthhead; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td class="center caption">出生胸圍</td>
                <td><input type="text" name="birthchest" value="<?php echo $birthchest; ?>" /> 公分
                  <?php if (isset($error_child_birthchest)) { ?>
                  <span class="error"><?php echo $error_child_birthchest; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td class="center caption">出生體重</td>
                <td><input type="text" name="birthweight" value="<?php echo $birthweight; ?>" /> 公克
                  <?php if (isset($error_child_birthweight)) { ?>
                  <span class="error"><?php echo $error_child_birthweight; ?></span>
                  <?php } ?></td>
              </tr>
			   <tr>
                <td class="center caption">入住體重</td>
                <td><input type="text" name="inweight" value="<?php echo $inweight; ?>" /> 公克
                  <?php if (isset($error_child_inweight)) { ?>
                  <span class="error"><?php echo $error_child_inweight; ?></span>
                  <?php } ?></td>
              </tr>
			  <tr>
                <td class="center caption">入住黃疸數值</td>
                <td><input type="text" name="chk6" value="<?php echo $chk6; ?>" size="12" /> mg/dL</td>
              </tr>
			  <tr>
                <td class="center caption">入住體溫</td>
                <td><input type="text" name="chk2" value="<?php echo $chk2; ?>" size="12" /> ℃</td>
              </tr>
		  </table>
		  <h3>二、生產異常狀況</h3>
		  <table class="form list">
			 <tr>
			<?php $c8 = (is_serialized($chk8))? unserialize($chk8) : array(); $otherchecked8 = false; $chk8_other = '';
				if (!empty($c8)) {
					foreach ($c8 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked8 = true;  $chk8_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td width="120px"><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk8[]"  <?php echo (!empty($c8) && in_array("無", $c8 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="羊水內有胎便" name="chk8[]"  <?php echo (!empty($c8) && in_array("羊水內有胎便", $c8 ))? "checked":""; ?>/> 羊水內有胎便</div>
				  <div class="odd"><input type="checkbox"  value="呼吸暫停" name="chk8[]"  <?php echo (!empty($c8) && in_array("呼吸暫停", $c8 ))? "checked":""; ?>/> 呼吸暫停</div>
				  <div class="even"><input type="checkbox"  value="哭聲弱" name="chk8[]"  <?php echo (!empty($c8) && in_array("哭聲弱", $c8 ))? "checked":""; ?>/> 哭聲弱</div>
				  <div class="odd"><input type="checkbox"  value="皮膚發紫" name="chk8[]"  <?php echo (!empty($c8) && in_array("皮膚發紫", $c8 ))? "checked":""; ?>/> 皮膚發紫</div>
				  <div class="even"><input type="checkbox"  value="羊水吸入" name="chk8[]"  <?php echo (!empty($c8) && in_array("羊水吸入", $c8 ))? "checked":""; ?>/> 羊水吸入</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk8[]"  <?php echo ($otherchecked8)? "checked":""; ?>/> 其他</div><span id="chk8other"><input name="chk8_other" value="<?php echo $chk8_other; ?>" size="30" /></span>
                </div></td>
			</tr>
		  </table>
		  <h3>三、身體評估</h3>
		  <table class="form list">
			  <tr>
                <td class="caption center" width="120px" rowspan="3">預防接種</td>
				<td class="center">HBIG</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="已施打" name="chk5"  <?php echo ($chk5=="已施打")? "checked":""; ?>/> 已施打</div><span id="chk5other">日期：<input name="chk5_other" class="date" value="<?php echo $chk5_other; ?>" /></span>
				  <div class="even"><input type="radio"  value="未施打" name="chk5"  <?php echo ($chk5=="未施打")? "checked":""; ?>/> 未施打</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">BCG</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="已施打" name="chk7" <?php echo ($chk7=="已施打")? "checked":""; ?>/> 已施打</div><span id="chk7other">日期：<input name="chk7_other" class="date" value="<?php echo $chk7_other; ?>" /></span>
				  <div class="even"><input type="radio"  value="未施打" name="chk7" <?php echo ($chk7=="未施打")? "checked":""; ?>/> 未施打</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">B 型肝炎疫苗第一劑</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="已施打" name="chk9" <?php echo ($chk9=="已施打")? "checked":""; ?>/> 已施打</div><span id="chk9other">日期：<input name="chk9_other" class="date" value="<?php echo $chk9_other; ?>" /></span>
				  <div class="even"><input type="radio"  value="未施打" name="chk9" <?php echo ($chk9=="未施打")? "checked":""; ?>/> 未施打</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="5">皮膚</td>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="radio"  value="紅潤" name="chk16"  <?php echo ($chk16=="紅潤")? "checked":""; ?>/> 紅潤</div>
				  <div class="even"><input type="radio"  value="微黃" name="chk16"  <?php echo ($chk16=="微黃")? "checked":""; ?>/> 微黃</div>
				  <div class="odd"><input type="radio"  value="偏黃" name="chk16"  <?php echo ($chk16=="偏黃")? "checked":""; ?>/> 偏黃</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center" width="150px">紅疹</td>
				<?php $c17 = (is_serialized($chk17))? unserialize($chk17) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="臉部" name="chk17[]"  <?php echo (!empty($c17) && in_array("臉部", $c17 ))? "checked":""; ?>/> 臉部</div>
				  <div class="even"><input type="checkbox"  value="頸部" name="chk17[]"  <?php echo (!empty($c17) && in_array("頸部", $c17 ))? "checked":""; ?>/> 頸部</div>
				  <div class="odd"><input type="checkbox"  value="身體" name="chk17[]"  <?php echo (!empty($c17) && in_array("身體", $c17 ))? "checked":""; ?>/> 身體</div>
				  <div class="even"><input type="checkbox"  value="四肢" name="chk17[]"  <?php echo (!empty($c17) && in_array("四肢", $c17 ))? "checked":""; ?>/> 四肢</div>
				  <div class="odd"><input type="checkbox"  value="腹股溝" name="chk17[]"  <?php echo (!empty($c17) && in_array("腹股溝", $c17 ))? "checked":""; ?>/> 腹股溝</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">乾燥脫皮</td>
			<?php $c18 = (is_serialized($chk18))? unserialize($chk18) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="身體" name="chk18[]"  <?php echo (!empty($c18) && in_array("身體", $c18 ))? "checked":""; ?>/> 身體</div>
				  <div class="even"><input type="checkbox"  value="上肢" name="chk18[]"  <?php echo (!empty($c18) && in_array("上肢", $c18 ))? "checked":""; ?>/> 上肢</div>
				  <div class="odd"><input type="checkbox"  value="下肢" name="chk18[]"  <?php echo (!empty($c18) && in_array("下肢", $c18 ))? "checked":""; ?>/> 下肢</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">血管瘤</td>
			<?php $c21 = (is_serialized($chk21))? unserialize($chk21) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="額頭" name="chk21[]"  <?php echo (!empty($c21) && in_array("額頭", $c21 ))? "checked":""; ?>/> 額頭</div>
				  <div class="even"><input type="checkbox"  value="雙眉間" name="chk21[]"  <?php echo (!empty($c21) && in_array("雙眉間", $c21 ))? "checked":""; ?>/> 雙眉間</div>
				  <div class="odd"><input type="checkbox"  value="左上眼瞼" name="chk21[]"  <?php echo (!empty($c21) && in_array("左上眼瞼", $c21 ))? "checked":""; ?>/> 左上眼瞼</div>
				  <div class="even"><input type="checkbox"  value="右上眼瞼" name="chk21[]"  <?php echo (!empty($c21) && in_array("右上眼瞼", $c21 ))? "checked":""; ?>/> 右上眼瞼</div>
				  <div class="odd"><input type="checkbox"  value="頸背髮際處" name="chk21[]"  <?php echo (!empty($c21) && in_array("頸背髮際處", $c21 ))? "checked":""; ?>/> 頸背髮際處</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $c24 = (is_serialized($chk24))? unserialize($chk24) : array(); ?>
				<td colspan="2"><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="臉部皮下瘀血" name="chk24[]"  <?php echo (!empty($c24) && in_array("臉部皮下瘀血", $c24 ))? "checked":""; ?>/> 臉部皮下瘀血</div>
				  <div class="even"><input type="checkbox"  value="脂漏性皮膚炎" name="chk24[]"  <?php echo (!empty($c24) && in_array("脂漏性皮膚炎", $c24 ))? "checked":""; ?>/> 脂漏性皮膚炎</div>
				  <div class="odd"><input type="checkbox"  value="粟粒疹" name="chk24[]"  <?php echo (!empty($c24) && in_array("粟粒疹", $c24 ))? "checked":""; ?>/> 粟粒疹</div>
				  <div class="even"><input type="checkbox"  value="毒性紅斑" name="chk24[]"  <?php echo (!empty($c24) && in_array("毒性紅斑", $c24 ))? "checked":""; ?>/> 毒性紅斑</div>
				  <div class="odd"><input type="checkbox"  value="臀部蒙古斑" name="chk24[]"  <?php echo (!empty($c24) && in_array("臀部蒙古斑", $c24 ))? "checked":""; ?>/> 臀部蒙古斑</div>
				  <div class="even"><input type="checkbox"  value="針扎" name="chk24[]"  <?php echo (!empty($c24) && in_array("針扎", $c24 ))? "checked":""; ?>/> 針扎</div><span id="chk24other">左腳：<input name="chk24_l" value="<?php echo $chk24_l; ?>" />處，右腳：<input name="chk24_r" value="<?php echo $chk24_r; ?>" />處</span>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="2">眼</td>
				<td class="center">鞏膜出血點</td>
				<?php $c28 = (is_serialized($chk28))? unserialize($chk28) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左眼" name="chk28[]" <?php echo (!empty($c28) && in_array("左眼", $c28 ))? "checked":""; ?>/> 左眼</div>
				  <div class="even"><input type="checkbox"  value="右眼" name="chk28[]" <?php echo (!empty($c28) && in_array("右眼", $c28 ))? "checked":""; ?>/> 右眼</div>
                </div></td>
              </tr>
			  <tr>
				<td class="center">分泌物</td>
				<?php $c29 = (is_serialized($chk29))? unserialize($chk29) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左眼" name="chk29[]" <?php echo (!empty($c29) && in_array("左眼", $c29 ))? "checked":""; ?>/> 左眼</div>
				  <div class="even"><input type="checkbox"  value="右眼" name="chk29[]" <?php echo (!empty($c29) && in_array("右眼", $c29 ))? "checked":""; ?>/> 右眼</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="2">耳</td>
				<td class="center">耳前息肉</td>
				<?php $c30 = (is_serialized($chk30))? unserialize($chk30) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左耳" name="chk30[]" <?php echo (!empty($c30) && in_array("左耳", $c30 ))? "checked":""; ?>/> 左耳</div>
				  <div class="even"><input type="checkbox"  value="右耳" name="chk30[]" <?php echo (!empty($c30) && in_array("右耳", $c30 ))? "checked":""; ?>/> 右耳</div>
                </div></td>
              </tr>
			  <tr>
				<td class="center">耳前小竇</td>
				<?php $c31 = (is_serialized($chk31))? unserialize($chk31) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左耳" name="chk31[]" <?php echo (!empty($c31) && in_array("左耳", $c31 ))? "checked":""; ?>/> 左耳</div>
				  <div class="even"><input type="checkbox"  value="右耳" name="chk31[]" <?php echo (!empty($c31) && in_array("右耳", $c31 ))? "checked":""; ?>/> 右耳</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="caption center">口腔</td>
				<?php $c34 = (is_serialized($chk34))? unserialize($chk34) : array(); ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="鵝口瘡" name="chk34[]" <?php echo (!empty($c34) && in_array("鵝口瘡", $c34 ))? "checked":""; ?>/> 鵝口瘡</div>
				  <div class="even"><input type="checkbox"  value="唇裂" name="chk34[]" <?php echo (!empty($c34) && in_array("唇裂", $c34 ))? "checked":""; ?>/> 唇裂</div>
				  <div class="odd"><input type="checkbox"  value="顎裂" name="chk34[]" <?php echo (!empty($c34) && in_array("顎裂", $c34 ))? "checked":""; ?>/> 顎裂</div>
				  <div class="even"><input type="checkbox"  value="珍珠瘤" name="chk34[]" <?php echo (!empty($c34) && in_array("珍珠瘤", $c34 ))? "checked":""; ?>/> 珍珠瘤</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="caption center">臉頰</td>
				<?php $c33 = (is_serialized($chk33))? unserialize($chk33) : array(); ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="雙邊不對稱" name="chk33[]" <?php echo (!empty($c33) && in_array("雙邊不對稱", $c33 ))? "checked":""; ?>/> 雙邊不對稱</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="caption center">鼻</td>
				<?php $c32 = (is_serialized($chk32))? unserialize($chk32) : array(); ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="鼻塞" name="chk32[]" <?php echo (!empty($c32) && in_array("鼻塞", $c32 ))? "checked":""; ?>/> 鼻塞</div>
				  <div class="even"><input type="checkbox"  value="流鼻水" name="chk32[]" <?php echo (!empty($c32) && in_array("流鼻水", $c32 ))? "checked":""; ?>/> 流鼻水</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="4">頭頸部</td>
				<td class="center">頭皮血腫</td>
				<?php $c27 = (is_serialized($chk27))? unserialize($chk27) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左側" name="chk27[]" <?php echo (!empty($c27) && in_array("左側", $c27 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk27[]" <?php echo (!empty($c27) && in_array("右側", $c27 ))? "checked":""; ?>/> 右側</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center" width="150px">產瘤</td>
				<?php $c26 = (is_serialized($chk26))? unserialize($chk26) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左側" name="chk26[]" <?php echo (!empty($c26) && in_array("左側", $c26 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk26[]" <?php echo (!empty($c26) && in_array("右側", $c26 ))? "checked":""; ?>/> 右側</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">斜頸</td>
			<?php $c35 = (is_serialized($chk35))? unserialize($chk35) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="左斜頸" name="chk35[]" <?php echo (!empty($c35) && in_array("左斜頸", $c35 ))? "checked":""; ?>/> 左斜頸</div>
				  <div class="even"><input type="checkbox"  value="右斜頸" name="chk35[]" <?php echo (!empty($c35) && in_array("右斜頸", $c35 ))? "checked":""; ?>/> 右斜頸</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">囟門</td>
			<?php $c23 = (is_serialized($chk23))? unserialize($chk23) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk23[]" <?php echo (!empty($c23) && in_array("正常", $c23 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="膨出" name="chk23[]" <?php echo (!empty($c23) && in_array("膨出", $c23 ))? "checked":""; ?>/> 膨出</div>
				  <div class="odd"><input type="checkbox"  value="凹陷" name="chk23[]" <?php echo (!empty($c23) && in_array("凹陷", $c23 ))? "checked":""; ?>/> 凹陷</div>
				  <div class="even"><input type="checkbox"  value="破皮" name="chk23[]" <?php echo (!empty($c23) && in_array("破皮", $c23 ))? "checked":""; ?>/> 破皮</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center">胸部</td>
				<?php $c38 = (is_serialized($chk38))? unserialize($chk38) : array(); ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="胸骨凹陷" name="chk38[]" <?php echo (!empty($c38) && in_array("胸骨凹陷", $c38 ))? "checked":""; ?>/> 胸骨凹陷</div>
				  <div class="even"><input type="checkbox"  value="乳房肥大" name="chk38[]" <?php echo (!empty($c38) && in_array("乳房肥大", $c38 ))? "checked":""; ?>/> 乳房肥大</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center">腹部</td>
				<td class="center">肚臍</td>
				<?php $c44 = (is_serialized($chk44))? unserialize($chk44) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="已脫落" name="chk44[]" <?php echo (!empty($c44) && in_array("已脫落", $c44 ))? "checked":""; ?>/> 已脫落</div>
				  <div class="even"><input type="checkbox"  value="未脫落" name="chk44[]" <?php echo (!empty($c44) && in_array("未脫落", $c44 ))? "checked":""; ?>/> 未脫落</div>
				  <div class="odd"><input type="checkbox"  value="臍周圍紅腫" name="chk44[]" <?php echo (!empty($c44) && in_array("臍周圍紅腫", $c44 ))? "checked":""; ?>/> 臍周圍紅腫</div>
				  <div class="even"><input type="checkbox"  value="有分泌物" name="chk44[]" <?php echo (!empty($c44) && in_array("有分泌物", $c44 ))? "checked":""; ?>/> 有分泌物</div>
				  <div class="odd"><input type="checkbox"  value="臍疝氣" name="chk44[]" <?php echo (!empty($c44) && in_array("臍疝氣", $c44 ))? "checked":""; ?>/> 臍疝氣</div>
                </div></td>
              </tr>
			  <tr>
			    <td class="caption center" rowspan="2">四肢</td>
				<?php $c60 = (is_serialized($chk60))? unserialize($chk60) : array(); ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="上肢異常" name="chk60[]" <?php echo (!empty($c60) && in_array("上肢異常", $c60 ))? "checked":""; ?>/> 上肢異常</div>
				  <div class="even"><input type="checkbox"  value="下肢異常" name="chk60[]" <?php echo (!empty($c60) && in_array("下肢異常", $c60 ))? "checked":""; ?>/> 下肢異常</div>
                </div></td>
              </tr>
			  <tr>				
			    <td class="center">鎖骨</td>
				<?php $c36 = (is_serialized($chk36))? unserialize($chk36) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左邊骨折" name="chk36[]" <?php echo (!empty($c36) && in_array("左邊骨折", $c36 ))? "checked":""; ?>/> 左邊骨折</div>
				  <div class="even"><input type="checkbox"  value="右邊骨折" name="chk36[]" <?php echo (!empty($c36) && in_array("右邊骨折", $c36 ))? "checked":""; ?>/> 右邊骨折</div>
                </div></td>
              </tr>
			  <tr>
                <td class="caption center" rowspan="<?php echo ($gender == '男') ? "4" : "2"; ?>">生殖器</td>
				<td class="center"><?php echo $gender; ?></td>
				<td>
				<?php if ($gender == '男') { ?>
				<?php $c40 = (is_serialized($chk40))? unserialize($chk40) : array(); ?>
				<div class="mybox">
				  <div class="odd"><input type="checkbox"  value="尿道下裂" name="chk40[]" <?php echo (!empty($c40) && in_array("尿道下裂", $c40 ))? "checked":""; ?>/> 尿道下裂</div>
				  <div class="even"><input type="checkbox"  value="割包皮手術" name="chk40[]" <?php echo (!empty($c40) && in_array("割包皮手術", $c40 ))? "checked":""; ?>/> 割包皮手術</div>
                </div>
				<?php } elseif ($gender == '女') { ?>
				<?php $c40 = (is_serialized($chk40))? unserialize($chk40) : array(); ?>
				<div class="mybox">
				  <div class="odd"><input type="checkbox"  value="假性月經" name="chk40[]" <?php echo (!empty($c40) && in_array("假性月經", $c40 ))? "checked":""; ?>/> 假性月經</div>
				  <div class="even"><input type="checkbox"  value="分泌物" name="chk40[]" <?php echo (!empty($c40) && in_array("分泌物", $c40 ))? "checked":""; ?>/> 分泌物</div>
                </div>
				<?php } ?>
				</td>
              </tr>
			  <tr>
			    <td class="center">疝氣</td>
				<?php $c41 = (is_serialized($chk41))? unserialize($chk41) : array(); ?>
			    <td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左邊" name="chk41[]" <?php echo (!empty($c41) && in_array("左邊", $c41 ))? "checked":""; ?>/> 左邊</div>
				  <div class="even"><input type="checkbox"  value="右邊" name="chk41[]" <?php echo (!empty($c41) && in_array("右邊", $c41 ))? "checked":""; ?>/> 右邊</div>
                </div></td>
			  </tr>
			  <?php if ($gender == '男') { ?>
			  <tr>
			    <td class="center">隱睪</td>
				<?php $c42 = (is_serialized($chk42))? unserialize($chk42) : array(); ?>
			    <td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左邊" name="chk42[]" <?php echo (!empty($c42) && in_array("左邊", $c42 ))? "checked":""; ?>/> 左邊</div>
				  <div class="even"><input type="checkbox"  value="右邊" name="chk42[]" <?php echo (!empty($c42) && in_array("右邊", $c42 ))? "checked":""; ?>/> 右邊</div>
                </div></td>
			  </tr>
			  <tr>
			    <td class="center">陰囊水腫</td>
				<?php $c43 = (is_serialized($chk43))? unserialize($chk43) : array(); ?>
			    <td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="左邊" name="chk43[]" <?php echo (!empty($c43) && in_array("左邊", $c43 ))? "checked":""; ?>/> 左邊</div>
				  <div class="even"><input type="checkbox"  value="右邊" name="chk43[]" <?php echo (!empty($c43) && in_array("右邊", $c43 ))? "checked":""; ?>/> 右邊</div>
                </div></td>
			  </tr>
			  <?php } ?>
			  <tr>
                <td class="caption center" rowspan="3">排泄</td>
				<td class="center">大便顏色</td>
				<?php $c50 = (is_serialized($chk50))? unserialize($chk50) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk50[]" <?php echo (!empty($c50) && in_array("正常", $c50 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="黃" name="chk50[]" <?php echo (!empty($c50) && in_array("黃", $c50 ))? "checked":""; ?>/> 黃</div>
				  <div class="odd"><input type="checkbox"  value="黃綠" name="chk50[]" <?php echo (!empty($c50) && in_array("黃綠", $c50 ))? "checked":""; ?>/> 黃綠</div>
				  <div class="even"><input type="checkbox"  value="綠" name="chk50[]" <?php echo (!empty($c50) && in_array("綠", $c50 ))? "checked":""; ?>/> 綠</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center" width="150px">大便性質</td>
				<?php $c51 = (is_serialized($chk51))? unserialize($chk51) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="糊便" name="chk51[]" <?php echo (!empty($c51) && in_array("糊便", $c51 ))? "checked":""; ?>/> 糊便</div>
				  <div class="even"><input type="checkbox"  value="軟便" name="chk51[]" <?php echo (!empty($c51) && in_array("軟便", $c51 ))? "checked":""; ?>/> 軟便</div>
				  <div class="odd"><input type="checkbox"  value="水便" name="chk51[]" <?php echo (!empty($c51) && in_array("水便", $c51 ))? "checked":""; ?>/> 水便</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">小便</td>
			<?php $c52 = (is_serialized($chk52))? unserialize($chk52) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk52[]" <?php echo (!empty($c52) && in_array("正常", $c52 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="尿酸結晶" name="chk52[]" <?php echo (!empty($c52) && in_array("尿酸結晶", $c52 ))? "checked":""; ?>/> 尿酸結晶</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="4">神經肌肉</td>
				<td class="center">活動力</td>
				<td><div class="mybox">
				  <div class="odd"><input type="radio"  value="佳" name="chk12" <?php echo ($chk12=="佳")? "checked":""; ?>/> 佳</div>
				  <div class="even"><input type="radio"  value="可" name="chk12" <?php echo ($chk12=="可")? "checked":""; ?>/> 可</div>
				  <div class="odd"><input type="radio"  value="差" name="chk12" <?php echo ($chk12=="差")? "checked":""; ?>/> 差</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center" width="150px">姿勢</td>
				<?php $c13 = (is_serialized($chk13))? unserialize($chk13) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="屈曲狀" name="chk13[]" <?php echo (!empty($c13) && in_array("屈曲狀", $c13 ))? "checked":""; ?>/> 屈曲狀</div>
				  <div class="even"><input type="checkbox"  value="軟弱伸展" name="chk13[]" <?php echo (!empty($c13) && in_array("軟弱伸展", $c13 ))? "checked":""; ?>/> 軟弱伸展</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">哭聲</td>
			<?php $c61 = (is_serialized($chk61))? unserialize($chk61) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="宏亮" name="chk61[]" <?php echo (!empty($c61) && in_array("宏亮", $c61 ))? "checked":""; ?>/> 宏亮</div>
				  <div class="even"><input type="checkbox"  value="微弱" name="chk61[]" <?php echo (!empty($c61) && in_array("微弱", $c61 ))? "checked":""; ?>/> 微弱</div>
				  <div class="odd"><input type="checkbox"  value="沙啞" name="chk61[]" <?php echo (!empty($c61) && in_array("沙啞", $c61 ))? "checked":""; ?>/> 沙啞</div>
				  <div class="even"><input type="checkbox"  value="尖銳" name="chk61[]" <?php echo (!empty($c61) && in_array("尖銳", $c61 ))? "checked":""; ?>/> 尖銳</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center">反射</td>
			<?php $c62 = (is_serialized($chk62))? unserialize($chk62) : array(); ?>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="吸吮" name="chk62[]" <?php echo (!empty($c62) && in_array("吸吮", $c62 ))? "checked":""; ?>/> 吸吮</div>
				  <div class="even"><input type="checkbox"  value="尋乳" name="chk62[]" <?php echo (!empty($c62) && in_array("尋乳", $c62 ))? "checked":""; ?>/> 尋乳</div>
                  <div class="odd"><input type="checkbox"  value="抓握" name="chk62[]" <?php echo (!empty($c62) && in_array("抓握", $c62 ))? "checked":""; ?>/> 抓握</div>
				  <div class="even"><input type="checkbox"  value="驚嚇" name="chk62[]" <?php echo (!empty($c62) && in_array("驚嚇", $c62 ))? "checked":""; ?>/> 驚嚇</div>
                  <div class="odd"><input type="checkbox"  value="踏步" name="chk62[]" <?php echo (!empty($c62) && in_array("踏步", $c62 ))? "checked":""; ?>/> 踏步</div>
				  <div class="even"><input type="checkbox"  value="巴比斯金氏" name="chk62[]" <?php echo (!empty($c62) && in_array("巴比斯金氏", $c62 ))? "checked":""; ?>/> 巴比斯金氏</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center">臀部</td>
				<td class="center">紅臀</td>
				<td><div class="mybox">
				  <div class="odd"><input type="radio"  value="輕度" name="chk55" <?php echo ($chk55=="輕度")? "checked":""; ?>/> 輕度</div>
				  <div class="even"><input type="radio"  value="中度" name="chk55" <?php echo ($chk55=="中度")? "checked":""; ?>/> 中度</div>
				  <div class="odd"><input type="radio"  value="重度" name="chk55" <?php echo ($chk55=="重度")? "checked":""; ?>/> 重度</div>
                </div></td>
              </tr>
			  <tr>
				<td class="caption center">其他說明</td>
				<td class="center">說明</td>
				<td><textarea name="chk67" cols="65" rows="10"><?php echo $chk67; ?></textarea></td>
			  </tr>
		  </table>
		</div>
	  </form>
        <div id="tab-datatable">
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
	<div class="footing">
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
$('#tabs a').tabs(); 
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

		
<?php for ($i = 8; $i <= 8 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 5; $i <= 9 ;$i+=2) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('已施打',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('已施打',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 24; $i <= 24 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('針扎',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('針扎',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

});		
	
//--></script>
<script type="text/javascript"><!--	
	/*if ($('input[name=chk8]:checked').val() == '其他') {
		$('span#chk8other').show();
	} else {
		$('span#chk8other').hide();
	}
	if ($('input[name^=chk8]:checked').val() == '其他') {
		$('span#chk8other').show();
	} else {
		$('span#chk8other').hide();
	}
	$('input[name^=chk8]').click(function(e){
		v = $(this).val();

		if (v == '其他' && $(this).is('checked')) {
			//$('span#chk8other').show();
			$('span#chk8other').hide();
		} else {
			$('span#chk8other').show();
		}
	});
	
<?php for ($i = 26; $i <= 27 ;$i++) { ?>
	if ($('input[name=chk<?php echo $i; ?>]:checked').val() == '有') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name=chk<?php echo $i; ?>]').click(function(){
		v = $(this).val();
		
		if (v == '有') {
			$('span#chk<?php echo $i; ?>other').show();
		} else {
			$('span#chk<?php echo $i; ?>other').hide();
		}
	});	
	//-------------------------//
<?php } ?>
*/

<?php for ($i = 8; $i <= 8 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 5; $i <= 9 ;$i+=2) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('已施打',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('已施打',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 24; $i <= 24;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('針扎',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('針扎',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

/*
<?php for ($i = 37; $i <= 37; $i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('有',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('有',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 47; $i <= 48 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('有',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('有',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 56; $i <= 56 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('不正確',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('不正確',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>
*/
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	minDate: "-0D",
	dateFormat: 'yy-mm-dd'
});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'hh:mm'
});
$('.time').timepicker({timeFormat: 'hh:mm'});
//--></script> 
<?php echo $footer; ?>