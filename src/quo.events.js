(function($$) {

    var ELEMENT_ID = 1;
    var HANDLERS = {};

    $$.fn.listener = function(action, callback) {
        return this.each(function() {
            _subscribeEvent(this, action, callback);
        });
    };

    $$.fn.removeListener = function(action, callback) {
        return this.each(function() {
            _unsubscribeEvent(this, action, callback);
        });
    }

    $$.fn.bind = function(action, callback) {
        return this.each(function() {
            _subscribeEvent(this, action, callback);
        });
    };

    $$.fn.unbind = function(action, callback){
        return this.each(function() {
            _unsubscribeEvent(this, action, callback);
        });
    };

    function _subscribeEvent(element, action, callback, selector, getDelegate) {
        //TODO : Manager
        element.addEventListener(action, callback, false);
    }

    function _unsubscribeEvent(element, action, callback, selector) {
        //TODO : Manager
        element.removeEventListener(action, callback, type);
    }

    function _generateElementId(element) {
        return element._id || (element._id = ELEMENT_ID++);
    }

    /* Special Events */

    $$.fn.tap = function(callback) {
        return this.each(function() {

        });
    }

    $$.fn.touch = function(callback) {
        return this.each(function() {

        });
    }

    $$.fn.tap = function(callback) {
        return this.each(function() {

        });
    }

    $$.fn.swipe = function(callback) {
        return this.each(function() {

        });
    }

})(Quo);
