<?php
class ModelServiceCustomer extends Model {
	public function addCustomer($data) {
		//if (!isset($data['degree'])) { $data['degree'] = ''; }
		//if (!isset($data['profession'])) { $data['profession'] = ''; }
		//if (!isset($data['language'])) { $data['language'] = ''; }
		//if (!isset($data['evacuation_hospital'])) { $data['evacuation_hospital'] = ''; }
		
		//$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET idnumber = UPPER('".$this->db->escape($data['idnumber'])."'), birthdate = '".$this->db->escape($data['birthdate'])."', name = '" . $this->db->escape($data['name']) . "', address = '".$this->db->escape($data['address'])."', telephone = '" . $this->db->escape($data['telephone']) . "', email = '" . $this->db->escape($data['email']) . "', fall_score = '". (int)$data['fall_score']."', depression_score = '". (int)$data['depression_score']."' , degree = '" . $this->db->escape($data['degree']) . "', profession = '" . $this->db->escape($data['profession']) . "', language = '" . $this->db->escape($data['language']) . "', evacuation_hospital = '".$this->db->escape($data['evacuation_hospital']) ."', status = '" . (int)$data['status'] . "', showathome = '" . (int)$data['showathome'] . "', service_id = '" . (int)$data['service_id'] . "', date_leave= '" . $this->db->escape($data['date_leave']." ".$data['date_leave_time']). "', date_added = '".$this->db->escape($data['date_added']." ".$data['date_added_time'])."' ");
		if (!isset($data['degree'])) { $data['degree'] = ''; }
		if (!isset($data['profession'])) { $data['profession'] = ''; }
		if (!isset($data['language'])) { $data['language'] = ''; }
		if (!isset($data['evacuation_hospital'])) { $data['evacuation_hospital'] = ''; }
		if (!isset($data['childbirth_hospital'])) { $data['childbirth_hospital'] = ''; }
		if (!isset($data['childbirth_doctor'])) { $data['childbirth_doctor'] = ''; }
		if (!isset($data['childbirth_method'])) { $data['childbirth_method'] = ''; }
	
		$pro = (isset($data['profession']) && $data['profession'] == "其他") ? $data['profession'].":".$data['profession_other'] : $data['profession'] ;
		$lng = (isset($data['language']) && $data['language'] == "其他") ? $data['language'].":".$data['language_other'] : $data['language'] ;
		$evh = (isset($data['evacuation_hospital']) && $data['evacuation_hospital'] == "其他") ? $data['evacuation_hospital'].":".$data['evacuation_hospital_other'] : $data['evacuation_hospital'] ;
		$cbh = (isset($data['childbirth_hospital']) && $data['childbirth_hospital'] == "其他") ? $data['childbirth_hospital'].":".$data['childbirth_hospital_other'] : $data['childbirth_hospital'] ;

		$data_fall_score = (!isset($data['fall_score']) || $data['fall_score']=='') ? 'NULL' : "'".(int)$data['fall_score']."'";
		$data_depression_score = (!isset($data['depression_score']) || $data['depression_score']=='') ? 'NULL' : "'".(int)$data['depression_score']."'";
		$data_child_count_g = (!isset($data['child_count_g']) || $data['child_count_g']=='') ? 'NULL' : "'".(int)$data['child_count_g']."'";
		$data_child_count_p = (!isset($data['child_count_p']) || $data['child_count_p']=='') ? 'NULL' : "'".(int)$data['child_count_p']."'";
		$data_pregnancy_weeks = (!isset($data['pregnancy_weeks']) || $data['pregnancy_weeks']=='') ? 'NULL' : "'".(int)$data['pregnancy_weeks']."'";
		$data_weeks_plus = (!isset($data['weeks_plus']) || $data['weeks_plus']=='') ? 'NULL' : "'".(int)$data['weeks_plus']."'";
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET idnumber = UPPER('".$this->db->escape($data['idnumber'])."'), foreigner = '" . (int)$data['foreigner'] . "', name = '" . $this->db->escape($data['name']) . "', birthdate = '" . $this->db->escape($data['birthdate']) . "', address= '" . $this->db->escape($data['address']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', email = '" . $this->db->escape($data['email']) . "',  fall_score = ". $data_fall_score.", depression_score = ". $data_depression_score." , degree = '" . $this->db->escape($data['degree']) . "', profession = '" . $this->db->escape($pro) . "', language = '" . $this->db->escape($lng) . "', evacuation_hospital = '".$this->db->escape($evh) ."', status = '" . (int)$data['status'] . "', showathome = '1', service_id = '" . (int)$data['service_id'] . "', date_leave = '" . $this->db->escape($data['date_leave']." ".$data['date_leave_time']) . "', date_added = '" . $this->db->escape($data['date_added']." ".$data['date_added_time']) . "', spouse_name = '" . $this->db->escape($data['spouse_name']) . "', childbirth_hospital = '".$this->db->escape($cbh)."', childbirth_doctor = '" . $this->db->escape($data['childbirth_doctor']) . "', childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "', child_count_g = " .  $data_child_count_g . ", child_count_p = " .  $data_child_count_p . ", pregnancy_weeks = " .  $data_pregnancy_weeks . ", weeks_plus = " .  $data_weeks_plus . " ");
      	
      	$customer_id = $this->db->getLastId();
      	
		if (isset($data['child'])) {		
      		foreach ($data['child'] as $child) {	
				/*
				$child_date_leave = ($child['date_leave'] == '' OR $child['date_leave'] == '0000-00-00') ? $data['date_leave'] : $child['date_leave'];
				$child_date_leave_time = ($child['date_leave'] == '') ? $data['date_leave_time'] : $child['date_leave_time'];
				*/
				$child_date_leave = $data['date_leave'];
				$child_date_leave_time = $data['date_leave_time'];
				
				$child_birthweight = ($child['birthweight'] == '') ? 'NULL' : "'".(int)$child['birthweight']."'";
				$child_birthhead = ($child['birthhead'] == '') ? 'NULL' : "'".(int)$child['birthhead']."'";
				$child_birthchest = ($child['birthchest'] == '') ? 'NULL' : "'".(int)$child['birthchest']."'";
				$child_birthlength = ($child['birthlength'] == '') ? 'NULL' : "'".(int)$child['birthlength']."'";
				$child_inweight = ($child['inweight'] == '') ? 'NULL' : "'".(int)$child['inweight']."'";
				$child_inlength = ($child['inlength'] == '') ? 'NULL' : "'".(int)$child['inlength']."'";
				$child_apgar_score_1 = ($child['apgar_score_1'] == '') ? 'NULL' : "'".(int)$child['apgar_score_1']."'";
				$child_apgar_score_5 = ($child['apgar_score_5'] == '') ? 'NULL' : "'".(int)$child['apgar_score_5']."'";
				
				$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($child['name']) . "', gender = '" . $this->db->escape($child['gender']) . "', birthhospital = '" . $this->db->escape($child['birthhospital']) . "', birthdate = '" . $this->db->escape($child['birthdate']) . "', birthdate_time = '" . $this->db->escape($child['birthdate_time']) . "', birthweight = " . $child_birthweight . ", birthhead = " . $child_birthhead . ", birthchest = " . $child_birthchest . ", birthlength = " . $child_birthlength . ", inweight = " . $child_inweight . ",  inlength = " . $child_inlength . ", b_streptococcus_check = '', apgar_score_1 = " . $child_apgar_score_1 . ", apgar_score_5 = " . $child_apgar_score_5 . ", bed_id='". (int)$child['bed_id'] ."', date_leave = '".$this->db->escape($child_date_leave." ".$child_date_leave_time)."' ");
			}
		}
		
		if (isset($data['contact'])) {		
      		foreach ($data['contact'] as $contact) {	
      			$this->db->query("INSERT INTO " . DB_PREFIX . "contact SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "', telephone = '" . $this->db->escape($contact['telephone']) . "', contact_info = '" . $this->db->escape($contact['contact_info']) . "', relationship = '" . $this->db->escape($contact['relationship']) . "'");
				
				if (isset($contact['default'])) {
					$contact_id = $this->db->getLastId();
					$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact_id = '" . $contact_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
				}
			}
		}
	}
	
	public function editCustomer($customer_id, $data) {	
		if (!isset($data['degree'])) { $data['degree'] = ''; }
		if (!isset($data['profession'])) { $data['profession'] = ''; }
		if (!isset($data['language'])) { $data['language'] = ''; }
		if (!isset($data['evacuation_hospital'])) { $data['evacuation_hospital'] = ''; }
		if (!isset($data['childbirth_hospital'])) { $data['childbirth_hospital'] = ''; }
		if (!isset($data['childbirth_doctor'])) { $data['childbirth_doctor'] = ''; }
		if (!isset($data['childbirth_method'])) { $data['childbirth_method'] = ''; }
	
		$pro = (isset($data['profession']) && $data['profession'] == "其他") ? $data['profession'].":".$data['profession_other'] : $data['profession'] ;
		$lng = (isset($data['language']) && $data['language'] == "其他") ? $data['language'].":".$data['language_other'] : $data['language'] ;
		$evh = (isset($data['evacuation_hospital']) && $data['evacuation_hospital'] == "其他") ? $data['evacuation_hospital'].":".$data['evacuation_hospital_other'] : $data['evacuation_hospital'] ;
		$cbh = (isset($data['childbirth_hospital']) && $data['childbirth_hospital'] == "其他") ? $data['childbirth_hospital'].":".$data['childbirth_hospital_other'] : $data['childbirth_hospital'] ;

		$data_fall_score = (!isset($data['fall_score']) || $data['fall_score']=='') ? 'NULL' : "'".(int)$data['fall_score']."'";
		$data_depression_score = (!isset($data['depression_score']) || $data['depression_score']=='') ? 'NULL' : "'".(int)$data['depression_score']."'";
		$data_child_count_g = (!isset($data['child_count_g']) || $data['child_count_g']=='') ? 'NULL' : "'".(int)$data['child_count_g']."'";
		$data_child_count_p = (!isset($data['child_count_p']) || $data['child_count_p']=='') ? 'NULL' : "'".(int)$data['child_count_p']."'";
		$data_pregnancy_weeks = (!isset($data['pregnancy_weeks']) || $data['pregnancy_weeks']=='') ? 'NULL' : "'".(int)$data['pregnancy_weeks']."'";
		$data_weeks_plus = (!isset($data['weeks_plus']) || $data['weeks_plus']=='') ? 'NULL' : "'".(int)$data['weeks_plus']."'";
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET idnumber = UPPER('".$this->db->escape($data['idnumber'])."'), foreigner = '" . (int)$data['foreigner'] . "', name = '" . $this->db->escape($data['name']) . "', birthdate = '" . $this->db->escape($data['birthdate']) . "', address= '" . $this->db->escape($data['address']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', email = '" . $this->db->escape($data['email']) . "',  fall_score = ". $data_fall_score.", depression_score = ". $data_depression_score." , degree = '" . $this->db->escape($data['degree']) . "', profession = '" . $this->db->escape($pro) . "', language = '" . $this->db->escape($lng) . "', evacuation_hospital = '".$this->db->escape($evh) ."', status = '" . (int)$data['status'] . "', showathome = '1', service_id = '" . (int)$data['service_id'] . "', date_leave = '" . $this->db->escape($data['date_leave']." ".$data['date_leave_time']) . "', date_added = '" . $this->db->escape($data['date_added']." ".$data['date_added_time']) . "', spouse_name = '" . $this->db->escape($data['spouse_name']) . "', childbirth_hospital = '".$this->db->escape($cbh)."', childbirth_doctor = '" . $this->db->escape($data['childbirth_doctor']) . "', childbirth_method = '" . $this->db->escape($data['childbirth_method']) . "', child_count_g = " .  $data_child_count_g . ", child_count_p = " .  $data_child_count_p . ", pregnancy_weeks = " .  $data_pregnancy_weeks . ", weeks_plus = " .  $data_weeks_plus . " WHERE customer_id = '" . (int)$customer_id . "'");
		
			
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		if (isset($data['child'])) {
      		foreach ($data['child'] as $child) {
				if (!isset($child['b_streptococcus_check'])) { $child['b_streptococcus_check'] = ''; }
				
				/*
				$child_date_leave = ($child['date_leave'] == '' OR $child['date_leave'] == '0000-00-00') ? $data['date_leave'] : $child['date_leave'];
				$child_date_leave_time = ($child['date_leave'] == '') ? $data['date_leave_time'] : $child['date_leave_time'];
				*/
				$child_date_leave = $data['date_leave'];
				$child_date_leave_time = $data['date_leave_time'];
				
				$child_birthweight = ($child['birthweight'] == '') ? 'NULL' : "'".(int)$child['birthweight']."'";
				$child_birthhead = ($child['birthhead'] == '') ? 'NULL' : "'".(int)$child['birthhead']."'";
				$child_birthchest = ($child['birthchest'] == '') ? 'NULL' : "'".(int)$child['birthchest']."'";
				$child_birthlength = ($child['birthlength'] == '') ? 'NULL' : "'".(int)$child['birthlength']."'";
				$child_inweight = ($child['inweight'] == '') ? 'NULL' : "'".(int)$child['inweight']."'";
				$child_inlength = ($child['inlength'] == '') ? 'NULL' : "'".(int)$child['inlength']."'";
				$child_apgar_score_1 = ($child['apgar_score_1'] == '') ? 'NULL' : "'".(int)$child['apgar_score_1']."'";
				$child_apgar_score_5 = ($child['apgar_score_5'] == '') ? 'NULL' : "'".(int)$child['apgar_score_5']."'";
				
				if ($child['child_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_child_id = '" . $this->db->escape($child['child_id']) . "', customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($child['name']) . "', gender = '" . $this->db->escape($child['gender']) . "', birthhospital = '" . $this->db->escape($child['birthhospital']) . "', birthdate = '" . $this->db->escape($child['birthdate']) . "', birthdate_time = '" . $this->db->escape($child['birthdate_time']) . "', birthweight = " . $child_birthweight . ", birthhead = " . $child_birthhead . ", birthchest = " . $child_birthchest . ", birthlength = " . $child_birthlength . ", inweight = " . $child_inweight . ",  inlength = " . $child_inlength . ", b_streptococcus_check = '" . $this->db->escape($child['b_streptococcus_check']) . "', apgar_score_1 = " . $child_apgar_score_1 . ", apgar_score_5 = " . $child_apgar_score_5 . ", bed_id='". (int)$child['bed_id'] ."', image='". $this->db->escape($child['image']) ."',  date_leave = '".$this->db->escape($child_date_leave." ".$child_date_leave_time)."' ");
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($child['name']) . "', gender = '" . $this->db->escape($child['gender']) . "', birthhospital = '" . $this->db->escape($child['birthhospital']) . "', birthdate = '" . $this->db->escape($child['birthdate']) . "', birthdate_time = '" . $this->db->escape($child['birthdate_time']) . "', birthweight = " . $child_birthweight . ", birthhead = " . $child_birthhead . ", birthchest = " . $child_birthchest . ", birthlength = " . $child_birthlength . ", inweight = " . $child_inweight . ",  inlength = " . $child_inlength . ", b_streptococcus_check = '" . $this->db->escape($child['b_streptococcus_check']) . "', apgar_score_1 = " . $child_apgar_score_1 . ", apgar_score_5 = " . $child_apgar_score_5 . ", bed_id='". (int)$child['bed_id'] ."',  image='". $this->db->escape($child['image']) ."', date_leave = '".$this->db->escape($child_date_leave." ".$child_date_leave_time)."' ");
				}
			}
		}
		
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
      	if (isset($data['contact'])) {
      		foreach ($data['contact'] as $contact) {
				if (!isset($contact['relationship'])) { $contact['relationship'] = ''; }
				
				if ($contact['contact_id']) {
					$this->db->query("INSERT INTO  " . DB_PREFIX . "contact SET contact_id = '" . (int)$contact['contact_id'] . "', customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "', telephone = '".$this->db->escape($contact['telephone'])."', contact_info = '" . $this->db->escape($contact['contact_info']) . "', relationship = '".$this->db->escape($contact['relationship'])."'");
					
					if (isset($contact['default'])) {
						$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact_id = '" . (int)$contact['contact_id'] . "' WHERE customer_id = '" . (int)$customer_id . "'");
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "contact SET customer_id = '" . (int)$customer_id . "', name = '" . $this->db->escape($contact['name']) . "',  telephone = '".$this->db->escape($contact['telephone']). "', contact_info = '" . $this->db->escape($contact['contact_info']) . "', relationship = '".$this->db->escape($contact['relationship'])."'");
					
					if (isset($contact['default'])) {
						$contact_id = $this->db->getLastId();
						
						$this->db->query("UPDATE " . DB_PREFIX . "customer SET contact_id = '" . (int)$contact_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
					}
				}
			}
		}
		
		//print_r($data['transfer']); print isset($data['transfer']);
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
		if (isset($data['transfer'])) { 
			foreach ($data['transfer'] as $key => $transfer) {
				if ($key==0) {  
					$this->db->query("UPDATE " . DB_PREFIX . "customer SET customer_room_id = '".(int)$transfer['customer_room_id']."' WHERE customer_id = '". (int)$customer_id ."'"); 
					$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET bed_id = '".(int)$transfer['customer_room_id']."' WHERE customer_id = '". (int)$customer_id ."'"); 
				} 
				if ($transfer['customer_transfer_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_transfer SET customer_transfer_id = '" . (int)$transfer['customer_transfer_id'] . "', customer_id = '" . (int)$customer_id . "', customer_room_id = '" . (int)$transfer['customer_room_id'] . "',  date_added = '".$this->db->escape($transfer['date_added'])."', description = '" . $this->db->escape($transfer['description']) . "', extra_period = '" . (int)$transfer['extra_period'] . "' ");
				} 
			}
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET customer_room_id = '0' WHERE customer_id = '". (int)$customer_id ."'"); 
			$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET bed_id = '0' WHERE customer_id = '". (int)$customer_id ."'"); 
		}
		//exit;
	}

	public function editToken($customer_id, $token) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = '" . $this->db->escape($token) . "' WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function deleteCustomer($customer_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '" . (int)$customer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "contact WHERE customer_id = '" . (int)$customer_id . "'");
	}
	
	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
	
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
			
	public function getCustomers($data = array()) {
		//$sql = "SELECT *, CONCAT(c.lastname, c.firstname) AS name, cg.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id)";
		$sql = "SELECT c.*, cu.name AS service FROM " . DB_PREFIX . "customer c LEFT JOIN ". DB_PREFIX . "user cu ON (c.service_id = cu.user_id) ";

		$implode = array();
		
		if (!empty($data['filter_name'])) {
			//$implode[] = "LCASE(CONCAT(c.lastname, c.firstname)) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			$implode[] = "LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (!empty($data['filter_room_id'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer WHERE customer_room_id = '" . $this->db->escape($data['filter_room_id']) . "')";
		}
		
		/*
		if (isset($data['filter_newsletter']) && !is_null($data['filter_newsletter'])) {
			$implode[] = "c.newsletter = '" . (int)$data['filter_newsletter'] . "'";
		}	
				
		if (!empty($data['filter_customer_group_id'])) {
			$implode[] = "cg.customer_group_id = '" . (int)$data['filter_customer_group_id'] . "'";
		}	
			
		if (!empty($data['filter_ip'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer_ip WHERE ip = '" . $this->db->escape($data['filter_ip']) . "')";
		}
		*/		
				
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
		
		if (isset($data['filter_showathome']) && !is_null($data['filter_showathome'])) {
			$implode[] = "c.showathome = '" . (int)$data['filter_showathome'] . "'";
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
			'name',
			'room',
			'customer_room_id',
			//'customer_group',
			'c.status',
			'c.showathome',
			//'c.ip',
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
	
	public function hideathome($customer_id) {
		$customer_info = $this->getCustomer($customer_id);

		if ($customer_info) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET showathome = '0' WHERE customer_id = '" . (int)$customer_id . "'");
		}		
	}
	
	public function showathome($customer_id) {
		$customer_info = $this->getCustomer($customer_id);

		if ($customer_info) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET showathome = '1' WHERE customer_id = '" . (int)$customer_id . "'");
		}		
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
				'birthhospital'       => $child_query->row['birthhospital'],
				'birthdate'       => $child_query->row['birthdate'],
				'birthdate_time'       => date("H:i", strtotime($child_query->row['birthdate_time'])),
				'birthweight'       => $child_query->row['birthweight'],
				'birthhead'       => $child_query->row['birthhead'],
				'birthchest'       => $child_query->row['birthchest'],
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
				
	public function getTotalCustomers($data = array()) {
      	$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer c";
		
		$implode = array();
		
		if (!empty($data['filter_name'])) {
			$implode[] = "LCASE(name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		if (!empty($data['filter_room_id'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer_transfer WHERE customer_room_id = '" . $this->db->escape($data['filter_room_id']) . "')";
		}
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "status = '" . (int)$data['filter_status'] . "'";
		}			

		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if (isset($data['filter_showathome']) && !is_null($data['filter_showathome'])) {
			$implode[] = "showathome = '" . (int)$data['filter_showathome'] . "'";
		}	
		
		if (!empty($data['filter_service_id'])) {
			$implode[] = "service_id = '" . (int)$data['filter_service_id'] . "'";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
	}

	public function getTotalCustomersByCustomerRoomId($customer_room_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE customer_room_id = '" . (int)$customer_room_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalCustomersByChildbirthHospital($childbirth_hospital) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE childbirth_hospital = '" . $this->db->escape($childbirth_hospital) . "'");
		
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
			
	public function addTransfer($customer_id, $description = '', $extra_period = '', $customer_room_id = '') {
		$customer_info = $this->getCustomer($customer_id);
		
		if ($customer_info) { 
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_transfer SET customer_id = '" . (int)$customer_id . "', customer_room_id = '" . $this->db->escape($customer_room_id)  . "', description = '" . $this->db->escape($description) . "', extra_period = '" . (int)$extra_period . "', date_added = NOW()");
		}
	}
	
	public function deleteTransfer($customer_id, $customer_transfer_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_transfer WHERE customer_id = '". (int)$customer_id ."' AND customer_transfer_id = '" . (int)$customer_transfer_id . "'");
	}
	
	public function getTransfers($customer_id, $order="ASC", $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT *, cr.name as customer_room_name FROM " . DB_PREFIX . "customer_transfer ct LEFT JOIN ".DB_PREFIX." customer_room cr ON (ct.customer_room_id = cr.customer_room_id) WHERE customer_id = '" . (int)$customer_id . "' ORDER BY customer_transfer_id ".$order." LIMIT " . (int)$start . "," . (int)$limit);
	
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
	
	public function getCustomerPartumDate($customer_id) {
		$query = $this->db->query("SELECT birthdate FROM " . DB_PREFIX . "customer_child WHERE customer_id = '" . (int)$customer_id . "' ORDER BY birthdate ASC");
		
		return $query->row['birthdate'];
	}
	
	public function copyCustomer($customer_id) {
		$query = $this->db->query("SELECT DISTINCT cu.* FROM " . DB_PREFIX . "customer cu LEFT JOIN " . DB_PREFIX . "contact co ON (cu.customer_id = co.customer_id) WHERE cu.customer_id = '" . (int)$customer_id . "' ");

		if ($query->num_rows) {
			$data = array();
			
			$data = $query->row;
			
			//$data['sku'] = '';
			//$data['upc'] = '';
			//$data['viewed'] = '0';
			//$data['keyword'] = '';
			$data['status'] = '1';			$data['date_added'] = date($this->language->get('date_format_longest'), strtotime("now"));
			$data['date_leave'] = date($this->language->get('date_format_longest'), strtotime("+30 days"));
			$data['childbirth_hospital'] = '';
			$data['childbirth_doctor'] = '';
			$data['childbirth_method'] = '';
			$data['pregnancy_weeks'] = '';
						
			//$data = array_merge($data, array('product_attribute' => $this->getProductAttributes($product_id)));
			//$data = array_merge($data, array('product_description' => $this->getProductDescriptions($product_id)));			
			//$data = array_merge($data, array('product_discount' => $this->getProductDiscounts($product_id)));
			//$data = array_merge($data, array('product_filter' => $this->getProductFilters($product_id)));
			//$data = array_merge($data, array('product_image' => $this->getProductImages($product_id)));		
			//$data = array_merge($data, array('product_option' => $this->getProductOptions($product_id)));
			//$data = array_merge($data, array('product_related' => $this->getProductRelated($product_id)));
			//$data = array_merge($data, array('product_reward' => $this->getProductRewards($product_id)));
			//$data = array_merge($data, array('product_special' => $this->getProductSpecials($product_id)));
			//$data = array_merge($data, array('product_category' => $this->getProductCategories($product_id)));
			//$data = array_merge($data, array('product_download' => $this->getProductDownloads($product_id)));
			//$data = array_merge($data, array('product_layout' => $this->getProductLayouts($product_id)));
			//$data = array_merge($data, array('product_store' => $this->getProductStores($product_id)));
			$data = array_merge($data, array('contact' => $this->getContacts($customer_id)));
			
			$this->addCustomer($data);
		}
	}
	
	public function getCustomerLeave($customer_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_leave WHERE customer_id = '" . (int)$customer_id . "' ");
		
		return $query->row;
	}
	
	public function getCustomerChildLeaves($customer_id) {
		$query = $this->db->query("SELECT DISTINCT c.customer_child_id, c.name, cl.chk1, cl.chk2, cl.chk3, cl.jaundice, cl.jaundice_chkdate, cl.medicine, cl.groupchk FROM " . DB_PREFIX . "customer_child c LEFT JOIN " . DB_PREFIX . "customer_child_leave cl ON c.customer_child_id = cl.customer_child_id WHERE c.customer_id = '" . (int)$customer_id . "' ");
		
		return $query->rows;
	}
	
	public function setCustomerLeave($data) {
		//print"<pre>";print_r($data);print"</pre>";
		//exit;

		if (isset($data['customerleaveform'])) {				
      		foreach ($data['customerleaveform'] as $k => $dataleave) {	
			
				for ($i=2;$i<=7;$i++) {
						if (!isset($dataleave['chk'.$i.''])) { $dataleave['chk'.$i.''] = ''; }
				}
				
				$groupchk = (isset($dataleave['groupchk']) && is_array($dataleave['groupchk'])) ? serialize($dataleave['groupchk']) : '';
				$chk6 = (isset($dataleave['chk6']) && is_array($dataleave['chk6'])) ? serialize($dataleave['chk6']) : '';
				$chk7 = (isset($dataleave['chk7']) && is_array($dataleave['chk7'])) ? serialize($dataleave['chk7']) : '';
				
				if ($dataleave['customer_leave_id']) {
					$this->db->query("UPDATE " . DB_PREFIX . "customer_leave SET service_id = '".(int)$dataleave['service_id']."', groupchk = '" . $this->db->escape($groupchk) . "', chk6 = '". $this->db->escape($chk6) ."', chk7 = '". $this->db->escape($chk7) ."', chk2 = '" . $this->db->escape($dataleave['chk2']) . "', chk3 = '" . $this->db->escape($dataleave['chk3']) . "', chk4 = '" . $this->db->escape($dataleave['chk4']) . "', date_added = '".$this->db->escape($dataleave['date_added']). "', date_modify = NOW() WHERE customer_leave_id = '" . (int)$dataleave['customer_leave_id'] . "' AND customer_id = '". (int)$dataleave['customer_id'] ."'");
					
					//$this->db->query("UPDATE " . DB_PREFIX . "customer SET status = '0', date_leave = NOW() WHERE customer_id = '". (int)$dataleave['customer_id'] ."' ");
					$this->db->query("UPDATE " . DB_PREFIX . "customer SET status = '0' WHERE customer_id = '". (int)$dataleave['customer_id'] ."' ");
					
					$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child_leave WHERE customer_leave_id = '" . (int)$dataleave['customer_leave_id'] . "'");					
					if (isset($dataleave['child_leave']) && is_array($dataleave['child_leave'])) {
						foreach ($dataleave['child_leave'] as $childleave) {	
								if (!isset($childleave['chk1'])) { $childleave['chk1'] = ''; }
								$cjaundice = ($childleave['jaundice'] == '') ? 'NULL' : "'".(int)$childleave['jaundice']."'"; 
								$cgroupchk = (isset($childleave['groupchk']) && is_array($childleave['groupchk'])) ? serialize($childleave['groupchk']) : '';
								
								$c2 = array();
								if (isset($childleave['chk2'])&&is_array($childleave['chk2'])) {
									foreach ($childleave['chk2'] as $k => $cc2) {
										if ($cc2 == "其他") {
											$c2[$k] = $cc2.":".$childleave['chk2_other'];
										} else {
											$c2[$k] = $cc2;
										}
									}
								}
								$cchk2 = (!empty($c2)) ? serialize($c2) : '';
								
								$medicine = array();
								if (isset($childleave['medicine'])&&is_array($childleave['medicine'])) {
									foreach ($childleave['medicine'] as $k => $ccm) {
										if ($ccm == "其他") {
											$medicine[$k] = $ccm.":".$childleave['medicine_other'];
										} else {
											$medicine[$k] = $ccm;
										}
									}
								}
								$cmedicine = (!empty($medicine)) ? serialize($medicine) : '';

								$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_leave SET customer_leave_id = '" . (int)$dataleave['customer_leave_id'] . "', customer_child_id = '". (int)$childleave['customer_child_id'] ."', groupchk = '" . $this->db->escape($cgroupchk) . "', chk2 = '". $this->db->escape($cchk2) ."', chk1 = '" . $this->db->escape($childleave['chk1']) . "', jaundice = " . $cjaundice . ", jaundice_chkdate = '" . $this->db->escape($childleave['jaundice_chkdate']) . "', medicine = '" . $this->db->escape($cmedicine) . "' ");
								
								//$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET date_leave = NOW() WHERE customer_child_id = '". (int)$childleave['customer_child_id'] ."' ");
						}
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_leave SET  customer_id = '" . (int)$dataleave['customer_id'] . "', service_id = '".(int)$dataleave['service_id']."', groupchk = '" . $this->db->escape($groupchk) . "', chk6 = '". $this->db->escape($chk6) ."', chk7 = '". $this->db->escape($chk7) ."', chk2 = '" . $this->db->escape($dataleave['chk2']) . "', chk3 = '" . $this->db->escape($dataleave['chk3']) . "', chk4 = '" . $this->db->escape($dataleave['chk4']) . "', date_added = '".$this->db->escape($dataleave['date_added']). "', date_modify = NOW() ");
					
					$customer_leave_id = $this->db->getLastId();
					
					//$this->db->query("UPDATE " . DB_PREFIX . "customer SET status = '0', date_leave = NOW() WHERE customer_id = '". (int)$dataleave['customer_id'] ."' ");
					$this->db->query("UPDATE " . DB_PREFIX . "customer SET status = '0' WHERE customer_id = '". (int)$dataleave['customer_id'] ."' ");
															
					if (isset($dataleave['child_leave']) && is_array($dataleave['child_leave'])) {
						foreach ($dataleave['child_leave'] as $childleave) {	
								$this->db->query("DELETE FROM " . DB_PREFIX . "customer_child_leave WHERE customer_child_id = '" . (int)$childleave['customer_child_id'] . "'");		
							
								if (!isset($childleave['chk1'])) { $childleave['chk1'] = ''; }
								$cjaundice = ($childleave['jaundice'] == '') ? 'NULL' : "'".(int)$childleave['jaundice']."'"; 
								$cgroupchk = (isset($childleave['groupchk']) && is_array($childleave['groupchk'])) ? serialize($childleave['groupchk']) : '';
								
								$c2 = array();
								if (isset($childleave['chk2'])&&is_array($childleave['chk2'])) {
									foreach ($childleave['chk2'] as $k => $cc2) {
										if ($cc2 == "其他") {
											$c2[$k] = $cc2.":".$childleave['chk2_other'];
										} else {
											$c2[$k] = $cc2;
										}
									}
								}
								$cchk2 = (!empty($c2)) ? serialize($c2) : '';
								
								$medicine = array();
								if (isset($childleave['medicine'])&&is_array($childleave['medicine'])) {
									foreach ($childleave['medicine'] as $k => $ccm) {
										if ($ccm == "其他") {
											$medicine[$k] = $ccm.":".$childleave['medicine_other'];
										} else {
											$medicine[$k] = $ccm;
										}
									}
								}
								$cmedicine = (!empty($medicine)) ? serialize($medicine) : '';
								
								$this->db->query("INSERT INTO " . DB_PREFIX . "customer_child_leave SET customer_leave_id = '" . (int)$customer_leave_id . "', customer_child_id = '". (int)$childleave['customer_child_id'] ."', groupchk = '" . $this->db->escape($cgroupchk) . "', chk2 = '". $this->db->escape($cchk2) ."', chk1 = '" . $this->db->escape($childleave['chk1']) . "', jaundice = " . $cjaundice . ", jaundice_chkdate = '" . $this->db->escape($childleave['jaundice_chkdate']) . "', medicine = '" . $this->db->escape($cmedicine) . "' ");
								
								//$this->db->query("UPDATE " . DB_PREFIX . "customer_child SET date_leave = NOW() WHERE customer_child_id = '". (int)$childleave['customer_child_id'] ."' ");
						}
					}
				}
			}			
		}
		
		
	}
			
}
?>