<?php

class ContactPage extends Page
{

}

class ContactPage_Controller extends Page_Controller
{
	static $allowed_actions = array(
		'ContactForm'		
	);
	
	public function init()
	{
		parent::init();

		requirements::customScript(<<<JS
			jQuery('document').ready(function(){
				jQuery('#ContactForm_ContactForm').placeholderLabels();
			})
JS
		);
	}
	
	
	function ContactForm() {
	    return new ContactForm($this, 'ContactForm');
	}

	public function Success(){
		return isset($_REQUEST['success']) && $_REQUEST['success'] == "1";
	}
}