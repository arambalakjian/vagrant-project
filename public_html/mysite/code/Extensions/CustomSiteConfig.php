<?php
/****************
 * 
 * Example SiteConfig
 * 
 */
class CustomSiteConfig extends DataExtension {
	
	static $db = array(
		'SendFormsTo' => 'Varchar(255)',
		'SendEmailsFrom' => 'Varchar(255)'
	);
	
	public function updateCMSFields(FieldList $fields) {
		
		$fields->removeFieldFromTab('Root.Main', 'Theme');
		
		$fields->addFieldToTab("Root.Main", new TextField("SendFormsTo", 'Send submitted forms to (comma separated)'));
		$fields->addFieldToTab("Root.Main", new TextField("SendEmailsFrom", "Send emails 'from' this address (SPF record recommended)"));
   	}
}