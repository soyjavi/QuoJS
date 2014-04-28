###
Quo Rotation Gestures: rotate, rotating, rotateLeft, rotateRight

@namespace Quo.Gestures
@class Rotation

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


Quo.Gestures.add
  name    : "rotation"
  events  : ["rotate", "rotating", "rotateLeft", "rotateRight"]

  handler : do (base = Quo.Gestures) ->
    GAP = 5
    ROTATION_LIMIT = 20

    _target = null
    _num_rotations = 0
    _start = null
    _last = null

    start = (target, data) ->
      if data.length is 2
        _target = target
        _num_rotations = 0
        _start = _rotation(data[0], data[1])

    move = (target, data) ->
      if _start and data.length is 2
        delta = _rotation(data[0], data[1]) - _start
        if _last and Math.abs(_last.delta - delta) > ROTATION_LIMIT
          delta += (360 * _sign(_last.delta))
        if Math.abs(delta) > 360
          _num_rotations++
          delta -= (360 * _sign(_last.delta))
        _last = {touches: data, delta: delta, rotationsCount: _num_rotations}
        _check(true)

    end = (target, data) ->
      if _start and _last
        _check(false)
        _target = null
        _num_rotations = 0
        _start = null
        _last = null
        _start = null

    _sign = (num) -> if num < 0 then -1 else 1

    _rotation = (A, B) ->
      theta = Math.atan2(A.y-B.y, A.x-B.x)
      (if theta < 0 then theta + 2 * Math.PI else theta) * 180 / Math.PI

    _check = (moving) ->
      if moving
        base.trigger _target, "rotating", _last
      else if Math.abs(_last.delta) > GAP
        base.trigger _target, "rotate", _last
        ev = if _last.delta > 0 then "rotateRight" else "rotateLeft"
        base.trigger _target, ev, _last

    start: start
    move: move
    end: end
