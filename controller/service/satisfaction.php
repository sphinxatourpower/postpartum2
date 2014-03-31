<?php    
class ControllerServiceSatisfaction extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('service/satisfaction');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/satisfaction');
		
    	$this->getList();
  	}
	
	public function satisfactionword() {		
		$this->load->language('service/customer');
    	$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
		
		//$result = $this->model_service_child->get($this->request->get['customer_child_id']);

		if ($customer_info) { 
		
			//$this->load->model('nurse/nurse1c');
			$results = $this->model_service_customer->getDataTables($this->request->get['customer_id']);
			
			$this->load->model('service/satisfaction');
			$satisfaction_data = $this->model_service_satisfaction->getSatisfaction($this->request->get['customer_satisfaction_id']);
			
			//print_r($satisfaction_data); exit;
		
			$filename = "客戶滿意度調查_".$customer_info['name'];
			
			$this->load->model('service/customer_service');
			$service_name = $this->model_service_customer_service->getCustomerServiceName($customer_info['service_id']);
			
			$contact_infos = $this->model_service_customer->getContacts($customer_info['customer_id']);
			
			/* 表格 1 */
			/*
			foreach ($results as $result) {		
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
						//'span' => array()
					),
					array (
						'content' => array('房號：'.$customer_firstroom, $transferrecord),
						'span' => array('', 2)
					),
					array(
						'content' => array('嬰兒出生日期：'.$result['birthdate'], '產婦入住日期：'.$result['date_added'], '預定退住日期：'.$result['date_leave']),
						//'span' => array()
					),
					array(
						'content' => array('生產方式：'.$result['childbirth_method'], '生產醫院：'.$result['childbirth_hospital']),
						'span' => array('', 2)
					),
					array(
						'content' => array(
									'懷孕週數：'.$result['pregnancy_weeks'].'<br />胎兒產胎次：<br />G&#32;<u>'.$result['child_count_g'].'</u>&#09;P&#32;<u>'.$result['child_count_p'].'</u>', 
									'生產醫師：'.$result['childbirth_doctor'].'<br />Apgar score：<u>'.$result['apgar_score_1'].'</u>（1 min）--> <u>'.$result['apgar_score_5'].'</u>（5 min）'
						),
						'span' => array('', 2)
					),
					array(
						'content' => array(
									'嬰兒出生時體重：'.$result['birthweight'].'公克 ，入住時體重'.$result['inweight'].'公克<br />頭圍：'.$result['birthhead'].'公分，身長：'.$result['birthlength'].'公分'
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
			*/

				$score = array(
					'1'	=> '不滿意',
					'2'	=> '待加強',
					'3'	=> '普通',
					'4'	=> '滿意',
					'5'	=> '非常滿意'
				);
				
				$this->load->model('tool/worddoc');
		
				$center = array(
					'text-align' 	=> 'center'
				);
				$titleFormat = array(
									'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '18pt');
				$titleFormat2 = array(
									//'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '14pt');
				$titleFormat3 = array(
									//'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'新細明體',
									'font-size'		=> '12pt');
				$smallfont = array(
									//'text-align' 	=> 'center',
									//'font-weight' 	=> 'bold',
									'font-family' =>	'新細明體',
									'font-size'		=> '11pt');
			
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				//$this->model_tool_worddoc->isDebugging = true;
				//$this->model_tool_worddoc->newSession();

				$this->model_tool_worddoc->addParagraph(PCOMPANY."&#32;意見調查表", $titleFormat);
				$this->model_tool_worddoc->addParagraph("房號：".$satisfaction_data['customer_room']."<span style='mso-tab-count:1'></span>姓名：".$satisfaction_data['customer']."<span style='mso-tab-count:5'></span>填表日期：".$satisfaction_data['date_added'], $center);
				//$this->model_tool_worddoc->addParagraph("表格 1");
				$this->model_tool_worddoc->addParagraph("意見調查", $titleFormat2);
				
				$this->model_tool_worddoc->addParagraph("一、照護服務內容", $titleFormat3);
				$this->model_tool_worddoc->addParagraph("1. 專業人員知識是否詳盡：". (($satisfaction_data['chk1']) ? $score[$satisfaction_data['chk1']] : '未填寫'), $smallfont);
				$this->model_tool_worddoc->addParagraph("2. 照護內容是否符合需求：". (($satisfaction_data['chk2']) ? $score[$satisfaction_data['chk2']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("3. 指導內容是否能夠了解：". (($satisfaction_data['chk3']) ? $score[$satisfaction_data['chk3']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("4. 可尊重媽媽的隱私權：". (($satisfaction_data['chk4']) ? $score[$satisfaction_data['chk4']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("5. 其他(請說明)：<br />" . nl2br($satisfaction_data['text1']), $smallfont );
				
				$this->model_tool_worddoc->addParagraph("二、服務人員態度", $titleFormat3);
				$this->model_tool_worddoc->addParagraph("1. 護理人員：". (($satisfaction_data['chk5']) ? $score[$satisfaction_data['chk5']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("2. 清潔人員：". (($satisfaction_data['chk6']) ? $score[$satisfaction_data['chk6']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("3. 其他(請說明)：<br />" . nl2br($satisfaction_data['text2']), $smallfont );
				
				$this->model_tool_worddoc->addParagraph("三、膳食", $titleFormat3);
				$this->model_tool_worddoc->addParagraph("1. 菜色：". (($satisfaction_data['chk7']) ? $score[$satisfaction_data['chk7']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("2. 烹調口味：". (($satisfaction_data['chk8']) ? $score[$satisfaction_data['chk8']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("3. 餐盤清潔：". (($satisfaction_data['chk9']) ? $score[$satisfaction_data['chk9']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("4. 其他(請說明)：<br />" . nl2br($satisfaction_data['text3']), $smallfont );

				$this->model_tool_worddoc->addParagraph("四、房間環境設施設備方面", $titleFormat3);
				$this->model_tool_worddoc->addParagraph("1. 房間空間寬敞，沒有擁擠情形：". (($satisfaction_data['chk10']) ? $score[$satisfaction_data['chk10']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("2. 房間空調適中，光線明亮：". (($satisfaction_data['chk11']) ? $score[$satisfaction_data['chk11']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("3. 房間的床單、被單、哺乳衣清潔：". (($satisfaction_data['chk12']) ? $score[$satisfaction_data['chk12']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("4. 房間內地板、設備及洗手間乾淨清潔：". (($satisfaction_data['chk13']) ? $score[$satisfaction_data['chk13']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("5. 環境常保持安寧：". (($satisfaction_data['chk14']) ? $score[$satisfaction_data['chk14']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("6. 公共空間設施設備情形：". (($satisfaction_data['chk15']) ? $score[$satisfaction_data['chk15']] : '未填寫'), $smallfont );
				$this->model_tool_worddoc->addParagraph("7. 其他(請說明)：<br />" . nl2br($satisfaction_data['text4']), $smallfont );
				
				$this->model_tool_worddoc->addParagraph("五、綜合建議", $titleFormat3);
				$this->model_tool_worddoc->addParagraph("1. 您認為本機構最需加強的部份是什麼？<br />" . nl2br($satisfaction_data['text5']), $smallfont );

				$good1 = ($satisfaction_data['good1']<>'') ? '第一名：'.$satisfaction_data['good1'].'<span style=\'mso-tab-count:1\'></span>' : '';
				$good2 = ($satisfaction_data['good2']<>'') ? '第二名：'.$satisfaction_data['good2'].'<span style=\'mso-tab-count:1\'></span>' : '';
				$good3 = ($satisfaction_data['good3']<>'') ? '第三名：'.$satisfaction_data['good3'].'<span style=\'mso-tab-count:1\'></span>' : '';
				$good = $good1 . $good2 . $good3;
				$this->model_tool_worddoc->addParagraph("請寫出您心目中表現優秀的工作人員，本機構會給予鼓勵及表揚<br />". $good, $smallfont);
				
				/*
				if (!empty($tablerows)) {
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable();
						foreach ($tablerow as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
					}
				}
				*/
				//$this->model_tool_worddoc->addParagraph('');
				
				//$this->model_tool_worddoc->newPage();
				
					//$this->model_tool_worddoc->addParagraph('');
					
				/*
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
				*/

				//$this->model_tool_worddoc->endSession();
				//$this->model_tool_worddoc->newPage();
				
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
  	public function insert() {
		$this->load->language('service/satisfaction');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/satisfaction');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_service_satisfaction->addSatisfaction($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_add_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_date_written'])) {
				$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
			}
					
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
			
			if (isset($this->request->get['filter_date_leave'])) {
				$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
			}
			
			if (isset($this->request->get['filter_service_id'])) {
				$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
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
			
			$this->redirect($this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('service/satisfaction');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/satisfaction');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_service_satisfaction->editSatisfaction($this->request->get['customer_satisfaction_id'], $this->request->post);
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_date_written'])) {
				$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
			}
					
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
			
			if (isset($this->request->get['filter_date_leave'])) {
				$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
			}
			
			if (isset($this->request->get['filter_service_id'])) {
				$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
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
			
			$this->redirect($this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('service/satisfaction');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/satisfaction');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $customer_satisfaction_id) {
				$this->model_service_satisfaction->deleteSatisfaction($customer_satisfaction_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_del_success');

			$url = '';
			
			if (isset($this->request->get['filter_date_written'])) {
				$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
			}

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_date_written'])) {
				$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
			}
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
			
			if (isset($this->request->get['filter_date_leave'])) {
				$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
			}
			
			if (isset($this->request->get['filter_service_id'])) {
				$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
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
			
			$this->redirect($this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
    
  	private function getList() {
		$this->load->model('service/customer');
		$this->load->model('service/satisfaction');
		
		if (isset($this->request->get['filter_date_written'])) {
			$filter_date_written = $this->request->get['filter_date_written'];
		} else {
			$filter_date_written = null;
		}
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		
		if (isset($this->request->get['filter_room_id'])) {
			$filter_room_id = $this->request->get['filter_room_id'];
		} else {
			$filter_room_id = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
				
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}		
		
		if (isset($this->request->get['filter_date_leave'])) {
			$filter_date_leave = $this->request->get['filter_date_leave'];
		} else {
			$filter_date_leave = null;
		}		
		
		if (isset($this->request->get['filter_service_id'])) {
			$filter_service_id = $this->request->get['filter_service_id'];
		} else {
			$filter_service_id = null;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = ''; 
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

		if (isset($this->request->get['filter_date_written'])) {
			$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
		}
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_room_id'])) {
			$url .= '&filter_room_id=' . $this->request->get['filter_room_id'];
		}
			
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_service_id'])) {
			$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
		}
					
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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
			'href'      => $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->data['insert'] = $this->url->link('service/satisfaction/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('service/satisfaction/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['customers'] = array();

		$data = array(
			'filter_date_written'              => $filter_date_written, 
			'filter_name'              => $filter_name, 
			'filter_room_id'            => $filter_room_id, 
			'filter_status'            => $filter_status, 
			'filter_date_added'        => $filter_date_added,
			'filter_date_leave'        => $filter_date_leave,
			'filter_service_id' => $filter_service_id, 
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                    => $this->config->get('config_admin_limit')
		);
		
		$customer_total = $this->model_service_satisfaction->getTotalSatisfactions($data);
		$results = $this->model_service_satisfaction->getSatisfactions($data);
 
    	foreach ($results as $rskey => $result) {
			$datatables = $this->model_service_customer->getDataTables($result['customer_id']);
			
			$actionprint = array();
			
			$actionprint[] = array(
				//'text' => $this->language->get('text_edit'),
				'text' => '下載列印',
				'href' => $this->url->link('service/satisfaction/satisfactionword', 'token=' . $this->session->data['token'] . '&customer_satisfaction_id=' . $result['customer_satisfaction_id'] . '&customer_id=' . $result['customer_id'] . $url, 'SSL')
			);
			
			$action = array();
		
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('service/satisfaction/update', 'token=' . $this->session->data['token'] . '&customer_satisfaction_id=' . $result['customer_satisfaction_id'] . $url, 'SSL')
			);
			
			$this->data['customers'][] = array(
				'customer_satisfaction_id'	=> $result['customer_satisfaction_id'],
				'date_written'     => date($this->language->get('date_format_short'), strtotime($result['date_written'])),
				'customer_id'    => $result['customer_id'],
				'name'           => $result['name'],
				'room'           => $this->model_service_customer->getLastTransfer($result['customer_id']),
				'status'         => ($result['status'] ? $this->language->get('text_livein') : $this->language->get('text_leave')),
				'date_added'     => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'date_leave'     => date($this->language->get('date_format_short'), strtotime($result['date_leave'])),
				'service' => $result['service'],
				'selected'       => isset($this->request->post['selected']) && in_array($result['customer_id'], $this->request->post['selected']),
				'actionprint'         => $actionprint,
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
		$this->data['column_room'] = $this->language->get('column_room');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_showathome'] = $this->language->get('column_showathome');
		$this->data['column_date_written'] = $this->language->get('column_date_written');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		$this->data['column_service'] = $this->language->get('column_service');
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

		if (isset($this->request->get['filter_date_written'])) {
			$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
		}
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_room_id'])) {
			$url .= '&filter_room_id=' . $this->request->get['filter_room_id'];
		}
			
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
		
		if (isset($this->request->get['filter_date_leave'])) {
			$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
		}
			
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_date_written'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=cs.date_added' . $url, 'SSL');
		$this->data['sort_name'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_room_id'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=room_id' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=c.date_added' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_service'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . '&sort=service' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_date_written'])) {
			$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
		}

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_room_id'])) {
			$url .= '&filter_room_id=' . $this->request->get['filter_room_id'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
			
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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

		$pagination = new Pagination();
		$pagination->total = $customer_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_date_written'] = $filter_date_written;
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_room_id'] = $filter_room_id;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_date_added'] = $filter_date_added;
		$this->data['filter_date_leave'] = $filter_date_leave;
		$this->data['filter_service_id'] = $filter_service_id;
		
		$this->load->model('service/customer_room');
		$this->data['rooms'] = $this->model_service_customer_room->getCustomerRooms();
		
		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => 3);
    	$this->data['services'] = $this->model_service_customer_service->getCustomerServices($servary);
				
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'service/satisfaction_list.tpl';
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
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
    	$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_livein'] = $this->language->get('text_livein');
    	$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_select'] = $this->language->get('text_select');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['score5'] = $this->language->get('text_score_5');
		$this->data['score4'] = $this->language->get('text_score_4');
		$this->data['score3'] = $this->language->get('text_score_3');
		$this->data['score2'] = $this->language->get('text_score_2');
		$this->data['score1'] = $this->language->get('text_score_1');
		
		$this->data['column_total'] = $this->language->get('column_total');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['entry_idnumber'] = $this->language->get('entry_idnumber');
		$this->data['entry_foreigner'] = $this->language->get('entry_foreigner');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_gender'] = $this->language->get('entry_gender');
		$this->data['entry_birthdate'] = $this->language->get('entry_birthdate');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_mobile'] = $this->language->get('entry_mobile');
		$this->data['entry_service'] = $this->language->get('entry_service');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_date_written'] = $this->language->get('entry_date_written');
		$this->data['entry_date_added'] = $this->language->get('entry_date_added');
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
		$this->data['entry_inlength'] = $this->language->get('entry_inlength');
		$this->data['entry_b_streptococcus_check'] = $this->language->get('entry_b_streptococcus_check');
		$this->data['entry_apgar_score'] = $this->language->get('entry_apgar_score');
 
		$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_contact'] = $this->language->get('button_add_contact');
		$this->data['button_add_child'] = $this->language->get('button_add_child');
		$this->data['button_add_transfer'] = $this->language->get('button_add_transfer');
		$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
    	$this->data['button_remove'] = $this->language->get('button_remove');
	
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_contact'] = $this->language->get('tab_contact');
		$this->data['tab_transfer'] = $this->language->get('tab_transfer');
		$this->data['tab_moredata'] = $this->language->get('tab_moredata');
		$this->data['tab_childdata'] = $this->language->get('tab_childdata');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->get['customer_satisfaction_id'])) {
			$this->data['customer_satisfaction_id'] = $this->request->get['customer_satisfaction_id'];
		} else {
			$this->data['customer_satisfaction_id'] = 0;
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
				
		if (isset($this->error['customer'])) {
			$this->data['error_customer'] = $this->error['customer'];
		} else {
			$this->data['error_customer'] = '';
		}
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_service_id'])) {
			$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_date_written'])) {
			$url .= '&filter_date_written=' . $this->request->get['filter_date_written'];
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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
			'href'      => $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);

		if (!isset($this->request->get['customer_satisfaction_id'])) {
			$this->data['action'] = $this->url->link('service/satisfaction/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('service/satisfaction/update', 'token=' . $this->session->data['token'] . '&customer_satisfaction_id=' . $this->request->get['customer_satisfaction_id'] . $url, 'SSL');
		}
		  
    	$this->data['cancel'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_satisfaction_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$customer_info = $this->model_service_satisfaction->getSatisfaction($this->request->get['customer_satisfaction_id']);
    	}
			
		if (isset($this->request->post['customer_id'])) {
      		$this->data['customer_id'] = $this->request->post['customer_id'];
    	} elseif (!empty($customer_info)) { 
			$this->data['customer_id'] = $customer_info['customer_id'];
		} else {
      		$this->data['customer_id'] = '';
    	}	
		
		if (isset($this->request->post['customer'])) {
      		$this->data['customer'] = $this->request->post['customer'];
    	} elseif (!empty($customer_info)) { 
			$this->data['customer'] = $customer_info['customer'];
		} else {
      		$this->data['customer'] = '';
    	}		
		
		if (isset($this->request->post['customer_room'])) {
      		$this->data['customer_room'] = $this->request->post['customer_room'];
    	} elseif (!empty($customer_info)) { 
			$this->data['customer_room'] = $customer_info['customer_room'];
		} else {
      		$this->data['customer_room'] = '';
    	}	
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_added'] = $customer_info['date_added'];
		} else {
      		$this->data['date_added'] = date($this->language->get('date_format_short'));
    	}		
		
		for ($i = 1;$i<=15;$i++) {
			if (isset($this->request->post['chk'.$i])) {
				$this->data['chk'.$i] = $this->request->post['chk'.$i];
			} elseif (!empty($customer_info)) { 
				$this->data['chk'.$i] = $customer_info['chk'.$i];
			} else {
				$this->data['chk'.$i] = '';
			}
		}

		for ($i = 1;$i<=5;$i++) {
			if (isset($this->request->post['text'.$i])) {
				$this->data['text'.$i] = $this->request->post['text'.$i];
			} elseif (!empty($customer_info)) { 
				$this->data['text'.$i] = $customer_info['text'.$i];
			} else {
				$this->data['text'.$i] = '';
			}
		}

		for ($i = 1;$i<=3;$i++) {
			if (isset($this->request->post['good'.$i])) {
				$this->data['good'.$i] = $this->request->post['good'.$i];
			} elseif (!empty($customer_info)) { 
				$this->data['good'.$i] = $customer_info['good'.$i];
			} else {
				$this->data['good'.$i] = '';
			}
		}
		
		$this->template = 'service/satisfaction_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'service/satisfaction')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
    	if (!$this->request->post['customer_id']) {
      		$this->error['customer'] = $this->language->get('error_customer');
    	}
		
    	if ($this->request->post['date_added'] =='' || $this->request->post['date_added'] == '0000-00-00' ) {
      		$this->error['date_added'] = $this->language->get('error_date_added');
    	}
			
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}    

  	private function validateDelete() {
    	if (!$this->user->hasPermission('delete', 'service/satisfaction')) {
      		$this->error['warning'] = $this->language->get('error_delete_permission');
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
			$this->load->model('service/customer');
			
			$data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 20
			);
		
			$results = $this->model_service_customer->getCustomers($data);
			
			foreach ($results as $result) {
				$json[] = array(
					'customer_id'    => $result['customer_id'], 
					'name'           => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'),
					'idnumber'		=> $result['idnumber'],
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
}
?>