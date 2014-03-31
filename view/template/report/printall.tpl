<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <table class="form">
        <tr>
          <td>按產婦搜尋<br />
            <select name="filter_customer">
			  <option value="">請選擇</option>
              <?php foreach ($customers as $customer) { ?>
              <?php if ($customer['value'] == $filter_customer_id) { ?>
              <option value="<?php echo $customer['value']; ?>" selected="selected"><?php echo $customer['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $customer['value']; ?>"><?php echo $customer['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>	
          <td style="text-align: right;"><a id="btnfilter" class="button"><?php echo $button_filter; ?></a></td>
        </tr>
      </table>

 <div id="progressbar"></div>
 <div id="loadingMsg"></div>
 <div id="Results"></div>
 <div id="errormsg" style="color:Red;"></div>
	 

    </div>
  </div>
</div>

<script type="text/javascript" language="javascript"><!--
$(document).ready(function () {
	$("select[name=filter_customer]").change(function () {
		$("#Results").html("");
	});
   
   $("#progressbar").progressbar({ value: 0 });
   $("#progressbar").hide();
   $("#loadingMsg").hide();
   $("#btnfilter").click(function () {
			$("#progressbar").progressbar("value", 0);
			$("#Results").html("");
			$("#progressbar").show();
			$("#loadingMsg").show();
			
			//設定progress bar的顯示方式與速度
			var intervalID = setInterval(updateProgress, 100);
			
			url = 'index.php?route=report/printall/check&token=<?php echo $token; ?>';
			uword = 'index.php?route=report/printall/word&token=<?php echo $token; ?>';
			
			var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
			if (filter_date_start) {
				url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
				uword += '&filter_date_start=' + encodeURIComponent(filter_date_start);
			}

			var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
			if (filter_date_end) {
				url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
				uword += '&filter_date_end=' + encodeURIComponent(filter_date_end);
			}
		
			var filter_customer_id = $('select[name=\'filter_customer\']').attr('value');
			if (filter_customer_id) {
				url += '&filter_customer_id=' + encodeURIComponent(filter_customer_id);
				uword += '&filter_customer_id=' + encodeURIComponent(filter_customer_id);
			}
			
			//location = url;
			
			$.ajax({
					url: url,
					type: "POST",
					async: true,
					data: {},
					dataType: "json",                                    
					//當有錯誤發生時,在errormsg <div>中顯示錯誤訊息
					error: function (xhr, status, thrownError) {
							$("#errormsg").text(xhr.statusText);
							$("#errormsg").show();
					},
					//當處理成功時,關閉progerss bar與loading 訊息,
					//並且顯示Action處理後之資料
					success: function (data) {
							$("#progressbar").progressbar("value", 100);
							$("#progressbar").hide();
							var result = '';
							$.each(data, function (index, d) {
								result += "<table class=\"form list\">"
								if (d.name != '' && d.idnumber != '' ) {									
									result += "<tr><td>姓名:</td><td>" + d.name + "</td></tr>";
									result += "<tr><td>身份證字號:</td><td>" + d.idnumber + "</td></tr>";
								}
								if (d.report1a == 'done') {
									result += "<tr><td>1A 基本資料:</td><td>OK</td></tr>";
									uword += '&1a=true';
								} else {
									uword += '&1a=false';
								}
								if (d.stat1 == 'done') {
									result += "<tr><td>統計表格1:</td><td>OK</td></tr>";
									uword += '&stat1=true';
								} else {
									uword += '&stat1=false';
								}
								if (d.stat2 == 'done') {
									result += "<tr><td>統計表格2:</td><td>OK</td></tr>";
									uword += '&stat2=true';
								} else {
									uword += '&stat2=false';
								}
								if (d.report1e == 'done') {
									result += "<tr><td>1E 嬰兒入住醫師評估單:</td><td>OK</td></tr>";
									uword += '&1e=true';
								} else {
									uword += '&1e=false';
								}
								if (d.report2e == 'done') {
									result += "<tr><td>2E 小兒科醫師巡診單:</td><td>OK</td></tr>";
									uword += '&2e=true';
								} else {
									uword += '&2e=false';
								}
								if (d.report3e == 'done') {
									result += "<tr><td>3E 婦產科醫師巡診單:</td><td>OK</td></tr>";
									uword += '&3e=true';
								} else {
									uword += '&3e=false';
								}
								if (d.report1b == 'done') {
									result += "<tr><td>1B 護理人員嬰兒入住身評紀錄單:</td><td>OK</td></tr>";
									uword += '&1b=true';
								} else {
									uword += '&1b=false';
								}
								if (d.report2b == 'done') {
									result += "<tr><td>2B 護理人員接班評估單:</td><td>OK</td></tr>";
									uword += '&2b=true';
								} else {
									uword += '&2b=false';
								}
								if (d.report3b == 'done') {
									result += "<tr><td>3B 嬰兒室 I/O 紀錄單:</td><td>OK</td></tr>";
									uword += '&3b=true';
								} else {
									uword += '&3b=false';
								}
								if (d.report4b == 'done') {
									result += "<tr><td>4B 護理人員交班評估單:</td><td>OK</td></tr>";
									uword += '&4b=true';
								} else {
									uword += '&4b=false';
								}
								if (d.report1c == 'done') {
									result += "<tr><td>1C 產後衛教入住身體評估單:</td><td>OK</td></tr>";
									uword += '&1c=true';
								} else {
									uword += '&1c=false';
								}
								if (d.report3c == 'done') {
									result += "<tr><td>3C 產後衛教跌倒因子評估表:</td><td>OK</td></tr>";
									uword += '&3c=true';
								} else {
									uword += '&3c=false';
								}
								if (d.report4c == 'done') {
									result += "<tr><td>4C 產後衛教愛丁堡產後憂鬱量表:</td><td>OK</td></tr>";
									uword += '&4c=true';
								} else {
									uword += '&4c=false';
								}
								if (d.report2c == 'done') {
									result += "<tr><td>2C 產後衛教每日身體評估單:</td><td>OK</td></tr>";
									uword += '&2c=true';
								} else {
									uword += '&2c=false';
								}
								if (d.report2a == 'done') {
									result += "<tr><td>2A 嬰兒圖檔:</td><td>OK</td></tr>";
									uword += '&2a=true';
								} else {
									uword += '&2a=false';
								}
								
								result += "</table>";
							});
							
							$("#Results").html(result);
							clearInterval(intervalID);
							$("#loadingMsg").hide();$("#errormsg").text('').hide();
							$("#Results").append('<a href="' + uword + '" class="button">下載所有報表</a>');
					}
			});
			return false;
	});
});
  
function updateProgress() {
     var value = $("#progressbar").progressbar("option", "value");
      if (value < 100) {
        $("#progressbar").progressbar("value", value + 1);
      }
}         
 //--></script>

<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/printall&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_customer_id = $('select[name=\'filter_customer\']').attr('value');
	
	if (filter_customer_id) {
		url += '&filter_customer_id=' + encodeURIComponent(filter_customer_id);
	}

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<?php echo $footer; ?>