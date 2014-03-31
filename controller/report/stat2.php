<?php
class ControllerReportStat2 extends Controller { 
	public function index() {  
		$this->load->language('report/stat2');

		$this->document->setTitle($this->language->get('heading_title'));

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
		
		if (isset($this->request->get['filter_child_id'])) {
			$filter_child_id = $this->request->get['filter_child_id'];
		} else {
			$filter_child_id = '';
		}
		
		/*
		if (isset($this->request->get['filter_order_status_id'])) {
			$filter_order_status_id = $this->request->get['filter_order_status_id'];
		} else {
			$filter_order_status_id = 0;
		}	
		*/
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$url = '';
						
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}
		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		
		if (isset($this->request->get['filter_child_id'])) {
			$url .= '&filter_child_id=' . $this->request->get['filter_child_id'];
		}		

		/*
		if (isset($this->request->get['filter_order_status_id'])) {
			$url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
		}
		*/
								
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
			'href'      => $this->url->link('report/stat2', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => $this->language->get('text_separator')
   		);
		
		$this->load->model('report/stat2');
		
		$this->data['orders'] = array();
		
		$data = array(
			'filter_date_start'	     => $filter_date_start, 
			'filter_date_end'	     => $filter_date_end, 
			'filter_child_id' => $filter_child_id,
			//'filter_group'           => $filter_group,
			//'filter_order_status_id' => $filter_order_status_id,
			'start'                  => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                  => $this->config->get('config_admin_limit')
		);
		
		if (isset($this->request->get['filter_child_id'])) {
			$this->load->model('service/child');
			$this->data['child_name'] = $this->model_service_child->getChildName($this->request->get['filter_child_id']);
		}
		
		$order_total = $this->model_report_stat2->getTotalNurse3bs($data);
		
		$results = $this->model_report_stat2->getNurse3bs($data);
		//$minmax = $this->model_report_stat2->getNurse3bsminmax($data);
		
		$roo = array("1.T 體溫 /℃","2.P 脈搏/每分鐘", "3.R 呼吸/每分鐘","4.親餵時間：分鐘","5.瓶餵食量：CC","6.瓶餵配方奶量：CC","7.瓶餵母奶量：CC","8.母奶點班庫存量","9.母奶交班庫存量","10.體重：公克","11.小便次數","12.大便次數","13.黃疸值：mg/dL","14.母嬰同室時間：分鐘");
		
		if (!empty($results)) {
			foreach ($results as $rk => $result) {		
				$this->data['roo'] = $roo;
				$this->data['nurse3bs'][] = array(
					//'date_min' => date($this->language->get('date_format_short'), strtotime($minmax['date_min'])),
					//'date_max' => date($this->language->get('date_format_short'), strtotime($minmax['date_max'])),
					'date_added'   => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'arrangement'   => $result['arrangement'],
					'1'  => $result['chk1'],
					'2'   => $result['chk2'],
					'3'   => $result['chk3'],
					'4'   => $result['chk4'],
					'5'   => $result['chk5'],
					'6'   => $result['chk6'],
					'7'   => $result['chk7'],
					'8'   => $result['chk8'],
					'9'   => $result['chk9'],
					'10'   => $result['chk10'],
					'11'   => $result['chk11'],
					'12'   => $result['chk12'],
					'13'   => $result['chk13'],
					'14'   => $result['chk14']
					
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
		$this->load->model('service/child');
		$childresult = $this->model_service_child->getChilds();
		
		$this->data['childs'] = array();
		
		foreach ($childresult as $child) {
			$childname = ($child['name']=='')? $child['customer_name']."的寶寶" : $child['name']; 
			$status = (date($this->language->get('date_format_short'), strtotime($child['date_leave'])) >= date($this->language->get('date_format_short'))) ? $this->language->get('text_livein') : $this->language->get('text_leave');
			$this->data['childs'][] = array(
				'text'	=> $childname." [". $status ."]",
				'value'	=> $child['customer_child_id'],
				'status' => (date($this->language->get('date_format_short'), strtotime($child['date_leave'])) >= date($this->language->get('date_format_short')))? 1 : 0,
				'name' => $childname,
				'leave' => $child['date_leave']
			);
		}
		
		foreach ($this->data['childs'] as $key => $row) {
			$stas[$key]  = $row['status'];
			$nam[$key] = $row['name'];
		}
		
		array_multisort($stas, SORT_DESC, $nam, SORT_ASC, $this->data['childs']);		

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
		
		if (isset($this->request->get['filter_child_id'])) {
			$url .= '&filter_child_id=' . $this->request->get['filter_child_id'];
		}		

		/*
		if (isset($this->request->get['filter_order_status_id'])) {
			$url .= '&filter_order_status_id=' . $this->request->get['filter_order_status_id'];
		}
		*/
				
		$pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('report/stat2', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['viewchart'] = $this->url->link('report/chart2', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$this->data['pagination'] = $pagination->render();		

		$this->data['filter_date_start'] = $filter_date_start;
		$this->data['filter_date_end'] = $filter_date_end;		
		$this->data['filter_child_id'] = $filter_child_id;
//		$this->data['filter_group'] = $filter_group;
//		$this->data['filter_order_status_id'] = $filter_order_status_id;
		
				 
		$this->template = 'report/stat2.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
}
?>