<div id="content" style="margin-top:1.5em;background: none;">
<div class="box">    
    <div class="heading">
		<h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
	</div>
    <div class="content">	
			<table class="form">
				<tr>
					<td><?php echo $entry_title; ?></td>
					<td><?php echo $title; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_category; ?></td>
					<td><span <?php if ($textcolor) { ?>style="color:<?php echo $textcolor; ?>"<?php } ?>><?php echo $news_category; ?></span></td>
				</tr>
				<tr>
					<td><?php echo $entry_date_added; ?></td>
					<td><?php echo $date_added<>'0000-00-00 00:00:00' && $date_added<>'' ? date('Y-m-d', strtotime($date_added)) : ''; ?>&nbsp;<?php echo $date_added<>'0000-00-00 00:00:00' && $date_added<>'' ? date('H:i:s', strtotime($date_added)) : ''; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_description; ?></td>
					<td><?php echo $description; ?></td>
				</tr>
      </table>
  </div>
    <div class="footing"></div>
 </div>
</div>

