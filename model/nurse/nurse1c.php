<?php
class ModelNurseNurse1c extends Model {
	public function addNurse1c($data) {
		for ($i=1;$i<=32;$i++) {
			if (!isset($data['chk'.$i.''])) { $data['chk'.$i.''] = ''; }
		}
		/*
		$c5 = (isset($data['chk5'])) ? ($data['chk5'] == "其他") ? $data['chk5'].":".$data['chk5_other'] : $data['chk5']  : "";
		$c17 = (isset($data['chk17'])) ? ($data['chk17'] == "其他") ? $data['chk17'].":".$data['chk17_other'] : $data['chk17']  : "";
		$c18 = (isset($data['chk18'])) ? ($data['chk18'] == "其他") ? $data['chk18'].":".$data['chk18_other'] : $data['chk18']  : "";
		$c19 = (isset($data['chk19'])) ? ($data['chk19'] == "其他") ? $data['chk19'].":".$data['chk19_other'] : $data['chk19']  : "";
		$c28 = (isset($data['chk28'])) ? ($data['chk28'] == "其他") ? $data['chk28'].":".$data['chk28_other'] : $data['chk28']  : "";
		
		
		$c6 = array();
		if (!empty($data['chk6'])) {
			foreach ($data['chk6'] as $cc6) {
				if ($cc6 == "其他") {
					$c6[] .= $cc6.":".$data['chk6_other'];
				} else {
					$c6[] .= $cc6;
				}
			}
		}
		
		
		$c7 = array();
		if (!empty($data['chk7'])) {
			foreach ($data['chk7'] as $cc7) {
				if ($cc7 == "其他") {
					$c7[] .= $cc7.":".$data['chk7_other'];
				} else {
					$c7[] .= $cc7;
				}
			}
		}

		$c8 = array();
		if (!empty($data['chk8'])) {
			foreach ($data['chk8'] as $cc8) {
				if ($cc8 == "其他") {
					$c8[] .= $cc8.":".$data['chk8_other'];
				} else {
					$c8[] .= $cc8;
				}
			}
		}
		
		$c9 = array();
		if (!empty($data['chk9'])) {
			foreach ($data['chk9'] as $cc9) {
				if ($cc9 == "其他") {
					$c9[] .= $cc9.":".$data['chk9_other'];
				} else {
					$c9[] .= $cc9;
				}
			}
		}
		
		$c23 = array();
		if (!empty($data['chk23'])) {
			foreach ($data['chk23'] as $cc23) {
				if ($cc23 == "其他") {
					$c23[] .= $cc23.":".$data['chk23_other'];
				} else {
					$c23[] .= $cc23;
				}
			}
		}
		
		$c24 = array();
		if (!empty($data['chk24'])) {
			foreach ($data['chk24'] as $cc24) {
				if ($cc24 == "其他") {
					$c24[] .= $cc24.":".$data['chk24_other'];
				} else {
					$c24[] .= $cc24;
				}
			}
		}
		*/
		
		$data_chk1 = ($data['chk1'] == '') ? 'NULL' : "'".(float)$data['chk1']."'"; 
		$data_chk2 = ($data['chk2'] == '') ? 'NULL' : "'".(int)$data['chk2']."'"; 
		$data_chk3 = ($data['chk3'] == '') ? 'NULL' : "'".(int)$data['chk3']."'"; 
		$data_chk4a = ($data['chk4a'] == '') ? 'NULL' : "'".(int)$data['chk4a']."'"; 
		$data_chk4b = ($data['chk4b'] == '') ? 'NULL' : "'".(int)$data['chk4b']."'"; 
		$data_chk10 = ($data['chk10'] == '') ? 'NULL' : "'".(int)$data['chk10']."'"; 
		$data_chk11 = ($data['chk11'] == '') ? 'NULL' : "'".(int)$data['chk11']."'"; 
		if($data['chk5']=='臍下'){
			$data_chk5 = $data['chk5'].",".$data['chk5_text1'];
		}elseif($data['chk5']=='臍上'){
			$data_chk5 = $data['chk5'].",".$data['chk5_text2'];
		}else{
			$data_chk5 = $data['chk5'];
		}
		
		
		//$this->db->query("INSERT INTO " . DB_PREFIX . "customer_nurse1c SET customer_id = '".(int)$this->request->get['customer_id']."', nurse_id = '".(int)$data['nurse_id']."', chk1 = " . $data_chk1 . ", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4a = " . $data_chk4a . ", chk4b = " . $data_chk4b . ", chk5 = '".$this->db->escape($c5)."', chk6 = '".serialize($c6)."' , chk7 = '" . serialize($c7) . "', chk8 = '" . serialize($c8) . "', chk9 = '" . serialize($c9) . "', chk10 = '".$this->db->escape($data['chk10']) ."', chk11 = '".$this->db->escape($data['chk11']) ."', chk12 = '".$this->db->escape($data['chk12']) ."', chk13 = '".$this->db->escape($data['chk13']) ."', chk14 = '".$this->db->escape($data['chk14']) ."', chk15 = '".$this->db->escape($data['chk15']) ."', chk16 = '".$this->db->escape($data['chk16']) ."', chk17 = '".$this->db->escape($c17) ."', chk18 = '".$this->db->escape($c18) ."', chk19 = '".$this->db->escape($c19) ."', chk20 = '".$this->db->escape($data['chk20']) ."', chk21 = '".(isset($data['chk21']) ? serialize($data['chk21']) : '') ."', chk22 = '".(isset($data['chk22']) ? serialize($data['chk22']) : '') ."', chk23 = '".serialize($c23)."', chk24 = '".serialize($c24)."', chk25 = '".(isset($data['chk25']) ? serialize($data['chk25']) : '') ."', chk26 = '".$this->db->escape($data['chk26']) ."',  chk27 = '".$this->db->escape($data['chk27']) ."', chk28 = '".$this->db->escape($data['chk28']) ."', chk29 = '".$this->db->escape($data['chk29']) ."', chk30 = '".$this->db->escape($data['chk30']) ."', chk31 = '".$this->db->escape($data['chk31']) ."', chk32 = '". $this->db->escape($data['chk32'])."', date_added = NOW() ");
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_nurse1c SET customer_id = '".(int)$this->request->get['customer_id']."', nurse_id = '".(int)$data['nurse_id']."', chk1 = " . $data_chk1 . ", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4a = " . $data_chk4a . ", chk4b = " . $data_chk4b . ", chk10 = '".$this->db->escape($data['chk10']) ."', chk11 = '".$this->db->escape($data['chk11']) ."', chk12 = '".$this->db->escape($data['chk12']) ."', chk13 = '".$this->db->escape($data['chk13']) ."', chk14 = '".$this->db->escape($data['chk14']) ."', chk15 = '".$this->db->escape($data['chk15']) ."', chk16 = '".$this->db->escape($data['chk16']) ."', chk17 = '".$this->db->escape($data['chk17']) ."', chk18 = '".$this->db->escape($data['chk18']) ."', chk19 = '".$this->db->escape($data['chk19']) ."', chk20 = '".$this->db->escape($data['chk20']) ."', chk26 = '".$this->db->escape($data['chk26']) ."', chk27 = '".$this->db->escape($data['chk27']) ."', chk28 = '".$this->db->escape($data['chk28']) ."', chk29 = '".$this->db->escape($data['chk29']) ."', chk30 = '".$this->db->escape($data['chk30']) ."', chk31 = '".$this->db->escape($data['chk31']) ."', chk32 = '".$this->db->escape($data['chk32']) ."', chk5 = '".$this->db->escape($data_chk5) ."', date_added = NOW() ");
		/*
		$cbh = (isset($data['childbirth_hospital_other']) && $data['childbirth_hospital_other'] <> '') ? "其他:".$data['childbirth_hospital_other'] : '';
		if ($cbh<>'') {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_hospital = '".$this->db->escape($cbh)."' WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		}
		
		$data_pregnancy_weeks = (!isset($data['pregnancy_weeks']) || $data['pregnancy_weeks']=='') ? 'NULL' : "'".(int)$data['pregnancy_weeks']."'";
		$data_weeks_plus = (!isset($data['weeks_plus']) || $data['weeks_plus']=='') ? 'NULL' : "'".(int)$data['weeks_plus']."'";
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "', partum_date = '" . $this->db->escape($data['partum_date']) . "', pregnancy_weeks = " .  $data_pregnancy_weeks . ", weeks_plus = " .  $data_weeks_plus . "  WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		*/
		if ($data['child_count_p']<>'') {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET child_count_p = '" . (int)$data['child_count_p'] . "'  WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		}
	}
	
	public function editNurse1c($customer_nurse1c_id, $data) {		
		for ($i=1;$i<=32;$i++) {
			if (!isset($data['chk'.$i.''])) { $data['chk'.$i.''] = ''; }
		}
		/*
		$c5 = (isset($data['chk5'])) ? ($data['chk5'] == "其他") ? $data['chk5'].":".$data['chk5_other'] : $data['chk5']  : "";
		$c17 = (isset($data['chk17'])) ? ($data['chk17'] == "其他") ? $data['chk17'].":".$data['chk17_other'] : $data['chk17']  : "";
		$c18 = (isset($data['chk18'])) ? ($data['chk18'] == "其他") ? $data['chk18'].":".$data['chk18_other'] : $data['chk18']  : "";
		$c19 = (isset($data['chk19'])) ? ($data['chk19'] == "其他") ? $data['chk19'].":".$data['chk19_other'] : $data['chk19']  : "";
		$c28 = (isset($data['chk28'])) ? ($data['chk28'] == "其他") ? $data['chk28'].":".$data['chk28_other'] : $data['chk28']  : "";
		
		$c6 = array();
		if (!empty($data['chk6'])) {
			foreach ($data['chk6'] as $cc6) {
				if ($cc6 == "其他") {
					$c6[] .= $cc6.":".$data['chk6_other'];
				} else {
					$c6[] .= $cc6;
				}
			}
		}
		
		$c7 = array();
		if (!empty($data['chk7'])) {
			foreach ($data['chk7'] as $cc7) {
				if ($cc7 == "其他") {
					$c7[] .= $cc7.":".$data['chk7_other'];
				} else {
					$c7[] .= $cc7;
				}
			}
		}

		$c8 = array();
		if (!empty($data['chk8'])) {
			foreach ($data['chk8'] as $cc8) {
				if ($cc8 == "其他") {
					$c8[] .= $cc8.":".$data['chk8_other'];
				} else {
					$c8[] .= $cc8;
				}
			}
		}
		
		$c9 = array();
		if (!empty($data['chk9'])) {
			foreach ($data['chk9'] as $cc9) {
				if ($cc9 == "其他") {
					$c9[] .= $cc9.":".$data['chk9_other'];
				} else {
					$c9[] .= $cc9;
				}
			}
		}
		
		$c23 = array();
		if (!empty($data['chk23'])) {
			foreach ($data['chk23'] as $cc23) {
				if ($cc23 == "其他") {
					$c23[] .= $cc23.":".$data['chk23_other'];
				} else {
					$c23[] .= $cc23;
				}
			}
		}
		
		$c24 = array();
		if (!empty($data['chk24'])) {
			foreach ($data['chk24'] as $cc24) {
				if ($cc24 == "其他") {
					$c24[] .= $cc24.":".$data['chk24_other'];
				} else {
					$c24[] .= $cc24;
				}
			}
		}
		*/
		
		$data_chk1 = ($data['chk1'] == '') ? 'NULL' : "'".(float)$data['chk1']."'"; 
		$data_chk2 = ($data['chk2'] == '') ? 'NULL' : "'".(int)$data['chk2']."'"; 
		$data_chk3 = ($data['chk3'] == '') ? 'NULL' : "'".(int)$data['chk3']."'"; 
		$data_chk4a = ($data['chk4a'] == '') ? 'NULL' : "'".(int)$data['chk4a']."'"; 
		$data_chk4b = ($data['chk4b'] == '') ? 'NULL' : "'".(int)$data['chk4b']."'"; 
		$data_chk10 = ($data['chk10'] == '') ? 'NULL' : "'".(int)$data['chk10']."'"; 
		$data_chk11 = ($data['chk11'] == '') ? 'NULL' : "'".(int)$data['chk11']."'"; 
		if($data['chk5']=='臍下'){
			$data_chk5 = $data['chk5'].",".$data['chk5_text1'];
		}elseif($data['chk5']=='臍上'){
			$data_chk5 = $data['chk5'].",".$data['chk5_text2'];
		}else{
			$data_chk5 = $data['chk5'];
		}
		
		//$this->db->query("UPDATE " . DB_PREFIX . "customer_nurse1c SET nurse_id = '".(int)$data['nurse_id']."', chk1 = ".$data_chk1.", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4a = ".$data_chk4a.", chk4b = ".$data_chk4b.", chk5 = '".$this->db->escape($c5)."', chk6 = '".serialize($c6)."' , chk7 = '" . serialize($c7) . "', chk8 = '" . serialize($c8) . "', chk9 = '" . serialize($c9) . "', chk10 = '".$this->db->escape($data['chk10']) ."', chk11 = '".$this->db->escape($data['chk11']) ."', chk12 = '".$this->db->escape($data['chk12']) ."', chk13 = '".$this->db->escape($data['chk13']) ."', chk14 = '".$this->db->escape($data['chk14']) ."', chk15 = '".$this->db->escape($data['chk15']) ."', chk16 = '".$this->db->escape($data['chk16']) ."', chk17 = '".$this->db->escape($c17) ."', chk18 = '".$this->db->escape($c18) ."', chk19 = '".$this->db->escape($c19) ."', chk20 = '".$this->db->escape($data['chk20']) ."', chk21 = '".(isset($data['chk21']) ? serialize($data['chk21']) : '') ."', chk22 = '".(isset($data['chk22']) ? serialize($data['chk22']) : '') ."', chk23 = '".serialize($c23)."', chk24 = '".serialize($c24)."', chk25 = '".(isset($data['chk25']) ? serialize($data['chk25']) : '') ."', chk26 = '".$this->db->escape($data['chk26']) ."',  chk27 = '".$this->db->escape($data['chk27']) ."', chk28 = '".$this->db->escape($data['chk28']) ."', chk29 = '".$this->db->escape($data['chk29']) ."', chk30 = '".$this->db->escape($data['chk30']) ."', chk31 = '".$this->db->escape($data['chk31']) ."', chk32 = '". $this->db->escape($data['chk32'])."', date_modify = NOW() WHERE customer_nurse1c_id = '".(int)$customer_nurse1c_id."'");
		$this->db->query("UPDATE " . DB_PREFIX . "customer_nurse1c SET customer_id = '".(int)$this->request->get['customer_id']."', nurse_id = '".(int)$data['nurse_id']."', chk1 = " . $data_chk1 . ", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4a = " . $data_chk4a . ", chk4b = " . $data_chk4b . ", chk10 = '".$this->db->escape($data['chk10']) ."', chk11 = '".$this->db->escape($data['chk11']) ."', chk12 = '".$this->db->escape($data['chk12']) ."', chk13 = '".$this->db->escape($data['chk13']) ."', chk14 = '".$this->db->escape($data['chk14']) ."', chk15 = '".$this->db->escape($data['chk15']) ."', chk16 = '".$this->db->escape($data['chk16']) ."', chk17 = '".$this->db->escape($data['chk17']) ."', chk18 = '".$this->db->escape($data['chk18']) ."', chk19 = '".$this->db->escape($data['chk19']) ."', chk20 = '".$this->db->escape($data['chk20']) ."', chk26 = '".$this->db->escape($data['chk26']) ."', chk27 = '".$this->db->escape($data['chk27']) ."', chk28 = '".$this->db->escape($data['chk28']) ."', chk29 = '".$this->db->escape($data['chk29']) ."', chk30 = '".$this->db->escape($data['chk30']) ."', chk31 = '".$this->db->escape($data['chk31']) ."', chk32 = '".$this->db->escape($data['chk32']) ."', chk5 = '".$this->db->escape($data_chk5) ."', date_modify = NOW() WHERE customer_nurse1c_id = '".(int)$customer_nurse1c_id."' ");
		/*
		$cbh = (isset($data['childbirth_hospital_other']) && $data['childbirth_hospital_other'] <> '') ? "其他:".$data['childbirth_hospital_other'] : '';
		if ($cbh<>'') {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_hospital = '".$this->db->escape($cbh)."' WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		}
		
		$data_pregnancy_weeks = (!isset($data['pregnancy_weeks']) || $data['pregnancy_weeks']=='') ? 'NULL' : "'".(int)$data['pregnancy_weeks']."'";
		$data_weeks_plus = (!isset($data['weeks_plus']) || $data['weeks_plus']=='') ? 'NULL' : "'".(int)$data['weeks_plus']."'";
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "', partum_date = '" . $this->db->escape($data['partum_date']) . "', pregnancy_weeks = " .  $data_pregnancy_weeks . ", weeks_plus = " .  $data_weeks_plus . "  WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		*/
		if ($data['child_count_p']<>'') {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET child_count_p = '" . (int)$data['child_count_p'] . "'  WHERE customer_id = '". (int)$this->request->get['customer_id'] ."' ");
		}
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
	
	public function getNurse1c($customer_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_nurse1c WHERE customer_id = '" . (int)$customer_id . "'");
	
		return $query->row;
	}
	
	/*
	public function getCustomerByIDNumber($idnumber) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer WHERE idnumber = '" . $this->db->escape($idnumber) . "'");
	
		return $query->row;
	}
	*/
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