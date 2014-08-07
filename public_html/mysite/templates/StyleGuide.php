<?php
class StyleGuide_Controller extends Page_Controller
{
	const URLSegment = 'styles';

	static $allowed_actions = array(
		'view' => 'ADMIN'
	);

	public function init()
	{
		parent::init();
	}
	/**
	 * view the styles 
	 * 
	 * @return String
	 */	
	public function view()
	{
		return $this->renderWith('StyleGuide');
	}
}