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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?>－<?php echo $child_name.'('.$customer_name.'的寶寶)';?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-nurse1b"><?php echo $tab_nurse1b; ?></a><a href="#tab-nurse1b2"><?php echo $tab_nurse1b."[二]"; ?></a><a href="#tab-nurse1b3"><?php echo $tab_nurse1b."[三]"; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse1b">
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
                <td>嬰兒入時胸圍</td>
                <td><input type="text" name="chk1" value="<?php echo $chk1; ?>" size="12" /> 公分</td>
                <td>體溫</td>
                <td><input type="text" name="chk2" value="<?php echo $chk2; ?>" size="12" /> ℃</td>
              </tr>
			  <tr>
                <td>脈搏</td>
                <td><input type="text" name="chk3" value="<?php echo $chk3; ?>" size="12" /> 次/分鐘</td>
                <td>呼吸</td>
                <td><input type="text" name="chk4" value="<?php echo $chk4; ?>" size="12" /> 次/分鐘</td>
              </tr>
			  <tr>
                <td>含氧濃度</td>
                <td><input type="text" name="chk5" value="<?php echo $chk5; ?>" size="12" /> %</td>
                <td>黃疸數值</td>
                <td><input type="text" name="chk6" value="<?php echo $chk6; ?>" size="12" /> mg/dL</td>
              </tr>
			  <tr>
                <td>已預防注射</td>
			<?php $c7 = (!empty($chk7))? unserialize($chk7) : array(); ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="卡介苗" name="chk7[]"  <?php echo (!empty($c7) && in_array("卡介苗", $c7 ))? "checked":""; ?>/> 卡介苗</div>
				  <div class="even"><input type="checkbox"  value="B 型肝炎疫苗第一劑" name="chk7[]"  <?php echo (!empty($c7) && in_array("B 型肝炎疫苗第一劑", $c7 ))? "checked":""; ?>/> B 型肝炎疫苗第一劑</div>
				  <div class="odd"><input type="checkbox"  value="B 型肝炎免疫球蛋白" name="chk7[]"  <?php echo (!empty($c7) && in_array("B 型肝炎免疫球蛋白", $c7 ))? "checked":""; ?>/> B 型肝炎免疫球蛋白</div>
                </div></td>
                <td>腦部超音波檢查</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk8"  <?php echo ($chk8=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk8"  <?php echo ($chk8=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
                <td>心臟超音波</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk9"  <?php echo ($chk9=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk9"  <?php echo ($chk9=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
                <td>腎臟超音波</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk10"  <?php echo ($chk10=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk10"  <?php echo ($chk10=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			  </tr>
			  <tr>
				<td>新生兒篩檢</td>
			<?php  $c11 = explode(':', $chk11);
			  if ($c11[0] == "未做" AND isset($c11[1])) { $chk11 = $c11[0];  $chk11_other = $c11[1]; } 
			  else { $chk11 = $c11[0];  $chk11_other = ''; } ?>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="已做" name="chk11"  <?php echo ($chk11=="已做")? "checked":""; ?>/> 已做</div>
				  <div class="even"><input type="radio"  value="未做" name="chk11"  <?php echo ($chk11=="未做")? "checked":""; ?>/> 未做&nbsp;&nbsp;<span id="chk11other">預定日期為 <span id="chk11other"><input name="chk11_other" value="<?php echo $chk11_other; ?>" size="12" class="date" /></span></div>
                </div></td>
                <td>飲食習慣</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="混合奶" name="chk12"  <?php echo ($chk12=="混合奶")? "checked":""; ?>/> 混合奶</div>
				  <div class="even"><input type="radio"  value="全母奶" name="chk12"  <?php echo ($chk12=="全母奶")? "checked":""; ?>/> 全母奶</div>
				  <div class="odd"><input type="radio"  value="配方奶" name="chk12"  <?php echo ($chk12=="配方奶")? "checked":""; ?>/> 配方奶</div>
                </div></td>
			  </tr>
			  <tr>
				<td>姿勢行為</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk13"  <?php echo ($chk13=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk13"  <?php echo ($chk13=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
                <td>手足發紺</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk14"  <?php echo ($chk14=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk14"  <?php echo ($chk14=="有")? "checked":""; ?>/> 有</div>
                </div></td>
			  </tr>
			  <tr>
				<td>嘴唇發紺</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk15"  <?php echo ($chk15=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk15"  <?php echo ($chk15=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>大理石皮膚</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk16"  <?php echo ($chk16=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk16"  <?php echo ($chk16=="無")? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
                <td width="15%">生理性黃疸</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk17"  <?php echo ($chk17=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk17"  <?php echo ($chk17=="無")? "checked":""; ?>/> 無</div>
                </div></td>
                <td width="15%">瘀斑或瘀點</td>
			<?php $c18 = (!empty($chk18))? unserialize($chk18) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk18[]"  <?php echo (!empty($c18) && in_array("無", $c18 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk18[]"  <?php echo (!empty($c18) && in_array("有", $c18 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk18other">部位：<input type="checkbox"  value="臉" name="chk18[]"  <?php echo (!empty($c18) && in_array("臉", $c18 ))? "checked":""; ?>/> 臉 <input type="checkbox"  value="前胸" name="chk18[]"  <?php echo (!empty($c18) && in_array("前胸", $c18 ))? "checked":""; ?>/> 前胸 <input type="checkbox"  value="後背" name="chk18[]"  <?php echo (!empty($c18) && in_array("後背", $c18 ))? "checked":""; ?>/> 後背 <input type="checkbox"  value="上肢" name="chk18[]"  <?php echo (!empty($c18) && in_array("上肢", $c18 ))? "checked":""; ?>/> 上肢 <input type="checkbox"  value="下肢" name="chk18[]"  <?php echo (!empty($c18) && in_array("下肢", $c18 ))? "checked":""; ?>/> 下肢</span></div>
                </div></td>
              </tr>
			  <tr>
                <td width="15%">蒙古斑</td>
			<?php $c19 = (!empty($chk19))? unserialize($chk19) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk19[]"  <?php echo (!empty($c19) && in_array("無", $c19 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk19[]"  <?php echo (!empty($c19) && in_array("有", $c19 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk19other">部位：<input type="checkbox"  value="臉" name="chk19[]"  <?php echo (!empty($c19) && in_array("臉", $c19 ))? "checked":""; ?>/> 臉 <input type="checkbox"  value="前胸" name="chk19[]"  <?php echo (!empty($c19) && in_array("前胸", $c19 ))? "checked":""; ?>/> 前胸 <input type="checkbox"  value="後背" name="chk19[]"  <?php echo (!empty($c19) && in_array("後背", $c19 ))? "checked":""; ?>/> 後背 <input type="checkbox"  value="上肢" name="chk19[]"  <?php echo (!empty($c19) && in_array("上肢", $c19 ))? "checked":""; ?>/> 上肢 <input type="checkbox"  value="下肢" name="chk19[]"  <?php echo (!empty($c19) && in_array("下肢", $c19 ))? "checked":""; ?>/> 下肢</span></div>
                </div></td>
                <td width="15%">粟粒疹</td>
			<?php $c20 = (!empty($chk20))? unserialize($chk20) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk20[]"  <?php echo (!empty($c20) && in_array("無", $c20 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk20[]"  <?php echo (!empty($c20) && in_array("有", $c20 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk20other">部位：<input type="checkbox"  value="鼻頭" name="chk20[]"  <?php echo (!empty($c20) && in_array("鼻頭", $c20 ))? "checked":""; ?>/> 鼻頭 <input type="checkbox"  value="其他" name="chk20[]"  <?php echo (!empty($c20) && in_array("其他", $c20 ))? "checked":""; ?>/> 其他</span></div>
                </div></td>
              </tr>
			  <tr>
                <td width="15%">微血管瘤</td>
			<?php $c21 = (!empty($chk21))? unserialize($chk21) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk21[]"  <?php echo (!empty($c21) && in_array("無", $c21 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk21[]"  <?php echo (!empty($c21) && in_array("有", $c21 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk21other">部位：<input type="checkbox"  value="臉" name="chk21[]"  <?php echo (!empty($c21) && in_array("臉", $c21 ))? "checked":""; ?>/> 臉 <input type="checkbox"  value="前胸" name="chk21[]"  <?php echo (!empty($c21) && in_array("前胸", $c21 ))? "checked":""; ?>/> 前胸 <input type="checkbox"  value="後背" name="chk21[]"  <?php echo (!empty($c21) && in_array("後背", $c21 ))? "checked":""; ?>/> 後背 <input type="checkbox"  value="上肢" name="chk21[]"  <?php echo (!empty($c21) && in_array("上肢", $c21 ))? "checked":""; ?>/> 上肢 <input type="checkbox"  value="下肢" name="chk21[]"  <?php echo (!empty($c21) && in_array("下肢", $c21 ))? "checked":""; ?>/> 下肢</span></div>
                </div></td>
                <td width="15%">毒性紅斑</td>
			<?php $c22 = (!empty($chk22))? unserialize($chk22) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk22[]"  <?php echo (!empty($c22) && in_array("無", $c22 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk22[]"  <?php echo (!empty($c22) && in_array("有", $c22 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk22other">部位：<input type="checkbox"  value="臉" name="chk22[]"  <?php echo (!empty($c22) && in_array("臉", $c22 ))? "checked":""; ?>/> 臉 <input type="checkbox"  value="前胸" name="chk22[]"  <?php echo (!empty($c22) && in_array("前胸", $c22 ))? "checked":""; ?>/> 前胸 <input type="checkbox"  value="後背" name="chk22[]"  <?php echo (!empty($c22) && in_array("後背", $c22 ))? "checked":""; ?>/> 後背 <input type="checkbox"  value="上肢" name="chk22[]"  <?php echo (!empty($c22) && in_array("上肢", $c22 ))? "checked":""; ?>/> 上肢 <input type="checkbox"  value="下肢" name="chk22[]"  <?php echo (!empty($c22) && in_array("下肢", $c22 ))? "checked":""; ?>/> 下肢</span></div>
                </div></td>
              </tr>
			  <tr>
				<td>前囟門</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk23"  <?php echo ($chk23=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk23"  <?php echo ($chk23=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
				<td>後囟門</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk24"  <?php echo ($chk24=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk24"  <?php echo ($chk24=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
          </table>
		</div>
        <div id="tab-nurse1b2">
          <table class="form list">
			  <tr>
				<td>頭骨重疊現象</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk25"  <?php echo ($chk25=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk25"  <?php echo ($chk25=="有")? "checked":""; ?>/> 有</div>
                </div></td>
                <td>產瘤</td>
			<?php  $c26 = explode(':', $chk26);
			  if ($c26[0] == "有" AND isset($c26[1])) { $chk26 = $c26[0];  $chk26_other = $c26[1]; } 
			  else { $chk26 = $c26[0];  $chk26_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk26"  <?php echo ($chk26=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk26"  <?php echo ($chk26=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk26other">大小 <input name="chk26_other" value="<?php echo $chk26_other; ?>" size="12" /> 公分</span></div>
                </div></td>
              </tr>
			  <tr>
                <td>頭皮血腫</td>
			<?php  $c27 = explode(':', $chk27);
			  if ($c27[0] == "有" AND isset($c27[1])) { $chk27 = $c27[0];  $chk27_other = $c27[1]; } 
			  else { $chk27 = $c27[0];  $chk27_other = ''; } ?>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk27"  <?php echo ($chk27=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk27"  <?php echo ($chk27=="有")? "checked":""; ?>/> 有&nbsp;&nbsp;<span id="chk27other">大小 <input name="chk27_other" value="<?php echo $chk27_other; ?>" size="12" /> 公分</span></div>
                </div></td>
				<td>結膜出血</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk28"  <?php echo ($chk28=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk28"  <?php echo ($chk28=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
				<td>眼睛分泌物</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk29"  <?php echo ($chk29=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk29"  <?php echo ($chk29=="有")? "checked":""; ?>/> 有</div>
                </div></td>
				<td>兩耳形狀對稱</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk30"  <?php echo ($chk30=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk30"  <?php echo ($chk30=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
				<td>耳頂比眼角高</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk31"  <?php echo ($chk31=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk31"  <?php echo ($chk31=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
				<td>鼻翼扇動</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk32"  <?php echo ($chk32=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk32"  <?php echo ($chk32=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
				<td>魔牙</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk33"  <?php echo ($chk33=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk33"  <?php echo ($chk33=="有")? "checked":""; ?>/> 有</div>
                </div></td>
				<td>鵝口瘡</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk34"  <?php echo ($chk34=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk34"  <?php echo ($chk34=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
				<td>斜頸</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk35"  <?php echo ($chk35=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk35"  <?php echo ($chk35=="有")? "checked":""; ?>/> 有</div>
                </div></td>
				<td>鎖骨骨折</td>
				<td><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk36"  <?php echo ($chk36=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk36"  <?php echo ($chk36=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
                <td width="15%">胸鎖乳頭肌腫塊</td>
			<?php $c37 = (!empty($chk37))? unserialize($chk37) : array(); $otherchecked37 = false; $chk37_other = '';
				if (!empty($c37)) {
					foreach ($c37 as $cccc) {
						if (preg_match("/大小/i", $cccc)) { $car = explode(':', $cccc); $otherchecked37= true;  $chk37_other = (isset($car[1])) ? $car[1] : '' ; } 
					} 
				}?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk37[]"  <?php echo (!empty($c37) && in_array("無", $c37 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk37[]"  <?php echo (!empty($c37) && in_array("有", $c37 ))? "checked":""; ?>/> 有 &nbsp;&nbsp;<span id="chk37other"><input type="checkbox"  value="左側" name="chk37[]"  <?php echo (!empty($c37) && in_array("左側", $c37 ))? "checked":""; ?>/>左側 <input type="checkbox"  value="右側" name="chk37[]"  <?php echo (!empty($c37) && in_array("右側", $c37 ))? "checked":""; ?>/>右側 <input type="checkbox"  id="chk37size" value="大小" name="chk37[]"  <?php echo ($otherchecked37)? "checked":""; ?>/>大小<input name="chk37_other" value="<?php echo $chk37_other; ?>" size="12" />公分</span></div>
                </div></td>
                <td width="15%">魔乳</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk38"  <?php echo ($chk38=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk38"  <?php echo ($chk38=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">雞胸</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk39"  <?php echo ($chk39=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk39"  <?php echo ($chk39=="有")? "checked":""; ?>/> 有</div>
                </div></td>
			    <td width="15%">漏斗胸</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk40"  <?php echo ($chk40=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk40"  <?php echo ($chk40=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">呼吸音</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk41"  <?php echo ($chk41=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk41"  <?php echo ($chk41=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			    <td width="15%">腹脹</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk42"  <?php echo ($chk42=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk42"  <?php echo ($chk42=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">腸蠕動</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk43"  <?php echo ($chk43=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk43"  <?php echo ($chk43=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			    <td width="15%">臍帶分泌物</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk44"  <?php echo ($chk51=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk44"  <?php echo ($chk51=="無")? "checked":""; ?>/> 無</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">臍疝氣</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk45"  <?php echo ($chk45=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk45"  <?php echo ($chk45=="有")? "checked":""; ?>/> 有</div>
                </div></td>
			    <td width="15%">腹股溝疝氣</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk46"  <?php echo ($chk46=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk46"  <?php echo ($chk46=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
          </table>
		</div>
        <div id="tab-nurse1b3">
          <table class="form list">
			  <tr>
                <td width="15%">陰囊水腫</td>
			<?php $c47 = (!empty($chk47))? unserialize($chk47) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk47[]"  <?php echo (!empty($c47) && in_array("無", $c47 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk47[]"  <?php echo (!empty($c47) && in_array("有", $c47 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk47other"><input type="checkbox"  value="左側" name="chk47[]"  <?php echo (!empty($c47) && in_array("左側", $c47 ))? "checked":""; ?>/> 左側 <input type="checkbox"  value="右側" name="chk47[]"  <?php echo (!empty($c47) && in_array("右側", $c47 ))? "checked":""; ?>/> 右側</span></div>
                </div></td>
                <td width="15%">隱睪症</td>
			<?php $c48 = (!empty($chk48))? unserialize($chk48) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="無" name="chk48[]"  <?php echo (!empty($c48) && in_array("無", $c48 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="有" name="chk48[]"  <?php echo (!empty($c48) && in_array("有", $c48 ))? "checked":""; ?>/> 有
				  &nbsp;&nbsp;<span id="chk48other"><input type="checkbox"  value="左側" name="chk48[]"  <?php echo (!empty($c48) && in_array("左側", $c48 ))? "checked":""; ?>/> 左側 <input type="checkbox"  value="右側" name="chk48[]"  <?php echo (!empty($c48) && in_array("右側", $c48 ))? "checked":""; ?>/> 右側</span></div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">包皮發炎</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk49"  <?php echo ($chk52=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk49"  <?php echo ($chk52=="有")? "checked":""; ?>/> 有</div>
                </div></td>
			    <td width="15%">大小陰唇對稱</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk50"  <?php echo ($chk50=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk50"  <?php echo ($chk50=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">大陰唇水腫</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk51"  <?php echo ($chk51=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk51"  <?php echo ($chk51=="無")? "checked":""; ?>/> 無</div>
                </div></td>
			    <td width="15%">假性月經</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk52"  <?php echo ($chk52=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk52"  <?php echo ($chk52=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">肛門口紅腫</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk53"  <?php echo ($chk53=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk53"  <?php echo ($chk53=="無")? "checked":""; ?>/> 無</div>
                </div></td>
			    <td width="15%">脊椎外觀</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk54"  <?php echo ($chk54=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk54"  <?php echo ($chk54=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">臀部肌肉對稱</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk55"  <?php echo ($chk55=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk55"  <?php echo ($chk55=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			    <td width="15%">手指腳趾數目</td>
			<?php $c56 = (!empty($chk56))? unserialize($chk56) : array(); ?>
				<td width="35%"><div class="scrollbox">
                  <div class="odd"><input type="checkbox"  value="正確" name="chk56[]"  <?php echo (!empty($c56) && in_array("正確", $c56 ))? "checked":""; ?>/> 正確</div>
				  <div class="even"><input type="checkbox"  value="不正確" name="chk56[]"  <?php echo (!empty($c56) && in_array("不正確", $c56 ))? "checked":""; ?>/> 不正確
				  &nbsp;&nbsp;<span id="chk56other"><input type="checkbox"  value="左手" name="chk56[]"  <?php echo (!empty($c56) && in_array("左手", $c56 ))? "checked":""; ?>/> 左手 <input type="checkbox"  value="左腳" name="chk56[]"  <?php echo (!empty($c56) && in_array("左腳", $c56 ))? "checked":""; ?>/> 左腳 <input type="checkbox"  value="右手" name="chk56[]"  <?php echo (!empty($c56) && in_array("右手", $c56 ))? "checked":""; ?>/> 右手 <input type="checkbox"  value="右腳" name="chk56[]"  <?php echo (!empty($c56) && in_array("右腳", $c56 ))? "checked":""; ?>/> 右腳</span></div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">長度對稱</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk57"  <?php echo ($chk57=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk57"  <?php echo ($chk57=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			    <td width="15%">斷掌</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk58"  <?php echo ($chk58=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk58"  <?php echo ($chk58=="有")? "checked":""; ?>/> 有</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">臂神經受損</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="無" name="chk59"  <?php echo ($chk59=="無")? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="radio"  value="有" name="chk59"  <?php echo ($chk59=="有")? "checked":""; ?>/> 有</div>
                </div></td>
			    <td width="15%">關節活動正常</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk60"  <?php echo ($chk60=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk60"  <?php echo ($chk60=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">肌肉張力</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="正常" name="chk61"  <?php echo ($chk61=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="不正常" name="chk61"  <?php echo ($chk61=="不正常")? "checked":""; ?>/> 不正常</div>
                </div></td>
			    <td width="15%">尋乳反射</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk62"  <?php echo ($chk62=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk62"  <?php echo ($chk62=="無")? "checked":""; ?>/> 無</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">吸吮反射</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk63"  <?php echo ($chk63=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk63"  <?php echo ($chk63=="無")? "checked":""; ?>/> 無</div>
                </div></td>
			    <td width="15%">抓握反射</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk64"  <?php echo ($chk64=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk64"  <?php echo ($chk64=="無")? "checked":""; ?>/> 無</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">巴賓斯基反射</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk65"  <?php echo ($chk65=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk65"  <?php echo ($chk65=="無")? "checked":""; ?>/> 無</div>
                </div></td>
			    <td width="15%">驚嚇反射</td>
				<td width="35%"><div class="scrollbox">
				  <div class="odd"><input type="radio"  value="有" name="chk66"  <?php echo ($chk66=="有")? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="radio"  value="無" name="chk66"  <?php echo ($chk66=="無")? "checked":""; ?>/> 無</div>
                </div></td>
              </tr>
			  <tr>
			    <td width="15%">備註</td>
				<td width="35%"><textarea name="chk67" cols="65" rows="10"><?php echo $chk67; ?></textarea></td>
			    <td width="15%"></td>
				<td width="35%"></td>
              </tr>
          </table>
		</div>
	  </form>
        <div id="tab-datatable">
			<table class="form list">
				<tbody>
					<tr><td width="33%">產婦姓名：<?php echo $customer_name; ?></td><td width="33%">嬰兒姓名：<?php echo $name; ?></td><td width="33%">父親姓名：<?php echo $spouse_name; ?></td></tr>
					<tr><td width="33%">房號：<?php echo $customer_firstroom; ?></td>
					<td colspan="2" width="66%">
					<?php foreach ($customer_transfers as $transfer) { ?>
						轉床紀錄：<?php echo $transfer['date_added']; ?>&nbsp;轉為：<?php echo $transfer['customer_room_name']; ?><br />
					<?php } ?>
					</td></tr>
					<tr><td width="33%">嬰兒出生日期：<?php echo $birthdate; ?></td><td width="33%">產婦入住日期：<?php echo $date_added; ?></td><td width="33%">預定退住日期：<?php echo $date_leave; ?></td></tr>
					<tr><td width="33%">生產方式：<?php echo $childbirth_method; ?></td><td width="66%" colspan="2">生產醫院：<?php echo $childbirth_hospital; ?></td></tr>
					<tr><td width="33%">週數：<?php echo $pregnancy_weeks; ?>週<br />胎兒產胎次：G:<?php echo $child_count_g; ?>&nbsp;&nbsp;P:<?php echo $child_count_p; ?></td><td width="66%" colspan="2">生產醫師：<?php echo $childbirth_doctor; ?><br />Apgar：<?php echo $apgar_score_1; ?> (1min) --> <?php echo $apgar_score_5;?> (5min)</</td></tr>
					<tr><td colspan="3">嬰兒出生時體重：<?php echo $birthweight; ?> 公克 &nbsp;頭圍：<?php echo $birthhead; ?> 公分 &nbsp;身長：<?php echo $birthlength; ?> 公分，入住時體重：<?php echo $inweight; ?> 公克</td></tr>
					<tr><td colspan="3">乙型鏈球菌檢查：<?php echo $b_streptococcus_check; ?></td></tr>
				</tdoby>
			</table>
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
	if ($('input[name=chk11]:checked').val() == '未做') {
		$('span#chk11other').show();
	} else {
		$('span#chk11other').hide();
	}
	$('input[name=chk11]').click(function(){
		v = $(this).val();
		
		if (v == '未做') {
			$('span#chk11other').show();
		} else {
			$('span#chk11other').hide();
		}
	});
<?php for ($i = 26; $i <= 27 ;$i++) { ?>
	if ($('input[name=chk<?php echo $i; ?>]:checked').val() == '有') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name=chk<?php echo $i; ?>]').click(function(){
		v = $(this).val();
		
		if (v == '有') {
			$('span#chk<?php echo $i; ?>other').show();
		} else {
			$('span#chk<?php echo $i; ?>other').hide();
		}
	});	
	//-------------------------//
<?php } ?>

<?php for ($i = 18; $i <= 22 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('有',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('有',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 37; $i <= 37 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('有',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('有',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 47; $i <= 48 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('有',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('有',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 56; $i <= 56 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('不正確',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').click(function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('不正確',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$('.date').datepicker({
	changeMonth: true,
	changeYear: true,
	minDate: "-0D",
	dateFormat: 'yy-mm-dd'
});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 
<?php echo $footer; ?>