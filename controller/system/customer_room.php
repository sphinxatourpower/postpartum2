<?php
class ControllerSystemCustomerRoom extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->language('system/customer_room');
 
		$this->document->setTitle($this->language->get('heading_title'));
 		
		$this->load->model('system/customer_room');
		
		$this->getList();
	}

	public function insert() {
		$this->load->language('system/customer_room');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/customer_room');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_system_customer_room->addCustomerRoom($this->request->post);
			
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
			
			$this->redirect($this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('system/customer_room');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/customer_room');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_system_customer_room->editCustomerRoom($this->request->get['customer_room_id'], $this->request->post);
			
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
			
			$this->redirect($this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() { 
		$this->load->language('system/customer_room');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('system/customer_room');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
      		foreach ($this->request->post['selected'] as $customer_room_id) {
				$this->model_system_customer_room->deleteCustomerRoom($customer_room_id);	
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
			
			$this->redirect($this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	private function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'cg.sort_order cg.name';
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
			'href'      => $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
							
		$this->data['insert'] = $this->url->link('system/customer_room/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('system/customer_room/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
	
		$this->data['customer_rooms'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$tenant_group_total = $this->model_system_customer_room->getTotalCustomerRooms();
		
		$results = $this->model_system_customer_room->getCustomerRooms($data);

		foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('system/customer_room/update', 'token=' . $this->session->data['token'] . '&customer_room_id=' . $result['customer_room_id'] . $url, 'SSL')
			);		
		
			$this->data['customer_rooms'][] = array(
				'customer_room_id' => $result['customer_room_id'],
				'floor'	=> $result['floor'],
				'price'	=> $result['price'],
				'name'              => $result['name'] . (($result['customer_room_id'] == $this->config->get('config_customer_room_id')) ? $this->language->get('text_default') : null),
				'sort_order'        => $result['sort_order'],
				'selected'          => isset($this->request->post['selected']) && in_array($result['customer_room_id'], $this->request->post['selected']),
				'editgroup'	=> $this->url->link('system/customer_room/update', 'token=' . $this->session->data['token'] . '&customer_room_id=' . $result['customer_room_id'] . $url, 'SSL'),
				'action'            => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_floor'] = $this->language->get('column_floor');
		$this->data['column_price'] = $this->language->get('column_price');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_insert'] = $this->language->get('button_insert');
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

		$this->data['sort_name'] = $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . '&sort=cg.name' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . '&sort=cg.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
				
		$pagination = new Pagination();
		$pagination->total = $tenant_group_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();				

		$this->data['sort'] = $sort; 
		$this->data['order'] = $order;

		$this->template = 'system/customer_room_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
 	}

	private function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
				
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_floor'] = $this->language->get('entry_floor');
		$this->data['entry_price'] = $this->language->get('entry_price');
		//$this->data['entry_description'] = $this->language->get('entry_description');
		//$this->data['entry_approval'] = $this->language->get('entry_approval');
		//$this->data['entry_company_id_display'] = $this->language->get('entry_company_id_display');
		//$this->data['entry_company_id_required'] = $this->language->get('entry_company_id_required');
		//$this->data['entry_tax_id_display'] = $this->language->get('entry_tax_id_display');
		//$this->data['entry_tax_id_required'] = $this->language->get('entry_tax_id_required');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
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
			'href'      => $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
			
		if (!isset($this->request->get['customer_room_id'])) {
			$this->data['action'] = $this->url->link('system/customer_room/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('system/customer_room/update', 'token=' . $this->session->data['token'] . '&customer_room_id=' . $this->request->get['customer_room_id'] . $url, 'SSL');
		}
		  
    	$this->data['cancel'] = $this->url->link('system/customer_room', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['customer_room_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$customer_room_info = $this->model_system_customer_room->getCustomerRoom($this->request->get['customer_room_id']);
		}
		
		$this->data['floors'] = array('1F','2F','3F');
		
		//$this->load->model('localisation/language');
		
		//$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($customer_room_info)) {
			$this->data['name'] = $customer_room_info['name'];
		} else {
			$this->data['name'] = '';
		}	
		
		if (isset($this->request->post['floor'])) {
			$this->data['floor'] = $this->request->post['floor'];
		} elseif (!empty($customer_room_info)) {
			$this->data['floor'] = $customer_room_info['floor'];
		} else {
			$this->data['floor'] = '';
		}	
		
		if (isset($this->request->post['price'])) {
			$this->data['price'] = $this->request->post['price'];
		} elseif (!empty($customer_room_info)) {
			$this->data['price'] = $customer_room_info['price'];
		} else {
			$this->data['price'] = '';
		}	
		
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($customer_room_info)) {
			$this->data['sort_order'] = $customer_room_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}	
									
		$this->template = 'system/customer_room_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render()); 
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'system/customer_room')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		
		if ($this->request->post['floor']=='') {
			$this->error['floor'] = $this->language->get('error_floor');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'system/customer_room')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		//$this->load->model('setting/store');
		$this->load->model('service/customer');
      	
		foreach ($this->request->post['selected'] as $customer_room_id) {
    		if ($this->config->get('config_customer_room_id') == $customer_room_id) {
	  			$this->error['warning'] = $this->language->get('error_default');	
			}  
			
			$customer_total = $this->model_service_customer->getTotalCustomersByCustomerRoomId($customer_room_id);

			if ($customer_total) {
				$this->error['warning'] = sprintf($this->language->get('error_customer'), $customer_total);
			}
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	public function groupdata() {
		$json = array();
		
		if (isset($this->request->get['filter_group_id'])) {
			$this->load->model('system/customer_room');
		
			$json = $this->model_system_customer_room->getCustomerRoom($this->request->get['filter_group_id']);
		}

		$this->response->setOutput(json_encode($json));
	}		
}
?>