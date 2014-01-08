###
Quo Drag Gestures: drag, dragging

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "drag"
  events  : "drag,dragging".split(",")
  handler : do (gm = Quo.Gestures) ->

    MIN_PX = 20

    _target       = null
    _num_fingers  = null
    _start        = null
    _last         = null

    start = (target, data) ->
      if data.length >= 2
        _target = target
        _num_fingers = data.length
        _start = _average(data)

    move = (target, data) ->
      if data.length is _num_fingers
        delta = _calcDelta(data)
        _last = touches: data, delta: delta
        _check(true)

    end = (target, data) ->
      if _start and _last
        _check(false)
        _num_fingers = null
        _start = null
        _last = null

    _calcDelta = (touches) ->
      average = _average(touches)
      x: average.x - _start.x
      y: average.y - _start.y

    _average = (touches) ->
      x = 0; y = 0
      for touch in touches
        x += parseInt(touch.x)
        y += parseInt(touch.y)
      return x: (x / touches.length), y: (y / touches.length)

    _check = (is_moving) ->
      if is_moving then gm.trigger _target, "dragging", _last
      else if Math.abs(_last.delta.x) > MIN_PX or Math.abs(_last.delta.y) > MIN_PX
          gm.trigger _target, "drag", _last


    start: start
    move: move
    end: end
