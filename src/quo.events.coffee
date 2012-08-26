###
  QuoJS 2.1
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    READY_EXPRESSION = /complete|loaded|interactive/
    SHORTCUTS = [ "touch", "tap" ]
    SHORTCUTS_EVENTS =
        touch: "touchstart"
        tap: "tap"

    SHORTCUTS.forEach (event) ->
        $$.fn[event] = (callback) ->
            $$(document.body).delegate @selector, SHORTCUTS_EVENTS[event], callback
        @

    $$.fn.on = (event, selector, callback) ->
        (if (selector is `undefined` or $$.toType(selector) is "function") then @bind(event, selector) else @delegate(selector, event, callback))

    $$.fn.off = (event, selector, callback) ->
        (if (selector is `undefined` or $$.toType(selector) is "function") then @unbind(event, selector) else @undelegate(selector, event, callback))

    $$.fn.ready = (callback) ->
        if READY_EXPRESSION.test(document.readyState)
            callback $$
        else
            $$.fn.addEvent document, "DOMContentLoaded", -> callback $$
        @

    return

) Quo
