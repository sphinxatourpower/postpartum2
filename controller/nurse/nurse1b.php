<?php    
class ControllerNurseNurse1b extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('nurse/nurse1b');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse1b');
		
    	$this->getList();
  	}
  
	public function word() {		
		$this->load->language('nurse/nurse1b');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse1b');
		$this->load->model('service/child');
		
		$datatable = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
		$result = $this->model_nurse_nurse1b->getNurse1b($this->request->get['customer_child_id'],$this->request->get['child_nurse1b_id']);
		//print_r($datatable); exit;
		
		if ($datatable) {
				$called = ($datatable['gender'] == "女") ? "女" : "子";
				$childname = ($datatable['name']=='') ? $datatable['customer_name']."之".$called : $datatable['name'];
				//$filename = "1B護理人員嬰兒入住身評紀錄單_".$childname;
				$filename = "嬰兒入住評估表_".$childname;
		
				$rooms = $this->model_service_child->getTransfers($datatable['customer_id']);
				
				 if (!empty($rooms)) {
					$customer_firstroom = $rooms[0]['customer_room_name'];
					if (count($rooms) == "1") {
						$customer_transfers = array();
						$customer_lastroom = $rooms[0]['customer_room_name'];
					} else {
						for ($i=0;$i<count($rooms)-1;$i++) {
							$customer_transfers[$i] = $rooms[$i+1];
						}
						$customer_lastroom =  $rooms[count($rooms)-1]['customer_room_name'];
					}
				 } else {
					$customer_firstroom = '尚未指定房間';
					$customer_transfers = array();
					$customer_lastroom = '尚未指定房間';
				 }
				$transferrecord = "";
				
				$this->load->model('service/customer_service');
				$service_name = $this->model_service_customer_service->getCustomerServiceName($datatable['service_id']);
				
				if (!empty($customer_transfers)) {
					foreach ($customer_transfers as $transfer) {
							$transferrecord .= "轉床紀錄：".$transfer['date_added']."&nbsp;轉為：".$transfer['customer_room_name']."<br />\n";
					}
				}
				
				if ($datatable['inweight'] && $datatable['inweight'] < $datatable['birthweight']) {
					$downrate =  round( ( ($datatable['birthweight'] - $datatable['inweight']) / $datatable['birthweight'] ) *100, 2);
				} else {
					$downrate = NULL;
				}
				
				$tablerows = array(
				/*
					array (
						'content' => array('產婦姓名：'.$datatable['customer_name'], '嬰兒姓名：'.$childname, '父親姓名：'.$datatable['spouse_name']), 
						//'span' => array()
					),
					array (
						'content' => array('房號：'.$customer_firstroom, $transferrecord),
						'span' => array('', 2)
					),
					*/
					array(
						'content' => array('入住日期：'.$datatable['date_added'], '生產方式：'.$datatable['childbirth_method'], '嬰兒性別：'.$datatable['gender']),
						//'content' => array('嬰兒出生日期：'.$datatable['birthdate'], '產婦入住日期：'.$datatable['date_added'], '預定退住日期：'.$datatable['date_leave']),
						//'span' => array()
					),
					array(
						'content' => array('出生醫院：'.$datatable['childbirth_hospital'], '出生日期時間：'.$datatable['birthdate'].'&#32;'.$datatable['birthdate_time']),
						//'content' => array('生產方式：'.$datatable['childbirth_method'], '生產醫院：'.$datatable['childbirth_hospital']),
						'span' => array('', 2)
					),
					array(
						'content' => array('ApgarScore：一分鐘<u>'.$datatable['apgar_score_1'].'</u>，五分鐘<u>'.$datatable['apgar_score_5'].'</u>', '身長：'.$datatable['birthlength'].'cm &#32; 頭圍：'.$datatable['birthhead'].'cm &#32; 胸圍：'.$datatable['birthchest'].'cm'),
						'span' => array('', 2)
					),
					array(
						'content' => array('出生體重：'.$datatable['birthweight'].'g', '入住時體重：'.$datatable['inweight'].'g'. (($downrate) ? '，下降：'.$downrate.'%' : '')),
						'span' => array('', 2)
					)
					/*
					array(
						'content' => array(
									'懷孕週數：'.$datatable['pregnancy_weeks'].'<br />胎兒產胎次：G&#32;<u>'.$datatable['child_count_g'].'</u>&#09;P&#32;<u>'.$datatable['child_count_p'].'</u>', 
									'生產醫師：'.$datatable['childbirth_doctor'].'<br />Apgar score：<u>'.$datatable['apgar_score_1'].'</u>（1 min）--> <u>'.$datatable['apgar_score_5'].'</u>（5 min）'
						),
						'span' => array('', 2)
					),
					array(
						'content' => array(
									'嬰兒出生時體重：'.$datatable['birthweight'].'公克 &#32; 頭圍：'.$datatable['birthhead'].'公分 &#32; 身長：'.$datatable['birthlength'].'公分，入住時體重'.$datatable['inweight'].'公克'
						),
						'span' => array(3)
					),
					array(
						'content' => array(
									'乙型鏈球菌檢查：'.$datatable['b_streptococcus_check']
						),
						'span' => array(3)
					)
					*/
				);
				if (!empty($result)) {
					$tablerows[] = array(
						'content' => array('入住時黃疸：'.$result['chk6'].'mg/dl', '體溫：'.$result['chk2'].'度'),
						'span' => array('', 2)
					);
				}
		}
		
		if (!empty($result)) {
				//Row1
				$chk5 = ($result['chk5']=='已施打')  ? 'HBIG：'.$result['chk5_other'].$result['chk5'].'<br />' : '';
				$chk7 = ($result['chk7']=='已施打')  ? 'BCG：'.$result['chk7_other'].$result['chk7'].'<br />' : '';
				$chk9 = ($result['chk9']=='已施打')  ? 'B 型肝炎疫苗第一劑：'.$result['chk9_other'].$result['chk9'].'<br />' : '';
				$row1 = $chk5 . $chk7 . $chk9;
				
				//Row2
				$chk16 = ($result['chk16']<>'') ? $result['chk16'].'<br />' : '';
				$text17 = '';
				if (is_array($c17 = unserialize($result['chk17'])) AND !empty($c17)) {
						$text17 = '紅疹：';
						foreach ($c17 as $k => $data) {
							if ($k+1!=count($c17)) {
								$text17 .= $data.",";
							} else {
								$text17 .= $data;
							}
						}
						$text17 .= '<br />';
				}
				$text18 = '';
				if (is_array($c18 = unserialize($result['chk18'])) AND !empty($c18)) {
						$text18 = '乾燥脫皮：';
						foreach ($c18 as $k => $data) {
							if ($k+1!=count($c18)) {
								$text18 .= $data.",";
							} else {
								$text18 .= $data;
							}
						}
						$text18 .= '<br />';
				}
				$text21 = '';
				if (is_array($c21 = unserialize($result['chk21'])) AND !empty($c21)) {
						$text21 = '血管瘤：';
						foreach ($c21 as $k => $data) {
							if ($k+1!=count($c21)) {
								$text21 .= $data.",";
							} else {
								$text21 .= $data;
							}
						}
						$text21 .= '<br />';
				}
				$text24 = '';
				if (is_array($c24 = unserialize($result['chk24'])) AND !empty($c24)) {
						foreach ($c24 as $k => $data) {
							if ($k+1!=count($c24)) {
								if ($data=='針扎') { $text24 .= $data. (($result['chk24_l']) ? '左腳'.$result['chk24_l'].'處' : '') . (($result['chk24_r']) ? '右腳'.$result['chk24_r'].'處' : '') .", "; } 
								else { $text24 .= $data.","; }
							} else {
								if ($data=='針扎') { $text24 .= $data. (($result['chk24_l']) ? '左腳'.$result['chk24_l'].'處' : '') . (($result['chk24_r']) ? '右腳'.$result['chk24_r'].'處' : ''); } 
								else { $text24 .= $data; }
							}
						}
						$text24 .= '<br />';
				}
				$row2 = $chk16 . $text17 . $text18 . $text21 . $text24;
				
				//Row3
				$text28 = '';
				if (is_array($c28 = unserialize($result['chk28'])) AND !empty($c28)) {
						$text28 = '鞏膜出血點：';
						foreach ($c28 as $k => $data) {
							if ($k+1!=count($c28)) {
								$text28 .= $data.",";
							} else {
								$text28 .= $data;
							}
						}
						$text28 .= '<br />';
				}
				$text29 = '';
				if (is_array($c29 = unserialize($result['chk29'])) AND !empty($c29)) {
						$text29 = '分泌物：';
						foreach ($c29 as $k => $data) {
							if ($k+1!=count($c29)) {
								$text29 .= $data.",";
							} else {
								$text29 .= $data;
							}
						}
						$text29 .= '<br />';
				}
				$row3 = $text28 . $text29;
				
				//Row4
				$text30 = '';
				if (is_array($c30 = unserialize($result['chk30'])) AND !empty($c30)) {
						$text30 = '耳前息肉：';
						foreach ($c30 as $k => $data) {
							if ($k+1!=count($c30)) {
								$text30 .= $data.",";
							} else {
								$text30 .= $data;
							}
						}
						$text30 .= '<br />';
				}
				$text31 = '';
				if (is_array($c31 = unserialize($result['chk31'])) AND !empty($c31)) {
						$text31 = '耳前小竇：';
						foreach ($c31 as $k => $data) {
							if ($k+1!=count($c31)) {
								$text31 .= $data.",";
							} else {
								$text31 .= $data;
							}
						}
						$text31 .= '<br />';
				}
				$row4 = $text30 . $text31;
				
				//Row5
				$text34 = '';
				if (is_array($c34 = unserialize($result['chk34'])) AND !empty($c34)) {
						foreach ($c34 as $k => $data) {
							if ($k+1!=count($c34)) {
								$text34 .= $data.",";
							} else {
								$text34 .= $data;
							}
						}
						$text34 .= '<br />';
				}
				$row5 = $text34;
				
				//Row6
				$text33 = '';
				if (is_array($c33 = unserialize($result['chk33'])) AND !empty($c33)) {
						foreach ($c33 as $k => $data) {
							if ($k+1!=count($c33)) {
								$text33 .= $data.",";
							} else {
								$text33 .= $data;
							}
						}
						$text33 .= '<br />';
				}
				$row6 = $text33;
				
				//Row7
				$text32 = '';
				if (is_array($c32 = unserialize($result['chk32'])) AND !empty($c32)) {
						foreach ($c32 as $k => $data) {
							if ($k+1!=count($c32)) {
								$text32 .= $data.",";
							} else {
								$text32 .= $data;
							}
						}
						$text32 .= '<br />';
				}
				$row7 = $text32;
				
				//Row8
				$text27 = '';
				if (is_array($c27 = unserialize($result['chk27'])) AND !empty($c27)) {
						$text27 = '頭皮血腫：';
						foreach ($c27 as $k => $data) {
							if ($k+1!=count($c27)) {
								$text27 .= $data.",";
							} else {
								$text27 .= $data;
							}
						}
						$text27 .= '<br />';
				}
				$text26 = '';
				if (is_array($c26 = unserialize($result['chk26'])) AND !empty($c26)) {
						$text26 = '產瘤：';
						foreach ($c26 as $k => $data) {
							if ($k+1!=count($c26)) {
								$text26 .= $data.",";
							} else {
								$text26 .= $data;
							}
						}
						$text26 .= '<br />';
				}
				$text35 = '';
				if (is_array($c35 = unserialize($result['chk35'])) AND !empty($c35)) {
						$text35 = '斜頸：';
						foreach ($c35 as $k => $data) {
							if ($k+1!=count($c35)) {
								$text35 .= $data.",";
							} else {
								$text35 .= $data;
							}
						}
						$text35 .= '<br />';
				}
				$text23 = '';
				if (is_array($c23 = unserialize($result['chk23'])) AND !empty($c23)) {
						$text23 = '囟門：';
						foreach ($c23 as $k => $data) {
							if ($k+1!=count($c23)) {
								$text23 .= $data.",";
							} else {
								$text23 .= $data;
							}
						}
						$text23 .= '<br />';
				}
				$row8 = $text27 . $text26 . $text35 . $text23;
				
				//Row9
				$text38 = '';
				if (is_array($c38 = unserialize($result['chk38'])) AND !empty($c38)) {
						foreach ($c38 as $k => $data) {
							if ($k+1!=count($c38)) {
								$text38 .= $data.",";
							} else {
								$text38 .= $data;
							}
						}
						$text38 .= '<br />';
				}
				$row9 = $text38;
		
				//Row10
				$text44 = '';
				if (is_array($c44 = unserialize($result['chk44'])) AND !empty($c44)) {
						$text44 = '肚臍：';
						foreach ($c44 as $k => $data) {
							if ($k+1!=count($c44)) {
								$text44 .= $data.",";
							} else {
								$text44 .= $data;
							}
						}
						$text44 .= '<br />';
				}
				$row10 = $text44;		
				
				//Row11
				$text60 = '';
				if (is_array($c60 = unserialize($result['chk60'])) AND !empty($c60)) {
						foreach ($c60 as $k => $data) {
							if ($k+1!=count($c60)) {
								$text60 .= $data.",";
							} else {
								$text60 .= $data;
							}
						}
						$text60 .= '<br />';
				}
				$text36 = '';
				if (is_array($c36 = unserialize($result['chk36'])) AND !empty($c36)) {
						$text36 = '鎖骨：';
						foreach ($c36 as $k => $data) {
							if ($k+1!=count($c36)) {
								$text36 .= $data.",";
							} else {
								$text36 .= $data;
							}
						}
						$text36 .= '<br />';
				}
				$row11 = $text60 . $text36;		
				
				//Row12
				$text40 = '';
				if (is_array($c40 = unserialize($result['chk40'])) AND !empty($c40)) {
						foreach ($c40 as $k => $data) {
							if ($k+1!=count($c40)) {
								$text40 .= $data.",";
							} else {
								$text40 .= $data;
							}
						}
						$text40 .= '<br />';
				}
				$text41 = '';
				if (is_array($c41 = unserialize($result['chk41'])) AND !empty($c41)) {
						$text41 = '疝氣：';
						foreach ($c41 as $k => $data) {
							if ($k+1!=count($c41)) {
								$text41 .= $data.",";
							} else {
								$text41 .= $data;
							}
						}
						$text41 .= '<br />';
				}
				$text42 = '';
				if (is_array($c42 = unserialize($result['chk42'])) AND !empty($c42)) {
						$text42 = '隱睪：';
						foreach ($c42 as $k => $data) {
							if ($k+1!=count($c42)) {
								$text42 .= $data.",";
							} else {
								$text42 .= $data;
							}
						}
						$text42 .= '<br />';
				}
				$text43 = '';
				if (is_array($c43 = unserialize($result['chk43'])) AND !empty($c43)) {
						$text43 = '陰囊水腫：';
						foreach ($c43 as $k => $data) {
							if ($k+1!=count($c43)) {
								$text43 .= $data.",";
							} else {
								$text43 .= $data;
							}
						}
						$text43 .= '<br />';
				}
				$row12 = ($datatable['gender']=='女') ? $text40 . $text41 : $text40 . $text41 . $text42 . $text43;
				
				//Row13
				$text50 = '';
				if (is_array($c50 = unserialize($result['chk50'])) AND !empty($c50)) {
						$text50 = '大便顏色：';
						foreach ($c50 as $k => $data) {
							if ($k+1!=count($c50)) {
								$text50 .= $data.",";
							} else {
								$text50 .= $data;
							}
						}
						$text50 .= '<br />';
				}
				$text51 = '';
				if (is_array($c51 = unserialize($result['chk51'])) AND !empty($c51)) {
						$text51 = '大便性質：';
						foreach ($c51 as $k => $data) {
							if ($k+1!=count($c51)) {
								$text51 .= $data.",";
							} else {
								$text51 .= $data;
							}
						}
						$text51 .= '<br />';
				}
				$text52 = '';
				if (is_array($c52 = unserialize($result['chk52'])) AND !empty($c52)) {
						$text52 = '小便：';
						foreach ($c52 as $k => $data) {
							if ($k+1!=count($c52)) {
								$text52 .= $data.",";
							} else {
								$text52 .= $data;
							}
						}
						$text52 .= '<br />';
				}
				$row13 = $text50 . $text51 . $text52;
				
				//Row14
				$chk12 = ($result['chk12']<>'')  ? '活動力：'.$result['chk12'].'<br />' : '';
				$text13 = '';
				if (is_array($c13 = unserialize($result['chk13'])) AND !empty($c13)) {
						$text13 = '姿勢：';
						foreach ($c13 as $k => $data) {
							if ($k+1!=count($c13)) {
								$text13 .= $data.",";
							} else {
								$text13 .= $data;
							}
						}
						$text13 .= '<br />';
				}
				$text61 = '';
				if (is_array($c61 = unserialize($result['chk61'])) AND !empty($c61)) {
						$text61 = '哭聲：';
						foreach ($c61 as $k => $data) {
							if ($k+1!=count($c61)) {
								$text61 .= $data.",";
							} else {
								$text61 .= $data;
							}
						}
						$text61 .= '<br />';
				}
				$text62 = '';
				if (is_array($c62 = unserialize($result['chk62'])) AND !empty($c62)) {
						$text62 = '反射：';
						foreach ($c62 as $k => $data) {
							if ($k+1!=count($c62)) {
								$text62 .= $data.",";
							} else {
								$text62 .= $data;
							}
						}
						$text62 .= '<br />';
				}
				$row14 = $chk12 . $text13 . $text61 . $text62;
				
				//Row15
				$chk55 = ($result['chk55']<>'')  ? '紅臀：'.$result['chk55'].'<br />' : '';
				$row15 = $chk55;
				
				//Row16
				$chk67 = ($result['chk67']<>'')  ? nl2br($result['chk67']) : '' ;
				$row16 = $chk67;
				
				$chktablerows = array(
					array(
						'content' => array('項目', '評估狀況'),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					)
				);
				
				if ($row1 <> '') {
					$chktablerows[] = array(
						'content' => array('預防接種', $row1),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row2 <> '') {
					$chktablerows[] = array(
						'content' => array('皮膚', $row2),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row3 <> '') {
					$chktablerows[] = array(
						'content' => array('眼', $row3),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row4 <> '') {
					$chktablerows[] = array(
						'content' => array('耳', $row4),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row5 <> '') {
					$chktablerows[] = array(
						'content' => array('口腔', $row5),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row6 <> '') {
					$chktablerows[] = array(
						'content' => array('臉頰', $row6),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row7 <> '') {
					$chktablerows[] = array(
						'content' => array('鼻', $row7),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row8 <> '') {
					$chktablerows[] = array(
						'content' => array('頭頸部', $row8),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row9 <> '') {
					$chktablerows[] = array(
						'content' => array('胸部', $row9),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row10 <> '') {
					$chktablerows[] = array(
						'content' => array('腹部', $row10),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row11 <> '') {
					$chktablerows[] = array(
						'content' => array('四肢', $row11),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row12 <> '') {
					$chktablerows[] = array(
						'content' => array('生殖器', $row12),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row13 <> '') {
					$chktablerows[] = array(
						'content' => array('排泄', $row13),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row14 <> '') {
					$chktablerows[] = array(
						'content' => array('神經肌肉', $row14),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row15 <> '') {
					$chktablerows[] = array(
						'content' => array('臀部', $row15),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
				
				if ($row16 <> '') {
					$chktablerows[] = array(
						'content' => array('其他說明', $row16),
						'cellwidth'	=> array('20%', '80%'),
						'span' => array()
					);
				}
		}
	
		$this->load->model('tool/worddoc');
		$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
		$this->model_tool_worddoc->setDocumentCharset('UTF-8');
		
		
		if ($result) { 
				$this->load->model('service/customer_service');
				$nurse_name = $this->model_service_customer_service->getCustomerServiceName($result['nurse_id']);
		
				$center = array(
					'text-align' 	=> 'center'
				);
				$titleFormat = array(
									'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '20pt');
				$titleFormat2 = array(
									//'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '16pt');
			
				//$this->model_tool_worddoc->isDebugging = true;
				//$this->model_tool_worddoc->addParagraph("1B護理人員嬰兒入住身評紀錄單：".$result['date_added'], $titleFormat);
				$this->model_tool_worddoc->addParagraph("嬰兒入住評估表", $titleFormat);
				$this->model_tool_worddoc->addParagraph("房號：".$customer_lastroom."<span style='mso-tab-count:3'></span>母親姓名：".$datatable['customer_name']."<span style='mso-tab-count:3'></span>評估人員：".$nurse_name, $center);
				$this->model_tool_worddoc->addParagraph("一、基本資料", $titleFormat2);
				//$this->model_tool_worddoc->addParagraph("表格 1");
				if ($datatable) {
					$this->model_tool_worddoc->startTable();
					foreach ($tablerows as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
				}
				
				$this->model_tool_worddoc->addParagraph("");
				
				$this->model_tool_worddoc->addParagraph("二、生產異常狀況", $titleFormat2);
				
				if (is_array($c8 = unserialize($result['chk8'])) AND !empty($c8)) {
						$text8 = '';
						foreach ($c8 as $k => $data) {
							if ($k+1!=count($c8)) {
								$text8 .= $data.",";
							} else {
								$text8 .= $data;
							}
						}
				}
				
				if ($text8<>'') {
					$this->model_tool_worddoc->addParagraph($text8);
				}
				
				$this->model_tool_worddoc->addParagraph("");
				
				$this->model_tool_worddoc->addParagraph("三、身體評估", $titleFormat2);
				
				if (!empty($chktablerows)) {
					$this->model_tool_worddoc->startTable();
					foreach ($chktablerows as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
				}
				
				/*
				$contents = array();
				
				if ($result['chk1']<>"") {
						$contents[] = "嬰兒入住時胸圍：".$result['chk1']." 公分";
				}
				if ($result['chk2']<>"") {
						$contents[] = "體溫：".$result['chk2']." ℃";
				}
				if ($result['chk3']<>"") {
						$contents[] = "脈搏：".$result['chk3']." 次／分鐘";
				}
				if ($result['chk4']<>"") {
						$contents[] = "呼吸：".$result['chk4']." 次／分鐘";
				}
				if ($result['chk5']<>"") {
						$contents[] = "含氧濃度：".$result['chk5']." %";
				}
				if ($result['chk6']<>"") {
						$contents[] = "黃疸數值：".$result['chk6']." mg/dL";
				}
				if (is_array($c7 = unserialize($result['chk7'])) AND !empty($c7)) {
						$text7 = '';
						foreach ($c7 as $k => $data) {
							if ($k+1!=count($c7)) {
								$text7 .= $data.",";
							} else {
								$text7 .= $data;
							}
						}
						$contents[] = "已預防注射：".$text7;
				}
				if ($result['chk8']<>"") {
						$contents[] = "腦部超音波檢查：".$result['chk8'];
				}
				if ($result['chk9']<>"") {
						$contents[] = "心臟超音波：".$result['chk9'];
				}
				if ($result['chk10']<>"") {
						$contents[] = "腎臟超音波：".$result['chk10'];
				}
				if ($result['chk11']<>"") {
					$c11 = explode(':', $result['chk11']);
					if ($c11[0] == "未做") { $chk11 = $c11[0];  $chk11_other = '，預定日期為：'.$c11[1]; } 
					else { $chk11 = $c11[0];  $chk11_other = ''; } 
					
					$contents[] = "新生兒篩檢：".$chk11.$chk11_other;
				}
				if ($result['chk12']<>"") {
						$contents[] = "飲食習慣：".$result['chk12'];
				}
				if ($result['chk13']<>"") {
						$contents[] = "姿勢行為：".$result['chk13'];
				}
				if ($result['chk14']<>"") {
						$contents[] = "手足發紺：".$result['chk14'];
				}
				if ($result['chk15']<>"") {
						$contents[] = "嘴唇發紺：".$result['chk15'];
				}
				if ($result['chk16']<>"") {
						$contents[] = "大理石皮膚：".$result['chk16'];
				}
				if ($result['chk17']<>"") {
						$contents[] = "生理性黃疸：".$result['chk17'];
				}
				if (is_array($c18 = unserialize($result['chk18'])) AND !empty($c18)) {
						$text18 = '';
						foreach ($c18 as $k => $data) {
							if ($k+1!=count($c18)) {
								$text18 .= $data.",";
							} else {
								$text18 .= $data;
							}
						}
						$contents[] = "瘀斑或瘀點：".$text18;
				}
				if (is_array($c19 = unserialize($result['chk19'])) AND !empty($c19)) {
						$text19 = '';
						foreach ($c19 as $k => $data) {
							if ($k+1!=count($c19)) {
								$text19 .= $data.",";
							} else {
								$text19 .= $data;
							}
						}
						$contents[] = "蒙古斑：".$text19;
				}
				if (is_array($c20 = unserialize($result['chk20'])) AND !empty($c20)) {
						$text20 = '';
						foreach ($c20 as $k => $data) {
							if ($k+1!=count($c20)) {
								$text20 .= $data.",";
							} else {
								$text20 .= $data;
							}
						}
						$contents[] = "粟粒疹：".$text20;
				}
				if (is_array($c21 = unserialize($result['chk21'])) AND !empty($c21)) {
						$text21 = '';
						foreach ($c21 as $k => $data) {
							if ($k+1!=count($c21)) {
								$text21 .= $data.",";
							} else {
								$text21 .= $data;
							}
						}
						$contents[] = "微血管瘤：".$text21;
				}
				if (is_array($c22 = unserialize($result['chk22'])) AND !empty($c22)) {
						$text22 = '';
						foreach ($c22 as $k => $data) {
							if ($k+1!=count($c22)) {
								$text22 .= $data.",";
							} else {
								$text22 .= $data;
							}
						}
						$contents[] = "毒性紅斑：".$text22;
				}
				if ($result['chk23']<>"") {
						$contents[] = "前囟門：".$result['chk23'];
				}
				if ($result['chk24']<>"") {
						$contents[] = "後囟門：".$result['chk24'];
				}
				if ($result['chk25']<>"") {
						$contents[] = "頭骨重疊現象：".$result['chk25'];
				}
				if ($result['chk26']<>"") {
					$c26 = explode(':', $result['chk26']);
					if ($c26[0] == "有") { $chk26 = $c26[0];  $chk26_other = '，大小：'.$c26[1].' 公分'; } 
					else { $chk26 = $c26[0];  $chk26_other = ''; } 
					
					$contents[] = "產瘤：".$chk26.$chk26_other;
				}
				if ($result['chk27']<>"") {
					$c27 = explode(':', $result['chk27']);
					if ($c27[0] == "有") { $chk27 = $c27[0];  $chk27_other = '，大小：'.$c27[1].'公分'; } 
					else { $chk27 = $c27[0];  $chk27_other = ''; } 
					
					$contents[] = "頭皮血腫：".$chk27.$chk27_other;
				}
				if ($result['chk28']<>"") {
						$contents[] = "結膜出血：".$result['chk28'];
				}
				if ($result['chk29']<>"") {
						$contents[] = "眼睛分泌物：".$result['chk29'];
				}
				if ($result['chk30']<>"") {
						$contents[] = "兩耳形狀對稱：".$result['chk30'];
				}
				if ($result['chk31']<>"") {
						$contents[] = "耳頂比眼角高：".$result['chk31'];
				}
				if ($result['chk32']<>"") {
						$contents[] = "鼻翼扇動：".$result['chk32'];
				}
				if ($result['chk33']<>"") {
						$contents[] = "魔牙：".$result['chk33'];
				}
				if ($result['chk34']<>"") {
						$contents[] = "鵝口瘡：".$result['chk34'];
				}
				if ($result['chk35']<>"") {
						$contents[] = "斜頸：".$result['chk35'];
				}
				if ($result['chk36']<>"") {
						$contents[] = "鎖骨骨折：".$result['chk36'];
				}
				if (is_array($c37 = unserialize($result['chk37'])) AND !empty($c37)) {
						$text37 = '';
						foreach ($c37 as $k => $data) {
							if (preg_match("/大小/i", $data)) {
								$text37 .= $data."公分,";
							} else {
								$text37 .= $data.",";
							}
						}
						$contents[] = "胸鎖乳頭肌腫塊：".$text37;
				}
				if ($result['chk38']<>"") {
						$contents[] = "魔乳：".$result['chk38'];
				}
				if ($result['chk39']<>"") {
						$contents[] = "雞胸：".$result['chk39'];
				}
				if ($result['chk40']<>"") {
						$contents[] = "漏斗胸：".$result['chk40'];
				}
				if ($result['chk41']<>"") {
						$contents[] = "呼吸音：".$result['chk41'];
				}
				if ($result['chk42']<>"") {
						$contents[] = "腹脹：".$result['chk42'];
				}
				if ($result['chk43']<>"") {
						$contents[] = "腸蠕動：".$result['chk43'];
				}
				if ($result['chk44']<>"") {
						$contents[] = "臍帶分泌物：".$result['chk44'];
				}
				if ($result['chk45']<>"") {
						$contents[] = "臍疝氣：".$result['chk45'];
				}
				if ($result['chk46']<>"") {
						$contents[] = "腹股溝疝氣：".$result['chk46'];
				}
				if (is_array($c47 = unserialize($result['chk47'])) AND !empty($c47)) {
						$text47 = '';
						foreach ($c47 as $k => $data) {
							if ($k+1!=count($c47)) {
								$text47 .= $data.",";
							} else {
								$text47 .= $data;
							}
						}
						$contents[] = "陰囊水腫：".$text47;
				}
				if (is_array($c48 = unserialize($result['chk48'])) AND !empty($c48)) {
						$text48 = '';
						foreach ($c48 as $k => $data) {
							if ($k+1!=count($c48)) {
								$text48 .= $data.",";
							} else {
								$text48 .= $data;
							}
						}
						$contents[] = "隱睪症：".$text48;
				}
				if ($result['chk49']<>"") {
						$contents[] = "包皮發炎：".$result['chk49'];
				}
				if ($result['chk50']<>"") {
						$contents[] = "大小陰唇對稱：".$result['chk50'];
				}
				if ($result['chk51']<>"") {
						$contents[] = "大陰唇水腫：".$result['chk51'];
				}
				if ($result['chk52']<>"") {
						$contents[] = "假性月經：".$result['chk52'];
				}
				if ($result['chk53']<>"") {
						$contents[] = "肛門口紅腫：".$result['chk53'];
				}
				if ($result['chk54']<>"") {
						$contents[] = "脊椎外觀：".$result['chk54'];
				}
				if ($result['chk55']<>"") {
						$contents[] = "臀部肌肉對稱：".$result['chk55'];
				}
				if (is_array($c56 = unserialize($result['chk56'])) AND !empty($c56)) {
						$text56 = '';
						foreach ($c56 as $k => $data) {
							if ($k+1!=count($c56)) {
								$text56 .= $data.",";
							} else {
								$text56 .= $data;
							}
						}
						$contents[] = "手指腳趾數目：".$text56;
				}
				if ($result['chk57']<>"") {
						$contents[] = "長度對稱：".$result['chk57'];
				}
				if ($result['chk58']<>"") {
						$contents[] = "斷掌：".$result['chk58'];
				}
				if ($result['chk59']<>"") {
						$contents[] = "臂神經受損：".$result['chk59'];
				}
				if ($result['chk60']<>"") {
						$contents[] = "關節活動正常：".$result['chk60'];
				}
				if ($result['chk61']<>"") {
						$contents[] = "肌肉張力：".$result['chk61'];
				}
				if ($result['chk62']<>"") {
						$contents[] = "尋乳反射：".$result['chk62'];
				}
				if ($result['chk63']<>"") {
						$contents[] = "吸吮反射：".$result['chk63'];
				}
				if ($result['chk64']<>"") {
						$contents[] = "抓握反射：".$result['chk64'];
				}
				if ($result['chk65']<>"") {
						$contents[] = "巴賓斯基反射：".$result['chk65'];
				}
				if ($result['chk66']<>"") {
						$contents[] = "驚嚇反射：".$result['chk66'];
				}
				if ($result['chk67']<>'') {
						$contents[] = "備註：<br />".nl2br($result['chk67']);
				}
				
				foreach ($contents as $ck => $content) {
					if ($content <> '') {
						$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
					}
				}
				
			$this->model_tool_worddoc->addParagraph("");
			$this->model_tool_worddoc->addParagraph("護理人員簽名：".$nurse_name);
			$this->model_tool_worddoc->addParagraph("家屬簽名：");
			*/

			$this->model_tool_worddoc->output($filename.'.doc');
			//$this->model_tool_worddoc->output($filename.'.doc',"data-export");
			
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
  	public function insert() {
		$this->load->language('nurse/nurse1b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse1b');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_nurse_nurse1b->addNurse1b($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
								
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
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
			
			$this->redirect($this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('nurse/nurse1b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse1b');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_nurse_nurse1b->editNurse1b($this->request->get['child_nurse1b_id'], $this->request->post);
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
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
			
			$this->redirect($this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('nurse/nurse1b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse1b');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $customer_child_id) {
				$this->model_service_customer->deleteCustomer($customer_child_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
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
			
			$this->redirect($this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
    
  	private function getList() {
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		
		if (isset($this->request->get['filter_customer_name'])) {
			$filter_customer_name = $this->request->get['filter_customer_name'];
		} else {
			$filter_customer_name = null;
		}
		
		if (isset($this->request->get['filter_birthdate'])) {
			$filter_birthdate = $this->request->get['filter_birthdate'];
		} else {
			$filter_birthdate = null;
		}		

		if (isset($this->request->get['filter_date_leave'])) {
			$filter_date_leave = $this->request->get['filter_date_leave'];
		} else {
			$filter_date_leave = date('Y-m-d');
		}		
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name'; 
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
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
					
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
		
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
		
		if (isset($this->request->get['filter_date_leave'])) {
			$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
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
			'href'      => $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		//$this->data['insert'] = $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		//$this->data['delete'] = $this->url->link('service/customer/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['childs'] = array();

		$data = array(
			'filter_name'              => $filter_name, 
			'filter_birthdate'        => $filter_birthdate,
			'filter_date_leave'        => $filter_date_leave,
			'filter_customer_name'            => $filter_customer_name, 
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                    => $this->config->get('config_admin_limit')
		);
				
		$this->load->model('service/child');
		$child_total = $this->model_service_child->getTotalChilds($data);
	
		$results = $this->model_service_child->getChilds($data);
 
    	foreach ($results as $result) {
			$form1b = $this->model_nurse_nurse1b->getNurse1b($result['customer_child_id']);
			
			$action = array();
		
			if (!empty($form1b)) {
				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->link('nurse/nurse1b/update', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] . '&child_nurse1b_id=' . $form1b['child_nurse1b_id'] . $url, 'SSL')
				);
				$action[] = array(
					'text' => '下載列印',
					'href' => $this->url->link('nurse/nurse1b/word', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] . '&child_nurse1b_id=' . $form1b['child_nurse1b_id'] . $url, 'SSL')
				);
			} else {
				$action[] = array(
					'text' => $this->language->get('text_addnew'),
					'href' => $this->url->link('nurse/nurse1b/insert', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] .  $url, 'SSL')
				);				
			}
			
			$roominfo = $this->model_service_child->getTransfers($result['customer_id'], "DESC", 0, 1);
			$last_transfer = (!empty($roominfo)) ? $roominfo[0]['customer_room_name'] : "尚未指定房間" ;
			
			$this->data['childs'][] = array(
				'customer_child_id'    => $result['customer_child_id'],
				'name'           => (($result['name']!="")? $result['name'] : "[寶寶尚未命名]"),
				'customer_id'           => $result['customer_id'],
				'customer_name'           => $result['customer_name'],
				'customer_room'	=> $last_transfer,
				'birthdate'     => date($this->language->get('date_format_short'), strtotime($result['birthdate'])),
				'date_leave'     => ($result['date_leave']=='0000-00-00 00:00:00') ? date($this->language->get('date_format_short'), strtotime($result['customer_date_leave'])) : date($this->language->get('date_format_short'), strtotime($result['date_leave'])),
				'selected'       => isset($this->request->post['selected']) && in_array($result['customer_id'], $this->request->post['selected']),
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
		$this->data['column_birthdate'] = $this->language->get('column_birthdate');
		$this->data['column_customer_name'] = $this->language->get('column_customer_name');
		$this->data['column_customer_room'] = $this->language->get('column_customer_room');
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
		
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
		
		if (isset($this->request->get['filter_date_leave'])) {
			$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
		}
		
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
		
			
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . '&sort=c.name' . $url, 'SSL');
		$this->data['sort_birthdate'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . '&sort=c.birthdate' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_customer_name'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . '&sort=customer_name' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
		}
		
		if (isset($this->request->get['filter_date_leave'])) {
			$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
		}
		
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $child_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		$this->data['filter_birthdate'] = $filter_birthdate;
		$this->data['filter_date_leave'] = $filter_date_leave;
		$this->data['filter_customer_name'] = $filter_customer_name;
		
				
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'nurse/nurse1b_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
 
    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_livein'] = $this->language->get('text_livein');
    	$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_select'] = $this->language->get('text_select');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_add_blacklist'] = $this->language->get('text_add_blacklist');
		$this->data['text_remove_blacklist'] = $this->language->get('text_remove_blacklist');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		
		$this->data['column_total'] = $this->language->get('column_total');
		//$this->data['column_date_added'] = $this->language->get('column_date_added');
		//$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['entry_idnumber'] = $this->language->get('entry_idnumber');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_birthdate'] = $this->language->get('entry_birthdate');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_mobile'] = $this->language->get('entry_mobile');
		$this->data['entry_service'] = $this->language->get('entry_service');
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
		$this->data['button_add_image'] = $this->language->get('button_add_image');
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
		$this->data['tab_nurse1b'] = $this->language->get('tab_nurse1b');

		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->request->get['customer_child_id'])) {
			$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
		} else {
			$this->data['customer_child_id'] = 0;
		}
		
		if (isset($this->request->get['child_nurse1b_id'])) {
			$this->data['child_nurse1b_id'] = $this->request->get['child_nurse1b_id'];
		} else {
			$this->data['child_nurse1b_id'] = 0;
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['date_added'])) {
			$this->data['error_date_added'] = $this->error['date_added'];
		} else {
			$this->data['error_date_added'] = '';
		}
		
		if (isset($this->error['child_gender'])) {
			$this->data['error_child_gender'] = $this->error['child_gender'];
		} else {
			$this->data['error_child_gender'] = '';
		}
		
		if (isset($this->error['child_birthdate'])) {
			$this->data['error_child_birthdate'] = $this->error['child_birthdate'];
		} else {
			$this->data['error_child_birthdate'] = '';
		}
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_customer_name'])) {
			$url .= '&filter_customer_name=' . $this->request->get['filter_customer_name'];
		}
		
		if (isset($this->request->get['filter_birthdate'])) {
			$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
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
			'href'      => $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);


		if (!isset($this->request->get['child_nurse1b_id'])) {
			$this->data['action'] = $this->url->link('nurse/nurse1b/insert', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('nurse/nurse1b/update', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] . '&child_nurse1b_id=' . $this->request->get['child_nurse1b_id'] . $url, 'SSL');
		}

    	$this->data['cancel'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_child_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$form_info = $this->model_nurse_nurse1b->getNurse1b($this->request->get['customer_child_id']);
			
			$this->load->model('service/child');
			$datatable_info = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
			if (empty($datatable_info)) $this->redirect($this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
		
#!#####
		if (isset($this->request->get['customer_child_id'])) {
      		$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
			$this->data['child_name'] = $this->model_nurse_nurse1b->getChildName($this->request->get['customer_child_id']);
    	} elseif (!empty($form_info)) { 
			$this->data['customer_child_id'] = $form_info['customer_child_id'];
			$this->data['child_name'] = $this->model_nurse_nurse1b->getChildName($form_info['customer_child_id']);
		} else {
      		$this->data['customer_child_id'] = '';
			$this->data['child_name'] = '';
    	}	
		
		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => array('2','3'));
		$this->data['nurses'] = $this->model_service_customer_service->getCustomerServices($servary);

		if (isset($this->request->post['nurse_id'])) {
      		$this->data['nurse_id'] = $this->request->post['nurse_id'];
    	} elseif (!empty($form_info)) { 
			$this->data['nurse_id'] = $form_info['nurse_id'];
		} else {
      		$this->data['nurse_id'] = $this->user->getId();
    	}	
		
		//$nar = array(7,8,18,19,20,21,22,37,47,48,56);
		for ($i=1;$i<=67;$i++) {
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['chk'.$i.''] = $form_info['chk'.$i.''];
				} else {
					$this->data['chk'.$i.''] = '';
				}
		}
		
		for ($i=1;$i<=5;$i++) {
				if (isset($this->request->post['field'.$i.''])) {
					$this->data['field'.$i.''] = $this->request->post['field'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['field'.$i.''] = $form_info['field'.$i.''];
				} else {
					$this->data['field'.$i.''] = '';
				}
		}
		
		for ($i=1;$i<=9;$i++) {
				if (isset($this->request->post['reflex'.$i.''])) {
					$this->data['reflex'.$i.''] = $this->request->post['reflex'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['reflex'.$i.''] = $form_info['reflex'.$i.''];
				} else {
					$this->data['reflex'.$i.''] = '';
				}
		}

		if (isset($this->request->post['birthhospital'])) {
      		$this->data['birthhospital'] = $this->request->post['birthhospital'];
    	} elseif (!empty($form_info)) { 
			$this->data['birthhospital'] = $datatable_info['birthhospital'];
		} else {
      		$this->data['birthhospital'] = '';
    	}
		
		if (isset($this->request->post['chk5_other'])) {
      		$this->data['chk5_other'] = $this->request->post['chk5_other'];
    	} elseif (!empty($form_info)&&$form_info['chk5_other']<>'0000-00-00') { 
			$this->data['chk5_other'] = $form_info['chk5_other'];
		} else {
      		$this->data['chk5_other'] = '';
    	}

		if (isset($this->request->post['chk7_other'])) {
      		$this->data['chk7_other'] = $this->request->post['chk7_other'];
    	} elseif (!empty($form_info)&&$form_info['chk7_other']<>'0000-00-00') { 
			$this->data['chk7_other'] = $form_info['chk7_other'];
		} else {
      		$this->data['chk7_other'] = '';
    	}

		if (isset($this->request->post['chk9_other'])) {
      		$this->data['chk9_other'] = $this->request->post['chk9_other'];
    	} elseif (!empty($form_info)&&$form_info['chk9_other']<>'0000-00-00') { 
			$this->data['chk9_other'] = $form_info['chk9_other'];
		} else {
      		$this->data['chk9_other'] = '';
    	}
		
		if (isset($this->request->post['chk24_l'])) {
      		$this->data['chk24_l'] = $this->request->post['chk24_l'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk24_l'] = $form_info['chk24_l'];
		} else {
      		$this->data['chk24_l'] = '';
    	}
		
		if (isset($this->request->post['chk24_r'])) {
      		$this->data['chk24_r'] = $this->request->post['chk24_r'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk24_r'] = $form_info['chk24_r'];
		} else {
      		$this->data['chk24_r'] = '';
    	}

		
#!#####

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
		
		if (isset($this->request->post['birthdate_time'])) {
			$this->data['birthdate_time'] = $this->request->post['birthdate_time'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthdate_time'] = date("H:i", strtotime($datatable_info['birthdate_time']));
		} else {
			$this->data['birthdate_time'] = '';
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
		
		if (isset($this->request->post['birthchest'])) {
      		$this->data['birthchest'] = $this->request->post['birthchest'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['birthchest'] = $datatable_info['birthchest'];
		} else {
      		$this->data['birthchest'] = '';
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
		
		if (isset($this->request->post['inlength'])) {
      		$this->data['inlength'] = $this->request->post['inlength'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['inlength'] = $datatable_info['inlength'];
		} else {
      		$this->data['inlength'] = '';
		}
		
		if (isset($this->request->post['inchest'])) {
      		$this->data['inchest'] = $this->request->post['inchest'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['inchest'] = $datatable_info['inchest'];
		} else {
      		$this->data['inchest'] = '';
		}
		
		if (isset($this->request->post['inhead'])) {
      		$this->data['inhead'] = $this->request->post['inhead'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['inhead'] = $datatable_info['inhead'];
		} else {
      		$this->data['inhead'] = '';
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
		
		if (isset($this->request->post['gender'])) {
      		$this->data['gender'] = $this->request->post['gender'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['gender'] = $datatable_info['gender'];
		} else {
      		$this->data['gender'] = '';
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
		
		
		$this->template = 'nurse/nurse1b_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'nurse/nurse1b')) {
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
		if (utf8_strlen($this->request->post['gender']) < 1) {
			$this->error['child_gender'] = $this->language->get('error_child_gender');
		}
		
		if ((utf8_strlen($this->request->post['birthdate']) < 10) || (utf8_strlen($this->request->post['birthdate']) > 10)) {
			$this->error['child_birthdate'] = $this->language->get('error_child_birthdate');
		}
		
		if ((utf8_strlen($this->request->post['date_added']) < 10) || (utf8_strlen($this->request->post['date_added']) > 10)) {
			$this->error['date_added'] = $this->language->get('error_date_added');
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
    	if (!$this->user->hasPermission('modify', 'nurse/nurse1b')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}	
	  	 
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  
  	} 

	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name'])) {
			$this->load->model('nurse/nurse1b');
			
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
	

}
?>