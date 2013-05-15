do ($$ = Quo) ->

    $$.fn.attr = (name, value) ->
        if this.length is 0
            null
        if $$.toType(name) is "string" and value is undefined
            this[0].getAttribute name
        else
            @each -> @setAttribute name, value

    $$.fn.removeAttr = (name) ->
        @each -> @removeAttribute name

    $$.fn.data = (name, value) -> @attr "data-" + name, value

    $$.fn.removeData = (name) -> @removeAttr "data-" + name

    $$.fn.val = (value) ->
        if $$.toType(value) is "string"
            @each -> @value = value
        else
            (if @length > 0 then this[0].value else null)

    $$.fn.show = -> @style "display", "block"

    $$.fn.hide = -> @style "display", "none"

    $$.fn.height = ->
        offset = @offset()
        offset.height

    $$.fn.width = ->
        offset = @offset()
        offset.width

    $$.fn.offset = ->
        bounding = this[0].getBoundingClientRect()

        left: bounding.left + window.pageXOffset
        top: bounding.top + window.pageYOffset
        width: bounding.width
        height: bounding.height

    $$.fn.remove = ->
        @each -> @parentNode.removeChild this  if @parentNode?

    $$.fn.next = -> _getSibling.call @, "nextSibling"

    $$.fn.prev = -> _getSibling.call @, "previousSibling"

    _getSibling = (command) ->
      element = @[0][command]
      element = element[command] while element and element.nodeType isnt 1
      $$ element
