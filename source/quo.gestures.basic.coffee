###
Quo Basic Gestures: tap, hold, singleTap, doubleTap

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "basic"
  events  : "tap,hold,singleTap,doubleTap,touch".split(",")
  handler : do (gm = Quo.Gestures) ->

    ALLOWED_MOVE_PIXELS = 15
    TAP                 = 250
    DOUBLE_TAP          = 400
    HOLD                = 400

    _hold_timeout = null
    _simpletap_timeout = null
    _valid = true
    _target = null
    _start = null
    _last_tap = null

    start = (target, data) ->
      if data.length is 1
        _start = time: new Date(), x: data[0].x, y: data[0].y
        _target = target
        _hold_timeout = setTimeout ->
          gm.trigger(target, "hold", data[0])
        , HOLD
      else do cancel

    move = (target, data) ->
      if _start isnt null
        xDiff = data[0].x - _start.x
        yDiff = data[0].y - _start.y
        if xDiff > ALLOWED_MOVE_PIXELS or yDiff > ALLOWED_MOVE_PIXELS or data.length > 1
          do cancel

    end = (target, data) ->
      gm.trigger(target, "touch", data[0])
      return unless _start
      clearTimeout _hold_timeout
      now = new Date()
      if (now - _start.time) < TAP
        if (now - _last_tap) < DOUBLE_TAP
          clearTimeout _simpletap_timeout
          gm.trigger(target, "doubleTap", data[0])
          _last_tap = null
        else
          _last_tap = now
          gm.trigger(target, "tap", data[0])
          _simpletap_timeout = setTimeout ->
            gm.trigger(target, "singleTap", data[0])
          , DOUBLE_TAP + 5

    cancel = () ->
      _start = null
      _valid = false
      clearTimeout _hold_timeout
      clearTimeout _simpletap_timeout


    start   : start
    move    : move
    end     : end
    cancel  : cancel
