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
      <div id="tabs" class="htabs"><a href="#tab-nurse4c"><?php echo $tab_beck; ?></a><a href="#tab-datatable"><?php echo $tab_datatable; ?></a></div>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-nurse4c">
          <table class="form list">
			  <tr>
				<td width="15%"><strong>在過去七天中</strong></td>
				<td width="35%"></td>
				<td width="15%"></td>
				<td width="35%"></td>
			  </tr>
			  <tr>
                <td>A</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不覺得悲傷" rel="0" name="chk1"  <?php echo ($chk1=="我不覺得悲傷")? "checked":""; ?>/> 我不覺得悲傷</div>
				  <div class="even"><input type="radio"  value="我覺得悲傷" rel="1" name="chk1"  <?php echo ($chk1=="我覺得悲傷")? "checked":""; ?>/> 我覺得悲傷</div>
				  <div class="odd"><input type="radio"  value="我時時感到悲傷，無法驅除這種感受" rel="2" name="chk1"  <?php echo ($chk1=="我時時感到悲傷，無法驅除這種感受")? "checked":""; ?>/> 我時時感到悲傷，無法驅除這種感受</div>
				  <div class="even"><input type="radio"  value="我悲傷或不快樂得無法忍受" rel="3" name="chk1"  <?php echo ($chk1=="我悲傷或不快樂得無法忍受")? "checked":""; ?>/> 我悲傷或不快樂得無法忍受</div>
                </div></td>
                <td>B</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="對將來我並不感到特別沮喪" rel="0" name="chk2"  <?php echo ($chk2=="對將來我並不感到特別沮喪")? "checked":""; ?>/> 對將來我並不感到特別沮喪</div>
				  <div class="even"><input type="radio"  value="對將來我感到沮喪" rel="1" name="chk2"  <?php echo ($chk2=="對將來我感到沮喪")? "checked":""; ?>/> 對將來我感到沮喪</div>
				  <div class="odd"><input type="radio"  value="我覺得將來沒有什麼希望" rel="2" name="chk2"  <?php echo ($chk2=="我覺得將來沒有什麼希望")? "checked":""; ?>/> 我覺得將來沒有什麼希望</div>
				  <div class="even"><input type="radio"  value="我感到將來沒希望，事情不能改善" rel="3" name="chk2"  <?php echo ($chk2=="我感到將來沒希望，事情不能改善")? "checked":""; ?>/> 我感到將來沒希望，事情不能改善</div>
                </div></td>
              </tr>
			  <tr>
                <td>C</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不覺得自己像是個失敗者" rel="0" name="chk3"  <?php echo ($chk3=="我不覺得自己像是個失敗者")? "checked":""; ?>/> 我不覺得自己像是個失敗者</div>
				  <div class="even"><input type="radio"  value="我覺自己已比一般的人失敗得更多" rel="1" name="chk3"  <?php echo ($chk3=="我覺自己已比一般的人失敗得更多")? "checked":""; ?>/> 我覺自己已比一般的人失敗得更多</div>
				  <div class="odd"><input type="radio"  value="回顧過去，我所看到的就是一連串的失敗" rel="2" name="chk3"  <?php echo ($chk3=="回顧過去，我所看到的就是一連串的失敗")? "checked":""; ?>/> 回顧過去，我所看到的就是一連串的失敗</div>
				  <div class="even"><input type="radio"  value="身為一個人我覺得我是徹底的失敗者" rel="3"  name="chk3"  <?php echo ($chk3=="身為一個人我覺得我是徹底的失敗者")? "checked":""; ?>/> 身為一個人我覺得我是徹底的失敗者</div>
                </div></td>
                <td>D</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我現在從事情中得到的滿足跟過去一樣多" rel="0" name="chk4"  <?php echo ($chk4=="我現在從事情中得到的滿足跟過去一樣多")? "checked":""; ?>/> 我現在從事情中得到的滿足跟過去一樣多</div>
				  <div class="even"><input type="radio"  value="與過去比較，現在我比較不能從事情中獲得喜悅" rel="1" name="chk4"  <?php echo ($chk4=="與過去比較，現在我比較不能從事情中獲得喜悅")? "checked":""; ?>/> 與過去比較，現在我比較不能從事情中獲得喜悅</div>
				  <div class="odd"><input type="radio"  value="我再也不能從任何事情中獲得真正的滿足" rel="2" name="chk4"  <?php echo ($chk4=="我再也不能從任何事情中獲得真正的滿足")? "checked":""; ?>/> 我再也不能從任何事情中獲得真正的滿足</div>
				  <div class="even"><input type="radio"  value="我對樣樣事都不滿或厭煩" rel="3" name="chk4"  <?php echo ($chk4=="我對樣樣事都不滿或厭煩")? "checked":""; ?>/> 我對樣樣事都不滿或厭煩</div>
                </div></td>
              </tr>
			  <tr>
                <td>E</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不特別覺得罪惡" rel="0" name="chk5"  <?php echo ($chk5=="我不特別覺得罪惡")? "checked":""; ?>/> 我不特別覺得罪惡</div>
				  <div class="even"><input type="radio"  value="相當多的時間我覺得罪惡" rel="1" name="chk5"  <?php echo ($chk5=="相當多的時間我覺得罪惡")? "checked":""; ?>/> 相當多的時間我覺得罪惡</div>
				  <div class="odd"><input type="radio"  value="大部份時間，我覺得自己真的很罪惡" rel="2" name="chk5"  <?php echo ($chk5=="大部份時間，我覺得自己真的很罪惡")? "checked":""; ?>/> 大部份時間，我覺得自己真的很罪惡</div>
				  <div class="even"><input type="radio"  value="我總是感到罪惡" rel="3" name="chk5"  <?php echo ($chk5=="我總是感到罪惡")? "checked":""; ?>/> 我總是感到罪惡</div>
                </div></td>
                <td>F</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不認為我正受懲罰" rel="0" name="chk6"  <?php echo ($chk6=="我不認為我正受懲罰")? "checked":""; ?>/> 我不認為我正受懲罰</div>
				  <div class="even"><input type="radio"  value="我感到或許會受罰" rel="1" name="chk6"  <?php echo ($chk6=="我感到或許會受罰")? "checked":""; ?>/> 我感到或許會受罰</div>
				  <div class="odd"><input type="radio"  value="我料想會受懲罰" rel="2" name="chk6"  <?php echo ($chk6=="我料想會受懲罰")? "checked":""; ?>/> 我料想會受懲罰</div>
				  <div class="even"><input type="radio"  value="我覺得自己正在受罰" rel="3" name="chk6"  <?php echo ($chk6=="我覺得自己正在受罰")? "checked":""; ?>/> 我覺得自己正在受罰</div>
                </div></td>
              </tr>
			  <tr>
                <td>G</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我對自己不感到失望" rel="0" name="chk7"  <?php echo ($chk7=="我對自己不感到失望")? "checked":""; ?>/> 我對自己不感到失望</div>
				  <div class="even"><input type="radio"  value="我對自己感到失望" rel="1" name="chk7"  <?php echo ($chk7=="我對自己感到失望")? "checked":""; ?>/> 我對自己感到失望</div>
				  <div class="odd"><input type="radio"  value="我討厭自己" rel="2" name="chk7"  <?php echo ($chk7=="我討厭自己")? "checked":""; ?>/> 我討厭自己</div>
				  <div class="even"><input type="radio"  value="我恨自己" rel="3" name="chk7"  <?php echo ($chk7=="我恨自己")? "checked":""; ?>/> 我恨自己</div>
                </div></td>
                <td>H</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不覺得自己比別人更壞" rel="0" name="chk8"  <?php echo ($chk8=="我不覺得自己比別人更壞")? "checked":""; ?>/> 我不覺得自己比別人更壞</div>
				  <div class="even"><input type="radio"  value="我因自己有弱點或錯誤而批評自己" rel="1" name="chk8"  <?php echo ($chk8=="我因自己有弱點或錯誤而批評自己")? "checked":""; ?>/> 我因自己有弱點或錯誤而批評自己</div>
				  <div class="odd"><input type="radio"  value="我由於自己的過錯而經常自責" rel="2" name="chk8"  <?php echo ($chk8=="我由於自己的過錯而經常自責")? "checked":""; ?>/> 我由於自己的過錯而經常自責</div>
				  <div class="even"><input type="radio"  value="我因發生的一切壞事而自責" rel="3" name="chk8"  <?php echo ($chk8=="我因發生的一切壞事而自責")? "checked":""; ?>/> 我因發生的一切壞事而自責</div>
                </div></td>
              </tr>
			  <tr>
                <td>I</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我沒有自殺的念頭" rel="0" name="chk9"  <?php echo ($chk9=="我沒有自殺的念頭")? "checked":""; ?>/> 我沒有自殺的念頭</div>
				  <div class="even"><input type="radio"  value="我有自殺的念頭，但沒有付諸實行" rel="1" name="chk9"  <?php echo ($chk9=="我有自殺的念頭，但沒有付諸實行")? "checked":""; ?>/> 我有自殺的念頭，但沒有付諸實行</div>
				  <div class="odd"><input type="radio"  value="我想自殺" rel="2" name="chk9"  <?php echo ($chk9=="我想自殺")? "checked":""; ?>/> 我想自殺</div>
				  <div class="even"><input type="radio"  value="如果有機會我會自殺" rel="3" name="chk9"  <?php echo ($chk9=="如果有機會我會自殺")? "checked":""; ?>/> 如果有機會我會自殺</div>
                </div></td>
                <td>J</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我並不比平常容易哭" rel="0" name="chk10"  <?php echo ($chk10=="我並不比平常容易哭")? "checked":""; ?>/> 我並不比平常容易哭</div>
				  <div class="even"><input type="radio"  value="我比以前更愛哭" rel="1" name="chk10"  <?php echo ($chk10=="我比以前更愛哭")? "checked":""; ?>/> 我比以前更愛哭</div>
				  <div class="odd"><input type="radio"  value="現在我時時在哭" rel="2" name="chk10"  <?php echo ($chk10=="現在我時時在哭")? "checked":""; ?>/> 現在我時時在哭</div>
				  <div class="even"><input type="radio"  value="我過去很會哭，但如今縱使我想哭也哭不出來了" rel="3" name="chk10"  <?php echo ($chk10=="我過去很會哭，但如今縱使我想哭也哭不出來了")? "checked":""; ?>/> 我過去很會哭，但如今縱使我想哭也哭不出來了</div>
                </div></td>
              </tr>
			  <tr>
                <td>K</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我和以前一樣，沒有特別暴躁" rel="0" name="chk11"  <?php echo ($chk11=="我和以前一樣，沒有特別暴躁")? "checked":""; ?>/> 我和以前一樣，沒有特別暴躁</div>
				  <div class="even"><input type="radio"  value="我比以前容易激怒或暴躁" rel="1" name="chk11"  <?php echo ($chk11=="我比以前容易激怒或暴躁")? "checked":""; ?>/> 我比以前容易激怒或暴躁</div>
				  <div class="odd"><input type="radio"  value="現在我時時感到暴躁" rel="2" name="chk11"  <?php echo ($chk11=="現在我時時感到暴躁")? "checked":""; ?>/> 現在我時時感到暴躁</div>
				  <div class="even"><input type="radio"  value="過去經常使我暴躁的事情一點也不再使我暴躁了" rel="3" name="chk11"  <?php echo ($chk11=="過去經常使我暴躁的事情一點也不再使我暴躁了")? "checked":""; ?>/> 過去經常使我暴躁的事情一點也不再使我暴躁了</div>
                </div></td>
                <td>L</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我對他人並沒失去興趣" rel="0" name="chk12"  <?php echo ($chk12=="我對他人並沒失去興趣")? "checked":""; ?>/> 我對他人並沒失去興趣</div>
				  <div class="even"><input type="radio"  value="我現在不像過去那樣對他人感到興趣" rel="1" name="chk12"  <?php echo ($chk12=="我現在不像過去那樣對他人感到興趣")? "checked":""; ?>/> 我現在不像過去那樣對他人感到興趣</div>
				  <div class="odd"><input type="radio"  value="我對他人已失去大部份的興趣" rel="2" name="chk12"  <?php echo ($chk12=="我對他人已失去大部份的興趣")? "checked":""; ?>/> 我對他人已失去大部份的興趣</div>
				  <div class="even"><input type="radio"  value="我對他人已完全失去興趣" rel="3" name="chk12"  <?php echo ($chk12=="我對他人已完全失去興趣")? "checked":""; ?>/> 我對他人已完全失去興趣</div>
                </div></td>
              </tr>
			  <tr>
                <td>M</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我大致與以前一樣做決定" rel="0" name="chk13"  <?php echo ($chk13=="我大致與以前一樣做決定")? "checked":""; ?>/> 我大致與以前一樣做決定</div>
				  <div class="even"><input type="radio"  value="我現在比以前更會拖延去做決定" rel="1" name="chk13"  <?php echo ($chk13=="我現在比以前更會拖延去做決定")? "checked":""; ?>/> 我現在比以前更會拖延去做決定</div>
				  <div class="odd"><input type="radio"  value="我現在比以前更難做決定" rel="2" name="chk13"  <?php echo ($chk13=="我現在比以前更難做決定")? "checked":""; ?>/> 我現在比以前更難做決定</div>
				  <div class="even"><input type="radio"  value="我再也無法做任何決定" rel="3" name="chk13"  <?php echo ($chk13=="我再也無法做任何決定")? "checked":""; ?>/> 我再也無法做任何決定</div>
                </div></td>
                <td>N</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我不覺得我自己比以前醜" rel="0" name="chk14"  <?php echo ($chk14=="我不覺得我自己比以前醜")? "checked":""; ?>/> 我不覺得我自己比以前醜</div>
				  <div class="even"><input type="radio"  value="我煩惱自己看起來漸老或漸不吸引人了" rel="1" name="chk14"  <?php echo ($chk14=="我煩惱自己看起來漸老或漸不吸引人了")? "checked":""; ?>/> 我煩惱自己看起來漸老或漸不吸引人了</div>
				  <div class="odd"><input type="radio"  value="我覺得外貌有了永久性變化，使我看起來不吸引人" rel="2" name="chk14"  <?php echo ($chk14=="我覺得外貌有了永久性變化，使我看起來不吸引人")? "checked":""; ?>/> 我覺得外貌有了永久性變化，使我看起來不吸引人</div>
				  <div class="even"><input type="radio"  value="我相信自己長得醜" rel="3" name="chk14"  <?php echo ($chk14=="我相信自己長得醜")? "checked":""; ?>/> 我相信自己長得醜</div>
                </div></td>
              </tr>
			  <tr>
                <td>O</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="大致而言，我能夠像往常一樣好好地工作" rel="0" name="chk15"  <?php echo ($chk15=="大致而言，我能夠像往常一樣好好地工作")? "checked":""; ?>/> 大致而言，我能夠像往常一樣好好地工作</div>
				  <div class="even"><input type="radio"  value="我需要特別努力，才能開始做事" rel="1" name="chk15"  <?php echo ($chk15=="我需要特別努力，才能開始做事")? "checked":""; ?>/> 我需要特別努力，才能開始做事</div>
				  <div class="odd"><input type="radio"  value="無論任何事情，我都必須很辛若勉強自己，才能去做" rel="2" name="chk15"  <?php echo ($chk15=="無論任何事情，我都必須很辛若勉強自己，才能去做")? "checked":""; ?>/> 無論任何事情，我都必須很辛若勉強自己，才能去做</div>
				  <div class="even"><input type="radio"  value="我一點也無法工作" rel="3" name="chk15"  <?php echo ($chk15=="我一點也無法工作")? "checked":""; ?>/> 我一點也無法工作</div>
                </div></td>
                <td>P</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我能像平常般睡好覺" rel="0" name="chk16"  <?php echo ($chk16=="我能像平常般睡好覺")? "checked":""; ?>/> 我能像平常般睡好覺</div>
				  <div class="even"><input type="radio"  value="我不如以往睡得好" rel="1" name="chk16"  <?php echo ($chk16=="我不如以往睡得好")? "checked":""; ?>/> 我不如以往睡得好</div>
				  <div class="odd"><input type="radio"  value="我比平常早一二小時醒來，並且發現難以再入眠" rel="2" name="chk16"  <?php echo ($chk16=="我比平常早一二小時醒來，並且發現難以再入眠")? "checked":""; ?>/> 我比平常早一二小時醒來，並且發現難以再入眠</div>
				  <div class="even"><input type="radio"  value="我比平常早好幾小時醒來，而且無法再入眠" rel="3" name="chk16"  <?php echo ($chk16=="我比平常早好幾小時醒來，而且無法再入眠")? "checked":""; ?>/> 我比平常早好幾小時醒來，而且無法再入眠</div>
                </div></td>
              </tr>
			  <tr>
                <td>Q</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我並沒有比平常更疲倦" rel="0" name="chk17"  <?php echo ($chk17=="我並沒有比平常更疲倦")? "checked":""; ?>/> 我並沒有比平常更疲倦</div>
				  <div class="even"><input type="radio"  value="我比前更容易累" rel="1" name="chk17"  <?php echo ($chk17=="我比前更容易累")? "checked":""; ?>/> 我比前更容易累</div>
				  <div class="odd"><input type="radio"  value="幾乎任何事我一做就累" rel="2" name="chk17"  <?php echo ($chk17=="幾乎任何事我一做就累")? "checked":""; ?>/> 幾乎任何事我一做就累</div>
				  <div class="even"><input type="radio"  value="我太累了以致無法做任何事" rel="3" name="chk17"  <?php echo ($chk17=="我太累了以致無法做任何事")? "checked":""; ?>/> 我太累了以致無法做任何事</div>
                </div></td>
                <td>R</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我的胃口並不比前差" rel="0" name="chk18"  <?php echo ($chk18=="我的胃口並不比前差")? "checked":""; ?>/> 我的胃口並不比前差</div>
				  <div class="even"><input type="radio"  value="我比以前更容易累" rel="1" name="chk18"  <?php echo ($chk18=="我比以前更容易累")? "checked":""; ?>/> 我比以前更容易累</div>
				  <div class="odd"><input type="radio"  value="幾乎任何事我一做就累" rel="2" name="chk18"  <?php echo ($chk18=="幾乎任何事我一做就累")? "checked":""; ?>/> 幾乎任何事我一做就累</div>
				  <div class="even"><input type="radio"  value="我太累了以致無法做任何事" rel="3" name="chk18"  <?php echo ($chk18=="我太累了以致無法做任何事")? "checked":""; ?>/> 我太累了以致無法做任何事</div>
                </div></td>
              </tr>
			  <tr>
                <td>S</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我近來體重未見減輕，即使有也是不多" rel="0" name="chk19"  <?php echo ($chk19=="我近來體重未見減輕，即使有也是不多")? "checked":""; ?>/> 我近來體重未見減輕，即使有也是不多</div>
				  <div class="even"><input type="radio"  value="我的體重減輕5磅(3.5公斤)以上" rel="1" name="chk19"  <?php echo ($chk19=="我的體重減輕5磅(3.5公斤)以上")? "checked":""; ?>/> 我的體重減輕5磅(3.5公斤)以上</div>
				  <div class="odd"><input type="radio"  value="我的體重減輕10磅(6.6公斤)以上" rel="2" name="chk19"  <?php echo ($chk19=="我的體重減輕10磅(6.6公斤)以上")? "checked":""; ?>/> 我的體重減輕10磅(6.6公斤)以上</div>
				  <div class="even"><input type="radio"  value="我的體重減輕15磅(10公斤)以上" rel="3" name="chk19"  <?php echo ($chk19=="我的體重減輕15磅(10公斤)以上")? "checked":""; ?>/> 我的體重減輕15磅(10公斤)以上</div>
                </div></td>
                <td>T</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我跟以前一樣不擔心我的健康" rel="0" name="chk20"  <?php echo ($chk20=="我跟以前一樣不擔心我的健康")? "checked":""; ?>/> 我跟以前一樣不擔心我的健康</div>
				  <div class="even"><input type="radio"  value="我擔心我身體上的不舒服，諸如：頭痛及身體上的病痛、胃不舒服或便秘等" rel="1" name="chk20"  <?php echo ($chk20=="我擔心我身體上的不舒服，諸如：頭痛及身體上的病痛、胃不舒服或便秘等")? "checked":""; ?>/> 我擔心我身體上的不舒服，諸如：頭痛及身體上的病痛、胃不舒服或便秘等</div>
				  <div class="odd"><input type="radio"  value="我很擔心身上的不舒服，並且難以去考慮其他事情" rel="2" name="chk20"  <?php echo ($chk20=="我很擔心身上的不舒服，並且難以去考慮其他事情")? "checked":""; ?>/> 我很擔心身上的不舒服，並且難以去考慮其他事情</div>
				  <div class="even"><input type="radio"  value="我非常擔心我身體上的不舒服，以致無法去考慮任何其他的事情" rel="3" name="chk20"  <?php echo ($chk20=="我非常擔心我身體上的不舒服，以致無法去考慮任何其他的事情")? "checked":""; ?>/> 我非常擔心我身體上的不舒服，以致無法去考慮任何其他的事情</div>
                </div></td>
              </tr>
			  <tr>
                <td>U</td>
				<td><div class="scrollbox">
                  <div class="odd"><input type="radio"  value="我並未發現我最近對於性的興趣有任何轉變" rel="0" name="chk21"  <?php echo ($chk21=="我並未發現我最近對於性的興趣有任何轉變")? "checked":""; ?>/> 我並未發現我最近對於性的興趣有任何轉變</div>
				  <div class="even"><input type="radio"  value="我對於性比以前不感興趣" rel="1" name="chk21"  <?php echo ($chk21=="我對於性比以前不感興趣")? "checked":""; ?>/> 我對於性比以前不感興趣</div>
				  <div class="odd"><input type="radio"  value="我目前對於性較缺乏興趣" rel="2" name="chk21"  <?php echo ($chk21=="我目前對於性較缺乏興趣")? "checked":""; ?>/> 我目前對於性較缺乏興趣</div>
				  <div class="even"><input type="radio"  value="我對於性完全失去興趣" rel="3" name="chk21"  <?php echo ($chk21=="我對於性完全失去興趣")? "checked":""; ?>/> 我對於性完全失去興趣</div>
                </div></td>
              </tr>
			  <tr>
                <td>分</td>
                <td><input type="text" name="score" value="<?php echo $score; ?>" size="12" /></td>
				<td></td>
				<td></td>
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
$(function() {
	function countTotal() {
		var sum = 0;

		$("input[type=radio]:checked").each(function(){	
		  sum += parseInt($(this).attr("rel"));
		});
		
		$('input[name="score"]').val(sum);
	}
	
	$('input[type=radio]').change(function() {
			countTotal();
	});
});
//--></script>
<?php echo $footer; ?>