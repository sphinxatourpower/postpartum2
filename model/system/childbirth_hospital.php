<?php 
class ModelSystemChildbirthHospital extends Model {
	public function addChildbirthHospital($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "childbirth_hospital SET name = '" . $this->db->escape($data['name']) . "' ");
		
		$this->cache->delete('childbirth_hospital');
	}

	public function editChildbirthHospital($childbirth_hospital_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "childbirth_hospital SET name = '" . $this->db->escape($data['name']) . "' WHERE childbirth_hospital_id = '". (int)$childbirth_hospital_id ."'");
				
		$this->cache->delete('childbirth_hospital');
	}
	
    public function editChildbirthHospitalList($childbirth_hospital_id, $el_data) { 
		if (isset($el_data['name'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "childbirth_hospital SET name = '" . $this->db->escape($el_data['name']) . "' WHERE childbirth_hospital_id = '" . (int)$childbirth_hospital_id . "'");
		}	
		
		if (isset($el_data['sort_order'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "childbirth_hospital SET sort_order = '" . (int)$el_data['sort_order'] . "' WHERE childbirth_hospital_id = '" . (int)$childbirth_hospital_id . "'");
		}	
		
		$this->cache->delete('childbirth_hospital');
	}
	
	public function deleteChildbirthHospital($childbirth_hospital_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "childbirth_hospital WHERE childbirth_hospital_id = '" . (int)$childbirth_hospital_id . "'");
	
		$this->cache->delete('childbirth_hospital');
	}
		
	public function getChildbirthHospital($childbirth_hospital_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "childbirth_hospital WHERE childbirth_hospital_id = '" . (int)$childbirth_hospital_id . "'");
		
		return $query->row;
	}
		
	public function getChildbirthHospitals($data = array()) {
      	if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "childbirth_hospital ";
			
			$sql .= " ORDER BY sort_order ";	
			
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
			$childbirth_hospital_data = $this->cache->get('childbirth_hospital');
		
			if (!$childbirth_hospital_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "childbirth_hospital ORDER BY name");
	
				$childbirth_hospital_data = $query->rows;
			
				$this->cache->set('childbirth_hospital', $childbirth_hospital_data);
			}	
	
			return $childbirth_hospital_data;				
		}
	}
	
	public function getChildbirthHospitalDescriptions($childbirth_hospital_id) {
		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "childbirth_hospital WHERE childbirth_hospital_id = '" . (int)$childbirth_hospital_id . "'");
		
		return $query->row['name'];
	}
	
	public function getChildbirthHospitalNameByCode($code) {
		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "childbirth_hospital WHERE code = '" . $this->db->escape($code) . "'");
		
		return $query->row['name'];
	}
	
	public function getTotalChildbirthHospitals() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "childbirth_hospital ");
		
		return $query->row['total'];
	}	
}
?>