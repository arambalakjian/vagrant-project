<?php

class ContactFormValidator extends RequiredFields
{
	/**
	* Allows validation of fields via specification of a php function for validation which is executed after
	* the form is submitted
	*/
	function php($data) 
	{
		$valid = true;
		
		$valid = parent::php($data);

		$Comments = isset($data['Comments']) ? $data['Comments'] : null;
		
		if($Comments != strip_tags($Comments)) 
		{
			$this->validationError(
				'Comments',
				'Please do not include HTML in your comment',
				"bad"
			);
			$valid = false;
		}
		
		if(isset($data['Empty']) && $data['Empty'] != '')
		{
			$this->validationError(
				'Empty',
				'Please leave this field empty',
				"bad"
			);
			$valid = false;
		}

		return $valid;
	}
}