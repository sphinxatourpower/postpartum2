<?php
class ControllerReportChart1 extends Controller { 
	public function index() {  
		$this->load->language('report/chart1');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle("view/stylesheet/stylesheet_print.css","stylesheet","print");

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
		
		/*
		if (isset($this->request->get['filter_order_status_id'])) {
			$filter_order_status_id = $this->request->get['filter_order_status_id'];
		} else {
			$filter_order_status_id = 0;
		}	
		*/
		
		/*
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		*/
		
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
		if (isset($this->request->get['filter_order_status_id'])) {
			$url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
		}
		*/
						
		/*
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		*/

   		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),       		
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('report/chart1', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->load->model('report/chart1');
		
		$this->data['orders'] = array();
		
		$data = array(
			'filter_date_start'	     => $filter_date_start, 
			'filter_date_end'	     => $filter_date_end, 
			'filter_customer_id' => $filter_customer_id,
			//'filter_group'           => $filter_group,
			//'filter_order_status_id' => $filter_order_status_id,
			//'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
			//'limit'                  => $this->config->get('config_admin_limit')
		);
		
		if (isset($this->request->get['filter_customer_id'])) {
			$this->load->model('service/customer');
			$this->data['customer_name'] = $this->model_service_customer->getCustomerName($this->request->get['filter_customer_id']);
		}
		
		$order_total = $this->model_report_chart1->getTotalNurse2cs($data);
		
		$results = $this->model_report_chart1->getNurse2cs($data);
		
		//$roo = array("右側乳頭外觀為","左側乳頭外觀為", "右側乳暈外觀為","左側乳暈外觀為","右側乳房外觀為","左側乳房外觀為","單次雙側奶量為每四小時","宮底位置為","惡露量為","惡露顏色為","惡露性質為","該產婦 NSD 傷口為","該產婦 C/S 傷口為","痔瘡","產婦情緒為","產婦本日食慾","活動精神狀況","乳汁排洩情況","乳房狀況","產婦按摩乳房狀況為","學習餵奶打嗝技巧","排尿情形","排便狀況","體溫 ℃","脈搏 次/每分鐘","呼吸 次/每分鐘","血壓 mmHg");
		
		if (!empty($results)) {
			foreach ($results as $rk => $result) {		
				//$this->data['roo'] = $roo;
				$this->data['nurse2cs'][] = array(
					'date_added'   => (int)strtotime($result['date_added']." 08:00:00"),
					'24'   => ($result['chk24']==NULL) ? 0 : $result['chk24'],
					'25'   => ($result['chk25']==NULL) ? 0 : $result['chk24'],
					'26'   => ($result['chk26']==NULL) ? 0 : $result['chk24'],
					'27a'   => ($result['chk27a']==NULL) ? 0 : $result['chk27a'],
					'27b'   => ($result['chk27b']==NULL) ? 0 : $result['chk27b']
					
	//				'date_start' => date($this->language->get('date_format_short'), strtotime($result['date_start'])),
	//				'date_end'   => date($this->language->get('date_format_short'), strtotime($result['date_end'])),
	//				'orders'     => $result['orders'],
	//				'products'   => $result['products'],
					//'tax'        => $this->currency->format($result['tax'], $this->config->get('config_currency')),
					//'total'      => $this->currency->format($result['total'], $this->config->get('config_currency'))
				);
			}
		}

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
		
		//$this->load->model('localisation/order_status');
		
		//$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
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

		/*
		$this->data['groups'] = array();

		$this->data['groups'][] = array(
			'text'  => $this->language->get('text_year'),
			'value' => 'year',
		);

		$this->data['groups'][] = array(
			'text'  => $this->language->get('text_month'),
			'value' => 'month',
		);

		$this->data['groups'][] = array(
			'text'  => $this->language->get('text_week'),
			'value' => 'week',
		);

		$this->data['groups'][] = array(
			'text'  => $this->language->get('text_day'),
			'value' => 'day',
		);
		*/

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

		$this->data['viewstat'] = $this->url->link('report/stat1', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		/*
		if (isset($this->request->get['filter_order_status_id'])) {
			$url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
		}
		*/
				
		/*
		$pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		//$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('report/chart1', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();		
		*/

		$this->data['filter_date_start'] = $filter_date_start;
		$this->data['filter_date_end'] = $filter_date_end;		
		$this->data['filter_customer_id'] = $filter_customer_id;
//		$this->data['filter_group'] = $filter_group;
//		$this->data['filter_order_status_id'] = $filter_order_status_id;
		
				 
		$this->template = 'report/chart1.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
}
?>
