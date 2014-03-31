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
      <div id="tabs" class="htabs"><a href="#tab-nurse4c"><?php echo $tab_nurse4c; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse4c">
          <table class="form list">
			  <tr>
				<td width="15%"><strong>在過去七天中</strong></td>
				<td width="35%"></td>
				<td width="15%"></td>
				<td width="35%"></td>
			  </tr>
			  <tr>
                <td>一、我能看到事物有趣的一面，並笑得很開心。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="和以前一樣" rel="0" name="chk1"  <?php echo ($chk1=="和以前一樣")? "checked":""; ?>/> 和以前一樣</div>
				  <div class="even"><input type="radio"  value="沒有以前那麼多" rel="1" name="chk1"  <?php echo ($chk1=="沒有以前那麼多")? "checked":""; ?>/> 沒有以前那麼多</div>
				  <div class="odd"><input type="radio"  value="肯定比以前少" rel="2" name="chk1"  <?php echo ($chk1=="肯定比以前少")? "checked":""; ?>/> 肯定比以前少</div>
				  <div class="even"><input type="radio"  value="完全不能" rel="3" name="chk1"  <?php echo ($chk1=="完全不能")? "checked":""; ?>/> 完全不能</div>
                </div></td>
                <td>二、我會欣然期待未來的一切。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="和以前一樣" rel="0" name="chk2"  <?php echo ($chk2=="和以前一樣")? "checked":""; ?>/> 和以前一樣</div>
				  <div class="even"><input type="radio"  value="沒有以前那麼多" rel="1" name="chk2"  <?php echo ($chk2=="沒有以前那麼多")? "checked":""; ?>/> 沒有以前那麼多</div>
				  <div class="odd"><input type="radio"  value="肯定比以前少" rel="2" name="chk2"  <?php echo ($chk2=="肯定比以前少")? "checked":""; ?>/> 肯定比以前少</div>
				  <div class="even"><input type="radio"  value="完全不能期待" rel="3" name="chk2"  <?php echo ($chk2=="完全不能期待")? "checked":""; ?>/> 完全不能期待</div>
                </div></td>
              </tr>
			  <tr>
                <td>三、當事情出錯時，我會先責備自己。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大多數" rel="3" name="chk3"  <?php echo ($chk3=="大多數")? "checked":""; ?>/> 大多數</div>
				  <div class="even"><input type="radio"  value="有時候" rel="2" name="chk3"  <?php echo ($chk3=="有時候")? "checked":""; ?>/> 有時候</div>
				  <div class="odd"><input type="radio"  value="不常" rel="1" name="chk3"  <?php echo ($chk3=="不常")? "checked":""; ?>/> 不常</div>
				  <div class="even"><input type="radio"  value="從未如此" rel="0"  name="chk3"  <?php echo ($chk3=="從未如此")? "checked":""; ?>/> 從未如此</div>
                </div></td>
                <td>四、我會無緣無故感到焦慮或擔心。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="完全不會" rel="0" name="chk4"  <?php echo ($chk4=="完全不會")? "checked":""; ?>/> 完全不會</div>
				  <div class="even"><input type="radio"  value="極少" rel="1" name="chk4"  <?php echo ($chk4=="極少")? "checked":""; ?>/> 極少</div>
				  <div class="odd"><input type="radio"  value="有時候" rel="2" name="chk4"  <?php echo ($chk4=="有時候")? "checked":""; ?>/> 有時候</div>
				  <div class="even"><input type="radio"  value="經常" rel="3" name="chk4"  <?php echo ($chk4=="經常")? "checked":""; ?>/> 經常</div>
                </div></td>
              </tr>
			  <tr>
                <td>五、我會無緣無故感到害怕或驚恐。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="總是如此" rel="3" name="chk5"  <?php echo ($chk5=="總是如此")? "checked":""; ?>/> 總是如此</div>
				  <div class="even"><input type="radio"  value="有時" rel="2" name="chk5"  <?php echo ($chk5=="有時")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="不常" rel="1" name="chk5"  <?php echo ($chk5=="不常")? "checked":""; ?>/> 不常</div>
				  <div class="even"><input type="radio"  value="從未如此" rel="0" name="chk5"  <?php echo ($chk5=="從未如此")? "checked":""; ?>/> 從未如此</div>
                </div></td>
                <td>六、很多事情衝著我來，我覺得無法應付處理。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大多數無法" rel="3" name="chk6"  <?php echo ($chk6=="大多數無法")? "checked":""; ?>/> 大多數無法</div>
				  <div class="even"><input type="radio"  value="有時無法" rel="2" name="chk6"  <?php echo ($chk6=="有時無法")? "checked":""; ?>/> 有時無法</div>
				  <div class="odd"><input type="radio"  value="大多數可以" rel="1" name="chk6"  <?php echo ($chk6=="大多數可以")? "checked":""; ?>/> 大多數可以</div>
				  <div class="even"><input type="radio"  value="能處理得跟以前一樣好" rel="0" name="chk6"  <?php echo ($chk6=="能處理得跟以前一樣好")? "checked":""; ?>/> 能處理得跟以前一樣好</div>
                </div></td>
              </tr>
			  <tr>
                <td>七、我很不快樂到失眠。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大多數" rel="3" name="chk7"  <?php echo ($chk7=="大多數")? "checked":""; ?>/> 大多數</div>
				  <div class="even"><input type="radio"  value="有時" rel="2" name="chk7"  <?php echo ($chk7=="有時")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="不常" rel="1" name="chk7"  <?php echo ($chk7=="不常")? "checked":""; ?>/> 不常</div>
				  <div class="even"><input type="radio"  value="完全不會" rel="0" name="chk7"  <?php echo ($chk7=="完全不會")? "checked":""; ?>/> 完全不會</div>
                </div></td>
                <td>八、我感到難過或悲傷。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大多數" rel="3" name="chk8"  <?php echo ($chk8=="大多數")? "checked":""; ?>/> 大多數</div>
				  <div class="even"><input type="radio"  value="有時" rel="2" name="chk8"  <?php echo ($chk8=="有時")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="不常" rel="1" name="chk8"  <?php echo ($chk8=="不常")? "checked":""; ?>/> 不常</div>
				  <div class="even"><input type="radio"  value="完全不會" rel="0" name="chk8"  <?php echo ($chk8=="完全不會")? "checked":""; ?>/> 完全不會</div>
                </div></td>
              </tr>
			  <tr>
                <td>九、我不開心到哭。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大多數" rel="3" name="chk9"  <?php echo ($chk9=="大多數")? "checked":""; ?>/> 大多數</div>
				  <div class="even"><input type="radio"  value="有時" rel="2" name="chk9"  <?php echo ($chk9=="有時")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="偶爾" rel="1" name="chk9"  <?php echo ($chk9=="偶爾")? "checked":""; ?>/> 偶爾</div>
				  <div class="even"><input type="radio"  value="不曾如此" rel="0" name="chk9"  <?php echo ($chk9=="不曾如此")? "checked":""; ?>/> 不曾如此</div>
                </div></td>
                <td>十、我曾經想要傷害自己。</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="很常" rel="3" name="chk10"  <?php echo ($chk10=="很常")? "checked":""; ?>/> 很常</div>
				  <div class="even"><input type="radio"  value="有時" rel="2" name="chk10"  <?php echo ($chk10=="有時")? "checked":""; ?>/> 有時</div>
				  <div class="odd"><input type="radio"  value="很少" rel="1" name="chk10"  <?php echo ($chk10=="很少")? "checked":""; ?>/> 很少</div>
				  <div class="even"><input type="radio"  value="從未如此" rel="0" name="chk10"  <?php echo ($chk10=="從未如此")? "checked":""; ?>/> 從未如此</div>
                </div></td>
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
});
//--></script>
<?php echo $footer; ?>