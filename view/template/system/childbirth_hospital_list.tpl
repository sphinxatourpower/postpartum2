<?php echo $header; ?>
<style type="text/css">		
.focusField {
	color: #000;
	border: solid 2px #EEEEEE !important;
	background: #FFEEEE !important;
}
.editable {
	color: #000;
	border: none;	
	background: none;
	cursor: pointer;
	text-align:left;
}
</style>
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
      <h1><img src="view/image/order.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list" id="formlist">
          <thead>
            <tr>
              <td width="50" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
			  <td class="left"><?php echo $column_name; ?></td>
              <td class="left"><?php if ($sort == 'sort_order') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($childbirth_hospitals) { ?>
            <?php foreach ($childbirth_hospitals as $childbirth_hospital) { ?>
            <tr>
              <td style="text-align: center;"><span class="dragable" style="float:left;"><img style="vertical-align:midle;" src="view/image/drag.png" height="20" alt="<?php echo $text_drag; ?>" title="<?php echo $text_drag; ?>" /></span><?php if ($childbirth_hospital['selected']) { ?>
				<input type="checkbox" name="selected[]" value="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>" checked="checked" id="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_select" />
                <?php } else { ?>
				<input type="checkbox" name="selected[]" value="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>" id="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_select" />
                <?php } ?></td>
			  <td class="left"><input type="text" size="30" class="editable" name="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_name" id="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_name" value="<?php echo $childbirth_hospital['name']; ?>" onclick='document.getElementById("<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_select").setAttribute("checked","checked");' /></td>
			  <td class="left dragedsort"><input type="text" size="5" class="editable" name="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_sort_order" id="<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_sort_order" value="<?php echo $childbirth_hospital['sort_order']; ?>" onclick='document.getElementById("<?php echo $childbirth_hospital['childbirth_hospital_id']; ?>_select").setAttribute("checked","checked");' /></td>
              <td class="right"><?php foreach ($childbirth_hospital['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<script type="text/javascript" src="view/javascript/jquery/jquery.dynotable.js"></script>
<script type="text/javascript"><!--
            $(document).ready(function() {                
                /*
                 * Table of beers, created with some custom config options and callbacks.
                 */
                $('#formlist').dynoTable({
                    removeClass: '.remove-beer',            //Custom remover class name in beers table 
                    cloneClass: '.clone-beer',              //Custom cloner class name in beers table 
                    addRowTemplateId: '#add-beer-template', //Custom id for beer row template 
                    addRowButtonId: '#add-beer',            //Click this to add a beer!
                    lastRowRemovable: false,                //Don't let the table be empty. Never run out of beer!
                    orderable: true,                        //can be rearranged
                    dragHandleClass: ".dragable",          //class for the click and draggable drag handle
                    /*
					onRowRemove: function(){
                        updateSortOrder();
                        //$('#msg').html("<span style='color:crimson'>Take one down, pass it around!</span>");
                    },
                    onRowClone: function(){
                        updateSortOrder();
                        //$('#msg').html("<span style='color:orange'>You cloned a beer, nice job.</span>");
                    },
                    onRowAdd: function(){
                        var numBeers = updateSortOrder();
                        //$('#msg').html("<span style='color:forestgreen'>" + numBeers +  " bottles of beer on the wall, woohoo!</span>");
                    },
					*/
                    onRowReorder: function(){
                        updateSortOrder();
						$("input[name='selected[]']").attr('checked', true);
                        //$('#msg').html("<span style='color:blue'>Beers got rearranged and renumbered</span>");
                    }
                }); 
                
                //updateSortOrder(); //initial bottles of beer
            });
            
            /**
             * Updates the current beer count 
             */
            function updateSortOrder() {
                var count = 0;
                $('.dragedsort').each(function(){ 
                    count++;
                    $(this).find("input").val(count);
                });
                return count;
            }
//--></script>
<script type="text/javascript"><!--		
$(document).ready(function() {
	$('.editable').focus(function() {
		$(this).addClass("focusField");		
      if (this.value == this.defaultValue){
        this.select();
    	}
      if(this.value != this.defaultValue){
	    	this.select();
      }
    });
    $('.editable').change(function() {
    	$(this).removeClass("focusField");				
      if (this.value == ''){
        this.value = (this.defaultValue ? this.defaultValue : '');			
    	}				
   });	
});
//--></script> 
<?php echo $footer; ?>