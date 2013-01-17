do ($$ = Quo) ->

    TAPS = null
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
                "drag", "dragLeft", "dragRight", "dragUp", "dragDown"]

    GESTURES.forEach (event) ->
        $$.fn[event] = (callback) -> @on event, callback
        return

    $$(document).ready -> _listenTouches()

    _listenTouches = ->
        environment = $$ document.body
        environment.bind "touchstart", _onTouchStart
        environment.bind "touchmove", _onTouchMove
        environment.bind "touchend", _onTouchEnd
        environment.bind "touchcancel", _cleanGesture

    _onTouchStart = (event) ->
        now = Date.now()
        TOUCH_TIMEOUT and clearTimeout(TOUCH_TIMEOUT)
        touches = _getTouches(event)
        fingers = touches.length
        FIRST_TOUCH = _fingersPosition(touches, fingers)
        GESTURE.el = $$(_parentIfText(touches[0].target))
        GESTURE.fingers = fingers
        GESTURE.last = now

        unless GESTURE.taps then GESTURE.taps = 0
        GESTURE.taps++

        if fingers is 1
            delta = now - (GESTURE.last or now)
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
                    event.preventDefault()
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
        if GESTURE.fingers is 1
            if GESTURE.taps is 2 and GESTURE.isDoubleTap
                _trigger "doubleTap"
                _cleanGesture()
            else if _isSwipe()
                _trigger "swipe"
                swipe_direction = _swipeDirection(FIRST_TOUCH[0].x, CURRENT_TOUCH[0].x, FIRST_TOUCH[0].y, CURRENT_TOUCH[0].y)
                _trigger "swipe" + swipe_direction
                _cleanGesture()
            else if GESTURE.taps is 1
                TOUCH_TIMEOUT = setTimeout((->
                  _trigger "tap"
                  _cleanGesture()
                ), 100)
            else
                _trigger "touch"
                TOUCH_TIMEOUT = setTimeout(_cleanGesture, 250)
        else
            anyevent = false
            if GESTURE.angle_difference isnt 0
                _trigger "rotate", angle: GESTURE.angle_difference
                rotation_direction = if GESTURE.angle_difference > 0 then "rotateRight" else "rotateLeft"
                _trigger rotation_direction, angle: GESTURE.angle_difference
                anyevent = true
            if GESTURE.distance_difference isnt 0
                _trigger "pinch", angle: GESTURE.distance_difference
                pinch_direction = if GESTURE.distance_difference > 0 then "pinchOut" else "pinchIn"
                _trigger pinch_direction, distance: GESTURE.distance_difference
                anyevent = true
            if not anyevent and CURRENT_TOUCH[0]
                if Math.abs(FIRST_TOUCH[0].x - CURRENT_TOUCH[0].x) > 10 or Math.abs(FIRST_TOUCH[0].y - CURRENT_TOUCH[0].y) > 10
                    _trigger "drag"
                    drag_direction = _swipeDirection(FIRST_TOUCH[0].x, CURRENT_TOUCH[0].x, FIRST_TOUCH[0].y, CURRENT_TOUCH[0].y)
                    _trigger "drag" + drag_direction
            _cleanGesture()

    _fingersPosition = (touches, fingers) ->
        result = []
        i = 0
        touches = if touches[0].targetTouches then touches[0].targetTouches else touches
        while i < fingers
            result.push
                x: touches[i].pageX
                y: touches[i].pageY
            i++
        result

    _captureRotation = () ->
        angle = parseInt(_angle(CURRENT_TOUCH), 10)
        diff = parseInt(GESTURE.initial_angle - angle, 10)
        if Math.abs(diff) > 20 or GESTURE.angle_difference isnt 0
            i = 0
            symbol = if GESTURE.angle_difference < 0 then "-" else "+"
            eval "diff " + symbol + "= 180;" while Math.abs(diff - GESTURE.angle_difference) > 90 and i++ < 10
            GESTURE.angle_difference = parseInt(diff, 10)
            _trigger "rotating", angle: GESTURE.angle_difference

    _capturePinch = () ->
        distance = parseInt(_distance(CURRENT_TOUCH), 10)
        diff = GESTURE.initial_distance - distance
        if Math.abs(diff) > 10
            GESTURE.distance_difference = diff
            _trigger "pinching", distance: diff

    _trigger = (type, params) ->
        if GESTURE.el
            params = params or {}
            if CURRENT_TOUCH[0]
                params.iniTouch = (if GESTURE.fingers > 1 then FIRST_TOUCH else FIRST_TOUCH[0])
                params.currentTouch = (if GESTURE.fingers > 1 then CURRENT_TOUCH else CURRENT_TOUCH[0])
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
            if x1-x2>0 then "Left" else "Right"
        else
            if y1-y2>0 then "Up" else "Down"

    _hold = ->
        if GESTURE.last and (Date.now() - GESTURE.last >= HOLD_DELAY)
            _trigger "hold"
            GESTURE.taps = 0
