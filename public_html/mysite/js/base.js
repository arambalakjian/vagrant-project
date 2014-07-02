/*!
 * base Theme version: 0.0.0
 * A Carbon Crayon SilverStripe base theme
 * Copyright 2014 Carbon Crayon 
 * Distributed under the MIT license
 * https://github.com/carboncrayon/base-ss
 */

/* global jQuery */

(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  (function($) {

    /*
     * Match Column heights
     */
    $.fn.equalHeight = function() {
      var max_bottom;
      max_bottom = 0;
      this.each(function() {
        var bottom;
        bottom = $(this).offset().top + $(this).outerHeight();
        if (bottom > max_bottom) {
          max_bottom = bottom;
        }
      });
      return this.each(function() {
        var bottom, curheight, height, offtop, padding;
        offtop = $(this).offset().top;
        curheight = $(this).outerHeight();
        height = $(this).height();
        padding = curheight - $(this).height();
        bottom = offtop + curheight;
        if (max_bottom > bottom) {
          return $(this).height(max_bottom - offtop - padding);
        }
      });
    };

    /*
     * Clear input field on focus
     *
     * Used to clear the search form text
     */
    $.fn.clearField = function() {
      var onBlur, onFocus;
      onFocus = function() {
        if (this.defaultValue === this.value) {
          this.value = '';
        }
      };
      onBlur = function() {
        if (!this.value.length) {
          this.value = this.defaultValue;
        }
      };
      return this.focus(onFocus).blur(onBlur);
    };

    /*
     * Placeholder Labels - Sets the placeholder for input fields to the label
     * text and hides the labels
     *
     * If Placeholder support is not current in the browser it will fall back to
     * using the value attribute and assign a click event to clear it
     *
     * jQuery("#form").placeholderLabels();
     *
     *
     * You can also pass in the field selectors in manually:
     *
     * jQuery("div.Block").placeholderLabels({
     *	"labelselector" : "label.myLabel",
     *	"fieldselector" : "input.myinput",
     * });
     */
    $.fn.placeholderLabels = function(options) {
      var settings;
      settings = {
        source: label,
        labelselector: '.text label.left, .textarea label.left, .email label.left, .dropdown label.left',
        inputselector: 'input.text, textarea,select'
      };
      if (options !== null) {
        options = $.extend(settings, options);
      }
      return this.each(function() {
        var $Form, $Items, i;
        $Form = $(this);

        /* Create input for testing later,
        saves us doing it each time further down
         */
        i = document.createElement('input');
        if (settings.source === 'label') {
          $Items = $Form.find(settings.labelselector);
        } else if (settings.source === 'field') {
          $Items = $Form.find(settings.inputselector);
        }
        return $Items.each(function() {
          var $field, $this, text;
          $this = $(this);
          text = '';
          if ($this.is('label')) {
            $field = $Form.find('#' + $this.attr('for'));
            text = $this.html();
            $this.hide();
          } else {
            $field = $this;
            text = $field.val();
            $field.val('');
          }
          if ($field.length) {
            if ($field.is('select')) {
              $field.prepend('<option value="0" class="empty" selected="1">' + text + '</option>');
            } else {
              if (__indexOf.call(i, 'placeholder') >= 0) {
                $field.attr('placeholder', text);
              } else {
                $field.val(text);
                $field.focusin(function() {
                  if ($field.val() === text) {
                    $field.val('');
                  }
                  return false;
                });
                $field.focusout(function() {
                  if ($this.val().length < 1) {
                    $field.val(text);
                  }
                });
              }
            }
          }
        });
      });
    };

    /*
     * Block Click - Creates a clickable block
     *
     * jQuery("div.Block").blockClick();
     *
     * This will find the first link within div.block and use the href from that.
     * You can also pass in the link selector manually like so:
     *
     * jQuery("div.Block").blockClick("a.myLink");
     */
    $.fn.blockClick = function(options) {
      var settings;
      settings = {
        link: 'a',
        "class": 'hover'
      };
      if (options !== null) {
        options = $.extend(settings, options);
      }
      return this.each(function() {
        var $this;
        $this = $(this);
        $this.click(function() {
          window.location = $this.find(options.link).attr('href');
        });
        onHover(function() {
          $this.addClass(options["class"]);
        });
        offHover(function() {
          $this.removeClass(options["class"]);
        });
        $this.hover(onHover, offHover);
      });
    };
  })(jQuery);

}).call(this);

//# sourceMappingURL=functions.js.map
;(function() {
  (function($) {})(jQuery);

}).call(this);

//# sourceMappingURL=app.js.map
