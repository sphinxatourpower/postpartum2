<?php
class ModelServiceSatisfaction extends Model {
	public function addSatisfaction($data) {
		$addchkdata = '';
		for ($i=1;$i<=15;$i++) {
			if (!isset($data['chk'.$i])) { $data['chk'.$i] = ''; }
		}
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_satisfaction SET customer_id = '". (int)$data['customer_id'] . "', date_added = '".$this->db->escape($data['date_added'])."', chk1 = '". (int)$data['chk1'] ."', chk2 = '". (int)$data['chk2'] ."', chk3 = '". (int)$data['chk3'] ."', chk4 = '". (int)$data['chk4'] ."', chk5 = '". (int)$data['chk5'] ."', chk6 = '". (int)$data['chk6'] ."', chk7 = '". (int)$data['chk7'] ."', chk8 = '". (int)$data['chk8'] ."', chk9 = '". (int)$data['chk9'] ."', chk10 = '". (int)$data['chk10'] ."', chk11 = '". (int)$data['chk11'] ."', chk12 = '". (int)$data['chk12'] ."', chk13 = '". (int)$data['chk13'] ."', chk14 = '". (int)$data['chk14'] ."', chk15 = '". (int)$data['chk15'] ."', text1 = '" . $this->db->escape($data['text1']) . "', text2 = '".$this->db->escape($data['text2'])."', text3 = '" . $this->db->escape($data['text3']) . "', text4 = '" . $this->db->escape($data['text4']) . "', text5 = '". $this->db->escape($data['text5'])."', good1 = '" . $this->db->escape($data['good1']) . "', good2 = '" . $this->db->escape($data['good2']) . "', good3 = '" . $this->db->escape($data['good3']) . "', date_modify = NOW() ");
	}
	
	public function editSatisfaction($customer_satisfaction_id, $data) {	
		for ($i=1;$i<=15;$i++) {
			if (!isset($data['chk'.$i])) { $data['chk'.$i] = ''; }
		}
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer_satisfaction SET customer_id = '". (int)$data['customer_id'] . "', date_added = '".$this->db->escape($data['date_added'])."', chk1 = '". (int)$data['chk1'] ."', chk2 = '". (int)$data['chk2'] ."', chk3 = '". (int)$data['chk3'] ."', chk4 = '". (int)$data['chk4'] ."', chk5 = '". (int)$data['chk5'] ."', chk6 = '". (int)$data['chk6'] ."', chk7 = '". (int)$data['chk7'] ."', chk8 = '". (int)$data['chk8'] ."', chk9 = '". (int)$data['chk9'] ."', chk10 = '". (int)$data['chk10'] ."', chk11 = '". (int)$data['chk11'] ."', chk12 = '". (int)$data['chk12'] ."', chk13 = '". (int)$data['chk13'] ."', chk14 = '". (int)$data['chk14'] ."', chk15 = '". (int)$data['chk15'] ."', text1 = '" . $this->db->escape($data['text1']) . "', text2 = '".$this->db->escape($data['text2'])."', text3 = '" . $this->db->escape($data['text3']) . "', text4 = '" . $this->db->escape($data['text4']) . "', text5 = '". $this->db->escape($data['text5'])."', good1 = '" . $this->db->escape($data['good1']) . "', good2 = '" . $this->db->escape($data['good2']) . "', good3 = '" . $this->db->escape($data['good3']) . "', date_modify = NOW() WHERE customer_satisfaction_id = '" . (int)$customer_satisfaction_id . "'");
	}

	public function editToken($customer_id, $token) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = '" . $this->db->escape($token) . "' WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function deleteSatisfaction($customer_satisfaction_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_satisfaction WHERE customer_satisfaction_id = '" . (int)$customer_satisfaction_id . "'");
	}
	
	public function getSatisfaction($customer_satisfaction_id) {
		$query = $this->db->query("SELECT DISTINCT cs.*, c.name AS customer, cr.name AS customer_room FROM " . DB_PREFIX . "customer_satisfaction cs 
		LEFT JOIN " . DB_PREFIX . "customer c ON (c.customer_id = cs.customer_id) 
		LEFT JOIN " . DB_PREFIX . "customer_room cr ON (cr.customer_room_id = c.customer_room_id)
		WHERE cs.customer_satisfaction_id = '" . (int)$customer_satisfaction_id . "'");
	
		return $query->row;
	}
	
	public function getCustomerName($customer_id) {
		$query = $this->db->query("SELECT DISTINCT name as customer_name FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
	
		return $query->row['customer_name'];
	}
	
	public function getCustomerByIDNumber($idnumber) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer WHERE idnumber = '" . $this->db->escape($idnumber) . "'");
	
		return $query->row;
	}
	
	public function isROCID($id){
			$id = strtoupper($id);
			//建立字母分數陣列
			$headPoint = array(
				'A'=>1,'I'=>39,'O'=>48,'B'=>10,'C'=>19,'D'=>28,
				'E'=>37,'F'=>46,'G'=>55,'H'=>64,'J'=>73,'K'=>82,
				'L'=>2,'M'=>11,'N'=>20,'P'=>29,'Q'=>38,'R'=>47,
				'S'=>56,'T'=>65,'U'=>74,'V'=>83,'W'=>21,'X'=>3,
				'Y'=>12,'Z'=>30
			);
			//建立加權基數陣列
			$multiply = array(8,7,6,5,4,3,2,1);
			//檢查身份字格式是否正確
			if (preg_match("/[A-Za-z][1-2]\d{8}/",$id) AND strlen($id) == 10){
				//切開字串
				$len = strlen($id);
				for($i=0; $i<$len; $i++){
					$stringArray[$i] = substr($id,$i,1);
				}
				//取得字母分數
				$total = $headPoint[array_shift($stringArray)];
				//取得比對碼
				$point = array_pop($stringArray);
				//取得數字分數
				$len = count($stringArray);
				for($j=0; $j<$len; $j++){
					$total += $stringArray[$j]*$multiply[$j];
				}
				//計算餘數碼並比對
				$last = (($total%10) == 0 )?0:(10-($total%10));
				if ($last != $point) {
					return false;
				} else {
					return true;
				}
			}  else {
			   return false;
			}
	}
			
	public function getSatisfactions($data = array()) {
		//$sql = "SELECT *, CONCAT(c.lastname, c.firstname) AS name, cg.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id)";
		$sql = "SELECT cs.customer_satisfaction_id, cs.date_added as date_written, c.*, cu.name AS service FROM " . DB_PREFIX . "customer_satisfaction cs LEFT JOIN ". DB_PREFIX . "customer c ON (c.customer_id = cs.customer_id) LEFT JOIN ". DB_PREFIX . "user cu ON (c.service_id = cu.user_id) ";

		$implode = array();
		
		if (!empty($data['filter_date_written'])) {
			$implode[] = "DATE(cs.date_added) = DATE('" . $this->db->escape($data['filter_date_written']) . "')";
		}
		
		if (!empty($data['filter_name'])) {
			$implode[] = "LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (!empty($data['filter_room_id'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer WHERE customer_room_id = '" . $this->db->escape($data['filter_room_id']) . "')";
		}
				
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
				
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if (!empty($data['filter_date_leave'])) {
			$implode[] = "DATE(c.date_leave) = DATE('" . $this->db->escape($data['filter_date_leave']) . "')";
		}
		
		if (!empty($data['filter_service_id'])) {
			$implode[] = "cu.user_id = '" . (int)$data['filter_service_id'] . "'";
		}	
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'cs.date_added',
			'name',
			'room',
			'customer_room_id',
			'c.status',
			'c.showathome',
			'c.date_added',
			'c.date_leave',
			'service',
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY status DESC, name ";	
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
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->rows;
	}	
	
	public function getContactids($customer_id) {
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
				'gender'       => $child_query->row['gender'],
				'birthdate'       => $child_query->row['birthdate'],
				'birthweight'       => $child_query->row['birthweight'],
				'birthhead'       => $child_query->row['birthhead'],
				'birthlength'       => $child_query->row['birthlength'],
				'inweight'       => $child_query->row['inweight'],
				'inlength'       => $child_query->row['inlength'],
				'b_streptococcus_check'       => $child_query->row['b_streptococcus_check'],
				'apgar_score_1'       => $child_query->row['apgar_score_1'],
				'apgar_score_5'       => $child_query->row['apgar_score_5'],
				'image'				=> $child_query->row['image'],
				'date_leave'       => $child_query->row['date_leave'],
				'bed_id'       => $child_query->row['bed_id']
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
				
	public function getTotalSatisfactions($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_satisfaction cs LEFT JOIN ". DB_PREFIX . "customer c ON (c.customer_id = cs.customer_id) LEFT JOIN ". DB_PREFIX . "user cu ON (c.service_id = cu.user_id) ";
		
		$implode = array();
		
		if (!empty($data['filter_date_written'])) {
			$implode[] = "DATE(cs.date_added) = DATE('" . $this->db->escape($data['filter_date_written']) . "')";
		}
		
		if (!empty($data['filter_name'])) {
			$implode[] = "LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		if (!empty($data['filter_room_id'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer_transfer WHERE customer_room_id = '" . $this->db->escape($data['filter_room_id']) . "')";
		}
	
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
				
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if (!empty($data['filter_date_leave'])) {
			$implode[] = "DATE(c.date_leave) = DATE('" . $this->db->escape($data['filter_date_leave']) . "')";
		}
		
		if (!empty($data['filter_service_id'])) {
			$implode[] = "cu.user_id = '" . (int)$data['filter_service_id'] . "'";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
	}

	public function getTotalContactsByCustomerId($customer_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalChildsByCustomerId($customer_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row['total'];
	}
			
	public function addTransfer($customer_id, $description = '', $customer_room_id = '') {
		$customer_info = $this->getCustomer($customer_id);
		
		if ($customer_info) { 
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_transfer SET customer_id = '" . (int)$customer_id . "', customer_room_id = '" . $this->db->escape($customer_room_id)  . "', description = '" . $this->db->escape($description) . "', date_added = NOW()");
		}
	}
	
	public function deleteTransfer($customer_id, $customer_transfer_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '". (int)$customer_id ."' AND customer_transfer_id = '" . (int)$customer_transfer_id . "'");
	}
	
	public function getTransfers($customer_id, $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT *, cr.name AS customer_room_name FROM " . DB_PREFIX . "customer_transfer ct LEFT JOIN ".DB_PREFIX." customer_room cr ON (ct.customer_room_id = cr.customer_room_id) WHERE customer_id = '" . (int)$customer_id . "' ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}
	
	public function getLastTransfer($customer_id) {
		$query = $this->db->query("SELECT cr.name AS customer_room_name FROM " . DB_PREFIX . "customer c LEFT JOIN ".DB_PREFIX." customer_room cr ON (c.customer_room_id = cr.customer_room_id) WHERE customer_id = '" . (int)$customer_id . "'");
	
		foreach ($query->rows as $r) {
			if (!empty($r)) {
				return $r['customer_room_name'];
			} else {
				return null;
			}
		}
	}

	public function getTotalTransfers($customer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total  FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
	
		return $query->row['total'];
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
			
}
?>