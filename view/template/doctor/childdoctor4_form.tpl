<?php echo $header; ?>
<?php require_once( DIR_SYSTEM . '/other/select.php'); ?>
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
      <div id="tabs" class="htabs"><a href="#tab-childdoctor4"><?php echo $tab_childdoctor4; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>

	  <div id="tab-childdoctor4">
		<!-- vtabs menu -->
          <div id="vtabs" class="vtabs"><a href="#tab-childdoctor4list"><?php echo $tab_childdoctor4; ?></a>
			<span id="childdoctor4-add"><?php echo $button_add_childdoctor4; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addChildDoctor4();" /></span>
			
			<?php if (count($childdoctor4forms) > 12) { ?>
			<div class="scrolldiv">
			<?php } ?>

			
            <?php $form_row = 1; ?>
            <?php foreach ($childdoctor4forms as $childdoctor4form) { ?>
            <a title="<?php echo $childdoctor4form['date_added']; ?>" alt="<?php echo $childdoctor4form['date_added']; ?>" href="#tab-childdoctor4form-<?php echo $form_row; ?>" id="childdoctor4form-<?php echo $form_row; ?>"><?php echo $tab_childdoctor4form . ' ' . $form_row; ?>&nbsp;<img src="view/image/delete.png" title="刪除此單" alt="刪除此單" onclick="delChildDoctor4(<?php echo $childdoctor4form['customer_child_doctor4_id']; ?>, <?php echo $form_row; ?>);" /></a>
            <?php $form_row++; ?>
            <?php } ?>
			
			<?php if (count($childdoctor4forms) > 12) { ?>
			</div>
			<?php } ?>
            
		</div>
		<!-- vtabs menu -->
		
		<div id="tab-childdoctor4list" class="vtabs-content">
			<div id="calendar"></div>
		</div>
		
		<?php $form_row = 1; ?>
        <?php foreach ($childdoctor4forms as $childdoctor4form) { ?>
		<div id="tab-childdoctor4form-<?php echo $form_row; ?>" class="vtabs-content"  style="display:none;">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-<?php echo $form_row; ?>">
			<div class="inner-heading">
				<h1><img src="view/image/calendar.png" alt="" /> <?php echo $childdoctor4form['date_added']; ?> <?php echo $tab_childdoctor4form; ?></h1>
				<div class="buttons"><a onclick="$('#form-<?php echo $form_row; ?>').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#vtabs a:first').trigger('click'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>
			</div>
		  <input type="hidden" name="childdoctor4form[<?php echo $form_row; ?>][customer_child_doctor4_id]" value="<?php echo $childdoctor4form['customer_child_doctor4_id']; ?>" />
          <table class="form list">
			  <tr>
				<td width="15%">實施日期</td>
				<td width="35%"><input type="text" name="childdoctor4form[<?php echo $form_row; ?>][date_added]" class="date" value="<?php echo  (($childdoctor4form['date_added']=='') ? date('Y-m-d') : $childdoctor4form['date_added'] );?>" size="12" /></td>
                <td>醫師</td>
                <td><select name="childdoctor4form[<?php echo $form_row; ?>][doctor_id]">
                    <?php foreach ($doctors as $doctor) { ?>
                    <?php if ($doctor['user_id'] == $childdoctor4form['doctor_id']) { ?>
                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
			  <tr>
			  	<?php
			  		$chk1 = new SelectorPrinter();
					$chk1->Title="頭痛部位";
					$chk1->arrOption=array("眉棱骨痛","巔頂痛","後頭頸部痛");
					$chk1->type="checkbox";
					$chk1->CheckField="chk1";
					$chk1->formName="childdoctor4form";
					$chk1->formRow=$form_row;
					$chk1->itemSelected = $childdoctor4form['chk1'];
					echo $chk1->combine();

			  		$chk2 = new SelectorPrinter();
					$chk2->Title="暈眩";
					$chk2->arrOption=array("有","無");
					$chk2->type="radio";
					$chk2->CheckField="chk2";
					$chk2->formName="childdoctor4form";
					$chk2->formRow=$form_row;
					$chk2->itemSelected = $childdoctor4form['chk2'];
					echo $chk2->combine();
			  	?>
              </tr>
			  <tr>
			  <?php
                	$chk3 = new SelectorPrinter();
					$chk3->Title="眼";
					$chk3->arrOption=array("目癢","目乾澀","模糊");
					$chk3->type="checkbox";
					$chk3->CheckField="chk3";
					$chk3->formName="childdoctor4form";
					$chk3->formRow=$form_row;
					$chk3->itemSelected = $childdoctor4form['chk3'];
					echo $chk3->combine();

			  		$chk4 = new SelectorPrinter();
					$chk4->Title="鼻";
					$chk4->arrOption=array("鼻過敏","鼻乾","鼻痛","鼻癢","鼻塞");
					$chk4->type="checkbox";
					$chk4->CheckField="chk4";
					$chk4->formName="childdoctor4form";
					$chk4->formRow=$form_row;
					$chk4->itemSelected = $childdoctor4form['chk4'];
					echo $chk4->combine();
				?>
              </tr>
			  <tr>
			  <?php
                	$chk5 = new SelectorPrinter();
					$chk5->Title="耳";
					$chk5->arrOption=array("耳鳴","耳聾","耳痛","重聽");
					$chk5->type="checkbox";
					$chk5->CheckField="chk5";
					$chk5->formName="childdoctor4form";
					$chk5->formRow=$form_row;
					$chk5->itemSelected = $childdoctor4form['chk5'];
					echo $chk5->combine();

			  		$chk6 = new SelectorPrinter();
					$chk6->Title="口";
					$chk6->arrOption=array("口乾");
					$chk6->type="checkbox";
					$chk6->CheckField="chk6";
					$chk6->formName="childdoctor4form";
					$chk6->formRow=$form_row;
					$chk6->itemSelected = $childdoctor4form['chk6'];
					echo $chk6->combine();
			?>
              </tr>
			  <tr>
			  <?php
                $chk3 = new SelectorPrinter();
					$chk7->Title="飲";
					$chk7->arrOption=array("喜冷飲","喜熱飲");
					$chk7->type="checkbox";
					$chk7->CheckField="chk7";
					$chk7->formName="childdoctor4form";
					$chk7->formRow=$form_row;
					$chk7->itemSelected = $childdoctor4form['chk7'];
					echo $chk7->combine();

			  		$chk8 = new SelectorPrinter();
					$chk8->Title="食";
					$chk8->arrOption=array("飢而不欲食","其他");
					$chk8->type="checkbox";
					$chk8->CheckField="chk8";
					$chk8->formName="childdoctor4form";
					$chk8->formRow=$form_row;
					$chk8->itemSelected = $childdoctor4form['chk8'];
					echo $chk8->combine();
				?>
              </tr>
              <tr>
              <?php
              		$chk9 = new SelectorPrinter();
					$chk9->Title="胃";
					$chk9->arrOption=array("脹痛","其他");
					$chk9->type="checkbox";
					$chk9->CheckField="chk9";
					$chk9->formName="childdoctor4form";
					$chk9->formRow=$form_row;
					$chk9->itemSelected = $childdoctor4form['chk9'];
					echo $chk9->combine();

			  		$chk10 = new SelectorPrinter();
					$chk10->Title="腹";
					$chk10->arrOption=array("脹痛","其他");
					$chk10->type="checkbox";
					$chk10->CheckField="chk10";
					$chk10->formName="childdoctor4form";
					$chk10->formRow=$form_row;
					$chk10->itemSelected = $childdoctor4form['chk10'];
					echo $chk10->combine();
			?>
              </tr>
              <tr>
              <?php
              		$chk11 = new SelectorPrinter();
					$chk11->Title="身軀";
					$chk11->arrOption=array("肢節疼痛","腰部痠痛","其他");
					$chk11->type="checkbox";
					$chk11->CheckField="chk11";
					$chk11->formName="childdoctor4form";
					$chk11->formRow=$form_row;
					$chk11->itemSelected = $childdoctor4form['chk11'];
					echo $chk11->combine();
					
					$chk12 = new SelectorPrinter();
					$chk12->Title="神";
					$chk12->arrOption=array("健忘","煩躁","其他");
					$chk12->type="checkbox";
					$chk12->CheckField="chk12";
					$chk12->formName="childdoctor4form";
					$chk12->formRow=$form_row;
					$chk12->itemSelected = $childdoctor4form['chk12'];
					echo $chk12->combine();
				?>
              </tr>
              <tr>
              <?php
              		$chk13 = new SelectorPrinter();
					$chk13->Title="眠";
					$chk13->arrOption=array("多嗜睡","多夢","易醒","早醒","失眠","昏睡","其他");
					$chk13->type="checkbox";
					$chk13->CheckField="chk13";
					$chk13->formName="childdoctor4form";
					$chk13->formRow=$form_row;
					$chk13->itemSelected = $childdoctor4form['chk13'];
					echo $chk13->combine();
					
					$chk14 = new SelectorPrinter();
					$chk14->Title="大便";
					$chk14->arrOption=array("便秘","前硬後軟","便不成形","羊矢便","排便不爽","其他");
					$chk14->type="checkbox";
					$chk14->CheckField="chk14";
					$chk14->formName="childdoctor4form";
					$chk14->formRow=$form_row;
					$chk14->itemSelected = $childdoctor4form['chk14'];
					echo $chk12->combine();
				?>
              </tr>
              <tr>
              <?php
              		$chk15 = new SelectorPrinter();
					$chk15->Title="小便";
					$chk15->arrOption=array("頻尿","小便不禁","其他");
					$chk15->type="checkbox";
					$chk15->CheckField="chk15";
					$chk15->formName="childdoctor4form";
					$chk15->formRow=$form_row;
					$chk15->itemSelected = $childdoctor4form['chk15'];
					echo $chk15->combine();
					
					$chk16 = new SelectorPrinter();
					$chk16->Title="月經";
					$chk16->arrOption=array("經量多","經量少","色紅","色紅","暗紅","淡紅","質稀","質稠","週期");
					$chk16->type="checkbox";
					$chk16->CheckField="chk16";
					$chk16->formName="childdoctor4form";
					$chk16->formRow=$form_row;
					$chk16->itemSelected = $childdoctor4form['chk16'];
					$aor = $chk16->combine();
					echo $aor;
				?>
              </tr>
          </table>
		  
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

<script type="text/javascript"><!--
function delChildDoctor4(id,row) {
	if (!confirm('確認?(Confirm?)')) {
        return false;
    } else {
		$('.success, .warning').remove();
		$('.content').hide();
		$('.box').append('<div class="content"><center><h2><img src="view/image/loading.gif" /> 刪除中...</h2></center></div>');
		url = 'index.php?route=doctor/childdoctor4/delete&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>&id='+encodeURIComponent(id);
		document.location.href=url;
	}
}
//--></script>
<script type="text/javascript">
var form_row = <?php echo $form_row; ?>;


function addChildDoctor4(date) {		
	
	<?php
	/******************************************************************/
		function combine($Title,$arrOption,$type,$formName,$formRow,$checkField) {

		$printBody = "<td>" . $$Title . ": </td>";
		$printBody .= <<<EOD
			<td><div class="scrollbox">
EOD;

		$arrNum = count($arrOption);
		$foo = arrStatList($arrNum);
		
		if($type == "radio"){
			for ($i = 0; $i < $arrNum; $i++) {
				$bar .= '<div class="' . $foo[$i] . '">';
				$bar .= '<input type="' . $this -> type . '"' . ' name="' . $formName . '[' . $formRow . '][' . $checkField . ']"' . ' value="' . $arrOption[$i] . $arrOption[$i] . '</div>';
				
			}
			$printBody .= $bar;
			$printBody .= '</div></td>';	
		}else{
			for ($i = 0; $i < $arrNum; $i++) {
				$bar .= '<div class="' . $foo[$i] . '">';
				$bar .= '<input type="' . $this -> type . '"' . ' name="' . $formName . '[' . $formRow . '][' . $checkField . '][]"' . ' value="' . $arrOption[$i] . $arrOption[$i] . '</div>';
			}
			$printBody .= $bar;
			$printBody .= '</div></td>';
		}
		return $printBody;

	}

	function arrStatList($e) {
		$foo = array();

		for ($i = 0; $i < $e; $i++) {
			if (($i + 1) % 2) {
				$foo[$i] = "odd";
			} else {
				$foo[$i] = "even";
			}
		}
		return $foo;
	} 
	
	/******************************************************************/
	?>
	
	if (date==null) { 
		today = new Date();
		var date = today.getFullYear() + '-'
								+ ('0' + (today.getMonth()+1)).slice(-2) + '-'
								+ ('0' + today.getDate()).slice(-2);
	} 
	
		html  = '<div id="tab-childdoctor4form-' + form_row + '" class="vtabs-content">';
		html += '	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-'+ form_row +'">';
		html += '	    <div class="inner-heading">';
		html += '			<h1><img src="view/image/calendar.png" alt="" /> 新增 <?php echo $tab_childdoctor4form; ?></h1>';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>	';
		html += '  <input type="hidden" name="childdoctor4form[' + form_row + '][customer_child_doctor4_id]" value="" />';
		html += '  <table class="form list">';
		html += '			  <tr>';
		html += '				<td width="15%">實施日期</td>';
		html += '				<td width="35%"><input type="text" name="childdoctor4form[' + form_row + '][date_added]" class="date" value="' + date + '" size="12" /></td>';
		html += '                <td>醫師</td>';
		html += '                <td><select name="childdoctor4form[' + form_row + '][doctor_id]">';
<?php foreach ($doctors as $doctor) { ?>
	<?php if ($doctor['user_id'] == $logged_id) { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>" selected="selected"><?php echo $doctor['name']; ?></option>';
	<?php } else { ?>
		html += '                    <option value="<?php echo $doctor['user_id']; ?>"><?php echo $doctor['name']; ?></option>';
	<?php } ?>
<?php } ?>
		html += '                  </select></td>';
		html += '              </tr>';
		
		
		
		
		
		html += '  </table>';
		html += '		<div class="inner-footing">';
		html += '			<div class="buttons"><a onclick="savenew('+ form_row +');" class="button"><?php echo $button_save; ?></a><a  onclick="$(\'#vtabs a:first\').trigger(\'click\'); return false;" class="backlist button"><?php echo $button_cancel; ?></a></div>';
		html += '		</div>';
		html += '	</form>';	
		html += '</div>';

	
	$('#tab-childdoctor4').append(html);
	
	/*
	if (tabid) {
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=days_afterbirth]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=days_afterbirth]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=days_livein]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=days_livein]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk24]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=chk24]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk25]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=chk25]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk26]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=chk26]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk27a]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=chk27a]').val());
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk27b]').val($('#tab-childdoctor4form-'+ tabid + ' input[name*=chk27b]').val());
			<?php for ($i=1; $i<=23; $i++) { ?>
			$('#tab-childdoctor4form-'+ form_row + ' input[name*=chk<?php echo $i; ?>][value=' + $('#tab-childdoctor4form-'+ tabid + ' input[name*=chk<?php echo $i; ?>]:checked').val() + ']').attr("checked", "checked");
			<?php } ?>
			$('#tab-childdoctor4form-'+ tabid + ' input[name*=subject_healthedu]').each(function(){ 
				if ($(this).attr('checked')=='checked') {
					$('#tab-childdoctor4form-'+ form_row + ' input[name*=subject_healthedu][value=' + $(this).val() + ']').attr("checked", "checked");
				}
			});
			$('#tab-childdoctor4form-'+ form_row + ' [name*=supplement]').text($('#tab-childdoctor4form-'+ tabid + ' [name*=supplement]').val());
	}
	*/
	
	$('.backlist').show();
	
	$('#childdoctor4-add').before('<a href="#tab-childdoctor4form-' + form_row + '" id="childdoctor4form-' + form_row + '"><?php echo $tab_childdoctor4form; ?> ' + form_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.backlist\').trigger(\'click\'); $(\'#childdoctor4form-' + form_row + '\').remove(); $(\'#tab-childdoctor4form-' + form_row + '\').remove(); return false;" /></a>');
		 
	$('#vtabs a').tabs();
	$('#vtabs .scrolldiv').mCustomScrollbar("update");
	
	$('.date').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
	
	$('#childdoctor4form-' + form_row).trigger('click');
	
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
		$('[id^=childdoctor4form]').click(function() {
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
foreach ($childdoctor4forms as $childdoctor4form) { 
		$time = strtotime($childdoctor4form['date_added']); 
		$yyy = date('Y', $time);
		$mmm = date('m', $time)-1;
		$ddd = date('d', $time);
?>
				{
					title: '<?php echo $tab_childdoctor4form ?>',
					start: new Date(<?php echo $yyy.','.$mmm.','.$ddd;?>),
					url: '#childdoctor4form-<?php echo $roww; ?>',
					allDay: true
				}<?php if ($roww<count($childdoctor4forms)) { ?>,<?php } ?>
				
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
				addChildDoctor4(myDateString);
				return false;
			}
		});
		
		/*
		$("#calendar a[href=#tab-childdoctor4form-1]").live("click", function () {
			$('#childdoctor4form-1').trigger('click');
			return false;
		});
		*/
		
	});
//--></script> 
<?php echo $footer; ?>