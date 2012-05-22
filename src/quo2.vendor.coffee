(($) ->

    VENDORS = [ "webkit", "moz", "ms", "o", "" ]
    CSS_PROPERTIES =
        userSelect: "none"
        touchCallout: "none"
        userDrag: "none"
        tapHighlightColor: "rgba(0,0,0,0)"

    _vendor = ->
        properties = ""
        i = 0

        while i < VENDORS.length
            for property of CSS_PROPERTIES
                properties = property
                properties = VENDORS[i] + properties.substring(0, 1).toUpperCase() + properties.substring(1)  if VENDORS[i]
                #@style(properties) = CSS_PROPERTIES[property]
            i++

    $.fn.vendor = ->
        _vendor()

) Quo