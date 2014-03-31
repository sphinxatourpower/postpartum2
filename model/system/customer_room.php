<?php
class ModelSystemCustomerRoom extends Model {
	public function addCustomerRoom($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_room SET name = '" . $this->db->escape($data['name']) . "', floor = '" . $this->db->escape($data['floor']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		
		$customer_room_id = $this->db->getLastId(); 
		
		if ($data['price']) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_room SET price = '" . (int)$data['price'] . "' WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		}
	}
	
	public function editCustomerRoom($customer_room_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_room SET name = '" . $this->db->escape($data['name']) . "', floor = '" . $this->db->escape($data['floor']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		
		if ($data['price']) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_room SET price = '" . (int)$data['price'] . "' WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_room SET price = NULL WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		}
	}
	
	public function deleteCustomerRoom($customer_room_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_room WHERE customer_room_id = '" . (int)$customer_room_id . "'");
	}
	
	public function getCustomerRoom($customer_room_id) {
		//$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_room cg LEFT JOIN " . DB_PREFIX . "customer_room_description cgd ON (cg.customer_room_id = cgd.customer_room_id) WHERE cg.customer_room_id = '" . (int)$customer_room_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_room cg WHERE cg.customer_room_id = '" . (int)$customer_room_id . "' ");
		
		return $query->row;
	}
	
	public function getCustomerRooms($data = array()) {
		//$sql = "SELECT * FROM " . DB_PREFIX . "customer_room cg LEFT JOIN " . DB_PREFIX . "customer_room_description cgd ON (cg.customer_room_id = cgd.customer_room_id) WHERE cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_room cg ";
		
		$sort_data = array(
			'cg.sort_order',
			'cg.name'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY cg.sort_order, cg.name";	
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
	
	public function getCustomerRoomDescriptions($customer_room_id) {
		$customer_group_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_room_description WHERE customer_room_id = '" . (int)$customer_room_id . "'");
				
		foreach ($query->rows as $result) {
			$customer_group_data[$result['language_id']] = array(
				'name'        => $result['name'],
				'description' => $result['description']
			);
		}
		
		return $customer_group_data;
	}
		
	public function getTotalCustomerRooms() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_room");
		
		return $query->row['total'];
	}
	
	public function getRoomStatus($room_id) {
		$query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "customer WHERE customer_room_id = '".$room_id."' AND ( ( CURRENT_DATE() BETWEEN DATE(date_added) AND DATE(date_leave) ) OR (CURRENT_DATE() >= DATE(date_added) AND DATE(date_leave) = '0000-00-00' ) ) AND status = '1' ");
		
		if ($query->num_rows) {
			return $query->row['customer_id'];
		} else {
			return false;
		}
	}
}
?>