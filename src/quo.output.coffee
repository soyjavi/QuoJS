###
  QuoJS 2.1
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->
    $$.fn.text = (value) ->
        if (not value)
            @[0].textContent
        else
            @each ->
                @textContent = value

    $$.fn.html = (value) ->
        type = $$.toType(value)
        if type is "string" or type is "number"
            @each ->
                @innerHTML = value
        else
            @[0].innerHTML

    $$.fn.append = (value) ->
        @each ->
            if $$.toType(value) is "string"
                if value
                    @appendChild _createElement(value)
            else
                @insertBefore value

    $$.fn.prepend = (value) ->
        @each ->
            if $$.toType(value) is "string"
                @innerHTML = value + @innerHTML
            else
                parent = @parentNode
                parent.insertBefore value, parent.firstChild

    $$.fn.replaceWith = (content) ->
        @each ->
            content = _createElement(content) if $$.toType(content) is "string"

            parent = @parentNode
            if parent
                parent.insertBefore content, @
            $$(@).remove()

    $$.fn.empty = () ->
        @each ->
            @innerHTML = null
            return

    _createElement = (content) ->
        div = document.createElement("div")
        div.innerHTML = content
        div.firstChild

    return
) Quo
