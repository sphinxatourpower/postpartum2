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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form list">
			  <tr>
				<td width="15%"><span class="required">*</span> <?php echo $entry_date_written; ?></td>
				<td width="35%"><input type="text" name="date_added" class="date" value="<?php echo $date_added;?>" size="12" />              
				<?php if ($error_date_added) { ?>
					<span class="error"><?php echo $error_date_added; ?></span>
				<?php  } ?></td>
                <td width="15%"><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td width="35%">
					<input type="text" name="customer" value="<?php echo $customer; ?>" /> <span id="customer_room"><?php echo $customer_room; ?></span>
					<input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>" />
					<input type="hidden" name="customer_room" value="<?php echo $customer_room; ?>" />
				<?php if ($error_customer) { ?>
					<span class="error"><?php echo $error_customer; ?></span>
				<?php  } ?>
				</td>
              </tr>
		</table>
		
        <table class="form">
		  <tr>
			<td class="caption">一、照護服務內容</td>
			<td class="caption"></td>
		  </tr>
          <tr>
            <td>1. 專業人員知識是否詳盡</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk1"  <?php echo ($chk1=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk1"  <?php echo ($chk1=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk1"  <?php echo ($chk1=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk1"  <?php echo ($chk1=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk1"  <?php echo ($chk1=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>2. 照護內容是否符合需求</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk2"  <?php echo ($chk2=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk2"  <?php echo ($chk2=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk2"  <?php echo ($chk2=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk2"  <?php echo ($chk2=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk2"  <?php echo ($chk2=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>3. 指導內容是否能夠了解</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk3"  <?php echo ($chk3=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk3"  <?php echo ($chk3=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk3"  <?php echo ($chk3=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk3"  <?php echo ($chk3=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk3"  <?php echo ($chk3=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>4. 可尊重媽媽的隱私權</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk4"  <?php echo ($chk4=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk4"  <?php echo ($chk4=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk4"  <?php echo ($chk4=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk4"  <?php echo ($chk4=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk4"  <?php echo ($chk4=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>5. 其他(請說明)：</td>
            <td><textarea name="text1" cols="65" rows="10"><?php echo $text1; ?></textarea></td>
          </tr>
		  <tr>
			<td class="caption">二、服務人員態度</td>
			<td class="caption"></td>
		  </tr>
          <tr>
            <td>1. 護理人員</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk5"  <?php echo ($chk5=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk5"  <?php echo ($chk5=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk5"  <?php echo ($chk5=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk5"  <?php echo ($chk5=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk5"  <?php echo ($chk5=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>2. 清潔人員</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk6"  <?php echo ($chk6=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk6"  <?php echo ($chk6=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk6"  <?php echo ($chk6=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk6"  <?php echo ($chk6=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk6"  <?php echo ($chk6=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>3. 其他(請說明)：</td>
            <td><textarea name="text2" cols="65" rows="10"><?php echo $text2; ?></textarea></td>
          </tr>
		  <tr>
			<td class="caption">三、膳食</td>
			<td class="caption"></td>
		  </tr>
          <tr>
            <td>1. 菜色</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk7"  <?php echo ($chk7=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk7"  <?php echo ($chk7=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk7"  <?php echo ($chk7=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk7"  <?php echo ($chk7=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk7"  <?php echo ($chk7=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>2. 烹調口味</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk8"  <?php echo ($chk8=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk8"  <?php echo ($chk8=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk8"  <?php echo ($chk8=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk8"  <?php echo ($chk8=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk8"  <?php echo ($chk8=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>3. 餐盤清潔</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk9"  <?php echo ($chk9=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk9"  <?php echo ($chk9=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk9"  <?php echo ($chk9=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk9"  <?php echo ($chk9=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk9"  <?php echo ($chk9=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>4. 其他(請說明)：</td>
            <td><textarea name="text3" cols="65" rows="10"><?php echo $text3; ?></textarea></td>
          </tr>
		  <tr>
			<td class="caption">四、房間環境設施設備方面</td>
			<td class="caption"></td>
		  </tr>
          <tr>
            <td>1. 房間空間寬敞，沒有擁擠情形</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk10"  <?php echo ($chk10=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk10"  <?php echo ($chk10=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk10"  <?php echo ($chk10=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk10"  <?php echo ($chk10=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk10"  <?php echo ($chk10=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>2. 房間空調適中，光線明亮</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk11"  <?php echo ($chk11=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk11"  <?php echo ($chk11=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk11"  <?php echo ($chk11=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk11"  <?php echo ($chk11=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk11"  <?php echo ($chk11=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>3. 房間的床單、被單、哺乳衣清潔</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk12"  <?php echo ($chk12=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk12"  <?php echo ($chk12=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk12"  <?php echo ($chk12=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk12"  <?php echo ($chk12=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk12"  <?php echo ($chk12=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>4. 房間內地板、設備及洗手間乾淨清潔</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk13"  <?php echo ($chk13=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk13"  <?php echo ($chk13=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk13"  <?php echo ($chk13=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk13"  <?php echo ($chk13=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk13"  <?php echo ($chk13=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>5. 環境常保持安寧</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk14"  <?php echo ($chk14=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk14"  <?php echo ($chk14=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk14"  <?php echo ($chk14=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk14"  <?php echo ($chk14=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk14"  <?php echo ($chk14=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>6. 公共空間設施設備情形</td>
            <td>
				<div class="mybox">
					  <div class="even"><input type="radio"  value="5" name="chk15"  <?php echo ($chk15=="5")? "checked=\"checked\"":""; ?> /> <?php echo $score5; ?></div>
					  <div class="odd"><input type="radio"  value="4" name="chk15"  <?php echo ($chk15=="4")? "checked=\"checked\"":""; ?> /> <?php echo $score4; ?></div>
					  <div class="even"><input type="radio"  value="3" name="chk15"  <?php echo ($chk15=="3")? "checked=\"checked\"":""; ?> /> <?php echo $score3; ?></div>
					  <div class="odd"><input type="radio"  value="2" name="chk15"  <?php echo ($chk15=="2")? "checked=\"checked\"":""; ?> /> <?php echo $score2; ?></div>
					  <div class="even"><input type="radio"  value="1" name="chk15"  <?php echo ($chk15=="1")? "checked=\"checked\"":""; ?> /> <?php echo $score1; ?></div>
				</div>
			</td>
          </tr>
          <tr>
            <td>7. 其他(請說明)：</td>
            <td><textarea name="text4" cols="65" rows="10"><?php echo $text4; ?></textarea></td>
          </tr>
		  <tr>
			<td class="caption">五、綜合建議</td>
			<td class="caption"></td>
		  </tr>
          <tr>
            <td>1. 認為本機構最需加強的部份</td>
            <td><textarea name="text5" cols="65" rows="10"><?php echo $text5; ?></textarea></td>
          </tr>
          <tr>
            <td>2. 心目中表現優秀的工作人員</td>
            <td><input type="text" name="good1" value="<?php echo $good1; ?>" /> <input type="text" name="good2" value="<?php echo $good2; ?>" /> <input type="text" name="good3" value="<?php echo $good3; ?>" /></td>
          </tr>
        </table>
      </form>
    </div>
	<div class="footing">
		<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
	</div>
  </div>
</div>

<script type="text/javascript"><!--
$('input[name=\'customer\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=service/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['customer_id'],
						room_name: item['room_name']
					}
				}));
			}
		});
	}, 
	select: function(event, ui) { 
		$('span[id=\'customer_room\']').html(ui.item['room_name']);
		$('input[name=\'customer\']').attr('value', ui.item['label']);
		$('input[name=\'customer_id\']').attr('value', ui.item['value']);
		$('input[name=\'customer_room\']').attr('value', ui.item['value']);
					 	
		return false; 
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>
<script type="text/javascript"><!--
$('.mybox > div').live('click', function() {
	$(this).find('input').attr('checked', true);
});
//--></script>
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	dateFormat: 'yy-mm-dd'
});
//--></script> 
<?php echo $footer; ?> 