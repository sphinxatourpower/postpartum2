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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $customer_name;?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-nurse1c"><?php echo $tab_nurse1c; ?></a><a href="#tab-nurse1c2"><?php echo $tab_nurse1c."[二]"; ?></a><a href="#tab-nurse1c3"><?php echo $tab_nurse1c."[三]"; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse1c">
          <table class="form list">
			  <tr>
                <td width="15%">護理人員</td>
                <td width="35%"><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
				<td width="15%"></td>
				<td width="35%"></td>
              </tr>
			  <tr>
                <td>體溫</td>
                <td><input type="text" name="chk1" value="<?php echo $chk1; ?>" size="12" /> ℃</td>
                <td>脈搏</td>
                <td><input type="text" name="chk2" value="<?php echo $chk2; ?>" size="12" /> (每分鐘)</td>
              </tr>
			  <tr>
                <td>呼吸</td>
                <td><input type="text" name="chk3" value="<?php echo $chk3; ?>" size="12" /> (每分鐘)</td>
                <td>血壓</td>
                <td>收縮壓：<input type="text" name="chk4a" value="<?php echo $chk4a; ?>" size="12" /> mmHg&nbsp;&nbsp;舒張壓：<input type="text" name="chk4b" value="<?php echo $chk4b; ?>" size="12" /> mmHg</td>
              </tr>
			  <tr>
                <td>頸部</td>
			<?php  $c5 = explode(':', $chk5);
			  if ($c5[0] == "其他") { $chk5 = $c5[0];  $chk5_other = $c5[1]; } 
			  else { $chk5 = $c5[0];  $chk5_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk5"  <?php echo ($chk5=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="僵硬" name="chk5"  <?php echo ($chk5=="僵硬")? "checked":""; ?>/> 僵硬</div>
				  <div class="odd"><input type="radio"  value="疼痛" name="chk5"  <?php echo ($chk5=="疼痛")? "checked":""; ?>/> 疼痛</div>
				  <div class="even"><input type="radio"  value="腫塊" name="chk5"  <?php echo ($chk5=="腫塊")? "checked":""; ?>/> 腫塊</div>
				  <div class="odd"><input type="radio"  value="其他" name="chk5"  <?php echo ($chk5=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk5_other" value="<?php echo $chk5_other; ?>" size="12" /></div>
                </div></td>
                <td>眼</td>
			<?php $c6 = (!empty($chk6))? unserialize($chk6) : array(); $otherchecked6 = false; $chk6_other = '';
				if (!empty($c6)) {
					foreach ($c6 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked6= true;  $chk6_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk6[]"  <?php echo (!empty($c6) && in_array("正常", $c6 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="近視" name="chk6[]"  <?php echo (!empty($c6) && in_array("近視", $c6 ))? "checked":""; ?>/> 近視</div>
				  <div class="odd"><input type="checkbox"  value="遠視" name="chk6[]"  <?php echo (!empty($c6) && in_array("遠視", $c6 ))? "checked":""; ?>/> 遠視</div>
				  <div class="even"><input type="checkbox"  value="閃光" name="chk6[]"  <?php echo (!empty($c6) && in_array("閃光", $c6 ))? "checked":""; ?>/> 閃光</div>
				  <div class="odd"><input type="checkbox"  value="結膜出血" name="chk6[]"  <?php echo (!empty($c6) && in_array("結膜出血", $c6 ))? "checked":""; ?>/> 結膜出血</div>
				  <div class="even"><input type="checkbox"  value="眼瞼水腫" name="chk6[]"  <?php echo (!empty($c6) && in_array("眼瞼水腫", $c6 ))? "checked":""; ?>/> 眼瞼水腫</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk6[]"  <?php echo ($otherchecked6)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk6_other" value="<?php echo $chk6_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>耳</td>
			<?php $c7 = (!empty($chk7))? unserialize($chk7) : array(); $otherchecked7 = false; $chk7_other = '';
				if (!empty($c7)) {
					foreach ($c7 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked7= true;  $chk7_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk7[]"  <?php echo (!empty($c7) && in_array("正常", $c7 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="耳鳴" name="chk7[]"  <?php echo (!empty($c7) && in_array("耳鳴", $c7 ))? "checked":""; ?>/> 耳鳴</div>
				  <div class="odd"><input type="checkbox"  value="暈眩" name="chk7[]"  <?php echo (!empty($c7) && in_array("暈眩", $c7 ))? "checked":""; ?>/> 暈眩</div>
				  <div class="even"><input type="checkbox"  value="聽障" name="chk7[]"  <?php echo (!empty($c7) && in_array("聽障", $c7 ))? "checked":""; ?>/> 聽障</div>
				  <div class="odd"><input type="checkbox"  value="疼痛" name="chk7[]"  <?php echo (!empty($c7) && in_array("疼痛", $c7 ))? "checked":""; ?>/> 疼痛</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk7[]"  <?php echo ($otherchecked7)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk7_other" value="<?php echo $chk7_other; ?>" size="12" /></div>
                </div></td>
                <td>鼻</td>
			<?php $c8 = (!empty($chk8))? unserialize($chk8) : array(); $otherchecked8 = false; $chk8_other = '';
				if (!empty($c8)) {
					foreach ($c8 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked8= true;  $chk8_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk8[]"  <?php echo (!empty($c8) && in_array("正常", $c8 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="鼻塞" name="chk8[]"  <?php echo (!empty($c8) && in_array("鼻塞", $c8 ))? "checked":""; ?>/> 鼻塞</div>
				  <div class="odd"><input type="checkbox"  value="流血" name="chk8[]"  <?php echo (!empty($c8) && in_array("流血", $c8 ))? "checked":""; ?>/> 流血</div>
				  <div class="even"><input type="checkbox"  value="鼻炎" name="chk8[]"  <?php echo (!empty($c8) && in_array("鼻炎", $c8 ))? "checked":""; ?>/> 鼻炎</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk8[]"  <?php echo ($otherchecked8)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk8_other" value="<?php echo $chk8_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>口腔</td>
			<?php $c9 = (!empty($chk9))? unserialize($chk9) : array(); $otherchecked9 = false; $chk9_other = '';
				if (!empty($c9)) {
					foreach ($c9 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked9= true;  $chk9_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk9[]"  <?php echo (!empty($c9) && in_array("正常", $c9 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="潰瘍" name="chk9[]"  <?php echo (!empty($c9) && in_array("潰瘍", $c9 ))? "checked":""; ?>/> 潰瘍</div>
				  <div class="odd"><input type="checkbox"  value="假牙" name="chk9[]"  <?php echo (!empty($c9) && in_array("假牙", $c9 ))? "checked":""; ?>/> 假牙</div>
				  <div class="even"><input type="checkbox"  value="蛀牙" name="chk9[]"  <?php echo (!empty($c9) && in_array("蛀牙", $c9 ))? "checked":""; ?>/> 蛀牙</div>
				  <div class="odd"><input type="checkbox"  value="咳嗽" name="chk9[]"  <?php echo (!empty($c9) && in_array("咳嗽", $c9 ))? "checked":""; ?>/> 咳嗽</div>
				  <div class="even"><input type="checkbox"  value="舌潰爛" name="chk9[]"  <?php echo (!empty($c9) && in_array("舌潰爛", $c9 ))? "checked":""; ?>/> 舌潰爛</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk9[]"  <?php echo ($otherchecked9)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk9_other" value="<?php echo $chk9_other; ?>" size="12" /></div>
                </div></td>
				<td></td>
				<td></td>
              </tr>
          </table>
		</div>
        <div id="tab-nurse1c2">
          <table class="form list">
			  <tr>
                <td width="15%">乳頭(R)</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk10"  <?php echo ($chk10=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="偏平" name="chk10"  <?php echo ($chk10=="偏平")? "checked":""; ?>/> 偏平</div>
				  <div class="odd"><input type="radio"  value="凹陷" name="chk10"  <?php echo ($chk10=="凹陷")? "checked":""; ?>/> 凹陷</div>
				  <div class="even"><input type="radio"  value="過大" name="chk10"  <?php echo ($chk10=="過大")? "checked":""; ?>/> 過大</div>
				  <div class="odd"><input type="radio"  value="破皮" name="chk10"  <?php echo ($chk10=="破皮")? "checked":""; ?>/> 破皮</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk10"  <?php echo ($chk10=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
                <td width="15%">乳頭(L)</td>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="正常" name="chk11"  <?php echo ($chk11=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="偏平" name="chk11"  <?php echo ($chk11=="偏平")? "checked":""; ?>/> 偏平</div>
				  <div class="odd"><input type="radio"  value="凹陷" name="chk11"  <?php echo ($chk11=="凹陷")? "checked":""; ?>/> 凹陷</div>
				  <div class="even"><input type="radio"  value="過大" name="chk11"  <?php echo ($chk11=="過大")? "checked":""; ?>/> 過大</div>
				  <div class="odd"><input type="radio"  value="破皮" name="chk11"  <?php echo ($chk11=="破皮")? "checked":""; ?>/> 破皮</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk11"  <?php echo ($chk11=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
              </tr>
			  <tr>
                <td>乳暈(R)</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="柔軟" name="chk12"  <?php echo ($chk12=="柔軟")? "checked":""; ?>/> 柔軟</div>
				  <div class="even"><input type="radio"  value="微硬" name="chk12"  <?php echo ($chk12=="微硬")? "checked":""; ?>/> 微硬</div>
				  <div class="odd"><input type="radio"  value="結塊" name="chk12"  <?php echo ($chk12=="結塊")? "checked":""; ?>/> 結塊</div>
				  <div class="even"><input type="radio"  value="紅腫" name="chk12"  <?php echo ($chk12=="紅腫")? "checked":""; ?>/> 紅腫</div>
				  <div class="odd"><input type="radio"  value="水腫" name="chk12"  <?php echo ($chk12=="水腫")? "checked":""; ?>/> 水腫</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk12"  <?php echo ($chk12=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
                <td>乳暈(L)</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="柔軟" name="chk13"  <?php echo ($chk13=="柔軟")? "checked":""; ?>/> 柔軟</div>
				  <div class="even"><input type="radio"  value="微硬" name="chk13"  <?php echo ($chk13=="微硬")? "checked":""; ?>/> 微硬</div>
				  <div class="odd"><input type="radio"  value="結塊" name="chk13"  <?php echo ($chk13=="結塊")? "checked":""; ?>/> 結塊</div>
				  <div class="even"><input type="radio"  value="紅腫" name="chk13"  <?php echo ($chk13=="紅腫")? "checked":""; ?>/> 紅腫</div>
				  <div class="odd"><input type="radio"  value="水腫" name="chk13"  <?php echo ($chk13=="水腫")? "checked":""; ?>/> 水腫</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk13"  <?php echo ($chk13=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
              </tr>
			  <tr>
                <td>乳房(R)</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="柔軟" name="chk14"  <?php echo ($chk14=="柔軟")? "checked":""; ?>/> 柔軟</div>
				  <div class="even"><input type="radio"  value="微硬" name="chk14"  <?php echo ($chk14=="微硬")? "checked":""; ?>/> 微硬</div>
				  <div class="odd"><input type="radio"  value="結塊" name="chk14"  <?php echo ($chk14=="結塊")? "checked":""; ?>/> 結塊</div>
				  <div class="even"><input type="radio"  value="紅腫" name="chk14"  <?php echo ($chk14=="紅腫")? "checked":""; ?>/> 紅腫</div>
				  <div class="odd"><input type="radio"  value="水腫" name="chk14"  <?php echo ($chk14=="水腫")? "checked":""; ?>/> 水腫</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk14"  <?php echo ($chk14=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
                <td>乳房(L)</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="柔軟" name="chk15"  <?php echo ($chk15=="柔軟")? "checked":""; ?>/> 柔軟</div>
				  <div class="even"><input type="radio"  value="微硬" name="chk15"  <?php echo ($chk15=="微硬")? "checked":""; ?>/> 微硬</div>
				  <div class="odd"><input type="radio"  value="結塊" name="chk15"  <?php echo ($chk15=="結塊")? "checked":""; ?>/> 結塊</div>
				  <div class="even"><input type="radio"  value="紅腫" name="chk15"  <?php echo ($chk15=="紅腫")? "checked":""; ?>/> 紅腫</div>
				  <div class="odd"><input type="radio"  value="水腫" name="chk15"  <?php echo ($chk15=="水腫")? "checked":""; ?>/> 水腫</div>
				  <div class="even"><input type="radio"  value="結痂" name="chk15"  <?php echo ($chk15=="結痂")? "checked":""; ?>/> 結痂</div>
                </div></td>
              </tr>
			  <tr>
                <td>子宮位置</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="U-2fb" name="chk16"  <?php echo ($chk16=="U-2fb")? "checked":""; ?>/> U-2fb</div>
				  <div class="even"><input type="radio"  value="U-3fb" name="chk16"  <?php echo ($chk16=="U-3fb")? "checked":""; ?>/> U-3fb</div>
				  <div class="odd"><input type="radio"  value="U-4fb" name="chk16"  <?php echo ($chk16=="U-4fb")? "checked":""; ?>/> U-4fb</div>
				  <div class="even"><input type="radio"  value="U-5fb" name="chk16"  <?php echo ($chk16=="U-5fb")? "checked":""; ?>/> U-5fb</div>
				  <div class="odd"><input type="radio"  value="U-6fb" name="chk16"  <?php echo ($chk16=="U-6fb")? "checked":""; ?>/> U-6fb</div>
				  <div class="even"><input type="radio"  value="U-7fb" name="chk16"  <?php echo ($chk16=="U-7fb")? "checked":""; ?>/> U-7fb</div>
				  <div class="odd"><input type="radio"  value="回到骨盆腔" name="chk16"  <?php echo ($chk16=="回到骨盆腔")? "checked":""; ?>/> 回到骨盆腔</div>
                </div></td>
                <td>子宮</td>
			<?php  $c17 = explode(':', $chk17);
			  if ($c17[0] == "其他") { $chk17 = $c17[0];  $chk17_other = $c17[1]; } 
			  else { $chk17 = $c17[0];  $chk17_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="宮縮硬" name="chk17"  <?php echo ($chk17=="宮縮硬")? "checked":""; ?>/> 宮縮硬</div>
				  <div class="even"><input type="radio"  value="宮縮軟" name="chk17"  <?php echo ($chk17=="宮縮軟")? "checked":""; ?>/> 宮縮軟</div>
				  <div class="odd"><input type="radio"  value="子宮肌瘤" name="chk17"  <?php echo ($chk17=="子宮肌瘤")? "checked":""; ?>/> 子宮肌瘤</div>
				  <div class="even"><input type="radio"  value="其他" name="chk17"  <?php echo ($chk17=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk17_other" value="<?php echo $chk17_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>惡露量</td>
			<?php  $c18 = explode(':', $chk18);
			  if ($c18[0] == "其他") { $chk18 = $c18[0];  $chk18_other = $c18[1]; } 
			  else { $chk18 = $c18[0];  $chk18_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="多" name="chk18"  <?php echo ($chk18=="多")? "checked":""; ?>/> 多</div>
				  <div class="even"><input type="radio"  value="中" name="chk18"  <?php echo ($chk18=="中")? "checked":""; ?>/> 中</div>
				  <div class="odd"><input type="radio"  value="少" name="chk18"  <?php echo ($chk18=="少")? "checked":""; ?>/> 少</div>
				  <div class="even"><input type="radio"  value="無" name="chk18"  <?php echo ($chk18=="無")? "checked":""; ?>/> 無</div>
				  <div class="odd"><input type="radio"  value="其他" name="chk18"  <?php echo ($chk18=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk18_other" value="<?php echo $chk18_other; ?>" size="12" /></div>
                </div></td>
                <td>惡露顏色</td>
			<?php  $c19 = explode(':', $chk19);
			  if ($c19[0] == "其他") { $chk19 = $c19[0];  $chk19_other = $c19[1]; } 
			  else { $chk19 = $c19[0];  $chk19_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="鮮紅" name="chk19"  <?php echo ($chk19=="鮮紅")? "checked":""; ?>/> 鮮紅</div>
				  <div class="even"><input type="radio"  value="暗紅" name="chk19"  <?php echo ($chk19=="暗紅")? "checked":""; ?>/> 暗紅</div>
				  <div class="odd"><input type="radio"  value="粉紅" name="chk19"  <?php echo ($chk19=="粉紅")? "checked":""; ?>/> 粉紅</div>
				  <div class="even"><input type="radio"  value="咖啡" name="chk19"  <?php echo ($chk19=="咖啡")? "checked":""; ?>/> 咖啡</div>
				  <div class="odd"><input type="radio"  value="黃" name="chk19"  <?php echo ($chk19=="黃")? "checked":""; ?>/> 黃</div>
				  <div class="even"><input type="radio"  value="白" name="chk19"  <?php echo ($chk19=="白")? "checked":""; ?>/> 白</div>
				  <div class="odd"><input type="radio"  value="無" name="chk19"  <?php echo ($chk19=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="其他" name="chk19"  <?php echo ($chk19=="其他")? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk19_other" value="<?php echo $chk19_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>惡露性質</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無味" name="chk20"  <?php echo ($chk20=="無")? "checked":""; ?>/> 無味</div>
				  <div class="even"><input type="radio"  value="血味" name="chk20"  <?php echo ($chk20=="血味")? "checked":""; ?>/> 血味</div>
				  <div class="odd"><input type="radio"  value="泡沫狀魚腥味" name="chk20"  <?php echo ($chk20=="泡沫狀魚腥味")? "checked":""; ?>/> 泡沫狀魚腥味</div>
				  <div class="even"><input type="radio"  value="惡臭味" name="chk20"  <?php echo ($chk20=="惡臭味")? "checked":""; ?>/> 惡臭味</div>
				  <div class="odd"><input type="radio"  value="血塊" name="chk20"  <?php echo ($chk20=="血塊")? "checked":""; ?>/> 血塊</div>
                </div></td>
                <td>NSD 傷口</td>
			<?php $c21 = (!empty($chk21))? unserialize($chk21) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk21[]"  <?php echo (!empty($c21) && in_array("正常", $c21 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="發炎" name="chk21[]"  <?php echo (!empty($c21) && in_array("發炎", $c21 ))? "checked":""; ?>/> 發炎</div>
				  <div class="odd"><input type="checkbox"  value="疼痛" name="chk21[]"  <?php echo (!empty($c21) && in_array("疼痛", $c21 ))? "checked":""; ?>/> 疼痛</div>
				  <div class="even"><input type="checkbox"  value="分泌物" name="chk21[]"  <?php echo (!empty($c21) && in_array("分泌物", $c21 ))? "checked":""; ?>/> 分泌物</div>
                </div></td>
              </tr>
			  <tr>
                <td>C/S 傷口</td>
			<?php $c22 = (!empty($chk22))? unserialize($chk22) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="橫式" name="chk22[]"  <?php echo (!empty($c22) && in_array("橫式", $c22 ))? "checked":""; ?>/> 橫式</div>
				  <div class="even"><input type="checkbox"  value="直式" name="chk22[]"  <?php echo (!empty($c22) && in_array("直式", $c22 ))? "checked":""; ?>/> 直式</div>
				  <div class="odd"><input type="checkbox"  value="發炎" name="chk22[]"  <?php echo (!empty($c22) && in_array("發炎", $c22 ))? "checked":""; ?>/> 發炎</div>
				  <div class="even"><input type="checkbox"  value="疼痛" name="chk22[]"  <?php echo (!empty($c22) && in_array("疼痛", $c22 ))? "checked":""; ?>/> 疼痛</div>
				  <div class="odd"><input type="checkbox"  value="分泌物" name="chk22[]"  <?php echo (!empty($c22) && in_array("分泌物", $c22 ))? "checked":""; ?>/> 分泌物</div>
                </div></td>
				<td></td>
				<td></td>
              </tr>
          </table>
		</div>
        <div id="tab-nurse1c3">
          <table class="form list">
			  <tr>
                <td width="15%">排尿</td>
			<?php $c23 = (!empty($chk23))? unserialize($chk23) : array(); $otherchecked23 = false; $chk23_other = '';
				if (!empty($c23)) {
					foreach ($c23 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked23= true;  $chk23_other = (isset($car[1])) ? $car[1] : '' ; } 
					} 
				}?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk23[]"  <?php echo (!empty($c23) && in_array("正常", $c23 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="頻尿" name="chk23[]"  <?php echo (!empty($c23) && in_array("頻尿", $c23 ))? "checked":""; ?>/> 頻尿</div>
				  <div class="odd"><input type="checkbox"  value="尿管留置" name="chk23[]"  <?php echo (!empty($c23) && in_array("尿管留置", $c23 ))? "checked":""; ?>/> 尿管留置</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk23[]"  <?php echo ($otherchecked23)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk23_other" value="<?php echo $chk23_other; ?>" size="12" /></div>
                </div></td>
                <td width="15%">胃</td>
			<?php $c24 = (!empty($chk24))? unserialize($chk24) : array(); $otherchecked24 = false; $chk24_other = '';
				if (!empty($c24)) {
					foreach ($c24 as $cccc) {
						if (preg_match("/其他/i", $cccc)) { $car = explode(':', $cccc); $otherchecked24= true;  $chk24_other = (isset($car[1])) ? $car[1] : ''; } 
					} 
				}?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk24[]"  <?php echo (!empty($c24) && in_array("正常", $c24 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="噁心" name="chk24[]"  <?php echo (!empty($c24) && in_array("噁心", $c24 ))? "checked":""; ?>/> 噁心</div>
				  <div class="odd"><input type="checkbox"  value="嘔吐" name="chk24[]"  <?php echo (!empty($c24) && in_array("嘔吐", $c24 ))? "checked":""; ?>/> 嘔吐</div>
				  <div class="even"><input type="checkbox"  value="胃潰瘍" name="chk24[]"  <?php echo (!empty($c24) && in_array("胃潰瘍", $c24 ))? "checked":""; ?>/> 胃潰瘍</div>
				  <div class="odd"><input type="checkbox"  value="十二指腸潰瘍" name="chk24[]"  <?php echo (!empty($c24) && in_array("十二指腸潰瘍", $c24 ))? "checked":""; ?>/> 十二指腸潰瘍</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk24[]"  <?php echo ($otherchecked24)? "checked":""; ?>/> 其他&nbsp;&nbsp;<input name="chk24_other" value="<?php echo $chk24_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>腸</td>
			<?php $c25 = (!empty($chk25))? unserialize($chk25) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk25[]"  <?php echo (!empty($c25) && in_array("正常", $c25 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="腹脹" name="chk25[]"  <?php echo (!empty($c25) && in_array("腹脹", $c25 ))? "checked":""; ?>/> 腹脹</div>
				  <div class="odd"><input type="checkbox"  value="便秘" name="chk25[]"  <?php echo (!empty($c25) && in_array("便秘", $c25 ))? "checked":""; ?>/> 便秘</div>
				  <div class="even"><input type="checkbox"  value="腹瀉" name="chk25[]"  <?php echo (!empty($c25) && in_array("腹瀉", $c25 ))? "checked":""; ?>/> 腹瀉</div>
                </div></td>
                <td>痔瘡</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk26"  <?php echo ($chk26=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk26"  <?php echo ($chk26=="有")? "checked":""; ?>/> 有</div>
				  <div class="odd"><input type="radio"  value="使用 Xylmott supp" name="chk26"  <?php echo ($chk26=="使用 Xylmott supp")? "checked":""; ?>/> 使用 Xylmott supp</div>
                </div></td>
              </tr>
			  <tr>
                <td>開刀史</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk27"  <?php echo ($chk27=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk27"  <?php echo ($chk27=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>重大疾病</td>
			<?php  $c28 = explode(':', $chk28);
			  if ($c28[0] == "有") { $chk28 = $c28[0];  $chk28_other = $c28[1]; } 
			  else { $chk28 = $c28[0];  $chk28_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk28"  <?php echo ($chk28=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk28"  <?php echo ($chk28=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<input name="chk28_other" value="<?php echo $chk28_other; ?>" size="12" /></div>
                </div></td>
              </tr>
			  <tr>
                <td>服生化湯</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk29"  <?php echo ($chk29=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk29"  <?php echo ($chk29=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>定期服用藥物</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk30"  <?php echo ($chk30=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk30"  <?php echo ($chk30=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td>服用子宮收縮劑</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk31"  <?php echo ($chk31=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk31"  <?php echo ($chk31=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>家人一星期內有人感冒</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="無" name="chk32"  <?php echo ($chk32=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk32"  <?php echo ($chk32=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
          </table>
		</div>
	  </form>
        <div id="tab-datatable">
		<?php if (!empty($dtab)) { ?>
		<?php 	foreach ($dtab as $db) { ?>
			<table class="form list">
				<tbody>
					<tr><td width="33%">產婦姓名：<?php echo $db['customer_name']; ?></td><td width="33%">嬰兒姓名：<?php echo $db['name']; ?></td><td width="33%">父親姓名：<?php echo $db['spouse_name']; ?></td></tr>
					<tr><td width="33%">房號：<?php echo $db['customer_firstroom']; ?></td>
					<td colspan="2" width="66%">
					<?php foreach ($db['customer_transfers'] as $transfer) { ?>
						轉床紀錄：<?php echo $transfer['date_added']; ?>&nbsp;轉為：<?php echo $transfer['customer_room_name']; ?><br />
					<?php } ?>
					</td></tr>
					<tr><td width="33%">嬰兒出生日期：<?php echo $db['birthdate']; ?></td><td width="33%">產婦入住日期：<?php echo $db['date_added']; ?></td><td width="33%">預定退住日期：<?php echo $db['date_leave']; ?></td></tr>
					<tr><td width="33%">生產方式：<?php echo $db['childbirth_method']; ?></td><td width="66%" colspan="2">生產醫院：<?php echo $db['childbirth_hospital']; ?></td></tr>
					<tr><td width="33%">週數：<?php echo $db['pregnancy_weeks']; ?>週<br />胎兒產胎次：G:<?php echo $db['child_count_g']; ?>&nbsp;&nbsp;P:<?php echo $db['child_count_p']; ?></td><td width="66%" colspan="2">生產醫師：<?php echo $db['childbirth_doctor']; ?><br />Apgar：<?php echo $db['apgar_score_1']; ?> (1min) --> <?php echo $db['apgar_score_5'];?> (5min)</</td></tr>
					<tr><td colspan="3">嬰兒出生時體重：<?php echo $db['birthweight']; ?> 公克 &nbsp;頭圍：<?php echo $db['birthhead']; ?> 公分 &nbsp;身長：<?php echo $db['birthlength']; ?> 公分，入住時體重：<?php echo $db['inweight']; ?> 公克</td></tr>
					<tr><td colspan="3">乙型鏈球菌檢查：<?php echo $db['b_streptococcus_check']; ?></td></tr>
				</tdoby>
			</table><br />
		<?php 	} ?> 
		<?php } ?>
        </div>
      
    </div>
	<div class="footing">
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<script type="text/javascript"><!--	
	if ($('input[name=chk5]:checked').val() == '其他') {
		$('input[name=chk5_other]').show();
	} else {
		$('input[name=chk5_other]').hide();
	}
	$('input[name=chk5]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk5_other]').show();
		} else {
			$('input[name=chk5_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk17]:checked').val() == '其他') {
		$('input[name=chk17_other]').show();
	} else {
		$('input[name=chk17_other]').hide();
	}
	$('input[name=chk17]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk17_other]').show();
		} else {
			$('input[name=chk17_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk18]:checked').val() == '其他') {
		$('input[name=chk18_other]').show();
	} else {
		$('input[name=chk18_other]').hide();
	}
	$('input[name=chk18]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk18_other]').show();
		} else {
			$('input[name=chk18_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk19]:checked').val() == '其他') {
		$('input[name=chk19_other]').show();
	} else {
		$('input[name=chk19_other]').hide();
	}
	$('input[name=chk19]').click(function(){
		v = $(this).val();
		if (v == '其他') {
			$('input[name=chk19_other]').show();
		} else {
			$('input[name=chk19_other]').hide();
		}
	});	

	//-------------------------//
	if ($('input[name=chk28]:checked').val() == '有') {
		$('input[name=chk28_other]').show();
	} else {
		$('input[name=chk28_other]').hide();
	}
	$('input[name=chk28]').click(function(){
		v = $(this).val();
		if (v == '有') {
			$('input[name=chk28_other]').show();
		} else {
			$('input[name=chk28_other]').hide();
		}
	});	

	//-------------------------//

<?php for ($i = 6; $i <= 9 ;$i++) { ?>
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	});	
	//-------------------------//
<?php } ?>
<?php for ($i = 23; $i <= 24 ;$i++) { ?>
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('input[name=chk<?php echo $i; ?>_other]').show();
			} else {
				$('input[name=chk<?php echo $i; ?>_other]').hide();
			}
	});	
	//-------------------------//
<?php } ?>
//--></script>
<?php echo $footer; ?>