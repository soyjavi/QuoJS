###
Basic Quo Module

@namespace Quo
@class Base

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Quo = do ->

  EMPTY_ARRAY = []
  OBJECT_PROTOTYPE  = Object::

  IS_HTML_FRAGMENT  = /^\s*<(\w+|!)[^>]*>/

  ELEMENT_TYPES     = [ 1, 9, 11 ]
  CLASS_SELECTOR    = /^\.([\w-]+)$/
  ID_SELECTOR       = /^#[\w\d-]+$/
  TAG_SELECTOR      = /^[\w-]+$/


  ###
  Basic Instance of QuoJS
  @method $$
  @param  {string/instance} [OPTIONAL] Selector for handler
  @param  {string} [OPTIONAL] Children in selector
  ###
  $$ = (selector, children) ->
    unless selector
      _Quo()
    else if $$.toType(selector) is "function"
      $$(document).ready selector
    else
      dom = _getDOMObject(selector, children)
      _Quo(dom, selector)

  # ---------------------------------------------------------------------------
  # Static Methods
  # ---------------------------------------------------------------------------
  $$.extend = (target) ->
    Array::slice.call(arguments, 1).forEach (source) ->
    target[key] = source[key] for key of source
    target


  $$.toType = (obj) ->
    OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _Quo = (dom = EMPTY_ARRAY, selector = "") ->
    dom.__proto__ = _Quo::
    dom

  _getDOMObject = (selector, children) ->
    domain = null
    type = $$.toType selector

    if selector instanceof _Quo and not children
      #@TODO: If selector it's array, fails :/
      domain = _compact selector

    else if type is "string" and IS_HTML_FRAGMENT.test(selector)
      domain = $$.fragment(selector.trim(), RegExp.$1)
      selector = null

    else if type is "string"
      domain = _query(document, selector)

      if children
        if domain.length is 1
          domain = _query(domain[0], children)
        else
          #@TODO: BUG if selector count > 1
          domain = $$.map(-> _query domain, children)

    else if ELEMENT_TYPES.indexOf(selector.nodeType) >= 0 or selector is window
      domain = [selector]
      selector = null

    domain

  _query = (domain, selector) ->
    if CLASS_SELECTOR.test(selector)
      elements = domain.getElementsByClassName selector.replace(".", "")
    else if TAG_SELECTOR.test(selector)
      elements = domain.getElementsByTagName(selector)
    else if ID_SELECTOR.test(selector) and domain is document
      elements = domain.getElementById selector.replace("#", "")
      unless elements then elements = []
    else
      elements = domain.querySelectorAll selector
    if elements.nodeType then [elements] else Array::slice.call(elements)


  _compact = (items) ->
    items.filter (item) -> item if item?

  # ---------------------------------------------------------------------------
  # Exports
  # ---------------------------------------------------------------------------
  _Quo:: = $$.fn = {}

  $$.fn.each = (callback) ->
    @forEach (element, index) -> callback.call element, index, element

  $$.fn.filter = (selector) ->
    console.log "selector", selector.length
    $$ EMPTY_ARRAY.filter.call(@, (el) ->
      el.parentNode and _query(el.parentNode, selector).indexOf(el) >= 0)

  $$.fn.forEach = EMPTY_ARRAY.forEach

  $$.fn.indexOf = EMPTY_ARRAY.indexOf

  $$

@Quo = @$$ = Quo
