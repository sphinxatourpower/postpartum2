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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a><?php if (isset($delete) AND $delete<>'' ) { ?><a onclick="delNurse3c();" class="button"><?php echo $button_delete?></a><?php } ?></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-nurse3c"><?php echo $tab_nurse3c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse3c">
          <table class="form list">
			  <tr>
				<td width="20%">實施日期</td>
				<td width="15%"><?php echo  (($date_added=='') ? date('Y-m-d') : $date_added );?></td>
				<td width="15%"></td>
				<td width="20%">護理人員</td>
				<td width="15%"><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
				  <td width="15%"></td>
			  </tr>
			  <tr>
                <td>一、意識、定向感差</td>
				<td><input type="radio"  value="是" name="chk1"  <?php echo ($chk1=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk1"  <?php echo ($chk1=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk1_score" value="<?php echo $chk1_score; ?>" size="5" onkeyup="countTotal();" /></td>
                <td>二、由床或椅子站起行走有障礙</td>
				<td><input type="radio"  value="是" name="chk2"  <?php echo ($chk2=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk2"  <?php echo ($chk2=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk2_score" value="<?php echo $chk2_score; ?>" size="5" onkeyup="countTotal();" /></td>
              </tr>
			  <tr>
                <td>三、憂鬱</td>
				<td><input type="radio"  value="是" name="chk3"  <?php echo ($chk3=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk3"  <?php echo ($chk3=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk3_score" value="<?php echo $chk3_score; ?>" size="5" onkeyup="countTotal();" /></td>
                <td>四、抗癲癇藥物</td>
				<td><input type="radio"  value="是" name="chk4"  <?php echo ($chk4=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk4"  <?php echo ($chk4=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk4_score" value="<?php echo $chk4_score; ?>" size="5" onkeyup="countTotal();" /></td>
              </tr>
			  <tr>
                <td>五、失禁、頻尿、夜尿頻繁</td>
				<td><input type="radio"  value="是" name="chk5"  <?php echo ($chk5=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk5"  <?php echo ($chk5=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk5_score" value="<?php echo $chk5_score; ?>" size="5" onkeyup="countTotal();" /></td>
                <td>六、頭暈、昏眩</td>
				<td><input type="radio"  value="是" name="chk6"  <?php echo ($chk6=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk6"  <?php echo ($chk6=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk6_score" value="<?php echo $chk6_score; ?>" size="5" onkeyup="countTotal();" /></td>
              </tr>
			  <tr>
                <td>七、藥物服用：利尿劑、安眠藥、降血壓藥物、姿位性低血壓藥物、鎮定劑等</td>
				<td><input type="radio"  value="是" name="chk7"  <?php echo ($chk7=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk7"  <?php echo ($chk7=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk7_score" value="<?php echo $chk7_score; ?>" size="5" onkeyup="countTotal();" /></td>
                <td>八、機械或環境因素：桌椅擁擠、電線纏繞在地、有尿袋</td>
				<td><input type="radio"  value="是" name="chk8"  <?php echo ($chk8=="是")? "checked":""; ?>/> 是 <input type="radio"  value="否" name="chk8"  <?php echo ($chk8=="否")? "checked":""; ?>/> 否</td>
				<td>分數：<input type="text" name="chk8_score" value="<?php echo $chk8_score; ?>" size="5" onkeyup="countTotal();" /></td>
              </tr>
			  <tr>
                <td>總得分</td>
                <td><input type="text" name="score_total" value="<?php echo $score_total; ?>" size="5" disabled="disabled"/></td>
				<td><input type="button"  value="計算總分" id="countsum" /></td>
				<td colspan="3">總分 16 分，高風險切截點：大於等於 5 分，超過 5 分者，7 天後需再評估一次</td>
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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a><?php if (isset($delete) AND $delete<>'' ) { ?><a onclick="delNurse3c();" class="button"><?php echo $button_delete?></a><?php } ?></div>
    </div>
  </div>
</div>


<?php if (isset($delete) AND $delete<>'') { ?> 
<script type="text/javascript"><!--
function delNurse3c() {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content, .footing').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = '<?php echo str_replace("&amp;", "&", $delete); ?>';
		document.location.href=url;
	}
}
//--></script>
<?php } ?>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<script type="text/javascript"><!--	
$('#countsum').click(function() { 
	countTotal();
});

function countTotal() {
	var sum = 0;
	
	$('input[name$="score"]').each(function(){
		if (this.value!='') {
			sum += parseInt(this.value);
		}
	});
	
	$('input[name="score_total"]').val(sum);
}
//--></script>
<?php echo $footer; ?>