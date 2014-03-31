<?php 
class ControllerSystemChildbirthHospital extends Controller { 
	private $error = array();
   
  	public function index() {
		$this->load->language('system/childbirth_hospital');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/childbirth_hospital');
		
    	$this->getList();
  	}
              
  	public function insert() {
		$this->load->language('system/childbirth_hospital');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/childbirth_hospital');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      		$this->model_system_childbirth_hospital->addChildbirthHospital($this->request->post);
		  	
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
      		$this->redirect($this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	
    	$this->getForm();
  	}

  	public function update() {
		$this->load->language('system/childbirth_hospital');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/childbirth_hospital');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
	  		$this->model_system_childbirth_hospital->editChildbirthHospital($this->request->get['childbirth_hospital_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getForm();
  	}
	
  	public function edit_list() {
		$this->load->language('system/childbirth_hospital');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/childbirth_hospital');
		
		if (isset($this->request->post['selected']) && $this->validateEditList()) {
			foreach ($this->request->post['selected'] as $childbirth_hospital_id) {
					$sort_order_str = $childbirth_hospital_id.'_sort_order';				
					$sort_order = $this->request->post[$sort_order_str]; 
					$name_str = $childbirth_hospital_id.'_name';				
					$name = $this->request->post[$name_str]; 
					$code_str = $childbirth_hospital_id.'_code';				
					$code = $this->request->post[$code_str]; 

					$el_data = array(
						'sort_order' => $sort_order,
						'name'	=> $name,
						//'code'	=> $code
					);
					
					$this->model_system_childbirth_hospital->editChildbirthHospitalList($childbirth_hospital_id, $el_data);
			}	
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getForm();
  	}

  	public function delete() {
		$this->load->language('system/childbirth_hospital');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/childbirth_hospital');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $childbirth_hospital_id) {
				$this->model_system_childbirth_hospital->deleteChildbirthHospital($childbirth_hospital_id);
			}
			      		
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'));
   		}
	
    	$this->getList();
  	}
    
  	private function getList() {
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
			'href'      => $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
							
		$this->data['insert'] = $this->url->link('system/childbirth_hospital/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['edit_list'] = $this->url->link('system/childbirth_hospital/edit_list', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('system/childbirth_hospital/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['childbirth_hospitals'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$contract_code_total = $this->model_system_childbirth_hospital->getTotalChildbirthHospitals();
	
		$results = $this->model_system_childbirth_hospital->getChildbirthHospitals($data);
 
    	foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('system/childbirth_hospital/update', 'token=' . $this->session->data['token'] . '&childbirth_hospital_id=' . $result['childbirth_hospital_id'] . $url, 'SSL')
			);
						
			$this->data['childbirth_hospitals'][] = array(
				'childbirth_hospital_id' => $result['childbirth_hospital_id'],
				'name'	=> $result['name'],
				'sort_order'	=> $result['sort_order'],
				'selected'      => isset($this->request->post['selected']) && in_array($result['childbirth_hospital_id'], $this->request->post['selected']),
				'action'        => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_drag'] = $this->language->get('text_drag');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_edit_list'] = $this->language->get('button_edit_list');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
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

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $contract_code_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'system/childbirth_hospital_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	private function getForm() {
     	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_code'] = $this->language->get('entry_code');
		
    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
    
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}	

 		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
		}
		
		$url = '';
			
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
			'href'      => $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$contract_code_info = array();
		
		if (!isset($this->request->get['childbirth_hospital_id'])) {
			$this->data['action'] = $this->url->link('system/childbirth_hospital/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('system/childbirth_hospital/update', 'token=' . $this->session->data['token'] . '&childbirth_hospital_id=' . $this->request->get['childbirth_hospital_id'] . $url, 'SSL');
			$contract_code_info = $this->model_system_childbirth_hospital->getChildbirthHospital($this->request->get['childbirth_hospital_id']);
		}
			
		$this->data['cancel'] = $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($contract_code_info)) {
			$this->data['name'] = $contract_code_info['name'];
		} else {
			$this->data['name'] = '';
		}
		
		$this->template = 'system/childbirth_hospital_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());	
  	}
  	
	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'system/childbirth_hospital')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
    	}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}

    private function validateEditList() {
		if (!$this->user->hasPermission('modify', 'system/childbirth_hospital')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
	  	return TRUE;
		} else {
	  	return FALSE;
		}
  	}
	
  	private function validateDelete() {
		if (!$this->user->hasPermission('delete', 'system/childbirth_hospital')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		$this->load->model('service/customer');
		
		foreach ($this->request->post['selected'] as $childbirth_hospital_id) {
    		if ($this->config->get('config_childbirth_hospital_id') == $childbirth_hospital_id) {
	  			$this->error['warning'] = $this->language->get('error_default');	
			}  
			
			$childbirth_hospital = $this->model_system_childbirth_hospital->getChildbirthHospitalDescriptions($childbirth_hospital_id);
			$return_total = $this->model_service_customer->getTotalCustomersByChildbirthHospital($childbirth_hospital);
		
			if ($return_total) {
	  			$this->error['warning'] = sprintf($this->language->get('error_customer_hospital'), $return_total);	
			}  
	  	}
		
		if (!$this->error) { 
	  		return true;
		} else {
	  		return false;
		}
  	}	  
}
?>