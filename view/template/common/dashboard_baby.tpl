<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/home.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">

	  <div class="content">
			<table class="form list">
			  <tr><td class="caption" colspan="2">寶寶身體資訊</td></tr>
			  <tr>
                <td width="15%">體溫</td>
                <td><?php if ($temperature) { ?><span <?php echo ($temperature_color<>'') ? "style=\"color:".$temperature_color."\"" : '' ?>><?php echo $temperature; ?></span> °C<?php } else { ?><span>無資料</span><?php } ?></td>
			  </tr>
			  <tr>
				<td>體重</td>
				<td><?php if ($weight) { ?><span <?php echo ($weight_color<>'') ? "style=\"color:".$weight_color."\"" : '' ?>><?php echo $weight; ?></span> 公克<?php } else { ?><span>無資料</span><?php } ?></td>
              </tr>
			  <tr>
				<td>黃疸值</td>
				<td><?php if ($jaundice) { ?><span <?php echo ($jaundice_color<>'') ? "style=\"color:".$jaundice_color."\"" : '' ?>><?php echo $jaundice; ?></span> mg/dL<?php } else { ?><span>無資料</span><?php } ?></td>
              </tr>
			  <tr>
				<td>小便次數</td>
				<td><?php if ($piss) { ?><span <?php echo ($piss_color<>'') ? "style=\"color:".$piss_color."\"" : '' ?>><?php echo $piss; ?></span> 次／天<?php } else { ?><span>無資料</span><?php } ?></td>
              </tr>
			</table>
	  </div>
	  
	  <div class="content">
		<?php if (!empty($icons)) { ?>
		<?php foreach ($icons as $i) { ?>
            	<a href="<?php echo $i['href']; ?>" class="dashboard-module">
                	<img src="<?php echo $i['image']; ?>" width="64" height="64" alt="<?php echo $i['title']; ?>" />
                	<span><?php echo $i['title']; ?></span>
                </a>
		<?php } ?>
				<div style="clear: both"></div>
		<?php } ?>
	  </div>
  </div>
</div>
</div>
  
<?php echo $footer; ?>