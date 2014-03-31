<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
<head>
<meta content='text/html; charset=UTF-8' http-equiv='Content-Type'/>
<link rel="icon" href="view/image/favico.png" type="image/x-icon">
<link rel="shortcut icon" href="view/image/favico.png" type="image/x-icon">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="view/javascript/jquery/ui/external/jquery.bgiframe-2.1.2.js"></script>
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="view/javascript/jquery/superfish/js/superfish.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="view/javascript/html5shiv/dist/html5shiv.js"></script>
<![endif]-->
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript">
//-----------------------------------------
// Confirm Actions (delete, uninstall)
//-----------------------------------------
$(document).ready(function(){
    // Confirm Delete
    $('#form').submit(function(){
        if ($(this).attr('action').indexOf('delete',1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
    	
    // Confirm Uninstall
    $('a').click(function(){
        if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
	
<?php if (!$mobilebrowser) { ?>
	$.event.add(window, "scroll", main_menu_scroll);

	var mainmenu = $('#menu');
	var menuwidth = $(mainmenu).innerWidth();
	var startMenu = $(mainmenu).offset().top;
	function main_menu_scroll() {
		var p = $(window).scrollTop();
		$(mainmenu).css('width', ((p)>startMenu) ? menuwidth : '');
		$(mainmenu).css('margin', ((p)>startMenu) ? '0 auto' : '');
		$(mainmenu).css('padding', ((p)>startMenu) ? '0' : '');
		$(mainmenu).find('#lefttopmenu').css('margin-left', ((p)>startMenu) ? '10px' : '');
		$(mainmenu).find('#righttopmenu').css('margin-right', ((p)>startMenu) ? '20px' : '');
		$(mainmenu).css('box-shadow',((p)>startMenu) ? '0px 3px 5px #999' : '');
		$(mainmenu).css('position',((p)>startMenu) ? 'fixed' : 'static');
		$(mainmenu).css('top',((p)>startMenu) ? '0px' : '');
	}
<?php } ?>
});
</script>
<script language="JavaScript" type="text/javascript"><!--
function clock() {
var d = new Date();
var month = d.getMonth()
var day = d.getDate();
var hours = d.getHours();
var minutes = d.getMinutes();
var seconds = d.getSeconds();

if (month == 0) month = "<?php echo $text_january; ?>"
 else if (month == 1) month = "<?php echo $text_february; ?>"
 else if (month == 2) month = "<?php echo $text_march; ?>"
 else if (month == 3) month = "<?php echo $text_april; ?>"
 else if (month == 4) month = "<?php echo $text_may; ?>"
 else if (month == 5) month = "<?php echo $text_june; ?>"
 else if (month == 6) month = "<?php echo $text_july; ?>"
 else if (month == 7) month = "<?php echo $text_august; ?>"
 else if (month == 8) month = "<?php echo $text_september; ?>"
 else if (month == 9) month = "<?php echo $text_october; ?>"
 else if (month == 10) month = "<?php echo $text_november; ?>"
 else if (month == 11) month = "<?php echo $text_december; ?>";

if (day <= 9) day = "0" + day;
if (hours <= 9) hours = "0" + hours;
if (minutes <= 9) minutes = "0" + minutes;
if (seconds <= 9) seconds = "0" + seconds;

//date_time =+ day + " " + month + " " + d.getFullYear() +
date_time =+ d.getFullYear() + "<?php echo $text_year; ?>" + month + "<?php echo $text_month; ?>" + day  + "<?php echo $text_day; ?>" +
" "+ hours + ":" + minutes + ":" + seconds;
if (document.layers) {
 document.layers.doc_time.document.write(date_time);
 document.layers.doc_time.document.close();
}
else document.getElementById("doc_time").innerHTML = date_time;
 setTimeout("clock()", 1000);
}
//--></script>
</head>
<body>

<div id="container">
<div id="header">
  <div class="div1">
    <div class="div2"><img src="view/image/logo.png" title="<?php echo $heading_title; ?>" onclick="location = '<?php echo $home; ?>'" /></div>
    <?php if ($logged) { ?>
	 <div id="doc_time" style="float:left;position:relative;top:21px;left:20px;color:white">
	  <script language="JavaScript" type="text/javascript">
		 clock();
	  </script>
	</div>
    <div class="div3"><img src="view/image/lock.png" alt="" style="position: relative; top: 3px;" />&nbsp;<?php echo $logged; ?></div>
    <?php } ?>
  </div>
  <?php if ($logged) { ?>
  <div id="menu">
    <ul id="lefttopmenu" class="left" style="display: none;">
      <li id="dashboard"><a rel="dashboard" href="<?php echo $home; ?>" class="top"><?php echo $text_dashboard; ?></a></li>
	  <li id="service"><a class="top"><?php echo $text_service; ?></a>
		<ul>
			<li><a rel="service" href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
			<li><a rel="service" href="<?php echo $child; ?>"><?php echo $text_child; ?></a></li>
			<li><a rel="service" href="<?php echo $satisfaction; ?>"><?php echo $text_satisfaction; ?></a></li>
		</ul>
	  </li>
	  <li id="nurse_dep"><a class="top"><?php echo $text_nurse_dep; ?></a>
		<ul>
			<li><a rel="nurse_dep" href="<?php echo $nurse1b; ?>"><?php echo $text_nurse1b; ?></a></li>
			<!--<li><a rel="nurse_dep" href="<?php echo $nurse2b; ?>"><?php echo $text_nurse2b; ?></a></li>-->
			<li><a rel="nurse_dep" href="<?php echo $nurse3b; ?>"><?php echo $text_nurse3b; ?></a></li>
			<!--<li><a rel="nurse_dep" href="<?php echo $nurse4b; ?>"><?php echo $text_nurse4b; ?></a></li>-->
			<li><a rel="nurse_dep" href="<?php echo $nurse1c; ?>"><?php echo $text_nurse1c; ?></a></li>
			<li><a rel="nurse_dep" href="<?php echo $nurse2c; ?>"><?php echo $text_nurse2c; ?></a></li>
			<li><a rel="nurse_dep" href="<?php echo $nurse4c; ?>"><?php echo $text_nurse4c; ?></a></li>
			<li><a rel="nurse_dep" href="<?php echo $beck; ?>"><?php echo $text_beck; ?></a></li>
		</ul>
	  </li>
	  <li id="pi_dep"><a class="top"><?php echo $text_pi_dep; ?></a>
		<ul>
			<li><a rel="pi_dep" href="<?php echo $edu1c; ?>"><?php echo $text_edu1c; ?></a></li>
		</ul>
	  </li>
	  <li id="bf_dep"><a class="top"><?php echo $text_bf_dep; ?></a>
		<ul>
			<li><a rel="bf_dep" href="<?php echo $breast2c; ?>"><?php echo $text_breast2c; ?></a></li>
			<li><a rel="bf_dep" href="<?php echo $nurse5c; ?>"><?php echo $text_nurse5c; ?></a></li>
			<li><a rel="bf_dep" href="<?php echo $breast1c; ?>"><?php echo $text_breast1c; ?></a></li>
		</ul>
	  </li>
	  <li id="doctor"><a class="top"><?php echo $text_doctor; ?></a>
		<ul>
			<li><a rel="doctor" href="<?php echo $childdoctor1; ?>"><?php echo $text_childdoctor1; ?></a></li>
			<li><a rel="doctor" href="<?php echo $childdoctor2; ?>"><?php echo $text_childdoctor2; ?></a></li>
			<li><a rel="doctor" href="<?php echo $childdoctor3; ?>"><?php echo $text_childdoctor3; ?></a></li>
		</ul>
	  </li>
      <li id="reports"><a class="top"><?php echo $text_reports; ?></a>
        <ul>
		  <li><a rel="reports" href="<?php echo $report_stat1; ?>"><?php echo $text_stat1; ?></a></li>
		  <li><a rel="reports" href="<?php echo $report_stat2; ?>"><?php echo $text_stat2; ?></a></li>
		  <li><a rel="reports" href="<?php echo $report_chart1; ?>"><?php echo $text_chart1; ?></a></li>
		  <li><a rel="reports" href="<?php echo $report_chart2; ?>"><?php echo $text_chart2; ?></a></li>
		  <li><a rel="reports" href="<?php echo $report_printall; ?>"><?php echo $text_printall; ?></a></li>
        </ul>
      </li>
      <li id="admins"><a class="top"><?php echo $text_admin; ?></a>
        <ul>
		  <li><a rel="admins" href="<?php echo $incident_report; ?>"><?php echo $text_incident_report; ?></a></li>
		  <li><a rel="admins" href="<?php echo $incident_category; ?>"><?php echo $text_incident_category; ?></a></li>
        </ul>
      </li>
      <li id="hrman"><a class="top"><?php echo $text_hr; ?></a>
        <ul>
		  <li><a rel="hrman" href="<?php echo $new_training; ?>"><?php echo $text_new_training; ?></a></li>
		  <li><a rel="hrman" href="<?php echo $staff_appraisal; ?>"><?php echo $text_staff_appraisal; ?></a></li>
        </ul>
      </li>
      <li id="system"><a class="top"><?php echo $text_system; ?></a>
        <ul>
          <li><a class="parent"><?php echo $text_users; ?></a>
            <ul>
              <li><a rel="system" href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
              <li><a rel="system" href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
            </ul>
          </li>
		  <li><a rel="system" href="<?php echo $customer_room; ?>"><?php echo $text_customer_room; ?></a></li>
		  <li><a rel="system" href="<?php echo $child_bed; ?>"><?php echo $text_child_bed; ?></a></li>
		  <li><a rel="system" href="<?php echo $childbirth_hospital; ?>"><?php echo $text_childbirth_hospital; ?></a></li>
		  <li><a rel="system" href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
        </ul>
      </li>
    </ul>
    <ul class="right" id="righttopmenu">
      <li id="logout"><a class="top" href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
    </ul>
    <script type="text/javascript"><!--
$(document).ready(function() {
	$('#menu > ul').superfish({
		hoverClass	 : 'sfHover',
		pathClass	 : 'overideThisToUse',
		delay		 : 0,
		animation	 : {height: 'show'},
		speed		 : 'normal',
		autoArrows   : false,
		dropShadows  : false, 
		disableHI	 : false, /* set to true to disable hoverIntent detection */
		onInit		 : function(){},
		onBeforeShow : function(){},
		onShow		 : function(){},
		onHide		 : function(){}
	});
	
	$('#menu > ul').css('display', 'block');
});
 
function getURLVar(urlVarName) {
	var urlHalves = String(document.location).toLowerCase().split('?');
	var urlVarValue = '';
	
	if (urlHalves[1]) {
		var urlVars = urlHalves[1].split('&');

		for (var i = 0; i <= (urlVars.length); i++) {
			if (urlVars[i]) {
				var urlVarPair = urlVars[i].split('=');
				
				if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
					urlVarValue = urlVarPair[1];
				}
			}
		}
	}
	
	return urlVarValue;
} 

$(document).ready(function() {
	route = getURLVar('route');
	
	if (!route) {
		$('#dashboard').addClass('selected');
	} else {
		part = route.split('/');
		
		url = part[0];
		
		if (part[1]) {
			url += '/' + part[1];
		}
		
		id = $('a[href*=\'' + url + '\']').attr("rel");
		$('li#' + id).addClass('selected');
	}
});
//--></script> 
  </div>
  <?php } ?>
</div>
