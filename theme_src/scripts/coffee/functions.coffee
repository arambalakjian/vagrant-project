### global jQuery ###
do ($ = jQuery) ->

  ###
  # Match Column heights
  ###
  $.fn.equalHeight = ->

    max_bottom = 0
    this.each ->
      bottom = $(this).offset().top + $(this).outerHeight()
      max_bottom = bottom if bottom > max_bottom
      return
    this.each ->
      offtop = $(this).offset().top
      curheight = $(this).outerHeight()
      height = $(this).height()
      padding = curheight - $(this).height()
      bottom = offtop + curheight
      if max_bottom > bottom then $(this).height(max_bottom - offtop - padding)

  ###
  # Clear input field on focus
  #
  # Used to clear the search form text
  ###
  $.fn.clearField = ->
    onFocus ->
      this.value = '' if this.defaultValue is this.value
      return
    onBlur ->
      this.value = this.defaultValue if not this.value.length
      return
    this.focus(onFocus).blur(onBlur)

  ###
  # Placeholder Labels - Sets the placeholder for input fields to the label
  # text and hides the labels
  #
  # If Placeholder support is not current in the browser it will fall back to
  # using the value attribute and assign a click event to clear it
  #
  # jQuery("#form").placeholderLabels();
  #
  #
  # You can also pass in the field selectors in manually:
  #
  # jQuery("div.Block").placeholderLabels({
  #	"labelselector" : "label.myLabel",
  #	"fieldselector" : "input.myinput",
  # });
  ###
  $.fn.placeholderLabels = (options) ->
    settings =
      source: label,
      labelselector: '.text label.left, .textarea label.left,
      .email label.left, .dropdown label.left'
      inputselector: 'input.text, textarea,select'
    options = $.extend(settings, options) if options isnt null

    this.each ->
      $Form = $(this)
      ### Create input for testing later,
      saves us doing it each time further down ###
      i = document.createElement('input')
      if settings.source is 'label'
        $Items = $Form.find(settings.labelselector)
      else if settings.source is 'field'
        $Items = $Form.find(settings.inputselector)
	 
      $Items.each ->
        $this = $(this)
        text = ''

        if $this.is('label')
          $field = $Form.find('#'+$this.attr('for'))
          text = $this.html()
          $this.hide()
	        
        else
          $field = $this
          text = $field.val()
          $field.val('')

        if $field.length
          if $field.is('select')
            $field.prepend(
              '<option value="0" class="empty" selected="1">'+text+'</option>'
            )
            return
          else
            if 'placeholder' in i
              $field.attr('placeholder', text)
              return
            else
              $field.val(text)
              $field.focusin ->
                if $field.val() is text then $field.val('')
                return false
              $field.focusout ->
                if $this.val().length < 1 then $field.val(text)
                return
              return
  ###
  # Block Click - Creates a clickable block
  #
  # jQuery("div.Block").blockClick();
  #
  # This will find the first link within div.block and use the href from that.
  # You can also pass in the link selector manually like so:
  #
  # jQuery("div.Block").blockClick("a.myLink");
  ###
  $.fn.blockClick = (options) ->
    settings =
      link: 'a'
      class: 'hover'
    options = $.extend(settings, options) if options isnt null
		
    this.each ->
      $this = $(this)
      $this.click ->
        window.location = $this.find(options.link).attr('href')
        return
      onHover -> $this.addClass(options.class); return
      offHover -> $this.removeClass(options.class); return
      $this.hover(onHover, offHover)
      return

  return