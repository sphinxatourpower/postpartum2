<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?><?php echo (isset($child_name)) ? "－".$child_name : ""; ?></h1>
	  <?php if (isset($nurse3bs)) { ?>
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
          <td>按嬰兒搜尋<br />
            <select name="filter_child">
			  <option value="">請選擇</option>
              <?php foreach ($childs as $child) { ?>
              <?php if ($child['value'] == $filter_child_id) { ?>
              <option value="<?php echo $child['value']; ?>" selected="selected"><?php echo $child['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $child['value']; ?>"><?php echo $child['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
          <td style="text-align: right;"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a><?php if (isset($nurse3bs)) { ?>&nbsp;<a id="printbtn" onclick="window.print();return false;" class="button" />列印統計圖</a><?php } ?></td>
        </tr>
      </table>
	  
<?php 
if (isset($nurse3bs)) { 
	  $chart1 = array(); $chart2 = array(); $chart3 = array(); $chart4 = array();$chart5 = array(); $chart6 = array();$chart7 = array();$chart8 = array();$chart9 = array();$chart10 = array();
	  foreach ($nurse3bs as $n) {
		$chart1['data'][] = array($n['date_added']*1000, $n['1']);
		$chart2['data'][] = array($n['date_added']*1000, $n['2']);
		$chart3['data'][] = array($n['date_added']*1000, $n['3']);
		$chart4['data'][] = array($n['date_added']*1000, $n['6']);
		$chart5['data'][] = array($n['date_added']*1000, $n['7']);
		$chart6['data'][] = array($n['date_added']*1000, $n['5']);
		$chart7['data'][] = array($n['date_added']*1000, $n['4']);
		$chart8['data'][] = array($n['date_added']*1000, $n['10']);
		$chart9['data'][] = array($n['date_added']*1000, $n['13']);
		$chart10['data'][] = array($n['date_added']*1000, $n['14']);
	  }
	  
	  $chart1['label'] = "體溫(℃)";
	  $chart2['label'] = "脈搏(次/分鐘)";
	  $chart3['label'] = "呼吸(次/分鐘)";
	  $chart4['label'] = "瓶餵配方奶量(cc)";
	  $chart5['label'] = "瓶餵母奶量(cc)";
	  $chart6['label'] = "瓶餵食量(cc)";
	  $chart7['label'] = "親餵時間(分鐘)";
	  $chart8['label'] = "體重(公克)";
	  $chart9['label'] = "黃疸值(mg/dL)";
	  $chart10['label'] = "母嬰同室時間(分鐘)";
	  
	 //print"<pre>";print_r($chart1);print"</pre>";
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
			<td class="center">瓶餵配方奶量</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart4" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">瓶餵母奶量</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart5" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">瓶餵食量</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart6" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">親餵時間</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart7" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">體重</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart8" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">黃疸值</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart9" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  <thead>
		<tr>
			<td class="center">母嬰同室時間</td>
		</tr>
	  </thead>
	  <tbody>
		<tr>
			<td><div id="chart10" style="width: 950px; height: 300px; margin: 15px auto;"></div></td>
		</tr>
	  </tbody>
	  </table>
<?php } ?>

    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/chart2&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_child_id = $('select[name=\'filter_child\']').attr('value');
	
	if (filter_child_id) {
		url += '&filter_child_id=' + encodeURIComponent(filter_child_id);
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
	$("select[name=filter_child]").change(function () {
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
<script type="text/javascript"><!--
$(function () {
	var d1 = <?php echo json_encode($chart1); ?>;
	var d2 = <?php echo json_encode($chart2); ?>;
	var d3 = <?php echo json_encode($chart3); ?>;
	var d4 = <?php echo json_encode($chart4); ?>;
	var d5 = <?php echo json_encode($chart5); ?>;
	var d6 = <?php echo json_encode($chart6); ?>;
	var d7 = <?php echo json_encode($chart7); ?>;
	var d8 = <?php echo json_encode($chart8); ?>;
	var d9 = <?php echo json_encode($chart9); ?>;
	var d10 = <?php echo json_encode($chart10); ?>;
	
	var options = {
        xaxis: {
            //axisLabel: '日期',
            //axisLabelUseCanvas: true,
            //axisLabelFontSizePixels: 16,
			mode: "time",
			timeformat: "%m/%d %h:%M"
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
			timeformat: "%m/%d %h:%M"
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
	
	var baroptions = {
		series: {
				//stack: 0,
				points: { show: true },
                lines: {show: false, fill: true, steps: false },
                bars: {show: true, barWidth: 2*60*60*1000}
		},
		grid: { hoverable: true, clickable: true },
        xaxis: {
            //axisLabel: '日期',
            //axisLabelUseCanvas: true,
            //axisLabelFontSizePixels: 16,
			mode: "time",
			timeformat: "%m/%d %h:%M"
            //axisLabelFontFamily: '微軟正黑體'
        }
    };
	
	$.plot($("#chart1"), [ d1 ], decimaloptions );
	$.plot($("#chart2"), [ d2 ], options );
	$.plot($("#chart3"), [ d3 ], options );
	$.plot($("#chart4"), [ d4 ], options );
	$.plot($("#chart5"), [ d5 ], options );
	$.plot($("#chart6"), [ d6 ], options );
	$.plot($("#chart7"), [ d7 ], baroptions );
	$.plot($("#chart8"), [ d8 ], options );
	$.plot($("#chart9"), [ d9 ], decimaloptions );
	$.plot($("#chart10"), [ d10 ], baroptions );
	
	
	// add some hovering logic to each point...
     var previousPoint = null;
    $("div[id=chart1], div[id=chart9]").bind("plothover", function (event, pos, item) {
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
	
	$("div[id^=chart]").not('#chart1, #chart9').bind("plothover", function (event, pos, item) {
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