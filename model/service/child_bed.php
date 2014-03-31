<?php
class ModelServiceChildBed extends Model {
	public function addChildBed($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_bed SET name = '" . $this->db->escape($data['name']) . "'");
	}
	
	public function editChildBed($bed_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_child_bed SET name = '" . $this->db->escape($data['name']) . "' WHERE bed_id = '" . (int)$bed_id . "'");
	}
	
	public function deleteChildBed($bed_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child_bed WHERE bed_id = '" . (int)$bed_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE customer_group_id = '" . (int)$customer_group_id . "'");
	}
	
	public function getChildBed($bed_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_child_bed WHERE bed_id = '" . (int)$bed_id . "'");
		
		return $query->row;
	}
	
	public function getChildOcuBeds() {
		$sql = "SELECT cb.name FROM customer_child_bed cb LEFT JOIN customer_child c ON (cb.bed_id = c.bed_id) WHERE DATE(c.date_leave) >= DATE(NOW()) ";
		
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	public function getChildEmptyBeds($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_child_bed";
		
		$sql .= " ORDER BY name";	
		
		$ocuinfo = array();
		$ocubeds = $this->getChildOcuBeds();
		foreach ($ocubeds as $k => $ocu) {
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
		
		$emptybed = array();
		foreach ($query->rows as $rows) {
			if (!in_array($rows['name'], $ocuinfo)) {
				$emptybed[] = $rows;
			}
		}
		
		return $emptybed;
	}
	
	public function getChildBeds($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_child_bed";
		
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
	
	public function getTotalChildBeds() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child_bed");
		
		return $query->row['total'];
	}
}
?>