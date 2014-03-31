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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $customer_name;?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-breast2c"><?php echo $tab_breast2c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-breast2c">
          <table class="form list">
			  <tr>
                <td width="15%">服務人員</td>
                <td colspan="2"><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr><td class="caption" colspan="3">1.寶寶現在的餵食</td></tr>
			  <tr>
				<td></td>
				<td>白天哺餵母乳</td>
				<td>晚上哺餵母乳</td>
			  </tr>
			  <tr>
                <td>多久餵一次</td>
                <td><textarea name="chk1a" cols="65" rows="5"><?php echo $chk1a; ?></textarea></td>
                <td><textarea name="chk1b" cols="65" rows="5"><?php echo $chk1b; ?></textarea></td>
              </tr>
			  <tr>
                <td>一次餵多久</td>
                <td><textarea name="chk2a" cols="65" rows="5"><?php echo $chk2a; ?></textarea></td>
                <td><textarea name="chk2b" cols="65" rows="5"><?php echo $chk2b; ?></textarea></td>
              </tr>
			  <tr>
                <td>每餐間隔最久時間</td>
                <td><textarea name="chk3a" cols="65" rows="5"><?php echo $chk3a; ?></textarea></td>
                <td><textarea name="chk3b" cols="65" rows="5"><?php echo $chk3b; ?></textarea></td>
              </tr>
            <tr>
				<td>寶寶不在媽媽身邊的時間最久多久</td>
                <td><textarea name="chk4a" cols="65" rows="5"><?php echo $chk4a; ?></textarea></td>
                <td><textarea name="chk4b" cols="65" rows="5"><?php echo $chk4b; ?></textarea></td>
            </tr>
            <tr>
				<td>餵一側，或兩側乳房</td>
                <td><textarea name="chk5a" cols="65" rows="5"><?php echo $chk5a; ?></textarea></td>
                <td><textarea name="chk5b" cols="65" rows="5"><?php echo $chk5b; ?></textarea></td>
            </tr>
			<tr><td class="caption" colspan="3">2.寶寶的健康及行為</td></tr>
            <tr>
				<td>出生體重</td>
                <td colspan="2"><textarea name="chk6" cols="65" rows="5"><?php echo $chk6; ?></textarea></td>
            </tr>
            <tr>
				<td>現在體重</td>
                <td colspan="2"><textarea name="chk7" cols="65" rows="5"><?php echo $chk7; ?></textarea></td>
            </tr>
			<tr>
				<td>尿量(多或少於每天六次)</td>
                <td colspan="2"><textarea name="chk8" cols="65" rows="5"><?php echo $chk8; ?></textarea></td>
            </tr>
			<tr>
				<td>大便(軟及黃或黃綠色，硬或綠色，次數)</td>
                <td colspan="2"><textarea name="chk9" cols="65" rows="5"><?php echo $chk9; ?></textarea></td>
            </tr>
			<tr>
				<td>餵食行為(食慾，吐奶或溢奶)</td>
                <td colspan="2"><textarea name="chk10" cols="65" rows="5"><?php echo $chk10; ?></textarea></td>
            </tr>
			<tr>
				<td>睡眠狀況</td>
                <td colspan="2"><textarea name="chk11" cols="65" rows="5"><?php echo $chk11; ?></textarea></td>
            </tr>
			<tr>
				<td>疾病(有/無)</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk12" value="有"  <?php echo ($chk12=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk12" value="無"  <?php echo ($chk12=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk12_text" cols="65" rows="5"><?php echo $chk12_text; ?></textarea></td>
            </tr>
			<tr>
				<td>雙胞胎(是/否)</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk13" value="是"  <?php echo ($chk13=="是")? "checked=\"checked\"":""; ?>/> 是</div>
					<div class="even"><input type="radio" name="chk13" value="否"  <?php echo ($chk13=="否")? "checked=\"checked\"":""; ?>/> 否</div>
				</div></td>
                <td><textarea name="chk13_text" cols="65" rows="5"><?php echo $chk13_text; ?></textarea></td>
            </tr>
			<tr><td class="caption" colspan="3">3.懷孕、生產、早期的餵食</td></tr>
			<tr>
				<td>產前門診(有/無) 有討論哺餵母乳嗎?</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk14" value="有"  <?php echo ($chk14=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk14" value="無"  <?php echo ($chk14=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk14_text" cols="65" rows="5"><?php echo $chk14_text; ?></textarea></td>
            </tr>
			<tr>
				<td>生產後早期接觸寶寶(頭半到一個小時)</td>
                <td colspan="2"><textarea name="chk15" cols="65" rows="5"><?php echo $chk15; ?></textarea></td>
            </tr>
			<tr>
				<td>親子同室  (第一次餵食的時間)</td>
                <td colspan="2"><textarea name="chk16" cols="65" rows="5"><?php echo $chk16; ?></textarea></td>
            </tr>
			<tr>
				<td>奶水來之前的食物 (給什麼)</td>
                <td colspan="2"><textarea name="chk17" cols="65" rows="5"><?php echo $chk17; ?></textarea></td>
            </tr>
			<tr>
				<td>給媽媽的配方奶樣品(有/無)  如何給予</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk18" value="有"  <?php echo ($chk18=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk18" value="無"  <?php echo ($chk18=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk18_text" cols="65" rows="5"><?php echo $chk18_text; ?></textarea></td>
            </tr>
			<tr>
				<td>在生產之後有關哺乳的幫助(有/無)</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk19" value="有"  <?php echo ($chk19=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk19" value="無"  <?php echo ($chk19=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk19_text" cols="65" rows="5"><?php echo $chk19_text; ?></textarea></td>
            </tr>
			<tr><td class="caption" colspan="3">4.媽媽的情況及家庭計劃</td></tr>
			<tr>
				<td>年紀</td>
                <td colspan="2"><textarea name="chk20" cols="65" rows="5"><?php echo $chk20; ?></textarea></td>
            </tr>
			<tr>
				<td>乳房的情形</td>
                <td colspan="2"><textarea name="chk21" cols="65" rows="5"><?php echo $chk21; ?></textarea></td>
            </tr>
			<tr>
				<td>健康情形</td>
                <td colspan="2"><textarea name="chk22" cols="65" rows="5"><?php echo $chk22; ?></textarea></td>
            </tr>
			<tr>
				<td>家庭計劃(有/無) 方式</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk23" value="有"  <?php echo ($chk23=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk23" value="無"  <?php echo ($chk23=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk23_text" cols="65" rows="5"><?php echo $chk23_text; ?></textarea></td>
            </tr>
			<tr>
				<td>(有/無)酒精抽菸、咖啡、其他藥物</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk24" value="有"  <?php echo ($chk24=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk24" value="無"  <?php echo ($chk24=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk24_text" cols="65" rows="5"><?php echo $chk24_text; ?></textarea></td>
            </tr>
			<tr>
				<td>哺餵母乳的動機</td>
                <td colspan="2"><textarea name="chk25" cols="65" rows="5"><?php echo $chk25; ?></textarea></td>
            </tr>
			<tr><td class="caption" colspan="3">5.以前餵食寶寶的經驗</td></tr>
			<tr>
				<td>以前有幾個孩子</td>
                <td colspan="2"><textarea name="chk26" cols="65" rows="5"><?php echo $chk26; ?></textarea></td>
            </tr>
			<tr>
				<td>有幾個餵母乳</td>
                <td colspan="2"><textarea name="chk27" cols="65" rows="5"><?php echo $chk27; ?></textarea></td>
            </tr>
			<tr>
				<td>使用任何奶瓶(有/無)</td>
				<td><div class="mybox">
					<div class="odd"><input type="radio" name="chk28" value="有"  <?php echo ($chk28=="有")? "checked=\"checked\"":""; ?>/> 有</div>
					<div class="even"><input type="radio" name="chk28" value="無"  <?php echo ($chk28=="無")? "checked=\"checked\"":""; ?>/> 無</div>
				</div></td>
                <td><textarea name="chk28_text" cols="65" rows="5"><?php echo $chk28_text; ?></textarea></td>
            </tr>
			<tr>
				<td>經驗好或不好</td>
                <td colspan="2"><textarea name="chk29" cols="65" rows="5"><?php echo $chk29; ?></textarea></td>
            </tr>
			<tr>
				<td>原因</td>
                <td colspan="2"><textarea name="chk30" cols="65" rows="5"><?php echo $chk30; ?></textarea></td>
            </tr>
			<tr><td class="caption" colspan="3">6.家庭及社會情況</td></tr>
			<tr>
				<td>父親對哺乳的態度</td>
                <td colspan="2"><textarea name="chk31" cols="65" rows="5"><?php echo $chk31; ?></textarea></td>
            </tr>
			<tr>
				<td>其他家人對哺乳的態度</td>
                <td colspan="2"><textarea name="chk32" cols="65" rows="5"><?php echo $chk32; ?></textarea></td>
            </tr>
			<tr>
				<td>家庭對照顧孩童的幫助</td>
                <td colspan="2"><textarea name="chk33" cols="65" rows="5"><?php echo $chk33; ?></textarea></td>
            </tr>
			<tr>
				<td>別人對哺乳的看法</td>
                <td colspan="2"><textarea name="chk34" cols="65" rows="5"><?php echo $chk34; ?></textarea></td>
            </tr>
          </table>
		</div>
	  </form>
        <div id="tab-datatable">
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
	<div class="footing">
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<script type="text/javascript"><!--
$('.mybox > div').live('click', function() {
	$(this).find('input').attr('checked', true);
});
//--></script>
<script type="text/javascript"><!--	
/*
	if ($('input[name=chk5]:checked').val() == '其他') {
		$('input[name=chk5_other]').show();
	} else {
		$('input[name=chk5_other]').hide();
	}
	$('input[name=chk5]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk5_other]').show();
		} else {
			$('input[name=chk5_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk17]:checked').val() == '其他') {
		$('input[name=chk17_other]').show();
	} else {
		$('input[name=chk17_other]').hide();
	}
	$('input[name=chk17]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk17_other]').show();
		} else {
			$('input[name=chk17_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk18]:checked').val() == '其他') {
		$('input[name=chk18_other]').show();
	} else {
		$('input[name=chk18_other]').hide();
	}
	$('input[name=chk18]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk18_other]').show();
		} else {
			$('input[name=chk18_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk19]:checked').val() == '其他') {
		$('input[name=chk19_other]').show();
	} else {
		$('input[name=chk19_other]').hide();
	}
	$('input[name=chk19]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk19_other]').show();
		} else {
			$('input[name=chk19_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk28]:checked').val() == '有') {
		$('input[name=chk28_other]').show();
	} else {
		$('input[name=chk28_other]').hide();
	}
	$('input[name=chk28]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('input[name=chk28_other]').show();
		} else {
			$('input[name=chk28_other]').hide();
		}
	});	

	//-------------------------//
*/
<?php for ($i = 6; $i <= 6 ;$i++) { ?>
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	});	
	//-------------------------//
<?php } ?>
/*
<?php for ($i = 23; $i <= 24 ;$i++) { ?>
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	});	
	//-------------------------//
<?php } ?>
*/
//--></script>
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	minDate: "-80Y",
	maxDate: "+0D",
	dateFormat: 'yy-mm-dd'
});
//--></script>
<?php echo $footer; ?>