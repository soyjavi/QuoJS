(($$) ->
    $$.fn.text = (value) ->
        if (not value)
            this[0].textContent
        else
            @each(-> @textContent = value)

    $$.fn.html = (value) ->
        if (not value)
            this[0].innerHTML
        else
            @each(-> @innerHTML = value)

    $$.fn.append = (value) ->
        true

    $$.fn.prepend = (value) ->
        true

    $$.fn.empty = ->
        @each ->
            @innerHTML = null

    this
) Quo