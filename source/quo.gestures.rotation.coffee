###
Quo Rotation Gestures: rotate, rotating, rotateLeft, rotateRight

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
###
"use strict"


Quo.Gestures.add
  name    : "rotation"
  events  : "rotate,rotating,rotateLeft,rotateRight".split(",")
  handler : do (gm = Quo.Gestures) ->

    TRIGGER_ANGLE             = 5
    IMPOSIBLE_ROTATION_FACTOR = 20

    _target         = null
    _num_rotations  = 0
    _start          = null
    _last           = null

    start = (target, data) ->
      if data.length is 2
        _target = target
        _num_rotations = 0
        _start = _rotation(data[0], data[1])

    move = (target, data) ->
      if _start and data.length is 2
        delta = _rotation(data[0], data[1]) - _start
        if _last and Math.abs(_last.delta - delta) > IMPOSIBLE_ROTATION_FACTOR
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

    _check = (is_moving) ->
      if is_moving then gm.trigger _target, "rotating", _last
      else if Math.abs(_last.delta) > TRIGGER_ANGLE
        gm.trigger _target, "rotate", _last
        ev = if _last.delta > 0 then "rotateRight" else "rotateLeft"
        gm.trigger _target, ev, _last

    start: start
    move: move
    end: end
