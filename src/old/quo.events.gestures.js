/*
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var TOUCH = {};
    var TOUCH_TIMEOUT;
    var HOLD_DELAY = 650;
    var GESTURES = ['doubleTap',
                    'hold',
                    'swipe', 'swiping', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown',
                    'drag'];

    /**
     * ?
     */
    GESTURES.forEach(function(event) {
        $$.fn[event] = function(callback) {
            return this.on(event, callback);
        };
    });

    /**
     * ?
     */
    $$(document).ready(function() {
        _listenTouches();
    });

    function _listenTouches() {
        var environment = $$(document.body);

        environment.bind('touchstart', _onTouchStart);
        environment.bind('touchmove', _onTouchMove);
        environment.bind('touchend', _onTouchEnd);
        environment.bind('touchcancel', _cleanGesture);
    }

    function _onTouchStart(event) {
        var now = Date.now();
        var delta = now - (TOUCH.last || now);
        var touch_event = _captureTouch(event);

        TOUCH_TIMEOUT && clearTimeout(TOUCH_TIMEOUT);
        TOUCH = {
            el: $$(_parentIfText(touch_event.target)),
            x1: touch_event.pageX,
            y1: touch_event.pageY,
            isDoubleTap: (delta > 0 && delta <= 250) ? true : false,
            last: now,
            fingers: _countFingers(event)
        }
        setTimeout(_hold, HOLD_DELAY);
    }

    function _onTouchMove(event) {
        var touch_event = _captureTouch(event);
        TOUCH.x2 = touch_event.pageX;
        TOUCH.y2 = touch_event.pageY;

        if (_isSwipe(event)) {
            TOUCH.el.trigger('swiping', TOUCH);
        }
    }

    function _onTouchEnd(event) {
        if (TOUCH.isDoubleTap) {
            _trigger('doubleTap', true)

        } else if (TOUCH.x2 > 0 || TOUCH.y2 > 0) {
            if (_isSwipe(event)) {
                if (TOUCH.fingers == 1) {
                    _trigger('swipe', false);

                    swipe_direction = _swipeDirection(TOUCH.x1, TOUCH.x2, TOUCH.y1, TOUCH.y2);
                    _trigger(swipe_direction, false);
                } else {
                    _trigger('drag', false);
                }
            }

            _cleanGesture();
        } else {
            if (TOUCH.el) {
                _trigger('tap');
            }
            TOUCH_TIMEOUT = setTimeout( _cleanGesture, 250);
        }
    }

    function _trigger(type, clean) {
        TOUCH.el.trigger(type, TOUCH);
        clean && _cleanGesture();
    }

    function _cleanGesture(event) {
        TOUCH = {};
        clearTimeout(TOUCH_TIMEOUT);
    }

    function _isSwipe(event) {
        return TOUCH.el && (Math.abs(TOUCH.x1 - TOUCH.x2) > 30 || Math.abs(TOUCH.y1 - TOUCH.y2) > 30);
    };

    function _captureTouch(event) {
        return ($$.isMobile()) ? event.touches[0] : event;
    }

    function _parentIfText(node) {
        return 'tagName' in node ? node : node.parentNode;
    }

    function _swipeDirection(x1, x2, y1, y2) {
        var xDelta = Math.abs(x1 - x2);
        var yDelta = Math.abs(y1 - y2);

        if (xDelta >= yDelta) {
            return (x1 - x2 > 0 ? 'swipeLeft' : 'swipeRight');
        } else {
            return (y1 - y2 > 0 ? 'swipeUp' : 'swipeDown');
        }
    }

    function _hold() {
        if (TOUCH.last && (Date.now() - TOUCH.last >= HOLD_DELAY)) {
            _trigger('hold');
            _cleanGesture();
        }
    }

    function _countFingers(event) {
         return event.touches ? event.touches.length : 1;
    }

})(Quo);