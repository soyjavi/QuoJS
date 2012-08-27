###
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    GESTURE = {}
    FIRST_TOUCH = []
    CURRENT_TOUCH = []
    TOUCH_TIMEOUT = undefined
    HOLD_DELAY = 650
    GESTURES = ["doubleTap",
                "hold",
                "swipe", "swiping", "swipeLeft", "swipeRight", "swipeUp", "swipeDown",
                "rotate", "rotating", "rotateLeft", "rotateRight",
                "pinch", "pinching", "pinchIn", "pinchOut",
                "drag"]

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
        delta = now - (GESTURE.last or now)
        TOUCH_TIMEOUT and clearTimeout(TOUCH_TIMEOUT)
        touches = _getTouches(event)
        fingers = touches.length
        FIRST_TOUCH = _fingersPosition(touches, fingers)
        GESTURE.el = $$(_parentIfText(touches[0].target))
        GESTURE.fingers = fingers
        GESTURE.last = now
        if fingers is 1
            GESTURE.isDoubleTap = (delta > 0 and delta <= 250)
            setTimeout _hold, HOLD_DELAY
        else if fingers is 2
            GESTURE.initial_angle = parseInt(_angle(FIRST_TOUCH), 10)
            GESTURE.initial_distance = parseInt(_distance(FIRST_TOUCH), 10)
            GESTURE.angle_difference = 0
            GESTURE.distance_difference = 0

    _onTouchMove = (event) ->
        if GESTURE.el
            touches = _getTouches(event)
            fingers = touches.length
            if fingers == GESTURE.fingers
                CURRENT_TOUCH = _fingersPosition(touches, fingers)
                _trigger "swiping" if _isSwipe(event)
                if fingers == 2
                    _captureRotation()
                    _capturePinch()
            else
                _cleanGesture()
        true

    _isSwipe = (event) ->
        ret = false
        if CURRENT_TOUCH[0]
            move_horizontal = Math.abs(FIRST_TOUCH[0].x - CURRENT_TOUCH[0].x) > 30
            move_vertical = Math.abs(FIRST_TOUCH[0].y - CURRENT_TOUCH[0].y) > 30
            ret = GESTURE.el and (move_horizontal or move_vertical)
        ret

    _onTouchEnd = (event) ->
        if GESTURE.isDoubleTap
            _trigger "doubleTap"
            _cleanGesture()
        else if GESTURE.fingers is 1
            if _isSwipe()
                _trigger "swipe"
                swipe_direction = _swipeDirection(FIRST_TOUCH[0].x, CURRENT_TOUCH[0].x, FIRST_TOUCH[0].y, CURRENT_TOUCH[0].y)
                _trigger swipe_direction
                _cleanGesture()
            else
                _trigger "tap"
                TOUCH_TIMEOUT = setTimeout(_cleanGesture, 250)
        else if GESTURE.fingers is 2
            if GESTURE.angle_difference isnt 0
                _trigger "rotate", angle: GESTURE.angle_difference
                rotation_direction = if GESTURE.angle_difference > 0 then "rotateRight" else "rotateLeft"
                _trigger rotation_direction, angle: GESTURE.angle_difference
            if GESTURE.distance_difference isnt 0
                _trigger "pinch", angle: GESTURE.distance_difference
                pinch_direction = if GESTURE.distance_difference > 0 then "pinchOut" else "pinchIn"
                _trigger pinch_direction, distance: GESTURE.distance_difference
            _cleanGesture()

    _fingersPosition = (touches, fingers) ->
        result = []
        i = 0
        while i < fingers
            result.push
                x: touches[i].pageX
                y: touches[i].pageY
            i++
        result

    _captureRotation = () ->
        angle = parseInt(_angle(CURRENT_TOUCH), 10)
        diff = parseInt(GESTURE.initial_angle - angle, 10)
        if Math.abs(diff) > 10 or GESTURE.angle_difference isnt 0
            i = 0
            symbol = if GESTURE.angle_difference < 0 then "-" else "+"
            eval "diff " + symbol + "= 180;" while Math.abs(diff - GESTURE.angle_difference) > 90 and i++ < 10
            GESTURE.angle_difference = parseInt(diff, 10)
            _trigger "rotating", angle: GESTURE.angle_difference

    _capturePinch = () ->
        distance = parseInt(_distance(CURRENT_TOUCH), 10)
        diff = GESTURE.initial_distance - distance
        if Math.abs(diff) > 5
            GESTURE.distance_difference = diff
            _trigger "pinching", distance: diff

    _trigger = (type, params) ->
        if GESTURE.el
            params = params or {}
            GESTURE.el.trigger type, params

    _cleanGesture = (event) ->
        FIRST_TOUCH = []
        CURRENT_TOUCH = []
        GESTURE = {}
        clearTimeout TOUCH_TIMEOUT

    _angle = (touches_data) ->
        A = touches_data[0]
        B = touches_data[1]
        angle = Math.atan((B.y-A.y)*-1/(B.x-A.x))*(180/Math.PI)
        if angle < 0 then (angle + 180) else angle

    _distance = (touches_data) ->
        A = touches_data[0]
        B = touches_data[1]
        Math.sqrt((B.x-A.x)*(B.x-A.x)+(B.y-A.y)*(B.y-A.y))*-1

    _getTouches = (event) ->
        if $$.isMobile() then event.touches else [event]

    _parentIfText = (node) ->
        if "tagName" of node then node else node.parentNode

    _swipeDirection = (x1, x2, y1, y2) ->
        xDelta = Math.abs(x1 - x2)
        yDelta = Math.abs(y1 - y2)
        if xDelta >= yDelta
            if x1-x2>0 then "swipeLeft" else "swipeRight"
        else
            if y1-y2>0 then "swipeUp" else "swipeDown"

    _hold = ->
        if GESTURE.last and (Date.now() - GESTURE.last >= HOLD_DELAY)
            _trigger "hold"
            _cleanGesture()

    return

) Quo