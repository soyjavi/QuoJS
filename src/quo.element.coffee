###
  QuoJS 2.1
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    $$.fn.attr = (name, value) ->
        if $$.toType(name) is "string" and value is undefined
            this[0].getAttribute name
        else
            @each -> @setAttribute name, value

    $$.fn.data = (name, value) -> @attr "data-" + name, value

    $$.fn.val = (value) ->
        if $$.toType(value) is "string"
            @each -> @value = value
        else
            (if @length > 0 then this[0].value else null)

    $$.fn.show = -> @style "display", "block"

    $$.fn.hide = -> @style "display", "none"

    $$.fn.toggle = ->
        @style "display", if @style "display" is "block" then "none" else "block"

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

    return

) Quo
