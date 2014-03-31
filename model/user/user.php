<?php
class ModelUserUser extends Model {
	public function addUser($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "user` SET username = '" . $this->db->escape($data['username']) . "', password = '" . $this->db->escape(md5($data['password'])) . "',  name = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', user_group_id = '" . (int)$data['user_group_id'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
	}
	
	public function editUser($user_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "user` SET username = '" . $this->db->escape($data['username']) . "', name = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', user_group_id = '" . (int)$data['user_group_id'] . "', status = '" . (int)$data['status'] . "' WHERE user_id = '" . (int)$user_id . "'");
		
		if ($data['password']) {
			$this->db->query("UPDATE `" . DB_PREFIX . "user` SET password = '" . $this->db->escape(md5($data['password'])) . "' WHERE user_id = '" . (int)$user_id . "'");
		}
	}

	public function editPassword($user_id, $password) {
		$this->db->query("UPDATE `" . DB_PREFIX . "user` SET password = '" . $this->db->escape(md5($password)) . "' WHERE user_id = '" . (int)$user_id . "'");
	}

	public function editCode($email, $code) {
		$this->db->query("UPDATE `" . DB_PREFIX . "user` SET code = '" . $this->db->escape($code) . "' WHERE email = '" . $this->db->escape($email) . "'");
	}
			
	public function deleteUser($user_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "user` WHERE user_id = '" . (int)$user_id . "'");
	}
	
	public function getUser($user_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "user` WHERE user_id = '" . (int)$user_id . "'");
	
		return $query->row;
	}
	
	public function getUserByUsername($username) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "user` WHERE username = '" . $this->db->escape($username) . "'");
	
		return $query->row;
	}
		
	public function getUserByCode($code) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "user` WHERE code = '" . $this->db->escape($code) . "' AND code != ''");
	
		return $query->row;
	}
		
	public function getUsers($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "user`";
			
		$sort_data = array(
			'username',
			'name',
			'user_group_id',
			'status',
			'date_added',
			'date_end'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY username";	
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

	public function getTotalUsers() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user`");
		
		return $query->row['total'];
	}

	public function getTotalUsersByGroupId($user_group_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user` WHERE user_group_id = '" . (int)$user_group_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalUsersByEmail($email) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user` WHERE email = '" . $this->db->escape($email) . "'");
		
		return $query->row['total'];
	}	
	
	public function setUserOnduty($user_id, $time) {
		//$query = $this->db->query("SELECT date_duty FROM `" . DB_PREFIX . "user_dailysign` WHERE user_id = '". (int)$user_id ."' AND DATE('". $this->db->escape($time) ."') = CURDATE() AND date_finishwork IS NULL");
		$query = $this->db->query("SELECT date_duty FROM `" . DB_PREFIX . "user_dailysign` WHERE user_id = '". (int)$user_id ."' AND date_duty >= NOW() - INTERVAL 1 DAY  AND date_finishwork IS NULL Limit 0,1");

		if ($query->num_rows) {
			return $query->row['date_duty'];
		} else {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "user_dailysign` SET user_id = '".(int)$user_id."', date_duty = '" . $time . "', ip_in = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' ");
			return false;
		}
	}
	
	public function setUserFinishwork($user_id, $time) {
		//$query = $this->db->query("SELECT id, date_duty, date_finishwork FROM `" . DB_PREFIX . "user_dailysign` WHERE user_id = '". (int)$user_id ."' AND date_duty IS NOT NULL AND date_finishwork IS NULL AND NOW( ) <= date_duty + INTERVAL 1 DAY ORDER BY date_duty DESC Limit 0,1");
		$query = $this->db->query("SELECT id, date_duty, date_finishwork FROM `" . DB_PREFIX . "user_dailysign` WHERE user_id = '". (int)$user_id ."' AND ( date_duty IS NOT NULL AND NOW( ) <= date_duty + INTERVAL 1 DAY ) OR ( date_duty IS NULL AND NOW( ) <= date_finishwork + INTERVAL 12 HOUR )  ORDER BY date_duty DESC Limit 0,1");
		
		if (!$query->num_rows) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "user_dailysign` SET date_finishwork = '" . $time . "', ip_leave = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', user_id = '". (int)$user_id ."' ");
			return 'nontodayduty';
		} else {
			if (!$query->row['date_finishwork']) {
				$this->db->query("UPDATE `" . DB_PREFIX . "user_dailysign` SET date_finishwork = '" . $time . "', ip_leave = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE id = '". (int)$query->row['id'] ."' AND user_id = '". (int)$user_id ."' ");
				return false;
			} else {
				return $query->row['date_finishwork'];
			}
		}
	}
	
	public function getUserOndutyTime($user_id) {
		$query = $this->db->query("SELECT date_duty FROM `" . DB_PREFIX . "user_dailysign` WHERE user_id = '". (int)$user_id ."' AND date_duty >= NOW() - INTERVAL 1 DAY  AND date_finishwork IS NULL Limit 0,1");
		
		if ($query->num_rows) {
			return $query->row['date_duty'];
		} else {
			return false;
		}
	}
}
?>