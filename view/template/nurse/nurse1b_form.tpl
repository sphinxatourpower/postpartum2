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
      <div id="tabs" class="htabs"><a href="#tab-nurse1b"><?php echo $tab_nurse1b; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse1b">
		<h3>一、基本資料</h3>
          <table class="form list">
			  <tr>
                <td class="center caption" width="120px">評估人員</td>
                <td><select name="nurse_id">
                    <?php foreach ($nurses as $nurse) { ?>
                    <?php if ($nurse['user_id'] == $nurse_id) { ?>
                    <option value="<?php echo $nurse['user_id']; ?>" selected="selected"><?php echo $nurse['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $nurse['user_id']; ?>"><?php echo $nurse['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
		      </tr>
			  <tr>
                <td class="center caption">生產合併症</td>
				<?php $f1 = (!empty($field1))? unserialize($field1) : array(); $field1_other_ck = false; $field1_other = '';
				if (!empty($f1)) {
					foreach ($f1 as $string) {
						if (preg_match("/其他/i", $string)) { 
							$car3 = explode(':', $string); $field1_other_ck= true;  $field1_other = (isset($car3[1])) ? $car3[1] : '';
						} 
					} 
				}?>
                <td><div class="mybox">
                  <div class="odd"> <input type="checkbox" name="field1[]" value="無" <?php echo (!empty($f1) && in_array("無", $f1 ))? "checked":""; ?> /> 無</div>
				  <div class="even"><input type="checkbox" name="field1[]" value="胎心音異常" <?php echo (!empty($f1) && in_array("胎心音異常", $f1 ))? "checked":""; ?> /> 胎心音異常</div>
				  <div class="odd"> <input type="checkbox" name="field1[]" value="臍帶脫垂" <?php echo (!empty($f1) && in_array("臍帶脫垂", $f1 ))? "checked":""; ?> /> 臍帶脫垂</div>
				  <div class="even"><input type="checkbox" name="field1[]" value="臍繞頸" <?php echo (!empty($f1) && in_array("臍繞頸", $f1 ))? "checked":""; ?> /> 臍繞頸</div>
				  <div class="odd"><input type="checkbox" name="field1[]" value="胎便染色" <?php echo (!empty($f1) && in_array("胎便染色", $f1 ))? "checked":""; ?> /> 胎便染色</div>
				  <div class="even"> <input type="checkbox" name="field1[]" value="其他" <?php echo ($field1_other_ck)? "checked":""; ?> /> 其他</div><span id="field1other"><input name="field1_other" value="<?php echo $field1_other; ?>" size="12" /></span>
                </div></td>
              </tr>
			  <tr>
                <td class="center caption">出生後併發症</td>
				<?php $f2 = (!empty($field2))? unserialize($field2) : array(); $field2_other_ck = false; $field2_other = '';
				if (!empty($f2)) {
					foreach ($f as $string) {
						if (preg_match("/感染/i", $string)) { 
							$car3 = explode(':', $string); $field2_other_ck= true;  $field2_other = (isset($car3[1])) ? $car3[1] : '';
						} 
					} 
				}?>
                <td><div class="mybox">
                  <div class="odd"> <input type="checkbox" name="field2[]" value="MAS" <?php echo (!empty($f2) && in_array("MAS", $f2 ))? "checked":""; ?> /> MAS</div>
				  <div class="even"><input type="checkbox" name="field2[]" value="TTNB" <?php echo (!empty($f2) && in_array("TTNB", $f2 ))? "checked":""; ?> /> TTNB</div>
				  <div class="odd"> <input type="checkbox" name="field2[]" value="臍帶脫垂" <?php echo (!empty($f2) && in_array("臍帶脫垂", $f2 ))? "checked":""; ?> /> 臍帶脫垂</div>
				  <div class="even"><input type="checkbox" name="field2[]" value="Hyperbilirubinemia" <?php echo (!empty($f2) && in_array("Hyperbilirubinemia", $f2 ))? "checked":""; ?> /> Hyperbilirubinemia</div>
				  <div class="odd"> <input type="checkbox" name="field2[]" value="感染" <?php echo ($field2_other_ck)? "checked":""; ?> /> 感染</div><span id="field2other"><input name="field2_other" value="<?php echo $field2_other; ?>" size="12" /></span>
                </div></td>
              </tr>
			  <tr>
                <td class="center caption">疫苗注射</td>
				<?php $f3 = (is_serialized($field3))? unserialize($field3) : array(); ?>
                <td><div class="mybox">
                  <div class="odd"> <input type="checkbox" name="field3[]" value="HBIG" <?php echo (!empty($f3) && in_array("HBIG", $f3 ))? "checked":""; ?> /> HBIG</div>
				  <div class="even"><input type="checkbox" name="field3[]" value="BCG" <?php echo (!empty($f3) && in_array("BCG", $f3 ))? "checked":""; ?> /> BCG</div>
                </div></td>
              </tr>
			  <tr>
                <td class="center caption">血糖</td>
                <td><input type="text" name="field4" value="<?php echo $field4; ?>" size="12" /> mg/dL （只有前3天要測，1次／天）</td>
              </tr>
			  
		  </table>

		  <h3>二、身體評估</h3>
		  <table class="form list">
			   <tr>
                <td class="center caption" width="120px">生命徵象</td>
                <td colspan="2">
				T：<input type="text" name="chk2" value="<?php echo $chk2; ?>" size="12" />
				P：<input type="text" name="chk3" value="<?php echo $chk3; ?>" size="12" />
				R：<input type="text" name="chk4" value="<?php echo $chk4; ?>" size="12" />
				體重：<input type="text" name="inweight" value="<?php echo $inweight; ?>" size="12" />
				頭圍：<input type="text" name="inhead" value="<?php echo $inhead; ?>" size="12" />
				胸圍：<input type="text" name="inchest" value="<?php echo $inchest; ?>" size="12" />
				身長：<input type="text" name="inlength" value="<?php echo $inlength; ?>" size="12" /></td>
              </tr>
			  <tr>
                <td class="center caption">入住黃疸數值</td>
                <td colspan="2"><input type="text" name="chk6" value="<?php echo $chk6; ?>" size="12" /> mg/dL</td>
              </tr>
			  <tr>
				<td class="center caption">外觀活動力</td>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="radio"  value="良好" name="chk12" <?php echo ($chk12=="良好")? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="radio"  value="可" name="chk12" <?php echo ($chk12=="可")? "checked":""; ?>/> 可</div>
				  <div class="odd"><input type="radio"  value="欠佳" name="chk12" <?php echo ($chk12=="欠佳")? "checked":""; ?>/> 欠佳</div>
                </div></td>
			  </tr>
			  <tr>
                <td class="center caption">哭聲</td>
			<?php $c61 = (is_serialized($chk61))? unserialize($chk61) : array(); ?>
				<td colspan="2"><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="強有力" name="chk61[]" <?php echo (!empty($c61) && in_array("強有力", $c61 ))? "checked":""; ?>/> 強有力</div>
				  <div class="even"><input type="checkbox"  value="中等" name="chk61[]" <?php echo (!empty($c61) && in_array("中等", $c61 ))? "checked":""; ?>/> 中等</div>
				  <div class="odd"><input type="checkbox"  value="微弱" name="chk61[]" <?php echo (!empty($c61) && in_array("微弱", $c61 ))? "checked":""; ?>/> 微弱</div>
				  
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="2">皮膚</td>
                <td class="center" width="240px">膚色：</td>
				<?php $c17 = (!empty($chk17)&&is_serialized($chk17))? unserialize($chk17) : array(); $chk17_other_ck = false; $chk17_other = '';
					if (!empty($c17)) {
						foreach ($c17 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car17 = explode(':', $string); $chk17_other_ck= true;  $chk17_other = (isset($car17[1])) ? $car17[1] : '';
							} 
						} 
					} ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="全身紅潤" name="chk17[]"  <?php echo (!empty($c17) && in_array("全身紅潤", $c17 ))? "checked":""; ?>/> 全身紅潤</div>
				  <div class="even"><input type="checkbox"  value="肢體發紺" name="chk17[]"  <?php echo (!empty($c17) && in_array("肢體發紺", $c17 ))? "checked":""; ?>/> 肢體發紺</div>
				  <div class="odd"><input type="checkbox"  value="黃疸" name="chk17[]"  <?php echo (!empty($c17) && in_array("黃疸", $c17 ))? "checked":""; ?>/> 黃疸</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk17[]"  <?php echo ($chk17_other_ck)? "checked":""; ?>/> 其他</div><span id="chk17other"><input name="chk17_other" value="<?php echo $chk17_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">特徵：</td>
			<?php $c24 = (is_serialized($chk24))? unserialize($chk24) : array(); ?>
				<td colspan="2"><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="無特殊" name="chk24[]"  <?php echo (!empty($c24) && in_array("無特殊", $c24 ))? "checked":""; ?>/> 無特殊</div>
				  <div class="even"><input type="checkbox"  value="蒙古斑" name="chk24[]"  <?php echo (!empty($c24) && in_array("蒙古斑", $c24 ))? "checked":""; ?>/> 蒙古斑</div>
				  <div class="odd"><input type="checkbox"  value="血管瘤" name="chk24[]"  <?php echo (!empty($c24) && in_array("血管瘤", $c24 ))? "checked":""; ?>/> 血管瘤</div><span id="chk24othera"><input name="chk24_l" value="<?php echo $chk24_l; ?>" /></span>
				  <div class="even"><input type="checkbox"  value="脫皮" name="chk24[]"  <?php echo (!empty($c24) && in_array("脫皮", $c24 ))? "checked":""; ?>/> 脫皮</div>
				  <div class="odd"><input type="checkbox"  value="瘀斑" name="chk24[]"  <?php echo (!empty($c24) && in_array("瘀斑", $c24 ))? "checked":""; ?>/> 瘀斑</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk24[]"  <?php echo (!empty($c24) && in_array("其他", $c24 ))? "checked":""; ?>/> 其他</div><span id="chk24otherb"><input name="chk24_r" value="<?php echo $chk24_r; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center">頭部</td>
				<?php $c27 = (!empty($chk27)&&is_serialized($chk27))? unserialize($chk27) : array(); $chk27_other_ck = false; $chk27_other = '';
					if (!empty($c27)) {
						foreach ($c27 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car27 = explode(':', $string); $chk27_other_ck= true;  $chk27_other = (isset($car27[1])) ? $car27[1] : '';
							} 
						} 
					} ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="無特殊" name="chk27[]" <?php echo (!empty($c27) && in_array("無特殊", $c27 ))? "checked":""; ?>/> 無特殊</div>
				  <div class="even"><input type="checkbox"  value="頭骨重疊" name="chk27[]" <?php echo (!empty($c27) && in_array("頭骨重疊", $c27 ))? "checked":""; ?>/> 頭骨重疊</div>
				  <div class="odd"><input type="checkbox"  value="產瘤" name="chk27[]" <?php echo (!empty($c27) && in_array("產瘤", $c27 ))? "checked":""; ?>/> 產瘤</div>
				  <div class="even"><input type="checkbox"  value="頭血腫" name="chk27[]" <?php echo (!empty($c27) && in_array("頭血腫", $c27 ))? "checked":""; ?>/> 頭血腫</div>
				  <div class="odd"><input type="checkbox"  value="破皮" name="chk27[]" <?php echo (!empty($c27) && in_array("破皮", $c27 ))? "checked":""; ?>/> 破皮</div>
				  <div class="even"><input type="checkbox"  value="囟門凸出" name="chk27[]" <?php echo (!empty($c27) && in_array("囟門凸出", $c27 ))? "checked":""; ?>/> 囟門凸出</div>
				  <div class="odd"><input type="checkbox"  value="囟門凹陷" name="chk27[]" <?php echo (!empty($c27) && in_array("囟門凹陷", $c27 ))? "checked":""; ?>/> 囟門凹陷</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk27[]" <?php echo ($chk27_other_ck)? "checked":""; ?>/> 其他</div><span id="chk27other"><input name="chk27_other" value="<?php echo $chk27_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center" rowspan="5">臉部</td>
				<td class="center">眼：</td>
				<?php $c28 = (is_serialized($chk28))? unserialize($chk28) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk28[]" <?php echo (!empty($c28) && in_array("正常", $c28 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="眼距過大（＞2.5 cm）" name="chk28[]" <?php echo (!empty($c28) && in_array("眼距過大（＞2.5 cm）", $c28 ))? "checked":""; ?>/> 眼距過大（＞2.5 cm）</div>
				  <div class="odd"><input type="checkbox"  value="分泌物" name="chk28[]" <?php echo (!empty($c28) && in_array("分泌物", $c28 ))? "checked":""; ?>/> 分泌物</div>
				  <div class="even"><input type="checkbox"  value="鞏膜下出血" name="chk28[]" <?php echo (!empty($c28) && in_array("鞏膜下出血", $c28 ))? "checked":""; ?>/> 鞏膜下出血</div>
				  <div class="odd"><input type="checkbox"  value="日落眼" name="chk28[]" <?php echo (!empty($c28) && in_array("日落眼", $c28 ))? "checked":""; ?>/> 日落眼</div>
				  <div class="even"><input type="checkbox"  value="黃疸" name="chk28[]" <?php echo (!empty($c28) && in_array("黃疸", $c28 ))? "checked":""; ?>/> 黃疸</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">鼻：</td>
				<?php $c32 = (!empty($chk32)&&is_serialized($chk32))? unserialize($chk32) : array(); $chk32_other_ck = false; $chk32_other = '';
					if (!empty($c32)) {
						foreach ($c32 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car32 = explode(':', $string); $chk32_other_ck= true;  $chk32_other = (isset($car32[1])) ? $car32[1] : '';
							} 
						} 
					} ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="無特殊" name="chk32[]" <?php echo (!empty($c32) && in_array("無特殊", $c32 ))? "checked":""; ?>/> 無特殊</div>
				  <div class="even"><input type="checkbox"  value="粟粒疹" name="chk32[]" <?php echo (!empty($c32) && in_array("粟粒疹", $c32 ))? "checked":""; ?>/> 粟粒疹</div>
				  <div class="odd"><input type="checkbox"  value="鼻翼摺動" name="chk32[]" <?php echo (!empty($c32) && in_array("鼻翼摺動", $c32 ))? "checked":""; ?>/> 鼻翼摺動</div>
				  <div class="even"><input type="checkbox"  value="鼻塞" name="chk32[]" <?php echo (!empty($c32) && in_array("鼻塞", $c32 ))? "checked":""; ?>/> 鼻塞</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk32[]" <?php echo ($chk32_other_ck)? "checked":""; ?>/> 其他</div><span id="chk32other"><input name="chk32_other" value="<?php echo $chk32_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">口：</td>
				<?php $c34 = (!empty($chk34)&&is_serialized($chk34))? unserialize($chk34) : array(); $chk34_other_ck = false; $chk34_other = '';
					if (!empty($c34)) {
						foreach ($c34 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car34 = explode(':', $string); $chk34_other_ck= true;  $chk34_other = (isset($car34[1])) ? $car34[1] : '';
							} 
						} 
					} ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk34[]" <?php echo (!empty($c34) && in_array("正常", $c34 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="兔唇" name="chk34[]" <?php echo (!empty($c34) && in_array("兔唇", $c34 ))? "checked":""; ?>/> 兔唇</div>
				  <div class="odd"><input type="checkbox"  value="顎裂" name="chk34[]" <?php echo (!empty($c34) && in_array("顎裂", $c34 ))? "checked":""; ?>/> 顎裂</div>
				  <div class="even"><input type="checkbox"  value="鵝口瘡" name="chk34[]" <?php echo (!empty($c34) && in_array("鵝口瘡", $c34 ))? "checked":""; ?>/> 鵝口瘡</div>
				  <div class="odd"><input type="checkbox"  value="早熟牙" name="chk34[]" <?php echo (!empty($c34) && in_array("早熟牙", $c34 ))? "checked":""; ?>/> 早熟牙</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk34[]" <?php echo ($chk34_other_ck)? "checked":""; ?>/> 其他</div><span id="chk34other"><input name="chk34_other" value="<?php echo $chk34_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">耳：</td>
				<?php $c31 = (!empty($chk31)&&is_serialized($chk31))? unserialize($chk31) : array(); $chk31_other_ck = false; $chk31_other = '';
					if (!empty($c31)) {
						foreach ($c31 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car31 = explode(':', $string); $chk31_other_ck= true;  $chk31_other = (isset($car31[1])) ? $car31[1] : '';
							} 
						} 
					} ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk31[]" <?php echo (!empty($c31) && in_array("正常", $c31 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="分泌物" name="chk31[]" <?php echo (!empty($c31) && in_array("分泌物", $c31 ))? "checked":""; ?>/> 分泌物</div>
				  <div class="odd"><input type="checkbox"  value="低於眼睛內外眥連線" name="chk31[]" <?php echo (!empty($c31) && in_array("低於眼睛內外眥連線", $c31 ))? "checked":""; ?>/> 低於眼睛內外眥連線</div>
				  <div class="even"><input type="checkbox"  value="畸形" name="chk31[]" <?php echo (!empty($c31) && in_array("畸形", $c31 ))? "checked":""; ?>/> 畸形</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk31[]" <?php echo ($chk31_other_ck)? "checked":""; ?>/> 其他</div><span id="chk31other"><input name="chk31_other" value="<?php echo $chk31_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
				<td class="center">臉部：</td>
				<?php $c33 = (!empty($chk33)&&is_serialized($chk33))? unserialize($chk33) : array(); $chk33_other_ck = false; $chk33_other = '';
					if (!empty($c33)) {
						foreach ($c33 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car33 = explode(':', $string); $chk33_other_ck= true;  $chk33_other = (isset($car33[1])) ? $car33[1] : '';
							} 
						} 
					} ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="對稱" name="chk33[]" <?php echo (!empty($c33) && in_array("對稱", $c33 ))? "checked":""; ?>/> 對稱</div>
				  <div class="even"><input type="checkbox"  value="不對稱" name="chk33[]" <?php echo (!empty($c33) && in_array("不對稱", $c33 ))? "checked":""; ?>/> 不對稱</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk33[]" <?php echo ($chk33_other_ck)? "checked":""; ?>/> 其他</div><span id="chk33other"><input name="chk33_other" value="<?php echo $chk33_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
                <td class="center caption">頸部</td>
				<?php $c35 = (!empty($chk35)&&is_serialized($chk35))? unserialize($chk35) : array(); $chk35_other_ck = false; $chk35_other = '';
					if (!empty($c35)) {
						foreach ($c35 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car35 = explode(':', $string); $chk35_other_ck= true;  $chk35_other = (isset($car35[1])) ? $car35[1] : '';
							} 
						} 
					} ?>
				<td colspan="2"><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="正常" name="chk35[]" <?php echo (!empty($c35) && in_array("正常", $c35 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="硬塊" name="chk35[]" <?php echo (!empty($c35) && in_array("硬塊", $c35 ))? "checked":""; ?>/> 硬塊</div>
				  <div class="odd"><input type="checkbox"  value="斜頸" name="chk35[]" <?php echo (!empty($c35) && in_array("斜頸", $c35 ))? "checked":""; ?>/> 斜頸</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk35[]" <?php echo ($chk35_other_ck)? "checked":""; ?>/> 其他</div><span id="chk35other"><input name="chk35_other" value="<?php echo $chk35_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
                <td class="caption center">胸部</td>
				<?php $c38 = (!empty($chk38)&&is_serialized($chk38))? unserialize($chk38) : array(); $chk38_other_ck = false; $chk38_other = '';
					if (!empty($c38)) {
						foreach ($c38 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car38 = explode(':', $string); $chk38_other_ck= true;  $chk38_other = (isset($car38[1])) ? $car38[1] : '';
							} 
						} 
					} ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk38[]" <?php echo (!empty($c38) && in_array("正常", $c38 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="魔乳" name="chk38[]" <?php echo (!empty($c38) && in_array("魔乳", $c38 ))? "checked":""; ?>/> 魔乳</div>
				  <div class="odd"><input type="checkbox"  value="肋間凹陷" name="chk38[]" <?php echo (!empty($c38) && in_array("肋間凹陷", $c38 ))? "checked":""; ?>/> 肋間凹陷</div>
				  <div class="even"><input type="checkbox"  value="雞胸" name="chk38[]" <?php echo (!empty($c38) && in_array("雞胸", $c38 ))? "checked":""; ?>/> 雞胸</div>
				  <div class="odd"><input type="checkbox"  value="漏斗胸" name="chk38[]" <?php echo (!empty($c38) && in_array("漏斗胸", $c38 ))? "checked":""; ?>/> 漏斗胸</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk38[]" <?php echo ($chk38_other_ck)? "checked":""; ?>/> 其他</div><span id="chk38other"><input name="chk38_other" value="<?php echo $chk38_other; ?>" /></span>
                </div></td>
			  </tr>
	
			  <tr>
                <td class="caption center">腹部</td>
				<td class="center">臍部：</td>
				<?php $c44 = (is_serialized($chk44))? unserialize($chk44) : array(); ?>
				<td><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk44[]" <?php echo (!empty($c44) && in_array("正常", $c44 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="血管數目異常" name="chk44[]" <?php echo (!empty($c44) && in_array("血管數目異常", $c44 ))? "checked":""; ?>/> 血管數目異常</div>
				  <div class="odd"><input type="checkbox"  value="膨出" name="chk44[]" <?php echo (!empty($c44) && in_array("膨出", $c44 ))? "checked":""; ?>/> 膨出</div>
				  <div class="even"><input type="checkbox"  value="滲血" name="chk44[]" <?php echo (!empty($c44) && in_array("滲血", $c44 ))? "checked":""; ?>/> 滲血</div>
				  <div class="odd"><input type="checkbox"  value="分泌物" name="chk44[]" <?php echo (!empty($c44) && in_array("分泌物", $c44 ))? "checked":""; ?>/> 分泌物</div>
				  <div class="even"><input type="checkbox"  value="臭味" name="chk44[]" <?php echo (!empty($c44) && in_array("臭味", $c44 ))? "checked":""; ?>/> 臭味</div>
                </div></td>
              </tr>
			  <tr>
                <td class="caption center">生殖器</td>
				<td class="center"><?php echo $gender; ?></td>
				<td>
				<?php if ($gender == '男') { ?>
				<?php $c40 = (is_serialized($chk40))? unserialize($chk40) : array(); ?>
				<div class="mybox">
				  <div class="odd"><input type="checkbox"  value="睪丸已下降" name="chk40[]" <?php echo (!empty($c40) && in_array("睪丸已下降", $c40 ))? "checked":""; ?>/> 睪丸已下降</div>
				  <div class="even"><input type="checkbox"  value="睪丸未下降" name="chk40[]" <?php echo (!empty($c40) && in_array("睪丸未下降", $c40 ))? "checked":""; ?>/> 睪丸未下降</div>
				  <div class="odd"><input type="checkbox"  value="陰囊水腫" name="chk40[]" <?php echo (!empty($c40) && in_array("陰囊水腫", $c40 ))? "checked":""; ?>/> 陰囊水腫</div>
				  <div class="even"><input type="checkbox"  value="尿道下裂" name="chk40[]" <?php echo (!empty($c40) && in_array("尿道下裂", $c40 ))? "checked":""; ?>/> 尿道下裂</div>
				  <div class="odd"><input type="checkbox"  value="陰莖長小於2公分" name="chk40[]" <?php echo (!empty($c40) && in_array("陰莖長小於2公分", $c40 ))? "checked":""; ?>/> 陰莖長小於2公分</div>
                </div>
				<?php } elseif ($gender == '女') { ?>
				<?php $c40 = (!empty($chk40)&&is_serialized($chk40))? unserialize($chk40) : array(); $chk40_other_ck = false; $chk40_other = '';
					if (!empty($c40)) {
						foreach ($c40 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car40 = explode(':', $string); $chk40_other_ck= true;  $chk40_other = (isset($car40[1])) ? $car40[1] : '';
							} 
						} 
					} ?>
				<div class="mybox">
				  <div class="odd"><input type="checkbox"  value="無特殊" name="chk40[]" <?php echo (!empty($c40) && in_array("無特殊", $c40 ))? "checked":""; ?>/> 無特殊</div>
				  <div class="even"><input type="checkbox"  value="有血性分泌物" name="chk40[]" <?php echo (!empty($c40) && in_array("有血性分泌物", $c40 ))? "checked":""; ?>/> 有血性分泌物</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk40[]" <?php echo ($chk40_other_ck)? "checked":""; ?>/> 其他</div><span id="chk40other"><input name="chk40_other" value="<?php echo $chk40_other; ?>" /></span>
                </div>
				<?php } ?>
				</td>
              </tr>
			  <tr>
                <td class="caption center">肛門</td>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="radio"  value="正常" name="chk55" <?php echo ($chk55=="正常")? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="radio"  value="異常" name="chk55" <?php echo ($chk55=="異常")? "checked":""; ?>/> 異常</div>
                </div></td>
              </tr>
			  <tr>
			    <td class="caption center">四肢</td>
				<?php $c60 = (!empty($chk60)&&is_serialized($chk60))? unserialize($chk60) : array(); $chk60_other_ck = false; $chk60_other = '';
					if (!empty($c60)) {
						foreach ($c60 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car60 = explode(':', $string); $chk60_other_ck= true;  $chk60_other = (isset($car60[1])) ? $car60[1] : '';
							} 
						} 
					} ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk60[]" <?php echo (!empty($c60) && in_array("正常", $c60 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="足內翻" name="chk60[]" <?php echo (!empty($c60) && in_array("足內翻", $c60 ))? "checked":""; ?>/> 足內翻</div>
				  <div class="odd"><input type="checkbox"  value="足外翻" name="chk60[]" <?php echo (!empty($c60) && in_array("足外翻", $c60 ))? "checked":""; ?>/> 足外翻</div>
				  <div class="even"><input type="checkbox"  value="多指症" name="chk60[]" <?php echo (!empty($c60) && in_array("多指症", $c60 ))? "checked":""; ?>/> 多指症</div>
				  <div class="odd"><input type="checkbox"  value="蹼掌" name="chk60[]" <?php echo (!empty($c60) && in_array("蹼掌", $c60 ))? "checked":""; ?>/> 蹼掌</div>
				  <div class="even"><input type="checkbox"  value="其他" name="chk60[]" <?php echo ($chk60_other_ck)? "checked":""; ?>/> 其他</div><span id="chk60other"><input name="chk60_other" value="<?php echo $chk60_other; ?>" /></span>
                </div></td>
              </tr>
			  <tr>
                <td class="center caption">脊柱</td>
				<?php $c13 = (!empty($chk13)&&is_serialized($chk13))? unserialize($chk13) : array(); $chk13_other_ck = false; $chk13_other = '';
					if (!empty($c13)) {
						foreach ($c13 as $string) {
							if (preg_match("/其他/i", $string)) { 
								$car13 = explode(':', $string); $chk13_other_ck= true;  $chk13_other = (isset($car13[1])) ? $car13[1] : '';
							} 
						} 
					} ?>
				<td colspan="2"><div class="mybox">
				  <div class="odd"><input type="checkbox"  value="正常" name="chk13[]" <?php echo (!empty($c13) && in_array("正常", $c13 ))? "checked":""; ?>/> 正常</div>
				  <div class="even"><input type="checkbox"  value="彎曲" name="chk13[]" <?php echo (!empty($c13) && in_array("彎曲", $c13 ))? "checked":""; ?>/> 彎曲</div>
				  <div class="odd"><input type="checkbox"  value="其他" name="chk13[]" <?php echo (!empty($c13) && in_array("其他", $c13 ))? "checked":""; ?>/> 其他</div><span id="chk13other"><input name="chk13_other" value="<?php echo $chk13_other; ?>" /></span>
                </div></td>
			  </tr>
			  <tr>
                <td class="center caption" rowspan="9">神經反射</td>
			<?php $r1 = (is_serialized($reflex1))? unserialize($reflex1) : array(); ?>
				<td class="center">擁抱（Moro reflex） :</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="有" name="reflex1[]" <?php echo (!empty($r1) && in_array("有", $r1 ))? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="checkbox"  value="微弱" name="reflex1[]" <?php echo (!empty($r1) && in_array("微弱", $r1 ))? "checked":""; ?>/> 微弱</div>
                  <div class="odd"><input type="checkbox"  value="無" name="reflex1[]" <?php echo (!empty($r1) && in_array("無", $r1 ))? "checked":""; ?>/> 無</div>
				  <div class="even"><input type="checkbox"  value="不對稱" name="reflex1[]" <?php echo (!empty($r1) && in_array("不對稱", $r1 ))? "checked":""; ?>/> 不對稱</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r2 = (is_serialized($reflex2))? unserialize($reflex2) : array(); ?>
				<td class="center">尋乳（Rooting reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="有" name="reflex2[]" <?php echo (!empty($r2) && in_array("有", $r2 ))? "checked":""; ?>/> 有</div>
				  <div class="even"><input type="checkbox"  value="無" name="reflex2[]" <?php echo (!empty($r2) && in_array("無", $r2 ))? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r3 = (is_serialized($reflex3))? unserialize($reflex3) : array(); ?>
				<td class="center">吸吮（Sucking reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="有力" name="reflex3[]" <?php echo (!empty($r3) && in_array("有力", $r3 ))? "checked":""; ?>/> 有力</div>
				  <div class="even"><input type="checkbox"  value="微弱" name="reflex3[]" <?php echo (!empty($r3) && in_array("微弱", $r3 ))? "checked":""; ?>/> 微弱</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r4 = (is_serialized($reflex4))? unserialize($reflex4) : array(); ?>
				<td class="center">吞嚥（Swallow reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="良好" name="reflex4[]" <?php echo (!empty($r4) && in_array("良好", $r4 ))? "checked":""; ?>/> 良好</div>
				  <div class="even"><input type="checkbox"  value="欠佳" name="reflex4[]" <?php echo (!empty($r4) && in_array("欠佳", $r4 ))? "checked":""; ?>/> 欠佳</div>
                  <div class="odd"><input type="checkbox"  value="吐奶" name="reflex4[]" <?php echo (!empty($r4) && in_array("吐奶", $r4 ))? "checked":""; ?>/> 吐奶</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r5 = (is_serialized($reflex5))? unserialize($reflex5) : array(); ?>
				<td class="center">抓握（Palmar grasp）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="強" name="reflex5[]" <?php echo (!empty($r5) && in_array("強", $r5 ))? "checked":""; ?>/> 強</div>
				  <div class="even"><input type="checkbox"  value="弱" name="reflex5[]" <?php echo (!empty($r5) && in_array("弱", $r5 ))? "checked":""; ?>/> 弱</div>
                  <div class="odd"><input type="checkbox"  value="無" name="reflex5[]" <?php echo (!empty($r5) && in_array("無", $r5 ))? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r6 = (is_serialized($reflex6))? unserialize($reflex6) : array(); ?>
				<td class="center">僵頸（Tonic neck reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="明顯" name="reflex6[]" <?php echo (!empty($r6) && in_array("明顯", $r6 ))? "checked":""; ?>/> 明顯</div>
				  <div class="even"><input type="checkbox"  value="不明顯" name="reflex6[]" <?php echo (!empty($r6) && in_array("不明顯", $r6 ))? "checked":""; ?>/> 不明顯</div>
                  <div class="odd"><input type="checkbox"  value="無" name="reflex6[]" <?php echo (!empty($r6) && in_array("無", $r6 ))? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r7 = (is_serialized($reflex7))? unserialize($reflex7) : array(); ?>
				<td class="center">俯爬（Crawling reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="明顯" name="reflex7[]" <?php echo (!empty($r7) && in_array("明顯", $r7 ))? "checked":""; ?>/> 明顯</div>
				  <div class="even"><input type="checkbox"  value="不明顯" name="reflex7[]" <?php echo (!empty($r7) && in_array("不明顯", $r7 ))? "checked":""; ?>/> 不明顯</div>
                  <div class="odd"><input type="checkbox"  value="無" name="reflex7[]" <?php echo (!empty($r7) && in_array("無", $r7 ))? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r8 = (is_serialized($reflex8))? unserialize($reflex8) : array(); ?>
				<td class="center">踏步（Stepping reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="明顯" name="reflex8[]" <?php echo (!empty($r8) && in_array("明顯", $r8 ))? "checked":""; ?>/> 明顯</div>
				  <div class="even"><input type="checkbox"  value="不明顯" name="reflex8[]" <?php echo (!empty($r8) && in_array("不明顯", $r8 ))? "checked":""; ?>/> 不明顯</div>
                  <div class="odd"><input type="checkbox"  value="無" name="reflex8[]" <?php echo (!empty($r8) && in_array("無", $r8 ))? "checked":""; ?>/> 無</div>
                </div></td>
			  </tr>
			  <tr>
			<?php $r9 = (is_serialized($reflex9))? unserialize($reflex9) : array(); ?>
				<td class="center">巴賓斯基（Babinski reflex）：</td>
				<td><div class="mybox">
                  <div class="odd"><input type="checkbox"  value="陽性" name="reflex9[]" <?php echo (!empty($r9) && in_array("陽性", $r9 ))? "checked":""; ?>/> 陽性</div>
				  <div class="even"><input type="checkbox"  value="陰性" name="reflex9[]" <?php echo (!empty($r9) && in_array("陰性", $r9 ))? "checked":""; ?>/> 陰性</div>
                </div></td>
			  </tr>
			  <tr>
				<td class="caption center">其他說明</td>
				<td colspan="2"><textarea name="chk67" cols="65" rows="8"><?php echo $chk67; ?></textarea></td>
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
	$('.mybox > div').on('click', function(event) { 
		if(event.target.type !== "checkbox" && event.target.type !== "radio") {
			if ($('input:checkbox', this).is(':checked')) {
				$('input:checkbox', this).attr('checked', false);
			} else {
				$('input:checkbox', this).attr('checked', true);
			}
			if ($('input:radio', this).is(':checked')) {
				$('input:radio', this).attr('checked', false);
			} else {
				$('input:radio', this).attr('checked', true);
			}
		}

		
<?php $uotherchk = array('8', '13', '17', '27', '31', '32', '33', '34', '35', '38', '40', '60'); ?>		
<?php for ($i = 8; $i <= 61 ;$i++) { ?>
<?php if (in_array($i, $uotherchk )) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>
<?php } ?>


<?php for ($i = 5; $i <= 9 ;$i+=2) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('已施打',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('已施打',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 24; $i <= 24 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('血管瘤',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>othera').show();
	} else {
		$('span#chk<?php echo $i; ?>othera').hide();
	}
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>otherb').show();
	} else {
		$('span#chk<?php echo $i; ?>otherb').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('血管瘤',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>othera').show();
			} else {
				$('span#chk<?php echo $i; ?>othera').hide();
			}
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>otherb').show();
			} else {
				$('span#chk<?php echo $i; ?>otherb').hide();
			}
	});	
//-------------------------//
<?php } ?>

	//---------------------------//
	var allVals = [];
			 $('input[name^=field1]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#field1other').show();
			} else {
				$('span#field1other').hide();
			}
	$('input[name^=field1]').click(function() {
			 var allVals = [];
			 $('input[name^=field1]:checked').each(function() {
				allVals.push($(this).val());
				
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#field1other').show();
			} else {
				$('span#field1other').hide();
			}
	});	
	//---------------------------//
	
	//---------------------------//
	var allVals = [];
			 $('input[name^=field2]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('感染',allVals) != '-1') {
				$('span#field2other').show();
			} else {
				$('span#field2other').hide();
			}
	$('input[name^=field2]').click(function() {
			 var allVals = [];
			 $('input[name^=field2]:checked').each(function() {
				allVals.push($(this).val());
				
			 });
			if ($.inArray('感染',allVals) != '-1') {
				$('span#field2other').show();
			} else {
				$('span#field2other').hide();
			}
	});	
	//---------------------------//
	
});		


	
//--></script>
<script type="text/javascript"><!--	
	

	//---------------------------//
	var allVals = [];
			 $('input[name^=field1]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#field1other').show();
			} else {
				$('span#field1other').hide();
			}
	$('input[name^=field1]').click(function() {
			 var allVals = [];
			 $('input[name^=field1]:checked').each(function() {
				allVals.push($(this).val());
				
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#field1other').show();
			} else {
				$('span#field1other').hide();
			}
	});	
	//---------------------------//

	//---------------------------//
	var allVals = [];
			 $('input[name^=field2]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('感染',allVals) != '-1') {
				$('span#field2other').show();
			} else {
				$('span#field2other').hide();
			}
	$('input[name^=field2]').click(function() {
			 var allVals = [];
			 $('input[name^=field2]:checked').each(function() {
				allVals.push($(this).val());
				
			 });
			if ($.inArray('感染',allVals) != '-1') {
				$('span#field2other').show();
			} else {
				$('span#field2other').hide();
			}
	});	
	//---------------------------//
	
<?php $uotherchk = array('8', '13', '17', '27', '31', '32', '33', '34', '35', '38', '40', '60'); ?>		
<?php for ($i = 8; $i <= 61 ;$i++) { ?>
<?php if (in_array($i, $uotherchk )) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>
<?php } ?>

<?php for ($i = 5; $i <= 9 ;$i+=2) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('已施打',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>other').show();
	} else {
		$('span#chk<?php echo $i; ?>other').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('已施打',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>other').show();
			} else {
				$('span#chk<?php echo $i; ?>other').hide();
			}
	});	
//-------------------------//
<?php } ?>

<?php for ($i = 24; $i <= 24 ;$i++) { ?>
	var allVals = [];
	$('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
		allVals.push($(this).val());
	 });
	if ($.inArray('血管瘤',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>othera').show();
	} else {
		$('span#chk<?php echo $i; ?>othera').hide();
	}
	if ($.inArray('其他',allVals) != '-1') {
		$('span#chk<?php echo $i; ?>otherb').show();
	} else {
		$('span#chk<?php echo $i; ?>otherb').hide();
	}
	$('input[name^=chk<?php echo $i; ?>]').on('change', function() {
		     var allVals = [];
			 $('input[name^=chk<?php echo $i; ?>]:checked').each(function() {
				allVals.push($(this).val());
			 });
			if ($.inArray('血管瘤',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>othera').show();
			} else {
				$('span#chk<?php echo $i; ?>othera').hide();
			}
			if ($.inArray('其他',allVals) != '-1') {
				$('span#chk<?php echo $i; ?>otherb').show();
			} else {
				$('span#chk<?php echo $i; ?>otherb').hide();
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
	timeFormat: 'hh:mm'
});
$('.time').timepicker({timeFormat: 'hh:mm'});
//--></script> 
<?php echo $footer; ?>