<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?><?php echo (isset($customer_name)) ? "－".$customer_name : ""; ?></h1>
	  <?php if (isset($nurse2cs)) { ?>
	  <div class="buttons"><a onclick="location = '<?php echo $viewstat; ?>'" class="button" id="viewstat">觀看統計表</a></div>
	  <?php } ?>
    </div>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_date_start; ?><br />
            <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" size="12" /></td>
          <td><?php echo $entry_date_end; ?><br />
            <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" size="12" /></td>
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
          <td style="text-align: right;"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a><?php if (isset($nurse2cs)) { ?>&nbsp;<a id="printbtn" onclick="window.print();return false;" class="button" />列印統計圖</a><?php } ?></td>
        </tr>
      </table>
	  
<?php 
if (isset($nurse2cs)) { 
	  $chart1 = array(); $chart2 = array(); $chart3 = array(); $chart4a = array(); $chart4b = array();
	  foreach ($nurse2cs as $n) {
		$chart1['data'][] = array($n['date_added']*1000, (($n['24']==NULL)?0:$n['24']));
		$chart2['data'][] = array($n['date_added']*1000, (($n['25']==NULL)?0:$n['25']));
		$chart3['data'][] = array($n['date_added']*1000, (($n['26']==NULL)?0:$n['26']));
		$chart4a['data'][] = array($n['date_added']*1000, (($n['27a']==NULL)?0:$n['27a']));
		$chart4b['data'][] = array($n['date_added']*1000, (($n['27b']==NULL)?0:$n['27b']));
	  }
	  
	  
	  $chart1['label'] = "體溫(℃)";
	  $chart2['label'] = "脈搏(次/分鐘)";
	  $chart3['label'] = "呼吸(次/分鐘)";
	  $chart4a['label'] = "收縮壓(mmHg)";
	  $chart4b['label'] = "舒張壓(mmHg)";
?>
	  <table class="list">
	  <thead>
		<tr>
			<td class="center">體溫</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart1" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">脈搏</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart2" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">呼吸</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart3" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">血壓</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart4" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  </table>
<?php } ?>

	<div id="xxxxx"></div>
	
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/chart1&token=<?php echo $token; ?>';
	
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
	
	/*
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');
	
	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	
	*/

	location = url;
}

$(function () {
	$("select[name=filter_customer]").change(function () {
		$("#printbtn").hide();
		$("#viewstat").hide();
		$("table.list").hide();
		$(".pagination").hide();
	});
});
//--></script> 
<!--[if IE]>
<script type="text/javascript" src="view/javascript/jquery/flot/excanvas.js"></script>
<![endif]--> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.axislabels.js"></script> 
<script type="text/javascript" src="view/javascript/canvas2image/canvas2image.js"></script>
<script type="text/javascript" src="view/javascript/canvas2image/base64.js"></script>
<script type="text/javascript"><!--
$(function () {
	var d1 = <?php echo json_encode($chart1); ?>;
	var d2 = <?php echo json_encode($chart2); ?>;
	var d3 = <?php echo json_encode($chart3); ?>;
	var d4a = <?php echo json_encode($chart4a); ?>;
	var d4b = <?php echo json_encode($chart4b); ?>;
	
	var options = {
        xaxis: {
            //axisLabel: '日期',
            //axisLabelUseCanvas: true,
            //axisLabelFontSizePixels: 16,
			mode: "time",
			timeformat: "%m/%d",
            //axisLabelFontFamily: '微軟正黑體'
        },
        yaxis: {
            //axisLabel: '體溫',
			//axisLabelFontSizePixels: 14,
			//axisLabelFontFamily: '微軟正黑體',
            //axisLabelUseCanvas: true
        },
		grid: { hoverable: true, clickable: true },
		series: {
				points: { show: true },
                lines: {show: true, fill: false, steps: false }
		}
    };
	
	var decimaloptions = {
        xaxis: {
            //axisLabel: '日期',
            //axisLabelUseCanvas: true,
            //axisLabelFontSizePixels: 16,
			mode: "time",
			timeformat: "%m/%d",
            //axisLabelFontFamily: '微軟正黑體'
        },
        yaxis: {
            //axisLabel: '體溫',
			//axisLabelFontSizePixels: 14,
			//axisLabelFontFamily: '微軟正黑體',
            //axisLabelUseCanvas: true
			tickDecimals: 1
        },
		grid: { hoverable: true, clickable: true },
		series: {
				points: { show: true },
                lines: {show: true, fill: false, steps: false }
		}
    };

	
	plot1 = $.plot($("#chart1"), [ d1 ], decimaloptions );
	$.plot($("#chart2"), [ d2 ], options );
	$.plot($("#chart3"), [ d3 ], options );
	$.plot($("#chart4"), [ d4a, d4b ], options );
	
	/*
	myCanvas1 = plot1.getCanvas();
	myURL1 = myCanvas1.toDataURL("image/png","");
	
	$("#xxxxx").html(
                $("<img />", { src: myURL1,
                    "class": "output"
               }));
	*/
	
	// add some hovering logic to each point...
     var previousPoint = null;
    $("div[id^=chart]").not('#chart1').bind("plothover", function (event, pos, item) {
        $("#x").text(pos.x.toFixed(2));
        $("#y").text(pos.y.toFixed(2));

            if (item) {
                if (previousPoint != item.datapoint) {
                    previousPoint = item.datapoint;
                    $("#tooltip").remove();
					var x = item.datapoint[0].toFixed(0), y = item.datapoint[1].toFixed(0);
                    //showTooltip(item.pageX, item.pageY, item.series.label + " of " + x + " = " + y);
					showTooltip(item.pageX, item.pageY, y);
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;            
            }

    });
	
    $("div[id=chart1]").bind("plothover", function (event, pos, item) {
        $("#x").text(pos.x.toFixed(2));
        $("#y").text(pos.y.toFixed(2));

            if (item) {
                if (previousPoint != item.datapoint) {
                    previousPoint = item.datapoint;
                    $("#tooltip").remove();
					var x = item.datapoint[0].toFixed(0), y = item.datapoint[1].toFixed(1);
                    //showTooltip(item.pageX, item.pageY, item.series.label + " of " + x + " = " + y);
					showTooltip(item.pageX, item.pageY, y);
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;            
            }

    });

    // show the tooltip
    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            top: y - 35,
            left: x + 5,
            border: '1px solid #ccc',
            padding: '5px',
            'background-color': '#eee',
            opacity: 0.90
        }).appendTo("body").fadeIn(200);
    }

});

//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<?php echo $footer; ?>
