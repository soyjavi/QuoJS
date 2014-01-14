###
Quo Gestures manager

@namespace Quo
@class Gestures

@author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Quo.Gestures = do ($$ = Quo) ->

  _started        = false
  _handlers       = {}
  _data           = null
  _originalEvent  = null

  $$(document).ready ->
    environment = $$ document.body
    environment.bind "touchstart", _start
    environment.bind "touchmove", _move
    environment.bind "touchend", _end
    environment.bind "touchcancel", _cancel

  add = (gesture) ->
    _handlers[gesture.name] = gesture.handler
    _addDelegations gesture.events

  trigger = (target, eventName, gestureData) ->
    $$(target).trigger(eventName, gestureData, _originalEvent)

  # Private methods
  _start = (ev) ->
    _started = true
    _originalEvent = ev or event
    _data = _getFingersData(ev)
    _handle "start", ev.target, _data

  _move = (ev) ->
    return unless _started
    _originalEvent = ev or event
    _data = _getFingersData(ev)
    _handle "move", ev.target, _data

  _end = (ev) ->
    return unless _started
    _originalEvent = ev or event
    _handle "end", ev.target, _data
    _started = false

  _cancel = (ev) ->
    _started = false
    _handle "cancel"

  _addDelegations = (events) ->
    events.forEach (event_name) ->
      $$.fn[event_name] = (callback) ->
        $$(document.body).delegate @selector, event_name, callback
    @

  _handle = (eventName, target, data) ->
    for name, handler of _handlers when handler[eventName]
      handler[eventName].call(handler, target, data)

  _getFingersData = (event) ->
    touches = if $$.isMobile() then event.touches else [event]
    return ({x: t.pageX, y: t.pageY} for t in touches)

  add         : add
  trigger     : trigger
