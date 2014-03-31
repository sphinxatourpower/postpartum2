<?php 
class ControllerCommonDashboardBaby extends Controller {   
	public function index() {
    	$this->load->language('common/dashboard_baby');
	 
		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['text_overview'] = $this->language->get('text_overview');
		$this->data['text_signwork'] = $this->language->get('text_signwork');
		$this->data['text_personal_temperature'] = $this->language->get('text_personal_temperature');
		$this->data['text_babyroom_info'] = $this->language->get('text_babyroom_info');
		$this->data['text_refrigerator_info'] = $this->language->get('text_refrigerator_info');

		$this->data['text_day'] = $this->language->get('text_day');
		$this->data['text_week'] = $this->language->get('text_week');
		$this->data['text_month'] = $this->language->get('text_month');
		$this->data['text_year'] = $this->language->get('text_year');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_wait'] = $this->language->get('text_wait');

		$this->data['column_order'] = $this->language->get('column_order');
		$this->data['column_customer'] = $this->language->get('column_customer');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_total'] = $this->language->get('column_total');
		$this->data['column_name'] = $this->language->get('column_name');
		//$this->data['column_firstname'] = $this->language->get('column_firstname');
		//$this->data['column_lastname'] = $this->language->get('column_lastname');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['entry_range'] = $this->language->get('entry_range');
										
		$url = '';
		
		if (isset($this->request->get['customer_child_id'])) {
			$url .= '&customer_child_id=' . $this->request->get['customer_child_id'];
			
			$this->load->model('service/child');
			
			$child_info = $this->model_service_child->getChild($this->request->get['customer_child_id']);
			$datatable_info = $this->model_service_child->getChildDataTable($this->request->get['customer_child_id']);
		}

				$this->data['breadcrumbs'] = array();

				$this->data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => false
				);
				
		if (!empty($child_info)) {
				$this->document->setTitle($this->language->get('heading_title') . '－' .  $child_info['name'] . '(' . $datatable_info['customer_name'] . ')');
				$this->data['heading_title'] = $this->language->get('heading_title') . '－' .  $child_info['name'] . '(' . $datatable_info['customer_name'] . ')';
		
				$this->data['breadcrumbs'][] = array(
					'text'      => $this->language->get('heading_title') . '－' .  $child_info['name'] . '(' . $datatable_info['customer_name'] . ')',
					'href'      => $this->url->link('common/dashboard_baby', 'token=' . $this->session->data['token'] . $url, 'SSL'),
					'separator' => $this->language->get('text_separator')
				);
				
				$this->data['icons'] = array();
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('service/child/update', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] , 'SSL'),
					'title' => '嬰兒圖檔維護',
					'image' => 'view/image/ico_picture.png'
				);
				
				$this->load->model('nurse/nurse1b');
				$nurse1b = $this->model_nurse_nurse1b->getNurse1b($this->request->get['customer_child_id']);
				if (empty($nurse1b)) {
					$act = 'insert'; 
					$child_nurse1b_id = 0;
				} else {
					$act = 'update';
					$child_nurse1b_id = $nurse1b['child_nurse1b_id'];
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse1b/' . $act, 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] . '&child_nurse1b_id=' . $child_nurse1b_id , 'SSL'),
					'title' => '嬰兒入住身體評估單',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse3b/insert', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'], 'SSL'),
					'title' => '嬰兒三班護理紀錄單',
					'image' => 'view/image/ico_record.png'
				);
				
				
				$this->load->model('doctor/childdoctor1');
				$childdoctor1 = $this->model_doctor_childdoctor1->getChildDoctor($this->request->get['customer_child_id']);
				if (empty($childdoctor1)) {
					$act = 'insert'; 
					$customer_child_doctor_id = 0;
				} else {
					$act = 'update';
					$customer_child_doctor_id = $childdoctor1['customer_child_doctor_id'];
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('doctor/childdoctor1/' . $act, 'token=' . $this->session->data['token'] . '&customer_child_id=' . $this->request->get['customer_child_id'] . '&customer_child_doctor_id=' . $customer_child_doctor_id, 'SSL'),
					'title' => '嬰兒入住醫師評估',
					'image' => 'view/image/ico_record.png'
				);

				$this->data['icons'][] = array(
					'href' => $this->url->link('doctor/childdoctor2/insert', 'token=' . $this->session->data['token'], 'SSL'),
					'title' => '新增小兒科醫師巡診單',
					'image' => 'view/image/ico_record.png'
				);

				$this->data['token'] = $this->session->data['token'];

				$this->load->model('nurse/nurse3b');
				
				$this->data['temperature'] = $this->model_nurse_nurse3b->getLastTemperature($this->request->get['customer_child_id']);
				$this->data['temperature_color'] = ($this->data['temperature'] < 36 || $this->data['temperature'] > 38) ? '#ff0000' : '';
				
				$this->data['weight'] = $this->model_nurse_nurse3b->getLastWeight($this->request->get['customer_child_id']);
				$this->data['weight_color'] = '';
				
				$this->data['jaundice'] = $this->model_nurse_nurse3b->getLastJaundice($this->request->get['customer_child_id']);
				$this->data['jaundice_color'] = ($this->data['jaundice'] > 15) ? '#ff0000' : '';
				
				$this->data['piss'] = $this->model_nurse_nurse3b->getLastPiss($this->request->get['customer_child_id']);
				$this->data['piss_color'] = ($this->data['piss'] < 3) ? '#ff0000' : '';
				
				$this->template = 'common/dashboard_baby.tpl';
				$this->children = array(
					'common/header',
					'common/footer'
				);
						
				$this->response->setOutput($this->render());
		} else {
			$url = '';
			
			if (isset($this->request->get['customer_child_id'])) {
				$url .= '&customer_child_id=' . $this->request->get['customer_child_id'];
			}			
				
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('common/dashboard_baby', $url),
        		'separator' => $this->language->get('text_separator')
      		);			
		
      		$this->document->setTitle($this->language->get('text_error'));

      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');
			$this->data['text_not_found'] = $this->language->get('text_not_found');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			$this->template = 'error/not_found.tpl';
			
			$this->children = array(
				'common/footer',
				'common/header'
			);
						
			$this->response->setOutput($this->render());
    	}
		
		
		
		
  	}
	

}
?>