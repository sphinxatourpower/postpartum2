<?php    
class ControllerEducationEdu1c extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('education/edu1c');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('education/edu1c');
		
    	$this->getList();
  	}
  
	public function word() {		
		$this->load->language('education/edu1c');
    	$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('education/edu1c');
		
		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);

		if ($customer_info) { 
		
			$edu1c_info = $this->model_education_edu1c->getEdu1c($this->request->get['customer_id']);
			$results = $this->model_education_edu1c->getDataTables($this->request->get['customer_id']);
			
			$filename = "家庭功能評估表_APGAR_".$customer_info['name'];
			
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
			*/

				$this->load->model('tool/worddoc');
		
				$titleFormat = array(
									'text-align' 	=> 'center',
									'font-weight' 	=> 'bold',
									'font-family' =>	'標楷體',
									'font-size'		=> '16pt');
									
				$centerp = array(
					'font-size'		=> '12pt',
					'text-align' 	=> 'center'
				);
			
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				//$this->model_tool_worddoc->isDebugging = true;
				//$this->model_tool_worddoc->newSession();
				$this->model_tool_worddoc->addParagraph("家庭功能評估表（APGAR）", $titleFormat);
				//$this->model_tool_worddoc->addParagraph("表格 1");
				$this->model_tool_worddoc->addParagraph("姓名：".$customer_info['name']."　　　　　　　　　　填寫日期：".$edu1c_info['date_added'], $centerp);
				
				/*
				foreach ($tablerows as $tablerow) {
					$this->model_tool_worddoc->startTable();
					foreach ($tablerow as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
				}
				*/
				
				//$this->model_tool_worddoc->newPage();
				
				
				if (!empty($edu1c_info)) {
					$array_choice = array(
						'2'	=> '經常',
						'1'	=> '有時',
						'0'	=> '幾乎沒有'
					);


					//$this->model_tool_worddoc->addParagraph('在過去七天中');
					$this->model_tool_worddoc->startTable();
					$this->model_tool_worddoc->addTableRow(array('content' => array('題目', '評量結果' ,'補充說明')));
					$a = array();
					
					if ($edu1c_info['chk1']<>'') {
						$a = array(
							'content'	=> array('我滿意於當我遇到困難時，可以求助於家人。（適應度Adaptation）', $array_choice[$edu1c_info['chk1']] , $edu1c_info['text1'])
						);
						$this->model_tool_worddoc->addTableRow($a);
					}
					if ($edu1c_info['chk2']<>'') {
						$a = array(
							'content'	=> array('我滿意於家人和我討論事情及分擔問題的方式。（合作度partnership）', $array_choice[$edu1c_info['chk2']] , $edu1c_info['text2'])
						);
						$this->model_tool_worddoc->addTableRow($a);
					}
					if ($edu1c_info['chk3']<>'') {
						$a = array(
							'content'	=> array('我滿意於當我希望從事新活動，或是有新的發展方向時，家人能接受並給予支持。（成長度growth）', $array_choice[$edu1c_info['chk3']] , $edu1c_info['text3'])
						);
						$this->model_tool_worddoc->addTableRow($a);
					}
					if ($edu1c_info['chk4']<>'') {
						$a = array(
							'content'	=> array('我滿意於當家人對我表達情感的方式，以及對我的情緒（如憤怒、悲傷、愛）的反應。（情感度affection）', $array_choice[$edu1c_info['chk4']] ,$edu1c_info['text4'])
						);
						$this->model_tool_worddoc->addTableRow($a);
					}
					if ($edu1c_info['chk5']<>'') {
						$a = array(
							'content'	=> array('我滿意於家人與我共處的方式。（融洽度resolve）', $array_choice[$edu1c_info['chk5']] , $edu1c_info['text5'])
						);
						$this->model_tool_worddoc->addTableRow($a);
					}
					
					$this->model_tool_worddoc->endTable();
					
					$this->model_tool_worddoc->addParagraph('');
					$this->model_tool_worddoc->addParagraph('分數7至10分：表示家庭功能無障礙');
					$this->model_tool_worddoc->addParagraph('分數4至6分 ：表示中度家庭功能障礙');
					$this->model_tool_worddoc->addParagraph('分數0至3分 ：表示有重度家庭功能不足');
					$this->model_tool_worddoc->addParagraph('');
					$this->model_tool_worddoc->addParagraph("總分：".$edu1c_info['score']);

				}

				//$this->model_tool_worddoc->endSession();
				//$this->model_tool_worddoc->newPage();
				
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
  	public function insert() {
		$this->load->language('education/edu1c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('education/edu1c');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_education_edu1c->addEdu1c($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
/*
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
*/			
					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
			
			if (isset($this->request->get['filter_customer_id'])) {
				$url .= '&filter_customer_id=' . $this->request->get['filter_customer_id'];
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
			
			$this->redirect($this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('education/edu1c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('education/edu1c');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_education_edu1c->editEdu1c($this->request->get['customer_edu1c_id'], $this->request->post);
	  		
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
			
			$this->redirect($this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('education/edu1c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('education/edu1c');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $customer_child_id) {
				$this->model_service_customer->deleteCustomer($customer_child_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			/*
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			*/
					
			if (isset($this->request->get['filter_birthdate'])) {
				$url .= '&filter_birthdate=' . $this->request->get['filter_birthdate'];
			}
			
			/*
			if (isset($this->request->get['filter_date_leave'])) {
				$url .= '&filter_date_leave=' . $this->request->get['filter_date_leave'];
			}
			
			if (isset($this->request->get['filter_customer_service_id'])) {
				$url .= '&filter_customer_service_id=' . $this->request->get['filter_customer_service_id'];
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
			
			$this->redirect($this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
    
  	private function getList() {
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
			//$filter_status = null;
			$filter_status = 1;
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
			$sort = 'customer_room_id'; 
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
			'href'      => $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		//$this->data['insert'] = $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		//$this->data['delete'] = $this->url->link('service/customer/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['customers'] = array();

		$data = array(
			'filter_name'              => $filter_name, 
			'filter_room_id'              => $filter_room_id, 
			'filter_status'            => $filter_status, 
			'filter_date_added'        => $filter_date_added,
			'filter_date_leave'        => $filter_date_leave,
			'filter_service_id' => $filter_service_id, 
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                    => $this->config->get('config_admin_limit')
		);
		
		$this->load->model('service/customer');
		$customer_total = $this->model_service_customer->getTotalCustomers($data);
	
		$results = $this->model_service_customer->getCustomers($data);
 
    	foreach ($results as $result) {
			$form4c = $this->model_education_edu1c->getEdu1c($result['customer_id']);
			
			$action = array();
		
			if (!empty($form4c)) {
				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->link('education/edu1c/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . '&customer_edu1c_id=' . $form4c['customer_edu1c_id'] . $url, 'SSL')
				);
				$action[] = array(
					'text' => '下載列印',
					'href' => $this->url->link('education/edu1c/word', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . '&customer_edu1c_id=' . $form4c['customer_edu1c_id'] . $url, 'SSL')
				);
			} else {
				$action[] = array(
					'text' => $this->language->get('text_addnew'),
					'href' => $this->url->link('education/edu1c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] .  $url, 'SSL')
				);				
			}
			
			
			$this->data['customers'][] = array(
				'customer_id'    => $result['customer_id'],
				'name'           => $result['name'],
				'room'           => $this->model_service_customer->getLastTransfer($result['customer_id']),
				'status'         => ($result['status'] ? $this->language->get('text_livein') : $this->language->get('text_leave')),
				'date_added'     => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'date_leave'     => date($this->language->get('date_format_short'), strtotime($result['date_leave'])),
				'service' => $result['service'],
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
		$this->data['column_room'] = $this->language->get('column_room');
		$this->data['column_status'] = $this->language->get('column_status');
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
		
		$this->data['sort_name'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_room_id'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=customer_room_id' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=c.date_added' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_service'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . '&sort=service' . $url, 'SSL');
		
		$url = '';

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
		$pagination->url = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

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
		
		$this->template = 'education/edu1c_list.tpl';
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
		$this->data['tab_edu1c'] = $this->language->get('tab_edu1c');

		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->request->get['customer_child_id'])) {
			$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
		} else {
			$this->data['customer_child_id'] = 0;
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
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
			'href'      => $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);


		if (!isset($this->request->get['customer_edu1c_id'])) {
			$this->data['action'] = $this->url->link('education/edu1c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('education/edu1c/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . '&customer_edu1c_id=' . $this->request->get['customer_edu1c_id'] . $url, 'SSL');
		}


    	$this->data['cancel'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$form_info = $this->model_education_edu1c->getEdu1c($this->request->get['customer_id']);
			$datatables = $this->model_education_edu1c->getDataTables($this->request->get['customer_id']);
    	}

#!#####

		if (isset($this->request->get['customer_id'])) {
      		$this->data['customer_id'] = $this->request->get['customer_id'];
			$this->load->model('service/customer');
			$this->data['customer_name'] = $this->model_service_customer->getCustomerName($this->request->get['customer_id']);
    	} elseif (!empty($form_info)) { 
			$this->data['customer_id'] = $form_info['customer_id'];
			$this->load->model('service/customer');
			$this->data['customer_name'] = $this->model_service_customer->getCustomerName($form_info['customer_id']);
		} else {
      		$this->data['customer_id'] = '';
			$this->data['customer_name'] = '';
    	}		

		if (isset($this->request->post['score'])) {
      		$this->data['score'] = $this->request->post['score'];
    	} elseif (!empty($form_info)) { 
			$this->data['score'] = $form_info['score'];
		} else {
      		$this->data['score'] = '';
    	}	
		
		for ($j=1;$j<=5;$j++) {
			if (isset($this->request->post['text'.$j])) {
				$this->data['text'.$j] = $this->request->post['text'.$j];
			} elseif (!empty($form_info)) { 
				$this->data['text'.$j] = $form_info['text'.$j];
			} else {
				$this->data['text'.$j] = '';
			}	
		}
		
		for ($i=1;$i<=5;$i++) {
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['chk'.$i.''] = $form_info['chk'.$i.''];
				} else {
					$this->data['chk'.$i.''] = '';
				}
		}
		
#!#####

	foreach ($datatables as $k => $datatable_info) {
		if (!empty($datatable_info)) {
			$this->load->model('service/child');
			$rooms = $this->model_service_child->getTransfers($datatable_info['customer_id']);
			
			 if (!empty($rooms)) {
				if (count($rooms) == "1") {
					$this->data['dtab'][$k]['customer_firstroom'] = $rooms[0]['customer_room_name'];
					$this->data['dtab'][$k]['customer_transfers'] = array();
				} else {
					$this->data['dtab'][$k]['customer_firstroom'] = $rooms[0]['customer_room_name'];
					for ($i=0;$i<count($rooms)-1;$i++) {
						$this->data['dtab'][$k]['customer_transfers'][$i] = $rooms[$i+1];
					}
				}
			 } else {
				$this->data['dtab'][$k]['customer_firstroom'] = '尚未指定房間';
				$this->data['dtab'][$k]['customer_transfers'] = array();
			 }
		}
		
		if (isset($this->request->post['birthdate'])) {
      		$this->data['dtab'][$k]['birthdate'] = $this->request->post['birthdate'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['birthdate'] = $datatable_info['birthdate'];
		} else {
      		$this->data['birthdate'] = '';
    	}		
		
		if (isset($this->request->post['name'])) {
      		$this->data['dtab'][$k]['name'] = $this->request->post['name'];
    	} elseif (!empty($datatable_info)) { 
			$called = ($datatable_info['gender'] == "女") ? "女" : "子";
			$this->data['dtab'][$k]['name'] = (($datatable_info['name']!='')? $datatable_info['name'] : $datatable_info['customer_name']."之".$called);
		} else {
      		$this->data['dtab'][$k]['name'] = '';
		}
		
		if (isset($this->request->post['b_streptococcus_check'])) {
      		$this->data['dtab'][$k]['b_streptococcus_check'] = $this->request->post['b_streptococcus_check'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['b_streptococcus_check'] = $datatable_info['b_streptococcus_check'];
		} else {
      		$this->data['dtab'][$k]['b_streptococcus_check'] = '';
		}
		
		if (isset($this->request->post['apgar_score_1'])) {
      		$this->data['dtab'][$k]['apgar_score_1'] = $this->request->post['apgar_score_1'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['apgar_score_1'] = $datatable_info['apgar_score_1'];
		} else {
      		$this->data['dtab'][$k]['apgar_score_1'] = '';
		}
		
		if (isset($this->request->post['apgar_score_5'])) {
      		$this->data['dtab'][$k]['apgar_score_5'] = $this->request->post['apgar_score_5'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['apgar_score_5'] = $datatable_info['apgar_score_5'];
		} else {
      		$this->data['dtab'][$k]['apgar_score_5'] = '';
		}
		
		if (isset($this->request->post['birthweight'])) {
      		$this->data['dtab'][$k]['birthweight'] = $this->request->post['birthweight'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['birthweight'] = $datatable_info['birthweight'];
		} else {
      		$this->data['dtab'][$k]['birthweight'] = '';
		}
		
		if (isset($this->request->post['birthhead'])) {
      		$this->data['dtab'][$k]['birthhead'] = $this->request->post['birthhead'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['birthhead'] = $datatable_info['birthhead'];
		} else {
      		$this->data['dtab'][$k]['birthhead'] = '';
		}
		
		if (isset($this->request->post['birthlength'])) {
      		$this->data['dtab'][$k]['birthlength'] = $this->request->post['birthlength'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['birthlength'] = $datatable_info['birthlength'];
		} else {
      		$this->data['dtab'][$k]['birthlength'] = '';
		}
		
		if (isset($this->request->post['inweight'])) {
      		$this->data['dtab'][$k]['inweight'] = $this->request->post['inweight'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['inweight'] = $datatable_info['inweight'];
		} else {
      		$this->data['dtab'][$k]['inweight'] = '';
		}

		if (isset($this->request->post['customer_name'])) {
      		$this->data['dtab'][$k]['customer_name'] = $this->request->post['customer_name'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['customer_name'] = $datatable_info['customer_name'];
		} else {
      		$this->data['dtab'][$k]['customer_name'] = '';
		}
		
		if (isset($this->request->post['spouse_name'])) {
      		$this->data['dtab'][$k]['spouse_name'] = $this->request->post['spouse_name'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['spouse_name'] = $datatable_info['spouse_name'];
		} else {
      		$this->data['dtab'][$k]['spouse_name'] = '';
		}
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['dtab'][$k]['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['date_added'] = $datatable_info['date_added'];
		} else {
      		$this->data['dtab'][$k]['date_added'] = '';
    	}
		
		if (isset($this->request->post['date_leave'])) {
      		$this->data['dtab'][$k]['date_leave'] = $this->request->post['date_leave'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['date_leave'] = $datatable_info['date_leave'];
		} else {
      		$this->data['dtab'][$k]['date_leave'] = '';
    	}
		
		if (isset($this->request->post['childbirth_method'])) {
      		$this->data['dtab'][$k]['childbirth_method'] = $this->request->post['childbirth_method'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['childbirth_method'] = $datatable_info['childbirth_method'];
		} else {
      		$this->data['dtab'][$k]['childbirth_method'] = '';
    	}

		if (isset($this->request->post['childbirth_hospital'])) {
      		$this->data['dtab'][$k]['childbirth_hospital'] = $this->request->post['childbirth_hospital'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['childbirth_hospital'] = $datatable_info['childbirth_hospital'];
		} else {
      		$this->data['dtab'][$k]['childbirth_hospital'] = '';
    	}
		
		if (isset($this->request->post['childbirth_doctor'])) {
      		$this->data['dtab'][$k]['childbirth_doctor'] = $this->request->post['childbirth_doctor'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['childbirth_doctor'] = $datatable_info['childbirth_doctor'];
		} else {
      		$this->data['dtab'][$k]['childbirth_doctor'] = '';
    	}
		
		if (isset($this->request->post['pregnancy_weeks'])) {
      		$this->data['dtab'][$k]['pregnancy_weeks'] = $this->request->post['pregnancy_weeks'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['pregnancy_weeks'] = $datatable_info['pregnancy_weeks'];
		} else {
      		$this->data['dtab'][$k]['pregnancy_weeks'] = '';
    	}
		
		if (isset($this->request->post['child_count_g'])) {
      		$this->data['dtab'][$k]['child_count_g'] = $this->request->post['child_count_g'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['child_count_g'] = $datatable_info['child_count_g'];
		} else {
      		$this->data['dtab'][$k]['child_count_g'] = '';
    	}
		
		if (isset($this->request->post['child_count_p'])) {
      		$this->data['dtab'][$k]['child_count_p'] = $this->request->post['child_count_p'];
    	} elseif (!empty($datatable_info)) { 
			$this->data['dtab'][$k]['child_count_p'] = $datatable_info['child_count_p'];
		} else {
      		$this->data['dtab'][$k]['child_count_p'] = '';
    	}
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
		
		
		$this->template = 'education/edu1c_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'education/edu1c')) {
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
    	if (!$this->user->hasPermission('modify', 'service/customer')) {
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
			$this->load->model('education/edu1c');
			
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