<?php    
class ControllerNurseNurse2b extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('nurse/nurse2b');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
		
    	$this->getList();
  	}
  
	public function word() {		
		$this->load->language('nurse/nurse2b');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
		$this->load->model('service/child');
		
		$datatable = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
		
		if ($datatable) {
				$called = ($datatable['gender'] == "女") ? "女" : "子";
				$childname = ($datatable['name']=='') ? $datatable['customer_name']."之".$called : $datatable['name'];
				$filename = "2B護理人員接班評估單_".$childname;
		
				$rooms = $this->model_service_child->getTransfers($datatable['customer_id']);
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
				
				$this->load->model('service/customer_service');
				$service_name = $this->model_service_customer_service->getCustomerServiceName($datatable['service_id']);
				
				if (!empty($customer_transfers)) {
					foreach ($customer_transfers as $transfer) {
							$transferrecord .= "轉床紀錄：".$transfer['date_added']."&nbsp;轉為：".$transfer['customer_room_name']."<br />\n";
					}
				}
				
				$tablerows = array(
					array (
						'content' => array('產婦姓名：'.$datatable['customer_name'], '嬰兒姓名：'.$childname, '父親姓名：'.$datatable['spouse_name']), 
						//'span' => array()
					),
					array (
						'content' => array('房號：'.$customer_firstroom, $transferrecord),
						'span' => array('', 2)
					),
					array(
						'content' => array('嬰兒出生日期：'.$datatable['birthdate'], '產婦入住日期：'.$datatable['date_added'], '預定退住日期：'.$datatable['date_leave']),
						//'span' => array()
					),
					array(
						'content' => array('生產方式：'.$datatable['childbirth_method'], '生產醫院：'.$datatable['childbirth_hospital']),
						'span' => array('', 2)
					),
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
				);
		}
			
		$results = $this->model_nurse_nurse2b->getNurse2bs($this->request->get['customer_child_id']);
	
		$this->load->model('tool/worddoc');
		$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
		$this->model_tool_worddoc->setDocumentCharset('UTF-8');
		
		
		if ($results) { 
			
			foreach ($results as $k => $result) {			
				$this->load->model('service/customer_service');
				$nurse_name = $this->model_service_customer_service->getCustomerServiceName($result['nurse_id']);
		
				$titleFormat = array(
									//'text-align' 	=> 'center',
									//'font-weight' 	=> 'bold',
									'font-family' =>	'新細明體',
									'font-size'		=> '14pt');
			
				$this->model_tool_worddoc->addParagraph("2B護理人員接班評估單：".$result['date_added']."，班別：".$result['arrangement']."，護理人員：".$nurse_name, $titleFormat);
				$this->model_tool_worddoc->addParagraph("表格 1");
				if ($datatable) {
					$this->model_tool_worddoc->startTable();
					foreach ($tablerows as $row) {
						$this->model_tool_worddoc->addTableRow($row);
					}
					$this->model_tool_worddoc->endTable();
				}
				
				$this->model_tool_worddoc->addParagraph("");
				
				$contents = array();
				
				if ($result['chk1']<>"") {
						$contents[] = "寶寶一般情形：".$result['chk1'];
				}
				if ($result['chk2']<>"") {
						$contents[] = "活動力：".$result['chk2'];
				}
				if ($result['chk3']<>"") {
						$contents[] = "食慾：".$result['chk3'];
				}
				if ($result['chk4']<>"") {
						$contents[] = "體溫：".$result['chk4']." ℃";
				}
				if ($result['chk5']<>"") {
						$contents[] = "心跳：".$result['chk5']." 每分鐘";
				}
				if ($result['chk6']<>"") {
						$contents[] = "呼吸：".$result['chk6']." 每分鐘";
				}
				if ($result['chk7']<>"") {
						$contents[] = "黃疸數值為：".$result['chk7']." mg/dL";
				}
				if ($result['chk8']<>"") {
						$contents[] = "血氣飽和濃度為：".$result['chk8']." %";
				}
				if ($result['chk9']<>"") {
						$contents[] = "嘴唇顏色：".$result['chk9'];
				}
				if ($result['chk10']<>"") {
						$contents[] = "四肢活動力：".$result['chk10'];
				}
				if (is_array($c11 = unserialize($result['chk11'])) AND !empty($c11)) {
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
				if (is_array($c12 = unserialize($result['chk12'])) AND !empty($c12)) {
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
				if (is_array($c13 = unserialize($result['chk13'])) AND !empty($c13)) {
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
				if (is_array($c14 = unserialize($result['chk14'])) AND !empty($c14)) {
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
				if (is_array($c15 = unserialize($result['chk15'])) AND !empty($c15)) {
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
				if ($result['chk16']<>"") {
						$contents[] = "臍帶：".$result['chk16'];
				}
				if (is_array($c17 = unserialize($result['chk17'])) AND !empty($c17)) {
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
				if (is_array($c18 = unserialize($result['chk18'])) AND !empty($c18)) {
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
				if (is_array($c19 = unserialize($result['chk19'])) AND !empty($c19)) {
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
				if (is_array($c20 = unserialize($result['chk20'])) AND !empty($c20)) {
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
				
				
				if ($result['chk21']<>"") {
						$contents[] = "尿布疹：".$result['chk21'];
				}								
				if ($result['chk22']<>"") {
						$contents[] = "寶寶目前在：".$result['chk22'];
				}		
				if ($result['chk23']<>'') {
						$contents[] = "特別補充：<br />".nl2br($result['chk23']);
				}
				
				foreach ($contents as $ck => $content) {
					if ($content <> '') {
						$this->model_tool_worddoc->addParagraph(($ck+1).". ".$content);
					}
				}
				
				if ($k+1 < count($results)) {
						$this->model_tool_worddoc->newPage();
				}
				
			}
			
			$this->model_tool_worddoc->output($filename.'.doc');
			
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
  	public function store() {
		$this->load->language('nurse/nurse2b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_nurse_nurse2b->addNurse2b($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['customer_child_id'])) {
				$url .= '&customer_child_id=' . $this->request->get['customer_child_id'];
			}
			
			//$this->redirect($this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			$this->redirect($this->url->link('nurse/nurse2b/insert', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
	
  	public function insert() {
		$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.css');
		$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.print.css','','print');
		$this->document->addScript('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.min.js');
		$this->document->addStyle('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.css');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mousewheel.min.js');
		$this->document->addScript('view/javascript/jquery/mCustomScrollbar/jquery.mCustomScrollbar.min.js');		
		$this->load->language('nurse/nurse2b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_nurse_nurse2b->addNurse2b($this->request->post);
			
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
			
			if (isset($this->request->get['filter_customer_child_id'])) {
				$url .= '&filter_customer_child_id=' . $this->request->get['filter_customer_child_id'];
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
			
			$this->redirect($this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('nurse/nurse2b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_nurse_nurse2b->editNurse2b($this->request->get['child_nurse2b_id'], $this->request->post);
	  		
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
			
			$this->redirect($this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('nurse/nurse2b');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse2b');
			
    	if (isset($this->request->get['id']) && $this->request->get['id']<>'' && $this->validateDelete()) {
			$this->model_nurse_nurse2b->deleteNurse2b($this->request->get['customer_child_id'],$this->request->get['id']);
			
			$this->session->data['success'] = $this->language->get('text_del_success');

			$url = '';
			
			if (isset($this->request->get['customer_child_id'])) {
				$url .= '&customer_child_id=' . $this->request->get['customer_child_id'];
			}
			
			$this->redirect($this->url->link('nurse/nurse2b/insert', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getForm();
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
			'href'      => $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL'),
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
			$form2b = $this->model_nurse_nurse2b->getNurse2bs($result['customer_child_id']);
			
			$action = array();
		
			/*
			if (!empty($form2b)) {
				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->link('nurse/nurse2b/update', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] . '&child_nurse2b_id=' . $form2b['child_nurse2b_id'] . $url, 'SSL')
				);
			} else {
				$action[] = array(
					'text' => $this->language->get('text_addnew'),
					'href' => $this->url->link('nurse/nurse2b/insert', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] .  $url, 'SSL')
				);				
			}
			*/
			
			$action[] = array(
				'text' => $this->language->get('text_manage'),
				'href' => $this->url->link('nurse/nurse2b/insert', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] .  $url, 'SSL')
			);	
			if ($form2b) {
				$action[] = array(
					'text' => '下載列印',
					'href' => $this->url->link('nurse/nurse2b/word', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $result['customer_child_id'] .  $url, 'SSL')
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
		
		$this->data['sort_name'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . '&sort=c.name' . $url, 'SSL');
		$this->data['sort_birthdate'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . '&sort=c.birthdate' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_customer_name'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . '&sort=customer_name' . $url, 'SSL');
		
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
		$pagination->url = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		$this->data['filter_birthdate'] = $filter_birthdate;
		$this->data['filter_date_leave'] = $filter_date_leave;
		$this->data['filter_customer_name'] = $filter_customer_name;
		
				
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'nurse/nurse2b_list.tpl';
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
		$this->data['button_add_nurse2b'] = $this->language->get('button_add_nurse2b');
		//$this->data['button_add_contact'] = $this->language->get('button_add_contact');
		//$this->data['button_add_child'] = $this->language->get('button_add_child');
		//$this->data['button_add_transfer'] = $this->language->get('button_add_transfer');
		//$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
    	$this->data['button_remove'] = $this->language->get('button_remove');
	
		//$this->data['tab_general'] = $this->language->get('tab_general');
		//$this->data['tab_contact'] = $this->language->get('tab_contact');
		//$this->data['tab_transfer'] = $this->language->get('tab_transfer');
		//$this->data['tab_moredata'] = $this->language->get('tab_moredata');
		$this->data['tab_datatable'] = $this->language->get('tab_datatable');
		$this->data['tab_nurse2b'] = $this->language->get('tab_nurse2b');
		$this->data['tab_nurse2bform'] = $this->language->get('tab_nurse2bform');

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
			'href'      => $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);


		/*
		if (!isset($this->request->get['child_nurse2b_id'])) {
			$this->data['action'] = $this->url->link('nurse/nurse2b/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('nurse/nurse2b/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . '&child_nurse2b_id=' . $this->request->get['child_nurse2b_id'] . $url, 'SSL');
		}
		*/
		
		$this->data['action'] = $this->url->link('nurse/nurse2b/store', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] . $url, 'SSL');

    	$this->data['cancel'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_child_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$child_nurse2b_id = (isset($this->request->get['child_nurse2b_id'])) ?  $this->request->get['child_nurse2b_id'] : '';
      		
			$form_info = $this->model_nurse_nurse2b->getNurse2b($this->request->get['customer_child_id'], $child_nurse2b_id);
			//$datatables = $this->model_nurse_nurse2b->getDataTables($this->request->get['customer_id']);
			
			$this->load->model('service/child');
			$datatable_info = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
    	}

#!#####

		if (isset($this->request->post['nurse2bform'])) { 
      		$this->data['nurse2bforms'] = $this->request->post['nurse2bform'];
		} elseif (!empty($this->request->get['customer_child_id'])) {
			$this->data['nurse2bforms'] = $this->model_nurse_nurse2b->getNurse2bs($this->request->get['customer_child_id']);
		} else {
			$this->data['nurse2bforms'] = array();
    	}	
	

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
		
		if (isset($this->request->get['customer_child_id'])) {
      		$this->data['customer_child_id'] = $this->request->get['customer_child_id'];
			$this->data['child_name'] = $this->model_nurse_nurse2b->getChildName($this->request->get['customer_child_id']);
    	} elseif (!empty($form_info)) { 
			$this->data['customer_child_id'] = $form_info['customer_child_id'];
			$this->data['child_name'] = $this->model_nurse_nurse2b->getChildName($form_info['customer_child_id']);
		} else {
      		$this->data['customer_child_id'] = '';
			$this->data['child_name'] = '';
    	}	
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($form_info)) { 
			$this->data['date_added'] = $form_info['date_added'];
		} else {
      		$this->data['date_added'] = '';
    	}	

		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => 2);
		$this->data['nurses'] = $this->model_service_customer_service->getCustomerServices($servary);

		if (isset($this->request->post['nurse_id'])) {
      		$this->data['nurse_id'] = $this->request->post['nurse_id'];
    	} elseif (!empty($form_info)) { 
			$this->data['nurse_id'] = $form_info['nurse_id'];
		} else {
      		$this->data['nurse_id'] = 0;
    	}	
		
		$this->data['logged_id'] = $this->user->getId();
		
		if (isset($this->request->post['aggangement'])) {
      		$this->data['aggangement'] = $this->request->post['aggangement'];
    	} elseif (!empty($form_info)) { 
			$this->data['aggangement'] = $form_info['aggangement'];
		} else {
      		$this->data['aggangement'] = '';
    	}	
		
		$nar = array(11,12,13,14,15,17,18,19,20);
		for ($i=1;$i<=23;$i++) {
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['chk'.$i.''] = $form_info['chk'.$i.''];
				} else {
					if (in_array($i, $nar)) {
						$this->data['chk'.$i.''] = array();
					} else {
						$this->data['chk'.$i.''] = '';
					}
				}
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
		
		
		$this->template = 'nurse/nurse2b_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'nurse/nurse2b')) {
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
    	if (!$this->user->hasPermission('delete', 'nurse/nurse2b')) {
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
			$this->load->model('nurse/nurse2b');
			
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