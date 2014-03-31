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
      <div id="tabs" class="htabs"><a href="#tab-edu1c"><?php echo $tab_edu1c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-edu1c">
          <table class="form list">
			  <tr>
				<td width="30%"><strong>情況描述</strong></td>
				<td width="35%"><strong>評量結果</strong></td>
				<td width="35%"><strong>補充說明</strong></td>
			  </tr>
			  <tr>
                <td>一、我滿意於當我遇到困難時，可以求助於家人。</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="2" rel="2" name="chk1"  <?php echo ($chk1=="2")? "checked":""; ?>/> 經常</div>
				  <div class="even"><input type="radio"  value="1" rel="1" name="chk1"  <?php echo ($chk1=="1")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="0" rel="0" name="chk1"  <?php echo ($chk1=="0")? "checked":""; ?>/> 幾乎沒有</div>
                </div></td>
                <td><textarea name="text1" cols="65" rows="5"><?php echo $text1; ?></textarea></td>
              </tr>
			  <tr>
                <td>二、我滿意於家人和我討論事情及分擔問題的方式。</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="2" rel="2" name="chk2"  <?php echo ($chk2=="2")? "checked":""; ?>/> 經常</div>
				  <div class="even"><input type="radio"  value="1" rel="1" name="chk2"  <?php echo ($chk2=="1")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="0" rel="0" name="chk2"  <?php echo ($chk2=="0")? "checked":""; ?>/> 幾乎沒有</div>
                </div></td>
                <td><textarea name="text2" cols="65" rows="5"><?php echo $text2; ?></textarea></td>
              </tr>
			  <tr>
                <td>三、我滿意於當我希望從事新活動，或是有新的發展方向時，家人能接受並給予支持。</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="2" rel="2" name="chk3"  <?php echo ($chk3=="2")? "checked":""; ?>/> 經常</div>
				  <div class="even"><input type="radio"  value="1" rel="1" name="chk3"  <?php echo ($chk3=="1")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="0" rel="0" name="chk3"  <?php echo ($chk3=="0")? "checked":""; ?>/> 幾乎沒有</div>
                </div></td>
                <td><textarea name="text3" cols="65" rows="5"><?php echo $text3; ?></textarea></td>
              </tr>
			  <tr>
                <td>四、我滿意於當家人對我表達情感的方式，以及對我的情緒（如憤怒、悲傷、愛）的反應。</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="2" rel="2" name="chk4"  <?php echo ($chk4=="2")? "checked":""; ?>/> 經常</div>
				  <div class="even"><input type="radio"  value="1" rel="1" name="chk4"  <?php echo ($chk4=="1")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="0" rel="0" name="chk4"  <?php echo ($chk4=="0")? "checked":""; ?>/> 幾乎沒有</div>
                </div></td>
                <td><textarea name="text4" cols="65" rows="5"><?php echo $text4; ?></textarea></td>
              </tr>
			  <tr>
                <td>五、我滿意於家人與我共處的方式。</td>
				<td><div class="mybox">
                  <div class="odd"><input type="radio"  value="2" rel="2" name="chk5"  <?php echo ($chk5=="2")? "checked":""; ?>/> 經常</div>
				  <div class="even"><input type="radio"  value="1" rel="1" name="chk5"  <?php echo ($chk5=="1")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="0" rel="0" name="chk5"  <?php echo ($chk5=="0")? "checked":""; ?>/> 幾乎沒有</div>
                </div></td>
                <td><textarea name="text5" cols="65" rows="5"><?php echo $text5; ?></textarea></td>
              </tr>
			  <tr>
                <td>得分</td>
                <td><input type="text" name="score" value="<?php echo $score; ?>" size="12" /></td>
				<td></td>
				<td></td>
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
$(function() {
	function countTotal() {
		var sum = 0;

		$("input[type=radio]:checked").each(function(){	
		  sum += parseInt($(this).attr("rel"));
		});
		
		$('input[name="score"]').val(sum);
	}
	
	$('input[type=radio]').change(function() {
			countTotal();
	});
	
	$('.mybox > div').live('click', function() {
		$(this).find('input').attr('checked', true);
		countTotal();
	});
});
//--></script>
<?php echo $footer; ?>