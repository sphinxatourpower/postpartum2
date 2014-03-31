<?php
class ModelServiceChild extends Model {
	public function addChild($data) {
		//$this->db->query("INSERT INTO " . DB_PREFIX . "customer_chlid SET idnumber = '".$this->db->escape($data['idnumber'])."', birthdate = '".$this->db->escape($data['birthdate'])."', name = '" . $this->db->escape($data['name']) . "', address = '".$this->db->escape($data['address'])."', telephone = '" . $this->db->escape($data['telephone']) . "', mobile = '" . $this->db->escape($data['mobile']) . "', fall_score = '".$this->db->escape($data['fall_score'])."', depression_score = '".$this->db->escape($data['depression_score'])."' , degree = '" . $this->db->escape($data['degree']) . "', profession = '" . $this->db->escape($data['profession']) . "', language = '" . $this->db->escape($data['language']) . "', evacuation_hospital = '".$this->db->escape($data['evacuation_hospital']) ."', status = '" . (int)$data['status'] . "', customer_service_id = '" . (int)$data['customer_service_id'] . "', date_leave= '" . $this->db->escape($data['date_leave']). "', date_added = NOW()");      	
		
      	$customer_child_id = $this->db->getLastId();
      	
		if (isset($data['child_image'])) {
			$sort_order = array();
	  		foreach ($data['child_image'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $data['child_image']);
		
			foreach ($data['child_image'] as $key => $child_image) {
				if ($key == "0") {
					$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET image = '". $this->db->escape(html_entity_decode($child_image['image'], ENT_QUOTES, 'UTF-8')) ."' WHERE customer_child_id = '". (int)$customer_child_id ."'");
				}
				$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_image SET customer_child_id = '" . (int)$customer_child_id . "', image = '" . $this->db->escape(html_entity_decode($child_image['image'], ENT_QUOTES, 'UTF-8')) . ", sort_order = '" . (int)$child_image['sort_order'] . "'");
			}
		}
		/*
		if (isset($data['child'])) {		
      		foreach ($data['child'] as $child) {	
      			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($address['name']) . "'");
			}
		}
		
		if (isset($data['contact'])) {		
      		foreach ($data['contact'] as $contact) {	
      			$this->db->query("INSERT INTO " . DB_PREFIX . "contact SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "', telephone = '" . $this->db->escape($contact['telephone']) . "', relationship = '" . $this->db->escape($contact['relationship']) . "'");
				
				if (isset($contact['default'])) {
					$contact_id = $this->db->getLastId();
					
					$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact=contact_id = '" . $contact_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
				}
			}
		}
		*/
	}
	
	public function editChild($customer_child_id, $data) {		
		//$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET idnumber = '".$this->db->escape($data['idnumber'])."', name = '" . $this->db->escape($data['name']) . "', birthdate = '" . $this->db->escape($data['birthdate']) . "', address= '" . $this->db->escape($data['address']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', mobile = '" . $this->db->escape($data['mobile']) . "',  fall_score = '".$this->db->escape($data['fall_score'])."', depression_score = '".$this->db->escape($data['depression_score'])."' , degree = '" . $this->db->escape($data['degree']) . "', profession = '" . $this->db->escape($pro) . "', language = '" . $this->db->escape($lng) . "', evacuation_hospital = '".$this->db->escape($evh) ."', status = '" . (int)$data['status'] . "', customer_service_id = '" . (int)$data['customer_service_id'] . "', date_leave = '" . $this->db->escape($data['date_leave']) . "', spouse_name = '" . $this->db->escape($data['spouse_name']) . "', childbirth_hospital = '".$this->db->escape($cbh)."', childbirth_doctor = '" . $this->db->escape($data['childbirth_doctor']) . "', childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "', child_count_g = '" . $this->db->escape($data['child_count_g']) . "', child_count_p = '" . $this->db->escape($data['child_count_p']) . "', pregnancy_weeks = '" . $this->db->escape($data['pregnancy_weeks']) . "' WHERE customer_id = '" . (int)$customer_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child_image WHERE customer_child_id = '" . (int)$customer_child_id . "'");
		
		if (isset($data['child_image'])) {
			$sort_order = array();
	  		foreach ($data['child_image'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $data['child_image']);
		
			foreach ($data['child_image'] as $key => $child_image) {
				if ($key == "0") {
					$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET image = '". $this->db->escape(html_entity_decode($child_image['image'], ENT_QUOTES, 'UTF-8')) ."' WHERE customer_child_id = '". (int)$customer_child_id ."'");
				}
				$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_image SET customer_child_id = '" . (int)$customer_child_id . "', image = '" . $this->db->escape(html_entity_decode($child_image['image'], ENT_QUOTES, 'UTF-8')) . "', image_txt = '". $this->db->escape($child_image['image_txt']) ."', sort_order = '" . (int)$child_image['sort_order'] . "'");
			}
		}
	    	
		/*
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
		if (isset($data['transfer'])) { 
			foreach ($data['transfer'] as $transfer) {
				if ($transfer['customer_transfer_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_transfer SET customer_transfer_id = '" . (int)$transfer['customer_transfer_id'] . "', customer_id = '" . (int)$customer_id . "', customer_room_id = '" . (int)$transfer['customer_room_id'] . "',  date_added = '".$this->db->escape($transfer['date_added'])."',description = '" . $this->db->escape($transfer['description']) . "' ");
				} 
			}
		}
			
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$customer_child_id . "'");
		if (isset($data['child'])) {
      		foreach ($data['child'] as $child) {
				if ($child['child_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_child_id = '" . $this->db->escape($child['child_id']) . "', customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($child['name']) . "', birthdate = '" . $this->db->escape($child['birthdate']) . "', birthweight = '" . $this->db->escape($child['birthweight']) . "', birthhead = '" . $this->db->escape($child['birthhead']) . "', birthlength = '" . $this->db->escape($child['birthlength']) . "', inweight = '" . $this->db->escape($child['inweight']) . "', b_streptococcus_check = '" . $this->db->escape($child['b_streptococcus_check']) . "', apgar_score_1 = '" . $this->db->escape($child['apgar_score_1']) . "', apgar_score_5 = '" . $this->db->escape($child['apgar_score_5']) . "' ");
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($child['name']) . "', birthdate = '" . $this->db->escape($child['birthdate']) . "', birthweight = '" . $this->db->escape($child['birthweight']) . "', birthhead = '" . $this->db->escape($child['birthhead']) . "', birthlength = '" . $this->db->escape($child['birthlength']) . "', inweight = '" . $this->db->escape($child['inweight']) . "', b_streptococcus_check = '" . $this->db->escape($child['b_streptococcus_check']) . "', apgar_score_1 = '" . $this->db->escape($child['apgar_score_1']) . "', apgar_score_5 = '" . $this->db->escape($child['apgar_score_5']) . "' ");
				}
			}
		}
		
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
      	if (isset($data['contact'])) {
      		foreach ($data['contact'] as $contact) {
				if ($contact['contact_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "contact SET contact_id = '" . $this->db->escape($contact['contact_id']) . "', customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "', telephone = '".$this->db->escape($contact['telephone'])."', relationship = '".$this->db->escape($contact['relationship'])."'");
					
					if (isset($contact['default'])) {
						$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact_id = '" . (int)$contact['contact_id'] . "' WHERE customer_id = '" . (int)$customer_id . "'");
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "contact SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "',  telephone = '".$this->db->escape($contact['telephone']). "', relationship = '".$this->db->escape($contact['relationship'])."'");
					
					if (isset($contact['default'])) {
						$contact_id = $this->db->getLastId();
						
						$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact_id = '" . (int)$contact_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
					}
				}
			}
		}
		*/
	}

	public function editToken($customer_child_id, $token) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET token = '" . $this->db->escape($token) . "' WHERE customer_child_id = '" . (int)$customer_child_id . "'");
	}
	
	public function deleteChild($customer_child_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$customer_child_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function getChild($customer_child_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT name FROM " . DB_PREFIX . "customer c WHERE c.customer_id = cc.customer_id) AS customer_name FROM " . DB_PREFIX . "customer_child cc WHERE cc.customer_child_id = '" . (int)$customer_child_id . "'");
	
		return $query->row;
	}
	
	/*
	public function getCustomerByIDNumber($idnumber) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer WHERE idnumber = '" . $this->db->escape($idnumber) . "'");
	
		return $query->row;
	}
	*/
	
	public function getChildName($child_id) {
		$query = $this->db->query("SELECT DISTINCT name AS child_name FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$child_id . "'");
	
		return $query->row['child_name'];
	}
	
	public function getChildGender($child_id) {
		$query = $this->db->query("SELECT DISTINCT gender AS child_gender FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$child_id . "'");
	
		return $query->row['child_gender'];
	}
	
	public function getChildDataTable($customer_child_id) {
		$query = $this->db->query("SELECT DISTINCT *, 
		c.name AS name, c.birthdate AS birthdate, 
		cu.name AS customer_name
		FROM " . DB_PREFIX . "customer_child c LEFT JOIN customer cu ON (cu.customer_id = c.customer_id) WHERE customer_child_id = '" . (int)$customer_child_id . "'");
	
		return $query->row;
	}
	
	public function getChildBodyRecord($customer_child_id, $date) {
		$query_t = $this->db->query("SELECT chk1 AS temperature, CONCAT(date_added, arrangement) AS temperature_chkdate FROM " . DB_PREFIX . "child_nurse3b WHERE customer_child_id = '". (int)$customer_child_id ."' AND date_added <= '". $this->db->escape($date) ."' AND chk1 != '' ORDER BY date_added DESC, child_nurse3b_id DESC ");
		
		$query_j = $this->db->query("SELECT chk13 AS jaundice, CONCAT(date_added, arrangement) AS jaundice_chkdate FROM " . DB_PREFIX . "child_nurse3b WHERE customer_child_id = '". (int)$customer_child_id ."' AND date_added <= '". $this->db->escape($date) ."' AND DATEDIFF(CURRENT_DATE(), date_added) <= 10 AND chk13 != '' ORDER BY date_added DESC, child_nurse3b_id DESC ");

		$query_w = $this->db->query("SELECT chk10 AS weight, CONCAT(date_added, arrangement) AS weight_chkdate FROM " . DB_PREFIX . "child_nurse3b WHERE customer_child_id = '". (int)$customer_child_id ."' AND date_added <= '". $this->db->escape($date) ."' AND chk10 != '' ORDER BY date_added DESC, child_nurse3b_id DESC ");
		
		$a = array();
		
		$a = array(
			'temperature'	=> (!empty($query_t->row)) ? $query_t->row['temperature'] : '',
			'temperature_chkdate'	=> (!empty($query_t->row)) ? $query_t->row['temperature_chkdate'] : '',
			'jaundice'	=> (!empty($query_j->row)) ? $query_j->row['jaundice'] : '',
			'jaundice_chkdate'	=> (!empty($query_j->row)) ? $query_j->row['jaundice_chkdate'] : '',
			'weight'	=> (!empty($query_w->row)) ? $query_w->row['weight'] : '',
			'weight_chkdate'	=> (!empty($query_w->row)) ? $query_w->row['weight_chkdate'] : ''
		);

		return $a;
	}
	
	public function checkIDNumber($roc_id) {
			$id_head = array(
			'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 
			'F' => 15, 'G' => 16, 'H' => 17, 'J' => 18, 'K' => 19, 
			'L' => 20, 'M' => 21, 'N' => 22, 'P' => 23, 'Q' => 24, 
			'R' => 25, 'S' => 26, 'T' => 27, 'U' => 28, 'V' => 29, 
			'W' => 30, 'X' => 31, 'Y' => 32, 'Z' => 33, 'I' => 34, 
			'O' => 35); 

			$n0 = $id_head[strtoupper(substr($roc_id, 0, 1))]; 
			$n[] = '0'; 
			$n[] = substr($n0, 0, 1); 
			$n[] = substr($n0, 1, 1); 

			for ($lop1=1; $lop1<strlen($roc_id); $lop1++) { 
			$n[] = substr($roc_id, $lop1, 1); 
			}

			return (
			($n[1] + ($n[2]*9) + ($n[3]* 8)+ ($n[4]*7) + ($n[5]*6) + 
			($n[6]*5) + ($n[7]*4) + ($n[8]*3) + ($n[9]*2) + $n[10] + 
			$n[11]) % 10); 
	}
			
	public function getChilds($data = array()) {
		$sql = "SELECT c.*, cu.name AS customer_name, cu.date_leave AS customer_date_leave FROM " . DB_PREFIX . "customer_child c LEFT JOIN ". DB_PREFIX . "customer cu ON (c.customer_id = cu.customer_id) ";

		$implode = array();
		
		if (!empty($data['filter_name'])) {
			$implode[] = "LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (!empty($data['filter_customer_name'])) {
			$implode[] = "LCASE(cu.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_customer_name'])) . "%'";
		}
		
		if (!empty($data['filter_birthdate'])) {
			$implode[] = "DATE(c.birthdate) = DATE('" . $this->db->escape($data['filter_birthdate']) . "')";
		}
		
		if (!empty($data['filter_date_leave'])) {
			$implode[] = " ( DATE(c.date_leave) >= DATE('" . $this->db->escape($data['filter_date_leave']) . "') OR DATE(cu.date_leave) >= DATE('" . $this->db->escape($data['filter_date_leave']) . "') )";
		} /*else {
			$implode[] = "DATE(c.date_leave) >= DATE(NOW()) OR DATE(cu.date_leave) >= DATE(NOW()) ";
		}*/
		
		if (!empty($data['filter_date_livein'])) {
			$implode[] = " DATE(cu.date_added) <= DATE('" . $this->db->escape($data['filter_date_livein']) . "') ";
		} 
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			//'c.customer_child_id',
			'c.name',
			'c.birthdate',
			'c.date_leave',
			'c.bed_id',
			'cu.name'
			//'customer_date_leave'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
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
	
	public function getTotalChilds($data = array()) {
      	//$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child ";
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child c LEFT JOIN ". DB_PREFIX . "customer cu ON (c.customer_id = cu.customer_id) ";
		
		$implode = array();
		
		if (!empty($data['filter_name'])) {
			$implode[] = "LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (!empty($data['filter_customer_name'])) {
			$implode[] = "LCASE(cu.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_customer_name'])) . "%'";
		}
		
		if (!empty($data['filter_birthdate'])) {
			$implode[] = "DATE(c.birthdate) = DATE('" . $this->db->escape($data['filter_birthdate']) . "')";
		}
		
		if (!empty($data['filter_date_leave'])) {
			$implode[] = " ( DATE(c.date_leave) >= DATE('" . $this->db->escape($data['filter_date_leave']) . "') OR DATE(cu.date_leave) >= DATE('" . $this->db->escape($data['filter_date_leave']) . "') )";
		} /*else {
			$implode[] = "DATE(c.date_leave) >= DATE(NOW()) OR DATE(cu.date_leave) >= DATE(NOW()) ";
		}*/
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
	}

	public function getChildImages($customer_child_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_child_image WHERE customer_child_id = '" . (int)$customer_child_id . "' ORDER BY sort_order, child_image_id");
		
		return $query->rows;
	}
	
	public function getCustomerLastRoom($customer_id) {
		$query = $this->db->query("SELECT ct.date_added AS customer_transfer_lastdate, cr.name AS customer_lastroom FROM " . DB_PREFIX . "customer_transfer ct LEFT JOIN ".DB_PREFIX." customer_room cr ON (cr.customer_room_id = ct.customer_room_id) WHERE ct.customer_id = '" . (int)$customer_id . "' ORDER BY ct.date_added DESC  LIMIT 1 ");
	
		return $query->rows;
	}	
	
	public function getCustomerFirstRoom($customer_id) {
		$query = $this->db->query("SELECT ct.date_added AS customer_transfer_firstdate, cr.name AS customer_firstroom FROM " . DB_PREFIX . "customer_transfer ct LEFT JOIN ".DB_PREFIX." customer_room cr ON (cr.customer_room_id = ct.customer_room_id) WHERE ct.customer_id = '" . (int)$customer_id . "' ORDER BY ct.date_added ASC  LIMIT 1 ");
	
		return  $query->rows;
	}	
	
	/*
	public function getContact($contact_id) {
		$contact_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "contact WHERE contact_id = '" . (int)$contact_id . "'");

		if ($contact_query->num_rows) {	
			return array(
				'contact_id'     => $contact_query->row['contact_id'],
				'customer_id'    => $contact_query->row['customer_id'],
				'name'       => $contact_query->row['name'],
				'telephone'      => $contact_query->row['telephone'],
				'relationship'      => $contact_query->row['relationship']
			);
		}
	}
	
	public function getContacts($customer_id) {
		$contact_data = array();
		
		$query = $this->db->query("SELECT contact_id FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
	
		foreach ($query->rows as $result) {
			$contact_info = $this->getContact($result['contact_id']);
		
			if ($contact_info) {
				$contact_data[] = $contact_info;
			}
		}		
		
		return $contact_data;
	}	
	
	public function getChild($child_id) {
		$child_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$child_id . "'");

		if ($child_query->num_rows) {	
			return array(
				'child_id'     => $child_query->row['customer_child_id'],
				'customer_id'    => $child_query->row['customer_id'],
				'name'       => $child_query->row['name'],
				'birthdate'       => $child_query->row['birthdate'],
				'birthweight'       => $child_query->row['birthweight'],
				'birthhead'       => $child_query->row['birthhead'],
				'birthlength'       => $child_query->row['birthlength'],
				'inweight'       => $child_query->row['inweight'],
				'b_streptococcus_check'       => $child_query->row['b_streptococcus_check'],
				'apgar_score_1'       => $child_query->row['apgar_score_1'],
				'apgar_score_5'       => $child_query->row['apgar_score_5']
			);
		}
	}
	
	public function getChilds($customer_id) {
		$child_data = array();
		
		$query = $this->db->query("SELECT customer_child_id FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
	
		foreach ($query->rows as $result) {
			$child_info = $this->getChild($result['customer_child_id']);
		
			if ($child_info) {
				$child_data[] = $child_info;
			}
		}		
		
		return $child_data;
	}	
	*/

	/*
	public function getTotalContactsByCustomerId($customer_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalChildsByCustomerId($customer_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row['total'];
	}
	*/
		
	/*
	public function addTransfer($customer_id, $description = '', $customer_room_id = '') {
		$customer_info = $this->getCustomer($customer_id);
		
		if ($customer_info) { 
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_transfer SET customer_id = '" . (int)$customer_id . "', customer_room_id = '" . $this->db->escape($customer_room_id)  . "', description = '" . $this->db->escape($description) . "', date_added = NOW()");
		}
	}
	
	public function deleteTransfer($customer_transfer_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_transfer_id = '" . (int)$customer_transfer_id . "'");
	}
	*/
	
	public function getTransfers($customer_id, $order="ASC", $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT *, cr.name as customer_room_name FROM " . DB_PREFIX . "customer_transfer ct LEFT JOIN ".DB_PREFIX." customer_room cr ON (ct.customer_room_id = cr.customer_room_id) WHERE customer_id = '" . (int)$customer_id . "' ORDER BY customer_transfer_id ".$order." LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}

	public function getTotalTransfers($customer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total  FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
	
		return $query->row['total'];
	}
	
	public function getChildBed($bed_id) {
		$query = $this->db->query("SELECT name  FROM " . DB_PREFIX . "customer_child_bed WHERE bed_id = '" . (int)$bed_id . "'");
	
		return $query->row['name'];
	}
	
	public function getTotalChildsByChildBedId($child_bed_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child WHERE bed_id = '" . (int)$child_bed_id . "'");
		
		return $query->row['total'];
	}
			
}
?>