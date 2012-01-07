/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var TOUCH = {};
    var TOUCH_TIMEOUT;
    var LONGTAP_DELAY = 750;
    var GESTURES = ['swipe', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown', 'doubleTap', 'longTap'];

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
        environment.bind('touchcancel', _onTouchCancel);
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
            isDoubleTap: (delta > 0 && delta <= 250),
            last: now
        };
        setTimeout(_longTap, LONGTAP_DELAY);
    }

    function _onTouchMove(event) {
        var move_touch = ($$.isMobile()) ? event.touches[0] : event;
        TOUCH.x2 = move_touch.pageX;
        TOUCH.y2 = move_touch.pageY;
    }

    function _onTouchEnd() {
        if (TOUCH.isDoubleTap) {
            TOUCH.el.trigger('doubleTap');
            TOUCH = {};
        } else if (TOUCH.x2 > 0 || TOUCH.y2 > 0) {
            (Math.abs(TOUCH.x1 - TOUCH.x2) > 30 || Math.abs(TOUCH.y1 - TOUCH.y2) > 30)  &&
            TOUCH.el.trigger('swipe') &&
            TOUCH.el.trigger('swipe' + (_swipeDirection(TOUCH.x1, TOUCH.x2, TOUCH.y1, TOUCH.y2)));

            TOUCH.x1 = TOUCH.x2 = TOUCH.y1 = TOUCH.y2 = TOUCH.last = 0;
            TOUCH = {};
        } else {
            TOUCH_TIMEOUT = setTimeout(function(){
                TOUCH_TIMEOUT = null;
                TOUCH = {};
            }, 250);
        }
    }

    function _onTouchCancel() {
        TOUCH = {};
        clearTimeout(TOUCH_TIMEOUT);
    }

    function _parentIfText(node) {
        return 'tagName' in node ? node : node.parentNode;
    }

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