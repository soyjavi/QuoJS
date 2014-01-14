###
Quo Drag Gestures: drag, dragging

@namespace Quo.Gestures
@class Drag

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "drag"
  events  : ["drag" ,"dragging"]

  handler : do (base = Quo.Gestures) ->
    GAP = 20
    _target = null
    _num_fingers = null
    _start = null
    _last = null

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

    _check = (moving) ->
      if moving then base.trigger _target, "dragging", _last
      else if Math.abs(_last.delta.x) > GAP or Math.abs(_last.delta.y) > GAP
          base.trigger _target, "drag", _last

    start: start
    move: move
    end: end
