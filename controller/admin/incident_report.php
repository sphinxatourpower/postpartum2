<?php
class ControllerAdminIncidentReport extends Controller { 
	private $error = array();

	public function index() {
		$this->load->language('admin/incident_report');

		$this->document->setTitle($this->language->get('heading_title'));
		 
		$this->load->model('admin/incident');

		$this->getList();
	}

	public function insert() {
		$this->load->language('admin/incident_report');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('admin/incident');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
		
			$this->model_admin_incident->addNews($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('admin/incident_report');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('admin/incident');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			
			if(isset($this->request->post['ignore_date_modified'])){
			$ignore_date_modified = $this->request->post['ignore_date_modified'];
			}else{
			$ignore_date_modified = '';
			}
			
			$this->model_admin_incident->editNews($this->request->get['news_id'], $this->request->post, $ignore_date_modified);
					
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}
	
	public function copy() {
		$this->load->language('admin/incident_report');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('admin/incident');
		
		if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $news_id) {
				$this->model_admin_incident->copyNews($news_id);
	  		}
					
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}
 
	public function delete() {
		$this->load->language('admin/incident_report');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('admin/incident');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $news_id) {
				$this->model_admin_incident->deleteNews($news_id);
				//$this->model_admin_incident->deleteNewsComments($news_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	private function getList() {
		if (isset($this->request->get['filter_title'])) {
			$filter_title = $this->request->get['filter_title'];
		} else {
			$filter_title = '';
		}
		
		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = '';
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = '';
		}
		
		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		
		if (isset($this->request->get['filter_user_id'])) {
			$filter_user_id = $this->request->get['filter_user_id'];
		} else {
			$filter_user_id = null;
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'n.date_added';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		$url = '';
			
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_user_id'])) {
			$url .= '&filter_user_id=' . $this->request->get['filter_user_id'];
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href'	  => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'	  => $this->language->get('text_home'),
	  		'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'href'	  => $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'text'	  => $this->language->get('heading_title'),
	  		'separator' => $this->language->get('text_separator')
		);
		$this->data['insert'] = $this->url->link('admin/incident_report/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('admin/incident_report/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
		$this->data['copy'] = $this->url->link('admin/incident_report/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['newss'] = array();

		$data = array(
			'filter_title'  => $filter_title,
			'filter_category'=> $filter_category,
			'filter_date_added'=> $filter_date_added,
			'filter_status'=> $filter_status,
			'filter_user_id'=> $filter_user_id,
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$this->load->model('service/customer_service');
		
		$servary = array("user_group_id" => 2);
		$this->data['nurses'] = $this->model_service_customer_service->getCustomerServices($servary);
		
		$news_total = $this->model_admin_incident->getTotalNewss($data);
	
		$results = $this->model_admin_incident->getNewss($data);
		
		$this->data['news_categories'] = $this->model_admin_incident->getCategories();
 
		foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('admin/incident_report/update', 'token=' . $this->session->data['token'] . '&news_id=' . $result['news_id'] . $url, 'SSL'),
			);
			/*
			$action[] = array(
				'text' => $this->language->get('text_view'),
				'href' => HTTP_FRONTSITE . 'index.php?ro=admin/incident&news_id=' . $result['news_id'],
			);
			*/
						
			$this->data['newss'][] = array(
				'news_id' => $result['news_id'],
				'title'	  => $result['title'],
				'category'	  => $result['category'],
				'textcolor'	  => $result['textcolor'],
				'date_added'	  => $result['date_added'],
				'date_modified'	  => $result['date_modified'],
				//'comment_total' => $this->model_admin_incident->getTotalCommentsByNewsId($result['news_id']),
				//'comment_link' => $this->url->link('news/comment', 'token=' . $this->session->data['token'] . '&filter_title=' . $result['title'], 'SSL'),
				//'approved_comment' => $this->model_admin_incident->getTotalApprovedCommentsByNewsId($result['news_id']),
				//'unapproved_comment' => $this->model_admin_incident->getTotalUnapprovedCommentsByNewsId($result['news_id']),
				'sort_order' => $result['sort_order'],
				'status'	 => ($result['status']) ? $this->language->get('text_post_enabled') : $this->language->get('text_post_disabled'),
				'reportername' => $this->model_service_customer_service->getCustomerServiceName($result['user_id']),
				'selected'=> isset($this->request->post['selected']) && in_array($result['news_id'], $this->request->post['selected']),
				'action'	 => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_post_enabled');		
		$this->data['text_disabled'] = $this->language->get('text_post_disabled');		
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_category'] = $this->language->get('column_category');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		//$this->data['column_date_modified'] = $this->language->get('column_date_modified');
		//$this->data['column_comment'] = $this->language->get('column_comment');
		//$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_status'] = $this->language->get('column_status');		
		$this->data['column_service'] = $this->language->get('column_service');		
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_copy'] = $this->language->get('button_copy');		
		$this->data['button_filter'] = $this->language->get('button_filter');
 
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
		
		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_user_id'])) {
			$url .= '&filter_user_id=' . $this->request->get['filter_user_id'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_title'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . '&sort=n.title' . $url, 'SSL');
		$this->data['sort_category'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . '&sort=n.news.category_id' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . '&sort=n.date_added' . $url, 'SSL');
		$this->data['sort_date_modified'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . '&sort=n.date_modified' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . '&sort=n.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_user_id'])) {
			$url .= '&filter_user_id=' . $this->request->get['filter_user_id'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $news_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL') . '&page={page}';
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_title'] = $filter_title;
		$this->data['filter_category'] = $filter_category;
		$this->data['filter_date_added'] = $filter_date_added;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_user_id'] = $filter_user_id;

 		$this->data['token'] = $this->session->data['token'];

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'admin/incident_report_list.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
	}

	private function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_data'] = $this->language->get('tab_data');
		$this->data['tab_related_news'] = $this->language->get('tab_related_news');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');	
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$this->data['text_enabled'] = $this->language->get('text_post_enabled');
		$this->data['text_disabled'] = $this->language->get('text_post_disabled');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_all_user'] = $this->language->get('text_all_user');
		$this->data['text_member_only'] = $this->language->get('text_member_only');
		$this->data['text_approved'] = $this->language->get('text_approved');
		$this->data['text_unapproved'] = $this->language->get('text_unapproved');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_no_comments'] = $this->language->get('text_no_comments');
		$this->data['text_ignore_date_modified'] = $this->language->get('text_ignore_date_modified');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_service'] = $this->language->get('entry_service');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_short_description'] = $this->language->get('entry_short_description');
		$this->data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$this->data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$this->data['entry_tag'] = $this->language->get('entry_tag');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_keyword'] = $this->language->get('entry_keyword');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_date_added'] = $this->language->get('entry_date_added');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_allow_comment'] = $this->language->get('entry_allow_comment');
		$this->data['entry_comment_permission'] = $this->language->get('entry_comment_permission');
		$this->data['entry_comment_need_approval'] = $this->language->get('entry_comment_need_approval');
		$this->data['entry_comment'] = $this->language->get('entry_comment');
		$this->data['entry_category'] = $this->language->get('entry_category');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['token'] = $this->session->data['token'];
		
		if(isset($this->request->get['news_id'])){
			$this->data['news_id'] = $this->request->get['news_id'];
		}else{
			$this->data['news_id'] = '';
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
		}
		
	 	if (isset($this->error['description'])) {
			$this->data['error_description'] = $this->error['description'];
		} else {
			$this->data['error_description'] = '';
		}
		
	 	if (isset($this->error['date_added'])) {
			$this->data['error_date_added'] = $this->error['date_added'];
		} else {
			$this->data['error_date_added'] = '';
		}
		
	 	if (isset($this->error['user'])) {
			$this->data['error_user'] = $this->error['user'];
		} else {
			$this->data['error_user'] = '';
		}
		
	 	if (isset($this->error['news_category'])) {
			$this->data['error_news_category'] = $this->error['news_category'];
		} else {
			$this->data['error_news_category'] = '';
		}
		
		$this->load->model('admin/incident');
				
		$this->data['news_categories'] = $this->model_admin_incident->getCategories();
		
		$url = '';
			
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
  		$this->document->breadcrumbs = array();

		$this->document->breadcrumbs[] = array(
			'href'	  => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'	  => $this->language->get('text_home'),
	  		'separator' => false
		);

		$this->document->breadcrumbs[] = array(
			'href'	  => $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'text'	  => $this->language->get('heading_title'),
	  		'separator' => $this->language->get('text_separator')
		);
		$this->data['breadcrumbs'] = $this->document->breadcrumbs;						
		if (!isset($this->request->get['news_id'])) {
			$this->data['action'] = $this->url->link('admin/incident_report/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('admin/incident_report/update', 'token=' . $this->session->data['token'] . '&news_id=' . $this->request->get['news_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('admin/incident_report', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['news_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$news_info = $this->model_admin_incident->getNews($this->request->get['news_id']);
		}
			
		if (isset($this->request->post['title'])) {
			$this->data['title'] = $this->request->post['title'];
		} elseif (!empty($news_info)) {
			$this->data['title'] = $news_info['title'];
		} else {
			$this->data['title'] = '';
		}
		
		if (isset($this->request->post['date_added'])) {
			$this->data['date_added'] = $this->request->post['date_added'];
		} elseif (!empty($news_info)) {
			$this->data['date_added'] = $news_info['date_added'];
		} else {
			$this->data['date_added'] = date($this->language->get('date_format_longest'), strtotime("now"));
		}
		
		if (isset($this->request->post['description'])) {
			$this->data['description'] = $this->request->post['description'];
		} elseif (!empty($news_info)) {
			$this->data['description'] = $news_info['description'];
		} else {
			$this->data['description'] = '';
		}
		
		if (isset($this->request->post['comment'])) {
			$this->data['comment'] = $this->request->post['comment'];
		} elseif (!empty($news_info)) {
			$this->data['comment'] = $news_info['comment'];
		} else {
			$this->data['comment'] = '';
		}
		
		if (isset($this->request->post['news_category_id'])) {
			$this->data['news_category_id'] = $this->request->post['news_category_id'];
		} elseif (!empty($news_info)) {
			$this->data['news_category_id'] = $news_info['news_category_id'];
		} else {
			$this->data['news_category_id'] = '';
		}
		
		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (!empty($news_info)) {
			$this->data['image'] = $news_info['image'];
		} else {
			$this->data['image'] = '';
		}
		
		$this->load->model('tool/image');
		
		if (isset($news_info) && $news_info['image'] && file_exists(DIR_IMAGE . $news_info['image'])) {
			$this->data['preview'] = $this->model_tool_image->resize($news_info['image'], 100, 100);
		} else {
			$this->data['preview'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}
				
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (isset($news_info)) {
			$this->data['status'] = $news_info['status'];
		} else {
			$this->data['status'] = 1;
		}
		
		$this->load->model('service/customer_service');
		$servary = array("user_group_id" => 2);
		$this->data['nurses'] = $this->model_service_customer_service->getCustomerServices($servary);
		
		if (isset($this->request->post['user_id'])) {
      		$this->data['user_id'] = $this->request->post['user_id'];
    	} elseif (!empty($form_info)) { 
			$this->data['user_id'] = $form_info['user_id'];
		} else {
      		$this->data['user_id'] = 0;
    	}	
		
		$this->data['logged_id'] = $this->user->getId();
		/*
		if (isset($this->request->post['allow_comment'])) {
			$this->data['allow_comment'] = $this->request->post['allow_comment'];
		} elseif (isset($news_info)) {
			$this->data['allow_comment'] = $news_info['allow_comment'];
		} else {
			$this->data['allow_comment'] = 1;
		}
		
		if (isset($this->request->post['comment_permission'])) {
			$this->data['comment_permission'] = $this->request->post['comment_permission'];
		} elseif (isset($news_info)) {
			$this->data['comment_permission'] = $news_info['comment_permission'];
		} else {
			$this->data['comment_permission'] = 0;
		}
		
		if (isset($this->request->post['comment_need_approval'])) {
			$this->data['comment_need_approval'] = $this->request->post['comment_need_approval'];
		} elseif (isset($news_info)) {
			$this->data['comment_need_approval'] = $news_info['comment_need_approval'];
		} else {
			$this->data['comment_need_approval'] = 0;
		}
		*/
		
		/*
		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		if (isset($this->request->post['news_store'])) {
			$this->data['news_store'] = $this->request->post['news_store'];
		} elseif (isset($news_info)) {
			$this->data['news_store'] = $this->model_admin_incident->getNewsStores($this->request->get['news_id']);
		} else {
			$this->data['news_store'] = array(0);
		}		
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (isset($news_info)) {
			$this->data['keyword'] = $news_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (isset($news_info)) {
			$this->data['sort_order'] = $news_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}
		*/
		
		/*
		if (isset($this->request->post['ignore_date_modified'])) {
			$this->data['ignore_date_modified'] = $this->request->post['ignore_date_modified'];
		}else{
			$this->data['ignore_date_modified'] = '';
		}
		*/
				
		// Related News start
		/*
		$this->data['newss'] = $this->model_admin_incident->getNewss(0);
		
		if (isset($this->request->post['related_news'])) {
			$this->data['related_news'] = $this->request->post['related_news'];
		} elseif (isset($news_info)) {
			$this->data['related_news'] = $this->model_admin_incident->getRelatedNews($this->request->get['news_id']);
		} else {
			$this->data['related_news'] = array();
		}
		*/
		// Related News end
		
		$this->template = 'admin/incident_report_form.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
	}
	
	public function view() {
		$this->load->language('admin/incident_report');
		
		$this->data['heading_title'] = $this->language->get('heading_title_view');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_data'] = $this->language->get('tab_data');
		$this->data['tab_related_news'] = $this->language->get('tab_related_news');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');	
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$this->data['text_enabled'] = $this->language->get('text_post_enabled');
		$this->data['text_disabled'] = $this->language->get('text_post_disabled');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_all_user'] = $this->language->get('text_all_user');
		$this->data['text_member_only'] = $this->language->get('text_member_only');
		$this->data['text_approved'] = $this->language->get('text_approved');
		$this->data['text_unapproved'] = $this->language->get('text_unapproved');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_no_comments'] = $this->language->get('text_no_comments');
		$this->data['text_ignore_date_modified'] = $this->language->get('text_ignore_date_modified');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_short_description'] = $this->language->get('entry_short_description');
		$this->data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$this->data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$this->data['entry_tag'] = $this->language->get('entry_tag');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_keyword'] = $this->language->get('entry_keyword');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_date_added'] = $this->language->get('entry_date_added');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_allow_comment'] = $this->language->get('entry_allow_comment');
		$this->data['entry_comment_permission'] = $this->language->get('entry_comment_permission');
		$this->data['entry_comment_need_approval'] = $this->language->get('entry_comment_need_approval');
		$this->data['entry_category'] = $this->language->get('entry_category');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['token'] = $this->session->data['token'];
		
		if(isset($this->request->get['news_id'])){
			$this->data['news_id'] = $this->request->get['news_id'];
		}else{
			$this->data['news_id'] = '';
		}
		
		$this->load->model('admin/incident');
		
		if (isset($this->request->get['news_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$news_info = $this->model_admin_incident->getNews($this->request->get['news_id']);
		}
			
		if (!empty($news_info)) {
			$this->data['title'] = $news_info['title'];
		} else {
			$this->data['title'] = '';
		}
		
		if (!empty($news_info)) {
			$this->data['textcolor'] = $news_info['textcolor'];
		} else {
			$this->data['textcolor'] = '';
		}
		
		if (!empty($news_info)) {
			$this->data['date_added'] = $news_info['date_added'];
		} else {
			$this->data['date_added'] = date($this->language->get('datetime_format_short'), strtotime("now"));
		}
		
		if (!empty($news_info)) {
			$this->data['description'] = html_entity_decode($news_info['description'], ENT_QUOTES, "UTF-8");
		} else {
			$this->data['description'] = '';
		}
		
		if (!empty($news_info)) {
			$this->data['news_category'] = $news_info['category'];
		} else {
			$this->data['news_category'] = '';
		}
		
		if (isset($news_info)) {
			$this->data['status'] = $news_info['status'];
		} else {
			$this->data['status'] = 1;
		}
	
		$this->template = 'admin/incident_report_view.tpl';
		
		$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'admin/incident_report')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		/*
		if ((strlen(utf8_decode($this->request->post['title'])) < 3) || (strlen(utf8_decode($this->request->post['title'])) > 255)) {
			$this->error['title'] = $this->language->get('error_title');
		}
		*/
		
		if (strlen(utf8_decode($this->request->post['description'])) < 3) {
			$this->error['description'] = $this->language->get('error_description');
		}
		
		/*
		if (strlen(utf8_decode($this->request->post['date_added'])) < 10) {
			$this->error['date_added'] = $this->language->get('error_date_added');
		}
		*/
		
		if (!isset($this->request->post['news_category_id'])) {
			$this->error['news_category'] = $this->language->get('error_news_category');
		}
		
		if (!isset($this->request->post['user_id'])) {
			$this->error['user'] = $this->language->get('error_user');
		}

		if (!$this->error) {
			return true;
		} else {
			if (!isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_required_data');
			}
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('delete', 'admin/incident_report')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

  	private function validateCopy() {
		if (!$this->user->hasPermission('modify', 'admin/incident_report')) {
	  		$this->error['warning'] = $this->language->get('error_permission');  
		}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}
	
	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_title'])) {
			$this->load->model('admin/incident');
			
			if (isset($this->request->get['filter_title'])) {
				$filter_title = $this->request->get['filter_title'];
			} else {
				$filter_title = '';
			}
			
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];	
			} else {
				$limit = 20;	
			}			
						
			$data = array(
				'filter_title'		 => $filter_title,
				'start'			=> 0,
				'limit'			=> $limit
			);
			
			$results = $this->model_admin_incident->getNewss($data);
			
			foreach ($results as $result) {			
				$json[] = array(
					'news_id' => $result['news_id'],
					'title'	=> html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),	
				);	
			}
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>