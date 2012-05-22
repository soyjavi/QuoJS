###
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###


Quo = (->
    EMPTY_ARRAY = []

    Q = (dom, selector) ->
        dom = dom or EMPTY_ARRAY
        dom.__proto__ = Q::
        dom.selector = selector or ''
        dom

    $$ = (selector) ->
        unless selector
            Q()
        else
            domain_selector = $$.getDomainSelector(selector)
            Q(domain_selector, selector)

    $$.extend = (target) ->
        Array::slice.call(arguments, 1).forEach (source) ->
          for key of source
            target[key] = source[key]
        target

    Q:: = $$.fn = {}
    $$
)()

window.Quo = Quo
'$$' of window or (window.$$ = Quo)