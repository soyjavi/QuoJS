do ($$ = Quo) ->

    $$.fn.text = (value) ->
        if arguments.length > 0
          @each -> @textContent = value
        else
            @[0].textContent

    $$.fn.html = (value) ->
        type = $$.toType(value)
        if arguments.lenth > 0
            @each ->
                if type is "string" or type is "number"
                    @innerHTML = value
                else
                    @innerHTML = null
                    if type is "array" then @appendChild element for element in value
                    else if value then @appendChild value
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
        @each ->
            if type is "string"
                @insertAdjacentHTML "afterbegin", value
            else if type is "array"
                value.each (index, value) => @insertBefore value, @firstChild
            else
                @insertBefore value, @firstChild

    $$.fn.replaceWith = (value) ->
        type = $$.toType(value)
        @each ->
            if @parentNode
                if type is "string"
                    @insertAdjacentHTML "beforeBegin", value
                else if type is "array"
                    value.each (index, value) => @parentNode.insertBefore value, @
                else
                    @parentNode.insertBefore value, @
        @remove()

    $$.fn.empty = () ->
        @each -> @innerHTML = null
