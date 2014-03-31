<?php
class ModelNurseNurse1b extends Model {
	public function addNurse1b($data) {
			$this->load->model('service/child');
			$aaa = $this->model_service_child->getChild((int)$this->request->get['customer_child_id']);
			if (!empty($aaa)) {
				/*
				$child_date_leave = ($child['date_leave'] == '' OR $child['date_leave'] == '0000-00-00') ? $data['date_leave'] : $child['date_leave'];
				$child_date_leave_time = ($child['date_leave'] == '') ? $data['date_leave_time'] : $child['date_leave_time'];
				*/
				//$child_date_added = $data['date_added'];
				//$child_date_added_time = $data['date_added_time'];
				//$child_birthdate = $data['birthdate'];
				
				//$child_birthweight = ($data['birthweight'] == '') ? 'NULL' : "'".(int)$data['birthweight']."'";
				//$child_birthhead = ($data['birthhead'] == '') ? 'NULL' : "'".(int)$data['birthhead']."'";
				//$child_birthchest = ($data['birthchest'] == '') ? 'NULL' : "'".(int)$data['birthchest']."'";
				//$child_birthlength = ($data['birthlength'] == '') ? 'NULL' : "'".(int)$data['birthlength']."'";
				$child_inweight = ($data['inweight'] == '') ? 'NULL' : "'".(int)$data['inweight']."'";
				$child_inlength = ($data['inlength'] == '') ? 'NULL' : "'".(int)$data['inlength']."'";
				$child_inchest = ($data['inchest'] == '') ? 'NULL' : "'".(int)$data['inchest']."'";
				$child_inhead = ($data['inhead'] == '') ? 'NULL' : "'".(int)$data['inhead']."'";
				//$child_apgar_score_1 = ($data['apgar_score_1'] == '') ? 'NULL' : "'".(int)$data['apgar_score_1']."'";
				//$child_apgar_score_5 = ($data['apgar_score_5'] == '') ? 'NULL' : "'".(int)$data['apgar_score_5']."'";
				
				//$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET gender = '" . $this->db->escape($data['gender']) . "', birthhospital = '" . $this->db->escape($data['birthhospital']) . "', birthdate = '" . $this->db->escape($data['birthdate']) . "', birthdate_time = '" . $this->db->escape($data['birthdate_time']) . "', birthweight = " . $child_birthweight . ", birthhead = " . $child_birthhead . ", birthchest = " . $child_birthchest . ", birthlength = " . $child_birthlength . ", inweight = " . $child_inweight . ", apgar_score_1 = " . $child_apgar_score_1 . ", apgar_score_5 = " . $child_apgar_score_5 . ",  date_added = '".$this->db->escape($child_date_added." ".$child_date_added_time)."' WHERE customer_child_id = '" . (int)$this->request->get['customer_child_id'] . "' ");
				$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET inweight = " . $child_inweight . ", inlength = " . $child_inlength . ", inchest = " . $child_inchest . ", inhead = " . $child_inhead . " WHERE customer_child_id = '" . (int)$this->request->get['customer_child_id'] . "' ");

				//$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "' WHERE customer_id = '" . (int)$aaa['customer_id'] . "' ");
			}
	
	
		for ($i=1;$i<=67;$i++) {
			if (!isset($data['chk'.$i.''])) { $data['chk'.$i.''] = ''; }
		}
		
		for ($i=1;$i<=5;$i++) {
			if (!isset($data['field'.$i.''])) { $data['field'.$i.''] = ''; }
		}
		
		for ($i=1;$i<=9;$i++) {
			if (!isset($data['reflex'.$i.''])) { $data['reflex'.$i.''] = ''; }
		}
		
		//$c11 = (isset($data['chk11'])) ? ($data['chk11'] == "未做") ? $data['chk11'].":".$data['chk11_other'] : $data['chk11']  : "";
		//$c26 = (isset($data['chk26'])) ? ($data['chk26'] == "有") ? $data['chk26'].":".$data['chk26_other'] : $data['chk26']  : "";
		//$c27 = (isset($data['chk27'])) ? ($data['chk27'] == "有") ? $data['chk27'].":".$data['chk27_other'] : $data['chk27']  : "";
		
		$f1 = array();
		if (!empty($data['field1'])) {
			foreach ($data['field1'] as $k => $ff1) {
				if ($ff1 == "其他") {
					$f1[$k] = $ff1.":".$data['field1_other'];
				} else {
					$f1[$k] = $ff1;
				}
			}
		}
		$f2 = array();
		if (!empty($data['field2'])) {
			foreach ($data['field2'] as $k => $ff2) {
				if ($ff2 == "感染") {
					$f2[$k] = $ff2.":".$data['field2_other'];
				} else {
					$f2[$k] = $ff2;
				}
			}
		}		
		
		
		$c8 = array();
		if (!empty($data['chk8'])) {
			foreach ($data['chk8'] as $k => $cc8) {
				if ($cc8 == "其他") {
					$c8[$k] = $cc8.":".$data['chk8_other'];
				} else {
					$c8[$k] = $cc8;
				}
			}
		}
		$c13 = array();
		if (!empty($data['chk13'])) {
			foreach ($data['chk13'] as $k => $cc13) {
				if ($cc13 == "其他") {
					$c13[$k] = $cc13.":".$data['chk13_other'];
				} else {
					$c13[$k] = $cc13;
				}
			}
		}
		$c17 = array();
		if (!empty($data['chk17'])) {
			foreach ($data['chk17'] as $k => $cc17) {
				if ($cc17 == "其他") {
					$c17[$k] = $cc17.":".$data['chk17_other'];
				} else {
					$c17[$k] = $cc17;
				}
			}
		}
		$c27 = array();
		if (!empty($data['chk27'])) {
			foreach ($data['chk27'] as $k => $cc27) {
				if ($cc27 == "其他") {
					$c27[$k] = $cc27.":".$data['chk27_other'];
				} else {
					$c27[$k] = $cc27;
				}
			}
		}
		$c32 = array();
		if (!empty($data['chk32'])) {
			foreach ($data['chk32'] as $k => $cc32) {
				if ($cc32 == "其他") {
					$c32[$k] = $cc32.":".$data['chk32_other'];
				} else {
					$c32[$k] = $cc32;
				}
			}
		}
		$c34 = array();
		if (!empty($data['chk34'])) {
			foreach ($data['chk34'] as $k => $cc34) {
				if ($cc34 == "其他") {
					$c34[$k] = $cc34.":".$data['chk34_other'];
				} else {
					$c34[$k] = $cc34;
				}
			}
		}
		$c31 = array();
		if (!empty($data['chk31'])) {
			foreach ($data['chk31'] as $k => $cc31) {
				if ($cc31 == "其他") {
					$c31[$k] = $cc31.":".$data['chk31_other'];
				} else {
					$c31[$k] = $cc31;
				}
			}
		}
		$c33 = array();
		if (!empty($data['chk33'])) {
			foreach ($data['chk33'] as $k => $cc33) {
				if ($cc33 == "其他") {
					$c33[$k] = $cc33.":".$data['chk33_other'];
				} else {
					$c33[$k] = $cc33;
				}
			}
		}
		$c35 = array();
		if (!empty($data['chk35'])) {
			foreach ($data['chk35'] as $k => $cc35) {
				if ($cc35 == "其他") {
					$c35[$k] = $cc35.":".$data['chk35_other'];
				} else {
					$c35[$k] = $cc35;
				}
			}
		}
		$c38 = array();
		if (!empty($data['chk38'])) {
			foreach ($data['chk38'] as $k => $cc38) {
				if ($cc38 == "其他") {
					$c38[$k] = $cc38.":".$data['chk38_other'];
				} else {
					$c38[$k] = $cc38;
				}
			}
		}
		$c40 = array();
		if (!empty($data['chk40'])) {
			foreach ($data['chk40'] as $k => $cc40) {
				if ($cc40 == "其他") {
					$c40[$k] = $cc40.":".$data['chk40_other'];
				} else {
					$c40[$k] = $cc40;
				}
			}
		}
		$c60 = array();
		if (!empty($data['chk60'])) {
			foreach ($data['chk60'] as $k => $cc60) {
				if ($cc60 == "其他") {
					$c60[$k] = $cc60.":".$data['chk60_other'];
				} else {
					$c60[$k] = $cc60;
				}
			}
		}
		
		
		if (!empty($data['chk24'])) {
			if (!in_array("其他",$data['chk24'])) {
				$data['chk24_r']= '';
			}
			if (!in_array("血管瘤",$data['chk24'])) {
				$data['chk24_l']= '';
			}
		}
		
		/*
		$c37 = array();
		if (!empty($data['chk37'])) {
			if (isset($data['chk37_other']) AND $data['chk37_other']<>'') {
				if (!in_array("大小",$data['chk37'])) {
					$data['chk37'][]= '大小';
				}
			}
			foreach ($data['chk37'] as $k => $cc37) {
				if ($cc37 == "大小") {
					$c37[$k] .= $cc37.":".$data['chk37_other'];
				} else {
					$c37[$k] .= $cc37;
				}
			}
		}
		*/
		
		//$data_chk1 = ($data['chk1'] == '') ? 'NULL' : "'".(int)$data['chk1']."'"; 
		$data_chk2 = ($data['chk2'] == '') ? 'NULL' : "'".(float)$data['chk2']."'"; 
		$data_chk3 = ($data['chk3'] == '') ? 'NULL' : "'".(int)$data['chk3']."'"; 
		$data_chk4 = ($data['chk4'] == '') ? 'NULL' : "'".(int)$data['chk4']."'"; 
		//$data_chk5 = ($data['chk5'] == '') ? 'NULL' : "'".(int)$data['chk5']."'"; 
		$data_chk6 = ($data['chk6'] == '') ? 'NULL' : "'".(float)$data['chk6']."'"; 
		
		//$this->db->query("INSERT INTO " . DB_PREFIX . "child_nurse1b SET customer_child_id = '".(int)$this->request->get['customer_child_id']."', nurse_id = '".(int)$data['nurse_id']."', chk1 = " . $data_chk1 . ", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4 = " . $data_chk4 . ", chk5 = " . $data_chk5 . ", chk6 = " . $data_chk6 . ", chk7 = '".(isset($data['chk7']) ? serialize($data['chk7']) : '')."', chk8 = '".$this->db->escape($data['chk8'])."' , chk9 = '" . $this->db->escape($data['chk9']) . "', chk10 = '" . $this->db->escape($data['chk10']) . "', chk11 = '" . $this->db->escape($c11) . "', chk12 = '" . $this->db->escape($data['chk12']) . "', chk13 = '" . $this->db->escape($data['chk13']) . "', chk14 = '" . $this->db->escape($data['chk14']) . "', chk15 = '" . $this->db->escape($data['chk15']) . "', chk16 = '" . $this->db->escape($data['chk16']) . "', chk17 = '" . $this->db->escape($data['chk17']) . "', chk18 = '" . (isset($data['chk18']) ? serialize($data['chk18']) : '') . "', chk19 = '" . (isset($data['chk19']) ? serialize($data['chk19']) : '') . "', chk20 = '" . (isset($data['chk20']) ? serialize($data['chk20']) : '') . "', chk21 = '" . (isset($data['chk21']) ? serialize($data['chk21']) : '') . "', chk22 = '" . (isset($data['chk22']) ? serialize($data['chk22']) : '') . "', chk23 = '" . $this->db->escape($data['chk23']) . "', chk24 = '" . $this->db->escape($data['chk24']) . "', chk25 = '" . $this->db->escape($data['chk25']) . "', chk26 = '" . $this->db->escape($c26) . "', chk27 = '" . $this->db->escape($c27) . "', chk28 = '" . $this->db->escape($data['chk28']) . "', chk29 = '" . $this->db->escape($data['chk29']) . "', chk30 = '" . $this->db->escape($data['chk30']) . "', chk31 = '" . $this->db->escape($data['chk31']) . "', chk32 = '" . $this->db->escape($data['chk32']) . "', chk33 = '" . $this->db->escape($data['chk33']) . "', chk34 = '" . $this->db->escape($data['chk34']) . "', chk35 = '" . $this->db->escape($data['chk35']) . "', chk36 = '" . $this->db->escape($data['chk36']) . "', chk37 = '" . serialize($c37) . "', chk38 = '".$this->db->escape($data['chk38']) ."', chk39 = '".$this->db->escape($data['chk39']) ."', chk40 = '".$this->db->escape($data['chk40']) ."', chk41 = '".$this->db->escape($data['chk41']) ."', chk42 = '".$this->db->escape($data['chk42']) ."', chk43 = '".$this->db->escape($data['chk43']) ."', chk44 = '".$this->db->escape($data['chk44']) ."', chk45 = '".$this->db->escape($data['chk45']) ."', chk46 = '".$this->db->escape($data['chk46']) ."', chk47 = '".(isset($data['chk47']) ? serialize($data['chk47']) : '') ."', chk48 = '".(isset($data['chk48']) ? serialize($data['chk48']) : '') ."', chk49 = '".$this->db->escape($data['chk49'])."' , chk50 = '".$this->db->escape($data['chk50'])."' , chk51 = '".$this->db->escape($data['chk51'])."' , chk52 = '".$this->db->escape($data['chk52'])."' , chk53 = '".$this->db->escape($data['chk53'])."' , chk54 = '".$this->db->escape($data['chk54'])."' , chk55 = '".$this->db->escape($data['chk55'])."' , chk56 = '".(isset($data['chk56']) ? serialize($data['chk56']) : '') ."', chk57 = '".$this->db->escape($data['chk57'])."' ,  chk58 = '".$this->db->escape($data['chk58'])."' ,  chk59 = '".$this->db->escape($data['chk59'])."' ,  chk60 = '".$this->db->escape($data['chk60'])."' ,  chk61 = '".$this->db->escape($data['chk61'])."' ,  chk62 = '".$this->db->escape($data['chk62'])."' ,  chk63 = '".$this->db->escape($data['chk63'])."' ,  chk64 = '".$this->db->escape($data['chk64'])."' ,  chk65 = '".$this->db->escape($data['chk65'])."' ,  chk66 = '".$this->db->escape($data['chk66'])."' ,  chk67 = '". $this->db->escape($data['chk67'])."', date_added = NOW() ");
		$this->db->query("INSERT INTO " . DB_PREFIX . "child_nurse1b SET customer_child_id = '".(int)$this->request->get['customer_child_id']."', nurse_id = '".(int)$data['nurse_id']."', 
		field1 = '" . (isset($f1) ? serialize($f1) : '') . "', 
		field2 = '" . (isset($f2) ? serialize($f2) : '') . "', 
		field3 = '" . (isset($data['field3']) ? serialize($data['field3']) : '') . "', 
		field4 = '" . (int)$data['field4'] . "', 
		chk2 = ".$data_chk2.", 
		chk3 = ".$data_chk3.", 
		chk4 = ".$data_chk4.", 
		chk6 = " . $data_chk6 . ", 
		chk12 = '" . $this->db->escape($data['chk12']) . "', 
		chk61 = '".(isset($data['chk61']) ? serialize($data['chk61']) : '')  ."', 
		chk17 = '" . (isset($c17) ? serialize($c17) : '') . "', 
		chk24 = '" . (isset($data['chk24']) ? serialize($data['chk24']) : '') . "', chk24_l = '" . $this->db->escape($data['chk24_l']) . "', chk24_r = '" . $this->db->escape($data['chk24_r']) . "', 
		chk27 = '" . (isset($c27) ? serialize($c27) : '') . "', 
		chk28 = '".(isset($data['chk28']) ? serialize($data['chk28']) : '')  ."', 
		chk32 = '" . (isset($c32) ? serialize($c32) : '') . "', 
		chk34 = '" . (isset($c34) ? serialize($c34) : '') . "', 
		chk31 = '" . (isset($c31) ? serialize($c31) : '') . "', 
		chk33 = '" . (isset($c33) ? serialize($c33) : '') . "', 
		chk35 = '" . (isset($c35) ? serialize($c35) : '') . "', 
		chk38 = '" . (isset($c38) ? serialize($c38) : '') . "', 
		chk44 = '".(isset($data['chk44']) ? serialize($data['chk44']) : '')  ."', 
		chk40 = '" . (isset($c40) ? serialize($c40) : '') . "', 
		chk55 = '".$this->db->escape($data['chk55'])."' ,
		chk60 = '" . (isset($c60) ? serialize($c60) : '') . "', 
		chk13 = '" . (isset($c13) ? serialize($c13) : '') . "', 
		reflex1 = '" . (isset($data['reflex1']) ? serialize($data['reflex1']) : '') . "', 
		reflex2 = '" . (isset($data['reflex2']) ? serialize($data['reflex2']) : '') . "', 
		reflex3 = '" . (isset($data['reflex3']) ? serialize($data['reflex3']) : '') . "', 
		reflex4 = '" . (isset($data['reflex4']) ? serialize($data['reflex4']) : '') . "', 
		reflex5 = '" . (isset($data['reflex5']) ? serialize($data['reflex5']) : '') . "', 
		reflex6 = '" . (isset($data['reflex6']) ? serialize($data['reflex6']) : '') . "', 
		reflex7 = '" . (isset($data['reflex7']) ? serialize($data['reflex7']) : '') . "', 
		reflex8 = '" . (isset($data['reflex8']) ? serialize($data['reflex8']) : '') . "', 
		reflex9 = '" . (isset($data['reflex9']) ? serialize($data['reflex9']) : '') . "',		
		chk67 = '". $this->db->escape($data['chk67'])."', 
		date_added = NOW() ");
	}
	
	public function editNurse1b($child_nurse1b_id, $data) {		
			$this->load->model('service/child');
			$aaa = $this->model_service_child->getChild((int)$this->request->get['customer_child_id']);
			if (!empty($aaa)) {
				/*
				$child_date_leave = ($child['date_leave'] == '' OR $child['date_leave'] == '0000-00-00') ? $data['date_leave'] : $child['date_leave'];
				$child_date_leave_time = ($child['date_leave'] == '') ? $data['date_leave_time'] : $child['date_leave_time'];
				*/
				//$child_date_added = $data['date_added'];
				//$child_date_added_time = $data['date_added_time'];
				//$child_birthdate = $data['birthdate'];
				
				//$child_birthweight = ($data['birthweight'] == '') ? 'NULL' : "'".(int)$data['birthweight']."'";
				//$child_birthhead = ($data['birthhead'] == '') ? 'NULL' : "'".(int)$data['birthhead']."'";
				//$child_birthchest = ($data['birthchest'] == '') ? 'NULL' : "'".(int)$data['birthchest']."'";
				//$child_birthlength = ($data['birthlength'] == '') ? 'NULL' : "'".(int)$data['birthlength']."'";
				$child_inweight = ($data['inweight'] == '') ? 'NULL' : "'".(int)$data['inweight']."'";
				$child_inlength = ($data['inlength'] == '') ? 'NULL' : "'".(int)$data['inlength']."'";
				$child_inchest = ($data['inchest'] == '') ? 'NULL' : "'".(int)$data['inchest']."'";
				$child_inhead = ($data['inhead'] == '') ? 'NULL' : "'".(int)$data['inhead']."'";
				//$child_apgar_score_1 = ($data['apgar_score_1'] == '') ? 'NULL' : "'".(int)$data['apgar_score_1']."'";
				//$child_apgar_score_5 = ($data['apgar_score_5'] == '') ? 'NULL' : "'".(int)$data['apgar_score_5']."'";
				
				//$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET gender = '" . $this->db->escape($data['gender']) . "', birthhospital = '" . $this->db->escape($data['birthhospital']) . "', birthdate = '" . $this->db->escape($data['birthdate']) . "', birthdate_time = '" . $this->db->escape($data['birthdate_time']) . "', birthweight = " . $child_birthweight . ", birthhead = " . $child_birthhead . ", birthchest = " . $child_birthchest . ", birthlength = " . $child_birthlength . ", inweight = " . $child_inweight . ", apgar_score_1 = " . $child_apgar_score_1 . ", apgar_score_5 = " . $child_apgar_score_5 . ",  date_added = '".$this->db->escape($child_date_added." ".$child_date_added_time)."' WHERE customer_child_id = '" . (int)$this->request->get['customer_child_id'] . "' ");
				$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET inweight = " . $child_inweight . ", inlength = " . $child_inlength . ", inchest = " . $child_inchest . ", inhead = " . $child_inhead . " WHERE customer_child_id = '" . (int)$this->request->get['customer_child_id'] . "' ");

				//$this->db->query("UPDATE " . DB_PREFIX . "customer SET childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "' WHERE customer_id = '" . (int)$aaa['customer_id'] . "' ");
			}	
	
		for ($i=1;$i<=67;$i++) {
			if (!isset($data['chk'.$i.''])) { $data['chk'.$i.''] = ''; }
		}
		
		for ($i=1;$i<=5;$i++) {
			if (!isset($data['field'.$i.''])) { $data['field'.$i.''] = ''; }
		}
		
		for ($i=1;$i<=9;$i++) {
			if (!isset($data['reflex'.$i.''])) { $data['reflex'.$i.''] = ''; }
		}
		
		//$c11 = (isset($data['chk11'])) ? ($data['chk11'] == "未做") ? $data['chk11'].":".$data['chk11_other'] : $data['chk11']  : "";
		//$c26 = (isset($data['chk26'])) ? ($data['chk26'] == "有") ? $data['chk26'].":".$data['chk26_other'] : $data['chk26']  : "";
		//$c27 = (isset($data['chk27'])) ? ($data['chk27'] == "有") ? $data['chk27'].":".$data['chk27_other'] : $data['chk27']  : "";
		
		$f1 = array();
		if (!empty($data['field1'])) {
			foreach ($data['field1'] as $k => $ff1) {
				if ($ff1 == "其他") {
					$f1[$k] = $ff1.":".$data['field1_other'];
				} else {
					$f1[$k] = $ff1;
				}
			}
		}
		$f2 = array();
		if (!empty($data['field2'])) {
			foreach ($data['field2'] as $k => $ff2) {
				if ($ff2 == "感染") {
					$f2[$k] = $ff2.":".$data['field2_other'];
				} else {
					$f2[$k] = $ff2;
				}
			}
		}		
		
		
		$c8 = array();
		if (!empty($data['chk8'])) {
			foreach ($data['chk8'] as $k => $cc8) {
				if ($cc8 == "其他") {
					$c8[$k] = $cc8.":".$data['chk8_other'];
				} else {
					$c8[$k] = $cc8;
				}
			}
		}
		$c13 = array();
		if (!empty($data['chk13'])) {
			foreach ($data['chk13'] as $k => $cc13) {
				if ($cc13 == "其他") {
					$c13[$k] = $cc13.":".$data['chk13_other'];
				} else {
					$c13[$k] = $cc13;
				}
			}
		}
		$c17 = array();
		if (!empty($data['chk17'])) {
			foreach ($data['chk17'] as $k => $cc17) {
				if ($cc17 == "其他") {
					$c17[$k] = $cc17.":".$data['chk17_other'];
				} else {
					$c17[$k] = $cc17;
				}
			}
		}
		$c27 = array();
		if (!empty($data['chk27'])) {
			foreach ($data['chk27'] as $k => $cc27) {
				if ($cc27 == "其他") {
					$c27[$k] = $cc27.":".$data['chk27_other'];
				} else {
					$c27[$k] = $cc27;
				}
			}
		}
		$c32 = array();
		if (!empty($data['chk32'])) {
			foreach ($data['chk32'] as $k => $cc32) {
				if ($cc32 == "其他") {
					$c32[$k] = $cc32.":".$data['chk32_other'];
				} else {
					$c32[$k] = $cc32;
				}
			}
		}
		$c34 = array();
		if (!empty($data['chk34'])) {
			foreach ($data['chk34'] as $k => $cc34) {
				if ($cc34 == "其他") {
					$c34[$k] = $cc34.":".$data['chk34_other'];
				} else {
					$c34[$k] = $cc34;
				}
			}
		}
		$c31 = array();
		if (!empty($data['chk31'])) {
			foreach ($data['chk31'] as $k => $cc31) {
				if ($cc31 == "其他") {
					$c31[$k] = $cc31.":".$data['chk31_other'];
				} else {
					$c31[$k] = $cc31;
				}
			}
		}
		$c33 = array();
		if (!empty($data['chk33'])) {
			foreach ($data['chk33'] as $k => $cc33) {
				if ($cc33 == "其他") {
					$c33[$k] = $cc33.":".$data['chk33_other'];
				} else {
					$c33[$k] = $cc33;
				}
			}
		}
		$c35 = array();
		if (!empty($data['chk35'])) {
			foreach ($data['chk35'] as $k => $cc35) {
				if ($cc35 == "其他") {
					$c35[$k] = $cc35.":".$data['chk35_other'];
				} else {
					$c35[$k] = $cc35;
				}
			}
		}
		$c38 = array();
		if (!empty($data['chk38'])) {
			foreach ($data['chk38'] as $k => $cc38) {
				if ($cc38 == "其他") {
					$c38[$k] = $cc38.":".$data['chk38_other'];
				} else {
					$c38[$k] = $cc38;
				}
			}
		}
		$c40 = array();
		if (!empty($data['chk40'])) {
			foreach ($data['chk40'] as $k => $cc40) {
				if ($cc40 == "其他") {
					$c40[$k] = $cc40.":".$data['chk40_other'];
				} else {
					$c40[$k] = $cc40;
				}
			}
		}
		$c60 = array();
		if (!empty($data['chk60'])) {
			foreach ($data['chk60'] as $k => $cc60) {
				if ($cc60 == "其他") {
					$c60[$k] = $cc60.":".$data['chk60_other'];
				} else {
					$c60[$k] = $cc60;
				}
			}
		}
		
		
		if (!empty($data['chk24'])) {
			if (!in_array("其他",$data['chk24'])) {
				$data['chk24_r']= '';
			}
			if (!in_array("血管瘤",$data['chk24'])) {
				$data['chk24_l']= '';
			}
		}
		
		/*
		$c37 = array();
		if (!empty($data['chk37'])) {
			if (isset($data['chk37_other']) AND $data['chk37_other']<>'') {
				if (!in_array("大小",$data['chk37'])) {
					$data['chk37'][]= '大小';
				}
			}
			foreach ($data['chk37'] as $k => $cc37) {
				if ($cc37 == "大小") {
					$c37[$k] .= $cc37.":".$data['chk37_other'];
				} else {
					$c37[$k] .= $cc37;
				}
			}
		}
		*/
		
		//$data_chk1 = ($data['chk1'] == '') ? 'NULL' : "'".(int)$data['chk1']."'"; 
		$data_chk2 = ($data['chk2'] == '') ? 'NULL' : "'".(float)$data['chk2']."'"; 
		$data_chk3 = ($data['chk3'] == '') ? 'NULL' : "'".(int)$data['chk3']."'"; 
		$data_chk4 = ($data['chk4'] == '') ? 'NULL' : "'".(int)$data['chk4']."'"; 
		//$data_chk5 = ($data['chk5'] == '') ? 'NULL' : "'".(int)$data['chk5']."'"; 
		$data_chk6 = ($data['chk6'] == '') ? 'NULL' : "'".(float)$data['chk6']."'"; 
		
		//$this->db->query("UPDATE " . DB_PREFIX . "child_nurse1b SET customer_child_id = '".(int)$this->request->get['customer_child_id']."', nurse_id = '".(int)$data['nurse_id']."', chk1 = " . $data_chk1 . ", chk2 = ".$data_chk2.", chk3 = " . $data_chk3 . ", chk4 = " . $data_chk4 . ", chk5 = " . $data_chk5 . ", chk6 = " . $data_chk6 . ", chk7 = '".(isset($data['chk7']) ? serialize($data['chk7']) : '')."', chk8 = '".$this->db->escape($data['chk8'])."' , chk9 = '" . $this->db->escape($data['chk9']) . "', chk10 = '" . $this->db->escape($data['chk10']) . "', chk11 = '" . $this->db->escape($c11) . "', chk12 = '" . $this->db->escape($data['chk12']) . "', chk13 = '" . $this->db->escape($data['chk13']) . "', chk14 = '" . $this->db->escape($data['chk14']) . "', chk15 = '" . $this->db->escape($data['chk15']) . "', chk16 = '" . $this->db->escape($data['chk16']) . "', chk17 = '" . $this->db->escape($data['chk17']) . "', chk18 = '" . (isset($data['chk18']) ? serialize($data['chk18']) : '') . "', chk19 = '" . (isset($data['chk19']) ? serialize($data['chk19']) : '') . "', chk20 = '" . (isset($data['chk20']) ? serialize($data['chk20']) : '') . "', chk21 = '" . (isset($data['chk21']) ? serialize($data['chk21']) : '') . "', chk22 = '" . (isset($data['chk22']) ? serialize($data['chk22']) : '') . "', chk23 = '" . $this->db->escape($data['chk23']) . "', chk24 = '" . $this->db->escape($data['chk24']) . "', chk25 = '" . $this->db->escape($data['chk25']) . "', chk26 = '" . $this->db->escape($c26) . "', chk27 = '" . $this->db->escape($c27) . "', chk28 = '" . $this->db->escape($data['chk28']) . "', chk29 = '" . $this->db->escape($data['chk29']) . "', chk30 = '" . $this->db->escape($data['chk30']) . "', chk31 = '" . $this->db->escape($data['chk31']) . "', chk32 = '" . $this->db->escape($data['chk32']) . "', chk33 = '" . $this->db->escape($data['chk33']) . "', chk34 = '" . $this->db->escape($data['chk34']) . "', chk35 = '" . $this->db->escape($data['chk35']) . "', chk36 = '" . $this->db->escape($data['chk36']) . "', chk37 = '" . serialize($c37) . "', chk38 = '".$this->db->escape($data['chk38']) ."', chk39 = '".$this->db->escape($data['chk39']) ."', chk40 = '".$this->db->escape($data['chk40']) ."', chk41 = '".$this->db->escape($data['chk41']) ."', chk42 = '".$this->db->escape($data['chk42']) ."', chk43 = '".$this->db->escape($data['chk43']) ."', chk44 = '".$this->db->escape($data['chk44']) ."', chk45 = '".$this->db->escape($data['chk45']) ."', chk46 = '".$this->db->escape($data['chk46']) ."', chk47 = '".(isset($data['chk47']) ? serialize($data['chk47']) : '') ."', chk48 = '".(isset($data['chk48']) ? serialize($data['chk48']) : '') ."', chk49 = '".$this->db->escape($data['chk49'])."' , chk50 = '".$this->db->escape($data['chk50'])."' , chk51 = '".$this->db->escape($data['chk51'])."' , chk52 = '".$this->db->escape($data['chk52'])."' , chk53 = '".$this->db->escape($data['chk53'])."' , chk54 = '".$this->db->escape($data['chk54'])."' , chk55 = '".$this->db->escape($data['chk55'])."' , chk56 = '".(isset($data['chk56']) ? serialize($data['chk56']) : '') ."', chk57 = '".$this->db->escape($data['chk57'])."' ,  chk58 = '".$this->db->escape($data['chk58'])."' ,  chk59 = '".$this->db->escape($data['chk59'])."' ,  chk60 = '".$this->db->escape($data['chk60'])."' ,  chk61 = '".$this->db->escape($data['chk61'])."' ,  chk62 = '".$this->db->escape($data['chk62'])."' ,  chk63 = '".$this->db->escape($data['chk63'])."' ,  chk64 = '".$this->db->escape($data['chk64'])."' ,  chk65 = '".$this->db->escape($data['chk65'])."' ,  chk66 = '".$this->db->escape($data['chk66'])."' ,  chk67 = '". $this->db->escape($data['chk67'])."', date_modify = NOW() WHERE child_nurse1b_id = '".(int)$child_nurse1b_id."'");
		//$this->db->query("UPDATE " . DB_PREFIX . "child_nurse1b SET customer_child_id = '".(int)$this->request->get['customer_child_id']."', nurse_id = '".(int)$data['nurse_id']."', chk2 = ".$data_chk2.", chk5 = '" . $this->db->escape($data['chk5']) . "', chk5_other = '" . $this->db->escape($data['chk5_other']) . "', chk6 = " . $data_chk6 . ", chk7 = '" . $this->db->escape($data['chk7']) . "', chk7_other = '" . $this->db->escape($data['chk7_other']) . "',  chk8 = '".(!empty($c8) ? serialize($c8) : '') ."' , chk9 = '" . $this->db->escape($data['chk9']) . "', chk9_other = '" . $this->db->escape($data['chk9_other']) . "', chk12 = '" . $this->db->escape($data['chk12']) . "', chk13 = '" . (isset($data['chk13']) ? serialize($data['chk13']) : '') . "', chk16 = '" . $this->db->escape($data['chk16']) . "', chk17 = '" . (isset($data['chk17']) ? serialize($data['chk17']) : '') . "', chk18 = '" . (isset($data['chk18']) ? serialize($data['chk18']) : '') . "', chk21 = '" . (isset($data['chk21']) ? serialize($data['chk21']) : '') . "', chk22 = '" . (isset($data['chk22']) ? serialize($data['chk22']) : '') . "', chk23 = '" . $this->db->escape($data['chk23']) . "', chk24 = '" . (isset($data['chk24']) ? serialize($data['chk24']) : '') . "', chk24_l = '" . $this->db->escape($data['chk24_l']) . "', chk24_r = '" . $this->db->escape($data['chk24_r']) . "', chk26 = '" . (isset($data['chk26']) ? serialize($data['chk26']) : '') . "', chk27 = '" . (isset($data['chk27']) ? serialize($data['chk27']) : '')  . "', chk28 = '" . (isset($data['chk28']) ? serialize($data['chk28']) : '')  . "', chk29 = '" . (isset($data['chk29']) ? serialize($data['chk29']) : '')  . "', chk30 = '" . (isset($data['chk30']) ? serialize($data['chk30']) : '')  . "', chk31 = '" . (isset($data['chk31']) ? serialize($data['chk31']) : '')  . "', chk32 = '" . (isset($data['chk32']) ? serialize($data['chk32']) : '')  . "', chk33 = '" . (isset($data['chk33']) ? serialize($data['chk33']) : '')  . "', chk34 = '" . (isset($data['chk34']) ? serialize($data['chk34']) : '')  . "', chk35 = '" . (isset($data['chk35']) ? serialize($data['chk35']) : '')  . "', chk36 = '" . (isset($data['chk36']) ? serialize($data['chk36']) : '')  . "', chk38 = '".(isset($data['chk38']) ? serialize($data['chk38']) : '')  ."', chk40 = '".(isset($data['chk40']) ? serialize($data['chk40']) : '')  ."', chk41 = '".(isset($data['chk41']) ? serialize($data['chk41']) : '')  ."', chk42 = '". (isset($data['chk42']) ? serialize($data['chk42']) : '')  ."', chk43 = '". (isset($data['chk43']) ? serialize($data['chk43']) : '')  ."', chk44 = '". (isset($data['chk44']) ? serialize($data['chk44']) : '')  ."', chk50 = '".(isset($data['chk50']) ? serialize($data['chk50']) : '')."' , chk51 = '".(isset($data['chk51']) ? serialize($data['chk51']) : '')."' , chk52 = '".(isset($data['chk52']) ? serialize($data['chk52']) : '')."', chk55 = '".$this->db->escape($data['chk55'])."' , chk60 = '".(isset($data['chk60']) ? serialize($data['chk60']) : '')  ."', chk61 = '".(isset($data['chk61']) ? serialize($data['chk61']) : '')  ."', chk62 = '". (isset($data['chk62']) ? serialize($data['chk62']) : '')  ."', chk67 = '". $this->db->escape($data['chk67'])."', date_modify = NOW() WHERE child_nurse1b_id = '".(int)$child_nurse1b_id."'");
		
		$this->db->query("UPDATE " . DB_PREFIX . "child_nurse1b SET customer_child_id = '".(int)$this->request->get['customer_child_id']."', nurse_id = '".(int)$data['nurse_id']."', 
		field1 = '" . (isset($f1) ? serialize($f1) : '') . "', 
		field2 = '" . (isset($f2) ? serialize($f2) : '') . "', 
		field3 = '" . (isset($data['field3']) ? serialize($data['field3']) : '') . "', 
		field4 = '" . (int)$data['field4'] . "', 
		chk2 = ".$data_chk2.", 
		chk3 = ".$data_chk3.", 
		chk4 = ".$data_chk4.", 
		chk6 = " . $data_chk6 . ", 
		chk12 = '" . $this->db->escape($data['chk12']) . "', 
		chk61 = '".(isset($data['chk61']) ? serialize($data['chk61']) : '')  ."', 
		chk17 = '" . (isset($c17) ? serialize($c17) : '') . "', 
		chk24 = '" . (isset($data['chk24']) ? serialize($data['chk24']) : '') . "', chk24_l = '" . $this->db->escape($data['chk24_l']) . "', chk24_r = '" . $this->db->escape($data['chk24_r']) . "', 
		chk27 = '" . (isset($c27) ? serialize($c27) : '') . "', 
		chk28 = '".(isset($data['chk28']) ? serialize($data['chk28']) : '')  ."', 
		chk32 = '" . (isset($c32) ? serialize($c32) : '') . "', 
		chk34 = '" . (isset($c34) ? serialize($c34) : '') . "', 
		chk31 = '" . (isset($c31) ? serialize($c31) : '') . "', 
		chk33 = '" . (isset($c33) ? serialize($c33) : '') . "', 
		chk35 = '" . (isset($c35) ? serialize($c35) : '') . "', 
		chk38 = '" . (isset($c38) ? serialize($c38) : '') . "', 
		chk44 = '".(isset($data['chk44']) ? serialize($data['chk44']) : '')  ."', 
		chk40 = '" . (isset($c40) ? serialize($c40) : '') . "', 
		chk55 = '".$this->db->escape($data['chk55'])."' ,
		chk60 = '" . (isset($c60) ? serialize($c60) : '') . "', 
		chk13 = '" . (isset($c13) ? serialize($c13) : '') . "', 
		reflex1 = '" . (isset($data['reflex1']) ? serialize($data['reflex1']) : '') . "', 
		reflex2 = '" . (isset($data['reflex2']) ? serialize($data['reflex2']) : '') . "', 
		reflex3 = '" . (isset($data['reflex3']) ? serialize($data['reflex3']) : '') . "', 
		reflex4 = '" . (isset($data['reflex4']) ? serialize($data['reflex4']) : '') . "', 
		reflex5 = '" . (isset($data['reflex5']) ? serialize($data['reflex5']) : '') . "', 
		reflex6 = '" . (isset($data['reflex6']) ? serialize($data['reflex6']) : '') . "', 
		reflex7 = '" . (isset($data['reflex7']) ? serialize($data['reflex7']) : '') . "', 
		reflex8 = '" . (isset($data['reflex8']) ? serialize($data['reflex8']) : '') . "', 
		reflex9 = '" . (isset($data['reflex9']) ? serialize($data['reflex9']) : '') . "',		
		chk67 = '". $this->db->escape($data['chk67'])."', 
		date_added = NOW() WHERE child_nurse1b_id = '".(int)$child_nurse1b_id."' ");
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
	
	public function getNurse1b($customer_child_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "child_nurse1b WHERE customer_child_id = '" . (int)$customer_child_id . "'");
	
		return $query->row;
	}
	
	public function getChildName($child_id) {
		$query = $this->db->query("SELECT DISTINCT name AS child_name FROM " . DB_PREFIX . "customer_child WHERE customer_child_id = '" . (int)$child_id . "'");
	
		return $query->row['child_name'];
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