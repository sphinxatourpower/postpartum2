<?php    
class ControllerDoctorChildDoctor2 extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('doctor/childdoctor2');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('doctor/childdoctor2');
		
    	$this->getList();
		
  	}
  
	public function word() {		
		$this->load->language('doctor/childdoctor2');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/child');
		$this->load->model('service/customer_service');
		
		$this->load->model('doctor/childdoctor2');
		$childdoctor2s = $this->model_doctor_childdoctor2->getChildDoctor2UnionDatas($this->request->get['union_id']);
					
			$titleFormat = array(
									'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '14pt');

			if (!empty($childdoctor2s)) {		
				$this->load->model('tool/worddoc');
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				//$filename = "2E小兒科醫師巡診單_".$childname;
				$filename = "2E小兒科醫師檢查嬰兒紀錄表_".date('Ymd');
								
				foreach ($childdoctor2s as $kk => $childdoctor_info) {
				
					$result = $this->model_service_child->getChildDataTable($childdoctor_info['customer_child_id']);
					$tablerows = array();
					
					if (!empty($result)) { 
							$called = ($result['gender'] == "女") ? "女" : "子";
							$childname = ($result['name']=='') ? $result['customer_name']."之".$called : $result['name'];

							
							$rooms = $this->model_service_child->getTransfers($result['customer_id'], 'DESC');
							$lastroom = $rooms[0]['customer_room_name'];
							$doctor_name = $this->model_service_customer_service->getCustomerServiceName($childdoctor_info['doctor_id']);
							
							// 房號、母親姓名、週數、性別、生產方式、出生日期、出生體重
							// 體溫、目前體重、下降 %、黃疸指數、黃疸檢測日期、醫師、檢查日期
										
							$tablerows = array(
								array (
									'content' => array('房號：'.$lastroom, '母親姓名：'.$result['customer_name'], '週數：'.$result['pregnancy_weeks'], '性別：'.$result['gender'], '生產方式：'.$result['childbirth_method'], '出生日期：'.$result['birthdate'], '出生體重：'.$result['birthweight'] ), 
									//'span' => array()
								),
								array(
									'content' => array(
										'0' => '體溫：'.$childdoctor_info['temperature'] . '℃', 
										'1' => '目前體重：'.$childdoctor_info['weight'], 
										'2' => '下降：'.$childdoctor_info['weight_down'].' %', 
										'3'	=> ($childdoctor_info['jaundice_chkdate']&&$childdoctor_info['jaundice']) ? '黃疸指數：'.$childdoctor_info['jaundice'] : '',
										'4'	=> ($childdoctor_info['jaundice_chkdate']&&$childdoctor_info['jaundice']) ? '黃疸檢測日期：'.$childdoctor_info['jaundice_chkdate'] : '',
										'5' => '醫師：'.$doctor_name,
										'6' => '檢測日期：'.$childdoctor_info['date_added']
									),
									//'span' => array()
								)
							);
					}
				
					$this->model_tool_worddoc->addParagraph("小兒科醫師檢查嬰兒紀錄表", $titleFormat);
					//$this->model_tool_worddoc->addParagraph("小兒科醫師檢查嬰兒紀錄表：".$childdoctor_info['date_added']."&#09;&#09;醫師：".$doctor_name, $titleFormat);
					//$this->model_tool_worddoc->addParagraph("表格 1");
						
					$this->model_tool_worddoc->startTable();
					foreach ($tablerows as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
					//$this->model_tool_worddoc->addParagraph('');

					if (!empty($childdoctor_info)) {
					
						$nar = array(4,5,8,9,11,12,13,14,15,16,17,18,19,21,22,23,26,27,28,29,30,31,32,33,34);
						$cvar = array(
							'活動力：',
							'膚色：',
							'體溫：',
							'體重：',
							'大便：',
							'小便：',
							'餵食：',
							'紅疹：',
							'血管瘤：',
							'其他：',
							'結膜炎：',
							'血管瘤：',
							'鼻淚管阻塞：',
							'耳前息肉：',
							'耳道異常分泌物：',
							'',
							'',
							'',
							'頭部：',
							'斜頸：',
							'',
							'',
							'呼吸音：',
							'腹部： ',
							'腸蠕動聲：',
							'肚臍：',
							'上肢：',
							'下肢：',
							'鎖骨：',
							(!empty($result)) ? $result['gender'] : '',
							'疝氣：',
							'隱睪症：',
							'陰囊水腫：',
							'腹股溝：',
							'紅臀：'
						);
						for ($i=1;$i<=35;$i++) {
							if ($childdoctor_info['chk'.$i.'']) { 
								if (in_array($i, $nar)&&is_array(${"ca".$i} = unserialize($childdoctor_info['chk'.$i.'']))) {
									${"chk".$i} = (!empty(${"ca".$i})) ? $cvar[$i-1] . implode(",", ${"ca".$i}) . "<br />" : "";
								} else {
									${"chk".$i} = ($childdoctor_info['chk'.$i.'']) ? $cvar[$i-1] . $childdoctor_info['chk'.$i.'']."<br />" : "";
								}
							} else {
								${"chk".$i} = '';
							}
						}
						
						$medicine = (!empty($childdoctor_info['medicine'])) ? implode(",", $childdoctor_info['medicine']) . "<br />" : "";
						
						$grpchk = ($childdoctor_info['groupchk']<>'') ? unserialize($childdoctor_info['groupchk']) : array();
						$groupchk1 = (in_array("一般表現", $grpchk)||$chk1.$chk2.$chk3.$chk4.$chk5.$chk6.$chk7=='') ? "正常" : $chk1.$chk2.$chk3.$chk4.$chk5.$chk6.$chk7;
						$groupchk2 = (in_array("皮膚", $grpchk)||$chk8.$chk9.$chk10=='') ? "正常" : $chk8.$chk9.$chk10;
						$groupchk3 = (in_array("眼", $grpchk)||$chk11.$chk12.$chk13=='') ? "正常" : $chk11.$chk12.$chk13;
						$groupchk4 = (in_array("耳", $grpchk)||$chk14.$chk15=='') ? "正常" : $chk14.$chk15;
						$groupchk5 = (in_array("口腔", $grpchk)||$chk16=='') ? "正常" : $chk16;
						$groupchk6 = (in_array("鼻咽喉部", $grpchk)||$chk17=='') ? "正常" : $chk17;
						$groupchk7 = (in_array("喉", $grpchk)||$chk18=='') ? "正常" : $chk18;
						$groupchk8 = (in_array("頭頸部", $grpchk)||$chk19.$chk20=='') ? "正常" : $chk19.$chk20;
						$groupchk9 = (in_array("胸腔", $grpchk)||$chk21=='') ? "正常" : $chk21;
						$groupchk10 = (in_array("心", $grpchk)||$chk22=='') ? "正常" : $chk22;
						$groupchk11 = (in_array("肺", $grpchk)||$chk23=='') ? "正常" : $chk23;
						$groupchk12 = (in_array("腹部", $grpchk)||$chk24.$chk25.$chk26=='') ? "正常" : $chk24.$chk25.$chk26;
						$groupchk13 = (in_array("四肢", $grpchk)||$chk27.$chk28.$chk29=='') ? "正常" : $chk27.$chk28.$chk29;
						$groupchk14 = (in_array("生殖器", $grpchk)||$chk30.$chk31.$chk32.$chk33.$chk34=='') ? "正常" : $chk30.$chk31.$chk32.$chk33.$chk34;
						$groupchk15 = (in_array("臀部", $grpchk)||$chk35=='') ? "正常" : $chk35;
						$groupchk16 = (in_array("醫囑", $grpchk)||$childdoctor_info['prescription']=='') ? "正常" : $childdoctor_info['prescription'];
						$groupchk18 = (in_array("處方", $grpchk)||$medicine=='') ? "正常" : $medicine;
						$groupchk17 = (in_array("其他", $grpchk)||$childdoctor_info['supplement']=='') ? "正常" : $childdoctor_info['supplement'];

						$chktablerows = array(
								array (
									'content'	=> array('項目', '正常/異常情況'),
									//'span'	=> array('1', '2')
									'cellwidth'	=> array('20%', '80%')
								),
								array (
									'content'	=> array('一般表現', $groupchk1),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('皮膚', $groupchk2),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('眼', $groupchk3),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('耳', $groupchk4),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('口腔', $groupchk5),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('鼻咽喉部', $groupchk6),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('喉', $groupchk7),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('頭頸部', $groupchk8),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('胸腔', $groupchk9),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('心', $groupchk10),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('肺', $groupchk11),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('腹部', $groupchk12),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('四肢', $groupchk13),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('生殖器', $groupchk14),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),
								array (
									'content'	=> array('臀部', $groupchk15),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),			
								array (
									'content'	=> array('醫師醫囑', $groupchk16),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),				
								array (
									'content'	=> array('醫師處方', $groupchk18),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),			
								array (
									'content'	=> array('其他', $groupchk17),
									'cellwidth'	=> array('20%', '80%')
									//'span'	=> array('1', '2')
								),		
							);
					} else {
						$chktablerows = array();
					}
					

					
					/*
					$rowstyle = array(
						"0" => array("font-size" => "14pt", "background" => $bgcolor, "font-weight" => 'bold')
					);
					*/
					
					$this->model_tool_worddoc->startTable(array('font-family' => '標楷體', 'width' => '100%', 'font-size' => '12pt'));
					foreach ($chktablerows as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
					
					$this->model_tool_worddoc->addParagraph('');
					$this->model_tool_worddoc->addParagraph('醫師簽名：');
					
					/*
					if ($childdoctor_info['chk1']<>'') {
						$this->model_tool_worddoc->addParagraph("本日寶寶活動力：".$childdoctor_info['chk1']);
					}
					if ($childdoctor_info['chk2']<>'') {
						$this->model_tool_worddoc->addParagraph("本日寶寶食慾為：".$childdoctor_info['chk2']);
					}
					if (is_array($c3 = unserialize($childdoctor_info['chk3'])) AND !empty($c3)) {
						$text3 = '';
						foreach ($c3 as $k => $data) {
							if ($k+1!=count($c3)) {
								$text3 .= $data.",";
							} else {
								$text3 .= $data;
							}
						}
						$this->model_tool_worddoc->addParagraph("寶寶感冒症狀為：".$text3);
					}
					if (is_array($c4 = unserialize($childdoctor_info['chk4'])) AND !empty($c4)) {
						$text4 = '';
						foreach ($c4 as $k => $data) {
							if ($k+1!=count($c4)) {
								$text4 .= $data.",";
							} else {
								$text4 .= $data;
							}
						}
						$this->model_tool_worddoc->addParagraph("寶寶腸胃炎症狀為：".$text4);
					}
					if (is_array($c5 = unserialize($childdoctor_info['chk5'])) AND !empty($c5)) {
						$text5 = '';
						foreach ($c5 as $k => $data) {
							if ($k+1!=count($c5)) {
								$text5 .= $data.",";
							} else {
								$text5 .= $data;
							}
						}
						$this->model_tool_worddoc->addParagraph("寶寶皮膚有紅疹部位為：".$text5);
					}
					if ($childdoctor_info['chk6']<>'') {
						$this->model_tool_worddoc->addParagraph("寶寶有服藥，藥物為：".$childdoctor_info['chk6']);
					}
					if ($childdoctor_info['supplement']<>'') {
						$this->model_tool_worddoc->addParagraph("特別補充事項：<br />".nl2br($childdoctor_info['supplement']));
					}
					*/
					
					if ($kk+1 <> count($childdoctor2s)) {
							$this->model_tool_worddoc->newPage();
					}

			}
			
			if ($this->request->get['preview']) {
				$this->model_tool_worddoc->setPreview();
				$this->model_tool_worddoc->output();
			} else {
				$this->model_tool_worddoc->output($filename.'.doc');	
			}
			
				
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
	public function memo() {		
		$this->load->language('doctor/childdoctor2');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/child');
		$this->load->model('service/customer_service');
		$this->load->model('doctor/childdoctor2');
		
		$datac = array(
				'sort'	=> 'c.bed_id',
				'filter_date_livein'	=>	date('Y-m-d'),
				'filter_date_leave'	=>	date('Y-m-d')
			);
			
		$childs_info = $this->model_service_child->getChilds($datac);
					
		$titleFormat = array(
								'text-align' 	=> 'center',
								'font-weight' 	=> 'bold',
								'font-family' =>	'標楷體',
								'font-size'		=> '14pt');

			if (!empty($childs_info)) {		
				$this->load->model('tool/worddoc');
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				$filename = "2E小兒科醫師檢查嬰兒紀錄單_備忘錄_".date('Ymd');
								
				$this->model_tool_worddoc->addParagraph("小兒科醫師檢查嬰兒紀錄單", $titleFormat);
				
				$tablerows = array();
				
				foreach ($childs_info as $k => $child) {	
					$pageno = ceil(($k+1)/4);
					$chkdata = '';
					$bodychk = '';
					$result = $this->model_service_child->getChildDataTable($child['customer_child_id']);
					$childdoctor_info = $this->model_doctor_childdoctor2->getChildDoctor2($child['customer_child_id'], $this->request->get['union_id']);
					$bodyrecords = $this->model_service_child->getChildBodyRecord($child['customer_child_id'], date('Y-m-d'));
					
					//print"<pre>";print_r($result);print"</pre>";
					//print"<pre>";print_r($bodyrecords);print"</pre>";
					//print"<pre>";print_r($childdoctor_info);print"</pre>"; exit;

					if (!empty($result)) { 
							$called = ($result['gender'] == "女") ? "女" : "子";
							$childname = ($result['name']=='') ? $result['customer_name']."之".$called : $result['name'];
							
							$rooms = $this->model_service_child->getTransfers($result['customer_id'], 'DESC');
							$lastroom = $rooms[0]['customer_room_name'];
							$doctor_name = (!empty($childdoctor_info)) ? $this->model_service_customer_service->getCustomerServiceName($childdoctor_info['doctor_id']) : '';


							if (!empty($childdoctor_info)) {
								$nar = array(4,5,8,9,11,12,13,14,15,16,17,18,19,21,22,23,26,27,28,29,30,31,32,33,34);
								$cvar = array(
									'活動力：',
									'膚色：',
									'體溫：',
									'體重：',
									'大便：',
									'小便：',
									'餵食：',
									'紅疹：',
									'血管瘤：',
									'其他：',
									'結膜炎：',
									'血管瘤：',
									'鼻淚管阻塞：',
									'耳前息肉：',
									'耳道異常分泌物：',
									'',
									'',
									'',
									'頭部：',
									'斜頸：',
									'',
									'',
									'呼吸音：',
									'腹部： ',
									'腸蠕動聲：',
									'肚臍：',
									'上肢：',
									'下肢：',
									'鎖骨：',
									(!empty($result)) ? $result['gender'] : '',
									'疝氣：',
									'隱睪症：',
									'陰囊水腫：',
									'腹股溝：',
									'紅臀：'
								);
								for ($i=1;$i<=35;$i++) {
									if ($childdoctor_info['chk'.$i.'']) { 
										if (in_array($i, $nar)&&is_array(${"ca".$i} = unserialize($childdoctor_info['chk'.$i.'']))) {
											${"chk".$i} = (!empty(${"ca".$i})) ? $cvar[$i-1] . implode(",", ${"ca".$i}) . "<br />" : "";
										} else {
											${"chk".$i} = ($childdoctor_info['chk'.$i.'']) ? $cvar[$i-1] . $childdoctor_info['chk'.$i.'']."<br />" : "";
										}
									} else {
										${"chk".$i} = '';
									}
								}
							
								$medicine = (!empty($childdoctor_info['medicine'])) ? implode(",", $childdoctor_info['medicine']) . "<br />" : "";
								
								$grpchk = ($childdoctor_info['groupchk']<>'') ? unserialize($childdoctor_info['groupchk']) : array();
								$groupchk1 = (in_array("一般表現", $grpchk)||$chk1.$chk2.$chk3.$chk4.$chk5.$chk6.$chk7=='') ? "正常" : $chk1.$chk2.$chk3.$chk4.$chk5.$chk6.$chk7;
								$groupchk2 = (in_array("皮膚", $grpchk)||$chk8.$chk9.$chk10=='') ? "正常" : $chk8.$chk9.$chk10;
								$groupchk3 = (in_array("眼", $grpchk)||$chk11.$chk12.$chk13=='') ? "正常" : $chk11.$chk12.$chk13;
								$groupchk4 = (in_array("耳", $grpchk)||$chk14.$chk15=='') ? "正常" : $chk14.$chk15;
								$groupchk5 = (in_array("口腔", $grpchk)||$chk16=='') ? "正常" : $chk16;
								$groupchk6 = (in_array("鼻咽喉部", $grpchk)||$chk17=='') ? "正常" : $chk17;
								$groupchk7 = (in_array("喉", $grpchk)||$chk18=='') ? "正常" : $chk18;
								$groupchk8 = (in_array("頭頸部", $grpchk)||$chk19.$chk20=='') ? "正常" : $chk19.$chk20;
								$groupchk9 = (in_array("胸腔", $grpchk)||$chk21=='') ? "正常" : $chk21;
								$groupchk10 = (in_array("心", $grpchk)||$chk22=='') ? "正常" : $chk22;
								$groupchk11 = (in_array("肺", $grpchk)||$chk23=='') ? "正常" : $chk23;
								$groupchk12 = (in_array("腹部", $grpchk)||$chk24.$chk25.$chk26=='') ? "正常" : $chk24.$chk25.$chk26;
								$groupchk13 = (in_array("四肢", $grpchk)||$chk27.$chk28.$chk29=='') ? "正常" : $chk27.$chk28.$chk29;
								$groupchk14 = (in_array("生殖器", $grpchk)||$chk30.$chk31.$chk32.$chk33.$chk34=='') ? "正常" : $chk30.$chk31.$chk32.$chk33.$chk34;
								$groupchk15 = (in_array("臀部", $grpchk)||$chk35=='') ? "正常" : $chk35;
								$groupchk16 = (in_array("醫囑", $grpchk)||$childdoctor_info['prescription']=='') ? "正常" : $childdoctor_info['prescription'];
								$groupchk18 = (in_array("處方", $grpchk)||$medicine=='') ? "正常" : $medicine;
								$groupchk17 = (in_array("其他", $grpchk)||$childdoctor_info['supplement']=='') ? "正常" : $childdoctor_info['supplement'];

								$chkdata = $doctor_name . "<br />";
								$chkdata .= ($groupchk1<>'正常') ? "一般表現<br />" . $groupchk1. "<br />" : '';
								$chkdata .= ($groupchk2<>'正常') ? "皮膚<br />" . $groupchk2. "<br />" : '';
								$chkdata .= ($groupchk3<>'正常') ? "眼<br />" . $groupchk3. "<br />" : '';
								$chkdata .= ($groupchk4<>'正常') ? "耳<br />" . $groupchk4. "<br />" : '';
								$chkdata .= ($groupchk5<>'正常') ? "口腔<br />" . $groupchk5. "<br />" : '';
								$chkdata .= ($groupchk6<>'正常') ? "鼻咽喉部<br />" . $groupchk6. "<br />" : '';
								$chkdata .= ($groupchk7<>'正常') ? "喉<br />" . $groupchk7. "<br />" : '';
								$chkdata .= ($groupchk8<>'正常') ? "頭頸部<br />" . $groupchk8. "<br />" : '';
								$chkdata .= ($groupchk9<>'正常') ? "胸腔<br />" . $groupchk9. "<br />" : '';
								$chkdata .= ($groupchk10<>'正常') ? "心<br />" . $groupchk10. "<br />" : '';
								$chkdata .= ($groupchk11<>'正常') ? "肺<br />" . $groupchk11. "<br />" : '';
								$chkdata .= ($groupchk12<>'正常') ? "腹部<br />" . $groupchk12. "<br />" : '';
								$chkdata .= ($groupchk13<>'正常') ? "四肢<br />" . $groupchk13. "<br />" : '';
								$chkdata .= ($groupchk14<>'正常') ? "生殖器<br />" . $groupchk14. "<br />" : '';
								$chkdata .= ($groupchk15<>'正常') ? "臀部<br />" . $groupchk15. "<br />" : '';
								$chkdata .= ($groupchk16<>'正常') ? "醫師醫囑<br />" . $groupchk16. "<br />" : '';
								$chkdata .= ($groupchk18<>'正常') ? "醫師處方<br />" . $groupchk18. "<br />" : '';
								$chkdata .= ($groupchk17<>'正常') ? "其他<br />" . $groupchk17. "<br />" : '';
								$chkdata .= ($groupchk1=='正常'&&$groupchk2=='正常'&&$groupchk3=='正常'&&$groupchk4=='正常'&&$groupchk5=='正常'&&$groupchk6=='正常'&&$groupchk7=='正常'&&$groupchk8=='正常'&&$groupchk9=='正常'&&$groupchk10=='正常'&&$groupchk11=='正常'&&$groupchk12=='正常'&&$groupchk13=='正常'&&$groupchk14=='正常'&&$groupchk15=='正常'&&$groupchk16=='正常'&&$groupchk17=='正常'&&$groupchk18=='正常') ? "皆正常" : "";
							} else {
								$chkdata = "前次未檢測";
							}
						
							//身體數據
							$jaundice = (!empty($bodyrecords)&&$bodyrecords['jaundice']&&$bodyrecords['jaundice_chkdate']) ? '黃疸：'.$bodyrecords['jaundice'] . ' (' . $bodyrecords['jaundice_chkdate'] . ')<br />' : '';
							$temperature = (!empty($bodyrecords)) ? '體溫：'.$bodyrecords['temperature'] .' ℃<br />' : '';
							$pregnancy_weeks = '週數：' . $result['pregnancy_weeks'] . '<br />';
							$gender = '性別：'. $result['gender'] . '<br />';
							$childbirth_method = '生產方式：'. $result['childbirth_method'] .'<br />';
							$birthdate = '出生日期：'. $result['birthdate'] . '<br />';
							$birthweight = '出生體重：' . $result['birthweight'] . '<br />';
							$nowweight = (!empty($bodyrecords)) ? '目前體重：'.$bodyrecords['weight']. '公克' : '';
							$weight_down = ' (下降率：' . ( ($bodyrecords['weight'] && $result['birthweight'] > $bodyrecords['weight'])  ? round(($result['birthweight']-$bodyrecords['weight'])/$result['birthweight']*100, 2) : 0 ) . ' %)';

							$bodychk = $gender.$pregnancy_weeks.$childbirth_method.$jaundice.$temperature.$birthdate.$birthweight.$nowweight.$weight_down;

							$tablerows[$pageno][] = array(
									'content' => array($childname.'(性別：'.$result['gender'].')'.'<br />'.$result['customer_name'].'(房號：'.$lastroom.')', $bodychk, '', $chkdata, '')
							);
					}

			}
			

			foreach ($tablerows as $pageno => $prow) {
				$this->model_tool_worddoc->startTable(array('font-family' => '標楷體', 'width' => '100%', 'font-size' => '11pt'));
				$this->model_tool_worddoc->addTableRow(								
								array (
									'content' => array('嬰兒資料', '身體數據', '護理摘要', '前次檢查紀錄', '本次'.date('Y-m-d').'檢查紀錄' ), 
									'cellwidth'	=> array('15%', '15%' , '18%', '25%', '27%')
									//'span' => array()
								)
				);
				
				foreach ($prow as $row) {
					$this->model_tool_worddoc->addTableRow($row);
				}
				
				$this->model_tool_worddoc->endTable();
				
				if ($pageno <> count($tablerows)) {
					$this->model_tool_worddoc->newPage();
				}
			}
			
			//$this->model_tool_worddoc->isDebugging = true;
			$this->model_tool_worddoc->output($filename.'.doc');	
				
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
  	public function store() {
		$this->load->language('doctor/childdoctor2');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('doctor/childdoctor2');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$union_id = isset($this->request->get['union_id']) ? $this->request->get['union_id'] : 0;
      	  	$newunionid = $this->model_doctor_childdoctor2->addChildDoctor2($this->request->post, $union_id);

			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['union_id'])) {
				$url .= '&union_id=' . $this->request->get['union_id'];
			} elseif (isset($newunionid)) {
				$url .= '&union_id=' . $newunionid;
			}
			
			if (isset($this->request->post['tab_id'])) {
				$url .= '&tab_id=' . $this->request->post['tab_id'];
			}
			
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}	
					
/*					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
*/			
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
			
/*			
			if (isset($this->request->get['filter_customer_id'])) {
				$url .= '&filter_customer_id=' . $this->request->get['filter_customer_id'];
			}
*/			
							
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('doctor/childdoctor2/update', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			//$this->redirect($this->url->link('doctor/childdoctor2/insert', 'token=' . $this->session->data['token'] . '&customer_child_id='. $this->request->get['customer_child_id'] .  $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
	
  	public function insert() {
		//$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.css');
		//$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.print.css','','print');
		//$this->document->addScript('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.min.js');
		$this->document->addStyle('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.css');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mousewheel.min.js');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.min.js');		
		$this->load->language('doctor/childdoctor2');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('doctor/childdoctor2');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_doctor_childdoctor2->addChildDoctor($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
/*
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
*/			
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
			
/*			
			if (isset($this->request->get['filter_customer_id'])) {
				$url .= '&filter_customer_id=' . $this->request->get['filter_customer_id'];
			}
*/			
							
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->document->addStyle('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.css');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mousewheel.min.js');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.min.js');		
		
		$this->load->language('doctor/childdoctor2');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('doctor/childdoctor2');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_doctor_childdoctor2->editChildDoctor($this->request->get['customer_child_doctor2_id'], $this->request->post);
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
					
/*					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
*/			
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
						
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('doctor/childdoctor2');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('doctor/childdoctor2');
			
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $union_id) {
				$this->model_doctor_childdoctor2->deleteChildDoctor2($union_id);
			}
			
					
			$this->session->data['success'] = $this->language->get('text_del_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
					
/*					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
*/			
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
						
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getForm();
  	}  
    
  	private function getList() {	
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

/*		
		if (isset($this->request->get['filter_customer_name'])) {
			$filter_customer_name = $this->request->get['filter_customer_name'];
		} else {
			$filter_customer_name = null;
		}		
*/		
		
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}		
	
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'u.date_added'; 
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			//$order = 'ASC';
			$order = 'DESC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
						
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
/*		
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
					
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
*/		
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
						
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->data['insert'] = $this->url->link('doctor/childdoctor2/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('doctor/childdoctor2/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['childs'] = array();

		$data = array(
			'filter_name'              => $filter_name, 
//			'filter_customer_name'            => $filter_customer_name, 
//			'filter_status'            => $filter_status, 
//			'filter_birthdate'        => $filter_birthdate,
			'filter_date_added'        => $filter_date_added,
//			'filter_customer_service_id' => $filter_customer_service_id, 
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                    => $this->config->get('config_admin_limit')
		);
		
		$this->load->model('service/child');
		//$child_total = $this->model_service_child->getTotalChilds($data);
		$form_total = $this->model_doctor_childdoctor2->getTotalChildDoctor2Unions($data);
	
		//$results = $this->model_service_child->getChilds($data);
		$results = $this->model_doctor_childdoctor2->getChildDoctor2Unions($data);
 
    	foreach ($results as $result) {
//		$drform = $this->model_doctor_childdoctor2->getChildDoctor2s($result['customer_child_id']);
			$drforms = $this->model_doctor_childdoctor2->getChildDoctor2UnionDatas($result['union_id']);
			
			$action = array();
		
			$action[] = array(
				'text' => $this->language->get('text_manage'),
				'href' => $this->url->link('doctor/childdoctor2/update', 'token=' . $this->session->data['token'] . '&union_id=' . $result['union_id'] . $url, 'SSL')
			);
				
			if (!empty($drforms)) {
				$action[] = array(
					'text' => '列印簽名',
					'href' => $this->url->link('doctor/childdoctor2/word', 'token=' . $this->session->data['token'] . '&union_id=' . $result['union_id'] . $url, 'SSL')
				);
				
				$action[] = array(
					'text' => '醫師診斷參考',
					'href' => $this->url->link('doctor/childdoctor2/memo', 'token=' . $this->session->data['token'] . '&union_id=' . $result['union_id'] . $url, 'SSL')
				);
			} 
			
			$childformdata = '';
			foreach ($drforms as $k => $drform) {
				$childdata = $this->model_service_child->getChild($drform['customer_child_id']);
				$roominfo = $this->model_service_child->getTransfers($childdata['customer_id'], "DESC", 0, 1);
				$last_transfer = (!empty($roominfo)) ? $roominfo[0]['customer_room_name'] : "尚未指定房間" ;
				$childformdata .= $childdata['name'] . "[". $childdata['customer_name'] . $last_transfer .  (($k+1 == count($drforms)) ? "] " : "], ");
			}
			
			
			$this->data['childs'][] = array(
				'union_id'    => $result['union_id'],
				//'customer_child_id'    => $result['customer_child_id'],
				'doctor_id'    => $result['doctor_id'],
				'name'           => $result['name'],
				//'customer_id'           => $result['customer_id'],
				//'customer_name'           => $result['customer_name'],
				//'customer_room'	=> $last_transfer,
				//'status'         => ($result['status'] ? $this->language->get('text_livein') : $this->language->get('text_leave')),
				//'birthdate'     => date($this->language->get('date_format_short'), strtotime($result['birthdate'])),
				//'date_added'     => ($result['date_added']=='0000-00-00 00:00:00') ? date($this->language->get('date_format_short'), strtotime($result['customer_date_added'])) : date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'date_added'     => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'child_data'	=> $childformdata . "<br />共" . count($drforms) . "筆",
				//'customer_service' => $result['customer_service'],
				'selected'       => isset($this->request->post['selected']) && in_array($result['union_id'], $this->request->post['selected']),
				'action'         => $action
			);
		}	
				
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_livein'] = $this->language->get('text_livein');
		$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');	
		$this->data['text_select'] = $this->language->get('text_select');	
		$this->data['text_default'] = $this->language->get('text_default');		
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		//$this->data['column_customer_name'] = $this->language->get('column_customer_name');
		//$this->data['column_customer_room'] = $this->language->get('column_customer_room');
		$this->data['column_child_data'] = $this->language->get('column_child_data');
		//$this->data['column_status'] = $this->language->get('column_status');
		//$this->data['column_birthdate'] = $this->language->get('column_birthdate');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		//$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		//$this->data['column_customer_service'] = $this->language->get('column_customer_service');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');
		$this->data['button_reset_filter'] = $this->language->get('button_reset_filter');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
	
/*	
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
				
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
*/

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
			
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . '&sort=uu.name' . $url, 'SSL');
		//$this->data['sort_customer_name'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . '&sort=customer_name' . $url, 'SSL');
		//$this->data['sort_birthdate'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . '&sort=c.birthdate' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . '&sort=u.date_added' . $url, 'SSL');
		//$this->data['sort_customer_service'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=customer_service' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
/*
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
				
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
*/

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		//$pagination->total = $child_total;
		$pagination->total = $form_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		//$this->data['filter_customer_name'] = $filter_customer_name;
		//$this->data['filter_status'] = $filter_status;
		//$this->data['filter_birthdate'] = $filter_birthdate;
		$this->data['filter_date_added'] = $filter_date_added;
		//$this->data['filter_customer_service_id'] = $filter_customer_service_id;
		
		//$this->load->model('service/customer_service');
    	//$this->data['customer_services'] = $this->model_service_customer_service->getCustomerServices();
				
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'doctor/childdoctor2_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
		$this->document->addStyle('view/javascript/jquery/colorbox/colorbox.css');
		$this->document->addScript('view/javascript/jquery/colorbox/jquery.colorbox-min.js');
 
    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_livein'] = $this->language->get('text_livein');
    	$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_add_blacklist'] = $this->language->get('text_add_blacklist');
		$this->data['text_remove_blacklist'] = $this->language->get('text_remove_blacklist');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		
		$this->data['column_total'] = $this->language->get('column_total');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		//$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['entry_idnumber'] = $this->language->get('entry_idnumber');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_birthdate'] = $this->language->get('entry_birthdate');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_mobile'] = $this->language->get('entry_mobile');
		$this->data['entry_customer_service'] = $this->language->get('entry_customer_service');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_date_leave'] = $this->language->get('entry_date_leave');
		$this->data['entry_default'] = $this->language->get('entry_default');
		$this->data['entry_customer_room_id'] = $this->language->get('entry_customer_room_id');
		$this->data['entry_customer_room'] = $this->language->get('entry_customer_room');
 		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_spouse_name'] = $this->language->get('entry_spouse_name');
		$this->data['entry_childbirth_method'] = $this->language->get('entry_childbirth_method');
		$this->data['entry_childbirth_hospital'] = $this->language->get('entry_childbirth_hospital');
		$this->data['entry_childbirth_doctor'] = $this->language->get('entry_childbirth_doctor');
		$this->data['entry_pregnancy_weeks'] = $this->language->get('entry_pregnancy_weeks');
		$this->data['entry_child_count'] = $this->language->get('entry_child_count');
		$this->data['entry_birthweight'] = $this->language->get('entry_birthweight');
		$this->data['entry_birthhead'] = $this->language->get('entry_birthhead');
		$this->data['entry_birthlength'] = $this->language->get('entry_birthlength');
		$this->data['entry_inweight'] = $this->language->get('entry_inweight');
		$this->data['entry_b_streptococcus_check'] = $this->language->get('entry_b_streptococcus_check');
		$this->data['entry_apgar_score'] = $this->language->get('entry_apgar_score');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
 
		$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
		//$this->data['button_add_image'] = $this->language->get('button_add_image');
		$this->data['button_add_childdoctor2'] = $this->language->get('button_add_childdoctor2');
		//$this->data['button_add_contact'] = $this->language->get('button_add_contact');
		$this->data['button_add_child'] = $this->language->get('button_add_child');
		$this->data['button_add_transfer'] = $this->language->get('button_add_transfer');
		$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
    	$this->data['button_remove'] = $this->language->get('button_remove');
	
		//$this->data['tab_general'] = $this->language->get('tab_general');
		//$this->data['tab_contact'] = $this->language->get('tab_contact');
		//$this->data['tab_transfer'] = $this->language->get('tab_transfer');
		//$this->data['tab_moredata'] = $this->language->get('tab_moredata');
		$this->data['tab_datatable'] = $this->language->get('tab_datatable');
		$this->data['tab_childdoctor2'] = $this->language->get('tab_childdoctor2');
		$this->data['tab_childdoctor2form'] = $this->language->get('tab_childdoctor2form');

		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->request->get['union_id'])) {
			$this->data['union_id'] = $this->request->get['union_id'];
		} else {
			$this->data['union_id'] = 0;
		}
		
		if (isset($this->request->get['customer_child_id'])) {
			$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
		} else {
			$this->data['customer_child_id'] = 0;
		}
		
		if (isset($this->request->get['customer_child_doctor2_id'])) {
			$this->data['customer_child_doctor2_id'] = $this->request->get['customer_child_doctor2_id'];
		} else {
			$this->data['customer_child_doctor2_id'] = 0;
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		/*
 		if (isset($this->error['idnumber'])) {
			$this->data['error_idnumber'] = $this->error['idnumber'];
		} else {
			$this->data['error_idnumber'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}
				
 		if (isset($this->error['telephone'])) {
			$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}
		
		if (isset($this->error['mobile'])) {
			$this->data['error_mobile'] = $this->error['mobile'];
		} else {
			$this->data['error_mobile'] = '';
		}
		
		if (isset($this->error['contact_name'])) {
			$this->data['error_contact_name'] = $this->error['contact_name'];
		} else {
			$this->data['error_contact_name'] = '';
		}
			
		if (isset($this->error['contact_telephone'])) {
			$this->data['error_contact_telephone'] = $this->error['contact_telephone'];
		} else {
			$this->data['error_contact_telephone'] = '';
		}
		
		if (isset($this->error['contact_relationship'])) {
			$this->data['error_contact_relationship'] = $this->error['contact_relationship'];
		} else {
			$this->data['error_contact_relationship'] = '';
		}
		
		if (isset($this->error['child_name'])) {
			$this->data['error_child_name'] = $this->error['child_name'];
		} else {
			$this->data['error_child_name'] = '';
		}
		
		if (isset($this->error['child_birthdate'])) {
			$this->data['error_child_birthdate'] = $this->error['child_birthdate'];
		} else {
			$this->data['error_child_birthdate'] = '';
		}
		*/
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
/*		
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
		
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
*/		
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
						
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);

		//if (!isset($this->request->get['union_id'])) { $this->redirect($this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL')); }
		
		if (!isset($this->request->get['union_id'])) { 
			$this->data['action'] = $this->url->link('doctor/childdoctor2/store', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$union_id = 0;
		} else {
			$this->data['action'] = $this->url->link('doctor/childdoctor2/store', 'token=' . $this->session->data['token'] . '&union_id=' . $this->request->get['union_id'] . $url, 'SSL');
			$union_id = $this->request->get['union_id'];
		}

    	$this->data['cancel'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['print'] = (isset($this->request->get['union_id'])) ? $this->url->link('doctor/childdoctor2/word', 'token=' . $this->session->data['token'] . '&union_id=' . $this->request->get['union_id'] . $url, 'SSL') : '';
		$this->data['preview'] = (isset($this->request->get['union_id'])) ? $this->url->link('doctor/childdoctor2/word', 'token=' . $this->session->data['token'] . '&union_id=' . $this->request->get['union_id'] .'&preview=1' . $url, 'SSL') : '';

		if ($union_id) {
			$childdoctor2union = $this->model_doctor_childdoctor2->getChildDoctor2Union($union_id);
		} else {
			$childdoctor2union = array();
		}

		$this->load->model('service/child');

    	//if (isset($this->request->get['customer_child_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {		
			//$this->load->model('service/child');
			//$datatable_info = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
    	//}
		


#!#####

		if (isset($this->request->post['childdoctor2form'])) { 
      		$this->data['childdoctor2forms'] = $this->request->post['childdoctor2form'];
		} elseif (is_array($childdoctor2union)) {
			$this->data['childdoctor2forms'] = $this->model_doctor_childdoctor2->getChildDoctor2UnionDatas($union_id);
			$childid = array();
			foreach ($this->data['childdoctor2forms'] as $c2form) {
				$childid[] = $c2form['customer_child_id'];
				$this->data['datatables'][] = $this->model_service_child->getChildDataTable($c2form['customer_child_id']);
				//$this->data['bodyrecords'][] = $this->model_service_child->getChildBodyRecord($c2form['customer_child_id'], (!empty($childdoctor2union)) ? $childdoctor2union['date_added'] : date('Y-m-d'));

				$this->data['bodyrecords'][] = array(
					'temperature'	=> $c2form['temperature'],
					'temperature_chkdate'	=> $c2form['temperature_chkdate'],
					'jaundice'	=> $c2form['jaundice'],
					'jaundice_chkdate'	=> $c2form['jaundice_chkdate'],
					'weight'	=> $c2form['weight'],
					'weight_down'	=> $c2form['weight_down'],
					'weight_chkdate'	=> $c2form['weight_chkdate']
				);
				
			}
			
			$datac = array(
				'sort'	=> 'c.bed_id',
				'filter_date_livein'	=>	(!empty($childdoctor2union)) ? $childdoctor2union['date_added'] : date('Y-m-d'),
				'filter_date_leave'	=>	(!empty($childdoctor2union)) ? $childdoctor2union['date_added'] : date('Y-m-d')
			);
			
			$childs_info = $this->model_service_child->getChilds($datac);
			
			//$thischilddoctor2 = array();
			
			foreach ($childs_info as $child ) {
				//$thischilddoctor2 = $this->model_doctor_childdoctor2->getChildDoctor2($child['customer_child_id'], $union_id);
				
				if (!in_array($child['customer_child_id'], $childid)) {
					$this->data['childdoctor2forms'][] = array(
							'customer_child_doctor2_id' => '',
							'customer_child_id' => $child['customer_child_id'],
							'date_added' => (!empty($childdoctor2union)) ? $childdoctor2union['date_added'] : date('Y-m-d'),
							'date_modify' => '',
							'union_id' => ($union_id) ? $union_id : '',
							'chk1' => '',
							'chk2' => '',
							'chk3' => '',
							'chk4' => '',
							'chk5' => '',
							'chk6' => '',
							'chk7' => '',
							'chk8' => '',
							'chk9' => '',
							'chk10' => '',
							'chk11' => '',
							'chk12' => '',
							'chk13' => '',
							'chk14' => '',
							'chk15' => '',
							'chk16' => '',
							'chk17' => '',
							'chk18' => '',
							'chk19' => '',
							'chk20' => '',
							'chk21' => '',
							'chk22' => '',
							'chk23' => '',
							'chk24' => '',
							'chk25' => '',
							'chk26' => '',
							'chk27' => '',
							'chk28' => '',
							'chk29' => '',
							'chk30' => '',
							'chk31' => '',
							'chk32' => '',
							'chk33' => '',
							'chk34' => '',
							'chk35' => '',
							'groupchk' => '',
							'prescription' => '',
							'medicine' => '',
							'supplement' => '',
							'child_name' => $child['name'],
							'child_gender' => $child['gender'],
							'doctor_id' => ($this->user->getGroupId() == '4') ? $this->user->getId() : (isset($childdoctor2union['doctor_id'])) ? $childdoctor2union['doctor_id'] : 0
					);

					$this->data['datatables'][] = $this->model_service_child->getChildDataTable($child['customer_child_id']);
					$this->data['bodyrecords'][] = $this->model_service_child->getChildBodyRecord($child['customer_child_id'], (!empty($childdoctor2union)) ? $childdoctor2union['date_added'] : date('Y-m-d'));
							
				} 
			}
		} else {
			$this->data['childdoctor2forms'] = array();
    	}	

		
					foreach ($this->data['datatables'] as $nn => $datatable):
							$rooms = $this->model_service_child->getTransfers($datatable['customer_id']);
							$lastrooms = $this->model_service_child->getTransfers($datatable['customer_id'], 'DESC', 0, 1);
							if (!empty($rooms)) {
									if (count($rooms) == "1") {
										$this->data['datatables'][$nn]['customer_firstroom'] = $rooms[0]['customer_room_name'];
										$this->data['datatables'][$nn]['customer_lastroom'] = $lastrooms[0]['customer_room_name'];
										$this->data['datatables'][$nn]['customer_transfers'] = array();
									} else {
										$this->data['datatables'][$nn]['customer_firstroom'] = $rooms[0]['customer_room_name'];
										$this->data['datatables'][$nn]['customer_lastroom'] = $lastrooms[0]['customer_room_name'];
										for ($i=0;$i<count($rooms)-1;$i++) {
											$this->data['datatables'][$nn]['customer_transfers'][$i] = $rooms[$i+1];
										}
									}
							 } else {
									$this->data['datatables'][$nn]['customer_firstroom'] = '尚未指定房間';
									$this->data['datatables'][$nn]['customer_lastroom'] = '';
									$this->data['datatables'][$nn]['customer_transfers'] = array();
							}
							
							$this->data['bodyrecords'][$nn]['weight_down'] = ($this->data['bodyrecords'][$nn]['weight'] && $datatable['birthweight'] > $this->data['bodyrecords'][$nn]['weight'])  ? round(($datatable['birthweight']-$this->data['bodyrecords'][$nn]['weight'])/$datatable['birthweight']*100, 2) : 0 ;
							
					endforeach;
		
		//print_r(	$this->data['bodyrecords']);
		//print"<pre>";print_r($this->data['childdoctor2forms']);print"</pre>";
		
		/*
		if (isset($this->request->post['childdoctor2form'])) { 
      		$this->data['childdoctor2forms'] = $this->request->post['childdoctor2form'];
		} elseif (!empty($this->request->get['customer_child_id'])) {
			$this->data['childdoctor2forms'] = $this->model_doctor_childdoctor2->getChildDoctor2s($this->request->get['customer_child_id']);
		} else {
			$this->data['childdoctor2forms'] = array();
    	}	
		*/
	
	
	/*
		$this->load->model('service/child');
		if (isset($this->request->get['customer_child_id'])) {
      		$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
			$this->data['child_name'] = $this->model_service_child->getChildName($this->request->get['customer_child_id']);
			$this->data['child_gender'] = $this->model_service_child->getChildGender($this->request->get['customer_child_id']);
    	} elseif (!empty($datatable_info)) { 
			$this->data['customer_child_id'] = $datatable_info['customer_child_id'];
			$this->data['child_name'] = $this->model_service_child->getChildName($datatable_info['customer_child_id']);
			$this->data['child_gender'] = $this->model_service_child->getChildGender($datatable_info['customer_child_id']);
		} else {
      		$this->data['customer_child_id'] = '';
			$this->data['child_name'] = '';
			$this->data['child_gender'] = '';
    	}	
		*/
		
		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => 4);
		$this->data['doctors'] = $this->model_service_customer_service->getCustomerServices($servary);

		/*
		if (isset($this->request->post['doctor_id'])) {
      		$this->data['doctor_id'] = $this->request->post['doctor_id'];
    	} elseif (!empty($child_info)) { 
			$this->data['doctor_id'] = $child_info['doctor_id'];
		} else {
      		$this->data['doctor_id'] = 0;
    	}	
		*/
		
		$this->data['logged_id'] = ($this->user->getGroupId() == '4') ? $this->user->getId() : 0;
		
		$nar = array(4,5,8,9,11,12,13,14,15,16,17,18,19,21,22,23,26,27,28,29,30,31,32,33,34);
		for ($i=1;$i<=35;$i++) {
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($child_info)) { 
					$this->data['chk'.$i.''] = $child_info['chk'.$i.''];
				} else {
					if (in_array($i, $nar)) {
						$this->data['chk'.$i.''] = array();
					} else {
						$this->data['chk'.$i.''] = '';
					}
				}
		}
		

#!#####
/*
		if (!empty($datatable_info)) {
			$rooms = $this->model_service_child->getTransfers($datatable_info['customer_id']);
			
			 if (!empty($rooms)) {
				if (count($rooms) == "1") {
					$this->data['customer_firstroom'] = $rooms[0]['customer_room_name'];
					$this->data['customer_transfers'] = array();
				} else {
					$this->data['customer_firstroom'] = $rooms[0]['customer_room_name'];
					for ($i=0;$i<count($rooms)-1;$i++) {
						$this->data['customer_transfers'][$i] = $rooms[$i+1];
					}
				}
			 } else {
				$this->data['customer_firstroom'] = '尚未指定房間';
				$this->data['customer_transfers'] = array();
			 }
		}
		
		if (isset($this->request->post['birthdate'])) {
      		$this->data['birthdate'] = $this->request->post['birthdate'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthdate'] = $datatable_info['birthdate'];
		} else {
      		$this->data['birthdate'] = '';
    	}		
		
		if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($datatable_info)) { 
			$called = ($datatable_info['gender'] == "女") ? "女" : "子";
			$this->data['name'] = (($datatable_info['name']!='')? $datatable_info['name'] : $datatable_info['customer_name']."之".$called);
		} else {
      		$this->data['name'] = '';
		}
		
		if (isset($this->request->post['b_streptococcus_check'])) {
      		$this->data['b_streptococcus_check'] = $this->request->post['b_streptococcus_check'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['b_streptococcus_check'] = $datatable_info['b_streptococcus_check'];
		} else {
      		$this->data['b_streptococcus_check'] = '';
		}
		
		if (isset($this->request->post['apgar_score_1'])) {
      		$this->data['apgar_score_1'] = $this->request->post['apgar_score_1'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['apgar_score_1'] = $datatable_info['apgar_score_1'];
		} else {
      		$this->data['apgar_score_1'] = '';
		}
		
		if (isset($this->request->post['apgar_score_5'])) {
      		$this->data['apgar_score_5'] = $this->request->post['apgar_score_5'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['apgar_score_5'] = $datatable_info['apgar_score_5'];
		} else {
      		$this->data['apgar_score_5'] = '';
		}
		
		if (isset($this->request->post['birthweight'])) {
      		$this->data['birthweight'] = $this->request->post['birthweight'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthweight'] = $datatable_info['birthweight'];
		} else {
      		$this->data['birthweight'] = '';
		}
		
		if (isset($this->request->post['birthhead'])) {
      		$this->data['birthhead'] = $this->request->post['birthhead'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthhead'] = $datatable_info['birthhead'];
		} else {
      		$this->data['birthhead'] = '';
		}
		
		if (isset($this->request->post['birthlength'])) {
      		$this->data['birthlength'] = $this->request->post['birthlength'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthlength'] = $datatable_info['birthlength'];
		} else {
      		$this->data['birthlength'] = '';
		}
		
		if (isset($this->request->post['inweight'])) {
      		$this->data['inweight'] = $this->request->post['inweight'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['inweight'] = $datatable_info['inweight'];
		} else {
      		$this->data['inweight'] = '';
		}

		if (isset($this->request->post['customer_name'])) {
      		$this->data['customer_name'] = $this->request->post['customer_name'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['customer_name'] = $datatable_info['customer_name'];
		} else {
      		$this->data['customer_name'] = '';
		}
		
		if (isset($this->request->post['spouse_name'])) {
      		$this->data['spouse_name'] = $this->request->post['spouse_name'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['spouse_name'] = $datatable_info['spouse_name'];
		} else {
      		$this->data['spouse_name'] = '';
		}
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['date_added'] = $datatable_info['date_added'];
		} else {
      		$this->data['date_added'] = '';
    	}
		
		if (isset($this->request->post['date_leave'])) {
      		$this->data['date_leave'] = $this->request->post['date_leave'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['date_leave'] = $datatable_info['date_leave'];
		} else {
      		$this->data['date_leave'] = '';
    	}
		
		if (isset($this->request->post['childbirth_method'])) {
      		$this->data['childbirth_method'] = $this->request->post['childbirth_method'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['childbirth_method'] = $datatable_info['childbirth_method'];
		} else {
      		$this->data['childbirth_method'] = '';
    	}

		if (isset($this->request->post['childbirth_hospital'])) {
      		$this->data['childbirth_hospital'] = $this->request->post['childbirth_hospital'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['childbirth_hospital'] = $datatable_info['childbirth_hospital'];
		} else {
      		$this->data['childbirth_hospital'] = '';
    	}
		
		if (isset($this->request->post['childbirth_doctor'])) {
      		$this->data['childbirth_doctor'] = $this->request->post['childbirth_doctor'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['childbirth_doctor'] = $datatable_info['childbirth_doctor'];
		} else {
      		$this->data['childbirth_doctor'] = '';
    	}
		
		if (isset($this->request->post['pregnancy_weeks'])) {
      		$this->data['pregnancy_weeks'] = $this->request->post['pregnancy_weeks'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['pregnancy_weeks'] = $datatable_info['pregnancy_weeks'];
		} else {
      		$this->data['pregnancy_weeks'] = '';
    	}
		
		if (isset($this->request->post['child_count_g'])) {
      		$this->data['child_count_g'] = $this->request->post['child_count_g'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['child_count_g'] = $datatable_info['child_count_g'];
		} else {
      		$this->data['child_count_g'] = '';
    	}
		
		if (isset($this->request->post['child_count_p'])) {
      		$this->data['child_count_p'] = $this->request->post['child_count_p'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['child_count_p'] = $datatable_info['child_count_p'];
		} else {
      		$this->data['child_count_p'] = '';
    	}
*/		
		


/*
		if (isset($this->request->post['address'])) {
      		$this->data['address'] = $this->request->post['address'];
    	} elseif (!empty($customer_info)) { 
			$this->data['address'] = $customer_info['address'];
		} else {
      		$this->data['address'] = '';
    	}

    	if (isset($this->request->post['telephone'])) {
      		$this->data['telephone'] = $this->request->post['telephone'];
    	} elseif (!empty($customer_info)) { 
			$this->data['telephone'] = $customer_info['telephone'];
		} else {
      		$this->data['telephone'] = '';
    	}

		if (isset($this->request->post['mobile'])) {
      		$this->data['mobile'] = $this->request->post['mobile'];
    	} elseif (!empty($customer_info)) { 
			$this->data['mobile'] = $customer_info['mobile'];
		} else {
      		$this->data['mobile'] = '';
    	}
		

		
		if (isset($this->request->post['degree'])) {
      		$this->data['degree'] = $this->request->post['degree'];
    	} elseif (!empty($customer_info)) { 
			$this->data['degree'] = $customer_info['degree'];
		} else {
      		$this->data['degree'] = '';
    	}
		
		if (isset($this->request->post['profession'])) {
      		$this->data['profession'] = $this->request->post['profession'];
    	} elseif (!empty($customer_info)) { 
			$this->data['profession'] = $customer_info['profession'];
		} else {
      		$this->data['profession'] = '';
    	}
		
		if (isset($this->request->post['language'])) {
      		$this->data['language'] = $this->request->post['language'];
    	} elseif (!empty($customer_info)) { 
			$this->data['language'] = $customer_info['language'];
		} else {
      		$this->data['language'] = '';
    	}
		
		if (isset($this->request->post['evacuation_hospital'])) {
      		$this->data['evacuation_hospital'] = $this->request->post['evacuation_hospital'];
    	} elseif (!empty($customer_info)) { 
			$this->data['evacuation_hospital'] = $customer_info['evacuation_hospital'];
		} else {
      		$this->data['evacuation_hospital'] = '';
    	}
		
		if (isset($this->request->post['spouse_name'])) {
      		$this->data['spouse_name'] = $this->request->post['spouse_name'];
    	} elseif (!empty($customer_info)) { 
			$this->data['spouse_name'] = $customer_info['spouse_name'];
		} else {
      		$this->data['spouse_name'] = '';
    	}
		
		if (isset($this->request->post['childbirth_method'])) {
      		$this->data['childbirth_method'] = $this->request->post['childbirth_method'];
    	} elseif (!empty($customer_info)) { 
			$this->data['childbirth_method'] = $customer_info['childbirth_method'];
		} else {
      		$this->data['childbirth_method'] = '';
    	}
		
		if (isset($this->request->post['childbirth_hospital'])) {
			$this->data['childbirth_hospital'] = $this->request->post['childbirth_hospital'];
    	} elseif (!empty($customer_info)) { 
			$this->data['childbirth_hospital'] = $customer_info['childbirth_hospital'];
		} else {
      		$this->data['childbirth_hospital'] = '';
    	}
		
		if (isset($this->request->post['childbirth_doctor'])) {
      		$this->data['childbirth_doctor'] = $this->request->post['childbirth_doctor'];
    	} elseif (!empty($customer_info)) { 
			$this->data['childbirth_doctor'] = $customer_info['childbirth_doctor'];
		} else {
      		$this->data['childbirth_doctor'] = '';
    	}
		
		if (isset($this->request->post['pregnancy_weeks'])) {
      		$this->data['pregnancy_weeks'] = $this->request->post['pregnancy_weeks'];
    	} elseif (!empty($customer_info)) { 
			$this->data['pregnancy_weeks'] = $customer_info['pregnancy_weeks'];
		} else {
      		$this->data['pregnancy_weeks'] = '';
    	}
		
		if (isset($this->request->post['child_count_g'])) {
      		$this->data['child_count_g'] = $this->request->post['child_count_g'];
    	} elseif (!empty($customer_info)) { 
			$this->data['child_count_g'] = $customer_info['child_count_g'];
		} else {
      		$this->data['child_count_g'] = '';
    	}
		
		if (isset($this->request->post['child_count_p'])) {
      		$this->data['child_count_p'] = $this->request->post['child_count_p'];
    	} elseif (!empty($customer_info)) { 
			$this->data['child_count_p'] = $customer_info['child_count_p'];
		} else {
      		$this->data['child_count_p'] = '';
    	}
		
		$this->load->model('service/customer_service');
			
		$this->data['customer_services'] = $this->model_service_customer_service->getCustomerServices();

    	if (isset($this->request->post['customer_service_id'])) {
      		$this->data['customer_service_id'] = $this->request->post['customer_service_id'];
    	} elseif (!empty($customer_info)) { 
			$this->data['customer_service_id'] = $customer_info['customer_service_id'];
		} else {
      		$this->data['customer_service_id'] = $this->config->get('config_customer_service_id');
    	}
		
    	if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($customer_info)) { 
			$this->data['status'] = $customer_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}
		
		if (isset($this->request->post['date_leave'])) {
      		$this->data['date_leave'] = $this->request->post['date_leave'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_leave'] = $customer_info['date_leave'];
		} else {
      		$this->data['date_leave'] = '';
    	}
*/
		
		//$this->load->model('service/customer_room');
		//$this->data['customer_rooms'] = $this->model_service_customer_room->getCustomerRooms();
		
		/*
		if (isset($this->request->post['contact'])) { 
      		$this->data['contacts'] = $this->request->post['contact'];
		} elseif (!empty($this->request->get['customer_id'])) {
			$this->data['contacts'] = $this->model_service_customer->getContacts($this->request->get['customer_id']);
		} else {
			$this->data['contacts'] = array();
    	}
		
		if (isset($this->request->post['contact_id'])) {
      		$this->data['contact_id'] = $this->request->post['contact_id'];
    	} elseif (!empty($customer_info)) { 
			$this->data['contact_id'] = $customer_info['contact_id'];
		} else {
      		$this->data['contact_id'] = '';
    	}
		
		if (isset($this->request->post['child'])) { 
      		$this->data['childs'] = $this->request->post['child'];
		} elseif (!empty($this->request->get['customer_id'])) {
			$this->data['childs'] = $this->model_service_customer->getChilds($this->request->get['customer_id']);
		} else {
			$this->data['childs'] = array();
    	}
		*/
		
		
		$this->template = 'doctor/childdoctor2_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'doctor/childdoctor2')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		/*
		if ((utf8_strlen($this->request->post['idnumber']) <> 10 ) || $this->model_service_customer->checkIDNumber($this->request->post['idnumber'])) {
      		$this->error['idnumber'] = $this->language->get('error_idnumber');
    	}
		*/
		
		//$customer_info = $this->model_service_customer->getCustomerByIDNumber($this->request->post['idnumber']);
		//$child_info = $this->model_service_customer->getCustomerByIDNumber($this->request->post['idnumber']);
		
		/*
		if (!isset($this->request->get['customer_child_id'])) {
			if ($child_info) {
				$this->error['warning'] = $this->language->get('error_idnumber_exists');
			}
		} else {
			if ($customer_info && ($this->request->get['customer_id'] != $customer_info['customer_id'])) {
				$this->error['warning'] = $this->language->get('error_idnumber_exists');
			}
		}
		
		if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}
		
    	if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
      		$this->error['telephone'] = $this->language->get('error_telephone');
    	}
		
		if (isset($this->request->post['contact'])) {
			foreach ($this->request->post['contact'] as $key => $value) {			
				
				if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 64)) {
					$this->error['contact_name'][$key] = $this->language->get('contact_name');
				}	
				
				if ($value['telephone'] == "") {
					$this->error['contact_telephone'][$key] = $this->language->get('contact_telephone');
				}
				
				if ($value['relationship'] == "") {
					$this->error['contact_relationship'][$key] = $this->language->get('contact_relationship');
				}
				
			}
		}
		*/
		
		
		/*
		if (isset($this->request->post['child'])) {
			foreach ($this->request->post['child'] as $key => $value) {			
			
				if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 64)) {
					$this->error['child_name'][$key] = $this->language->get('child_name');
				}
			
				if ($value['birthdate'] == "") {
					$this->error['child_birthdate'][$key] = $this->language->get('child_birthdate');
				}
				
			}
		}
		*/
			
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}    

  	private function validateDelete() {
    	if (!$this->user->hasPermission('delete', 'doctor/childdoctor2')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}	
	  	 
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  
  	} 
	
	/*
	public function transfer() {
    	$this->language->load('service/customer');
		
		$this->load->model('service/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->user->hasPermission('modify', 'service/customer')) { 
			$this->model_service_customer->addTransfer($this->request->get['customer_id'], $this->request->post['description'], $this->request->post['customer_room_id']);
				
			$this->data['success'] = $this->language->get('text_success');
		} else {
			$this->data['success'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && !$this->user->hasPermission('modify', 'service/customer')) {
			$this->data['error_warning'] = $this->language->get('error_permission');
		} else {
			$this->data['error_warning'] = '';
		}		
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_customer_room'] = $this->language->get('column_customer_room');
		
		$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['transfers'] = array();
			
		$results = $this->model_service_customer->getTransfers($this->request->get['customer_id'], ($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
        	$this->data['transfers'][] = array(
				'customer_transfer_id'      => $result['customer_transfer_id'],
				'customer_room_id'      => $result['customer_room_id'],
				'customer_room_name'      => $result['customer_room_name'],
				'description' => $result['description'],
        		'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added']))
				//'selected'       => isset($this->request->post['selected']) && in_array($result['customer_transfer_id'], $this->request->post['selected']),
        	);
      	}			
		
		$transfer_total = $this->model_service_customer->getTotalTransfers($this->request->get['customer_id']);
			
		$pagination = new Pagination();
		$pagination->total = $transfer_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('service/customer/transfer', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->template = 'service/customer_transfer.tpl';
		
		$this->response->setOutput($this->render());
	}
	*/

	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name'])) {
			$this->load->model('doctor/childdoctor2');
			
			$data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 20
			);
		
			$results = $this->model_service_customer->getChilds($data);
			
			foreach ($results as $result) {
				$json[] = array(
					'customer_id'    => $result['customer_id'], 
					'name'           => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'),
					//'idnumber'		=> $result['idnumber'],
					'birthdate'		=> $result['birthdate'],
					'telephone'      => $result['telephone'],
					'mobile'      => $result['mobile'],
					'fall_score'			=> $result['fall_score'],
					'depression_score'			=> $result['depression_score'],
					'degree'			=> $result['degree'],
					'language'			=> $result['language'],
					'profession'			=> $result['profession'],
					'evacuation_hospital'			=> $result['evacuation_hospital'],
					'contact'        => $this->model_service_customer->getContacts($result['customer_id']),
					'child'        => $this->model_service_customer->getChilds($result['customer_id'])	
				);					
			}
		}

		$sort_order = array();
	  
		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->setOutput(json_encode($json));
	}		
	
/*	
	public function contact() {
		$json = array();
		
		if (!empty($this->request->get['contact_id'])) {
			$this->load->model('service/customer');
			
			$json = $this->model_service_customer->getContact($this->request->get['contact_id']);
		}

		$this->response->setOutput(json_encode($json));		
	}
	
	public function child() {
		$json = array();
		
		if (!empty($this->request->get['child_id'])) {
			$this->load->model('service/customer');
			
			$json = $this->model_service_customer->getChild($this->request->get['child_id']);
		}

		$this->response->setOutput(json_encode($json));		
	}
*/

}
?>