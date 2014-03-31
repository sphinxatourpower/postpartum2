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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/setting.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list rowclickable">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'cg.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="right"><?php if ($sort == 'cg.sort_order') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                <?php } ?></td>                
			  <td class="right" width="100"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($child_beds) { ?>
            <?php foreach ($child_beds as $child_bed) { ?>
            <tr>
              <td class="colnotclick" style="text-align: center;"><?php if ($child_bed['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $child_bed['child_bed_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $child_bed['child_bed_id']; ?>" />
                <?php } ?></td>
              <!--<td class="left"><a href="<?php echo $child_bed['editgroup']; ?>"><?php echo $child_bed['name']; ?></a></td>-->
			  <td class="left"><?php echo $child_bed['name']; ?></td>
              <td class="right"><?php echo $child_bed['sort_order']; ?></td>
              <td class="right"><?php foreach ($child_bed['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="3"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>


<style type="text/css">
  .hoveredRow, .hoveredRow td {  }
</style>
<script type="text/javascript"><!--
  $(document).on({
    mouseenter: function(){
      var link = $(this).find("a:contains('<?php echo $this->language->get('text_edit'); ?>')");
      if (link.length != 0) {
        $(this).css('cursor', 'pointer').addClass('hoveredRow');
      }
    }, 
    mouseleave: function(){ 
      $(this).removeClass('hoveredRow');
    }
  }, "tr");
	
  $(document).on("click", "td", function(){
		var link = $(this).parent().find("a:contains('<?php echo $this->language->get('text_edit'); ?>')").attr('href');
		if (!link) return;
		if (!$(this).html().match(/<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)) window.location=link;
	});
  
	$(document).on({
    click: function(){
      var job = $(this).find("a:first").attr('onclick');
      if (job.length != 0) eval(job);
    },
    mouseenter: function(){
      var link = $(this).find("a:first");
      if (link.length != 0) {
        $(this).css('cursor', 'pointer');
      }
    }
  }, '.image');
//--></script>
<?php echo $footer; ?> 