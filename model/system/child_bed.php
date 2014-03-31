<?php
class ModelSystemChildBed extends Model {
	public function addChildBed($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_bed SET name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
	}
	
	public function editChildBed($bed_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer_child_bed SET name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE bed_id = '" . (int)$bed_id . "'");
	}
	
	public function deleteChildBed($bed_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child_bed WHERE bed_id = '" . (int)$bed_id . "'");
	}
	
	public function getChildBed($bed_id) {
		//$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_child_bed cg LEFT JOIN " . DB_PREFIX . "customer_child_bed_description cgd ON (cg.bed_id = cgd.bed_id) WHERE cg.bed_id = '" . (int)$bed_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_child_bed cg WHERE cg.bed_id = '" . (int)$bed_id . "' ");
		
		return $query->row;
	}
	
	public function getChildBeds($data = array()) {
		//$sql = "SELECT * FROM " . DB_PREFIX . "customer_child_bed cg LEFT JOIN " . DB_PREFIX . "customer_child_bed_description cgd ON (cg.bed_id = cgd.bed_id) WHERE cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_child_bed cg ";
		
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
	
	public function getChildBedDescriptions($bed_id) {
		$customer_group_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_child_bed_description WHERE bed_id = '" . (int)$bed_id . "'");
				
		foreach ($query->rows as $result) {
			$customer_group_data[$result['language_id']] = array(
				'name'        => $result['name'],
				'description' => $result['description']
			);
		}
		
		return $customer_group_data;
	}
		
	public function getTotalChildBeds() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_child_bed");
		
		return $query->row['total'];
	}
}
?>