(($$) ->

    EMPTY_ARRAY = [ ]
    OBJECT_PROTOTYPE = Object::

    $$.toType = (obj) ->
        OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()

    $$.isOwnProperty = (object, property) ->
        OBJECT_PROTOTYPE.hasOwnProperty.call object, property

    $$.getDomainSelector = (selector) ->
        domain = null
        elementTypes = [ 1, 9, 11 ]
        type = $$.toType(selector)

        if type is "array"
            domain = _compact(selector)
        else if type is "string"
            domain = $$.query(document, selector)
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

) Quo