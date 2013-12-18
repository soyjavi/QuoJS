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

  # ---------------------------------------------------------------------------

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
      dom = $$.getDOMObject(selector, children)
      _Quo(dom, selector)


  # Static Methods
  $$.extend = (target) ->
    Array::slice.call(arguments, 1).forEach (source) ->
    target[key] = source[key] for key of source
    target


  $$.toType = (obj) ->
    OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()


  $$.getDOMObject = (selector, children) ->
    domain = null
    type = $$.toType selector

    if type is "array"
      domain = _compact(selector)

    else if type is "string" and IS_HTML_FRAGMENT.test(selector)
      domain = $$.fragment(selector.trim(), RegExp.$1)
      selector = null

    else if type is "string"
      domain = _query(document, selector)

      if children
        if domain.length is 1
          domain = _query(domain[0], children)
        else
          #@todo: BUG if selector count > 1
          domain = $$.map(-> _query domain, children )

    else if ELEMENT_TYPES.indexOf(selector.nodeType) >= 0 or selector is window
      domain = [selector]
      selector = null

    domain


  # Private Methods
  # ---------------------------------------------------------------------------
  _Quo = (dom = EMPTY_ARRAY, selector = "") ->
    dom.__proto__ = _Quo::
    dom.selector = selector
    dom

  _query = (domain, selector) ->
    selector = selector.trim()

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


  _compact = (array) ->
    console.log array, [1..100]
    # array = [1..10]
    # array.filter (x) -> x > 5
    array.filter (i) -> i?
    # array.filter (item) -> item isnt undefined and item isnt null


  # Instance Methods
  _Quo::forEach = [].forEach

  _Quo::indexOf = EMPTY_ARRAY.indexOf

  _Quo::each = (callback) ->
    @forEach (element, index) -> callback.call element, index, element

  # Exports
  # ---------------------------------------------------------------------------
  _Quo:: = $$.fn = {}

  # Instance Methods
  $$.fn.forEach = [].forEach

  $$.fn.indexOf = EMPTY_ARRAY.indexOf

  $$.fn.each = (callback) ->
    @forEach (element, index) -> callback.call element, index, element

  $$


@Quo = @$$ = Quo
