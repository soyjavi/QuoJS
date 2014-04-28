###
Quo Swipe Gestures: swipe, swiping, swipeLeft, swipeRight, swipeUp, swipeDown
New gestures added: swipingHorizontal, swipingVertical

@namespace Quo.Gestures
@class Swipe

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


Quo.Gestures.add
  name    : "swipe"
  events  : ["swipe",
             "swipeLeft", "swipeRight", "swipeUp", "swipeDown",
             "swiping", "swipingHorizontal", "swipingVertical"]

  handler : do (base = Quo.Gestures) ->
    GAP = 20
    _target = null
    _start = null
    _start_axis = null
    _last = null

    start = (target, data) ->
      if data.length is 1
        _target = target
        _start = data[0]
        _last = null

    move = (target, data) ->
      if data.length is 1
        console.log target
        delta = x: (data[0].x - _start.x), y: (data[0].y - _start.y)
        is_first = _last is null
        _last = x: data[0].x, y: data[0].y, delta: delta
        _check(true, is_first)
      else
        _last = null

    end = (target, data) ->
      if _last
        _check(false)
        _last = null

    _check = (moving, first_move = false) ->
      if moving
        if first_move then _start_axis = _getInitialAxis(_last.delta.x, _last.delta.y)
        if _start_axis isnt null
          base.trigger(_target, "swiping#{_start_axis}", _last)
        base.trigger(_target, "swiping", _last)
      else
        directions = []
        if Math.abs(_last.delta.y) > GAP
          directions.push(if _last.delta.y < 0 then "Up" else "Down")
        if Math.abs(_last.delta.x) > GAP
          directions.push(if _last.delta.x < 0 then "Left" else "Right")
        if directions.length
          base.trigger(_target, "swipe", _last)
          base.trigger(_target, "swipe#{direction}", _last) for direction in directions

    _getInitialAxis = (x, y) ->
      axis = null
      if Math.round(Math.abs(x / y)) >= 2 then axis = "Horizontal"
      else if Math.round(Math.abs(y / x)) >= 2 then axis = "Vertical"
      return axis

    start: start
    move: move
    end: end
