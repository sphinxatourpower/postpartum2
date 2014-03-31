<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_install) { ?>
  <div class="warning"><?php echo $error_install; ?></div>
  <?php } ?>
  <?php if ($error_image) { ?>
  <div class="warning"><?php echo $error_image; ?></div>
  <?php } ?>
  <?php if ($error_image_cache) { ?>
  <div class="warning"><?php echo $error_image_cache; ?></div>
  <?php } ?>
  <?php if ($error_cache) { ?>
  <div class="warning"><?php echo $error_cache; ?></div>
  <?php } ?>
  <?php if ($error_download) { ?>
  <div class="warning"><?php echo $error_download; ?></div>
  <?php } ?>
  <?php if ($error_logs) { ?>
  <div class="warning"><?php echo $error_logs; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/home.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <div class="overview">
        <div class="dashboard-heading"><?php echo $text_overview; ?></div>
		<div class="dashboard-content">
          <table class="form">
            <tr class="signwork">
              <td><?php echo $text_signwork; ?></td>
              <td class="sstatus" style="text-align:left;">
			  <?php if ($ondutytime!='') { ?>
				今日上班打卡時間：<?php echo $ondutytime; ?>&nbsp;<a class="button" onclick="finishwork();">下班打卡</a>
			  <?php } else { ?>
				上班未打卡，請補打卡&nbsp;<a class="button" onclick="onduty();">上班打卡</a>
			  <?php } ?>
			  </td>
            </tr>
            <tr class="ptemperature">
              <td><?php echo $text_personal_temperature; ?></td>
              <td></td>
            </tr>
			<tr class="babyroominfo">
              <td><?php echo $text_babyroom_info; ?></td>
              <td></td>
            </tr>
			<tr class="refrigeratorinfo">
              <td><?php echo $text_refrigerator_info; ?></td>
              <td></td>
            </tr>		
<!--			
            <tr>
              <td><?php echo $text_total_customer; ?></td>
              <td><?php echo $total_customer; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_customer_approval; ?></td>
              <td><?php echo $total_customer_approval; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_review_approval; ?></td>
              <td><?php echo $total_review_approval; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_affiliate; ?></td>
              <td><?php echo $total_affiliate; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_affiliate_approval; ?></td>
              <td><?php echo $total_affiliate_approval; ?></td>
            </tr>
-->			
          </table>
        </div>
      </div>
	  <div id="calendar" style="float:right;width:50%"></div>
  </div>
</div>
</div>

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
			height: 650,
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
	 foreach ($customers as $k => $customer) {
			$foo = str_replace("&amp;","&",$customer['url']); 
			$start_y = date('Y', strtotime( $customer['date_added'] ));
			$start_m = (int)date('m', strtotime( $customer['date_added'] )) - 1;
			$start_d = date('d', strtotime( $customer['date_added'] ));
			$start_hh = date('H', strtotime( $customer['date_added'] ));
			$start_mm = date('i', strtotime( $customer['date_added'] ));
			$end_y = date('Y', strtotime( $customer['date_leave'] ));
			$end_m = (int)date('m', strtotime( $customer['date_leave'] )) - 1;
			$end_d = date('d', strtotime( $customer['date_leave'] ));
			$end_hh = date('H', strtotime( $customer['date_leave'] ));
			$end_mm = date('i', strtotime( $customer['date_leave'] ));
?>
				{
					title: '<?php echo $customer['name'].$customer['room']; ?>',
					start: new Date(<?php echo $start_y.','.$start_m.','.$start_d.','.$start_hh.','.$start_mm;?>),
					end: new Date(<?php echo $end_y.','.$end_m.','.$end_d.','.$end_hh.','.$end_mm;?>),
					url: '<?php echo $foo; ?>',
					allDay: false
				}<?php if ($k+1<count($customers)) { ?>,<?php } ?>
				
<?php
	 }
?>
			]
		});
	});
//--></script> 
<script type="text/javascript"><!--
function onduty() {
	$.ajax({
		url: 'index.php?route=common/login/onduty&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'time=' + encodeURIComponent($('#doc_time').text()) + '&keeplogin=true',
		beforeSend: function() {
			$('.sumsg, .warnmsg').remove();
			$('tr.signwork a.button').hide();
			$('.box').before('<div class="smsg attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		success: function(json) {	
				$('.smsg').remove();
				
				response($.map(json, function(item) {
					if (item['success']) {
						$('.box').before('<div class="sumsg success">'+item['msg']+'</div>');
						$('.signwork .sstatus').html('上班時間：'+item['time']);
					} else {
						$('tr.signwork a.button').show();
						$('.box').before('<div class="warnmsg warning">'+item['msg']+'</div>');
					}
				}));
		}
	});	
}
function finishwork() {
	$.ajax({
		url: 'index.php?route=common/login/finishwork&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		//data: 'time=' + encodeURIComponent($('#doc_time').text())  + '&keeplogin=true',
		data: 'time=' + encodeURIComponent($('#doc_time').text()),
		beforeSend: function() {
			$('.sumsg, .warnmsg').remove();
			$('tr.signwork a.button').hide();
			$('.box').before('<div class="smsg attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		success: function(json) {	
				$('.smsg').remove();
				
				response($.map(json, function(item) {
					if (item['success']) {
						$('.box').before('<div class="sumsg success">'+item['msg']+'</div>');
						$('.signwork .sstatus').html('下班時間：'+item['time']);
					} else {
						$('tr.signwork a.button').show();
						$('.box').before('<div class="warnmsg warning">'+item['msg']+'</div>');
					}
				}));
		}
	});	
}
//--></script>  
<?php echo $footer; ?>