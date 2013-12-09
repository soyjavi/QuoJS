Quo = do ->
    EMPTY_ARRAY = []

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
          for key of source
            target[key] = source[key]
        target

    Q:: = $$.fn = {}

    $$


window.Quo = Quo
"$$" of window or (window.$$ = Quo)
