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
      <div id="tabs" class="htabs"><a href="#tab-nurse1c"><?php echo $tab_nurse1c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse1c">
          <table class="form list">
			  <tr>
                <td width="15%">護理人員</td>
                <td width="35%"><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
				<td width="15%">胎次</td>
				<td width="35%"><input type="text" name="child_count_p" value="<?php echo $child_count_p; ?>" size="2" /></td>
              </tr>
			  <tr>
                <td>身高</td>
                <td><input type="text" name="chk10" value="<?php echo $chk10; ?>" size="12" /> cm</td>
                <td>體重</td>
                <td><input type="text" name="chk11" value="<?php echo $chk11; ?>" size="12" /> kg</td>
              </tr>
			  <tr>
                <td>體溫</td>
                <td><input type="text" name="chk1" value="<?php echo $chk1; ?>" size="12" /> ℃</td>
                <td>脈搏</td>
                <td><input type="text" name="chk2" value="<?php echo $chk2; ?>" size="12" /> (每分鐘)</td>
              </tr>
			  <tr>
                <td>呼吸</td>
                <td><input type="text" name="chk3" value="<?php echo $chk3; ?>" size="12" /> (每分鐘)</td>
                <td>血壓</td>
                <td>收縮壓：<input type="text" name="chk4a" value="<?php echo $chk4a; ?>" size="12" /> mmHg&nbsp;&nbsp;舒張壓：<input type="text" name="chk4b" value="<?php echo $chk4b; ?>" size="12" /> mmHg</td>
              </tr>
            <tr style="display:none;">
              <td  width="15%"><?php echo $entry_childbirth_hospital; ?></td>
			  <?php  $cbh = explode(':', $childbirth_hospital);
			  if ($cbh[0] == "其他" && isset($cbh[1])) { $childbirth_hospital = $cbh[0];  $childbirth_hospital_other = $cbh[1]; } 
			  else { $childbirth_hospital = $cbh[0];  $childbirth_hospital_other = ''; } ?>
				<td  width="35%"><input type="hidden"  value="<?php echo $childbirth_hospital; ?>" name="childbirth_hospital" /><input type="text"  value="<?php echo $childbirth_hospital_other; ?>" name="childbirth_hospital_other" size="30" /></td>
                <td  width="15%">生產日期</td>
				<td  width="35%"><input type="text"  value="<?php echo $partum_date; ?>" name="partum_date" size="15" class="date" /></td>
            </tr>
            <tr style="display:none;">
              <td><?php echo $entry_childbirth_method; ?></td>
              <td>
                <input type="radio" name="childbirth_method" value="NSD" <?php echo ($childbirth_method=="NSD")? "checked=\"checked\"":""; ?> /> NSD
                <input type="radio" name="childbirth_method" value="C/S"  <?php echo ($childbirth_method=="C/S")? "checked=\"checked\"":""; ?>/> C/S
				<input type="radio" name="childbirth_method" value="VED"  <?php echo ($childbirth_method=="VED")? "checked=\"checked\"":""; ?>/> VED
			  </td>
              <td><?php echo $entry_pregnancy_weeks; ?></td>
              <td><input type="text" name="pregnancy_weeks" value="<?php echo $pregnancy_weeks; ?>" size="2" /> 週 + <input type="text" name="weeks_plus" value="<?php echo $weeks_plus; ?>" size="2" /> 天</td>
            </tr>
			  <tr style="display:none;">
                <td>生產期合併症</td>
			<?php $c6 = (!empty($chk6))? unserialize($chk6) : array(); $otherchecked6 = false; $chk6_other = '';
				if (!empty($c6)) {
					foreach ($c6 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked6= true;  $chk6_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox" style="height:200px;">
                  <div class="odd"><input type="checkbox"  value="無" name="chk6[]"  <?php echo (!empty($c6) && in_array("無", $c6 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="發燒" name="chk6[]"  <?php echo (!empty($c6) && in_array("發燒", $c6 ))? "checked":""; ?>/> 發燒</div>
				  <div class="odd"><input type="checkbox"  value="妊娠糖尿病" name="chk6[]"  <?php echo (!empty($c6) && in_array("妊娠糖尿病", $c6 ))? "checked":""; ?>/> 妊娠糖尿病</div>
				  <div class="even"><input type="checkbox"  value="妊娠高血壓" name="chk6[]"  <?php echo (!empty($c6) && in_array("妊娠高血壓", $c6 ))? "checked":""; ?>/> 妊娠高血壓</div>
				  <div class="odd"><input type="checkbox"  value="產後大出血" name="chk6[]"  <?php echo (!empty($c6) && in_array("產後大出血", $c6 ))? "checked":""; ?>/> 產後大出血</div>
				  <div class="even"><input type="checkbox"  value="感染" name="chk6[]"  <?php echo (!empty($c6) && in_array("感染", $c6 ))? "checked":""; ?>/> 感染</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk6[]"  <?php echo ($otherchecked6)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk6_other" value="<?php echo $chk6_other; ?>" size="12" /></div>
                </div></td>
				<td></td>
				<td></td>
              </tr>
          </table>
		  
		  <table class="form list">
			<tr>
				<td width="10%" rowspan="4">乳房</td>
			</tr>
			<tr style="border-top: 1px solid #DDDDDD;">
				<td width="5%">外觀：</td>
				<td>
					<input type="radio" name="chk12" <?php echo ($chk12=="柔軟")? "checked":""; ?> value="柔軟" />柔軟
					<input type="radio" name="chk12" <?php echo ($chk12=="充盈")? "checked":""; ?> value="充盈" />充盈
					<input type="radio" name="chk12" <?php echo ($chk12=="紅腫")? "checked":""; ?> value="紅腫" />紅腫
				</td>
			</tr>
			<tr>
				<td>乳頭：</td>
				<td>
					<input type="radio" name="chk13" <?php echo ($chk13=="正常")? "checked":""; ?> value="正常" />正常
					<input type="radio" name="chk13" <?php echo ($chk13=="凹陷")? "checked":""; ?> value="凹陷" />凹陷
					<input type="radio" name="chk13" <?php echo ($chk13=="破皮")? "checked":""; ?> value="破皮" />破皮
				</td>
			</tr>
			<tr>
				<td>泌乳：</td>
				<td>
					<input type="radio" name="chk14" <?php echo ($chk14=="有")? "checked":""; ?> value="有" />有
					<input type="radio" name="chk14" <?php echo ($chk14=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td rowspan="4">子宮</td>
			</tr>
			<tr>
				<td>堅實度：</td>
				<td>
					<input type="radio" name="chk15" <?php echo ($chk15=="堅硬")? "checked":""; ?> value="堅硬" />堅硬
					<input type="radio" name="chk15" <?php echo ($chk15=="鬆弛柔軟")? "checked":""; ?> value="鬆弛柔軟" />鬆弛柔軟
				</td>
			</tr>
			<tr>
				<td>位置：</td>
				<td>
					<input type="radio" name="chk16" <?php echo ($chk16=="偏右")? "checked":""; ?> value="偏右" />偏右
					<input type="radio" name="chk16" <?php echo ($chk16=="居中")? "checked":""; ?> value="居中" />居中
					<input type="radio" name="chk16" <?php echo ($chk16=="偏左")? "checked":""; ?> value="偏左" />偏左
				</td>
			</tr>
			<tr>
				<?php 
					$chk5_data = explode(",",$chk5);
					
				?>
				<td>高度：</td>
				<td>
					<input type="radio" name="chk5" <?php echo ($chk5_data[0]=="臍下")? "checked":""; ?> value="臍下" />臍下 <input type="text" name="chk5_text1" size="4"  <?php echo ($chk5_data[0]=="臍下")? 'value="'.$chk5_data[1].'"':'disabled'; ?> />Fb
					<input type="radio" name="chk5" <?php echo ($chk5_data[0]=="臍平")? "checked":""; ?> value="臍平" />臍平
					<input type="radio" name="chk5" <?php echo ($chk5_data[0]=="臍上")? "checked":""; ?> value="臍上" />臍上 <input type="text" name="chk5_text2" size="4" <?php echo ($chk5_data[0]=="臍上")? 'value="'.$chk5_data[1].'"':'disabled'; ?> />Fb
				</td>
			</tr>
			<tr>
				<td rowspan="6">惡露</td>
			</tr>
			<tr>
				<td>量：</td>
				<td>
					<input type="radio" name="chk17" <?php echo ($chk17=="多")? "checked":""; ?> value="多" />多
					<input type="radio" name="chk17" <?php echo ($chk17=="中")? "checked":""; ?> value="中" />中
					<input type="radio" name="chk17" <?php echo ($chk17=="少")? "checked":""; ?> value="少" />少
				</td>
			</tr>
			<tr>
				<td>氣味：</td>
				<td>
					<input type="radio" name="chk18" <?php echo ($chk18=="血腥味")? "checked":""; ?> value="血腥味" />血腥味
					<input type="radio" name="chk18" <?php echo ($chk18=="惡臭味")? "checked":""; ?> value="惡臭味" />惡臭味
				</td>
			</tr>
			<tr>
				<td>顏色：</td>
				<td>
					<input type="radio" name="chk19" <?php echo ($chk19=="深紅")? "checked":""; ?> value="深紅" />深紅
					<input type="radio" name="chk19" <?php echo ($chk19=="紅")? "checked":""; ?> value="紅" />紅
					<input type="radio" name="chk19" <?php echo ($chk19=="淺紅")? "checked":""; ?> value="淺紅" />淺紅
					<input type="radio" name="chk19" <?php echo ($chk19=="白")? "checked":""; ?> value="白" />白
				</td>
			</tr>
			<tr>
				<td>性質：</td>
				<td>
					<input type="radio" name="chk20" <?php echo ($chk20=="紅惡露")? "checked":""; ?> value="紅惡露" />紅惡露
					<input type="radio" name="chk20" <?php echo ($chk20=="漿惡露")? "checked":""; ?> value="漿惡露" />漿惡露
					<input type="radio" name="chk20" <?php echo ($chk20=="白惡露")? "checked":""; ?> value="白惡露" />白惡露
				</td>
			</tr>
			<tr>
				<td>血塊：</td>
				<td>
					<input type="radio" name="chk26" <?php echo ($chk26=="有")? "checked":""; ?> value="有" />有 
					<input type="radio" name="chk26" <?php echo ($chk26=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td rowspan="5">傷口</td>
			</tr>
			<tr>
				<td>腫脹瘀血：</td>
				<td>
					<input type="radio" name="chk27" <?php echo ($chk27=="有")? "checked":""; ?> value="有" />有
					<input type="radio" name="chk27" <?php echo ($chk27=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td>疼痛：</td>
				<td>
					<input type="radio" name="chk28" <?php echo ($chk28=="有")? "checked":""; ?> value="有" />有
					<input type="radio" name="chk28" <?php echo ($chk28=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td>感染徵象：</td>
				<td>
					<input type="radio" name="chk29" <?php echo ($chk29=="有")? "checked":""; ?> value="有" />有 
					<input type="radio" name="chk29" <?php echo ($chk29=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td>痔瘡：</td>
				<td>
					<input type="radio" name="chk30" <?php echo ($chk30=="有")? "checked":""; ?> value="有" />有
					<input type="radio" name="chk30" <?php echo ($chk30=="無")? "checked":""; ?> value="無" />無
				</td>
			</tr>
			<tr>
				<td>下肢</td>
				<td>膝反射</td>
				<td>
					<input type="radio" name="chk31" <?php echo ($chk31=="無")? "checked":""; ?> value="無" />無
					<input type="radio" name="chk31" <?php echo ($chk31=="1+")? "checked":""; ?> value="1+" />1+
					<input type="radio" name="chk31" <?php echo ($chk31=="2+")? "checked":""; ?> value="2+" />2+
					<input type="radio" name="chk31" <?php echo ($chk31=="3+")? "checked":""; ?> value="3+" />3+
				</td>
			</tr>
			<tr>
				<td>心理狀況</td>
				<td></td>
				<td>
					<input type="radio" name="chk32" <?php echo ($chk32=="接受期")? "checked":""; ?> value="接受期" />接受期
					<input type="radio" name="chk32" <?php echo ($chk32=="緊執期")? "checked":""; ?> value="緊執期" />緊執期
					<input type="radio" name="chk32" <?php echo ($chk32=="放手期")? "checked":""; ?> value="放手期" />放手期
				</td>
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
//-->
//---------------------------//
	$('input[name^=chk5]').click(function() {
			if ($('input[name=chk5]:checked').val() == '臍下') {
				$('input[name=chk5_text1]').attr('disabled',false);
				$('input[name=chk5_text2]').attr('disabled',true);
				$('input[name=chk5_text2]').val('');
			} else if ($('input[name=chk5]:checked').val() == '臍上') {
				$('input[name=chk5_text1]').attr('disabled',true);
				$('input[name=chk5_text2]').attr('disabled',false);
				$('input[name=chk5_text1]').val('');
			} else {
				$('input[name=chk5_text1]').attr('disabled',true);
				$('input[name=chk5_text2]').attr('disabled',true);
				$('input[name=chk5_text1]').val('');
				$('input[name=chk5_text2]').val('');
			}
	});	
</script>
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