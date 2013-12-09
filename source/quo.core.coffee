do ($$ = Quo) ->

    EMPTY_ARRAY = []
    OBJECT_PROTOTYPE = Object::
    IS_HTML_FRAGMENT = /^\s*<(\w+|!)[^>]*>/

    TABLE = document.createElement('table')
    TABLE_ROW = document.createElement('tr')
    HTML_CONTAINERS =
        "tr": document.createElement("tbody")
        "tbody": TABLE
        "thead": TABLE
        "tfoot": TABLE
        "td": TABLE_ROW
        "th": TABLE_ROW
        "*": document.createElement("div")


    $$.toType = (obj) ->
        OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()

    $$.isOwnProperty = (object, property) ->
        OBJECT_PROTOTYPE.hasOwnProperty.call object, property

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
                values.push value  if value?
        _flatten values

    $$.each = (elements, callback) ->
        i = undefined
        key = undefined
        if $$.toType(elements) is "array"
            i = 0
            while i < elements.length
                return elements  if callback.call(elements[i], i, elements[i]) is false
                i++
        else
            for key of elements
                return elements  if callback.call(elements[key], key, elements[key]) is false
        elements

    $$.mix = ->
        child = {}
        arg = 0
        len = arguments.length

        while arg < len
            argument = arguments[arg]
            for prop of argument
                child[prop] = argument[prop]  if $$.isOwnProperty(argument, prop) and argument[prop] isnt `undefined`
            arg++
        child

    $$.fragment = (markup, tag = "*") ->
        tag = "*" unless tag of HTML_CONTAINERS

        container = HTML_CONTAINERS[tag]
        container.innerHTML = "" + markup
        $$.each Array::slice.call(container.childNodes), ->
            container.removeChild this

    $$.fn.map = (fn) ->
        $$.map this, (el, i) -> fn.call el, i, el

    $$.fn.instance = (property) ->
        @map -> this[property]

    $$.fn.filter = (selector) ->
        $$ [].filter.call(this, (element) ->
            element.parentNode and $$.query(element.parentNode, selector).indexOf(element) >= 0)

    $$.fn.forEach = EMPTY_ARRAY.forEach

    $$.fn.indexOf = EMPTY_ARRAY.indexOf

    _compact = (array) ->
        array.filter (item) ->
            item isnt undefined and item isnt null

    _flatten = (array) ->
        (if array.length > 0 then [].concat.apply([], array) else array)

