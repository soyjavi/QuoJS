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
                value.each (index, value) => @appendChild value.cloneNode(true)
            else
                @appendChild value.cloneNode(true)

    $$.fn.prepend = (value) ->
        type = $$.toType(value)
        @each ->
            if type is "string"
                @insertAdjacentHTML "afterbegin", value
            else if type is "array"
                value.each (index, value) => @insertBefore value.cloneNode(true), @firstChild
            else
                @insertBefore value.cloneNode(true), @firstChild

    $$.fn.replaceWith = (value) ->
        type = $$.toType(value)
        @each ->
            if type is "string"
                @insertAdjacentHTML "beforeBegin", value
            else if type is "array"
                value.each (index, value) => @parentNode.insertBefore value.cloneNode(true)
            else
                @parentNode.insertBefore value.cloneNode(true)
        @remove()

    $$.fn.empty = () ->
        @each -> @innerHTML = null
