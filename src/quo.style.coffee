###
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    $$.fn.addClass = (name) ->
        @each ->
            unless _existsClass(name, @className)
                @className += " " + name
                @className = @className.trim()

    $$.fn.removeClass = (name) ->
        @each ->
            @className = @className.replace(name, " ").replace(/\s+/g, " ").trim() if _existsClass(name, @className)

    $$.fn.toggleClass = (name) ->
        @each ->
            if _existsClass(name, @className)
                @className = @className.replace(name, " ")
            else
                @className += " " + name
                @className = @className.trim()

    $$.fn.hasClass = (name) ->
        _existsClass name, this[0].className

    $$.fn.style = (property, value) ->
        (if (not value) then this[0].style[property] or _computedStyle(this[0], property) else @each(->
            @style[property] = value
        ))

    _existsClass = (name, className) ->
        classes = className.split(/\s+/g)
        classes.indexOf(name) >= 0

    _computedStyle = (element, property) ->
        document.defaultView.getComputedStyle(element, "")[property]

    return

) Quo