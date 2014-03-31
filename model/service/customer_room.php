<?php
class ModelServiceCustomerRoom extends Model {
	public function addCustomerRoom($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_room SET name = '" . $this->db->escape($data['name']) . "'");
	}
	
	public function editCustomerRoom($customer_room_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_room SET name = '" . $this->db->escape($data['name']) . "' WHERE customer_room_id = '" . (int)$customer_room_id . "'");
	}
	
	public function deleteCustomerRoom($customer_room_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_room WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE customer_group_id = '" . (int)$customer_group_id . "'");
	}
	
	public function getCustomerRoom($customer_room_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_room WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		
		return $query->row;
	}
	
	public function getCustomerRoomName($customer_room_id) {
		$query = $this->db->query("SELECT DISTINCT name FROM " . DB_PREFIX . "customer_room WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		
		return $query->row['name'];
	}
	
	public function getCustomerOcuRooms() {
		$sql = "SELECT cr.name FROM customer_room cr LEFT JOIN customer c ON (cr.customer_room_id = c.customer_room_id) WHERE c.date_added < NOW() AND c.date_leave > NOW() AND c.status='1'";
		
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	public function getCustomerEmptyRooms($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_room";
		
		$sql .= " ORDER BY name";	
		
		$ocuinfo = array();
		$ocurooms = $this->getCustomerOcuRooms();
		foreach ($ocurooms as $k => $ocu) {
			$ocuinfo[] = $ocu['name'];
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
		
		$emptyroom = array();
		foreach ($query->rows as $rows) {
			if (!in_array($rows['name'], $ocuinfo)) {
				$emptyroom[] = $rows;
			}
		}
		
		return $emptyroom;
	}
	
	public function getCustomerRooms($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_room";
		
		$sql .= " ORDER BY name";	
			
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
	
	public function getTotalCustomerRooms() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_room");
		
		return $query->row['total'];
	}
}
?>