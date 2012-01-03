//     Quo.js
//     (c) 2011, 2012 Javier Jiménez Villar (@soyjavi)
//     Quo.js may be freely distributed under the MIT license.

(function($$) {

    var TOUCH = {};
    var TOUCH_TIMEOUT;
    var LONGTAP_DELAY = 600;
    var GESTURES = ['swipe', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown', 'doubleTap', 'longTap'];

    GESTURES.forEach(function(event) {
        $$.fn[event] = function(callback) {
            return this.bind(event, callback);
        };
    });

    $$(document).ready(function() {
        _listenTouches();
    });

    function _listenTouches() {
        var ent = $$(document.body);

        ent.bind('touchstart', _onTouchStart);
        ent.bind('touchmove', _onTouchMove);
        ent.bind('touchend', _onTouchEnd);
        ent.bind('touchcancel', _onTouchCancel);
    }

    function _onTouchStart(event) {
        var now = Date.now();
        var delta = now - (TOUCH.last || now);
        var first_touch = ($$.isMobile()) ? event.touches[0] : event;

        TOUCH_TIMEOUT && clearTimeout(TOUCH_TIMEOUT);

        TOUCH = {
            el: $$(_parentIfText(first_touch.target)),
            x1: first_touch.pageX,
            y1: first_touch.pageY,
            isDoubleTap: (delta > 0 && delta <= 250) ? true : false,
            last: now
        }
        setTimeout(_longTap, LONGTAP_DELAY);
    };

    function _onTouchMove(event) {
        var move_touch = ($$.isMobile()) ? event.touches[0] : event;
        TOUCH.x2 = move_touch.pageX;
        TOUCH.y2 = move_touch.pageY;
    };

    function _onTouchEnd(event) {
        if (TOUCH.isDoubleTap) {
            TOUCH.el.trigger('doubleTap');
            TOUCH = {};
        } else if (TOUCH.x2 > 0 || TOUCH.y2 > 0) {
            (Math.abs(TOUCH.x1 - TOUCH.x2) > 30 || Math.abs(TOUCH.y1 - TOUCH.y2) > 30)  &&
            TOUCH.el.trigger('swipe') &&
            TOUCH.el.trigger('swipe' + (_swipeDirection(TOUCH.x1, TOUCH.x2, TOUCH.y1, TOUCH.y2)));
            TOUCH.x1 = TOUCH.x2 = TOUCH.y1 = TOUCH.y2 = TOUCH.last = 0;
        } else {
            TOUCH_TIMEOUT = setTimeout(function(){
                TOUCH_TIMEOUT = null;
                TOUCH = {};
            }, 250);
        }
    };

    function _onTouchCancel(event) {
        TOUCH = {};
    };

    function _parentIfText(node) {
        return 'tagName' in node ? node : node.parentNode;
    };

    function _swipeDirection(x1, x2, y1, y2) {
        var xDelta = Math.abs(x1 - x2);
        var yDelta = Math.abs(y1 - y2);

        if (xDelta >= yDelta) {
            return (x1 - x2 > 0 ? 'Left' : 'Right');
        } else {
            return (y1 - y2 > 0 ? 'Up' : 'Down');
        }
    }

    function _longTap() {
        if (TOUCH.last && (Date.now() - TOUCH.last >= LONGTAP_DELAY)) {
            TOUCH.el.trigger('longTap');
            TOUCH = {};
        }
    }

})(Quo);
