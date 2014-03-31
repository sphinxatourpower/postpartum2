<?php
class ModelAdminIncident extends Model {
	public function addNews($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "incident SET title = '" . $this->db->escape($data['title']) . "', description = '" . $this->db->escape($data['description']) . "', comment = '" . $this->db->escape($data['comment']) . "', news_category_id = '" . (int)$data['news_category_id'] . "', user_id = '" . (int)$data['user_id'] . "', sort_order = '0', status = '" . (int)$data['status'] . "'");

		$news_id = $this->db->getLastId(); 
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET image = '" . $this->db->escape($data['image']) . "' WHERE news_id = '" . (int)$news_id . "'");
		}
		
		if ($data['date_added']<>'' && $data['date_added_time']<>'') {
			$d = $data['date_added'].' '.$data['date_added_time'];
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET date_added = '" . $this->db->escape($d) . "', date_modified = '" . $this->db->escape($d) . "' WHERE news_id = '" . (int)$news_id . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET date_added = '" . date('Y-m-d H:i:s') . "', date_modified = '" . date('Y-m-d H:i:s') . "' WHERE news_id = '" . (int)$news_id . "'");
		}
			
		/*
		foreach ($data['news_description'] as $language_id => $value) {
			if ($value['date_added']<>'' && $value['date_added_time']<>'') {
				$d = $value['date_added'].' '.$value['date_added_time'];
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_description SET news_id = '" . (int)$news_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', short_description = '" . $this->db->escape($value['short_description']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', date_added = '" . $this->db->escape($d) . "', date_modified = '" . $this->db->escape($d) . "'");
			} else {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_description SET news_id = '" . (int)$news_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', short_description = '" . $this->db->escape($value['short_description']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', date_added = '" . date('Y-m-d H:i:s') . "', date_modified = '" . date('Y-m-d H:i:s') . "'");
			}
		}
		*/
		
		/*
		if (isset($data['news_store'])) {
			foreach ($data['news_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_to_store SET news_id = '" . (int)$news_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'news_id=" . (int)$news_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		if (isset($data['related_news'])) {
			foreach ($data['related_news'] as $child_news_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_related SET parent_news_id = '" . (int)$news_id . "', child_news_id = '" . (int)$child_news_id . "'");
			}
		}
		if (isset($data['news_category'])) {
			foreach ($data['news_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_to_category SET news_id = '" . (int)$news_id . "', news_category_id = '" . (int)$category_id . "'");
			}
		}
		foreach ($data['news_tag'] as $language_id => $value) {
			if ($value) {
				$tags = explode(',', $value);
				
				foreach ($tags as $tag) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "incident_tag SET news_id = '" . (int)$news_id . "', language_id = '" . (int)$language_id . "', tag = '" . $this->db->escape(trim($tag)) . "'");
				}
			}
		}
		*/
		
		$this->cache->delete('incident');
	}
	
	public function editNews($news_id, $data, $ignore_date_modified) {
		$this->db->query("UPDATE " . DB_PREFIX . "incident SET title = '" . $this->db->escape($data['title']) . "', description = '" . $this->db->escape($data['description']) . "', comment = '" . $this->db->escape($data['comment']) . "', user_id = '" . (int)$data['user_id'] . "', news_category_id = '" . (int)$data['news_category_id'] . "', sort_order = '0', status = '" . (int)$data['status'] . "' WHERE news_id = '" . (int)$news_id . "'");
		
		$get_date_added = mysql_query("SELECT * FROM " . DB_PREFIX . "incident WHERE news_id = '" . (int)$news_id . "'");
		$date_added = mysql_fetch_array($get_date_added);
		$this->session->data['date_added'] = $date_added['date_added'];
					
		if ($data['date_added']<>'' && $data['date_added_time']<>'') {
			$d = $data['date_added'].' '.$data['date_added_time'];
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET date_added = '" . $this->db->escape($d) . "', date_modified = '" . $this->db->escape($d) . "' WHERE news_id = '" . (int)$news_id . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET date_added = '" . $this->db->escape($this->session->data['date_added']) . "', date_modified = '" . date('Y-m-d H:i:s') . "' WHERE news_id = '" . (int)$news_id . "'");
		}
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "incident SET image = '" . $this->db->escape($data['image']) . "' WHERE news_id = '" . (int)$news_id . "'");
		}

		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_to_store WHERE news_id = '" . (int)$news_id . "'");
		
		if (isset($data['news_store'])) {
			foreach ($data['news_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_to_store SET news_id = '" . (int)$news_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		*/
		
		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'news_id=" . (int)$news_id. "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'news_id=" . (int)$news_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_to_category WHERE news_id = '" . (int)$news_id . "'");
		*/
		
		/*
		if (isset($data['news_category'])) {
			foreach ($data['news_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_to_category SET news_id = '" . (int)$news_id . "', news_category_id = '" . (int)$category_id . "'");
			}		
		}	
		*/		
		
		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_related WHERE parent_news_id = '" . (int)$news_id . "'");
		
		if (isset($data['related_news'])) {
			foreach ($data['related_news'] as $child_news_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_related SET parent_news_id = '" . (int)$news_id . "', child_news_id = '" . (int)$child_news_id . "'");
			}		
		}
		*/
		
		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_tag WHERE news_id = '" . (int)$news_id. "'");
		
		foreach ($data['news_tag'] as $language_id => $value) {
			if ($value) {
				$tags = explode(',', $value);
				
				foreach ($tags as $tag) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "incident_tag SET news_id = '" . (int)$news_id . "', language_id = '" . (int)$language_id . "', tag = '" . $this->db->escape(trim($tag)) . "'");
				}
			}
		}
		*/
		$this->cache->delete('incident');
	}
	
	public function deleteNews($news_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident WHERE news_id = '" . (int)$news_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_description WHERE news_id = '" . (int)$news_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_to_store WHERE news_id = '" . (int)$news_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'news_id=" . (int)$news_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_to_category WHERE news_id = '" . (int)$news_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_tag WHERE news_id = '" . (int)$news_id . "'");
		
		$this->cache->delete('incident');
	}	

	public function copyNews($news_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "incident p WHERE p.news_id = '" . (int)$news_id . "'");
		
		if ($query->num_rows) {
			$data = array();
			
			$data = $query->row;
			
			$data['status'] = '0';
			$data['date_added'] = '';
			$data['date_modified'] = '';
						
			//$data = array_merge($data, array('news_description' => $this->getNewsDescriptions($news_id)));			
			//$data = array_merge($data, array('news_category' => $this->getNewsCategories($news_id)));
			//$data = array_merge($data, array('news_store' => $this->getNewsStores($news_id)));
			//$data = array_merge($data, array('news_tag' => $this->getNewsTags($news_id)));
			//$data = array_merge($data, array('related_news' => $this->getRelatedNews($news_id)));
			//$data = array_merge($data, array('keyword' => $this->getNews($news_id)));
			
			$this->addNews($data);
			
			$this->cache->delete('incident');
		}
	}
	
	public function getNews($news_id) {
		$query = $this->db->query("SELECT DISTINCT n.*, 
		(SELECT nc.name FROM " . DB_PREFIX . "incident_category nc WHERE nc.news_category_id = n.news_category_id ) AS category,
		(SELECT nc.textcolor FROM " . DB_PREFIX . "incident_category nc WHERE nc.news_category_id = n.news_category_id ) AS textcolor
		FROM " . DB_PREFIX . "incident n WHERE n.news_id = '" . (int)$news_id . "'");
		
		return $query->row;
	}
		
	public function getNewss($data = array()) {
		if ($data) {
			$sql = "SELECT n.*, nc.name AS category, nc.textcolor AS textcolor
			FROM " . DB_PREFIX . "incident n 
			LEFT JOIN " . DB_PREFIX . "incident_category nc ON nc.news_category_id = n.news_category_id
			WHERE 1 ";
			if (!empty($data['filter_title'])) {
				$sql .= " AND LCASE(n.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_title'])) . "%'";
			}
			
			if (isset($data['filter_category']) && !empty($data['filter_category'])) {
				$sql .= " AND n.news_category_id = '" . (int)$data['filter_category'] . "'";
			}
			
			if (isset($data['filter_user_id']) && !empty($data['filter_user_id'])) {
				$sql .= " AND n.user_id = '" . (int)$data['filter_user_id'] . "'";
			}
			
			if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
				$sql .= " AND DATE(n.date_added) = '" . $this->db->escape($data['filter_date_added']) . "'";
			}
			
			if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
				$sql .= " AND n.status = '" . (int)$data['filter_status'] . "'";
			}
			
			$sort_data = array(
				'n.title',
				'n.news_category_id',
				'n.date_added',
				'n.date_modified',
				'n.sort_order'
			);		
		
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY nc.sort_order ASC, " . $data['sort'];	
			} else {
				$sql .= " ORDER BY nc.sort_order ASC, n.title ASC";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}		

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
			
			$query = $this->db->query($sql);
			
			return $query->rows;
		} else {
			$news_data = $this->cache->get('incident');
		
			if (!$news_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident n ORDER BY n.date_added DESC");
	
				$news_data = $query->rows;
			
				$this->cache->set('incident', $news_data);
			}	
	
			return $news_data;			
		}
	}
	
	/*
	public function getNewsCategories($news_id) {
		$news_category_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_to_category WHERE news_id = '" . (int)$news_id . "'");
		
		foreach ($query->rows as $result) {
			$news_category_data[] = $result['news_category_id'];
		}

		return $news_category_data;
	}
	*/
	
	/*
	public function getNewsTags($news_id) {
		$news_tag_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_tag WHERE news_id = '" . (int)$news_id . "'");
		
		$tag_data = array();
		
		foreach ($query->rows as $result) {
			$tag_data[$result['language_id']][] = $result['tag'];
		}
		
		foreach ($tag_data as $language => $tags) {
			$news_tag_data[$language] = implode(',', $tags);
		}
		
		return $news_tag_data;
	}
	*/
	
	/*
	public function getNewsDescriptions($news_id) {
		$news_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_description WHERE news_id = '" . (int)$news_id . "'");

		foreach ($query->rows as $result) {
			$news_description_data[$result['language_id']] = array(
				'title'       => $result['title'],
				'description' => $result['description'],
				'short_description' => $result['short_description'],
				'meta_description' => $result['meta_description'],
				'date_added' => $result['date_added'],
				'meta_keyword' => $result['meta_keyword']
			);
		}
		
		return $news_description_data;
	}
	*/
	
	/*
	public function getNewsStores($news_id) {
		$news_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_to_store WHERE news_id = '" . (int)$news_id . "'");

		foreach ($query->rows as $result) {
			$news_store_data[] = $result['store_id'];
		}
		
		return $news_store_data;
	}
	*/
	
	public function getTotalNewss($data = array()) {
		$sql = "SELECT COUNT(*) AS total
			FROM " . DB_PREFIX . "incident n 
			LEFT JOIN " . DB_PREFIX . "incident_category nc ON nc.news_category_id = n.news_category_id
			WHERE 1 ";

		if (!empty($data['filter_title'])) {
			$sql .= " AND LCASE(n.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_title'])) . "%'";
		}
		
		if (isset($data['filter_category']) && !empty($data['filter_category'])) {
			$sql .= " AND n.news_category_id = '" . (int)$data['filter_category'] . "'";
		}
		
		if (isset($data['filter_user_id']) && !empty($data['filter_user_id'])) {
			$sql .= " AND n.user_id = '" . (int)$data['filter_user_id'] . "'";
		}
			
		if (isset($data['filter_date_added']) && !empty($data['filter_date_added'])) {
			$sql .= " AND DATE(n.date_added) = '" . $this->db->escape($data['filter_date_added']) . "'";
		}
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND n.status = '" . (int)$data['filter_status'] . "'";
		}
			
		$query = $this->db->query($sql);
		return $query->row['total'];
	}	
	
	public function getCommentsByNewsId($news_id, $start = 0, $limit = 40) {
		$query = $this->db->query("SELECT nc.news_comment_id, nc.news_id, nc.name, nc.email, nc.comment, nc.status, n.news_id, n.title, n.image, nc.date_added FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id) WHERE n.news_id = '" . (int)$news_id . "' ORDER BY nc.date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
		
		return $query->rows;
	}
	
	public function getTotalCommentsByNewsId($news_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id) WHERE n.news_id = '" . (int)$news_id . "'");
		
		return $query->row['total'];
	}	
	
	public function editComment($news_comment_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "incident_comment SET name = '" . $this->db->escape($data['name']) . "', news_id = '" . $this->db->escape($data['news_id']) . "', comment = '" . $this->db->escape(strip_tags($data['comment'])) . "', email = '" . $this->db->escape(strip_tags($data['email'])) . "', status = '" . (int)$data['status'] . "', date_added = NOW() WHERE news_comment_id = '" . (int)$news_comment_id . "'");
	}
	
	public function getComment($news_comment_id) {
		$query = $this->db->query("SELECT nc.news_comment_id, nc.news_id, nd.title, nc.comment, nc.name, nc.email, nc.status, nc.date_added FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id) WHERE nc.news_comment_id = '" . (int)$news_comment_id . "'");
	
		return $query->row;
	}
	
	public function getComments($data = array()) {
		$sql = "SELECT nc.news_comment_id, n.title, nc.name, nc.email, nc.comment, nc.status, nc.date_added FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id)";

		if (!empty($data['filter_title'])) {
				$sql .= " AND LCASE(n.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_title'])) . "%'";
			}
			
			if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
				$sql .= " AND nc.status = '" . (int)$data['filter_status'] . "'";
			}			

		$sort_data = array(
			'n.title',
			'nc.name',
			'nc.email',
			'nc.comment',
			'nc.status',
			'nc.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY nc.date_added";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}																																							  
																																							  
		$query = $this->db->query($sql);																																				
		
		return $query->rows;	
	}
	
	public function getTotalComments($data = array()) {
		$sql =  "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = nd.news_id) ";
		
		if (!empty($data['filter_title'])) {
			$sql .= " AND LCASE(n.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_title'])) . "%'";
		}
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND nc.status = '" . (int)$data['filter_status'] . "'";
		}			
		$query = $this->db->query($sql);
		return $query->row['total'];
	}
	
	public function getTotalApprovedCommentsByNewsId($news_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id) WHERE n.news_id = '" . (int)$news_id . "' AND nc.status = '1' ");
		
		return $query->row['total'];
	}
	
	public function getTotalUnapprovedCommentsByNewsId($news_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_comment nc LEFT JOIN " . DB_PREFIX . "incident n ON (nc.news_id = n.news_id) WHERE n.news_id = '" . (int)$news_id . "' AND nc.status = '0' ");
		
		return $query->row['total'];
	}
	
	public function deleteNewsComments($news_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_comment WHERE news_id = '" . (int)$news_id . "'");
	}	
	
	public function deleteComments($news_comment_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_comment WHERE news_comment_id = '" . (int)$news_comment_id . "'");
	}	
	
	/*
	public function getRelatedNews($news_id) {
		$related_news_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_related WHERE parent_news_id = '" . (int)$news_id . "'");
		
		foreach ($query->rows as $result) {
			$related_news_data[] = $result['child_news_id'];
		}

		return $related_news_data;
	}
	*/
       	
	public function addnews_category($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category SET name = '". $this->db->escape($data['name']) ."', textcolor = '". $this->db->escape($data['textcolor']) ."', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");
	
		$news_category_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "incident_category SET image = '" . $this->db->escape($data['image']) . "' WHERE news_category_id = '" . (int)$news_category_id . "'");
		}
		
		/*
		foreach ($data['news_category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_description SET news_category_id = '" . (int)$news_category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		if (isset($data['news_category_store'])) {
			foreach ($data['news_category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_to_store SET news_category_id = '" . (int)$news_category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['news_category_layout'])) {
			foreach ($data['news_category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_to_layout SET news_category_id = '" . (int)$news_category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'news_category_id=" . (int)$news_category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		*/
		
		$this->cache->delete('news_category');
	}
	
	public function editnews_category($news_category_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "incident_category SET name = '". $this->db->escape($data['name']) ."', textcolor = '". $this->db->escape($data['textcolor']) ."', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE news_category_id = '" . (int)$news_category_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "incident_category SET image = '" . $this->db->escape($data['image']) . "' WHERE news_category_id = '" . (int)$news_category_id . "'");
		}

		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_description WHERE news_category_id = '" . (int)$news_category_id . "'");

		foreach ($data['news_category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_description SET news_category_id = '" . (int)$news_category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_to_store WHERE news_category_id = '" . (int)$news_category_id . "'");
		
		if (isset($data['news_category_store'])) {		
			foreach ($data['news_category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_to_store SET news_category_id = '" . (int)$news_category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_to_layout WHERE news_category_id = '" . (int)$news_category_id . "'");

		if (isset($data['news_category_layout'])) {
			foreach ($data['news_category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "incident_category_to_layout SET news_category_id = '" . (int)$news_category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'news_category_id=" . (int)$news_category_id. "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'news_category_id=" . (int)$news_category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		*/
		
		$this->cache->delete('news_category');
	}
	
	public function deletenews_category($news_category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category WHERE news_category_id = '" . (int)$news_category_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_description WHERE news_category_id = '" . (int)$news_category_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_to_store WHERE news_category_id = '" . (int)$news_category_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "incident_category_to_layout WHERE news_category_id = '" . (int)$news_category_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'news_category_id=" . (int)$news_category_id . "'");
		
		/*
		$query = $this->db->query("SELECT news_category_id FROM " . DB_PREFIX . "incident_category WHERE parent_id = '" . (int)$news_category_id . "'");

		foreach ($query->rows as $result) {
			$this->deletenews_category($result['news_category_id']);
		}
		*/
		
		$this->cache->delete('news_category');
	} 

	public function getnews_category($news_category_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "incident_category WHERE news_category_id = '" . (int)$news_category_id . "'");
		
		return $query->row;
	} 
	
	//public function getCategories($parent_id = 0) {
	public function getCategories() {
		$news_category_data = $this->cache->get('news_category');
	
		if (!$news_category_data) {
			$news_category_data = array();
		
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_category c ORDER BY c.sort_order ASC, c.name ASC");
		
			foreach ($query->rows as $result) {
				$news_category_data[] = array(
					'news_category_id' => $result['news_category_id'],
					'name'        => $result['name'],
					'image'        => $result['image'],
					'textcolor'        => $result['textcolor'],
					'status'  	  => $result['status'],
					'sort_order'  => $result['sort_order']
				);
			
				//$news_category_data = array_merge($news_category_data, $this->getCategories($result['news_category_id']));
			}	
	
			$this->cache->set('news_category', $news_category_data);
		}
		
		return $news_category_data;
	}
	
	/*
	public function getPath($news_category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "incident_category c LEFT JOIN " . DB_PREFIX . "incident_category_description cd ON (c.news_category_id = cd.news_category_id) WHERE c.news_category_id = '" . (int)$news_category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
		if ($query->row['parent_id']) {
			return $this->getPath($query->row['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $query->row['name'];
		} else {
			return $query->row['name'];
		}
	}
	*/
	
	/*
	public function getnews_categoryDescriptions($news_category_id) {
		$news_category_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_category_description WHERE news_category_id = '" . (int)$news_category_id . "'");
		
		foreach ($query->rows as $result) {
			$news_category_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
				'meta_keyword'     => $result['meta_keyword'],
				'meta_description' => $result['meta_description'],
				'description'      => $result['description']
			);
		}
		
		return $news_category_description_data;
	}	
	*/
	
	/*
	public function getnews_categoryStores($news_category_id) {
		$news_category_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_category_to_store WHERE news_category_id = '" . (int)$news_category_id . "'");

		foreach ($query->rows as $result) {
			$news_category_store_data[] = $result['store_id'];
		}
		
		return $news_category_store_data;
	}
	*/

	/*
	public function getnews_categoryLayouts($news_category_id) {
		$news_category_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "incident_category_to_layout WHERE news_category_id = '" . (int)$news_category_id . "'");
		
		foreach ($query->rows as $result) {
			$news_category_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $news_category_layout_data;
	}
	*/
		
	public function getTotalCategories() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_category");
		
		return $query->row['total'];
	}	
		
	public function getTotalCategoriesByImageId($image_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_category WHERE image_id = '" . (int)$image_id . "'");
		
		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "incident_category_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
}
?>