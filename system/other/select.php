<?php
class SelectorPrinter {
	var $Title;
	var $type;
	var $arrOption = array();
	var $formRow;
	var $checkField;
	var $printBody;
	var $formName;
	var $itemSelected;

	function SelectorPrinter() {
		$this -> Title = 'Unset title yet!';
		$this -> type = 'radio';
		//$this -> arrOption = array("¬O", "§_");
		$this -> arrOption = array('a', 'b','c','d','e');
		$this -> formRow = 1;
		$this -> checkField = 'chk1';
	}
	
	

	function combine() {

		$this -> printBody = "<td>" . $this -> Title . ": </td>";
		$this -> printBody .= <<<EOD
			<td><div class="scrollbox">
EOD;

		$arrNum = count($this -> arrOption);
		$foo = $this -> arrStatList($arrNum);
		

		echo $this->itemSelected;
		if($this->type == "radio"){
			for ($i = 0; $i < $arrNum; $i++) {
				if($this -> arrOption[$i] == $this->itemSelected){
					$bar .= '<div class="' . $foo[$i] . '">';
					$bar .= '<input type="' . $this -> type . '"' . ' name="' . $this -> formName . '[' . $this -> formRow . '][' . $this -> checkField . ']"' . ' value="' . $this -> arrOption[$i] . '" checked="">' . $this -> arrOption[$i] . '</div>';
				}else{
					$bar .= '<div class="' . $foo[$i] . '">';
					$bar .= '<input type="' . $this -> type . '"' . ' name="' . $this -> formName . '[' . $this -> formRow . '][' . $this -> checkField . ']"' . ' value="' . $this -> arrOption[$i] . '">' . $this -> arrOption[$i] . '</div>';
				}
			}
			$this -> printBody .= $bar;
			$this -> printBody .= '</div></td>';	
		}else{
			for ($i = 0; $i < $arrNum; $i++) {
				if($this -> arrOption[$i] == $this->itemSelected){
					$bar .= '<div class="' . $foo[$i] . '">';
					$bar .= '<input type="' . $this -> type . '"' . ' name="' . $this -> formName . '[' . $this -> formRow . '][' . $this -> checkField . '][]"' . ' value="' . $this -> arrOption[$i] . '" checked="">' . $this -> arrOption[$i] . '</div>';
				}else{
					$bar .= '<div class="' . $foo[$i] . '">';
					$bar .= '<input type="' . $this -> type . '"' . ' name="' . $this -> formName . '[' . $this -> formRow . '][' . $this -> checkField . ']"' . ' value="' . $this -> arrOption[$i] . '">' . $this -> arrOption[$i] . '</div>';
				}
			}
			$this -> printBody .= $bar;
			$this -> printBody .= '</div></td>';
		}

		

		return $this -> printBody;

	}

	function arrStatList($e) {
		$foo = array();

		for ($i = 0; $i < $e; $i++) {
			if (($i + 1) % 2) {
				$foo[$i] = "odd";
			} else {
				$foo[$i] = "even";
			}
		}
		return $foo;
	}

}
?>