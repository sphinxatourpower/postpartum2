<?php 
class ControllerCommonHeader extends Controller {
	protected function index() {
		$this->data['title'] = $this->document->getTitle(); 
		$this->data['mobilebrowser'] = $this->document->mobile_device_detect();
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		
		$this->load->language('common/header');

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_attribute'] = $this->language->get('text_attribute');
		$this->data['text_attribute_group'] = $this->language->get('text_attribute_group');
		$this->data['text_backup'] = $this->language->get('text_backup');
		$this->data['text_showathome'] = $this->language->get('text_showathome');
		$this->data['text_banner'] = $this->language->get('text_banner');
		$this->data['text_catalog'] = $this->language->get('text_catalog');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_country'] = $this->language->get('text_country');
		$this->data['text_coupon'] = $this->language->get('text_coupon');
		$this->data['text_currency'] = $this->language->get('text_currency');			
		$this->data['text_service'] = $this->language->get('text_service');
		$this->data['text_customer'] = $this->language->get('text_customer');
		$this->data['text_child'] = $this->language->get('text_child');
		$this->data['text_doctor'] = $this->language->get('text_doctor');
		$this->data['text_childdoctor1'] = $this->language->get('text_childdoctor1');
		$this->data['text_childdoctor2'] = $this->language->get('text_childdoctor2');
		$this->data['text_childdoctor3'] = $this->language->get('text_childdoctor3');
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_customer_blacklist'] = $this->language->get('text_customer_blacklist');
		//$this->data['text_sale'] = $this->language->get('text_sale');
		$this->data['text_design'] = $this->language->get('text_design');
		$this->data['text_documentation'] = $this->language->get('text_documentation');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_error_log'] = $this->language->get('text_error_log');
		$this->data['text_extension'] = $this->language->get('text_extension');
		$this->data['text_feed'] = $this->language->get('text_feed');
		$this->data['text_front'] = $this->language->get('text_front');
		$this->data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$this->data['text_dashboard'] = $this->language->get('text_dashboard');
		$this->data['text_help'] = $this->language->get('text_help');
		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_language'] = $this->language->get('text_language');
		$this->data['text_layout'] = $this->language->get('text_layout');
		$this->data['text_localisation'] = $this->language->get('text_localisation');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_order_status'] = $this->language->get('text_order_status');
		$this->data['text_opencart'] = $this->language->get('text_opencart');
		$this->data['text_payment'] = $this->language->get('text_payment');
		$this->data['text_product'] = $this->language->get('text_product'); 
		$this->data['text_reports'] = $this->language->get('text_reports');
		$this->data['text_stat1'] = $this->language->get('text_stat1');
		$this->data['text_stat2'] = $this->language->get('text_stat2');
		$this->data['text_chart1'] = $this->language->get('text_chart1');
		$this->data['text_chart2'] = $this->language->get('text_chart2');
		$this->data['text_printall'] = $this->language->get('text_printall');
		/*
		$this->data['text_report_sale_order'] = $this->language->get('text_report_sale_order');
		$this->data['text_report_sale_tax'] = $this->language->get('text_report_sale_tax');
		$this->data['text_report_sale_shipping'] = $this->language->get('text_report_sale_shipping');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_sale_coupon'] = $this->language->get('text_report_sale_coupon');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_report_customer_reward'] = $this->language->get('text_report_customer_reward');
		$this->data['text_report_customer_credit'] = $this->language->get('text_report_customer_credit');
		$this->data['text_report_affiliate_commission'] = $this->language->get('text_report_affiliate_commission');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		*/
		$this->data['text_review'] = $this->language->get('text_review');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_return_action'] = $this->language->get('text_return_action');
		$this->data['text_return_reason'] = $this->language->get('text_return_reason');
		$this->data['text_return_status'] = $this->language->get('text_return_status');
		$this->data['text_support'] = $this->language->get('text_support'); 
		$this->data['text_shipping'] = $this->language->get('text_shipping');		
		$this->data['text_setting'] = $this->language->get('text_setting');
		$this->data['text_stock_status'] = $this->language->get('text_stock_status');
		$this->data['text_hr'] = $this->language->get('text_hr');
		$this->data['text_new_training'] = $this->language->get('text_new_training');
		$this->data['text_staff_appraisal'] = $this->language->get('text_staff_appraisal');
		$this->data['text_system'] = $this->language->get('text_system');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_tax_class'] = $this->language->get('text_tax_class');
		$this->data['text_tax_rate'] = $this->language->get('text_tax_rate');
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_user'] = $this->language->get('text_user');
		$this->data['text_user_group'] = $this->language->get('text_user_group');
		$this->data['text_users'] = $this->language->get('text_users');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_voucher_theme'] = $this->language->get('text_voucher_theme');
		$this->data['text_weight_class'] = $this->language->get('text_weight_class');
		$this->data['text_length_class'] = $this->language->get('text_length_class');
		$this->data['text_zone'] = $this->language->get('text_zone');
		
		$this->data['text_january'] = $this->language->get('text_january');
		$this->data['text_february'] = $this->language->get('text_february');
		$this->data['text_march'] = $this->language->get('text_march');
		$this->data['text_april'] = $this->language->get('text_april');
		$this->data['text_may'] = $this->language->get('text_may');
		$this->data['text_june'] = $this->language->get('text_june');
		$this->data['text_july'] = $this->language->get('text_july');
		$this->data['text_august'] = $this->language->get('text_august');
		$this->data['text_september'] = $this->language->get('text_september');
		$this->data['text_october'] = $this->language->get('text_october');
		$this->data['text_november'] = $this->language->get('text_november');
		$this->data['text_december'] = $this->language->get('text_december');
		$this->data['text_year'] = $this->language->get('text_year');
		$this->data['text_month'] = $this->language->get('text_month');
		$this->data['text_day'] = $this->language->get('text_day');
		
		$this->data['text_nurse_dep'] = $this->language->get('text_nurse_dep');
		$this->data['text_pi_dep'] = $this->language->get('text_pi_dep');
		$this->data['text_edu1c'] = $this->language->get('text_edu1c');
		$this->data['text_bf_dep'] = $this->language->get('text_bf_dep');
		$this->data['text_nurse5c'] = $this->language->get('text_nurse5c');
		$this->data['text_breast1c'] = $this->language->get('text_breast1c');
		$this->data['text_breast2c'] = $this->language->get('text_breast2c');
		//$this->data['text_nurse_customer'] = $this->language->get('text_nurse_customer');
		//$this->data['text_nurse_child'] = $this->language->get('text_nurse_child');
		$this->data['text_nurse1c'] = $this->language->get('text_nurse1c');
		$this->data['text_nurse2c'] = $this->language->get('text_nurse2c');
		$this->data['text_nurse3c'] = $this->language->get('text_nurse3c');
		$this->data['text_nurse4c'] = $this->language->get('text_nurse4c');
		$this->data['text_beck'] = $this->language->get('text_beck');
		$this->data['text_nurse1b'] = $this->language->get('text_nurse1b');
		$this->data['text_nurse2b'] = $this->language->get('text_nurse2b');
		$this->data['text_nurse3b'] = $this->language->get('text_nurse3b');
		$this->data['text_nurse4b'] = $this->language->get('text_nurse4b');
		$this->data['text_customer_room'] = $this->language->get('text_customer_room');
		$this->data['text_child_bed'] = $this->language->get('text_child_bed');
		$this->data['text_childbirth_hospital'] = $this->language->get('text_childbirth_hospital');
		$this->data['text_satisfaction'] = $this->language->get('text_satisfaction');
		$this->data['text_admin'] = $this->language->get('text_admin');
		$this->data['text_incident_report'] = $this->language->get('text_incident_report');
		$this->data['text_incident_category'] = $this->language->get('text_incident_category');
		
		if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';
			
			$this->data['home'] = $this->url->link('common/login', '', 'SSL');
		} else {
			//$this->data['logged'] = sprintf($this->language->get('text_logged'), $this->user->getUserName());
			
			$this->data['logged'] = sprintf($this->language->get('text_logged'), $this->user->getGroupName($this->user->getGroupId()), $this->user->getName());
	
			
			/*
			$this->data['affiliate'] = $this->url->link('sale/affiliate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute'] = $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute_group'] = $this->url->link('catalog/attribute_group', 'token=' . $this->session->data['token'], 'SSL');
			
			$this->data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['country'] = $this->url->link('localisation/country', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['coupon'] = $this->url->link('sale/coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['currency'] = $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], 'SSL');
			*/
			$this->data['home'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], 'SSL');
			if ($this->user->hasPermission('access', 'service/customer')) {
				$this->data['customer'] = $this->url->link('service/customer', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['customer'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'service/child')) {
				$this->data['child'] = $this->url->link('service/child', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['child'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->haspermission('access', 'service/satisfaction')) {
				$this->data['satisfaction'] = $this->url->link('service/satisfaction', 'token=' . $this->session->data['token'], 'ssl');
			} else {
				$this->data['satisfaction'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'ssl');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse1b')) {
				$this->data['nurse1b'] = $this->url->link('nurse/nurse1b', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse1b'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse2b')) {
				$this->data['nurse2b'] = $this->url->link('nurse/nurse2b', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse2b'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse3b')) {
				$this->data['nurse3b'] = $this->url->link('nurse/nurse3b', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse3b'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse4b')) {
				$this->data['nurse4b'] = $this->url->link('nurse/nurse4b', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse4b'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse1c')) {
				$this->data['nurse1c'] = $this->url->link('nurse/nurse1c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse1c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse2c')) {
				$this->data['nurse2c'] = $this->url->link('nurse/nurse2c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse2c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse3c')) {
				$this->data['nurse3c'] = $this->url->link('nurse/nurse3c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse3c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse4c')) {
				$this->data['nurse4c'] = $this->url->link('nurse/nurse4c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse4c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/beck')) {
				$this->data['beck'] = $this->url->link('nurse/beck', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['beck'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'education/edu1c')) {
				$this->data['edu1c'] = $this->url->link('education/edu1c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['edu1c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'nurse/nurse5c')) {
				$this->data['nurse5c'] = $this->url->link('nurse/nurse5c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['nurse5c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'breast/breast1c')) {
				$this->data['breast1c'] = $this->url->link('breast/breast1c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['breast1c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'breast/breast2c')) {
				$this->data['breast2c'] = $this->url->link('breast/breast2c', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['breast2c'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'doctor/childdoctor1')) {
				$this->data['childdoctor1'] = $this->url->link('doctor/childdoctor1', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['childdoctor1'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'doctor/childdoctor2')) {
				$this->data['childdoctor2'] = $this->url->link('doctor/childdoctor2', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['childdoctor2'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'doctor/childdoctor3')) {
				$this->data['childdoctor3'] = $this->url->link('doctor/childdoctor3', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['childdoctor3'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'report/stat1')) {
				$this->data['report_stat1'] = $this->url->link('report/stat1', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['report_stat1'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'report/stat2')) {
				$this->data['report_stat2'] = $this->url->link('report/stat2', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['report_stat2'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'report/chart1')) {
				$this->data['report_chart1'] = $this->url->link('report/chart1', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['report_chart1'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'report/chart2')) {
				$this->data['report_chart2'] = $this->url->link('report/chart2', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['report_chart2'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'report/printall')) {
				$this->data['report_printall'] = $this->url->link('report/printall', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['report_printall'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'user/user')) {
				$this->data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['user'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'user/user_permission')) {
				$this->data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['user_group'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'tool/backup')) {
				$this->data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['backup'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'tool/showathome')) {
				$this->data['showathome'] = $this->url->link('tool/showathome', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['showathome'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'system/customer_room')) {
				$this->data['customer_room'] = $this->url->link('system/customer_room', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['customer_room'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'system/child_bed')) {
				$this->data['child_bed'] = $this->url->link('system/child_bed', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['child_bed'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'system/childbirth_hospital')) {
				$this->data['childbirth_hospital'] = $this->url->link('system/childbirth_hospital', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['childbirth_hospital'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'hrman/new_training')) {
				//$this->data['new_training'] = $this->url->link('hrman/new_training', 'token=' . $this->session->data['token'], 'SSL');
				$this->data['new_training'] = '#';
			} else {
				$this->data['new_training'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'hrman/staff_appraisal')) {
				//$this->data['staff_appraisal'] = $this->url->link('hrman/staff_appraisal', 'token=' . $this->session->data['token'], 'SSL');\
				$this->data['staff_appraisal'] = '#';
			} else {
				$this->data['staff_appraisal'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			
			
			if ($this->user->hasPermission('access', 'admin/incident_report')) {
				$this->data['incident_report'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['incident_report'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			if ($this->user->hasPermission('access', 'admin/incident_category')) {
				$this->data['incident_category'] = $this->url->link('admin/incident_category', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['incident_category'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			}
			//$this->data['customer_group'] = $this->url->link('sale/customer_group', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['customer_blacklist'] = $this->url->link('sale/customer_blacklist', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['download'] = $this->url->link('catalog/download', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['error_log'] = $this->url->link('tool/error_log', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');			
			//$this->data['geo_zone'] = $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['information'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');			
			//$this->data['contact'] = $this->url->link('sale/contact', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['manufacturer'] = $this->url->link('catalog/manufacturer', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['option'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['order'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['order_status'] = $this->url->link('localisation/order_status', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['payment'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['product'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_sale_order'] = $this->url->link('report/sale_order', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_sale_tax'] = $this->url->link('report/sale_tax', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_sale_shipping'] = $this->url->link('report/sale_shipping', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_sale_return'] = $this->url->link('report/sale_return', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_sale_coupon'] = $this->url->link('report/sale_coupon', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_product_viewed'] = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_product_purchased'] = $this->url->link('report/product_purchased', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_customer_order'] = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_customer_reward'] = $this->url->link('report/customer_reward', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_customer_credit'] = $this->url->link('report/customer_credit', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['report_affiliate_commission'] = $this->url->link('report/affiliate_commission', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');			
			//$this->data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['setting'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['store'] = HTTP_CATALOG;
			//$this->data['stock_status'] = $this->url->link('localisation/stock_status', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['tax_class'] = $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['tax_rate'] = $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['total'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['voucher'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['voucher_theme'] = $this->url->link('sale/voucher_theme', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['weight_class'] = $this->url->link('localisation/weight_class', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['length_class'] = $this->url->link('localisation/length_class', 'token=' . $this->session->data['token'], 'SSL');
			//$this->data['zone'] = $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], 'SSL');
			
			/*
			$this->data['stores'] = array();
			
			$this->load->model('setting/store');
			
			$results = $this->model_setting_store->getStores();
			
			foreach ($results as $result) {
				$this->data['stores'][] = array(
					'name' => $result['name'],
					'href' => $result['url']
				);
			}			
			*/
		}
		
		$this->template = 'common/header.tpl';
		
		$this->render();
	}
}
?>