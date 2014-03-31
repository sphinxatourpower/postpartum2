<?php 
class ControllerCommonDashboardMom extends Controller {   
	public function index() {
    	$this->load->language('common/dashboard_mom');
	 
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
		
		if (isset($this->request->get['customer_id'])) {
			$url .= '&customer_id=' . $this->request->get['customer_id'];
			
			$this->load->model('service/customer');
			
			$customer_info = $this->model_service_customer->getCustomer($this->request->get['customer_id']);
		}

				$this->data['breadcrumbs'] = array();

				$this->data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => false
				);
				
		if (!empty($customer_info)) {
				$this->document->setTitle($this->language->get('heading_title') . '－' .  $customer_info['name']);
				$this->data['heading_title'] = $this->language->get('heading_title') . '－' .  $customer_info['name'];
		
				$this->data['breadcrumbs'][] = array(
					'text'      => $this->language->get('heading_title') . '－' .  $customer_info['name'],
					'href'      => $this->url->link('common/dashboard_mom', 'token=' . $this->session->data['token'] . $url, 'SSL'),
					'separator' => $this->language->get('text_separator')
				);
				
				$this->data['icons'] = array();
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('service/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'] , 'SSL'),
					'title' => '客戶資料維護',
					'image' => 'view/image/ico_member.png'
				);
				$this->data['icons'][] = array(
					'href' => $this->url->link('service/satisfaction/insert', 'token=' . $this->session->data['token'], 'SSL'),
					'title' => '新增客戶滿意度調查',
					'image' => 'view/image/ico_member.png'
				);
				
				$this->load->model('nurse/nurse1c');
				$nurse1c = $this->model_nurse_nurse1c->getNurse1c($this->request->get['customer_id']);
				if (empty($nurse1c)) {
					$act = 'insert'; 
				} else {
					$act = 'update';
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse1c/' . $act, 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '媽媽入住身體評估表',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse2c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '媽媽每日身體紀錄單',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->load->model('nurse/nurse4c');
				$nurse4c = $this->model_nurse_nurse4c->getNurse4c($this->request->get['customer_id']);
				if (empty($nurse4c)) {
					$act = 'insert'; 
				} else {
					$act = 'update';
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse4c/' . $act, 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '愛丁堡產後憂鬱量表',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->load->model('nurse/beck');
				$beck = $this->model_nurse_beck->getNurse4c($this->request->get['customer_id']);
				if (empty($beck)) {
					$act = 'insert'; 
				} else {
					$act = 'update';
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/beck/' . $act, 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '貝氏產後憂鬱評估表',
					'image' => 'view/image/ico_record.png'
				);
				
				
				$this->load->model('education/edu1c');
				$edu1c = $this->model_education_edu1c->getEdu1c($this->request->get['customer_id']);
				if (empty($edu1c)) {
					$act = 'insert'; 
				} else {
					$act = 'update';
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('education/edu1c/' . $act, 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '家庭功能評估表',
					'image' => 'view/image/ico_record.png'
				);
				
				
				$this->load->model('breast/breast2c');
				$breast2c = $this->model_breast_breast2c->getBreast2c($this->request->get['customer_id']);
				if (empty($breast2c)) {
					$act = 'insert'; 
				} else {
					$act = 'update';
				}
				$this->data['icons'][] = array(
					'href' => $this->url->link('breast/breast2c/' . $act, 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '一週內母乳哺育評估單',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('nurse/nurse5c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '哺餵母乳觀察表',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('breast/breast1c/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '母乳哺育護理指導紀錄表',
					'image' => 'view/image/ico_record.png'
				);
				
				$this->data['icons'][] = array(
					'href' => $this->url->link('doctor/childdoctor3/insert', 'token=' . $this->session->data['token'] . '&customer_id=' . $this->request->get['customer_id'], 'SSL'),
					'title' => '婦產科醫師巡診單',
					'image' => 'view/image/ico_record.png'
				);

				$this->data['token'] = $this->session->data['token'];

				$this->load->model('nurse/nurse2c');
				
				$this->data['temperature'] = $this->model_nurse_nurse2c->getYesterdayTemperature($this->request->get['customer_id']);
				$this->data['temperature_color'] = ($this->data['temperature'] < 36 || $this->data['temperature'] > 38) ? '#ff0000' : '';
				
				$this->template = 'common/dashboard_mom.tpl';
				$this->children = array(
					'common/header',
					'common/footer'
				);
						
				$this->response->setOutput($this->render());
		} else {
			$url = '';
			
			if (isset($this->request->get['customer_id'])) {
				$url .= '&customer_id=' . $this->request->get['customer_id'];
			}			
				
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('common/dashboard_mom', $url),
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