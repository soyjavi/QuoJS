###
Quo Basic Gestures: tap, hold, singleTap, doubleTap

@namespace Quo.Gestures
@class Basic

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "basic"
  events  : ["tap", "hold", "singleTap", "doubleTap", "touch"]

  handler : do (base = Quo.Gestures) ->
    GAP = 15
    DELAY =
      TAP       : 250
      DOUBLE_TAP: 400
      HOLD      : 400

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
          base.trigger(target, "hold", data[0])
        , DELAY.HOLD
      else do cancel

    move = (target, data) ->
      if _start isnt null
        xDiff = data[0].x - _start.x
        yDiff = data[0].y - _start.y
        if xDiff > GAP or yDiff > GAP or data.length > 1
          do cancel

    end = (target, data) ->
      base.trigger(target, "touch", data[0])
      return unless _start
      clearTimeout _hold_timeout
      now = new Date()
      if (now - _start.time) < DELAY.TAP
        if (now - _last_tap) < DELAY.DOUBLE_TAP
          clearTimeout _simpletap_timeout
          base.trigger(target, "doubleTap", data[0])
          _last_tap = null
        else
          _last_tap = now
          base.trigger(target, "tap", data[0])
          _simpletap_timeout = setTimeout ->
            base.trigger(target, "singleTap", data[0])
          , DELAY.DOUBLE_TAP + 5

    cancel = () ->
      _start = null
      _valid = false
      clearTimeout _hold_timeout
      clearTimeout _simpletap_timeout

    start   : start
    move    : move
    end     : end
    cancel  : cancel
