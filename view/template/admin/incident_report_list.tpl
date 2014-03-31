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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a><a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="button"><?php echo $button_copy; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
  <div class="content">
    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="list">
        <thead>
          <tr>
            <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="left"><?php if ($sort == 'n.news_category_id') { ?>
              <a href="<?php echo $sort_category; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
              <?php } else { ?>
              <a href="<?php echo $sort_category; ?>"><?php echo $column_title; ?></a>
              <?php } ?></td>
            <td class="left"><?php if ($sort == 'n.date_added') { ?>
              <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
              <?php } else { ?>
              <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
              <?php } ?></td>
            <td class="left"><?php echo $column_service; ?></td>
            <td class="right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
            <tr class="filter">
              <td></td>
			  <td><select name="filter_category">
					<option value="*"></option>
                    <?php foreach ($news_categories as $category) { ?>
                    <?php if ($category['news_category_id'] == $filter_category) { ?>
                    <option value="<?php echo $category['news_category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category['news_category_id']; ?>"><?php echo $category['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                </select></td>
              <td><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="10" class="date" /></td>
              <td><select name="filter_user_id">
                  <option value="*"></option>
						<?php foreach ($nurses as $nurse) { ?>
						  <?php if ($nurse['user_id'] == $filter_user_id) { ?>
						  <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
						  <?php } ?>
						<?php } ?>
                </select></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
          <?php if ($newss) { ?>
          <?php foreach ($newss as $news) { ?>
          <tr>
            <td style="text-align: center;"><?php if ($news['selected']) { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $news['news_id']; ?>" checked="checked" />
              <?php } else { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $news['news_id']; ?>" />
              <?php } ?></td>
			<td class="left"><span <?php if ($news['textcolor']) { ?>style="color:<?php echo $news['textcolor']; ?>"<?php } ?>><?php echo $news['category']; ?></span>&nbsp;<?php echo $news['title']; ?></td>
            <td class="left"><?php echo $news['date_added']; ?></td>
            <td class="left"><?php echo $news['reportername']; ?></td>
            <td class="right"><?php foreach ($news['action'] as $action) { ?>
              [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
              <?php } ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
    </form>
    <div class="pagination"><?php echo $pagination; ?></div>
  </div>
 </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=admin/incident_report&token=<?php echo $token; ?>';
	
	var filter_category = $('select[name=\'filter_category\']').attr('value');
	
	if (filter_category != '*') {
		url += '&filter_category=' + encodeURIComponent(filter_category);
	}
	
	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}
	
	var filter_user_id = $('select[name=\'filter_user_id\']').attr('value');
	
	if (filter_user_id != '*') {
		url += '&filter_user_id=' + encodeURIComponent(filter_user_id);
	}

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script> 
<script type="text/javascript"><!--
$('input.date').datepicker({
	dateFormat: 'yy-mm-dd'
});
//--></script>
<?php echo $footer; ?>