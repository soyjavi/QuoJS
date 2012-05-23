###
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    TOUCH = {}
    TOUCH_TIMEOUT = undefined
    HOLD_DELAY = 650
    GESTURES = ["doubleTap",
                "hold",
                "swipe", "swiping", "swipeLeft", "swipeRight", "swipeUp", "swipeDown",
                "drag" ]

    GESTURES.forEach (event) ->
        $$.fn[event] = (callback) -> @on event, callback
        return

    $$(document).ready -> _listenTouches()

    _listenTouches = ->
        environment = $$(document.body)
        environment.bind "touchstart", _onTouchStart
        environment.bind "touchmove", _onTouchMove
        environment.bind "touchend", _onTouchEnd
        environment.bind "touchcancel", _cleanGesture

    _onTouchStart = (event) ->
        now = Date.now()
        delta = now - (TOUCH.last or now)
        touch_event = _captureTouch(event)
        TOUCH_TIMEOUT and clearTimeout(TOUCH_TIMEOUT)
        TOUCH =
            el: $$(_parentIfText(touch_event.target))
            x1: touch_event.pageX
            y1: touch_event.pageY
            isDoubleTap: (if (delta > 0 and delta <= 250) then true else false)
            last: now
            fingers: _countFingers(event)

        setTimeout _hold, HOLD_DELAY

    _onTouchMove = (event) ->
        touch_event = _captureTouch(event)
        TOUCH.x2 = touch_event.pageX
        TOUCH.y2 = touch_event.pageY
        TOUCH.el.trigger "swiping", TOUCH    if _isSwipe(event)

    _onTouchEnd = (event) ->
        if TOUCH.isDoubleTap
            _trigger "doubleTap", true
        else if TOUCH.x2 > 0 or TOUCH.y2 > 0
            if _isSwipe(event)
                if TOUCH.fingers is 1
                    _trigger "swipe", false
                    swipe_direction = _swipeDirection(TOUCH.x1, TOUCH.x2, TOUCH.y1, TOUCH.y2)
                    _trigger swipe_direction, false
                else
                    _trigger "drag", false
            _cleanGesture()
        else
            _trigger "tap" if TOUCH.el
            TOUCH_TIMEOUT = setTimeout(_cleanGesture, 250)

    _trigger = (type, clean) ->
        TOUCH.el.trigger type, TOUCH
        clean and _cleanGesture()

    _cleanGesture = (event) ->
        TOUCH = {}
        clearTimeout TOUCH_TIMEOUT

    _isSwipe = (event) ->
        TOUCH.el and (Math.abs(TOUCH.x1 - TOUCH.x2) > 30 or Math.abs(TOUCH.y1 - TOUCH.y2) > 30)

    _captureTouch = (event) ->
        (if $$.isMobile() then event.touches[0] else event)

    _parentIfText = (node) ->
        (if "tagName" of node then node else node.parentNode)

    _swipeDirection = (x1, x2, y1, y2) ->
        xDelta = Math.abs(x1 - x2)
        yDelta = Math.abs(y1 - y2)
        if xDelta >= yDelta
            (if x1 - x2 > 0 then "swipeLeft" else "swipeRight")
        else
            (if y1 - y2 > 0 then "swipeUp" else "swipeDown")

    _hold = ->
        if TOUCH.last and (Date.now() - TOUCH.last >= HOLD_DELAY)
            _trigger "hold"
            _cleanGesture()
            return

    _countFingers = (event) ->
        (if event.touches then event.touches.length else 1)

    return

) Quo