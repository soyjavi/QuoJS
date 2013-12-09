do ($$ = Quo) ->

    $$.fn.text = (value) ->
        if value or $$.toType(value) is "number"
          @each -> @textContent = value
        else
            (if @length > 0 then @[0].textContent else '')

    $$.fn.html = (value) ->
        type = $$.toType(value)
        if type is "undefined"
            (if @length > 0 then @[0].innerHTML else)
        else
            @each ->            
                if type is "string"
                    @innerHTML = value
                    return
                else if type is "array"
                    value.forEach (v) => $$(@).html(v)
                else
                    @innerHTML = @innerHTML + $$(value).html()

    $$.fn.append = (value) ->
        type = $$.toType(value)
        @each ->
            if type is "string"
                @insertAdjacentHTML "beforeend", value
            else if type is "array"
                value.forEach (v) => $$(@).append(v)
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