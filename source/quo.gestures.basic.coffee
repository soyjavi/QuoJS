###
Quo Basic Gestures: touch, hold, doubleTap

@namespace Quo.Gestures
@class Basic

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "basic"
  events  : ["touch", "hold", "doubleTap"]

  handler : do (base = Quo.Gestures) ->
    GAP = 15
    DELAY =
      TAP       : 200
      DOUBLE_TAP: 400
      HOLD      : 400

    _hold_timeout = null
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
        diff = _calculateDiff _start, data[0]
        do cancel if diff.x > GAP or diff.y > GAP or data.length > 1

    end = (target, data) ->
      return unless _start

      diff = _calculateDiff _start, data[0]
      return cancel() if diff.x isnt 0 or diff.y isnt 0

      # base.trigger target, "touch", data[0]
      clearTimeout _hold_timeout
      now = new Date()
      if (now - _start.time) < DELAY.TAP
        if (now - _last_tap) < DELAY.DOUBLE_TAP
          base.trigger target, "doubleTap", data[0]
          _last_tap = null
        else
          _last_tap = now
          # base.trigger target, "tap", data[0]
          base.trigger target, "touch", data[0]

    cancel = () ->
      _start = null
      _valid = false
      clearTimeout _hold_timeout

    _calculateDiff = (start, end) ->
      diff =
        x: end.x - start.x
        y: end.y - start.y

    start   : start
    move    : move
    end     : end
    cancel  : cancel
