(function($){ //Plugins
	
	
/****************************************
 * 
 *	Match Column heights
 *
 *
 *****************************************/
$.fn.equalHeight = function() {
	
    var max_bottom = 0;

    this.each(function() {
        var bottom = $(this).offset().top + $(this).outerHeight();
        if (bottom > max_bottom) max_bottom = bottom;
    });

    return this.each(function() {
        var offtop = $(this).offset().top,
		curheight = $(this).outerHeight(),
		diff = curheight - $(this).height(),
		bottom = offtop + curheight;

        if (max_bottom > bottom) $(this).height(max_bottom - offtop - diff);
    });
};		


/****************************************
 * 
 *	Clear input field on focus
 *  
 *	used to clear the search form text
 *
 *****************************************/
$.fn.clearField = function() { 

	return this.focus(function() { 
		console.log('test');
		if (this.value == this.defaultValue) { 
			this.value = ''; 
		} 
	})
	.blur(function() { 
		if (!this.value.length) { 
			this.value = this.defaultValue; 
		} 
	}); 
}; 
	
/*****************************
 * 
 * Placeholder Labels - Sets the placeholder for input fields to the label text and hides the labels
 * 
 * If Placeholder support is not current in the browser it will fall back to 
 * using the value attribute and assign a click event to clear it
 * 
    jQuery("#form").placeholderLabels();
 * 
 * 
 * You can also pass in the field selectors in manually:
 * 
    jQuery("div.Block").placeholderLabels({
    	"labelselector" : "label.myLabel", 
    	"fieldselector" : "input.myinput", 
    });
 * 
 *****************************/ 
	
	$.fn.placeholderLabels = function(options)		
	{ 
		var settings = {
			'source' : 'label', // or 'field'
			'labelselector' : '.text label.left, .textarea label.left, .email label.left',
			'inputselector' : 'input.text, textarea'
	    };			

		if ( options ) { 
			$.extend( settings, options );
		}

		return this.each(function() 
		{  		
			var $Form = jQuery(this);
			
			var i = document.createElement('input'); //Create Input for testing later, saves us doing it each time further down
			
			if(settings.source === 'label')
			{
				var $Items = $Form.find(settings.labelselector);
			}		
			else if(settings.source === 'field')
			{
				var $Items = $Form.find(settings.inputselector);
			}
			
			$Items.each(function()
			{
				var $field;
				var text = "";
				
				if(jQuery(this).is('label'))
				{
					$field = $Form.find('#' + jQuery(this).attr('for'));	
					text = jQuery(this).html();
					
					jQuery(this).hide();
				}
				else
				{
					$field = jQuery(this);
					text = $field.val();	
					$field.val("");	
				}
				
				if($field.length)
				{
					if ('placeholder' in i) //Supports Placeholder
					{
						$field.attr('placeholder', text);	
					}
					else
					{
						$field.val(text);
						
						$field.focusin(function()
						{
							if ($field.val() === text) 
							{
								$field.val("");
							}
							
							return false;
						});
						
						$field.focusout(function()
						{
							if (jQuery(this).val().length < 1) 
							{
								$field.val(text);
							}
						});
					}					
				}
			});			
		
		});
	}

/*****************************
 * 
 * Block Click - Creates a clickable block
 * 
    jQuery("div.Block").blockClick();
 * 
 * This will find the first link within div.block and use the href from that
 * 
 * You can also pass in the link selector manually like so:
 * 
    jQuery("div.Block").blockClick("a.myLink");
 * 
 *****************************/ 

	$.fn.blockClick = function(options)		
	{ 
		var settings = {
		      'link'  : 'a'
	    };			

		if ( options ) { 
			$.extend( settings, options );
		}

		return this.each(function() 
		{  		
			jQuery(this).click(function() {
				window.location = jQuery(this).find(settings.link).attr("href");
			});
			
			jQuery(this).hover(  
				function() {
			    	jQuery(this).addClass("hover");   
				},  
				function() {  
			    	jQuery(this).removeClass("hover");  
				}  
			);					
		});
	}	

})(jQuery);