<?php
class ControllerCommonFooter extends Controller {   
	protected function index() {
		$this->load->language('common/footer');
		
		$this->data['text_footer'] = sprintf($this->language->get('text_footer'), PCOMPANY, APPNAME, VERSION, OURPOWER_SUPPORT_URL, OURPOWER_SUPPORT);
		
		$this->template = 'common/footer.tpl';
	
    	$this->render();
  	}
}
?>