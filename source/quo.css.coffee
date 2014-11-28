###
CSS Quo Module

@namespace Quo
@class css

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  VENDORS = [ "-webkit-", "-moz-", "-ms-", "-o-", "" ]

  ###
  Add class to a given instance element
  @method addClass
  @param  {string} Name of stylesheet class
  ###
  $$.fn.addClass = (values) ->
    @each ->
      @classList.add value for value in _arrayOf values


  ###
  Remove stylesheet class to a given instance element
  @method addClass
  @param  {string} Name of stylesheet class
  ###
  $$.fn.removeClass = (values) ->
    @each ->
      @classList.remove value for value in _arrayOf values


  ###
  Toggle stylesheet class to a given instance element
  @method addClass
  @param  {string} Name of stylesheet class
  ###
  $$.fn.toggleClass = (values) ->
    @each ->
      @classList.toggle value for value in _arrayOf values


  ###
  Test if a stylesheet class is in the giben instance element
  @method hasClass
  @param  {string} Name of stylesheet class
  ###
  $$.fn.hasClass = (name) ->
    @length > 0 and @[0].classList.contains name


  ###
  List a object with all classes in a given instance element
  @method listClass
  @param  {string} Name of stylesheet class
  ###
  $$.fn.listClass = ->
    @[0].classList if @length > 0


  ###
  Set/Get a stylesheet property in a given instance element
  @method style
  @param  {string} Name of property
  @param  {string} [OPTIONAL] Value for property
  ###
  $$.fn.style = $$.fn.css = (property, value) ->
    if value?
      @each -> @style[property] = value
    else
      el = @[0]
      el.style[property] or _computedStyle(el, property)


  ###
  Set/Get a stylesheet vendor-prefix property in a given instance element
  @method vendor
  @param  {string} Name of property
  @param  {string} Value for property
  ###
  $$.fn.vendor = (property, value) ->
    @style("#{prefix}#{property}", value) for prefix in VENDORS

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _computedStyle = (element, property) ->
    document.defaultView.getComputedStyle(element, "")[property]

  _arrayOf = (values) ->
    values = [values] unless Array.isArray(values)
    values
