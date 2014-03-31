<?php    
class ControllerServiceCustomer extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('service/customer');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
		
    	$this->getList();
  	}
	
	public function customerword() {		
		$this->load->language('service/customer');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
		
		//$result = $this->model_service_child->get($this->request->get['customer_child_id']);

		if ($customer_info) { 
		
			//$this->load->model('nurse/nurse1c');
			$results = $this->model_service_customer->getDataTables($this->request->get['customer_id']);
		
			$filename = "1A基本資料_".$customer_info['name'];
			
			$this->load->model('service/customer_service');
			$service_name = $this->model_service_customer_service->getCustomerServiceName($customer_info['service_id']);
			
			$contact_infos = $this->model_service_customer->getContacts($customer_info['customer_id']);
			
			/* 表格 1 */
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

				$this->load->model('tool/worddoc');
		
				$titleFormat = array(
									//'text-align' 	=> 'center',
									//'font-weight' 	=> 'bold',
									'font-family' =>	'新細明體',
									'font-size'		=> '14pt');
			
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				//$this->model_tool_worddoc->isDebugging = true;
				//$this->model_tool_worddoc->newSession();

				$this->model_tool_worddoc->addParagraph("1A基本資料：".$customer_info['name'], $titleFormat);
				$this->model_tool_worddoc->addParagraph("表格 1");
				
				if (!empty($tablerows)) {
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable();
						foreach ($tablerow as $row) {
							$this->model_tool_worddoc->addTableRow($row);
						}
						$this->model_tool_worddoc->endTable();
					}
				}
				$this->model_tool_worddoc->addParagraph('');
				
				//$this->model_tool_worddoc->newPage();
				
					//$this->model_tool_worddoc->addParagraph('');
					
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

				//$this->model_tool_worddoc->endSession();
				//$this->model_tool_worddoc->newPage();
				
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
	
	public function childbedcard() {		
		$this->load->language('service/customer');
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
		
		//$result = $this->model_service_child->get($this->request->get['customer_child_id']);

		if ($customer_info) { 
		
			//$this->load->model('nurse/nurse1c');
			$results = $this->model_service_customer->getDataTables($this->request->get['customer_id']);
		
			$filename = "1A床頭卡_".$customer_info['name'];
			
			//$this->load->model('service/customer_service');
			//$service_name = $this->model_service_customer_service->getCustomerServiceName($customer_info['service_id']);
			//$contact_infos = $this->model_service_customer->getContacts($customer_info['customer_id']);
			
			/* 表格 1 */
			foreach ($results as $result) {		
				$childname = ($result['name'] == '' ) ? $result['customer_name']."之".(($result['gender'] == "女") ? "女" : "子") : $result['name'];
				if ($result['bed_id']) {
					$this->load->model('service/child');
					$childbed = $this->model_service_child->getChildBed($result['bed_id']);
				} else {
					$childbed = "";
				}
				
				$tablerows[] = array(
					array (
						'content' => array(PCOMPANY), 
						'span' => array(4)
					),
					array (
						'content' => array('寶寶姓名', $childname , '床號', $childbed), 
						//'span' => array()
					),
					array(
						'content' => array('出生日期', date($this->language->get('date_format_short'), strtotime($result['birthdate'])), '寶寶性別', $result['gender']),
						//'span' => array()
					),
					array(
						'content' => array('出生體重', $result['birthweight']."公克", '出生身高',$result['birthlength']."公分"),
					),
					array(
						'content' => array('入住日期', date($this->language->get('date_format_short'), strtotime($result['date_added'])), ''),
						'span' => array('', '', 2),
						'rspan' => array('', '', 3)
					),
					array(
						'content' => array('入住體重', $result['inweight']."公克"),
						'span' => array('', '', 2)
					),
					array(
						'content' => array('入住身高', $result['inlength']."公分"),
						'span' => array('', '', 2)
					)
				);
			}

				$this->load->model('tool/worddoc');
			
				$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
				$this->model_tool_worddoc->setDocumentCharset('UTF-8');
				//$this->model_tool_worddoc->isDebugging = true;
				//$this->model_tool_worddoc->newSession();
				
				//$this->model_tool_worddoc->addParagraph("1A基本資料：".$customer_info['name'], $titleFormat);
				//$this->model_tool_worddoc->addParagraph("表格 1");
				
				$sty = array('font-family' => '標楷體', 'width' => '52%', 'font-size' => '11pt');
				$bgcolor = ($result['gender'] == "男" ) ? "#E6E6FA" : "#FFE1FF";
				$rowstyle = array(
					"0" => array("font-size" => "14pt", "background" => $bgcolor, "font-weight" => 'bold')
				);
				$rowalign = array(
					'0' => array('center'),
					'1' => array('center','center','center','center')
				);
				$rowclass = array(
					'1' => array('med','large','med','large')
				);
				
				if (!empty($tablerows)) {
					foreach ($tablerows as $tablerow) {
						$this->model_tool_worddoc->startTable($sty);
						foreach ($tablerow as $tbrk => $row) {
							$thisrowalign = (isset($rowalign[$tbrk])) ? $rowalign[$tbrk] : '';
							$thisrowstyle = (isset($rowstyle[$tbrk])) ? $rowstyle[$tbrk] : '';
							$thisrowclass = (isset($rowclass[$tbrk])) ? $rowclass[$tbrk] : '';
							$this->model_tool_worddoc->addTableRow($row, $thisrowalign, '', $thisrowstyle, $thisrowclass);
						}
						$this->model_tool_worddoc->endTable();
						$this->model_tool_worddoc->addParagraph('');
					}
				}
				
				//$this->model_tool_worddoc->newPage();
				//$this->model_tool_worddoc->endSession();
				//$this->model_tool_worddoc->newPage();
				
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
  
  	public function insert() {
		$this->load->language('service/customer');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			if (isset($this->request->get['customer_room_id'])) {
				$this->model_service_customer->addCustomer($this->request->post, $this->request->get['customer_room_id']);
			} else {
				$this->model_service_customer->addCustomer($this->request->post);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('service/customer');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_service_customer->editCustomer($this->request->get['customer_id'], $this->request->post);
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   
	
  	public function setleave() {
		$this->load->language('service/customer');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateLeave()) {
			$this->model_service_customer->setCustomerLeave($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_leave_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			
			if (isset($this->request->get['selected']) && is_array($this->request->get['selected'])) {
				function urlify($key, $val) {
					return 'selected[' . urlencode($key) . ']=' . urlencode($val);
				}
				$url .= '&' . implode('&', array_map('urlify', array_keys($this->request->get['selected']), $this->request->get['selected']));
			}
			
			$this->redirect($this->url->link('service/customer/leave', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->redirect($this->url->link('service/customer/leave', 'token=' . $this->session->data['token'] . $url, 'SSL'));
  	} 

  	public function delete() {
		$this->load->language('service/customer');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $customer_id) {
				$this->model_service_customer->deleteCustomer($customer_id);
			}
			
			$this->session->data['success'] = sprintf($this->language->get('text_delete_success'), count($this->request->post['selected']));

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
	
  	public function copy() {
		$this->load->language('service/customer');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');

    	if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $customer_id) {
				$this->model_service_customer->copyCustomer($customer_id);
			}
			
			$this->session->data['success'] = sprintf($this->language->get('text_copy_success'), count($this->request->post['selected']));

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
	
	public function hideathome() {
		$this->load->language('service/customer');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('service/customer');
		
		if (!$this->user->hasPermission('modify', 'service/customer')) {
			$this->error['warning'] = $this->language->get('error_permission');
		} elseif (isset($this->request->post['selected'])) {
			$hided = 0;
			
			foreach ($this->request->post['selected'] as $customer_id) {
				$customer_info = $this->model_service_customer->getCustomer($customer_id);
				
				if ($customer_info && $customer_info['showathome']) {
					$this->model_service_customer->hideathome($customer_id);
					
					$hided++;
				}
			} 
			
			$this->session->data['success'] = sprintf($this->language->get('text_hideathome'), $hided);	
			
			$url = '';
		
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			
			if (isset($this->request->get['filter_showathome'])) {
				$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
	
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));			
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
			$filter_status = null;
		}
		
		if (isset($this->request->get['filter_showathome'])) {
			$filter_showathome = $this->request->get['filter_showathome'];
		} else {
			$filter_showathome = null;
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
			$sort = 'c.date_added'; 
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
		
		if (isset($this->request->get['filter_room_id'])) {
			$url .= '&filter_room_id=' . $this->request->get['filter_room_id'];
		}
			
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_showathome'])) {
			$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			'href'      => $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->data['hideathome'] = $this->url->link('service/customer/hideathome', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['insert'] = $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['copy'] = $this->url->link('service/customer/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('service/customer/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['leave'] = $this->url->link('service/customer/leave', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['customers'] = array();

		$data = array(
			'filter_name'              => $filter_name, 
			'filter_room_id'            => $filter_room_id, 
			'filter_status'            => $filter_status, 
			'filter_showathome'            => $filter_showathome, 
			'filter_date_added'        => $filter_date_added,
			'filter_date_leave'        => $filter_date_leave,
			'filter_service_id' => $filter_service_id, 
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                    => $this->config->get('config_admin_limit')
		);
		
		$customer_total = $this->model_service_customer->getTotalCustomers($data);
		$results = $this->model_service_customer->getCustomers($data);
 
    	foreach ($results as $rskey => $result) {
			$datatables = $this->model_service_customer->getDataTables($result['customer_id']);
			
			$actionprint = array();
			
			$actionprint[] = array(
				//'text' => $this->language->get('text_edit'),
				'text' => '列印客戶資料',
				'href' => $this->url->link('service/customer/customerword', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . $url, 'SSL')
			);
			
			/*
			if (!empty($datatables)) {
				$actionprint[] = array(
					//'text' => $this->language->get('text_edit'),
					'text' => '列印床頭卡',
					'href' => $this->url->link('service/customer/childbedcard', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . $url, 'SSL')
				);
			}
			*/
			
			$action = array();
		
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('service/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . $url, 'SSL')
			);
			
			$this->data['customers'][] = array(
				'customer_id'    => $result['customer_id'],
				'name'           => $result['name'],
				'room'           => $this->model_service_customer->getLastTransfer($result['customer_id']),
				'status'         => ($result['status'] ? $this->language->get('text_livein') : $this->language->get('text_leave')),
				'showathome'         => ($result['showathome'] ? $this->language->get('text_yes') : $this->language->get('text_no')),
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
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_date_leave'] = $this->language->get('column_date_leave');
		$this->data['column_service'] = $this->language->get('column_service');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_showfilter'] = $this->language->get('button_showfilter');
		$this->data['button_hidefilter'] = $this->language->get('button_hidefilter');
		$this->data['button_hideathome'] = $this->language->get('button_hideathome');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_copy'] = $this->language->get('button_copy');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_leave'] = $this->language->get('button_leave');
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
		
		if (isset($this->request->get['filter_showathome'])) {
			$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
		
		$this->data['sort_name'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_room_id'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=customer_room_id' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_showathome'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=c.showathome' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=c.date_added' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_service'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . '&sort=service' . $url, 'SSL');
		
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
		
		if (isset($this->request->get['filter_showathome'])) {
			$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
		$pagination->url = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		$this->data['filter_room_id'] = $filter_room_id;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_showathome'] = $filter_showathome;
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
		
		$this->template = 'service/customer_list.tpl';
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
		$this->data['text_yes'] = $this->language->get('text_yes');
    	$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_livein'] = $this->language->get('text_livein');
    	$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_select'] = $this->language->get('text_select');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_add_blacklist'] = $this->language->get('text_add_blacklist');
		$this->data['text_remove_blacklist'] = $this->language->get('text_remove_blacklist');
		
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
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_service'] = $this->language->get('entry_service');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_showathome'] = $this->language->get('entry_showathome');
		$this->data['entry_date_added'] = $this->language->get('entry_date_added');
		$this->data['entry_date_leave'] = $this->language->get('entry_date_leave');
		$this->data['entry_default'] = $this->language->get('entry_default');
		$this->data['entry_customer_room_id'] = $this->language->get('entry_customer_room_id');
		$this->data['entry_customer_room'] = $this->language->get('entry_customer_room');
 		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_extra_period'] = $this->language->get('entry_extra_period');
		$this->data['entry_spouse_name'] = $this->language->get('entry_spouse_name');
		$this->data['entry_childbirth_method'] = $this->language->get('entry_childbirth_method');
		$this->data['entry_childbirth_hospital'] = $this->language->get('entry_childbirth_hospital');
		$this->data['entry_childbirth_doctor'] = $this->language->get('entry_childbirth_doctor');
		$this->data['entry_pregnancy_weeks'] = $this->language->get('entry_pregnancy_weeks');
		$this->data['entry_child_count'] = $this->language->get('entry_child_count');
		$this->data['entry_birthhospital'] = $this->language->get('entry_birthhospital');
		$this->data['entry_birthweight'] = $this->language->get('entry_birthweight');
		$this->data['entry_birthhead'] = $this->language->get('entry_birthhead');
		$this->data['entry_birthchest'] = $this->language->get('entry_birthchest');
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

		if (isset($this->request->get['customer_id'])) {
			$this->data['customer_id'] = $this->request->get['customer_id'];
		} else {
			$this->data['customer_id'] = 0;
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

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
		
		if (isset($this->error['date_added'])) {
			$this->data['error_date_added'] = $this->error['date_added'];
		} else {
			$this->data['error_date_added'] = '';
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
		
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
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
		
		/*
		if (isset($this->error['child_name'])) {
			$this->data['error_child_name'] = $this->error['child_name'];
		} else {
			$this->data['error_child_name'] = '';
		}*/
		
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
		
		if (isset($this->request->get['customer_room_id'])) {
			$url .= '&customer_room_id=' . $this->request->get['customer_room_id'];
		}
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_service_id'])) {
			$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_showathome'])) {
			$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
			'href'      => $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);

		if (!isset($this->request->get['customer_id'])) {
			$this->data['action'] = $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('service/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');
		}
		  
    	$this->data['cancel'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
    	}
			
		if (isset($this->request->post['idnumber'])) {
      		$this->data['idnumber'] = $this->request->post['idnumber'];
    	} elseif (!empty($customer_info)) { 
			$this->data['idnumber'] = $customer_info['idnumber'];
		} else {
      		$this->data['idnumber'] = '';
    	}		
		
		if (isset($this->request->post['foreigner'])) {
      		$this->data['foreigner'] = $this->request->post['foreigner'];
    	} elseif (!empty($customer_info)) { 
			$this->data['foreigner'] = $customer_info['foreigner'];
		} else {
      		$this->data['foreigner'] = '';
    	}		
		
		if (isset($this->request->post['birthdate'])) {
      		$this->data['birthdate'] = $this->request->post['birthdate'];
    	} elseif (!empty($customer_info)) { 
			$this->data['birthdate'] = $customer_info['birthdate'];
		} else {
      		$this->data['birthdate'] = '';
    	}		
		
		if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($customer_info)) { 
			$this->data['name'] = $customer_info['name'];
		} else {
      		$this->data['name'] = '';
		}

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
		
		if (isset($this->request->post['email'])) {
      		$this->data['email'] = $this->request->post['email'];
    	} elseif (!empty($customer_info)) { 
			$this->data['email'] = $customer_info['email'];
		} else {
      		$this->data['email'] = '';
    	}
		
		if (isset($this->request->post['fall_score'])) {
      		$this->data['fall_score'] = $this->request->post['fall_score'];
    	} elseif (!empty($customer_info)) { 
			$this->data['fall_score'] = $customer_info['fall_score'];
		} else {
      		$this->data['fall_score'] = '';
    	}
		
		if (isset($this->request->post['depression_score'])) {
      		$this->data['depression_score'] = $this->request->post['depression_score'];
    	} elseif (!empty($customer_info)) { 
			$this->data['depression_score'] = $customer_info['depression_score'];
		} else {
      		$this->data['depression_score'] = '';
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
		
		if (isset($this->request->post['memo'])) {
      		$this->data['memo'] = $this->request->post['memo'];
    	} elseif (!empty($customer_info)) { 
			$this->data['memo'] = $customer_info['memo'];
		} else {
      		$this->data['memo'] = '';
    	}
		
		if (isset($this->request->post['sick_history'])) {
      		$this->data['sick_history'] = $this->request->post['sick_history'];
    	} elseif (!empty($customer_info)) { 
			$this->data['sick_history'] = $customer_info['sick_history'];
		} else {
      		$this->data['sick_history'] = '';
    	}
		
		if (isset($this->request->post['complications'])) {
			$this->data['complications'] = $this->request->post['complications'];
		} elseif (!empty($customer_info)) { 
			$this->data['complications'] = $customer_info['complications'];
		} else {
			$this->data['complications'] = '';
		}
		
		if (isset($this->request->post['food'])) {
			$this->data['food'] = $this->request->post['food'];
		} elseif (!empty($customer_info)) { 
			$this->data['food'] = $customer_info['food'];
		} else {
			$this->data['food'] = '';
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
		
		$this->load->model('system/childbirth_hospital');
		$this->data['childbirth_hospitals'] = $this->model_system_childbirth_hospital->getChildbirthHospitals();
		
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
		
		if (isset($this->request->post['weeks_plus'])) {
      		$this->data['weeks_plus'] = $this->request->post['weeks_plus'];
    	} elseif (!empty($customer_info)) { 
			$this->data['weeks_plus'] = $customer_info['weeks_plus'];
		} else {
      		$this->data['weeks_plus'] = '';
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
		$servary = array("user_group_id" => 3);
		$this->data['services'] = $this->model_service_customer_service->getCustomerServices($servary);

    	if (isset($this->request->post['service_id'])) {
      		$this->data['service_id'] = $this->request->post['service_id'];
    	} elseif (!empty($customer_info)) { 
			$this->data['service_id'] = $customer_info['service_id'];
		} else {
      		$this->data['service_id'] = $this->user->getId();
			//$this->data['service_id'] = "";
    	}
		
    	if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($customer_info)) { 
			$this->data['status'] = $customer_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}
		
    	if (isset($this->request->post['showathome'])) {
      		$this->data['showathome'] = $this->request->post['showathome'];
    	} elseif (!empty($customer_info)) { 
			$this->data['showathome'] = $customer_info['showathome'];
		} else {
      		$this->data['showathome'] = 1;
    	}
		
		if (isset($this->request->post['date_leave'])) {
      		$this->data['date_leave'] = $this->request->post['date_leave'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_leave'] = $customer_info['date_leave'];
		} else {
      		$this->data['date_leave'] = '';
    	}
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_added'] = $customer_info['date_added'];
		} else {
      		$this->data['date_added'] = date($this->language->get('date_format_long'));
    	}
		
		$this->load->model('service/customer_room');
		$this->data['customer_rooms'] = $this->model_service_customer_room->getCustomerEmptyRooms();
		
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
		
		$this->load->model('service/child_bed');
		$this->data['child_beds'] = $this->model_service_child_bed->getChildBeds();
		
		if (isset($this->request->post['child'])) { 
      		$this->data['childs'] = $this->request->post['child'];
		} elseif (!empty($this->request->get['customer_id'])) {
			$this->data['childs'] = $this->model_service_customer->getChilds($this->request->get['customer_id']);
		} else {
			$this->data['childs'] = array();
    	}
		
		$this->template = 'service/customer_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
  	public function leave() {
		$this->load->language('service/customer');
		$this->document->setTitle($this->language->get('heading_title_leave'));
		$this->load->model('service/customer');
		
    	$this->data['heading_title'] = $this->language->get('heading_title_leave');
 
    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
    	$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_livein'] = $this->language->get('text_livein');
    	$this->data['text_leave'] = $this->language->get('text_leave');
		$this->data['text_select'] = $this->language->get('text_select');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_add_blacklist'] = $this->language->get('text_add_blacklist');
		$this->data['text_remove_blacklist'] = $this->language->get('text_remove_blacklist');
		
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
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_service'] = $this->language->get('entry_service');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_showathome'] = $this->language->get('entry_showathome');
		$this->data['entry_date_added'] = $this->language->get('entry_date_added');
		$this->data['entry_date_leave'] = $this->language->get('entry_date_leave');
		$this->data['entry_default'] = $this->language->get('entry_default');
		$this->data['entry_customer_room_id'] = $this->language->get('entry_customer_room_id');
		$this->data['entry_customer_room'] = $this->language->get('entry_customer_room');
 		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_extra_period'] = $this->language->get('entry_extra_period');
		$this->data['entry_spouse_name'] = $this->language->get('entry_spouse_name');
		$this->data['entry_childbirth_method'] = $this->language->get('entry_childbirth_method');
		$this->data['entry_childbirth_hospital'] = $this->language->get('entry_childbirth_hospital');
		$this->data['entry_childbirth_doctor'] = $this->language->get('entry_childbirth_doctor');
		$this->data['entry_pregnancy_weeks'] = $this->language->get('entry_pregnancy_weeks');
		$this->data['entry_child_count'] = $this->language->get('entry_child_count');
		$this->data['entry_birthhospital'] = $this->language->get('entry_birthhospital');
		$this->data['entry_birthweight'] = $this->language->get('entry_birthweight');
		$this->data['entry_birthhead'] = $this->language->get('entry_birthhead');
		$this->data['entry_birthchest'] = $this->language->get('entry_birthchest');
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
	
		//$this->data['tab_general'] = $this->language->get('tab_general');
		//$this->data['tab_contact'] = $this->language->get('tab_contact');
		//$this->data['tab_transfer'] = $this->language->get('tab_transfer');
		//$this->data['tab_moredata'] = $this->language->get('tab_moredata');
		$this->data['tab_leaveform'] = $this->language->get('tab_leaveform');
		$this->data['tab_datatable'] = $this->language->get('tab_datatable');

		$this->data['token'] = $this->session->data['token'];

		/*
		if (isset($this->request->get['customer_id'])) {
			$this->data['customer_id'] = $this->request->get['customer_id'];
		} else {
			$this->data['customer_id'] = 0;
		}
		*/

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
		
		if (isset($this->error['date_added'])) {
			$this->data['error_date_added'] = $this->error['date_added'];
		} else {
			$this->data['error_date_added'] = '';
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
		
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
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
		
		/*
		if (isset($this->error['child_name'])) {
			$this->data['error_child_name'] = $this->error['child_name'];
		} else {
			$this->data['error_child_name'] = '';
		}*/
		
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
		
		if (isset($this->request->get['filter_service_id'])) {
			$url .= '&filter_service_id=' . $this->request->get['filter_service_id'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_showathome'])) {
			$url .= '&filter_showathome=' . $this->request->get['filter_showathome'];
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
       		'text'      => $this->language->get('heading_title_leave'),
			'href'      => $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		//print_r($this->request->post['selected']);
		//print_r($this->request->get);
		if (empty($this->request->post['selected'])&&empty($this->request->get['selected'])) {
			$this->redirect($this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
		$customer_infos = array();
		$customer_leave = array();
		$datatables = array();
		
		function urlify($key, $val) {
			return 'selected[' . urlencode($key) . ']=' . urlencode($val);
		}
		
		$selected_customers = (isset($this->request->post['selected'])) ? $this->request->post['selected'] : $this->request->get['selected'];
		$selectedar = '&' . implode('&', array_map('urlify', array_keys($selected_customers), $selected_customers));
		$this->data['action'] = $this->url->link('service/customer/setleave', 'token=' . $this->session->data['token'] . $selectedar . $url, 'SSL');
		
		foreach ($selected_customers as $customer_id) {
			$rooms = $this->model_service_customer->getTransfers($customer_id);
			$lastrooms = $this->model_service_customer->getTransfers($customer_id, 'DESC', 0, 1);
			$customer_infos[] = $this->model_service_customer->getCustomer($customer_id);
			$customer_leave[] = $this->model_service_customer->getCustomerLeave($customer_id);
			
			if (!empty($rooms)) {
				if (count($rooms) == "1") {
					$datatables[] = array(
						$this->model_service_customer->getDataTables($customer_id),
						'customer_firstroom' => $rooms[0]['customer_room_name'],
						'customer_transfers'	=> array(),
						'customer_lastroom'	=> (isset($lastrooms[0]['customer_room_name'])) ? $lastrooms[0]['customer_room_name'] : ''
					);
				} else {
					$aaa = array();
					for ($i=0;$i<count($rooms)-1;$i++) {
						$aaa[] = $rooms[$i+1];
					}
					$datatables[] = array(
						$this->model_service_customer->getDataTables($customer_id),
						'customer_firstroom' => $rooms[0]['customer_room_name'],
						'customer_transfers'	=> $aaa,
						'customer_lastroom'	=> (isset($lastrooms[0]['customer_room_name'])) ? $lastrooms[0]['customer_room_name'] : ''
					);
				}
			} else {
				$datatables[] = array(
					$this->model_service_customer->getDataTables($customer_id),
					'customer_firstroom' => '尚未指定房間',
					'customer_transfers'	=> array(),
					'customer_lastroom'	=> (isset($lastrooms[0]['customer_room_name'])) ? $lastrooms[0]['customer_room_name'] : ''
				);
			}
			
			
			
		}

		//print_r($customer_leave);
		//$this->data['customers'] = $customer_infos;
		$child_leave = array();
		foreach ($customer_infos as $j => $customer) {
			$child_leave = $this->model_service_customer->getCustomerChildLeaves($customer['customer_id']);

			if (!empty($customer_leave[$j])) {
				$this->data['customers'][$j] = array(
					'name' => $customer['name'],
					'customer_leave_id' => $customer_leave[$j]['customer_leave_id'],
					'customer_id' => $customer_leave[$j]['customer_id'],
					'date_added' => $customer_leave[$j]['date_added'],
					'service_id' => $customer_leave[$j]['service_id'],
					'groupchk' => $customer_leave[$j]['groupchk'],
					//'chk1' => $customer_leave[$j]['chk1'],
					'chk2' => $customer_leave[$j]['chk2'],
					'chk3' => $customer_leave[$j]['chk3'],
					'chk4' => $customer_leave[$j]['chk4'],
					'chk6' => $customer_leave[$j]['chk6'],
					'chk7' => $customer_leave[$j]['chk7'],
					'child_leave' => $child_leave
				);
			} elseif (isset($this->request->post['customerleaveform'])) {
				$this->data['customers'][$j] = array(
					'name'	=> $customer['name'],
					'customer_leave_id' => $this->request->post['customerleaveform'][$j]['customer_leave_id'],
					'customer_id' => $this->request->post['customerleaveform'][$j]['customer_id'],
					'date_added' => $this->request->post['customerleaveform'][$j]['date_added'],
					'service_id' => $this->request->post['customerleaveform'][$j]['service_id'],
					'groupchk'	=> serialize($this->request->post['customerleaveform'][$j]['groupchk']),
					//'chk1'	=> $this->request->post['customerleaveform'][$j]['chk1'],
					'chk2'	=> $this->request->post['customerleaveform'][$j]['chk2'],
					'chk3'	=> $this->request->post['customerleaveform'][$j]['chk3'],
					'chk4'	=> $this->request->post['customerleaveform'][$j]['chk4'],
					'chk6'	=> $this->request->post['customerleaveform'][$j]['chk6'],
					'chk7'	=> $this->request->post['customerleaveform'][$j]['chk7'],
					'child_leave' => $this->request->post['customerleaveform'][$j]['child_leave']
				);
			} else {
				$this->data['customers'][$j] = array(
					'name'	=> $customer['name'],
					'customer_leave_id' => 0,
					'customer_id' => $customer['customer_id'],
					'date_added' => date($this->language->get('date_format_short'), strtotime("now")),
					'service_id' => 0,
					'groupchk' => '',
					//'chk1'	=> '',
					'chk2'	=> '',
					'chk3'	=> '',
					'chk4'	=> '',
					'chk6'	=> '',
					'chk7'	=> '',
					'child_leave' => $child_leave
				);
			}
		}
		
		$this->data['datatables'] = $datatables;

		/*
		if (!isset($this->request->get['customer_id'])) {
			$this->data['action'] = $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('service/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');
		}
		*/
		  
    	$this->data['cancel'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => array('2','3'));
		$this->data['services'] = $this->model_service_customer_service->getCustomerServices($servary);

		/*
		if (isset($this->request->post['nurse2bform'])) { 
      		$this->data['nurse2bforms'] = $this->request->post['nurse2bform'];
		} else {
			$this->data['nurse2bforms'] = array();
    	}	
		
    	if (isset($this->request->post['service_id'])) {
      		$this->data['service_id'] = $this->request->post['service_id'];
    	} else {
      		$this->data['service_id'] = $this->user->getId();
			//$this->data['service_id'] = "";
    	}
		*/
		
		/*
    	if (isset($this->request->get['customer_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
    	}
		*/
			
		/*
		if (isset($this->request->post['idnumber'])) {
      		$this->data['idnumber'] = $this->request->post['idnumber'];
    	} elseif (!empty($customer_info)) { 
			$this->data['idnumber'] = $customer_info['idnumber'];
		} else {
      		$this->data['idnumber'] = '';
    	}		
		
		if (isset($this->request->post['foreigner'])) {
      		$this->data['foreigner'] = $this->request->post['foreigner'];
    	} elseif (!empty($customer_info)) { 
			$this->data['foreigner'] = $customer_info['foreigner'];
		} else {
      		$this->data['foreigner'] = '';
    	}		
		
		if (isset($this->request->post['birthdate'])) {
      		$this->data['birthdate'] = $this->request->post['birthdate'];
    	} elseif (!empty($customer_info)) { 
			$this->data['birthdate'] = $customer_info['birthdate'];
		} else {
      		$this->data['birthdate'] = '';
    	}		
		
		if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($customer_info)) { 
			$this->data['name'] = $customer_info['name'];
		} else {
      		$this->data['name'] = '';
		}

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
		
		if (isset($this->request->post['email'])) {
      		$this->data['email'] = $this->request->post['email'];
    	} elseif (!empty($customer_info)) { 
			$this->data['email'] = $customer_info['email'];
		} else {
      		$this->data['email'] = '';
    	}
		
		if (isset($this->request->post['fall_score'])) {
      		$this->data['fall_score'] = $this->request->post['fall_score'];
    	} elseif (!empty($customer_info)) { 
			$this->data['fall_score'] = $customer_info['fall_score'];
		} else {
      		$this->data['fall_score'] = '';
    	}
		
		if (isset($this->request->post['depression_score'])) {
      		$this->data['depression_score'] = $this->request->post['depression_score'];
    	} elseif (!empty($customer_info)) { 
			$this->data['depression_score'] = $customer_info['depression_score'];
		} else {
      		$this->data['depression_score'] = '';
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
		
		if (isset($this->request->post['weeks_plus'])) {
      		$this->data['weeks_plus'] = $this->request->post['weeks_plus'];
    	} elseif (!empty($customer_info)) { 
			$this->data['weeks_plus'] = $customer_info['weeks_plus'];
		} else {
      		$this->data['weeks_plus'] = '';
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
		
    	if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($customer_info)) { 
			$this->data['status'] = $customer_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}
		
    	if (isset($this->request->post['showathome'])) {
      		$this->data['showathome'] = $this->request->post['showathome'];
    	} elseif (!empty($customer_info)) { 
			$this->data['showathome'] = $customer_info['showathome'];
		} else {
      		$this->data['showathome'] = 1;
    	}
		
		if (isset($this->request->post['date_leave'])) {
      		$this->data['date_leave'] = $this->request->post['date_leave'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_leave'] = $customer_info['date_leave'];
		} else {
      		$this->data['date_leave'] = '';
    	}
		
		if (isset($this->request->post['date_added'])) {
      		$this->data['date_added'] = $this->request->post['date_added'];
    	} elseif (!empty($customer_info)) { 
			$this->data['date_added'] = $customer_info['date_added'];
		} else {
      		$this->data['date_added'] = date($this->language->get('date_format_long'));
    	}
		
		$this->load->model('service/customer_room');
		$this->data['customer_rooms'] = $this->model_service_customer_room->getCustomerEmptyRooms();
		
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
		
		$this->load->model('service/child_bed');
		$this->data['child_beds'] = $this->model_service_child_bed->getChildBeds();
		
		if (isset($this->request->post['child'])) { 
      		$this->data['childs'] = $this->request->post['child'];
		} elseif (!empty($this->request->get['customer_id'])) {
			$this->data['childs'] = $this->model_service_customer->getChilds($this->request->get['customer_id']);
		} else {
			$this->data['childs'] = array();
    	}
		*/
		
		$this->template = 'service/customer_leave.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'service/customer')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		if (!isset($this->request->post['foreigner']) ) {
			if ( !$this->model_service_customer->isROCID($this->request->post['idnumber']) ) {
				$this->error['idnumber'] = $this->language->get('error_idnumber');
			}
		}

		/* for the customer live not once
		$customer_info = $this->model_service_customer->getCustomerByIDNumber($this->request->post['idnumber']);
		
		if (!isset($this->request->get['customer_id'])) {
			if ($customer_info) {
				$this->error['warning'] = $this->language->get('error_idnumber_exists');
			}
		} else {
			if ($customer_info && ($this->request->get['customer_id'] != $customer_info['customer_id'])) {
				$this->error['warning'] = $this->language->get('error_idnumber_exists');
			}
		}
		*/
		
		if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}
		
    	if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
      		$this->error['telephone'] = $this->language->get('error_telephone');
    	}
		
    	if ($this->request->post['date_added'] =='' || $this->request->post['date_added'] == '0000-00-00' ) {
      		$this->error['date_added'] = $this->language->get('error_date_added');
    	}
		
		if (isset($this->request->post['contact'])) {
			foreach ($this->request->post['contact'] as $key => $value) {			
				
				if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 64)) {
					$this->error['contact_name'][$key] = $this->language->get('error_contact_name');
				}	
				
				if ($value['telephone'] == "") {
					$this->error['contact_telephone'][$key] = $this->language->get('error_contact_telephone');
				}
				
				if (!isset($value['relationship'])) {
					$this->error['contact_relationship'][$key] = $this->language->get('error_contact_relationship');
				}
				
			}
		}
		
		if (isset($this->request->post['child'])) {
			foreach ($this->request->post['child'] as $key => $value) {			
				/*
				if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 64)) {
					$this->error['child_name'][$key] = $this->language->get('child_name');
				}
				*/
				
				if (utf8_strlen($value['gender']) < 1) {
					$this->error['child_gender'][$key] = $this->language->get('error_child_gender');
				}
			
				if ($value['birthdate'] == "") {
					$this->error['child_birthdate'][$key] = $this->language->get('error_child_birthdate');
				}
				
			}
		}
			
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
	
  	protected function validateCopy() {
    	if (!$this->user->hasPermission('modify', 'service/customer')) {
      		$this->error['warning'] = $this->language->get('error_permission');  
    	}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}
	
  	protected function validateLeave() {
    	if (!$this->user->hasPermission('modify', 'service/customer')) {
      		$this->error['warning'] = $this->language->get('error_permission');  
    	}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}
	
	public function transfer() {
    	$this->language->load('service/customer');
		
		$this->load->model('service/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->user->hasPermission('modify', 'service/customer')) { 
			$extra_period = (isset($this->request->post['extra_period'])&&$this->request->post['extra_period']) ? $this->request->post['extra_period'] : 0;
			$this->model_service_customer->addTransfer($this->request->get['customer_id'], $this->request->post['description'], $extra_period, $this->request->post['customer_room_id']);
				
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
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_yes'] = $this->language->get('text_yes');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_extra_period'] = $this->language->get('column_extra_period');
		$this->data['column_customer_room'] = $this->language->get('column_customer_room');
		
		$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['transfers'] = array();
			
		$results = $this->model_service_customer->getTransfers($this->request->get['customer_id'], 'DESC', ($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
        	$this->data['transfers'][] = array(
				'customer_transfer_id'      => $result['customer_transfer_id'],
				'customer_room_id'      => $result['customer_room_id'],
				'customer_room_name'      => $result['customer_room_name'],
				'description' => $result['description'],
				'extra_period' => $result['extra_period'],
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
	
	public function deltransfer() {
    	$this->language->load('service/customer');
		
		$this->load->model('service/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->user->hasPermission('modify', 'service/customer')) { 
			$this->model_service_customer->deleteTransfer($this->request->get['customer_id'], $this->request->get['customer_transfer_id']);
				
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
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_yes'] = $this->language->get('text_yes');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_extra_period'] = $this->language->get('column_extra_period');
		$this->data['column_customer_room'] = $this->language->get('column_customer_room');
		
		$this->data['button_delete_transfer'] = $this->language->get('button_delete_transfer');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['transfers'] = array();
			
		$results = $this->model_service_customer->getTransfers($this->request->get['customer_id'], "DESC", ($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
        	$this->data['transfers'][] = array(
				'customer_transfer_id'      => $result['customer_transfer_id'],
				'customer_room_id'      => $result['customer_room_id'],
				'customer_room_name'      => $result['customer_room_name'],
				'description' => $result['description'],
				'extra_period' => $result['extra_period'],
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

	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name'])) {
			$this->load->model('service/customer');
			$this->load->model('service/customer_room');
			
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
					'room_name'			=> $this->model_service_customer_room->getCustomerRoomName($result['customer_room_id']),
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