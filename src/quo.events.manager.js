/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var ELEMENT_ID = 1;
    var HANDLERS = {};
    var EVENT_METHODS = {
        preventDefault: 'isDefaultPrevented',
        stopImmediatePropagation: 'isImmediatePropagationStopped',
        stopPropagation: 'isPropagationStopped' };
    var EVENTS_DESKTOP = {
        touchstart : 'mousedown',
        touchmove: 'mousemove',
        touchend: 'mouseup',
        tap: 'click',
        doubletap: 'dblclick',
        orientationchange: 'resize' };

    /**
     * ?
     */
    $$.Event = function(type, props) {
        var event = document.createEvent('Events');
        event.initEvent(type, true, true, null, null, null, null, null, null, null, null, null, null, null, null);

        return event;
    };

    /**
     * ?
     */
    $$.fn.bind = function(event, callback) {
        return this.each(function() {
            _subscribe(this, event, callback);
        });
    };

    /**
     * ?
     */
    $$.fn.unbind = function(event, callback){
        return this.each(function() {
            _unsubscribe(this, event, callback);
        });
    };

    /**
     * ?
     */
    $$.fn.delegate = function(selector, event, callback) {
        return this.each(function(i, element) {
            _subscribe(element, event, callback, selector, function(fn) {
                return function(e) {
                    var match = $$(e.target).closest(selector, element).get(0);
                    if (match) {
                        var evt = $$.extend(_createProxy(e), {
                            currentTarget: match,
                            liveFired: element
                        });
                        return fn.apply(match, [evt].concat([].slice.call(arguments, 1)));
                    }
                }
            });
        });
    };

    /**
     * ?
     */
    $$.fn.undelegate = function(selector, event, callback){
        return this.each(function(){
            _unsubscribe(this, event, callback, selector);
        });
    };

    /**
     * ?
     */
    $$.fn.trigger = function(event) {
        if ($$.toType(event) === 'string') event = $$.Event(event);
        return this.each(function() {
            this.dispatchEvent(event);
        });
    };

    function _subscribe(element, event, callback, selector, delegate_callback) {
        event = _environmentEvent(event);

        var element_id = _getElementId(element);
        var element_handlers = HANDLERS[element_id] || (HANDLERS[element_id] = []);
        var delegate = delegate_callback && delegate_callback(callback, event);

        var handler = {
            event: event,
            callback: callback,
            selector: selector,
            proxy: _createProxyCallback(delegate, callback, element),
            delegate: delegate,
            index: element_handlers.length
        };
        element_handlers.push(handler);

        element.addEventListener(handler.event, handler.proxy, false);
    }

    function _unsubscribe(element, event, callback, selector) {
        event = _environmentEvent(event);

        var element_id = _getElementId(element);
        _findHandlers(element_id, event, callback, selector).forEach(function(handler) {
            delete HANDLERS[element_id][handler.index];
            element.removeEventListener(handler.event, handler.proxy, false);
        });
    }

    function _getElementId(element) {
        return element._id || (element._id = ELEMENT_ID++);
    }

    function _environmentEvent(event) {
        var environment_event = ($$.isMobile()) ? event : EVENTS_DESKTOP[event];

        return (environment_event) || event;
    }

    function _createProxyCallback(delegate, callback, element) {
        var callback = delegate || callback;

        var proxy = function (event) {
            var result = callback.apply(element, [event].concat(event.data));
            if (result === false) {
                event.preventDefault();
            }
            return result;
        };

        return proxy;
    }

    function _findHandlers(element_id, event, fn, selector) {
        return (HANDLERS[element_id] || []).filter(function(handler) {
            return handler
            && (!event  || handler.event == event)
            && (!fn       || handler.fn == fn)
            && (!selector || handler.selector == selector);
        });
    }

    function _createProxy(event) {
        var proxy = $$.extend({originalEvent: event}, event);

        $$.each(EVENT_METHODS, function(name, method) {
            proxy[name] = function() {
                this[method] = function(){ return true };
                return event[name].apply(event, arguments);
            };
            proxy[method] = function() { return false };
        })
        return proxy;
    }

})(Quo);