###
Quo Gestures manager

@namespace Quo
@class Gestures

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Quo.Gestures = do ($$ = Quo) ->

  _started        = false
  _handlers       = {}
  _fingers        = null
  _originalEvent  = null
  _disabled_tags  = ["input", "select", "textarea"]

  add = (gesture) ->
    _handlers[gesture.name] = gesture.handler
    _addDelegations gesture.events

  trigger = (target, eventName, gestureData) ->
    $$(target).trigger(eventName, gestureData, _originalEvent)

  # Private methods
  _start = (ev) ->
    return ev.stopPropagation() if (ev.srcElement or ev.target).tagName.toLowerCase() in _disabled_tags
    _started = true
    _originalEvent = ev or event
    _fingers = _getFingers(ev)
    _handle "start", ev.target, _fingers

  _move = (ev) ->
    return unless _started
    _originalEvent = ev or event
    _fingers = _getFingers(ev)
    _originalEvent.preventDefault() if _fingers.length > 1
    _handle "move", ev.target, _fingers

  _end = (ev) ->
    return unless _started
    _originalEvent = ev or event
    _handle "end", ev.target, _fingers
    _started = false

  _cancel = (ev) ->
    _started = false
    _handle "cancel"

  _addDelegations = (events) ->
    events.forEach (event_name) ->
      $$.fn[event_name] = (callback) ->
        $$(document.body).delegate @selector, event_name, callback
    @

  _handle = (event, target, data) ->
    for name, handler of _handlers when handler[event]
      handler[event].call(handler, target, data)

  _getFingers = (event) ->
    ({x: t.pageX, y: t.pageY} for t in event.touches or [event])

  $$(document).ready ->
    environment = $$ document.body
    environment.bind "touchstart", _start
    environment.bind "touchmove", _move
    environment.bind "touchend", _end
    environment.bind "touchcancel", _cancel

  add         : add
  trigger     : trigger
