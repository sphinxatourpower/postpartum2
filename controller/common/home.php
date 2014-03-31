<?php   
class ControllerCommonHome extends Controller {   
	public function index() {
    	$this->load->language('common/home');
	 	$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.css');
		$this->document->addStyle('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.print.css','','print');
		$this->document->addScript('view/javascript/jquery/fullcalendar/fullcalendar/fullcalendar.min.js');
	 
		$this->document->setTitle($this->language->get('heading_title'));
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_overview'] = $this->language->get('text_overview');
		$this->data['text_signwork'] = $this->language->get('text_signwork');
		$this->data['text_personal_temperature'] = $this->language->get('text_personal_temperature');
		$this->data['text_babyroom_info'] = $this->language->get('text_babyroom_info');
		$this->data['text_refrigerator_info'] = $this->language->get('text_refrigerator_info');

		//$this->data['text_statistics'] = $this->language->get('text_statistics');
		//$this->data['text_latest_10_orders'] = $this->language->get('text_latest_10_orders');
		//$this->data['text_total_sale'] = $this->language->get('text_total_sale');
		//$this->data['text_total_sale_year'] = $this->language->get('text_total_sale_year');
		//$this->data['text_total_order'] = $this->language->get('text_total_order');
		//$this->data['text_total_customer'] = $this->language->get('text_total_customer');
		//$this->data['text_total_customer_approval'] = $this->language->get('text_total_customer_approval');
		//$this->data['text_total_review_approval'] = $this->language->get('text_total_review_approval');
		//$this->data['text_total_affiliate'] = $this->language->get('text_total_affiliate');
		//$this->data['text_total_affiliate_approval'] = $this->language->get('text_total_affiliate_approval');
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
		
		// Check install directory exists
		if (ini_get('open_basedir')<>'') {
			if (is_dir(DIR_APPLICATION . PHP_EOL . 'install' . PHP_EOL)) {
				$this->data['error_install'] = $this->language->get('error_install');
			} else {
				$this->data['error_install'] = '';
			}
		} else {
			if (is_dir(dirname(DIR_APPLICATION) . '/install')) {
				$this->data['error_install'] = $this->language->get('error_install');
			} else {
				$this->data['error_install'] = '';
			}
		}

		// Check image directory is writable
		$file = DIR_IMAGE . 'test';
		
		$handle = fopen($file, 'a+'); 
		
		fwrite($handle, '');
			
		fclose($handle); 		
		
		if (!file_exists($file)) {
			$this->data['error_image'] = sprintf($this->language->get('error_image'). DIR_IMAGE);
		} else {
			$this->data['error_image'] = '';
			
			unlink($file);
		}
		
		// Check image cache directory is writable
		$file = DIR_IMAGE . 'cache/test';
		
		$handle = fopen($file, 'a+'); 
		
		fwrite($handle, '');
			
		fclose($handle); 		
		
		if (!file_exists($file)) {
			$this->data['error_image_cache'] = sprintf($this->language->get('error_image_cache'). DIR_IMAGE . 'cache/');
		} else {
			$this->data['error_image_cache'] = '';
			
			unlink($file);
		}
		
		// Check cache directory is writable
		$file = DIR_CACHE . 'test';
		
		$handle = fopen($file, 'a+'); 
		
		fwrite($handle, '');
			
		fclose($handle); 		
		
		if (!file_exists($file)) {
			$this->data['error_cache'] = sprintf($this->language->get('error_image_cache'). DIR_CACHE);
		} else {
			$this->data['error_cache'] = '';
			
			unlink($file);
		}
		
		// Check download directory is writable
		$file = DIR_DOWNLOAD . 'test';
		
		$handle = fopen($file, 'a+'); 
		
		fwrite($handle, '');
			
		fclose($handle); 		
		
		if (!file_exists($file)) {
			$this->data['error_download'] = sprintf($this->language->get('error_download'). DIR_DOWNLOAD);
		} else {
			$this->data['error_download'] = '';
			
			unlink($file);
		}
		
		// Check logs directory is writable
		$file = DIR_LOGS . 'test';
		
		$handle = fopen($file, 'a+'); 
		
		fwrite($handle, '');
			
		fclose($handle); 		
		
		if (!file_exists($file)) {
			$this->data['errorlogs'] = sprintf($this->language->get('error_logs'). DIR_LOGS);
		} else {
			$this->data['error_logs'] = '';
			
			unlink($file);
		}
										
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('service/customer');
		$this->load->model('service/customer_room');
		$this->load->model('system/customer_room');
		
		// getRooms
		$rooms_results = $this->model_system_customer_room->getCustomerRooms();
		
		//print_r($rooms_results); exit;
		
		$this->data['rooms'] = array();
		
		foreach ($rooms_results as $room) { 
		
			$customer_id = $this->model_system_customer_room->getRoomStatus($room['customer_room_id']);
			
			if ($customer_id) {
				$customer_name = $this->model_service_customer->getCustomerName($customer_id);
				$childsa = $this->model_service_customer->getChilds($customer_id);
				$childs = array();
				foreach ($childsa as $c) {
					$childs[] = array(
						'name'	=> $c['name'],
						'babydashboard'	=> $this->url->link('common/dashboard_baby', 'token=' . $this->session->data['token'] . '&customer_child_id=' . $c['child_id'], 'SSL')
					);
				}
				$status_val = 1;
				$color = 'greylabel';
			} else {
				$customer_name = '';
				$childs = array();
				$status_val = 0;
				$color = 'greenlabel';
			}
		
			$key = $room['floor'];
			if (!isset($this->data['rooms'][$key])) {
				$this->data['rooms'][$key] = array(
					'floor'	=> $room['floor']					
				);
				$this->data['rooms'][$key]['items'][] = array(
					'customer_room_id'	=> $room['customer_room_id'],
					'name'	=> $room['name'],
					'customer_name' => $customer_name,
					'momdashboard' => ($customer_id) ? $this->url->link('common/dashboard_mom', 'token=' . $this->session->data['token'] . '&customer_id=' . $customer_id, 'SSL') : false,
					'childs' => $childs,
					'status_val'	=> $status_val,
					'status'	=> ($status_val) ? '已佔床' : '空床',
					'booking'	=> $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . '&customer_room_id=' . $room['customer_room_id'], 'SSL'),
					'status_class'	=> $color
				);
			} else {
				$this->data['rooms'][$key]['items'][] = array(
					'customer_room_id'	=> $room['customer_room_id'],
					'name'	=> $room['name'],
					'customer_name' => $customer_name,
					'momdashboard' => ($customer_id) ? $this->url->link('common/dashboard_mom', 'token=' . $this->session->data['token'] . '&customer_id=' . $customer_id, 'SSL') : false,
					'childs' => $childs,
					'status_val'	=> $status_val,
					'status'	=> ($status_val) ? '已佔床' : '空床',
					'booking'	=> $this->url->link('service/customer/insert', 'token=' . $this->session->data['token'] . '&customer_room_id=' . $room['customer_room_id'], 'SSL'),
					'status_class'	=> $color
				);
			}
		}
		
		
		
		
		$data = array(
			'filter_showathome'            => '1'
		);
		
		$this->data['customers'] = $this->model_service_customer->getCustomers($data);
		
		foreach ($this->data['customers'] as $k => $v) {
			$this->data['customers'][$k]['url'] = $this->url->link('service/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $v['customer_id'], 'SSL');
			$this->data['customers'][$k]['room'] = ($v['customer_room_id']) ? " [". $this->model_service_customer_room->getCustomerRoomName($v['customer_room_id']). "]" : "";
		}
		
		// duty and finishwork
		$this->load->model('user/user');
		$this->data['ondutytime'] = ($this->model_user_user->getUserOndutyTime($this->user->getId())) ? date($this->language->get('time_format_shortest'), strtotime($this->model_user_user->getUserOndutyTime($this->user->getId()))) : '';
		
/*		
		$this->load->model('sale/order');

		$this->data['total_sale'] = $this->currency->format($this->model_sale_order->getTotalSales(), $this->config->get('config_currency'));
		$this->data['total_sale_year'] = $this->currency->format($this->model_sale_order->getTotalSalesByYear(date('Y')), $this->config->get('config_currency'));
		$this->data['total_order'] = $this->model_sale_order->getTotalOrders();
		
		$this->load->model('service/customer');
		
		$this->data['total_customer'] = $this->model_sale_customer->getTotalCustomers();
		$this->data['total_customer_approval'] = $this->model_sale_customer->getTotalCustomersAwaitingApproval();
		
		$this->load->model('catalog/review');
		
		$this->data['total_review'] = $this->model_catalog_review->getTotalReviews();
		$this->data['total_review_approval'] = $this->model_catalog_review->getTotalReviewsAwaitingApproval();
		
		$this->load->model('sale/affiliate');
		
		$this->data['total_affiliate'] = $this->model_sale_affiliate->getTotalAffiliates();
		$this->data['total_affiliate_approval'] = $this->model_sale_affiliate->getTotalAffiliatesAwaitingApproval();
				
		$this->data['orders'] = array(); 
		
		$data = array(
			'sort'  => 'o.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => 10
		);
		
		$results = $this->model_sale_order->getOrders($data);
    	
    	foreach ($results as $result) {
			$action = array();
			 
			$action[] = array(
				'text' => $this->language->get('text_view'),
				'href' => $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $result['order_id'], 'SSL')
			);
					
			$this->data['orders'][] = array(
				'order_id'   => $result['order_id'],
				'customer'   => $result['customer'],
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'action'     => $action
			);
		}

		if ($this->config->get('config_currency_auto')) {
			$this->load->model('localisation/currency');
		
			$this->model_localisation_currency->updateCurrencies();
		}
	*/
	
		$this->template = 'common/home.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
	
	public function chart() {
		$this->load->language('common/home');
		
		$data = array();
		
		$data['order'] = array();
		$data['customer'] = array();
		$data['xaxis'] = array();
		
		$data['order']['label'] = $this->language->get('text_order');
		$data['customer']['label'] = $this->language->get('text_customer');
		
		if (isset($this->request->get['range'])) {
			$range = $this->request->get['range'];
		} else {
			$range = 'month';
		}
		
		switch ($range) {
			case 'day':
				for ($i = 0; $i < 24; $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND (DATE(date_added) = DATE(NOW()) AND HOUR(date_added) = '" . (int)$i . "') GROUP BY HOUR(date_added) ORDER BY date_added ASC");
					
					if ($query->num_rows) {
						$data['order']['data'][]  = array($i, (int)$query->row['total']);
					} else {
						$data['order']['data'][]  = array($i, 0);
					}
					
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE DATE(date_added) = DATE(NOW()) AND HOUR(date_added) = '" . (int)$i . "' GROUP BY HOUR(date_added) ORDER BY date_added ASC");
					
					if ($query->num_rows) {
						$data['customer']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array($i, 0);
					}
			
					$data['xaxis'][] = array($i, date('H', mktime($i, 0, 0, date('n'), date('j'), date('Y'))));
				}					
				break;
			case 'week':
				$date_start = strtotime('-' . date('w') . ' days'); 
				
				for ($i = 0; $i < 7; $i++) {
					$date = date('Y-m-d', $date_start + ($i * 86400));

					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND DATE(date_added) = '" . $this->db->escape($date) . "' GROUP BY DATE(date_added)");
			
					if ($query->num_rows) {
						$data['order']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array($i, 0);
					}
				
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "customer` WHERE DATE(date_added) = '" . $this->db->escape($date) . "' GROUP BY DATE(date_added)");
			
					if ($query->num_rows) {
						$data['customer']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array($i, 0);
					}
		
					$data['xaxis'][] = array($i, date('D', strtotime($date)));
				}
				
				break;
			default:
			case 'month':
				for ($i = 1; $i <= date('t'); $i++) {
					$date = date('Y') . '-' . date('m') . '-' . $i;
					
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND (DATE(date_added) = '" . $this->db->escape($date) . "') GROUP BY DAY(date_added)");
					
					if ($query->num_rows) {
						$data['order']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array($i, 0);
					}	
				
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE DATE(date_added) = '" . $this->db->escape($date) . "' GROUP BY DAY(date_added)");
			
					if ($query->num_rows) {
						$data['customer']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array($i, 0);
					}	
					
					$data['xaxis'][] = array($i, date('j', strtotime($date)));
				}
				break;
			case 'year':
				for ($i = 1; $i <= 12; $i++) {
					$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id > '0' AND YEAR(date_added) = '" . date('Y') . "' AND MONTH(date_added) = '" . $i . "' GROUP BY MONTH(date_added)");
					
					if ($query->num_rows) {
						$data['order']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['order']['data'][] = array($i, 0);
					}
					
					$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE YEAR(date_added) = '" . date('Y') . "' AND MONTH(date_added) = '" . $i . "' GROUP BY MONTH(date_added)");
					
					if ($query->num_rows) { 
						$data['customer']['data'][] = array($i, (int)$query->row['total']);
					} else {
						$data['customer']['data'][] = array($i, 0);
					}
					
					$data['xaxis'][] = array($i, date('M', mktime(0, 0, 0, $i, 1, date('Y'))));
				}			
				break;	
		} 
		
		$this->response->setOutput(json_encode($data));
	}
	
	public function login() {
		$route = '';
		
		if (isset($this->request->get['route'])) {
			$part = explode('/', $this->request->get['route']);
			
			if (isset($part[0])) {
				$route .= $part[0];
			}
			
			if (isset($part[1])) {
				$route .= '/' . $part[1];
			}
		}
		
		$ignore = array(
			'common/login',
			'common/forgotten',
			'common/reset'
		);	
					
		if (!$this->user->isLogged() && !in_array($route, $ignore)) {
			return $this->forward('common/login');
		}
		
		if (isset($this->request->get['route'])) {
			$ignore = array(
				'common/login',
				'common/logout',
				'common/forgotten',
				'common/reset',
				'error/not_found',
				'error/permission'
			);
						
			$config_ignore = array();
			
			if ($this->config->get('config_token_ignore')) {
				$config_ignore = unserialize($this->config->get('config_token_ignore'));
			}
				
			$ignore = array_merge($ignore, $config_ignore);
						
			if (!in_array($route, $ignore) && (!isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token']))) {
				return $this->forward('common/login');
			}
		} else {
			if (!isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
				return $this->forward('common/login');
			}
		}
	}
	
	public function permission() {
		if (isset($this->request->get['route'])) {
			$route = '';
			
			$part = explode('/', $this->request->get['route']);
			
			if (isset($part[0])) {
				$route .= $part[0];
			}
			
			if (isset($part[1])) {
				$route .= '/' . $part[1];
			}
			
			$ignore = array(
				'common/home',
				'common/dashboard_mom',
				'common/dashboard_baby',
				'common/login',
				'common/logout',
				'common/forgotten',
				'common/reset',
				'error/not_found',
				'error/permission'		
			);			
						
			if (!in_array($route, $ignore) && !$this->user->hasPermission('access', $route)) {
				return $this->forward('error/permission');
			}
		}
	}	
}
?>