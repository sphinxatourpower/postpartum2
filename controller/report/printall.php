<?php
class ControllerReportPrintall extends Controller { 
	public function index() {  
		$this->load->language('report/printall');

		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->request->get['filter_date_start'])) {
			$filter_date_start = $this->request->get['filter_date_start'];
		} else {
			$filter_date_start = '';
		}

		if (isset($this->request->get['filter_date_end'])) {
			$filter_date_end = $this->request->get['filter_date_end'];
		} else {
			$filter_date_end = '';
		}
		
		if (isset($this->request->get['filter_customer_id'])) {
			$filter_customer_id = $this->request->get['filter_customer_id'];
		} else {
			$filter_customer_id = '';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$url = '';
						
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}
		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		
		if (isset($this->request->get['filter_customer_id'])) {
			$url .= '&filter_customer_id=' . $this->request->get['filter_customer_id'];
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
			'href'      => $this->url->link('report/printall', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->load->model('report/printall');
		
		$this->data['orders'] = array();
		
		$data = array(
			'filter_date_start'	     => $filter_date_start, 
			'filter_date_end'	     => $filter_date_end, 
			'filter_customer_id' => $filter_customer_id,
			//'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
			//'limit'                  => $this->config->get('config_admin_limit')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_all_status'] = $this->language->get('text_all_status');
		
		$this->data['column_date_start'] = $this->language->get('column_date_start');
		$this->data['column_date_end'] = $this->language->get('column_date_end');
    	$this->data['column_orders'] = $this->language->get('column_orders');
		$this->data['column_products'] = $this->language->get('column_products');
		$this->data['column_tax'] = $this->language->get('column_tax');
		$this->data['column_total'] = $this->language->get('column_total');
		
		$this->data['entry_date_start'] = $this->language->get('entry_date_start');
		$this->data['entry_date_end'] = $this->language->get('entry_date_end');
		$this->data['entry_group'] = $this->language->get('entry_group');	
		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['button_filter'] = $this->language->get('button_filter');
		
		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('service/customer');
		$customersresult = $this->model_service_customer->getCustomers();
		
		$this->data['customers'] = array();
		
		foreach ($customersresult as $customer) {
			$status = ($customer['status']) ? $this->language->get('text_livein') : $this->language->get('text_leave');
			$this->data['customers'][] = array(
				'text'	=> $customer['name']." [". $status ."]",
				'value'	=> $customer['customer_id']
			);
		}

		$url = '';
						
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}
		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		
		if (isset($this->request->get['filter_customer_id'])) {
			$url .= '&filter_customer_id=' . $this->request->get['filter_customer_id'];
		}		
		
		/*
		$pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('report/printall', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		*/
		
		//$this->data['action'] = $this->url->link('report/printall/word', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
		//$this->data['pagination'] = $pagination->render();		

		$this->data['filter_date_start'] = $filter_date_start;
		$this->data['filter_date_end'] = $filter_date_end;		
		$this->data['filter_customer_id'] = $filter_customer_id;
				 
		$this->template = 'report/printall.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function check() {
		$json = array();
		
		if (isset($this->request->get['filter_customer_id'])) {
			$this->load->model('service/customer');
			$this->load->model('nurse/nurse1c');
			$this->load->model('nurse/nurse2c');
			$this->load->model('nurse/nurse3c');
			$this->load->model('nurse/nurse4c');
			$this->load->model('doctor/childdoctor3');
			
			$customer_childs = $this->model_service_customer->getChilds($this->request->get['filter_customer_id']);
			if (empty($customer_childs)) return false;
			
			$result = $this->model_service_customer->getCustomer($this->request->get['filter_customer_id']);
			$report1a = $this->model_service_customer->getDataTables($this->request->get['filter_customer_id']);
			$report1c = $this->model_nurse_nurse1c->getNurse1c($this->request->get['filter_customer_id']);
			$report2c = $this->model_nurse_nurse2c->getNurse2cs($this->request->get['filter_customer_id']);
			$report3c = $this->model_nurse_nurse3c->getNurse3cs($this->request->get['filter_customer_id']);
			$report4c = $this->model_nurse_nurse4c->getNurse4c($this->request->get['filter_customer_id']);
			$report3e = $this->model_doctor_childdoctor3->getCustomerDoctor3s($this->request->get['filter_customer_id']);
			
			$this->load->model('service/child');
			$this->load->model('doctor/childdoctor1');
			$this->load->model('doctor/childdoctor2');
			$this->load->model('nurse/nurse1b');
			$this->load->model('nurse/nurse2b');
			$this->load->model('nurse/nurse3b');
			$this->load->model('nurse/nurse4b');
			
			$report1e = array();
			$report1b = array();
			$report2b = array();
			$report3b = array();
			$report4b = array();
			$report2a = array();
			
			foreach ($customer_childs as $r1a) {
					$report1e[] = $this->model_doctor_childdoctor1->getChildDoctor($r1a['child_id']);
					$report2e[] = $this->model_doctor_childdoctor2->getChildDoctor2s($r1a['child_id']);
					$report1b[] = $this->model_nurse_nurse1b->getNurse1b($r1a['child_id']);
					$report2b[] = $this->model_nurse_nurse2b->getNurse2bs($r1a['child_id']);
					$report3b[] = $this->model_nurse_nurse3b->getNurse3bs($r1a['child_id']);
					$report4b[] = $this->model_nurse_nurse4b->getNurse4bs($r1a['child_id']);
					$report2a[] = $this->model_service_child->getChildImages($r1a['child_id']);
			}
			
			
			/*
			== Group A ==
			基本資料 1A
			統計表格1、2
			
			== Group E ==
			嬰兒入住醫師評估單 1E
			小兒科醫師巡診單 2E
			婦產科醫師巡診單 3E
			
			== Group B ==
			護理人員嬰兒入住身評紀錄單 1B
			護理人員接班評估單 2B
			護理人員I/O紀錄單 3B
			護理人員交班評估單 4B
			
			== Group C ==
			產後衛教入住身體評估單 1C
			產後衛教跌倒因子評估表 3C
			產後衛教愛丁堡產後憂鬱量表 4C
			產後衛教每日身評紀錄單 2C
			嬰兒圖檔 2A
			*/
			
			//sleep(5);
			
			if (!empty($result)) {				
				$json[] = array(
					'name'           => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'),
					'idnumber'		=> $result['idnumber'],
					'report1a' => (!empty($report1a)) ? "done" : "",
					'stat1'			=>	(!empty($report2c)) ? "done" : "",
					'stat2'			=>	(count($report3b) == "1" AND empty($report3b[0])) ? "" : "done",
					'report1e'			=>	(count($report1e) == "1" AND empty($report1e[0])) ? "" : "done",
					'report2e'			=>	(count($report2e) == "1" AND empty($report2e[0])) ? "" : "done",
					'report3e'			=>	(!empty($report3e)) ? "done" : "",
					'report1b'			=>	(count($report1b) == "1" AND empty($report1b[0])) ? "" : "done",
					'report2b'			=>	(count($report2b) == "1" AND empty($report2b[0])) ? "" : "done",
					'report3b'			=>	(count($report3b) == "1" AND empty($report3b[0])) ? "" : "done",
					'report4b'			=>	(count($report4b) == "1" AND empty($report4b[0])) ? "" : "done",
					'report1c'			=>	(!empty($report1c)) ? "done" : "",
					'report3c'			=>	(!empty($report3c)) ? "done" : "",
					'report4c'			=>	(!empty($report4c)) ? "done" : "",
					'report2c'			=>	(!empty($report2c)) ? "done" : "",
					'report2a'			=>	(count($report2a) == "1" AND empty($report2a[0])) ? "" : "done"	
				);	
			}

			$sort_order = array();
		  
			foreach ($json as $key => $value) {
				$sort_order[$key] = $value['name'];
			}

			array_multisort($sort_order, SORT_ASC, $json);

			$this->response->setOutput(json_encode($json));
		} 
	}		
	
	
	public function word() {		
		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['filter_customer_id']);

		if ($customer_info) { 
			$childinfos = $this->model_service_customer->getChilds($this->request->get['filter_customer_id']);
			$results = $this->model_service_customer->getDataTables($this->request->get['filter_customer_id']);
		
			$filename = date('Ymd')."_資料報表總輸出_".$customer_info['name'];
			
			$this->load->model('service/customer_service');
			$service_name = $this->model_service_customer_service->getCustomerServiceName($customer_info['service_id']);
			
			$contact_infos = $this->model_service_customer->getContacts($customer_info['customer_id']);
			
			/* 表格 1 */
			foreach ($results as $tbkey => $result) {		
				$called = ($result['gender'] == "女") ? "女" : "子";
				$childname = ($result['name']=='') ? $result['customer_name']."之".$called : $result['name'];
				
				$rooms = $this->model_service_customer->getTransfers($result['customer_id']);
				 if (!empty($rooms)) {
					$customer_firstroom = $rooms[0]['customer_room_name'];
					if (count($rooms) == "1") {
						$customer_transfers = array();
					} else {
						for ($i=0;$i<count($rooms)-1;$i++) {
							$customer_transfers[$i] = $rooms[$i+1];
						}
					}
				 } else {
					$customer_firstroom = '尚未指定房間';
					$customer_transfers = array();
				 }
				$transferrecord = "";
				
				if (!empty($customer_transfers)) {
					foreach ($customer_transfers as $transfer) {
							$transferrecord .= "轉床紀錄：".$transfer['date_added']."&nbsp;轉為：".$transfer['customer_room_name']."<br />\n";
					}
				}
				
				$tablerows[] = array(
					array (
						'content' => array('產婦姓名：'.$result['customer_name'], '嬰兒姓名：'.$childname, '父親姓名：'.$result['spouse_name']), 
					),
					array (
						'content' => array('房號：'.$customer_firstroom, $transferrecord),
						'span' => array('', 2)
					),
					array(
						'content' => array('嬰兒出生日期：'.$result['birthdate'], '產婦入住日期：'.$result['date_added'], '預定退住日期：'.$result['date_leave']),
					),
					array(
						'content' => array('生產方式：'.$result['childbirth_method'], '生產醫院：'.$result['childbirth_hospital']),
						'span' => array('', 2)
					),
					array(
						'content' => array(
									'懷孕週數：'.$result['pregnancy_weeks'].'<br />胎兒產胎次：G&#32;<u>'.$result['child_count_g'].'</u>&#09;P&#32;<u>'.$result['child_count_p'].'</u>', 
									'生產醫師：'.$result['childbirth_doctor'].'<br />Apgar score：<u>'.$result['apgar_score_1'].'</u>（1 min）--> <u>'.$result['apgar_score_5'].'</u>（5 min）'
						),
						'span' => array('', 2)
					),
					array(
						'content' => array(
									'嬰兒出生時體重：'.$result['birthweight'].'公克 &#32; 頭圍：'.$result['birthhead'].'公分 &#32; 身長：'.$result['birthlength'].'公分，入住時體重'.$result['inweight'].'公克'
						),
						'span' => array(3)
					),
					array(
						'content' => array(
									'乙型鏈球菌檢查：'.$result['b_streptococcus_check']
						),
						'span' => array(3)
					)
				);
			}

				$this->load->model('tool/worddoc');
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
		
				$titleFormat = array(
									'font-family' =>	'新細明體',
									'font-size'		=> '14pt');

//++++ A 組表單 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
									
				if ($this->request->get['1a'] == "true") {	// 1A 資料表格
					$this->model_tool_worddoc->addParagraph("1A基本資料：".$customer_info['name'], $titleFormat);
					$this->model_tool_worddoc->addParagraph("表格 1");
					
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable();
						foreach ($tablerow as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
					}
					
					$this->model_tool_worddoc->addParagraph('');
					$this->model_tool_worddoc->addParagraph('產婦出生日期：'.$customer_info['birthdate']);
					$this->model_tool_worddoc->addParagraph('產婦身份證號碼：'.$customer_info['idnumber']);
					$this->model_tool_worddoc->addParagraph('產婦地址：'.$customer_info['address']);
					$this->model_tool_worddoc->addParagraph('聯絡電話：'.$customer_info['telephone']);
					$this->model_tool_worddoc->addParagraph('手機：'.$customer_info['mobile']);
					$this->model_tool_worddoc->addParagraph('產婦跌倒評估分數：'.$customer_info['fall_score']);
					$this->model_tool_worddoc->addParagraph('產婦憂鬱評估分數：'.$customer_info['depression_score']);
					$this->model_tool_worddoc->addParagraph('最高學歷：'.$customer_info['degree']);
					$this->model_tool_worddoc->addParagraph('職業：'.$customer_info['profession']);
					$this->model_tool_worddoc->addParagraph('語言溝通：'.$customer_info['language']);
					$this->model_tool_worddoc->addParagraph('後送醫院：'.$customer_info['evacuation_hospital']);

					foreach ($contact_infos as $k => $contact_info) {
						$this->model_tool_worddoc->addParagraph('緊急聯絡人'.($k+1).'姓名：'.$contact_info['name']);
						$this->model_tool_worddoc->addParagraph('緊急聯絡人'.($k+1).'電話：'.$contact_info['telephone']);
						$this->model_tool_worddoc->addParagraph('與緊急聯絡人'.($k+1).'關係：'.$contact_info['relationship']);
					}
					$this->model_tool_worddoc->addParagraph('客服人員：'.$service_name);
				} // 1A 資料表格
				
				if ($this->request->get['stat1'] == "true" ) { //統計表格 1
					$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
					
						$this->load->model('report/stat1');
						$qstat1data = array(
							//'filter_date_start'	     => $filter_date_start, 
							//'filter_date_end'	     => $filter_date_end, 
							'filter_customer_id' => $this->request->get['filter_customer_id'],
							//'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
							//'limit'                  => $this->config->get('config_admin_limit')
						);
						$stat1_results = $this->model_report_stat1->getNurse2cs($qstat1data);
						$perpageitem = 4;
						$totalpage = ceil(count($stat1_results)/$perpageitem);
						$nstat1_results = array_chunk($stat1_results, $perpageitem);
		
						$roo = array("右側乳頭外觀為","左側乳頭外觀為", "右側乳暈外觀為","左側乳暈外觀為","右側乳房外觀為","左側乳房外觀為","單次雙側奶量為每四小時","宮底位置為","惡露量為","惡露顏色為","惡露性質為","該產婦 NSD 傷口為","該產婦 C/S 傷口為","痔瘡","產婦情緒為","產婦本日食慾","活動精神狀況","乳汁排洩情況","乳房狀況","產婦按摩乳房狀況為","學習餵奶打嗝技巧","排尿情形","排便狀況","體溫 ℃","脈搏 次/每分鐘","呼吸 次/每分鐘","血壓 mmHg");
						
						for ($i=0;$i<$totalpage;$i++) {
							$stat1toprow[$i]['content'] = array('編號','項目');
							foreach ($nstat1_results[$i] as $toprow) {
								$stat1toprow[$i]['content'][] = date($this->language->get('date_format_short'), strtotime($toprow['date_added']));
							}
							
							if (!empty($nstat1_results)) {
								foreach ($roo as $rok => $rodata) {
									$stat1rowdata[$i][$rok]['content'] = array($rok+1, $rodata);
								}
								foreach ($nstat1_results[$i] as $rk => $result) {		
									$stat1rowdata[$i][0]['content'][] = $result['chk1'];
									$stat1rowdata[$i][1]['content'][] = $result['chk2'];
									$stat1rowdata[$i][2]['content'][] = $result['chk3'];
									$stat1rowdata[$i][3]['content'][] = $result['chk4'];
									$stat1rowdata[$i][4]['content'][] = $result['chk5'];
									$stat1rowdata[$i][5]['content'][] = $result['chk6'];
									$stat1rowdata[$i][6]['content'][] = $result['chk7'];
									$stat1rowdata[$i][7]['content'][] = $result['chk8'];
									$stat1rowdata[$i][8]['content'][] = $result['chk9'];
									$stat1rowdata[$i][9]['content'][] = $result['chk10'];
									$stat1rowdata[$i][10]['content'][] = $result['chk11'];
									$stat1rowdata[$i][11]['content'][] = $result['chk12'];
									$stat1rowdata[$i][12]['content'][] = $result['chk13'];
									$stat1rowdata[$i][13]['content'][] = $result['chk14'];
									$stat1rowdata[$i][14]['content'][] = $result['chk15'];
									$stat1rowdata[$i][15]['content'][] = $result['chk16'];
									$stat1rowdata[$i][16]['content'][] = $result['chk17'];
									$stat1rowdata[$i][17]['content'][] = $result['chk18'];
									$stat1rowdata[$i][18]['content'][] = $result['chk19'];
									$stat1rowdata[$i][19]['content'][] = $result['chk20'];
									$stat1rowdata[$i][20]['content'][] = $result['chk21'];
									$stat1rowdata[$i][21]['content'][] = $result['chk22'];
									$stat1rowdata[$i][22]['content'][] = $result['chk23'];
									$stat1rowdata[$i][23]['content'][] = $result['chk24'];
									$stat1rowdata[$i][24]['content'][] = $result['chk25'];
									$stat1rowdata[$i][25]['content'][] = $result['chk26'];
									$stat1rowdata[$i][26]['content'][] = "(收縮壓)".$result['chk27a']."<br />(舒張壓)".$result['chk27b'];
								}
							}
						}
						
						for ($n=0;$n<$totalpage;$n++) {
							$this->model_tool_worddoc->addParagraph("統計表格1&#09;&#09;&#09;&#09;(第".($n+1)."頁)", $titleFormat);
							$this->model_tool_worddoc->startTable();
							$this->model_tool_worddoc->addTableRow($stat1toprow[$n]);
							foreach ($stat1rowdata[$n] as $row) {
								$this->model_tool_worddoc->addTableRow($row);
							}
							$this->model_tool_worddoc->endTable();
							if ($n+1<$totalpage) {
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
							}
						}
				} // 統計表格 1
				
				
				if ( $this->request->get['stat2'] == "true" ) { //統計表格 2
					$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
					
					$this->load->model('report/stat2');
					$stat2_results = array();
					$nstat2_results = array();
					//$stat2_minmax = array();
					
					$stat2_roo = array("1.T 體溫 /℃","2.P 脈搏/每分鐘", "3.R 呼吸/每分鐘","4.親餵時間：分鐘","5.瓶餵食量：CC","6.瓶餵配方奶量：CC","7.瓶餵母奶量：CC","8.母奶點班庫存量","9.母奶交班庫存量","10.體重：公克","11.小便次數","12.大便次數","13.黃疸值：mg/dL","14.母嬰同室時間：分鐘");
					
					foreach ($childinfos as $key => $childinfo) {
						$qstat2data = array(
							//'filter_date_start'	     => $filter_date_start, 
							//'filter_date_end'	     => $filter_date_end, 
							'filter_child_id' => $childinfo['child_id']
							//'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
							//'limit'                  => $this->config->get('config_admin_limit')
						);
						if ($this->model_report_stat2->getTotalNurse3bs($qstat2data)) {
							$stat2_results[$key] = $this->model_report_stat2->getNurse3bs($qstat2data);
							$perpageitem = 9;
							$totalpage = ceil(count($stat2_results[$key])/$perpageitem);
							$nstat2_results = array_chunk($stat2_results[$key], $perpageitem);
							//print"<pre>";print_r($nstat2_results);print"</pre>";exit;
							//$stat2_minmax[$key] = $this->model_report_stat2->getNurse3bsminmax($qstat2data);
							
							for ($i=0;$i<$totalpage;$i++) {
								foreach ($stat2_roo as $ro2 => $ro2data) {
									$stat2rowdata[$key][$i][$ro2]['content'] = array($ro2data);
								}
								
								$stat2firstrow[$key][$i]['content'][0] = "";
								$stat2firstrow[$key][$i]['span'][0] = "1";
								$stat2toprow[$key][$i]['content'][0] = "項目";
									
								$dd = array();
								
						 		  foreach ($nstat2_results[$i] as $d) {
									$dd[] = $d['date_added'];
								  }
								  $cdv[$i] = array_count_values($dd);								  

								 foreach ($nstat2_results[$i] as $m => $nurse3b) {
									//toprow
									$stat2toprow[$key][$i]['content'][] = $nurse3b['arrangement'];
								 
									//firstrow
									if ($m==0) {
										$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
										$stat2firstrow[$key][$i]['span'][] = $cdv[$i][$nurse3b['date_added']];
										$c = $cdv[$i][$nurse3b['date_added']];
									}
									
									if ($m<>0 AND ($m-$c)%3==0) {
										$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
										if (count($stat2_results[$key])-$m<3) {
											$stat2firstrow[$key][$i]['span'][] = count($stat2_results[$key])-$m;
										} else {
											$stat2firstrow[$key][$i]['span'][] = $cdv[$i][$nurse3b['date_added']];
										}
									}
									
									/*
									if ($m==0) {
											if ($nurse3b['arrangement']=="白班") {
												$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
												$stat2firstrow[$key][$i]['span'][] = 3;
												$c = 3;
											} elseif ($nurse3b['arrangement']=="小夜") {
												$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
												$stat2firstrow[$key][$i]['span'][] = 2;
												$c = 2;
											} elseif ($nurse3b['arrangement']=="大夜") {
												$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
												$stat2firstrow[$key][$i]['span'][] = 1;
												$c = 1;
											}
									}
									if ($m<>0 AND ($m-$c)%3==0) {
												$stat2firstrow[$key][$i]['content'][] = $nurse3b['date_added'];
												if (count($stat2_results[$key])-$m<3) {
													$stat2firstrow[$key][$i]['span'][] = count($stat2_results[$key])-$m;
												} else {
													$stat2firstrow[$key][$i]['span'][] = 3;
												}
									}
									*/
										
									//datarow
									$stat2rowdata[$key][$i][0]['content'][] = $nurse3b['chk1'];
									$stat2rowdata[$key][$i][1]['content'][] = $nurse3b['chk2'];
									$stat2rowdata[$key][$i][2]['content'][] = $nurse3b['chk3'];
									$stat2rowdata[$key][$i][3]['content'][] = $nurse3b['chk4'];
									$stat2rowdata[$key][$i][4]['content'][] = $nurse3b['chk5'];
									$stat2rowdata[$key][$i][5]['content'][] = $nurse3b['chk6'];
									$stat2rowdata[$key][$i][6]['content'][] = $nurse3b['chk7'];
									$stat2rowdata[$key][$i][7]['content'][] = $nurse3b['chk8'];
									$stat2rowdata[$key][$i][8]['content'][] = $nurse3b['chk9'];
									$stat2rowdata[$key][$i][9]['content'][] = $nurse3b['chk10'];
									$stat2rowdata[$key][$i][10]['content'][] = $nurse3b['chk11'];
									$stat2rowdata[$key][$i][11]['content'][] = $nurse3b['chk12'];
									$stat2rowdata[$key][$i][12]['content'][] = $nurse3b['chk13'];
									$stat2rowdata[$key][$i][13]['content'][] = $nurse3b['chk14'];
								}
							}

							for ($n=0;$n<$totalpage;$n++) {
								$this->model_tool_worddoc->addParagraph("統計表格2&#09;&#09;嬰兒:".$childinfo['name']."&#09;&#09;(第".($n+1)."頁)", $titleFormat);
								$this->model_tool_worddoc->startTable();
								$this->model_tool_worddoc->addTableRow($stat2firstrow[$key][$n]);
								$this->model_tool_worddoc->addTableRow($stat2toprow[$key][$n]);
								foreach ($stat2rowdata[$key][$n] as $row) {
									$this->model_tool_worddoc->addTableRow($row);
								}
								$this->model_tool_worddoc->endTable();
								if ($n+1<$totalpage) {
									$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								}
							}
							
	
							if ($key+1<count($childinfos)) {
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
							}
						}

					}
					
				
				} //統計表格 2
				
//++++ 醫師 1E 2E 表單 (For Child) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
				
				//if ( $this->request->get['1e'] == "true" ) { //1E嬰兒入住醫師評估
				if ($this->request->get['1e'] == "true" OR $this->request->get['2e'] == "true") {
				
					foreach ($childinfos as $key => $childinfo) {					
						$this->load->model('doctor/childdoctor1');
						$childdoctor_info = $this->model_doctor_childdoctor1->getChildDoctor($childinfo['child_id']);
						$this->load->model('doctor/childdoctor2');
						$child_doctor2_infos = $this->model_doctor_childdoctor2->getChildDoctor2s($childinfo['child_id']);
						
						if (!empty($childdoctor_info)) {	//1E嬰兒入住醫師評估
							$this->load->model('service/customer_service');
							$doctor_name = $this->model_service_customer_service->getCustomerServiceName($childdoctor_info['doctor_id']);
						
							$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
							$this->model_tool_worddoc->addParagraph("1E嬰兒入住醫師評估單：".$childdoctor_info['date_added']."&#09;&#09;醫師：".$doctor_name, $titleFormat);
							$this->model_tool_worddoc->addParagraph("表格 1");
							
							$this->model_tool_worddoc->startTable();
							foreach ($tablerows[$key] as $row) {
								$this->model_tool_worddoc->addTableRow($row);
							}
							$this->model_tool_worddoc->endTable();
						
							$this->model_tool_worddoc->addParagraph('');
							
							if ($childdoctor_info['chk1']<>'') {
								$this->model_tool_worddoc->addParagraph("黃疸值：".$childdoctor_info['chk1']." mg/dL");
							}
							if ($childdoctor_info['chk2']<>'') {
								$c2 = explode(':', $childdoctor_info['chk2']);
								if ($c2[0] == "有") { $chk2 = $c2[0];  $chk2_other = '，部位：'.$c2[1]; } 
								else { $chk2 = $c2[0];  $chk2_other = ''; } 
								$this->model_tool_worddoc->addParagraph("皮下出血點：".$chk2.$chk2_other);
							}
							if ($childdoctor_info['chk3']<>'') {
								$c3 = explode(':', $childdoctor_info['chk3']);
								if ($c3[0] == "有") { $chk3 = $c3[0];  $chk3_other = '，部位：'.$c3[1]; } 
								else { $chk3 = $c3[0];  $chk3_other = ''; } 
								$this->model_tool_worddoc->addParagraph("頭皮血腫：".$chk3.$chk3_other);
							}
							if ($childdoctor_info['chk4']<>'') {
								$c4 = explode(':', $childdoctor_info['chk4']);
								if ($c4[0] == "有") { $chk4 = $c4[0];  $chk4_other = '，部位及大小：'.$c4[1]; } 
								else { $chk4 = $c4[0];  $chk4_other = ''; } 
								$this->model_tool_worddoc->addParagraph("產瘤：".$chk4.$chk4_other);
							}
							if ($childdoctor_info['chk5']<>'') {
								$c5 = explode(':', $childdoctor_info['chk5']);
								if ($c5[0] == "有") { $chk5 = $c5[0];  $chk5_other = '，部位：'.$c5[1]; } 
								else { $chk5 = $c5[0];  $chk5_other = ''; } 
								$this->model_tool_worddoc->addParagraph("微血管瘤：".$chk5.$chk5_other);
							}
							if ($childdoctor_info['chk6']<>'') {
								$c6 = explode(':', $childdoctor_info['chk6']);
								if ($c6[0] == "有") { $chk6 = $c6[0];  $chk6_other = '，部位：'.$c6[1]; } 
								else { $chk6 = $c6[0];  $chk6_other = ''; } 
								$this->model_tool_worddoc->addParagraph("異位性皮膚炎：".$chk6.$chk6_other);
							}
							if ($childdoctor_info['chk7']<>'') {
								$this->model_tool_worddoc->addParagraph("嘴唇發紺：".$childdoctor_info['chk7']);
							}
							if ($childdoctor_info['chk8']<>'') {
								$this->model_tool_worddoc->addParagraph("四肢發紺：".$childdoctor_info['chk8']);
							}
							if ($childdoctor_info['chk9']<>'') {
								$this->model_tool_worddoc->addParagraph("尿布疹：".$childdoctor_info['chk9']);
							}
							if ($childdoctor_info['chk10']<>'') {
								$this->model_tool_worddoc->addParagraph("包皮發炎：".$childdoctor_info['chk10']);
							}
							if ($childdoctor_info['chk11']<>'') {
								$this->model_tool_worddoc->addParagraph("臍帶發炎：".$childdoctor_info['chk11']);
							}
							if ($childdoctor_info['chk12']<>'') {
								$this->model_tool_worddoc->addParagraph("頭部外型：".$childdoctor_info['chk12']);
							}
							if ($childdoctor_info['chk13']<>'') {
								$this->model_tool_worddoc->addParagraph("結膜出血：".$childdoctor_info['chk13']);
							}
							if ($childdoctor_info['chk14']<>'') {
								$this->model_tool_worddoc->addParagraph("粟粒疹：".$childdoctor_info['chk14']);
							}
							if ($childdoctor_info['chk15']<>'') {
								$this->model_tool_worddoc->addParagraph("兔唇：".$childdoctor_info['chk15']);
							}
							if ($childdoctor_info['chk16']<>'') {
								$this->model_tool_worddoc->addParagraph("顎裂：".$childdoctor_info['chk16']);
							}
							if ($childdoctor_info['chk17']<>'') {
								$this->model_tool_worddoc->addParagraph("斜頸：".$childdoctor_info['chk17']);
							}
							if ($childdoctor_info['chk18']<>'') {
								$this->model_tool_worddoc->addParagraph("鎖骨斷裂：".$childdoctor_info['chk18']);
							}
							if ($childdoctor_info['chk19']<>'') {
								$c19 = explode(':', $childdoctor_info['chk19']);
								if ($c19[0] == "有") { $chk19 = $c19[0];  $chk19_other = '，大小：'.$c19[1]; } 
								else { $chk19 = $c19[0];  $chk19_other = ''; } 
								$this->model_tool_worddoc->addParagraph("頸部硬塊：".$chk19.$chk19_other);
							}
							if ($childdoctor_info['chk20']<>'') {
								$this->model_tool_worddoc->addParagraph("兩手活動：".$childdoctor_info['chk20']);
							}
							if ($childdoctor_info['chk21']<>'') {
								$this->model_tool_worddoc->addParagraph("副乳：".$childdoctor_info['chk21']);
							}
							if ($childdoctor_info['chk22']<>'') {
								$this->model_tool_worddoc->addParagraph("胸廓外型：".$childdoctor_info['chk22']);
							}
							if (is_array($c23 = unserialize($childdoctor_info['chk23'])) AND !empty($c23)) {
								$text23 = '';
								foreach ($c23 as $k => $data) {
									if ($k+1!=count($c23)) {
										$text23 .= $data.",";
									} else {
										$text23 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("呼吸聲：".$text23);
							}
							if (is_array($c24 = unserialize($childdoctor_info['chk24'])) AND !empty($c24)) {
								$text24 = '';
								foreach ($c24 as $k => $data) {
									if ($k+1!=count($c24)) {
										$text24 .= $data.",";
									} else {
										$text24 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("心跳聲：".$text24);
							}
							if ($childdoctor_info['chk25']<>'') {
								$this->model_tool_worddoc->addParagraph("腹部外型：".$childdoctor_info['chk25']);
							}
							if ($childdoctor_info['chk26']<>'') {
								$this->model_tool_worddoc->addParagraph("腹脹：".$childdoctor_info['chk26']);
							}
							if ($childdoctor_info['chk27']<>'') {
								$this->model_tool_worddoc->addParagraph("兩腳活動：".$childdoctor_info['chk27']);
							}
							if ($childdoctor_info['chk28']<>'') {
								$this->model_tool_worddoc->addParagraph("兩腳等長：".$childdoctor_info['chk28']);
							}
							if (is_array($c29 = unserialize($childdoctor_info['chk29'])) AND !empty($c29)) {
								$text29 = '';
								foreach ($c29 as $k => $data) {
									if ($k+1!=count($c29)) {
										$text29 .= $data.",";
									} else {
										$text29 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("大陰唇紅腫：".$text29);
							}
							if (is_array($c30 = unserialize($childdoctor_info['chk30'])) AND !empty($c30)) {
								$text30 = '';
								foreach ($c30 as $k => $data) {
									if ($k+1!=count($c30)) {
										$text30 .= $data.",";
									} else {
										$text30 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("陰囊水腫：".$text30);
							}
							if (is_array($c31 = unserialize($childdoctor_info['chk31'])) AND !empty($c31)) {
								$text31 = '';
								foreach ($c31 as $k => $data) {
									if ($k+1!=count($c31)) {
										$text31 .= $data.",";
									} else {
										$text31 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("疝氣：".$text31);
							}
							if (is_array($c32 = unserialize($childdoctor_info['chk32'])) AND !empty($c32)) {
								$text32 = '';
								foreach ($c32 as $k => $data) {
									if ($k+1!=count($c32)) {
										$text32 .= $data.",";
									} else {
										$text32 .= $data;
									}
								}
								$this->model_tool_worddoc->addParagraph("隱睪症：".$text32);
							}
							if ($childdoctor_info['chk33']<>'') {
								$this->model_tool_worddoc->addParagraph("其他事項：<br />".nl2br($childdoctor_info['chk33']));
							}
						} //1E嬰兒入住醫師評估
						
						if (!empty($child_doctor2_infos)) {	//2E小兒科醫師巡診單
							foreach ($child_doctor2_infos as $childdoctor_info) {
								$this->load->model('service/customer_service');
								$doctor_name = $this->model_service_customer_service->getCustomerServiceName($childdoctor_info['doctor_id']);
							
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								$this->model_tool_worddoc->addParagraph("2E小兒科醫師巡診單：".$childdoctor_info['date_added']."&#09;&#09;醫師：".$doctor_name, $titleFormat);
								$this->model_tool_worddoc->addParagraph("表格 1");
								
								$this->model_tool_worddoc->startTable();
								foreach ($tablerows[$key] as $row) {
									$this->model_tool_worddoc->addTableRow($row);
								}
								$this->model_tool_worddoc->endTable();
							
								$this->model_tool_worddoc->addParagraph('');
								
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
							}
						} //2E小兒科醫師巡診單
					} 
				} 
				
//++++ 醫師 3E 表單 (For Customer) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

				if ($this->request->get['3e'] == "true") {	// 3E 婦產科巡診
					$this->load->model('doctor/childdoctor3');
					$customer_doctor_infos = $this->model_doctor_childdoctor3->getCustomerDoctor3s($customer_info['customer_id']);
					
					foreach ($customer_doctor_infos as $doctor3_info) {
						$this->load->model('service/customer_service');
						$doctor_name = $this->model_service_customer_service->getCustomerServiceName($doctor3_info['doctor_id']);
						
						$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
						$this->model_tool_worddoc->addParagraph("3E婦產科醫師巡診單：".$doctor3_info['date_added']."&#09;&#09;醫師：".$doctor_name, $titleFormat);
						$this->model_tool_worddoc->addParagraph("表格 1");
						
						foreach ($tablerows as $tablerow) {
							$this->model_tool_worddoc->startTable();
							foreach ($tablerow as $row) {
								$this->model_tool_worddoc->addTableRow($row);
							}
							$this->model_tool_worddoc->endTable();
						}
						
						$this->model_tool_worddoc->addParagraph('');
						
						if ($doctor3_info['chk1']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦意識狀況為：".$doctor3_info['chk1']);
						}
						if ($doctor3_info['chk2']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦乳房狀況為：".$doctor3_info['chk2']);
						}
						if ($doctor3_info['chk3']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦乳暈狀況為：".$doctor3_info['chk3']);
						}
						if ($doctor3_info['chk4']<>'') {
							$this->model_tool_worddoc->addParagraph("宮底位置為：".$doctor3_info['chk4']);
						}
						if ($doctor3_info['chk5']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦生產方式為：".$doctor3_info['chk5']);
						}
						if (is_array($c6 = unserialize($doctor3_info['chk6'])) AND !empty($c6)) {
							$text6 = '';
							foreach ($c6 as $k => $data) {
								if ($k+1!=count($c6)) {
									$text6 .= $data.",";
								} else {
									$text6 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("傷口狀況為：".$text6);
						}
						if (is_array($c7 = unserialize($doctor3_info['chk7'])) AND !empty($c7)) {
							$text7 = '';
							foreach ($c7 as $k => $data) {
								if ($k+1!=count($c7)) {
									$text7 .= $data.",";
								} else {
									$text7 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("產婦本日感冒症狀為：".$text7);
						}
						if (is_array($c8 = unserialize($doctor3_info['chk8'])) AND !empty($c8)) {
							$text8 = '';
							foreach ($c8 as $k => $data) {
								if ($k+1!=count($c8)) {
									$text8 .= $data.",";
								} else {
									$text8 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("產婦本日有腸胃炎症狀為：".$text8);
						}
						if (is_array($c9 = unserialize($doctor3_info['chk9'])) AND !empty($c9)) {
							$text9 = '';
							foreach ($c9 as $k => $data) {
								if ($k+1!=count($c9)) {
									$text9 .= $data.",";
								} else {
									$text9 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("產婦皮膚有紅疹部位為：".$text9);
						}
						if ($doctor3_info['chk10']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦有服藥，藥物為：".$doctor3_info['chk10']);
						}
						if ($doctor3_info['supplement']<>'') {
							$this->model_tool_worddoc->addParagraph("特別補充事項：<br />".nl2br($doctor3_info['supplement']));
						}

					}
				} // 3E 婦產科巡診
				
				
//++++ B 組表單 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

				if ($this->request->get['1b'] == "true" ) { //1B 護理人員嬰兒入住身評紀錄單
					foreach ($childinfos as $key => $childinfo) {		
						$this->load->model('nurse/nurse1b');
						$nurse1b = $this->model_nurse_nurse1b->getNurse1b($childinfo['child_id']);
						
						if (!empty($nurse1b)) {
								$this->load->model('service/customer_service');
								$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse1b['nurse_id']);
								
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								$this->model_tool_worddoc->addParagraph("1B護理人員嬰兒入住身評紀錄單：".$nurse1b['date_added'], $titleFormat);
								$this->model_tool_worddoc->addParagraph("表格 1");

								$this->model_tool_worddoc->startTable();
								foreach ($tablerows[$key] as $row) {
									$this->model_tool_worddoc->addTableRow($row);
								}
								$this->model_tool_worddoc->endTable();
								
								$this->model_tool_worddoc->addParagraph("");
								
								$content1bs = array();
								
								if ($nurse1b['chk1']<>"") {
										$content1bs[] = "嬰兒入住時胸圍：".$nurse1b['chk1']." 公分";
								}
								if ($nurse1b['chk2']<>"") {
										$content1bs[] = "體溫：".$nurse1b['chk2']." ℃";
								}
								if ($nurse1b['chk3']<>"") {
										$content1bs[] = "脈搏：".$nurse1b['chk3']." 次／分鐘";
								}
								if ($nurse1b['chk4']<>"") {
										$content1bs[] = "呼吸：".$nurse1b['chk4']." 次／分鐘";
								}
								if ($nurse1b['chk5']<>"") {
										$content1bs[] = "含氧濃度：".$nurse1b['chk5']." %";
								}
								if ($nurse1b['chk6']<>"") {
										$content1bs[] = "黃疸數值：".$nurse1b['chk6']." mg/dL";
								}
								if (is_array($c7 = unserialize($nurse1b['chk7'])) AND !empty($c7)) {
										$text7 = '';
										foreach ($c7 as $k => $data) {
											if ($k+1!=count($c7)) {
												$text7 .= $data.",";
											} else {
												$text7 .= $data;
											}
										}
										$content1bs[] = "已預防注射：".$text7;
								}
								if ($nurse1b['chk8']<>"") {
										$content1bs[] = "腦部超音波檢查：".$nurse1b['chk8'];
								}
								if ($nurse1b['chk9']<>"") {
										$content1bs[] = "心臟超音波：".$nurse1b['chk9'];
								}
								if ($nurse1b['chk10']<>"") {
										$content1bs[] = "腎臟超音波：".$nurse1b['chk10'];
								}
								if ($nurse1b['chk11']<>"") {
									$c11 = explode(':', $nurse1b['chk11']);
									if ($c11[0] == "未做") { $chk11 = $c11[0];  $chk11_other = '，預定日期為：'.$c11[1]; } 
									else { $chk11 = $c11[0];  $chk11_other = ''; } 
									
									$content1bs[] = "新生兒篩檢：".$chk11.$chk11_other;
								}
								if ($nurse1b['chk12']<>"") {
										$content1bs[] = "飲食習慣：".$nurse1b['chk12'];
								}
								if ($nurse1b['chk13']<>"") {
										$content1bs[] = "姿勢行為：".$nurse1b['chk13'];
								}
								if ($nurse1b['chk14']<>"") {
										$content1bs[] = "手足發紺：".$nurse1b['chk14'];
								}
								if ($nurse1b['chk15']<>"") {
										$content1bs[] = "嘴唇發紺：".$nurse1b['chk15'];
								}
								if ($nurse1b['chk16']<>"") {
										$content1bs[] = "大理石皮膚：".$nurse1b['chk16'];
								}
								if ($nurse1b['chk17']<>"") {
										$content1bs[] = "生理性黃疸：".$nurse1b['chk17'];
								}
								if (is_array($c18 = unserialize($nurse1b['chk18'])) AND !empty($c18)) {
										$text18 = '';
										foreach ($c18 as $k => $data) {
											if ($k+1!=count($c18)) {
												$text18 .= $data.",";
											} else {
												$text18 .= $data;
											}
										}
										$content1bs[] = "瘀斑或瘀點：".$text18;
								}
								if (is_array($c19 = unserialize($nurse1b['chk19'])) AND !empty($c19)) {
										$text19 = '';
										foreach ($c19 as $k => $data) {
											if ($k+1!=count($c19)) {
												$text19 .= $data.",";
											} else {
												$text19 .= $data;
											}
										}
										$content1bs[] = "蒙古斑：".$text19;
								}
								if (is_array($c20 = unserialize($nurse1b['chk20'])) AND !empty($c20)) {
										$text20 = '';
										foreach ($c20 as $k => $data) {
											if ($k+1!=count($c20)) {
												$text20 .= $data.",";
											} else {
												$text20 .= $data;
											}
										}
										$content1bs[] = "粟粒疹：".$text20;
								}
								if (is_array($c21 = unserialize($nurse1b['chk21'])) AND !empty($c21)) {
										$text21 = '';
										foreach ($c21 as $k => $data) {
											if ($k+1!=count($c21)) {
												$text21 .= $data.",";
											} else {
												$text21 .= $data;
											}
										}
										$content1bs[] = "微血管瘤：".$text21;
								}
								if (is_array($c22 = unserialize($nurse1b['chk22'])) AND !empty($c22)) {
										$text22 = '';
										foreach ($c22 as $k => $data) {
											if ($k+1!=count($c22)) {
												$text22 .= $data.",";
											} else {
												$text22 .= $data;
											}
										}
										$content1bs[] = "毒性紅斑：".$text22;
								}
								if ($nurse1b['chk23']<>"") {
										$content1bs[] = "前囟門：".$nurse1b['chk23'];
								}
								if ($nurse1b['chk24']<>"") {
										$content1bs[] = "後囟門：".$nurse1b['chk24'];
								}
								if ($nurse1b['chk25']<>"") {
										$content1bs[] = "頭骨重疊現象：".$nurse1b['chk25'];
								}
								if ($nurse1b['chk26']<>"") {
									$c26 = explode(':', $nurse1b['chk26']);
									if ($c26[0] == "有") { $chk26 = $c26[0];  $chk26_other = '，大小：'.$c26[1].' 公分'; } 
									else { $chk26 = $c26[0];  $chk26_other = ''; } 
									
									$content1bs[] = "產瘤：".$chk26.$chk26_other;
								}
								if ($nurse1b['chk27']<>"") {
									$c27 = explode(':', $nurse1b['chk27']);
									if ($c27[0] == "有") { $chk27 = $c27[0];  $chk27_other = '，大小：'.$c27[1].'公分'; } 
									else { $chk27 = $c27[0];  $chk27_other = ''; } 
									
									$content1bs[] = "頭皮血腫：".$chk27.$chk27_other;
								}
								if ($nurse1b['chk28']<>"") {
										$content1bs[] = "結膜出血：".$nurse1b['chk28'];
								}
								if ($nurse1b['chk29']<>"") {
										$content1bs[] = "眼睛分泌物：".$nurse1b['chk29'];
								}
								if ($nurse1b['chk30']<>"") {
										$content1bs[] = "兩耳形狀對稱：".$nurse1b['chk30'];
								}
								if ($nurse1b['chk31']<>"") {
										$content1bs[] = "耳頂比眼角高：".$nurse1b['chk31'];
								}
								if ($nurse1b['chk32']<>"") {
										$content1bs[] = "鼻翼扇動：".$nurse1b['chk32'];
								}
								if ($nurse1b['chk33']<>"") {
										$content1bs[] = "魔牙：".$nurse1b['chk33'];
								}
								if ($nurse1b['chk34']<>"") {
										$content1bs[] = "鵝口瘡：".$nurse1b['chk34'];
								}
								if ($nurse1b['chk35']<>"") {
										$content1bs[] = "斜頸：".$nurse1b['chk35'];
								}
								if ($nurse1b['chk36']<>"") {
										$content1bs[] = "鎖骨骨折：".$nurse1b['chk36'];
								}
								if (is_array($c37 = unserialize($nurse1b['chk37'])) AND !empty($c37)) {
										$text37 = '';
										foreach ($c37 as $k => $data) {
											if (preg_match("/大小/i", $data)) {
												$text37 .= $data."公分,";
											} else {
												$text37 .= $data.",";
											}
										}
										$content1bs[] = "胸鎖乳頭肌腫塊：".$text37;
								}
								if ($nurse1b['chk38']<>"") {
										$content1bs[] = "魔乳：".$nurse1b['chk38'];
								}
								if ($nurse1b['chk39']<>"") {
										$content1bs[] = "雞胸：".$nurse1b['chk39'];
								}
								if ($nurse1b['chk40']<>"") {
										$content1bs[] = "漏斗胸：".$nurse1b['chk40'];
								}
								if ($nurse1b['chk41']<>"") {
										$content1bs[] = "呼吸音：".$nurse1b['chk41'];
								}
								if ($nurse1b['chk42']<>"") {
										$content1bs[] = "腹脹：".$nurse1b['chk42'];
								}
								if ($nurse1b['chk43']<>"") {
										$content1bs[] = "腸蠕動：".$nurse1b['chk43'];
								}
								if ($nurse1b['chk44']<>"") {
										$content1bs[] = "臍帶分泌物：".$nurse1b['chk44'];
								}
								if ($nurse1b['chk45']<>"") {
										$content1bs[] = "臍疝氣：".$nurse1b['chk45'];
								}
								if ($nurse1b['chk46']<>"") {
										$content1bs[] = "腹股溝疝氣：".$nurse1b['chk46'];
								}
								if (is_array($c47 = unserialize($nurse1b['chk47'])) AND !empty($c47)) {
										$text47 = '';
										foreach ($c47 as $k => $data) {
											if ($k+1!=count($c47)) {
												$text47 .= $data.",";
											} else {
												$text47 .= $data;
											}
										}
										$content1bs[] = "陰囊水腫：".$text47;
								}
								if (is_array($c48 = unserialize($nurse1b['chk48'])) AND !empty($c48)) {
										$text48 = '';
										foreach ($c48 as $k => $data) {
											if ($k+1!=count($c48)) {
												$text48 .= $data.",";
											} else {
												$text48 .= $data;
											}
										}
										$content1bs[] = "隱睪症：".$text48;
								}
								if ($nurse1b['chk49']<>"") {
										$content1bs[] = "包皮發炎：".$nurse1b['chk49'];
								}
								if ($nurse1b['chk50']<>"") {
										$content1bs[] = "大小陰唇對稱：".$nurse1b['chk50'];
								}
								if ($nurse1b['chk51']<>"") {
										$content1bs[] = "大陰唇水腫：".$nurse1b['chk51'];
								}
								if ($nurse1b['chk52']<>"") {
										$content1bs[] = "假性月經：".$nurse1b['chk52'];
								}
								if ($nurse1b['chk53']<>"") {
										$content1bs[] = "肛門口紅腫：".$nurse1b['chk53'];
								}
								if ($nurse1b['chk54']<>"") {
										$content1bs[] = "脊椎外觀：".$nurse1b['chk54'];
								}
								if ($nurse1b['chk55']<>"") {
										$content1bs[] = "臀部肌肉對稱：".$nurse1b['chk55'];
								}
								if (is_array($c56 = unserialize($nurse1b['chk56'])) AND !empty($c56)) {
										$text56 = '';
										foreach ($c56 as $k => $data) {
											if ($k+1!=count($c56)) {
												$text56 .= $data.",";
											} else {
												$text56 .= $data;
											}
										}
										$content1bs[] = "手指腳趾數目：".$text56;
								}
								if ($nurse1b['chk57']<>"") {
										$content1bs[] = "長度對稱：".$nurse1b['chk57'];
								}
								if ($nurse1b['chk58']<>"") {
										$content1bs[] = "斷掌：".$nurse1b['chk58'];
								}
								if ($nurse1b['chk59']<>"") {
										$content1bs[] = "臂神經受損：".$nurse1b['chk59'];
								}
								if ($nurse1b['chk60']<>"") {
										$content1bs[] = "關節活動正常：".$nurse1b['chk60'];
								}
								if ($nurse1b['chk61']<>"") {
										$content1bs[] = "肌肉張力：".$nurse1b['chk61'];
								}
								if ($nurse1b['chk62']<>"") {
										$content1bs[] = "尋乳反射：".$nurse1b['chk62'];
								}
								if ($nurse1b['chk63']<>"") {
										$content1bs[] = "吸吮反射：".$nurse1b['chk63'];
								}
								if ($nurse1b['chk64']<>"") {
										$content1bs[] = "抓握反射：".$nurse1b['chk64'];
								}
								if ($nurse1b['chk65']<>"") {
										$content1bs[] = "巴賓斯基反射：".$nurse1b['chk65'];
								}
								if ($nurse1b['chk66']<>"") {
										$content1bs[] = "驚嚇反射：".$nurse1b['chk66'];
								}
								if ($nurse1b['chk67']<>'') {
										$content1bs[] = "備註：<br />".nl2br($nurse1b['chk67']);
								}
								
								foreach ($content1bs as $ck => $content) {
									if ($content <> '') {
										$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
									}
								}
								
							$this->model_tool_worddoc->addParagraph("");
							$this->model_tool_worddoc->addParagraph("護理人員簽名：".$nurse_name);
							$this->model_tool_worddoc->addParagraph("家屬簽名：");
						}
					}
				} //1B 護理人員嬰兒入住身評紀錄單

				if ($this->request->get['2b'] == "true" OR $this->request->get['3b'] == "true" OR $this->request->get['4b'] == "true") {
					$arra = array("白班", "小夜", "大夜");
					
					foreach ($childinfos as $key => $childinfo) {	
						$this->load->model('nurse/nurse');
						$minmax = $this->model_nurse_nurse->getNurse234bminmax($childinfo['child_id']);
						
						if (version_compare(phpversion(), '5.3.0', '<') == true) {
							$datary = $this->model_nurse_nurse->createDateRangeArray($minmax['mindate'], $minmax['maxdate'], $arra);
						} else {
							$datary = $this->model_nurse_nurse->getDateRangeArray($minmax['mindate'], $minmax['maxdate'], $arra);
						}
						
						foreach ($datary['date'] as $dk => $date) {
							$nurse2b_info = $this->model_nurse_nurse->getNurse2bByDateArrange($date, $datary['arrangement'][$dk], $childinfo['child_id']);
							$nurse3b_info = $this->model_nurse_nurse->getNurse3bByDateArrange($date, $datary['arrangement'][$dk], $childinfo['child_id']);
							$nurse4b_info = $this->model_nurse_nurse->getNurse4bByDateArrange($date, $datary['arrangement'][$dk], $childinfo['child_id']);
							
							if (!empty($nurse2b_info) AND is_array($nurse2b_info)) {	//2B 接班評估
								$this->load->model('service/customer_service');
								$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse2b_info['nurse_id']);
								
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								$this->model_tool_worddoc->addParagraph("2B護理人員接班評估單：".$nurse2b_info['date_added']."，班別：".$nurse2b_info['arrangement']."，護理人員：".$nurse_name, $titleFormat);
								$this->model_tool_worddoc->addParagraph("表格 1");
								
								$this->model_tool_worddoc->startTable();
								foreach ($tablerows[$key] as $row) {
									$this->model_tool_worddoc->addTableRow($row);
								}
								$this->model_tool_worddoc->endTable();
								
								$this->model_tool_worddoc->addParagraph("");
								
								$contents = array();
				
								if ($nurse2b_info['chk1']<>"") {
										$contents[] = "寶寶一般情形：".$nurse2b_info['chk1'];
								}
								if ($nurse2b_info['chk2']<>"") {
										$contents[] = "活動力：".$nurse2b_info['chk2'];
								}
								if ($nurse2b_info['chk3']<>"") {
										$contents[] = "食慾：".$nurse2b_info['chk3'];
								}
								if ($nurse2b_info['chk4']<>"") {
										$contents[] = "體溫：".$nurse2b_info['chk4']." ℃";
								}
								if ($nurse2b_info['chk5']<>"") {
										$contents[] = "心跳：".$nurse2b_info['chk5']." 每分鐘";
								}
								if ($nurse2b_info['chk6']<>"") {
										$contents[] = "呼吸：".$nurse2b_info['chk6']." 每分鐘";
								}
								if ($nurse2b_info['chk7']<>"") {
										$contents[] = "黃疸數值為：".$nurse2b_info['chk7']." mg/dL";
								}
								if ($nurse2b_info['chk8']<>"") {
										$contents[] = "血氣飽和濃度為：".$nurse2b_info['chk8']." %";
								}
								if ($nurse2b_info['chk9']<>"") {
										$contents[] = "嘴唇顏色：".$nurse2b_info['chk9'];
								}
								if ($nurse2b_info['chk10']<>"") {
										$contents[] = "四肢活動力：".$nurse2b_info['chk10'];
								}
								if (is_array($c11 = unserialize($nurse2b_info['chk11'])) AND !empty($c11)) {
										$text11 = '';
										foreach ($c11 as $k => $data) {
											if ($k+1!=count($c11)) {
												$text11 .= $data.",";
											} else {
												$text11 .= $data;
											}
										}
										$contents[] = "外觀情形為：".$text11;
								}
								if (is_array($c12 = unserialize($nurse2b_info['chk12'])) AND !empty($c12)) {
										$text12 = '';
										foreach ($c12 as $k => $data) {
											if ($k+1!=count($c12)) {
												$text12 .= $data.",";
											} else {
												$text12 .= $data;
											}
										}
										$contents[] = "眼睛狀況為：".$text12;
								}
								if (is_array($c13 = unserialize($nurse2b_info['chk13'])) AND !empty($c13)) {
										$text13 = '';
										foreach ($c13 as $k => $data) {
											if (preg_match("/先天畸形/i", $data)) {
												$text13 .= $data.",";
											} else {
												$text13 .= $data.",";
											}
										}
										$contents[] = "口腔情形為：".$text13;
								}
								if (is_array($c14 = unserialize($nurse2b_info['chk14'])) AND !empty($c14)) {
										$text14 = '';
										foreach ($c14 as $k => $data) {
											if ($k+1!=count($c14)) {
												$text14 .= $data.",";
											} else {
												$text14 .= $data;
											}
										}
										$contents[] = "皮膚狀況為：".$text14;
								}
								if (is_array($c15 = unserialize($nurse2b_info['chk15'])) AND !empty($c15)) {
										$text15 = '';
										foreach ($c15 as $k => $data) {
											if ($k+1!=count($c15)) {
												$text15 .= $data.",";
											} else {
												$text15 .= $data;
											}
										}
										$contents[] = "腹部外觀：".$text15;
								}
								if ($nurse2b_info['chk16']<>"") {
										$contents[] = "臍帶：".$nurse2b_info['chk16'];
								}
								if (is_array($c17 = unserialize($nurse2b_info['chk17'])) AND !empty($c17)) {
										$text17 = '';
										foreach ($c17 as $k => $data) {
											if ($k+1!=count($c17)) {
												$text17 .= $data.",";
											} else {
												$text17 .= $data;
											}
										}
										$contents[] = "臍帶分泌物為：".$text17;
								}
								if (is_array($c18 = unserialize($nurse2b_info['chk18'])) AND !empty($c18)) {
										$text18 = '';
										foreach ($c18 as $k => $data) {
											if ($k+1!=count($c18)) {
												$text18 .= $data.",";
											} else {
												$text18 .= $data;
											}
										}
										$contents[] = "陰部狀況為：".$text18;
								}
								if (is_array($c19 = unserialize($nurse2b_info['chk19'])) AND !empty($c19)) {
										$text19 = '';
										foreach ($c19 as $k => $data) {
											if ($k+1!=count($c19)) {
												$text19 .= $data.",";
											} else {
												$text19 .= $data;
											}
										}
										$contents[] = "睪丸狀況為：".$text19;
								}
								if (is_array($c20 = unserialize($nurse2b_info['chk20'])) AND !empty($c20)) {
										$text20 = '';
										foreach ($c20 as $k => $data) {
											if ($k+1!=count($c20)) {
												$text20 .= $data.",";
											} else {
												$text20 .= $data;
											}
										}
										$contents[] = "肛門口附近：".$text20;
								}
								
								
								if ($nurse2b_info['chk21']<>"") {
										$contents[] = "尿布疹：".$nurse2b_info['chk21'];
								}								
								if ($nurse2b_info['chk22']<>"") {
										$contents[] = "寶寶目前在：".$nurse2b_info['chk22'];
								}		
								if ($nurse2b_info['chk23']<>'') {
										$contents[] = "特別補充：<br />".nl2br($nurse2b_info['chk23']);
								}
								
								foreach ($contents as $ck => $content) {
									if ($content <> '') {
										$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
									}
								}
								

							}	//2B 接班評估
							
							if (!empty($nurse3b_info) AND is_array($nurse3b_info)) {	//3B IO 紀錄
								$this->load->model('service/customer_service');
								$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse3b_info['nurse_id']);
								
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								$this->model_tool_worddoc->addParagraph("3B嬰兒室 I/O 紀錄單：".$nurse3b_info['date_added']."，班別：".$nurse3b_info['arrangement']."，護理人員：".$nurse_name, $titleFormat);
								$this->model_tool_worddoc->addParagraph("表格 1");
								
								$this->model_tool_worddoc->startTable();
								foreach ($tablerows[$key] as $row) {
									$this->model_tool_worddoc->addTableRow($row);
								}
								$this->model_tool_worddoc->endTable();
								
								$this->model_tool_worddoc->addParagraph("");
								
								//表格2
								$table2 = array();
								
								$table2[]['content'] = array("項目", "");
								
								if ($nurse3b_info['chk1']<>"") {
									$table2[]['content'] = array("1.T 體溫/℃", $nurse3b_info['chk1']);
								}
								if ($nurse3b_info['chk2']<>"") {
									$table2[]['content'] = array("2.P 脈搏/每分鐘", $nurse3b_info['chk2']);
								}
								if ($nurse3b_info['chk3']<>"") {
									$table2[]['content'] = array("3.R 呼吸/每分鐘", $nurse3b_info['chk3']);
								}
								if ($nurse3b_info['chk4']<>"") {
									$table2[]['content'] = array("4.親餵時間：分鐘", $nurse3b_info['chk4']);
								}
								if ($nurse3b_info['chk5']<>"") {
									$table2[]['content'] = array("5.瓶餵食量：CC", $nurse3b_info['chk5']);
								}
								if ($nurse3b_info['chk6']<>"") {
									$table2[]['content'] = array("6.瓶餵配方奶量：CC", $nurse3b_info['chk6']);
								}
								if ($nurse3b_info['chk7']<>"") {
									$table2[]['content'] = array("7.瓶餵母奶量：CC", $nurse3b_info['chk7']);
								}
								if ($nurse3b_info['chk8']<>"") {
									$table2[]['content'] = array("8.母奶點班庫存量", $nurse3b_info['chk8']);
								}
								if ($nurse3b_info['chk9']<>"") {
									$table2[]['content'] = array("9.母奶交班庫存量", $nurse3b_info['chk9']);
								}
								if ($nurse3b_info['chk10']<>"") {
									$table2[]['content'] = array("10.體重：公克", $nurse3b_info['chk10']);
								}
								if ($nurse3b_info['chk11']<>"") {
									$table2[]['content'] = array("11.小便次數", $nurse3b_info['chk11']);
								}
								if ($nurse3b_info['chk12']<>"") {
									$table2[]['content'] = array("12.大便次數", $nurse3b_info['chk12']);
								}
								if ($nurse3b_info['chk13']<>"") {
									$table2[]['content'] = array("13.黃疸值：mg/dL", $nurse3b_info['chk13']);
								}
								if ($nurse3b_info['chk14']<>"") {
									$table2[]['content'] = array("14.母嬰同室時間：分鐘", $nurse3b_info['chk14']);
								}
								if ($nurse3b_info['chk15']<>"") {
									$table2[]['content'] = array("備註", $nurse3b_info['chk15']);
								}
								
								if ($table2) {
									$this->model_tool_worddoc->addParagraph("表格 2");
									$this->model_tool_worddoc->startTable();
									foreach ($table2 as $tb2) {
										$this->model_tool_worddoc->addTableRow($tb2);
									}
									$this->model_tool_worddoc->endTable();
								}
								
								$this->model_tool_worddoc->addParagraph("");
								
								//表格3
								$this->load->model('nurse/nurse3b');
								$iotables = $this->model_nurse_nurse3b->getIOTables($childinfo['child_id'], $nurse3b_info['child_nurse3b_id']);
								
								$table3 = array();
								
								$table3[0]['content'] = array("嬰兒室 I/O 紀錄");
								$table3[0]['span'] = array("2");
								$table3[1]['content'] = array("時間", "紀錄");
								foreach ($iotables as $k => $v) {
									if ($v['mommilk']<>0) {
										$table3[]['content'] = array($v['io_datetime_added'], "母奶餵食 ".$v['mommilk']." cc，並給予有效打嗝，寶寶吸吮能力可。");
									} elseif ($v['bottlemilk']<>0) {
										$table3[]['content'] = array($v['io_datetime_added'], "配方奶餵食 ".$v['bottlemilk']." cc，並給予有效打嗝，寶寶吸吮能力可。");
									} elseif ($v['babymoveto']<>'' AND $v['babymovewith']<>'') {
										if ($v['babymoveto'] == '回嬰兒室') {
											$table3[]['content'] = array($v['io_datetime_added'], "寶寶".$v['babymoveto']."，由".$v['babymovewith']."推回");
										} else {
											$table3[]['content'] = array($v['io_datetime_added'], "寶寶".$v['babymoveto']."，有".$v['babymovewith']."陪同");
										}
									} elseif ($v['stoolorurine']<>'') {
										$table3[]['content'] = array($v['io_datetime_added'], "寶寶".$v['stoolorurine']."，予更換尿布並清除肛門口周圍及臀部完成。");
									} else {
										$table3[]['content'] = array($v['io_datetime_added'], "為寶寶".$v['wash']."完成，寶寶活動力可，秤體重完成，並給予寶寶皮膚塗抹潤膚乳液，會陰部、肛門口及肚臍護理完成。");
									}
								}
								
								if ($table3) {
									$this->model_tool_worddoc->addParagraph("表格 3");
									$this->model_tool_worddoc->startTable();
									foreach ($table3 as $row) {
										$this->model_tool_worddoc->addTableRow($row);
									}
									$this->model_tool_worddoc->endTable();
								}
								
								$this->model_tool_worddoc->addParagraph("");
								
								//文字紀錄
								$contents = array();
								
								if ($nurse3b_info['chk16']<>'' || $nurse3b_info['chk16supplement']<>'') {
									if ($nurse3b_info['chk16']<>'') { 
										$contents[] = "大便性質：".$nurse3b_info['chk16'].$nurse3b_info['chk16supplement'];
									} else {
										$contents[] = $nurse3b_info['chk16supplement'];
									}
								}
								if ($nurse3b_info['chk17']<>'' || $nurse3b_info['chk17supplement']<>'') {
									if ($nurse3b_info['chk17']<>'') { 
										$contents[] = "臍帶脫落：".$nurse3b_info['chk17'].$nurse3b_info['chk17supplement'];
									} else {
										$contents[] = $nurse3b_info['chk17supplement'];
									}
								}
								if (is_array($c18 = unserialize($nurse3b_info['chk18']))  || $nurse3b_info['chk18supplement']<>'') {
									if ($c18['a']<>'' OR $c18['b']<>'' OR $c18['c']<>'') { 
										$contents[] = "於媽媽房內，親餵".$c18['a']."分鐘，更換尿布".$c18['b']."，有大小便".$c18['c']."次。".$nurse3b_info['chk18supplement'];
									} else {
										$contents[] = $nurse3b_info['chk18supplement'];
									}
								}
								if ($nurse3b_info['chk19']<>'' || $nurse3b_info['chk19supplement']<>'') {
									if ($nurse3b_info['chk19']<>'') { 
										$contents[] = $nurse3b_info['chk19']."。".$nurse3b_info['chk19supplement'];
									} else {
										$contents[] = $nurse3b_info['chk19supplement'];
									}
								}
								if ($nurse3b_info['chk20']<>'' || $nurse3b_info['chk20supplement']<>'') {
									if ($nurse3b_info['chk20']<>'') { 
										$contents[] = $nurse3b_info['chk20']."。".$nurse3b_info['chk20supplement'];
									} else {
										$contents[] = $nurse3b_info['chk20supplement'];
									}
								}
								if ($nurse3b_info['chk21']<>'' || $nurse3b_info['chk21supplement']<>'') {
									if ($nurse3b_info['chk21']<>'') { 
										$contents[] = $nurse3b_info['chk21']."。".$nurse3b_info['chk21supplement'];
									} else {
										$contents[] = $nurse3b_info['chk21supplement'];
									}
								}
								if ($nurse3b_info['chk22']<>'' || $nurse3b_info['chk22supplement']<>'') {
									if ($nurse3b_info['chk22']<>'') { 
										$contents[] = $nurse3b_info['chk22']."。".$nurse3b_info['chk22supplement'];
									} else {
										$contents[] = $nurse3b_info['chk22supplement'];
									}
								}
								if ($nurse3b_info['chk23']<>'' || $nurse3b_info['chk23supplement']<>'') {
									if ($nurse3b_info['chk23']<>'') { 
										$contents[] = "母嬰同室時間為".$nurse3b_info['chk23']."小時。".$nurse3b_info['chk23supplement'];
									} else {
										$contents[] = $nurse3b_info['chk23supplement'];
									}
								}
								if ($nurse3b_info['supplement']<>'') {
									$sarr = explode("\n", $nurse3b_info['supplement']);
									
									if (!empty($sarr)) {
										foreach ($sarr as $sar) {
											$contents[] = $sar;
										}
									}
								}
								
								foreach ($contents as $ck => $content) {
									if ($content <> '') {
										$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
									}
								}
							} 	//3B IO 紀錄
							
							if (!empty($nurse4b_info) AND is_array($nurse4b_info)) {	//4B 交班評估
								$this->load->model('service/customer_service');
								$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse4b_info['nurse_id']);
								
								$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
								$this->model_tool_worddoc->addParagraph("4B護理人員交班評估單：".$nurse4b_info['date_added']."，班別：".$nurse4b_info['arrangement']."，護理人員：".$nurse_name, $titleFormat);
								$this->model_tool_worddoc->addParagraph("");
								
								$contents = array();
								
								if ($nurse4b_info['chk1']<>'' || $nurse4b_info['chk1supplement']<>'') {
									if ($nurse4b_info['chk1']<>'') { 
										$contents[] = "本班次，寶寶一共解小便".$nurse4b_info['chk1']."次，予以更換尿布完成。".$nurse4b_info['chk1supplement'];
									} else {
										$contents[] = $nurse4b_info['chk1supplement'];
									}
								}
								
								if ($nurse4b_info['chk2']<>'' || $nurse4b_info['chk2supplement']<>'') {
									if ($nurse4b_info['chk2']<>'') { 
										$contents[] = "本班次，寶寶一共解大便".$nurse4b_info['chk2']."次，予以更換尿布完成。".$nurse4b_info['chk2supplement'];
									} else {
										$contents[] = $nurse4b_info['chk2supplement'];
									}
								}
								
								if ($nurse4b_info['chk3']<>'' || $nurse4b_info['chk3supplement']<>'') {
									if ($nurse4b_info['chk3']<>'') { 
										$contents[] = "本班次瓶餵母奶".$nurse4b_info['chk3']." cc，並給予拍背打嗝。".$nurse4b_info['chk3supplement'];
									} else {
										$contents[] = $nurse4b_info['chk3supplement'];
									}
								}
								
								if ($nurse4b_info['chk4']<>'' || $nurse4b_info['chk4supplement']<>'') {
									if ($nurse4b_info['chk4']<>'') { 
										$contents[] = "本班次瓶餵配方奶".$nurse4b_info['chk4']." cc，並給予拍背打嗝。".$nurse4b_info['chk4supplement'];
									} else {
										$contents[] = $nurse4b_info['chk4supplement'];
									}
								}
								
								if ($nurse4b_info['chk5']<>'' || $nurse4b_info['chk5supplement']<>'') {
									if ($nurse4b_info['chk5']<>'') { 
										$contents[] = "大便狀況為：".$nurse4b_info['chk5']."。".$nurse4b_info['chk5supplement'];
									} else {
										$contents[] = $nurse4b_info['chk5supplement'];
									}
								}
								
								if ($nurse4b_info['chk6']<>'' || $nurse4b_info['chk6supplement']<>'') {
									if ($nurse4b_info['chk6']<>'') { 
										$contents[] = "寶寶目前於：".$nurse4b_info['chk6']."。".$nurse4b_info['chk6supplement'];
									} else {
										$contents[] = $nurse4b_info['chk6supplement'];
									}
								}
								
								if ($nurse4b_info['supplement']<>'') {
									$sarr = explode("\n", $nurse4b_info['supplement']);
									
									if (!empty($sarr)) {
										foreach ($sarr as $sar) {
											$contents[] = $sar;
										}
									}
								}
								
								foreach ($contents as $ck => $content) {
									if ($content <> '') {
										$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
									}
								}
							} 	//4B 交班評估
						}
						
					}
					
					
				
				}



//++++ C 組表單 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
				
				if ($this->request->get['1c'] == "true" ) { //產後衛教入住身體評估
					$this->load->model('nurse/nurse1c');
					$nurse1c_info = $this->model_nurse_nurse1c->getNurse1c($customer_info['customer_id']);
					$this->load->model('service/customer_service');
					$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse1c_info['nurse_id']);
					
					$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
					$this->model_tool_worddoc->addParagraph("1C產後衛教入住身體評估單：".$nurse1c_info['date_added'], $titleFormat);
					$this->model_tool_worddoc->addParagraph("表格 1");
					
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable();
						foreach ($tablerow as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
					}
					
					if ($nurse1c_info) {
						$this->model_tool_worddoc->addParagraph('');
						
						if ($nurse1c_info['chk1']<>'') {
							$this->model_tool_worddoc->addParagraph("體溫：".$nurse1c_info['chk1']." ℃");
						}
						if ($nurse1c_info['chk2']<>'') {
							$this->model_tool_worddoc->addParagraph("脈搏：".$nurse1c_info['chk2']."（每分鐘）");
						}
						if ($nurse1c_info['chk3']<>'') {
							$this->model_tool_worddoc->addParagraph("呼吸：".$nurse1c_info['chk3']."（每分鐘）");
						}
						if ($nurse1c_info['chk4a']<>'' AND $nurse1c_info['chk4b']<>'') {
							$this->model_tool_worddoc->addParagraph("血壓：(收縮壓):".$nurse1c_info['chk4a']."mmHg&#32;(舒張壓):".$nurse1c_info['chk4b']."mmHg");
						}
						if ($nurse1c_info['chk5']<>'') {
							$this->model_tool_worddoc->addParagraph("頸部：".$nurse1c_info['chk5']);
						}
						if (is_array($c6 = unserialize($nurse1c_info['chk6'])) AND !empty($c6)) {
							$text6 = '';
							foreach ($c6 as $k => $data) {
								if ($k+1!=count($c6)) {
									$text6 .= $data.",";
								} else {
									$text6 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("眼：".$text6);
						}
						if (is_array($c7 = unserialize($nurse1c_info['chk7'])) AND !empty($c7)) {
							$text7 = '';
							foreach ($c7 as $k => $data) {
								if ($k+1!=count($c7)) {
									$text7 .= $data.",";
								} else {
									$text7 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("耳：".$text7);
						}
						if (is_array($c8 = unserialize($nurse1c_info['chk8'])) AND !empty($c8)) {
							$text8 = '';
							foreach ($c8 as $k => $data) {
								if ($k+1!=count($c8)) {
									$text8 .= $data.",";
								} else {
									$text8 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("鼻：".$text8);
						}
						if (is_array($c9 = unserialize($nurse1c_info['chk9'])) AND !empty($c9)) {
							$text9 = '';
							foreach ($c9 as $k => $data) {
								if ($k+1!=count($c9)) {
									$text9 .= $data.",";
								} else {
									$text9 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("口腔：".$text9);
						}
						if ($nurse1c_info['chk10']<>'') {
							$this->model_tool_worddoc->addParagraph("乳頭(R)：".$nurse1c_info['chk10']);
						}
						if ($nurse1c_info['chk11']<>'') {
							$this->model_tool_worddoc->addParagraph("乳頭(L)：".$nurse1c_info['chk11']);
						}
						if ($nurse1c_info['chk12']<>'') {
							$this->model_tool_worddoc->addParagraph("乳暈(R)：".$nurse1c_info['chk12']);
						}
						if ($nurse1c_info['chk13']<>'') {
							$this->model_tool_worddoc->addParagraph("乳暈(L)：".$nurse1c_info['chk13']);
						}
						if ($nurse1c_info['chk14']<>'') {
							$this->model_tool_worddoc->addParagraph("乳房(R)：".$nurse1c_info['chk14']);
						}
						if ($nurse1c_info['chk15']<>'') {
							$this->model_tool_worddoc->addParagraph("乳房(L)：".$nurse1c_info['chk15']);
						}
						if ($nurse1c_info['chk16']<>'') {
							$this->model_tool_worddoc->addParagraph("子宮位置：".$nurse1c_info['chk16']);
						}
						if ($nurse1c_info['chk17']<>'') {
							$this->model_tool_worddoc->addParagraph("子宮：".$nurse1c_info['chk17']);
						}
						if ($nurse1c_info['chk18']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露量：".$nurse1c_info['chk18']);
						}
						if ($nurse1c_info['chk19']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露顏色：".$nurse1c_info['chk19']);
						}
						if ($nurse1c_info['chk20']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露性質：".$nurse1c_info['chk20']);
						}
						if (is_array($c21 = unserialize($nurse1c_info['chk21'])) AND !empty($c21)) {
							$text21 = '';
							foreach ($c21 as $k => $data) {
								if ($k+1!=count($c21)) {
									$text21 .= $data.",";
								} else {
									$text21 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("NSD傷口：".$text21);
						}
						if (is_array($c22 = unserialize($nurse1c_info['chk22'])) AND !empty($c22)) {
							$text22 = '';
							foreach ($c22 as $k => $data) {
								if ($k+1!=count($c22)) {
									$text22 .= $data.",";
								} else {
									$text22 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("C/S傷口：".$text22);
						}
						if (is_array($c23 = unserialize($nurse1c_info['chk23'])) AND !empty($c23)) {
							$text23 = '';
							foreach ($c23 as $k => $data) {
								if ($k+1!=count($c23)) {
									$text23 .= $data.",";
								} else {
									$text23 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("排尿：".$text23);
						}
						if (is_array($c24 = unserialize($nurse1c_info['chk24'])) AND !empty($c24)) {
							$text24 = '';
							foreach ($c24 as $k => $data) {
								if ($k+1!=count($c24)) {
									$text24 .= $data.",";
								} else {
									$text24 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("胃：".$text24);
						}
						if (is_array($c25 = unserialize($nurse1c_info['chk25'])) AND !empty($c25)) {
							$text25 = '';
							foreach ($c25 as $k => $data) {
								if ($k+1!=count($c25)) {
									$text25 .= $data.",";
								} else {
									$text25 .= $data;
								}
							}
							$this->model_tool_worddoc->addParagraph("腸：".$text25);
						}
						if ($nurse1c_info['chk26']<>'') {
							$this->model_tool_worddoc->addParagraph("痔瘡：".$nurse1c_info['chk26']);
						}
						if ($nurse1c_info['chk27']<>'') {
							$this->model_tool_worddoc->addParagraph("開刀史：".$nurse1c_info['chk27']);
						}
						if ($nurse1c_info['chk28']<>'') {
							$this->model_tool_worddoc->addParagraph("重大疾病：".$nurse1c_info['chk28']);
						}
						if ($nurse1c_info['chk29']<>'') {
							$this->model_tool_worddoc->addParagraph("服生化湯：".$nurse1c_info['chk29']);
						}
						if ($nurse1c_info['chk30']<>'') {
							$this->model_tool_worddoc->addParagraph("定期服用藥物：".$nurse1c_info['chk30']);
						}
						if ($nurse1c_info['chk31']<>'') {
							$this->model_tool_worddoc->addParagraph("服用子宮收縮劑：".$nurse1c_info['chk31']);
						}
						if ($nurse1c_info['chk32']<>'') {
							$this->model_tool_worddoc->addParagraph("家人一星期內有人感冒：".$nurse1c_info['chk32']);
						}
						
						$this->model_tool_worddoc->addParagraph('');
						
						$this->model_tool_worddoc->addParagraph('護理人員簽名／日期：'.$nurse_name.'&#09;&#09;產婦簽名／日期：');
					}
					
				} //產後衛教入住身體評估
				
				
				if ($this->request->get['3c'] == "true" ) { //產後衛教跌倒因子評估
					$this->load->model('nurse/nurse3c');
					$nurse3c_infos = $this->model_nurse_nurse3c->getNurse3cs($customer_info['customer_id']);
					
					foreach ($nurse3c_infos as $nurse3c_info) {
						$this->load->model('service/customer_service');
						$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse3c_info['nurse_id']);
						
						$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
						$this->model_tool_worddoc->addParagraph("3C跌倒因子評估表：（Hendrich II 量表）", $titleFormat);
						$this->model_tool_worddoc->addParagraph("表格 1");
						
						foreach ($tablerows as $tablerow) {
							$this->model_tool_worddoc->startTable();
							foreach ($tablerow as $row) {
								$this->model_tool_worddoc->addTableRow($row);
							}
							$this->model_tool_worddoc->endTable();
						}
						
						if ($nurse3c_info) {
							$this->model_tool_worddoc->addParagraph('');
							$this->model_tool_worddoc->addParagraph("實施日期：".$nurse3c_info['date_added']);
							$this->model_tool_worddoc->addParagraph("得分：".$nurse3c_info['score_total']);
							
							$this->model_tool_worddoc->startTable();
							$tbh = array();
							$tbh['content'] = array("","是／否", "分數");
							$this->model_tool_worddoc->addTableRow($tbh);
							if ($nurse3c_info['chk1']<>'' AND $nurse3c_info['chk1_score']<>'') {
								$c1 = array();
								$c1['content'] = array("意識、定向感差", $nurse3c_info['chk1'], $nurse3c_info['chk1_score']);
								$this->model_tool_worddoc->addTableRow($c1);
							}
							if ($nurse3c_info['chk2']<>'' AND $nurse3c_info['chk2_score']<>'') {
								$c2 = array();
								$c2['content'] = array("由床或椅子站起行走有障礙", $nurse3c_info['chk2'], $nurse3c_info['chk2_score']);
								$this->model_tool_worddoc->addTableRow($c2);
							}
							if ($nurse3c_info['chk3']<>'' AND $nurse3c_info['chk3_score']<>'') {
								$c3 = array();
								$c3['content'] = array("憂鬱", $nurse3c_info['chk3'], $nurse3c_info['chk3_score']);
								$this->model_tool_worddoc->addTableRow($c3);
							}
							if ($nurse3c_info['chk4']<>'' AND $nurse3c_info['chk4_score']<>'') {
								$c4 = array();
								$c4['content'] = array("抗癲癇藥物", $nurse3c_info['chk4'], $nurse3c_info['chk4_score']);
								$this->model_tool_worddoc->addTableRow($c4);
							}
							if ($nurse3c_info['chk5']<>'' AND $nurse3c_info['chk5_score']<>'') {
								$c5 = array();
								$c5['content'] = array("失禁、頻尿、夜尿頻繁", $nurse3c_info['chk5'], $nurse3c_info['chk5_score']);
								$this->model_tool_worddoc->addTableRow($c5);
							}
							if ($nurse3c_info['chk6']<>'' AND $nurse3c_info['chk6_score']<>'') {
								$c6 = array();
								$c6['content'] = array("頭暈、昏眩", $nurse3c_info['chk6'], $nurse3c_info['chk6_score']);
								$this->model_tool_worddoc->addTableRow($c6);
							}
							if ($nurse3c_info['chk7']<>'' AND $nurse3c_info['chk7_score']<>'') {
								$c7 = array();
								$c7['content'] = array("藥物服用：利尿劑、安眠藥、降血壓藥物、姿位性低血壓藥物、鎮定劑等", $nurse3c_info['chk7'], $nurse3c_info['chk7_score']);
								$this->model_tool_worddoc->addTableRow($c7);
							}
							if ($nurse3c_info['chk8']<>'' AND $nurse3c_info['chk8_score']<>'') {
								$c8 = array();
								$c8['content'] = array("機械或環境因素：桌椅擁擠、電線纏繞在地、有尿袋", $nurse3c_info['chk8'], $nurse3c_info['chk8_score']);
								$this->model_tool_worddoc->addTableRow($c8);
							}
							$tbf = array();
							$tbf['content'] = array("分數總計／護理人員簽名", $nurse3c_info['score_total'], $nurse_name);
							$this->model_tool_worddoc->addTableRow($tbf);

							$this->model_tool_worddoc->endTable();
				
							$footerFormat = array(
											'text-align' 	=> 'center',
											//'font-weight' 	=> 'bold',
											'font-family' =>	'新細明體',
											'font-size'		=> '12pt');
											
							$this->model_tool_worddoc->addParagraph("總分：16分，高風險切截點：大於等於 5 分",  $footerFormat);
							$this->model_tool_worddoc->addParagraph("超過 5 分者，7 天後需要評估一次",  $footerFormat);
						}
					}

				} //產後衛教跌倒因子評估
				
				if ($this->request->get['4c'] == "true" ) { //產後衛教愛丁堡
					$this->load->model('nurse/nurse4c');
					$nurse4c_info = $this->model_nurse_nurse4c->getNurse4c($customer_info['customer_id']);
					
					$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
					$this->model_tool_worddoc->addParagraph("4C愛丁堡產後憂鬱量表：".$nurse4c_info['date_added'], $titleFormat);
					$this->model_tool_worddoc->addParagraph("表格 1");
					
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable();
						foreach ($tablerow as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
					}
					
					if ($nurse4c_info) {
						$this->model_tool_worddoc->addParagraph('');
						$this->model_tool_worddoc->addParagraph("得分：".$nurse4c_info['score']);
						$this->model_tool_worddoc->addParagraph('在過去七天中');
						
						if ($nurse4c_info['chk1']<>'') {
							$this->model_tool_worddoc->addParagraph("1.我能看到事物有趣的一面，並笑得很開心。<br />ｖ".$nurse4c_info['chk1']);
						}
						if ($nurse4c_info['chk2']<>'') {
							$this->model_tool_worddoc->addParagraph("2.我會欣然期待未來的一切。<br />ｖ".$nurse4c_info['chk2']);
						}
						if ($nurse4c_info['chk3']<>'') {
							$this->model_tool_worddoc->addParagraph("3.當事情出錯時，我會先責備自己。<br />ｖ".$nurse4c_info['chk3']);
						}
						if ($nurse4c_info['chk4']<>'') {
							$this->model_tool_worddoc->addParagraph("4.我會無緣無故感到焦慮或擔心。<br />ｖ".$nurse4c_info['chk4']);
						}
						if ($nurse4c_info['chk5']<>'') {
							$this->model_tool_worddoc->addParagraph("5.我會無緣無故感到害怕或驚恐。<br />ｖ".$nurse4c_info['chk5']);
						}
						if ($nurse4c_info['chk6']<>'') {
							$this->model_tool_worddoc->addParagraph("6.很多事情衝著我來，我覺得無法應付處理。<br />ｖ".$nurse4c_info['chk6']);
						}
						if ($nurse4c_info['chk7']<>'') {
							$this->model_tool_worddoc->addParagraph("7.我很不快到失眠。<br />ｖ".$nurse4c_info['chk7']);
						}
						if ($nurse4c_info['chk8']<>'') {
							$this->model_tool_worddoc->addParagraph("8.我感到難過或悲傷。<br />ｖ".$nurse4c_info['chk8']);
						}
						if ($nurse4c_info['chk9']<>'') {
							$this->model_tool_worddoc->addParagraph("9.我不開心到哭。<br />ｖ".$nurse4c_info['chk9']);
						}
						if ($nurse4c_info['chk10']<>'') {
							$this->model_tool_worddoc->addParagraph("10.我曾經想要傷害自己。<br />ｖ".$nurse4c_info['chk10']);
						}

					}
				} //產後衛教愛丁堡
				
				if ($this->request->get['2c'] == "true" ) { //產後衛教每日身體評估
					$this->load->model('nurse/nurse2c');
					$nurse2c_infos = $this->model_nurse_nurse2c->getNurse2cs($customer_info['customer_id']);
					
					foreach ($nurse2c_infos as $nurse2c_info) {
						$this->load->model('service/customer_service');
						$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse2c_info['nurse_id']);
						
						if ($nurse2c_info) {
							$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
							$this->model_tool_worddoc->addParagraph("2C產後衛教每日身評紀錄單：".$nurse2c_info['date_added'], $titleFormat);
						
							$this->model_tool_worddoc->addParagraph("護理人員：".$nurse_name);
							$this->model_tool_worddoc->addParagraph("產後天數：".$nurse2c_info['days_afterbirth']."，入住天數：".$nurse2c_info['days_livein']);
							
							$this->model_tool_worddoc->addParagraph("");
							$this->model_tool_worddoc->addParagraph("《身體評估》", array("font-size"=>'14pt', 'font-weight'=>'bold'));
							
							if ($nurse2c_info['chk24']<>'') {
								$this->model_tool_worddoc->addParagraph("體溫：".$nurse2c_info['chk24']."℃");
							}
							if ($nurse2c_info['chk25']<>'') {
								$this->model_tool_worddoc->addParagraph("脈搏：".$nurse2c_info['chk25']."（每分鐘）");
							}
							if ($nurse2c_info['chk26']<>'') {
								$this->model_tool_worddoc->addParagraph("呼吸：".$nurse2c_info['chk26']."（每分鐘）");
							}
							if ($nurse2c_info['chk27a']<>'' AND $nurse2c_info['chk27b']<>'') {
								$this->model_tool_worddoc->addParagraph("血壓：(收縮壓):".$nurse2c_info['chk27a']."mmHg&#32;(舒張壓):".$nurse2c_info['chk27b']."mmHg");
							}						
							if ($nurse2c_info['chk1']<>'') {
								$this->model_tool_worddoc->addParagraph("右側乳頭外觀為：".$nurse2c_info['chk1']);
							}
							if ($nurse2c_info['chk2']<>'') {
								$this->model_tool_worddoc->addParagraph("左側乳頭外觀為：".$nurse2c_info['chk2']);
							}
							if ($nurse2c_info['chk3']<>'') {
								$this->model_tool_worddoc->addParagraph("右側乳暈外觀為：".$nurse2c_info['chk3']);
							}
							if ($nurse2c_info['chk4']<>'') {
								$this->model_tool_worddoc->addParagraph("左側乳暈外觀為：".$nurse2c_info['chk4']);
							}
							if ($nurse2c_info['chk5']<>'') {
								$this->model_tool_worddoc->addParagraph("右側乳房外觀為：".$nurse2c_info['chk5']);
							}
							if ($nurse2c_info['chk6']<>'') {
								$this->model_tool_worddoc->addParagraph("左側乳房外觀為：".$nurse2c_info['chk6']);
							}
							if ($nurse2c_info['chk7']<>'') {
								$this->model_tool_worddoc->addParagraph("單次雙側奶量為四小時：".$nurse2c_info['chk7']);
							}
							if ($nurse2c_info['chk8']<>'') {
								$this->model_tool_worddoc->addParagraph("宮底位置為：".$nurse2c_info['chk8']);
							}
							if ($nurse2c_info['chk9']<>'') {
								$this->model_tool_worddoc->addParagraph("惡露量為：".$nurse2c_info['chk9']);
							}
							if ($nurse2c_info['chk10']<>'') {
								$this->model_tool_worddoc->addParagraph("惡露顏色為：".$nurse2c_info['chk10']);
							}
							if ($nurse2c_info['chk11']<>'') {
								$this->model_tool_worddoc->addParagraph("惡露性質為：".$nurse2c_info['chk11']);
							}
							if ($nurse2c_info['chk12']<>'') {
								$this->model_tool_worddoc->addParagraph("該產婦 NSD 傷口為：".$nurse2c_info['chk12']);
							}
							if ($nurse2c_info['chk13']<>'') {
								$this->model_tool_worddoc->addParagraph("該產婦 C/S 傷口為：".$nurse2c_info['chk13']);
							}
							if ($nurse2c_info['chk14']<>'') {
								$this->model_tool_worddoc->addParagraph("痔瘡：".$nurse2c_info['chk14']);
							}
							if ($nurse2c_info['chk15']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦情緒為：".$nurse2c_info['chk15']);
							}
							if ($nurse2c_info['chk16']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦本日食慾：".$nurse2c_info['chk16']);
							}
							if ($nurse2c_info['chk17']<>'') {
								$this->model_tool_worddoc->addParagraph("活動精神狀況：".$nurse2c_info['chk17']);
							}
							if ($nurse2c_info['chk18']<>'') {
								$this->model_tool_worddoc->addParagraph("乳汁排洩情況：".$nurse2c_info['chk18']);
							}
							if ($nurse2c_info['chk19']<>'') {
								$this->model_tool_worddoc->addParagraph("乳房狀況：".$nurse2c_info['chk19']);
							}
							if ($nurse2c_info['chk20']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦按摩乳房狀況為：".$nurse2c_info['chk20']);
							}
							if ($nurse2c_info['chk21']<>'') {
								$this->model_tool_worddoc->addParagraph("學習餵奶打嗝技巧：".$nurse2c_info['chk21']);
							}
							if ($nurse2c_info['chk22']<>'') {
								$this->model_tool_worddoc->addParagraph("排尿情形：".$nurse2c_info['chk22']);
							}
							if ($nurse2c_info['chk23']<>'') {
								$this->model_tool_worddoc->addParagraph("排便狀況：".$nurse2c_info['chk23']);
							}
							if (is_array($subedu = unserialize($nurse2c_info['subject_healthedu'])) AND !empty($subedu)) {
								$textsubedu = '';
								foreach ($subedu as $data) {
									$textsubedu .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("本日衛教題目為：".$textsubedu);
							}
							if ($nurse2c_info['supplement']<>'') {
								$this->model_tool_worddoc->addParagraph("本日補充說明：<br />".nl2br($nurse2c_info['supplement']));
							}
							
							$this->model_tool_worddoc->addParagraph("");
							$this->model_tool_worddoc->addParagraph("《資料紀錄》", array("font-size"=>'14pt', 'font-weight'=>'bold'));
							
							if ($nurse2c_info['chk28']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦本日意識狀況為：".$nurse2c_info['chk28']);
							}
							if ($nurse2c_info['chk29']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦生產方式為：".$nurse2c_info['chk29']."，傷口使用除疤凝膠");
							}
							if ($nurse2c_info['chk30']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦身體不適，建議外出至：".$nurse2c_info['chk30']."就醫");
							}
							if (is_array($c31 = unserialize($nurse2c_info['chk31'])) AND !empty($c31)) {
								$textc31 = '';
								foreach ($c31 as $data) {
									$textc31 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦本日感冒症狀為：".$textc31);
							}
							if (is_array($c32 = unserialize($nurse2c_info['chk32'])) AND !empty($c32)) {
								$textc32 = '';
								foreach ($c32 as $data) {
									$textc32 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦本日有腸胃炎症狀為：".$textc32);
							}
							if (is_array($c33 = unserialize($nurse2c_info['chk33'])) AND !empty($c33)) {
								$textc33 = '';
								foreach ($c33 as $data) {
									$textc33 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦皮膚有紅疹部位為：".$textc33);
							}
							if ($nurse2c_info['chk34']<>'') {
								$this->model_tool_worddoc->addParagraph("已告知產婦，寶寶接觸到父母親以外的第三人，需在媽媽房隔離 ".$nurse2c_info['chk34']);
							}
							if (is_array($c35 = unserialize($nurse2c_info['chk35'])) AND !empty($c35)) {
								$textc35 = '';
								foreach ($c35 as $data) {
									$textc35 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("已告知產婦，寶寶有 ".$textc35."，需在媽媽房隔離自我照顧，期間每日可退 800 元，直到症狀解除，沒有感染疑慮，才可回到嬰兒室。");
							}
							if ($nurse2c_info['chk36']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦有服藥，藥物為：".$nurse2c_info['chk36']);
							}
							if ($nurse2c_info['chk37a']<>'' AND $nurse2c_info['chk37a']<>'0000-00-00 00:00:00') {
								$this->model_tool_worddoc->addParagraph("產婦本日外出，時間為：".$nurse2c_info['chk37a']);
							}
							if ($nurse2c_info['chk37b']<>'' AND $nurse2c_info['chk37b']<>'0000-00-00 00:00:00') {
								$this->model_tool_worddoc->addParagraph("產婦返回，時間為：".$nurse2c_info['chk37b']);
							}
							if (is_array($c38 = unserialize($nurse2c_info['chk38'])) AND !empty($c38)) {
								$textc38 = '';
								foreach ($c38 as $data) {
									$textc38 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦抱怨伙食不適應，感覺口味 ".$textc38."，已請廚師作調整");
							}
							if (is_array($c39 = unserialize($nurse2c_info['chk39'])) AND !empty($c39)) {
								$textc39 = '';
								foreach ($c39 as $data) {
									$textc39 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦覺得環境 ".$textc39);
							}
							if (is_array($c40 = unserialize($nurse2c_info['chk40'])) AND !empty($c40)) {
								$textc40 = '';
								foreach ($c40 as $data) {
									$textc40 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦心情欠佳，建議 ".$textc40." 多給予心靈支持");
							}
							if (is_array($c41 = unserialize($nurse2c_info['chk41'])) AND !empty($c41)) {
								$textc41 = '';
								foreach ($c41 as $data) {
									$textc41 .= $data.",";
								}
								$this->model_tool_worddoc->addParagraph("產婦有 ".$textc41." 密集造訪，建議減少次數，以免寶寶受感染");
							}
							if ($nurse2c_info['chk42']<>'') {
								$this->model_tool_worddoc->addParagraph("產婦基本狀況".$nurse2c_info['chk42']."，身體健康，心情愉快，安心調養中");
							}
							if ($nurse2c_info['supplement_record']<>'') {
								$this->model_tool_worddoc->addParagraph("特別補充事項：<br />".nl2br($nurse2c_info['supplement_record']));
							}
						
						}

						/*if ($kk+1 < count($nurse2c_infos)) {
							$this->model_tool_worddoc->newPage();
						}*/
						
					}
				} //產後衛教入住身體評估
				
				if ($this->request->get['2a'] == "true" ) { //嬰兒圖檔
					$this->load->model('service/customer_service');
					$service_name = $this->model_service_customer_service->getCustomerServiceName($customer_info['service_id']);
					
					foreach ($childinfos as $key => $childinfo) {		
						$this->load->model('service/child');
						$images = $this->model_service_child->getChildImages($childinfo['child_id']);
						$this->load->model('tool/image');
						
						$this->model_tool_worddoc->newSession('PORTRAIT','A4',1,1,1,1);
						$this->model_tool_worddoc->addParagraph("2A嬰兒圖檔&#09;&#09;客服人員：".$service_name, $titleFormat);
						$this->model_tool_worddoc->addParagraph("表格 1");
						
						$this->model_tool_worddoc->startTable();
						foreach ($tablerows[$key] as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
						
						if (!empty($images)) {		
							$this->model_tool_worddoc->newSession();
							//$this->model_tool_worddoc->startTable();
							$this->model_tool_worddoc->startTable(NULL, 'tableWithoutGrid');
							
							$im = array_chunk($images, 2);
							//print"<pre>";print_r($im);print"</pre>";exit;
							
							foreach ($im as $k => $v) {
								$cols = array();
								foreach ($v as $i => $m) {
									$cols['content'][] = $this->model_tool_worddoc->bufferImage($this->model_tool_image->resize($m['image'], 350, '' ),'','')."<br /><center>".$m['image_txt']."</center>";
									//$cols2['content'][] = $m['image_txt'];
								}
								$this->model_tool_worddoc->addTableRow($cols);
								//$this->model_tool_worddoc->addTableRow($cols2);
								unset($cols);//unset($cols2);
							}					
							
							$this->model_tool_worddoc->endTable();
							$this->model_tool_worddoc->endSession();
						}
					}
				} //嬰兒圖檔
				
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
}
?>