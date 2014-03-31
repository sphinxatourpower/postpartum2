<?php
class ModelNurseNurse extends Model {
	public function getNurse234bminmax($child_id) {

		$sql = "SELECT MIN( mydate ) mindate, MAX( mydate ) maxdate
		FROM (
		SELECT date_added AS mydate
		FROM child_nurse2b
		WHERE child_nurse2b.customer_child_id = '".$child_id."'
		UNION ALL 
		SELECT date_added AS mydate
		FROM child_nurse3b
		WHERE child_nurse3b.customer_child_id = '".$child_id."'
		UNION ALL 
		SELECT date_added AS mydate
		FROM child_nurse4b
		WHERE child_nurse4b.customer_child_id = '".$child_id."'
		) AS nursetable";
		
		$query = $this->db->query($sql);
		return $query->row;
	
	}
	
	public function getNurse2bByDateArrange($date, $arrange, $child_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "child_nurse2b WHERE customer_child_id = '" . (int)$child_id . "' AND date_added = '". $date ."' AND arrangement = '". $arrange ."'");
	
		return $query->row;

	}
	
	public function getNurse3bByDateArrange($date, $arrange, $child_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "child_nurse3b WHERE customer_child_id = '" . (int)$child_id . "' AND date_added = '". $date ."' AND arrangement = '". $arrange ."'");
	
		return $query->row;
	}
	
	public function getNurse4bByDateArrange($date, $arrange, $child_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "child_nurse4b WHERE customer_child_id = '" . (int)$child_id . "' AND date_added = '". $date ."' AND arrangement = '". $arrange ."'");
	
		return $query->row;
	}
	
	public function getDateRangeArray($strDateFrom,$strDateTo,$arrangearr) {
		$start = new DateTime($strDateFrom);
		$end = new DateTime($strDateTo);
		$oneday = new DateInterval("P1D");

		$days = array();

		foreach(new DatePeriod($start, $oneday, $end->add($oneday)) as $k => $day) {
			if (!empty($arrangearr)) {
				foreach ($arrangearr as $ar) {
					$days['date'][] = $day->format("Y-m-d");
					$days['arrangement'][] = $ar;
				}
			} else {
				$days['date'][] = $day->format("Y-m-d");
			}
		}    

		return $days;		
	}
	
	public function createDateRangeArray($strDateFrom,$strDateTo, $arrangearr) {
	  // takes two dates formatted as YYYY-MM-DD and creates an
	  // inclusive array of the dates between the from and to dates.

	  // could test validity of dates here but I'm already doing
	  // that in the main script

	  $aryRange=array();
	  $days = array();

	  $iDateFrom=mktime(1,0,0,substr($strDateFrom,5,2),     substr($strDateFrom,8,2),substr($strDateFrom,0,4));
	  $iDateTo=mktime(1,0,0,substr($strDateTo,5,2),     substr($strDateTo,8,2),substr($strDateTo,0,4));

	  if ($iDateTo>=$iDateFrom) {
		array_push($aryRange,date('Y-m-d',$iDateFrom)); // first entry

		while ($iDateFrom<$iDateTo) {
		  $iDateFrom+=86400; // add 24 hours
		  array_push($aryRange,date('Y-m-d',$iDateFrom));
		}
	  }
	  
	  foreach($aryRange as $k => $day) {
		if (!empty($arrangearr)) {
			foreach ($arrangearr as $ar) {
				$days['date'][] = $day;
				$days['arrangement'][] = $ar;
			}
		} else {
			$days['date'][] = $day;
		}
	  }
	  
	  return $aryRange;
	}
	
			
}
?>