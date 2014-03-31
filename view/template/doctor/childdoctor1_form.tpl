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
      <div id="tabs" class="htabs"><a href="#tab-childdoctor"><?php echo $tab_childdoctor1; ?></a><a href="#tab-childdoctor2"><?php echo $tab_childdoctor1."[二]"; ?></a><a href="#tab-childdoctor3"><?php echo $tab_childdoctor1."[三]"; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-childdoctor">
          <table class="form list">
			   <tr>
                <td width="15%">醫師</td>
                <td width="35%"><select name="doctor_id">
                    <?php foreach ($doctors as $doctor) { ?>
                    <?php if ($doctor['user_id'] == $doctor_id) { ?>
                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
                <td width="15%" rowspan="2">皮下出血點</td>
			<?php  $c2 = explode(':', $chk2);
			  if ($c2[0] == "有" AND isset($c2[1])) { $chk2 = $c2[0];  $chk2_other = $c2[1]; } 
			  else { $chk2 = $c2[0];  $chk2_other = ''; } ?>
				<td width="35%" rowspan="2"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk2"  <?php echo ($chk2=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk2"  <?php echo ($chk2=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk2other">部位<input name="chk2_other" value="<?php echo $chk2_other; ?>" size="12" /></span></div>
                </div></td>
              </tr>
			  <tr>
                <td>黃疸值</td>
                <td><input type="text" name="chk1" value="<?php echo $chk1; ?>" size="12" /> mg/DL</td>
              </tr>
			  <tr>
                <td>頭皮血腫</td>
			<?php  $c3 = explode(':', $chk3);
			  if ($c3[0] == "有" AND isset($c3[1])) { $chk3 = $c3[0];  $chk3_other = $c3[1]; } 
			  else { $chk3 = $c3[0];  $chk3_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk3"  <?php echo ($chk3=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk3"  <?php echo ($chk3=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk3other">部位<input name="chk3_other" value="<?php echo $chk3_other; ?>" size="12" /></span></div>
                </div></td>
                <td>產瘤</td>
			<?php  $c4 = explode(':', $chk4);
			  if ($c4[0] == "有") { $chk4 = $c4[0];  $chk4_other = $c4[1]; } 
			  else { $chk4 = $c4[0];  $chk4_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk4"  <?php echo ($chk4=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk4"  <?php echo ($chk4=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk4other">部位及大小<input name="chk4_other" value="<?php echo $chk4_other; ?>" size="12" /></span></div>
                </div></td>
              </tr>
			  <tr>
                <td>微血管瘤</td>
			<?php  $c5 = explode(':', $chk5);
			  if ($c5[0] == "有") { $chk5 = $c5[0];  $chk5_other = $c5[1]; } 
			  else { $chk5 = $c5[0];  $chk5_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk5"  <?php echo ($chk5=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk5"  <?php echo ($chk5=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk5other">部位<input name="chk5_other" value="<?php echo $chk5_other; ?>" size="12" /></span></div>
                </div></td>
                <td>異位性皮膚炎</td>
			<?php  $c6 = explode(':', $chk6);
			  if ($c6[0] == "有") { $chk6 = $c6[0];  $chk6_other = $c6[1]; } 
			  else { $chk6 = $c6[0];  $chk6_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk6"  <?php echo ($chk6=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk6"  <?php echo ($chk6=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk6other">部位<input name="chk6_other" value="<?php echo $chk6_other; ?>" size="12" /></span></div>
                </div></td>
              </tr>
			  <tr>
                <td>嘴唇發紺</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk7"  <?php echo ($chk7=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk7"  <?php echo ($chk7=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>四肢發紺</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk8"  <?php echo ($chk8=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk8"  <?php echo ($chk8=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td>尿布疹</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk9"  <?php echo ($chk9=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk9"  <?php echo ($chk9=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>包皮發炎</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk10"  <?php echo ($chk10=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk10"  <?php echo ($chk10=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
          </table>
		</div>
        <div id="tab-childdoctor2">
          <table class="form list">
			  <tr>
                <td width="15%">臍帶發炎</td>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk11"  <?php echo ($chk11=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk11"  <?php echo ($chk11=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td width="15%">頭部外型</td>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk12"  <?php echo ($chk12=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk12"  <?php echo ($chk12=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
                <td>結膜出血</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk13"  <?php echo ($chk13=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk13"  <?php echo ($chk13=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>粟粒疹</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk14"  <?php echo ($chk14=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk14"  <?php echo ($chk14=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td>兔唇</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk15"  <?php echo ($chk15=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk15"  <?php echo ($chk15=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>顎裂</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk16"  <?php echo ($chk16=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk16"  <?php echo ($chk16=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td>斜頸</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk17"  <?php echo ($chk17=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk17"  <?php echo ($chk17=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>鎖骨斷裂</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk18"  <?php echo ($chk18=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk18"  <?php echo ($chk18=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td>頸部硬塊</td>
			<?php  $c19 = explode(':', $chk19);
			  if ($c19[0] == "有") { $chk19 = $c19[0];  $chk19_other = $c19[1]; } 
			  else { $chk19 = $c19[0];  $chk19_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk19"  <?php echo ($chk19=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk19"  <?php echo ($chk19=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk19other">大小<input name="chk19_other" value="<?php echo $chk19_other; ?>" size="12" /></span></div>
                </div></td>
                <td>兩手活動</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk20"  <?php echo ($chk20=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk20"  <?php echo ($chk20=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
                <td>副乳</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk21"  <?php echo ($chk21=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk21"  <?php echo ($chk21=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>胸廓外型</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk22"  <?php echo ($chk22=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk22"  <?php echo ($chk22=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
          </table>
		</div>
        <div id="tab-childdoctor3">
          <table class="form">
			  <tr>
                <td width="15%">呼吸聲</td>
				<?php $c23 = (!empty($chk23))? unserialize($chk23) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk23[]"  <?php echo (!empty($c23) && in_array("正常", $c23 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="不正常" name="chk23[]"  <?php echo (!empty($c23) && in_array("不正常", $c23 ))? "checked":""; ?>/> 不正常</div>
				  <div class="odd"><input type="checkbox"  value="胸、肋凹" name="chk23[]"  <?php echo (!empty($c23) && in_array("胸、肋凹", $c23 ))? "checked":""; ?>/> 胸、肋凹</div>
				  <div class="even"><input type="checkbox"  value="呼吸急促" name="chk23[]"  <?php echo (!empty($c23) && in_array("呼吸急促", $c23 ))? "checked":""; ?>/> 呼吸急促</div>
                </div></td>
                <td width="15%">心跳聲</td>
				<?php $c24 = (!empty($chk24))? unserialize($chk24) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk24[]"  <?php echo (!empty($c24) && in_array("正常", $c24 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="不正常" name="chk24[]"  <?php echo (!empty($c24) && in_array("不正常", $c24 ))? "checked":""; ?>/> 不正常</div>
				  <div class="odd"><input type="checkbox"  value="心律不整" name="chk24[]"  <?php echo (!empty($c24) && in_array("心律不整", $c24 ))? "checked":""; ?>/> 心律不整</div>
				  <div class="even"><input type="checkbox"  value="心雜音" name="chk24[]"  <?php echo (!empty($c24) && in_array("心雜音", $c24 ))? "checked":""; ?>/> 心雜音</div>
                </div></td>
              </tr>
			  <tr>
                <td>腹部外型</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk25"  <?php echo ($chk25=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk25"  <?php echo ($chk25=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
                <td>腹脹</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk26"  <?php echo ($chk26=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk26"  <?php echo ($chk26=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
                <td>兩腳活動</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk27"  <?php echo ($chk27=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk27"  <?php echo ($chk27=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
                <td>兩腳等長</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk28"  <?php echo ($chk28=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk28"  <?php echo ($chk28=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
                <td>大陰唇紅腫</td>
				<?php $c29 = (!empty($chk29))? unserialize($chk29) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk29[]"  <?php echo (!empty($c29) && in_array("無", $c29 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk29[]"  <?php echo (!empty($c29) && in_array("有", $c29 ))? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="checkbox"  value="左側" name="chk29[]"  <?php echo (!empty($c29) && in_array("左側", $c29 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk29[]"  <?php echo (!empty($c29) && in_array("右側", $c29 ))? "checked":""; ?>/> 右側</div>
                </div></td>
                <td>陰囊水腫</td>
				<?php $c30 = (!empty($chk30))? unserialize($chk30) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk30[]"  <?php echo (!empty($c30) && in_array("無", $c30 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk30[]"  <?php echo (!empty($c30) && in_array("有", $c30 ))? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="checkbox"  value="左側" name="chk30[]"  <?php echo (!empty($c30) && in_array("左側", $c30 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk30[]"  <?php echo (!empty($c30) && in_array("右側", $c30 ))? "checked":""; ?>/> 右側</div>
                </div></td>
              </tr>
			  <tr>
                <td>疝氣</td>
				<?php $c31 = (!empty($chk31))? unserialize($chk31) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk31[]"  <?php echo (!empty($c31) && in_array("無", $c31 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk31[]"  <?php echo (!empty($c31) && in_array("有", $c31 ))? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="checkbox"  value="左側" name="chk31[]"  <?php echo (!empty($c31) && in_array("左側", $c31 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk31[]"  <?php echo (!empty($c31) && in_array("右側", $c31 ))? "checked":""; ?>/> 右側</div>
                </div></td>
                <td>隱睪症</td>
				<?php $c32 = (!empty($chk32))? unserialize($chk32) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk32[]"  <?php echo (!empty($c32) && in_array("無", $c32 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk32[]"  <?php echo (!empty($c32) && in_array("有", $c32 ))? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="checkbox"  value="左側" name="chk32[]"  <?php echo (!empty($c32) && in_array("左側", $c32 ))? "checked":""; ?>/> 左側</div>
				  <div class="even"><input type="checkbox"  value="右側" name="chk32[]"  <?php echo (!empty($c32) && in_array("右側", $c32 ))? "checked":""; ?>/> 右側</div>
                </div></td>
              </tr>
			  <tr>
                <td>其他事項</td>
				<td><textarea name="chk33" cols="65" rows="10"><?php echo $chk33; ?></textarea></td>
				<td></td>
				<td></td>
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
	if ($('input[name=chk2]:checked').val() == '有') {
		$('#chk2other').show();
	} else {
		$('#chk2other').hide();
	}
	$('input[name=chk2]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk2other').show();
		} else {
			$('span#chk2other').hide();
		}
	});	
	
	//-------------------------------//
	if ($('input[name=chk3]:checked').val() == '有') {
		$('#chk3other').show();
	} else {
		$('#chk3other').hide();
	}
	$('input[name=chk3]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk3other').show();
		} else {
			$('span#chk3other').hide();
		}
	});	
	
	//-----------------------------//
	if ($('input[name=chk4]:checked').val() == '有') {
		$('#chk4other').show();
	} else {
		$('#chk4other').hide();
	}
	$('input[name=chk4]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk4other').show();
		} else {
			$('span#chk4other').hide();
		}
	});	
	
	//---------------------------//
	if ($('input[name=chk5]:checked').val() == '有') {
		$('#chk5other').show();
	} else {
		$('#chk5other').hide();
	}
	$('input[name=chk5]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk5other').show();
		} else {
			$('span#chk5other').hide();
		}
	});	
	
	//---------------------------//
	if ($('input[name=chk6]:checked').val() == '有') {
		$('#chk6other').show();
	} else {
		$('#chk6other').hide();
	}
	$('input[name=chk6]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk6other').show();
		} else {
			$('span#chk6other').hide();
		}
	});	
	
	//---------------------------//
	if ($('input[name=chk19]:checked').val() == '有') {
		$('#chk19other').show();
	} else {
		$('#chk19other').hide();
	}
	$('input[name=chk19]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('span#chk19other').show();
		} else {
			$('span#chk19other').hide();
		}
	});	
//--></script>
<?php echo $footer; ?>