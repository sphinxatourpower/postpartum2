<?php    
class ControllerNurseNurse5c extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->load->language('nurse/nurse5c');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse5c');
		
    	$this->getList();
  	}
	
	public function word() {		
		$this->load->language('nurse/nurse5c');
    	$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('nurse/nurse5c');
		
		$this->load->model('service/customer');
		$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);

		if ($customer_info) { 
			$this->load->model('tool/worddoc');
			
			$this->model_tool_worddoc->clsMsDocGenerator('PORTRAIT','A4','',1,1,1,1);
			$this->model_tool_worddoc->setDocumentCharset('UTF-8');
					
			$nurse5c_infos = $this->model_nurse_nurse5c->getNurse5cs($this->request->get['customer_id']);
			
			foreach ($nurse5c_infos as $kk => $nurse5c_info) {
				
				$filename = "2C產後衛教每日身評紀錄單_".$customer_info['name'];
				
				$this->load->model('service/customer_service');
				$nurse_name = $this->model_service_customer_service->getCustomerServiceName($nurse5c_info['nurse_id']);
					
			
					$titleFormat = array(
										//'text-align' 	=> 'center',
										//'font-weight' 	=> 'bold',
										'font-family' =>	'新細明體',
										'font-size'		=> '14pt');
				
					
					//$this->model_tool_worddoc->isDebugging = true;
					//$this->model_tool_worddoc->newSession();
					if ($nurse5c_info) {
						$this->model_tool_worddoc->addParagraph("2C產後衛教每日身評紀錄單：".$nurse5c_info['date_added'], $titleFormat);
					
						$this->model_tool_worddoc->addParagraph("護理人員：".$nurse_name);
						$this->model_tool_worddoc->addParagraph("產後天數：".$nurse5c_info['days_afterbirth']."，入住天數：".$nurse5c_info['days_livein']);
						
						$this->model_tool_worddoc->addParagraph("");
						$this->model_tool_worddoc->addParagraph("《身體評估》", array("font-size"=>'14pt', 'font-weight'=>'bold'));
						
						if ($nurse5c_info['chk24']<>'') {
							$this->model_tool_worddoc->addParagraph("體溫：".$nurse5c_info['chk24']."℃");
						}
						if ($nurse5c_info['chk25']<>'') {
							$this->model_tool_worddoc->addParagraph("脈搏：".$nurse5c_info['chk25']."（每分鐘）");
						}
						if ($nurse5c_info['chk26']<>'') {
							$this->model_tool_worddoc->addParagraph("呼吸：".$nurse5c_info['chk26']."（每分鐘）");
						}
						if ($nurse5c_info['chk27a']<>'' AND $nurse5c_info['chk27b']<>'') {
							$this->model_tool_worddoc->addParagraph("血壓：(收縮壓):".$nurse5c_info['chk27a']."mmHg&#32;(舒張壓):".$nurse5c_info['chk27b']."mmHg");
						}
						if ($nurse5c_info['chk1']<>'') {
							$this->model_tool_worddoc->addParagraph("右側乳頭外觀為：".$nurse5c_info['chk1']);
						}
						if ($nurse5c_info['chk2']<>'') {
							$this->model_tool_worddoc->addParagraph("左側乳頭外觀為：".$nurse5c_info['chk2']);
						}
						if ($nurse5c_info['chk3']<>'') {
							$this->model_tool_worddoc->addParagraph("右側乳暈外觀為：".$nurse5c_info['chk3']);
						}
						if ($nurse5c_info['chk4']<>'') {
							$this->model_tool_worddoc->addParagraph("左側乳暈外觀為：".$nurse5c_info['chk4']);
						}
						if ($nurse5c_info['chk5']<>'') {
							$this->model_tool_worddoc->addParagraph("右側乳房外觀為：".$nurse5c_info['chk5']);
						}
						if ($nurse5c_info['chk6']<>'') {
							$this->model_tool_worddoc->addParagraph("左側乳房外觀為：".$nurse5c_info['chk6']);
						}
						if ($nurse5c_info['chk7']<>'') {
							$this->model_tool_worddoc->addParagraph("單次雙側奶量為四小時：".$nurse5c_info['chk7']);
						}
						if ($nurse5c_info['chk8']<>'') {
							$this->model_tool_worddoc->addParagraph("宮底位置為：".$nurse5c_info['chk8']);
						}
						if ($nurse5c_info['chk9']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露量為：".$nurse5c_info['chk9']);
						}
						if ($nurse5c_info['chk10']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露顏色為：".$nurse5c_info['chk10']);
						}
						if ($nurse5c_info['chk11']<>'') {
							$this->model_tool_worddoc->addParagraph("惡露性質為：".$nurse5c_info['chk11']);
						}
						if ($nurse5c_info['chk12']<>'') {
							$this->model_tool_worddoc->addParagraph("該產婦 NSD 傷口為：".$nurse5c_info['chk12']);
						}
						if ($nurse5c_info['chk13']<>'') {
							$this->model_tool_worddoc->addParagraph("該產婦 C/S 傷口為：".$nurse5c_info['chk13']);
						}
						if ($nurse5c_info['chk14']<>'') {
							$this->model_tool_worddoc->addParagraph("痔瘡：".$nurse5c_info['chk14']);
						}
						if ($nurse5c_info['chk15']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦情緒為：".$nurse5c_info['chk15']);
						}
						if ($nurse5c_info['chk16']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦本日食慾：".$nurse5c_info['chk16']);
						}
						if ($nurse5c_info['chk17']<>'') {
							$this->model_tool_worddoc->addParagraph("活動精神狀況：".$nurse5c_info['chk17']);
						}
						if ($nurse5c_info['chk18']<>'') {
							$this->model_tool_worddoc->addParagraph("乳汁排洩情況：".$nurse5c_info['chk18']);
						}
						if ($nurse5c_info['chk19']<>'') {
							$this->model_tool_worddoc->addParagraph("乳房狀況：".$nurse5c_info['chk19']);
						}
						if ($nurse5c_info['chk20']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦按摩乳房狀況為：".$nurse5c_info['chk20']);
						}
						if ($nurse5c_info['chk21']<>'') {
							$this->model_tool_worddoc->addParagraph("學習餵奶打嗝技巧：".$nurse5c_info['chk21']);
						}
						if ($nurse5c_info['chk22']<>'') {
							$this->model_tool_worddoc->addParagraph("排尿情形：".$nurse5c_info['chk22']);
						}
						if ($nurse5c_info['chk23']<>'') {
							$this->model_tool_worddoc->addParagraph("排便狀況：".$nurse5c_info['chk23']);
						}
						if (is_array($subedu = unserialize($nurse5c_info['subject_healthedu'])) AND !empty($subedu)) {
							$textsubedu = '';
							foreach ($subedu as $data) {
								$textsubedu .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("本日衛教題目為：".$textsubedu);
						}
						if ($nurse5c_info['supplement']<>'') {
							$this->model_tool_worddoc->addParagraph("本日補充說明：<br />".nl2br($nurse5c_info['supplement']));
						}
						
						$this->model_tool_worddoc->addParagraph("");
						$this->model_tool_worddoc->addParagraph("《資料紀錄》", array("font-size"=>'14pt', 'font-weight'=>'bold'));
						
						if ($nurse5c_info['chk28']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦本日意識狀況為：".$nurse5c_info['chk28']);
						}
						if ($nurse5c_info['chk29']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦生產方式為：".$nurse5c_info['chk29']."，傷口使用除疤凝膠");
						}
						if ($nurse5c_info['chk30']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦身體不適，建議外出至：".$nurse5c_info['chk30']."就醫");
						}
						if (is_array($c31 = unserialize($nurse5c_info['chk31'])) AND !empty($c31)) {
							$textc31 = '';
							foreach ($c31 as $data) {
								$textc31 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦本日感冒症狀為：".$textc31);
						}
						if (is_array($c32 = unserialize($nurse5c_info['chk32'])) AND !empty($c32)) {
							$textc32 = '';
							foreach ($c32 as $data) {
								$textc32 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦本日有腸胃炎症狀為：".$textc32);
						}
						if (is_array($c33 = unserialize($nurse5c_info['chk33'])) AND !empty($c33)) {
							$textc33 = '';
							foreach ($c33 as $data) {
								$textc33 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦皮膚有紅疹部位為：".$textc33);
						}
						if ($nurse5c_info['chk34']<>'') {
							$this->model_tool_worddoc->addParagraph("已告知產婦，寶寶接觸到父母親以外的第三人，需在媽媽房隔離 ".$nurse5c_info['chk34']);
						}
						if (is_array($c35 = unserialize($nurse5c_info['chk35'])) AND !empty($c35)) {
							$textc35 = '';
							foreach ($c35 as $data) {
								$textc35 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("已告知產婦，寶寶有 ".$textc35."，需在媽媽房隔離自我照顧，期間每日可退 800 元，直到症狀解除，沒有感染疑慮，才可回到嬰兒室。");
						}
						if ($nurse5c_info['chk36']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦有服藥，藥物為：".$nurse5c_info['chk36']);
						}
						if ($nurse5c_info['chk37a']<>'' AND $nurse5c_info['chk37a']<>'0000-00-00 00:00:00') {
							$this->model_tool_worddoc->addParagraph("產婦本日外出，時間為：".$nurse5c_info['chk37a']);
						}
						if ($nurse5c_info['chk37b']<>'' AND $nurse5c_info['chk37b']<>'0000-00-00 00:00:00') {
							$this->model_tool_worddoc->addParagraph("產婦返回，時間為：".$nurse5c_info['chk37b']);
						}
						if (is_array($c38 = unserialize($nurse5c_info['chk38'])) AND !empty($c38)) {
							$textc38 = '';
							foreach ($c38 as $data) {
								$textc38 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦抱怨伙食不適應，感覺口味 ".$textc38."，已請廚師作調整");
						}
						if (is_array($c39 = unserialize($nurse5c_info['chk39'])) AND !empty($c39)) {
							$textc39 = '';
							foreach ($c39 as $data) {
								$textc39 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦覺得環境 ".$textc39);
						}
						if (is_array($c40 = unserialize($nurse5c_info['chk40'])) AND !empty($c40)) {
							$textc40 = '';
							foreach ($c40 as $data) {
								$textc40 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦心情欠佳，建議 ".$textc40." 多給予心靈支持");
						}
						if (is_array($c41 = unserialize($nurse5c_info['chk41'])) AND !empty($c41)) {
							$textc41 = '';
							foreach ($c41 as $data) {
								$textc41 .= $data.",";
							}
							$this->model_tool_worddoc->addParagraph("產婦有 ".$textc41." 密集造訪，建議減少次數，以免寶寶受感染");
						}
						if ($nurse5c_info['chk42']<>'') {
							$this->model_tool_worddoc->addParagraph("產婦基本狀況".$nurse5c_info['chk42']."，身體健康，心情愉快，安心調養中");
						}
						if ($nurse5c_info['supplement_record']<>'') {
							$this->model_tool_worddoc->addParagraph("特別補充事項：<br />".nl2br($nurse5c_info['supplement_record']));
						}

					
					}

					if ($kk+1 < count($nurse5c_infos)) {
						$this->model_tool_worddoc->newPage();
					}
					//$this->model_tool_worddoc->endSession();
					//$this->model_tool_worddoc->newPage();
					
				}
				$this->model_tool_worddoc->output($filename.'.doc');
		} else {
			$this->error['warning'] = '查無資料' ;
			
			$this->getList();
		}
  	}
  
  	public function store() {
		$this->load->language('nurse/nurse5c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse5c');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_nurse_nurse5c->addNurse5c($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}		
					
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
			
			//$this->redirect($this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			$this->redirect($this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id='. $this->request->get['customer_id'] . $url, 'SSL'));
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
		$this->load->language('nurse/nurse5c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse5c');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_nurse_nurse5c->addNurse5c($this->request->post);
			
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
			
			$this->redirect($this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->load->language('nurse/nurse5c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse5c');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_nurse_nurse5c->editNurse5c($this->request->get['customer_nurse5c_id'], $this->request->post);
	  		
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
			
			$this->redirect($this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->load->language('nurse/nurse5c');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('nurse/nurse5c');
			
    	if (isset($this->request->get['id']) && $this->request->get['id']<>'' && $this->validateDelete()) {
			$this->model_nurse_nurse5c->deleteNurse5c($this->request->get['customer_id'],$this->request->get['id']);
			
			$this->session->data['success'] = $this->language->get('text_del_success');

			$url = '';

			if (isset($this->request->get['customer_id'])) {
				$url .= '&customer_id=' . $this->request->get['customer_id'];
			}
			
			$this->redirect($this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getForm();
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
			'href'      => $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL'),
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
			$form5cs = $this->model_nurse_nurse5c->getNurse5cs($result['customer_id']);
			
			$action = array();
		
			/*
			if (!empty($form5cs)) {
				foreach ($form5cs as $f5c) {
					$action[] = array(
						'text' => $this->language->get('text_edit').$f5c['date_added'],
						'href' => $this->url->link('nurse/nurse5c/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] . '&customer_nurse5c_id=' . $f5c['customer_nurse5c_id'] . $url, 'SSL')
					);
				}
				$action[] = array(
					'text' => $this->language->get('text_addnew'),
					'href' => $this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] .  $url, 'SSL')
				);		
			} else {
				$action[] = array(
					'text' => $this->language->get('text_addnew'),
					'href' => $this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] .  $url, 'SSL')
				);				
			}
			*/
			
			$action[] = array(
				'text' => $this->language->get('text_manage'),
				'href' => $this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] .  $url, 'SSL')
			);				
			
			if (!empty($form5cs)) {
				$action[] = array(
					'text' => '下載列印',
					'href' => $this->url->link('nurse/nurse5c/word', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] .  $url, 'SSL')
				);	
				$action[] = array(
					'text' => '觀看統計',
					'href' => $this->url->link('report/stat1', 'token=' . $this->session->data['token'] . '&filter_customer_id=' . $result['customer_id'] .  $url, 'SSL')
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
		$this->data['column_havedone'] = $this->language->get('column_havedone');		
		
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
		
		$this->data['sort_name'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_room_id'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=customer_room_id' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=c.date_added' . $url, 'SSL');
		$this->data['sort_date_leave'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=c.date_leave' . $url, 'SSL');
		$this->data['sort_service'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . '&sort=service' . $url, 'SSL');
		
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
		$pagination->url = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
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
		
		$this->template = 'nurse/nurse5c_list.tpl';
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
		$this->data['button_add_nurse5c'] = $this->language->get('button_add_nurse5c');
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
		$this->data['tab_nurse5c'] = $this->language->get('tab_nurse5c');
		$this->data['tab_nurse5cform'] = $this->language->get('tab_nurse5cform');

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
			'href'      => $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);

		if (!isset($this->request->get['customer_id'])) { $this->redirect($this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL')); }
		
		/*
		if (!isset($this->request->get['customer_nurse5c_id'])) {
			$this->data['action'] = $this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('nurse/nurse5c/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . '&customer_nurse5c_id=' . $this->request->get['customer_nurse5c_id'] . $url, 'SSL');
		}
		*/
		
		$this->data['action'] = $this->url->link('nurse/nurse5c/store', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] . $url, 'SSL');

    	$this->data['cancel'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['customer_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$customer_nurse5c_id = (isset($this->request->get['customer_nurse5c_id'])) ?  $this->request->get['customer_nurse5c_id'] : '';
      		
			$form_info = $this->model_nurse_nurse5c->getNurse5c($this->request->get['customer_id'], $customer_nurse5c_id);
			$datatables = $this->model_nurse_nurse5c->getDataTables($this->request->get['customer_id']);
    	}

#!#####

		if (isset($this->request->post['nurse5cform'])) { 
      		$this->data['nurse5cforms'] = $this->request->post['nurse5cform'];
		} elseif (!empty($this->request->get['customer_id'])) {
			$this->data['nurse5cforms'] = $this->model_nurse_nurse5c->getNurse5cs($this->request->get['customer_id']);
		} else {
			$this->data['nurse5cforms'] = array();
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
		
/*		
		if (isset($this->request->post['subject_healthedu'])) {
      		$this->data['subject_healthedu'] = $this->request->post['subject_healthedu'];
    	} elseif (!empty($form_info)) { 
			$this->data['subject_healthedu'] = $form_info['subject_healthedu'];
		} else {
      		$this->data['subject_healthedu'] = array();
    	}	
		
		if (isset($this->request->post['days_afterbirth'])) {
      		$this->data['days_afterbirth'] = $this->request->post['days_afterbirth'];
    	} elseif (!empty($form_info)) { 
			$this->data['days_afterbirth'] = $form_info['days_afterbirth'];
		} else {
      		$this->data['days_afterbirth'] = '';
    	}	
		
		if (isset($this->request->post['days_livein'])) {
      		$this->data['days_livein'] = $this->request->post['days_livein'];
    	} elseif (!empty($form_info)) { 
			$this->data['days_livein'] = $form_info['days_livein'];
		} else {
      		$this->data['days_livein'] = '';
    	}	
		
		if (isset($this->request->post['chk27a'])) {
      		$this->data['chk27a'] = $this->request->post['chk27a'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk27a'] = $form_info['chk27a'];
		} else {
      		$this->data['chk27a'] = '';
    	}	
		
		if (isset($this->request->post['chk27b'])) {
      		$this->data['chk27b'] = $this->request->post['chk27b'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk27b'] = $form_info['chk27b'];
		} else {
      		$this->data['chk27b'] = '';
    	}	
		
		if (isset($this->request->post['chk37a'])) {
      		$this->data['chk37a'] = $this->request->post['chk37a'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk37a'] = $form_info['chk37a'];
		} else {
      		$this->data['chk37a'] = '';
    	}	
		
		if (isset($this->request->post['chk37b'])) {
      		$this->data['chk37b'] = $this->request->post['chk37b'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk37b'] = $form_info['chk37b'];
		} else {
      		$this->data['chk37b'] = '';
    	}	
*/		
		
		for ($i=1;$i<=26;$i++) {
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['chk'.$i.''] = $form_info['chk'.$i.''];
				} else {
					$this->data['chk'.$i.''] = '';
				}
		}
		
/*		
		$nar = array(31,32,33,35);
		for ($i=28;$i<=36;$i++) {
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
		for ($i=38;$i<=41;$i++) {	
				if (isset($this->request->post['chk'.$i.''])) {
					$this->data['chk'.$i.''] = $this->request->post['chk'.$i.''];
				} elseif (!empty($form_info)) { 
					$this->data['chk'.$i.''] = $form_info['chk'.$i.''];
				} else {
					$this->data['chk'.$i.''] = array();
				}
		}
		if (isset($this->request->post['chk42'])) {
      		$this->data['chk42'] = $this->request->post['chk42'];
    	} elseif (!empty($form_info)) { 
			$this->data['chk42'] = $form_info['chk42'];
		} else {
      		$this->data['chk42'] = '';
    	}	
*/		
		
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
		
		
		$this->template = 'nurse/nurse5c_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
				
		$this->response->setOutput($this->render());
	}
			 
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'nurse/nurse5c')) {
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
    	if (!$this->user->hasPermission('delete', 'nurse/nurse5c')) {
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
			$this->load->model('nurse/nurse5c');
			
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