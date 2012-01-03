//     Quo.js
//     (c) 2011, 2012 Javier Jiménez Villar (@soyjavi)
//     Quo.js may be freely distributed under the MIT license.

(function($$) {

    var SHORTCUTS = [
        'touch',
        'tap'
    ];

    var SHORTCUTS_EVENTS = {
        touch: 'touchstart',
        tap: 'tap'
    };

    var READY_EXPRESSION = /complete|loaded|interactive/;

    SHORTCUTS.forEach(function(event) {
        $$.fn[event] = function(callback) {
            $$(document.body).delegate(this.selector, SHORTCUTS_EVENTS[event], callback);
            return this;
        };
    });

    $$.fn.on = function(event, selector, callback) {
        return (selector === undefined || toType(selector) === 'function') ?
            this.bind(event, selector)
            :
            this.delegate(selector, event, callback);
    };

    $$.fn.off = function(event, selector, callback){
        return (selector === undefined || toType(selector) === 'function') ?
            this.unbind(event, selector)
            :
            this.undelegate(selector, event, callback);
    };

    $$.fn.ready =function(callback) {
        if (READY_EXPRESSION.test(document.readyState)) {
            callback($$);
        }
        else {
            document.addEventListener('DOMContentLoaded', function(){ callback($$) }, false);
        }
      return this;

    };

})(Quo);
