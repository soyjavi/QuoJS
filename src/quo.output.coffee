do ($$ = Quo) ->

    $$.fn.text = (value) ->
        if value or $$.toType(value) is "number"
          @each -> @textContent = value
        else
            @[0].textContent

    $$.fn.html = (value) ->
        type = $$.toType(value)
        if value or type is "number" or type is "string"
            @each ->
                if type is "string" or type is "number"
                    @innerHTML = value
                else
                    @innerHTML = null
                    @appendChild value
        else
            @[0].innerHTML

    $$.fn.append = (value) ->
        type = $$.toType(value)
        @each ->
            if type is "string"
                @insertAdjacentHTML "beforeend", value
            else if type is "array"
                value.each (index, value) => @appendChild value
            else
                @appendChild value

    $$.fn.prepend = (value) ->
        type = $$.toType(value)
        @each -> _prependElement @, value, type

    $$.fn.replaceWith = (value) ->
        type = $$.toType(value)
        @each -> if @parentNode then _prependElement @parentNode, value, type
        @remove()

    $$.fn.empty = () ->
        @each -> @innerHTML = null

    _prependElement = (parent, value, type) ->
        if type is "string"
            parent.insertAdjacentHTML "afterbegin", value
        else if type is "array"
            value.each (index, value) => parent.insertBefore value, parent.firstChild
        else
            parent.insertBefore value, parent.firstChild
