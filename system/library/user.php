<?php
class User {
	private $user_id;
	private $username;
	private $name;
	private $user_group_id;
  	private $permission = array();

  	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		
    	if (isset($this->session->data['user_id'])) {
			$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE user_id = '" . (int)$this->session->data['user_id'] . "' AND status = '1' AND ( date_end >= CURDATE() OR date_end = '0000-00-00' )");
			
			if ($user_query->num_rows) {
				$this->user_id = $user_query->row['user_id'];
				$this->username = $user_query->row['username'];
				$this->name = $user_query->row['name'];
				$this->user_group_id = $user_query->row['user_group_id'];
				
      			$this->db->query("UPDATE " . DB_PREFIX . "user SET date_login = NOW(), ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE user_id = '" . (int)$this->session->data['user_id'] . "'");

      			$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");
				
	  			$permissions = unserialize($user_group_query->row['permission']);

				if (is_array($permissions)) {
	  				foreach ($permissions as $key => $value) {
	    				$this->permission[$key] = $value;
	  				}
				}
			} else {
				$this->logout();
			}
    	}
  	}
		
  	public function login($username, $password) {
		   $user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE username = '" . $this->db->escape($username) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = '1' AND ( date_end >= CURDATE() OR date_end = '0000-00-00' ) ");

    	if ($user_query->num_rows) {
			$this->session->data['user_id'] = $user_query->row['user_id'];
			
			$this->user_id = $user_query->row['user_id'];
			$this->username = $user_query->row['username'];		
			$this->name = $user_query->row['name'];			

      		$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

	  		$permissions = unserialize($user_group_query->row['permission']);

			if (is_array($permissions)) {
				foreach ($permissions as $key => $value) {
					$this->permission[$key] = $value;
				}
			}
		
      		return true;
    	} else {
      		return false;
    	}
  	}

  	public function logout() {
		unset($this->session->data['user_id']);
	
		$this->user_id = '';
		$this->username = '';
		$this->name = '';
		
		session_destroy();
  	}

  	public function hasPermission($key, $value) {
    	if (isset($this->permission[$key])) {
	  		return in_array($value, $this->permission[$key]);
		} else {
	  		return false;
		}
  	}
  
  	public function isLogged() {
    	return $this->user_id;
  	}
  
  	public function getId() {
    	return $this->user_id;
  	}
	
  	public function getUserName() {
    	return $this->username;
  	}	
	
  	public function getName() {
    	return $this->name;
  	}	
	
	public function getGroupId() {
    	return $this->user_group_id;
  	}	
	
	public function getGroupName($group_id) {
    	$user_group_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$group_id . "'");
		
		return $user_group_query->row['name'];
  	}	
}
?>