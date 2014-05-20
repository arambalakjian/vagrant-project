<?php

/*******************************************************************
 * 
 * Generic Contact form
 * 
 * Call from your controller like so:
 * 
 * function ContactForm()
 * {
 * 	return new ContactFrom($this, 'ContactForm');
 * }
 * 
 * Aab Web
 * www.aabweb.co.uk
 * 
 * author: Aram Balakjian
 * date: 13.02.2012
 * version: 1.0.0
 * 
 ********************************************************************/

class ContactForm extends Form 
{
	static $email_subject = "Website - General enquiry";
	static $email_template = "ContactEmail";
	
	protected $ajax_submit = true;	
	
    function __construct($controller, $name) 
	{
		//Get the requirements
		$this->getJS();
		
		//Get the fields
	    $fields = $this->getInputFields();
	 	
	    // Create action
	    $actions = new FieldList(
	    	new FormAction('SendForm', 'Send')
	    );
		
		// get the Validator
		$validator = $this->getValidator();

        parent::__construct($controller, $name, $fields, $actions, $validator);
    
    }
   
   	function getInputFields()
	{
		return new FieldList(
		    new TextField('Name', '* Name'),
			new EmailField('Email', '* Email'),
			new TextareaField('Comments','* Comments')
		);
	}
   
   	function getValidator()
	{
		return new ContactFormValidator('Name', 'Email', 'Comments');
	}
   
   	function getJS()
	{
		Requirements::customScript('
			jQuery(document).ready(function() 
			{
				jQuery("#ContactForm_ContactForm").validate({
					rules: {
						Name: "required",
						Email: {
							required: true,
							email: true
						},
						Comments: {
							required: true,
							minlength: 10
						}
					},
					messages: {
					Name: "Please enter your name.",
					Email: "Please enter a valid email address.",
					Comments: "Messages must have at least 10 characters."
					}
				});			
			});
		');	
		
		if($this->ajax_submit)
		{
			//For Ajax
			Requirements::javascript("framework/thirdparty/jquery-form/jquery.form.js");			
			Requirements::customScript('							
					//Support Form AJAX Submit
				    var options = { 
				        success:       showResponse,  // post-submit callback 
						beforeSubmit:  checkForm // add this to your ajaxForms options
				
				    }; 
				 		 
					function checkForm(data,form)
					{ 
						return jQuery(form).valid();
					}
				 		 
					function showResponse()
					{
						jQuery("#ContactForm_ContactForm").fadeOut(function()
						{
							jQuery("#contact-response").fadeIn();
						});
						
					}
					
				    jQuery("#ContactForm_ContactForm").ajaxForm(options); 	
			');					
		}
	}
   
	function SendForm($data, $form) {
      
	  	$siteConfig = SiteConfig::current_site_config();
	 	
		//Create Email	  
	 	$email = new Email($siteConfig->SendFormsFrom, $this->getToAddress($data), $this->stat('email_subject'));
		
		if(isset($data['Email']))
		{
			$email->replyTo($data['Email']);
		}

		//set template
		$email->setTemplate($this->stat('email_template'));
		//populate template
		$email->populateTemplate($data);
		//send mail
		if($email->send())
		{
		  	//return to submitted message
		  	if(Director::is_ajax())
			{
				return true;
			}
			else
			{
				return $this->success($form);
			}
		}
	}  

	public function success($form)
	{
		return Director::redirect($form->controller->Link( "?success=1"));
	}

	//returns the address to send the form to
	public function getToAddress($data)
	{
		return SiteConfig::current_site_config()->SendFormsTo;
	}

	//Enable or disable ajax submit on this form
	public function setAjaxSubmit($values)
	{
	   $this->ajax_submit = $values;
	}

}