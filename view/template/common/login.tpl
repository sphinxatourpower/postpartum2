<?php echo $header; ?>
<div id="content">
  <div class="box" style="width: 400px; min-height: 300px; margin-top: 40px; margin-left: auto; margin-right: auto;">
    <div class="heading">
      <h1><img src="view/image/lockscreen.png" alt="" /> <?php echo $text_login; ?></h1>
    </div>
    <div class="content" style="min-height: 150px; overflow: hidden;">
      <?php if ($success) { ?>
      <div class="success"><?php echo $success; ?></div>
      <?php } ?>
      <?php if ($error_warning) { ?>
      <div class="warning"><?php echo $error_warning; ?></div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table style="width: 100%;">
          <tr>
            <td style="text-align: center;" rowspan="4"><img src="view/image/login.png" alt="<?php echo $text_login; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_username; ?><br />
              <input type="text" name="username" value="<?php echo $username; ?>" style="margin-top: 4px;" />
              <br />
              <br />
              <?php echo $entry_password; ?><br />
              <input type="password" name="password" value="<?php echo $password; ?>" style="margin-top: 4px;" />
              <!--<br />
              <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>--></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align: right;"><a onclick="$('#form').submit();" class="button"><?php echo $button_login; ?></a></td>
          </tr>
        </table>
        <?php if ($redirect) { ?>
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        <?php } ?>
      </form>
    </div>
    <div class="content" style="min-height: 100px; overflow: hidden;" id="signform">
        <table style="width: 100%;">
          <tr>
            <td style="text-align: center;" rowspan="3"><img src="view/image/signin.png" alt="<?php echo $text_login; ?>" /></td>
          </tr>
          <tr>
            <td>		
				<div id="doc_time" style="color:#333;text-align:right;">
					<script language="JavaScript" type="text/javascript">
						clock();
					</script>
				</div>
			</td>
          </tr>
          <tr>
            <td style="text-align: right;"><a onclick="onduty();" class="button">上班</a>&nbsp;<a onclick="finishwork();" class="button">下班</a></td>
          </tr>
        </table>
    </div>
	
  </div>
</div>
<script type="text/javascript"><!--
$("input[name=username]").focus();
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#form').submit();
	}
});

function onduty() {
	if (!$('input[name=username]').val() || !$('input[name=password]').val()) { alert('請輸入帳號密碼'); return false; }
	//$('input[name=dutytime]').val($('#doc_time').text());
	$.ajax({
		url: 'index.php?route=common/login/onduty',
		type: 'post',
		dataType: 'json',
		data: 'username=' + encodeURIComponent($('#form input[name=\'username\']').val()) + '&password=' + encodeURIComponent($('#form input[name=\'password\']').val()) + '&time=' + encodeURIComponent($('#doc_time').text()),
		beforeSend: function() {
			$('.success, .warning').remove();
			//$('#button-transfer').attr('disabled', true);
			$('#signform a.button').hide();
			$('#signform').after('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			//$('#button-transfer').attr('disabled', false);
			//$('.attention').remove();
		},
		/*
		success: function(html) {
			$('#transfer').html(html);
			
			$('#tab-transfer select[name=\'customer_room_id\']').val('');
			//$('#tab-transfer input[name=\'description\']').val('');
			//$('#tab-transfer input[name=\'extra_period\']').val('');
		}
		*/
		success: function(json) {	
				$('.attention').remove();
				$('#signform a.button').show();
				
				response($.map(json, function(item) {
					/*return {
						label: item['name'],
						value: item['customer_id'],
						room_name: item['room_name']
					}*/
					if (item['success']) {
						$('#signform').after('<div class="success">'+item['msg']+'&nbsp;<a onclick="$(\'#form\').submit();" class="button">登入系統</a></div>');
					} else {
						$('#signform').after('<div class="warning">'+item['msg']+'</div>');
					}
				}));
		}
	});	
}
function finishwork() {
	if (!$('input[name=username]').val() || !$('input[name=password]').val()) { alert('請輸入帳號密碼'); return false; }
	//$('input[name=dutytime]').val($('#doc_time').text());
	$.ajax({
		url: 'index.php?route=common/login/finishwork',
		type: 'post',
		dataType: 'json',
		data: 'username=' + encodeURIComponent($('#form input[name=\'username\']').val()) + '&password=' + encodeURIComponent($('#form input[name=\'password\']').val()) + '&time=' + encodeURIComponent($('#doc_time').text()),
		beforeSend: function() {
			$('.success, .warning').remove();
			//$('#button-transfer').attr('disabled', true);
			$('#signform a.button').hide();
			$('#signform').after('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			//$('#button-transfer').attr('disabled', false);
			//$('.attention').remove();
		},
		/*
		success: function(html) {
			$('#transfer').html(html);
			
			$('#tab-transfer select[name=\'customer_room_id\']').val('');
			//$('#tab-transfer input[name=\'description\']').val('');
			//$('#tab-transfer input[name=\'extra_period\']').val('');
		}
		*/
		success: function(json) {	
				$('.attention').remove();
				$('#signform a.button').show();
				
				response($.map(json, function(item) {
					/*return {
						label: item['name'],
						value: item['customer_id'],
						room_name: item['room_name']
					}*/
					if (item['success']) {
						$('#signform').after('<div class="success">'+item['msg']+'</div>');
					} else {
						$('#signform').after('<div class="warning">'+item['msg']+'</div>');
					}
				}));
		}
	});	
}

//--></script>  
<?php echo $footer; ?>