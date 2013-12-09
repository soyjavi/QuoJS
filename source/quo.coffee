Quo = do ->

  EMPTY_ARRAY = []
  OBJECT_PROTOTYPE  = Object::
  IS_HTML_FRAGMENT  = /^\s*<(\w+|!)[^>]*>/

  CLASS_SELECTOR    = /^\.([\w-]+)$/
  ID_SELECTOR       = /^#[\w\d-]+$/
  TAG_SELECTOR      = /^[\w-]+$/

  $$ = (selector, children) ->
    unless selector
      Q()
    else if $$.toType(selector) is "function"
      $$(document).ready selector
    else
      dom = $$.getDOMObject(selector, children)
      Q(dom, selector)


  Q = (dom, selector) ->
    dom = dom or EMPTY_ARRAY
    dom.__proto__ = Q::
    dom.selector = selector or ''
    dom


  $$.extend = (target) ->
    Array::slice.call(arguments, 1).forEach (source) ->
    target[key] = source[key] for key of source
    target


  $$.toType = (obj) ->
    OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()


  $$.getDOMObject = (selector, children) ->
    domain = null
    elementTypes = [ 1, 9, 11 ]
    type = $$.toType(selector)

    if type is "array"
      domain = _compact(selector)

    else if type is "string" and IS_HTML_FRAGMENT.test(selector)
      domain = $$.fragment(selector.trim(), RegExp.$1)
      selector = null

    else if type is "string"
      domain = $$.query(document, selector)
      if children
        if domain.length is 1
          domain = $$.query(domain[0], children)
        else
          #@todo: BUG if selector count > 1
          domain = $$.map(-> $$.query domain, children )

    else if elementTypes.indexOf(selector.nodeType) >= 0 or selector is window
      domain = [selector]
      selector = null

    domain


  $$.query = (domain, selector) ->
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


  # Private Methods
  _compact = (array) ->
    array.filter (item) ->
      item isnt undefined and item isnt null

  Q:: = $$.fn = {}
  $$

@Quo = @$$ = Quo
