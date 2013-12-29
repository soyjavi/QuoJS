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
      _instance()
    else if $$.toType(selector) is "function"
      $$(document).ready selector
    else
      dom = _getDOMObject(selector, children)
      _instance(dom, selector)

  ###
  Basic Instance of QuoJS
  @method query
  @param  {string/instance} [OPTIONAL] Selector for handler
  @param  {string} [OPTIONAL] Children in selector
  ###
  $$.query = (domain, selector) ->
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


  # ---------------------------------------------------------------------------
  # Static Methods
  # ---------------------------------------------------------------------------
  $$.extend = (target) ->
    Array::slice.call(arguments, 1).forEach (source) ->
      target[key] = source[key] for key of source
    target

  $$.toType = (obj) ->
    OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()

  $$.each = (elements, callback) ->
    i = undefined
    key = undefined
    if $$.toType(elements) is "array"
      for element, i in elements
        elements if callback.call(element, i, element) is false
    else
      for key of elements
        elements if callback.call(elements[key], key, elements[key]) is false
    elements

  $$.map = (elements, callback) ->
    values = []
    i = undefined
    key = undefined
    if $$.toType(elements) is "array"
      i = 0
      while i < elements.length
        value = callback(elements[i], i)
        values.push value  if value?
        i++
    else
      for key of elements
        value = callback(elements[key], key)
        values.push value if value?
    _flatten values


  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _instance = (dom, selector = "") ->
    dom = dom or EMPTY_ARRAY
    dom.__proto__ = _instance::
    dom.__proto__.selector = selector or ""
    dom

  _getDOMObject = (selector, children) ->
    domain = null
    type = $$.toType selector

    if type is "array"
      domain = _compact selector

    else if type is "string" and IS_HTML_FRAGMENT.test(selector)
      domain = $$.fragment(selector.trim(), RegExp.$1)
      selector = null

    else if type is "string"
      domain = $$.query(document, selector)
      if children
        if domain.length is 1
          domain = $$.query(domain[0], children)
        else
          #@TODO: BUG if selector count > 1
          domain = $$.map(-> $$.query domain, children)

    else if ELEMENT_TYPES.indexOf(selector.nodeType) >= 0 or selector is window
      domain = [selector]
      selector = null

    domain

  _compact = (items) ->
    items.filter (item) -> item if item?

  _flatten = (array) ->
    if array.length > 0 then EMPTY_ARRAY.concat.apply(EMPTY_ARRAY, array) else array


  # ---------------------------------------------------------------------------
  # Exports
  # ---------------------------------------------------------------------------
  _instance:: = $$.fn = {}

  $$.fn.each = (callback) ->
    @forEach (element, index) -> callback.call element, index, element

  $$.fn.filter = (selector) ->
    $$ EMPTY_ARRAY.filter.call(@, (el) ->
      el.parentNode and $$.query(el.parentNode, selector).indexOf(el) >= 0)

  $$.fn.forEach = EMPTY_ARRAY.forEach

  $$.fn.indexOf = EMPTY_ARRAY.indexOf

  $$

@Quo = @$$ = Quo

