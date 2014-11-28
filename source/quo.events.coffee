###
EVENTS Quo Module

@namespace Quo
@class Events

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  ELEMENT_ID = 1
  HANDLERS = {}
  EVENT_METHODS =
    preventDefault          : "isDefaultPrevented"
    stopImmediatePropagation: "isImmediatePropagationStopped"
    stopPropagation         : "isPropagationStopped"
  EVENTS_DESKTOP =
    touchstart        : "mousedown"
    touchmove         : "mousemove"
    touchend          : "mouseup"
    touch             : "click"
    orientationchange : "resize"

  READY_EXPRESSION = /complete|loaded|interactive/

  ###
  Attach an event handler function for one or more events to a given instance element
  @method on
  @param  {string} One or more space-separated event types
  @param  {string} A selector string to filter the descendants of the selected elements that trigger the event
  @param  {function} A function to execute when the event is triggered
  ###
  $$.fn.on = (event, selector, callback) ->
    if not selector? or $$.toType(selector) is "function"
      @bind event, selector
    else
      @delegate selector, event, callback


  ###
  Remove an event handler.
  @method off
  @param  {string} One or more space-separated event types
  @param  {string} [OPTIONAL] A selector string to filter the descendants of the selected elements that trigger the event
  @param  {function} [OPTIONAL] A function to execute when the event is triggered
  ###
  $$.fn.off = (event, selector, callback) ->
    if not selector? or $$.toType(selector) is "function"
      @unbind event, selector
    else
      @undelegate selector, event, callback


  ###
  Specify a function to execute when the DOM is fully loaded.
  @method ready
  @param  {function} A function to execute after the DOM is ready.
  ###
  $$.fn.ready = (callback) ->
    if READY_EXPRESSION.test(document.readyState)
      callback.call @, $$
    else
      $$.fn.addEvent document, "DOMContentLoaded", -> callback.call @, $$


  ###
  Attach a handler to an event for the elements.
  @method bind
  @param  {string} One or more space-separated event types
  @param  {function} A function to execute when the event is triggered
  ###
  $$.fn.bind = (event, callback) ->
    @forEach (element) -> _subscribe element, event, callback


  ###
  Remove a previously-attached event handler from the elements.
  @method unbind
  @param  {string} One or more space-separated event types
  @param  {function} [OPTIONAL] A function to execute when the event is triggered
  ###
  $$.fn.unbind = (event, callback) ->
    @each -> _unsubscribe @, event, callback


  ###
  Attach a handler to one or more events for all elements that match the selector
  @method delegate
  ###
  $$.fn.delegate = (selector, event, callback) ->
    @each (i, element) ->
      _subscribe element, event, callback, selector, (fn) ->
        (e) ->
          match = $$(e.target).closest(selector, element).get(0)
          if match
            evt = $$.extend(_createProxy(e),
              currentTarget: match
              liveFired: element
            )
            fn.apply match, [ evt ].concat([].slice.call(arguments, 1))


  ###
  Remove a handler from the event for all elements which match the current selector
  @method undelegate
  ###
  $$.fn.undelegate = (selector, event, callback) ->
    @each -> _unsubscribe @, event, callback, selector


  ###
  Execute all handlers and behaviors attached to the matched elements for the given event type.
  @method trigger
  ###
  $$.fn.trigger = (event, touch, originalEvent) ->
    event = _event(event, touch) if $$.toType(event) is "string"
    event.originalEvent = originalEvent if originalEvent?
    @each -> @dispatchEvent event


  $$.fn.addEvent = (element, event_name, callback) ->
    if element.addEventListener
      element.addEventListener event_name, callback, false
    else if element.attachEvent
      element.attachEvent "on" + event_name, callback
    else
      element["on" + event_name] = callback


  $$.fn.removeEvent = (element, event_name, callback) ->
    if element.removeEventListener
      element.removeEventListener event_name, callback, false
    else if element.detachEvent
      element.detachEvent "on" + event_name, callback
    else
      element["on" + event_name] = null

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _event = (type, touch) ->
    event = document.createEvent("Events")
    event.initEvent type, true, true, null, null, null, null, null, null, null, null, null, null, null, null
    if touch then event.touch = touch
    event

  _subscribe = (element, event, callback, selector, delegate_callback) ->
    event = _environmentEvent(event)
    element_id = _getElementId(element)
    element_handlers = HANDLERS[element_id] or (HANDLERS[element_id] = [])
    delegate = delegate_callback and delegate_callback(callback, event)
    handler =
      event   : event
      callback: callback
      selector: selector
      proxy   : _createProxyCallback(delegate, callback, element)
      delegate: delegate
      index   : element_handlers.length

    element_handlers.push handler
    $$.fn.addEvent element, handler.event, handler.proxy

  _unsubscribe = (element, event, callback, selector) ->
    event = _environmentEvent(event)
    element_id = _getElementId(element)
    _findHandlers(element_id, event, callback, selector).forEach (handler) ->
      delete HANDLERS[element_id][handler.index]
      $$.fn.removeEvent element, handler.event, handler.proxy

  _getElementId = (element) ->
    element._id or (element._id = ELEMENT_ID++)

  _environmentEvent = (event) ->
    environment_event = if $$.isMobile?() then event else EVENTS_DESKTOP[event]
    environment_event or event

  _createProxyCallback = (delegate, callback, element) ->
    callback = delegate or callback
    proxy = (event) ->
      result = callback.apply(element, [ event ].concat(event.data))
      event.preventDefault() if result is false
      result
    proxy

  _findHandlers = (element_id, event, fn, selector) ->
    (HANDLERS[element_id] or []).filter (handler) ->
      handler and (not event or handler.event is event) and (not fn or handler.callback is fn) and (not selector or handler.selector is selector)

  _createProxy = (event) ->
    proxy = $$.extend originalEvent: event, event
    $$.each EVENT_METHODS, (name, method) ->
      proxy[name] = ->
        @[method] = -> true
        event[name].apply event, arguments
      proxy[method] = -> false
    proxy
