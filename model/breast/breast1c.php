<?php
class ModelBreastBreast1c extends Model {
	public function addBreast1c($data) {		
		
		if (isset($data['breast1cform'])) {		
			//$this->db->query("DELETE FROM " . DB_PREFIX . "customer_breast1c WHERE customer_id = '" . (int)$this->request->get['customer_id'] . "'");
			
			/*
			$totaldata = $this->getBreast1cs((int)$this->request->get['customer_id']);
			
			$sid = array();
			foreach ($data['breast1cform'] as $data_breast1c) {
				$sid[] = $data_breast1c['customer_breast1c_id'];
			}
			
			foreach ($totaldata as $ttdt ) {
				if ( ! in_array($ttdt['customer_breast1c_id'], $sid) ) {
					$this->db->query("DELETE FROM " . DB_PREFIX . "customer_breast1c WHERE customer_breast1c_id = '". (int)$ttdt['customer_breast1c_id'] ."' AND customer_id = '" . (int)$this->request->get['customer_id'] . "'");
				}
			}
			*/
		
      		foreach ($data['breast1cform'] as $data_breast1c) {	
			
				for ($i=1;$i<=20;$i++) {
					if (!isset($data_breast1c['chk'.$i.''])) { $data_breast1c['chk'.$i.''] = ''; }
				}
		
		/*
				if (!isset($data_breast1c['chk27a'])) { $data_breast1c['chk27a'] = ''; }
				if (!isset($data_breast1c['chk27b'])) { $data_breast1c['chk27b'] = ''; }
				if (isset($data_breast1c['chk37a']) AND $data_breast1c['chk37a']<>'') { 
					$c37adatetime = $data_breast1c['date_added']." ".$data_breast1c['chk37a'];
				} else {
					$data_breast1c['chk37a'] = ''; $c37adatetime = '';
				}
				if (isset($data_breast1c['chk37b']) AND $data_breast1c['chk37b']<>'') { 
					print $c37bdatetime = $data_breast1c['date_added']." ".$data_breast1c['chk37b'];
				} else {
					$data_breast1c['chk37b'] = ''; $c37bdatetime = '';
				}
				
				for ($i=28;$i<=36;$i++) {
					if (!isset($data_breast1c['chk'.$i.''])) { $data_breast1c['chk'.$i.''] = ''; }
				}
				for ($i=38;$i<=42;$i++) {
					if (!isset($data_breast1c['chk'.$i.''])) { $data_breast1c['chk'.$i.''] = ''; }
				}
		*/
				
				//$data_breast1c_days_afterbirth = ($data_breast1c['days_afterbirth'] == '') ? 'NULL' : "'".(int)$data_breast1c['days_afterbirth']."'"; 
				//$data_breast1c_days_livein = ($data_breast1c['days_livein'] == '') ? 'NULL' : "'".(int)$data_breast1c['days_livein']."'"; 
				//$data_breast1c_chk24 = ($data_breast1c['chk24'] == '') ? 'NULL' : "'".(float)$data_breast1c['chk24']."'"; 
				//$data_breast1c_chk25 = ($data_breast1c['chk25'] == '') ? 'NULL' : "'".(int)$data_breast1c['chk25']."'"; 
				//$data_breast1c_chk26 = ($data_breast1c['chk26'] == '') ? 'NULL' : "'".(int)$data_breast1c['chk26']."'"; 
				//$data_breast1c_chk27a = ($data_breast1c['chk27a'] == '') ? 'NULL' : "'".(int)$data_breast1c['chk27a']."'"; 
				//$data_breast1c_chk27b = ($data_breast1c['chk27b'] == '') ? 'NULL' : "'".(int)$data_breast1c['chk27b']."'"; 
			
				if ($data_breast1c['customer_breast1c_id']<>'') {
					$this->db->query("UPDATE " . DB_PREFIX . "customer_breast1c SET nurse_id = '".(int)$data_breast1c['nurse_id']."', chk1 = '" . $this->db->escape($data_breast1c['chk1']) . "', chk2 = '" . $this->db->escape($data_breast1c['chk2']) . "', chk3 = '" . $this->db->escape($data_breast1c['chk3']) . "', chk4 = '" . $this->db->escape($data_breast1c['chk4']) . "', chk5 = '" . $this->db->escape($data_breast1c['chk5']) . "', chk6 = '" . $this->db->escape($data_breast1c['chk6']) . "', chk7 = '" . $this->db->escape($data_breast1c['chk7']) . "', chk8 = '" . $this->db->escape($data_breast1c['chk8']) . "', chk9 = '" . $this->db->escape($data_breast1c['chk9']) . "', chk10 = '" . $this->db->escape($data_breast1c['chk10']) . "', chk11 = '" . $this->db->escape($data_breast1c['chk11']) . "', chk12 = '" . $this->db->escape($data_breast1c['chk12']) . "', chk13 = '" . $this->db->escape($data_breast1c['chk13']) . "', chk14 = '" . $this->db->escape($data_breast1c['chk14']) . "', chk15 = '" . $this->db->escape($data_breast1c['chk15']) . "', chk16 = '" . $this->db->escape($data_breast1c['chk16']) . "', chk17 = '" . $this->db->escape($data_breast1c['chk17']) . "', chk18 = '" . $this->db->escape($data_breast1c['chk18']) . "', chk19 = '" . $this->db->escape($data_breast1c['chk19']) . "', chk20 = '" . $this->db->escape($data_breast1c['chk20']) . "', date_added = '".$this->db->escape($data_breast1c['date_added']). "', date_modify = NOW() WHERE customer_breast1c_id = '". (int)$data_breast1c['customer_breast1c_id'] ."' AND customer_id = '" . (int)$this->request->get['customer_id'] . "'");
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_breast1c SET customer_id = '" . (int)$this->request->get['customer_id'] . "', nurse_id = '".(int)$data_breast1c['nurse_id']."', chk1 = '" . $this->db->escape($data_breast1c['chk1']) . "', chk2 = '" . $this->db->escape($data_breast1c['chk2']) . "', chk3 = '" . $this->db->escape($data_breast1c['chk3']) . "', chk4 = '" . $this->db->escape($data_breast1c['chk4']) . "', chk5 = '" . $this->db->escape($data_breast1c['chk5']) . "', chk6 = '" . $this->db->escape($data_breast1c['chk6']) . "', chk7 = '" . $this->db->escape($data_breast1c['chk7']) . "', chk8 = '" . $this->db->escape($data_breast1c['chk8']) . "', chk9 = '" . $this->db->escape($data_breast1c['chk9']) . "', chk10 = '" . $this->db->escape($data_breast1c['chk10']) . "', chk11 = '" . $this->db->escape($data_breast1c['chk11']) . "', chk12 = '" . $this->db->escape($data_breast1c['chk12']) . "', chk13 = '" . $this->db->escape($data_breast1c['chk13']) . "', chk14 = '" . $this->db->escape($data_breast1c['chk14']) . "', chk15 = '" . $this->db->escape($data_breast1c['chk15']) . "', chk16 = '" . $this->db->escape($data_breast1c['chk16']) . "', chk17 = '" . $this->db->escape($data_breast1c['chk17']) . "', chk18 = '" . $this->db->escape($data_breast1c['chk18']) . "', chk19 = '" . $this->db->escape($data_breast1c['chk19']) . "', chk20 = '" . $this->db->escape($data_breast1c['chk20']) . "', date_added = '".$this->db->escape($data_breast1c['date_added']). "', date_modify = NOW() ");
				}
			}
		}
		
		//$this->db->query("INSERT INTO " . DB_PREFIX . "customer_breast1c SET customer_id = '".(int)$this->request->get['customer_id']."', nurse_id = '".(int)$data_breast1c['nurse_id']."',  chk1 = '" . $this->db->escape($data_breast1c['chk1']) . "', chk2 = '".$this->db->escape($data_breast1c['chk2'])."', chk3 = '" . $this->db->escape($data_breast1c['chk3']) . "', chk4 = '" . $this->db->escape($data_breast1c['chk4']) . "',  chk5 = '".$this->db->escape($data_breast1c['chk5'])."', chk6 = '".$this->db->escape($data_breast1c['chk6'])."' , chk7 = '" . $this->db->escape($data_breast1c['chk7']) . "', chk1_score = '" . (int)$data_breast1c['chk1_score'] . "', chk2_score = '" . (int)$data_breast1c['chk2_score'] . "', chk3_score = '" . (int)$data_breast1c['chk3_score'] . "', chk4_score = '" . (int)$data_breast1c['chk4_score'] . "', chk5_score = '" . (int)$data_breast1c['chk5_score'] . "', chk6_score = '" . (int)$data_breast1c['chk6_score'] . "', chk7_score = '" . (int)$data_breast1c['chk7_score'] . "',  date_added = NOW() ");
	}
	
	public function editBreast1c($customer_breast1c_id, $data) {		//其實沒在用
		$totalscore = 0;
		for ($i=1;$i<=7;$i++) {
			if (!isset($data['chk'.$i.''])) { $data['chk'.$i.''] = ''; }
			if (!isset($data['chk'.$i.'_score'])) { $data['chk'.$i.'_score'] = ''; }
			$totalscore += (int)$data['chk'.$i.'_score'];
		}
		
		$score_total = ($data['score_total']=='' OR $data['score_total']!=$totalscore) ? $totalscore  : $data['score_total']  ;
				
		$this->db->query("UPDATE " . DB_PREFIX . "customer_breast1c SET nurse_id = '".(int)$data['nurse_id']."', score_total = '".(int)$score_total."', chk1 = '" . $this->db->escape($data['chk1']) . "', chk2 = '".$this->db->escape($data['chk2'])."', chk3 = '" . $this->db->escape($data['chk3']) . "', chk4 = '" . $this->db->escape($data['chk4']) . "',  chk5 = '".$this->db->escape($data['chk5'])."', chk6 = '".$this->db->escape($data['chk6'])."' , chk7 = '" . $this->db->escape($data['chk7']) . "', chk1_score = '" . (int)$data['chk1_score'] . "', chk2_score = '" . (int)$data['chk2_score'] . "', chk3_score = '" . (int)$data['chk3_score'] . "', chk4_score = '" . (int)$data['chk4_score'] . "', chk5_score = '" . (int)$data['chk5_score'] . "', chk6_score = '" . (int)$data['chk6_score'] . "', chk7_score = '" . (int)$data['chk7_score'] . "',  date_modify = NOW() WHERE customer_breast1c_id = '".(int)$customer_breast1c_id."'");
	}

	public function editToken($customer_child_id, $token) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET token = '" . $this->db->escape($token) . "' WHERE customer_child_id = '" . (int)$customer_child_id . "'");
	}
	
	public function deleteBreast1c($customer_id,$id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_breast1c WHERE customer_id = '" . (int)$customer_id . "' AND customer_breast1c_id = '" . (int)$id . "' ");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function getBreast1cs($customer_id, $user_id = 0) {
		if ($user_id) {
			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_breast1c WHERE customer_id = '" . (int)$customer_id . "' AND nurse_id = '". (int)$user_id. "' ORDER BY date_added");
		} else {
			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_breast1c WHERE customer_id = '" . (int)$customer_id . "' ORDER BY date_added");
		}
	
		return $query->rows;
	}
	
	public function getBreast1c($customer_id, $customer_breast1c_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_breast1c WHERE customer_id = '" . (int)$customer_id . "' AND customer_breast1c_id = '". (int)$customer_breast1c_id ."'");
	
		return $query->row;
	}
	
	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT DISTINCT *, name AS customer_name, birthdate AS customer_birthdate FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
	
		return $query->row;
	}

	public function getChildDataTable($customer_child_id) {
		$query = $this->db->query("SELECT DISTINCT *, 
		c.name AS name, c.birthdate AS birthdate, 
		cu.name AS customer_name
		FROM " . DB_PREFIX . "customer_child c LEFT JOIN customer cu ON (cu.customer_id = c.customer_id) WHERE customer_child_id = '" . (int)$customer_child_id . "'");
	
		return $query->row;
	}
	
	public function getDataTables($customer_id) {
		$datatables = array();
	
		$query = $this->db->query("SELECT customer_child_id FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
	
		foreach ($query->rows as $result) {
			$datatable = $this->getChildDataTable($result['customer_child_id']);
				
			if ($datatable) {
				$datatables[] = $datatable;
			}
		}	

		return $datatables;
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
		$sql = "SELECT c.*, cu.name AS customer_name FROM " . DB_PREFIX . "customer_child c LEFT JOIN ". DB_PREFIX . "customer cu ON (c.customer_id = cu.customer_id) ";

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
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'c.name',
			'c.birthdate',
			'cu.name'
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
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
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
	
			
}
?>