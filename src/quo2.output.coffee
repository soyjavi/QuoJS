(($$) ->
    $$.fn.text = (value) ->
        if (not value)
            this[0].textContent
        else
            @each ->
                @textContent = value

    $$.fn.html = (value) ->
        type = $$.toType(value)
        if type is "string" or type is "number"
            @each ->
                @innerHTML = value
        else
            this[0].innerHTML

    $$.fn.append = (value) ->
        @each ->
            if $$.toType(value) is "string"
                if value
                    div = document.createElement("div")
                    div.innerHTML = value
                    @appendChild div.firstChild
            else
                @insertBefore value

    $$.fn.prepend = (value) ->
        @each ->
            if $$.toType(value) is "string"
                @innerHTML = value + @innerHTML
            else
                parent = @parentNode
                parent.insertBefore value, parent.firstChild

    $$.fn.empty = () ->
        @each ->
            @innerHTML = null
            return

    _priv = -> true

    return
) Quo