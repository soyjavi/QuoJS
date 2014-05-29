###
Quo Pinch Gestures: pinch, pinching, pinchIn, pinchOut

@namespace Quo.Gestures
@class Pinch

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


Quo.Gestures.add
  name    : "pinch"
  events  : ["pinch", "pinching", "pinchIn", "pinchOut"]

  handler : do (base = Quo.Gestures) ->
    GAP = (if window.devicePixelRatio >= 2 then 15 else 20)
    _target = null
    _start = null
    _last = null

    start = (target, data) ->
      if data.length is 2
        _target = target
        _start = _distance data[0], data[1]

    move = (target, data) ->
      if _start and data.length is 2
        distance = _distance data[0], data[1]
        _last = touches: data, delta: (distance - _start)
        _check(true)

    cancel = end = (target, data) ->
      if _start and _last
        _check(false)
        _start = null
        _last = null

    _distance = (A, B) ->
      Math.sqrt((B.x-A.x)*(B.x-A.x)+(B.y-A.y)*(B.y-A.y))

    _check = (moving) ->
      if moving
        base.trigger(_target, "pinching", _last)
      else if Math.abs(_last.delta) > GAP
        base.trigger _target, "pinch", _last
        ev = if _last.delta > 0 then "pinchOut" else "pinchIn"
        base.trigger _target, ev, _last

    start: start
    move: move
    end: end
