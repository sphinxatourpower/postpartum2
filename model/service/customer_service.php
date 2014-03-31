<?php
class ModelServiceCustomerService extends Model {
	public function addCustomerService($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_group SET name = '" . $this->db->escape($data['name']) . "'");
	}
	
	public function editCustomerGroup($customer_group_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_group SET name = '" . $this->db->escape($data['name']) . "' WHERE customer_group_id = '" . (int)$customer_group_id . "'");
	}
	
	public function deleteCustomerGroup($customer_group_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_group WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE customer_group_id = '" . (int)$customer_group_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE customer_group_id = '" . (int)$customer_group_id . "'");
	}
	
	public function getCustomerService($user_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "user WHERE user_id = '" . (int)$user_id . "'");
		
		return $query->row;
	}
	
	public function getCustomerServiceName($user_id) {
		$service = $this->getCustomerService($user_id);
		
		if ($service) {
			return $service['name'];
		} else {
			return "";
		}
	}
	
	public function getCustomerServices($data = array()) {
		$sql = "SELECT user_id, name FROM " . DB_PREFIX . "user  ";

		if (isset($data['user_group_id'])) {
			if (is_array($data['user_group_id'])) {
				$implode = array();
				foreach ($data['user_group_id'] as $d) {
					$implode[] = "user_group_id = '" . $d . "' ";
				}
				$sql .= " WHERE " . implode(" OR ", $implode);
			} else {
				$sql .= "WHERE user_group_id = '".$data['user_group_id']."'";
			}
		} 
		
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
	
	public function getTotalCustomerServices() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "user WHERE user_group_id = '3' ");
		
		return $query->row['total'];
	}
}
?>