/*
  QuoJS 1.1
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var OBJ_PROTO   = Object.prototype;
    var EMPTY_ARRAY = [];

    /**
     * Determine the internal JavaScript [[Class]] of an object.
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.toType = function(obj) {
        return OBJ_PROTO.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
    };

    /**
     * ?
     */
    $$.isOwnProperty = function(object, property) {
        return OBJ_PROTO.hasOwnProperty.call(object, property);
    };

    /**
     * ?
     */
    $$.getDomainSelector = function(selector) {
        var domain = null;
        var elementTypes = [1, 9, 11];

        var type = $$.toType(selector);
        if (type === 'array') {
            domain = _compact(selector);
        } else if (type === 'string') {
            domain = $$.query(document, selector);
        } else if (elementTypes.indexOf(selector.nodeType) >= 0 || selector === window) {
            domain = [selector];
            selector = null;
        }

        return domain;
    };

    /**
     * ?
     */
    $$.map = function(elements, callback) {
        //@TODO: Refactor!!!
        var values = [];
        var i;
        var key;

        if ($$.toType(elements) === 'array') {
            for (i = 0; i < elements.length; i++) {
                var value = callback(elements[i], i);
                if (value != null) values.push(value);
            }
        } else {
            for (key in elements) {
                value = callback(elements[key], key);
                if (value != null) values.push(value);
            }
        }
        return _flatten(values);
    };

    /**
     * ?
     */
    $$.each = function(elements, callback) {
        var i, key;
        if ($$.toType(elements) === 'array')
            for(i = 0; i < elements.length; i++) {
                if(callback.call(elements[i], i, elements[i]) === false) return elements;
            }
        else
            for(key in elements) {
                if(callback.call(elements[key], key, elements[key]) === false) return elements;
            }
        return elements;
    };

    /**
     * ?
     */
     $$.mix = function() {
        var child = {};
        for (var arg = 0, len = arguments.length; arg < len; arg++) {
            var argument = arguments[arg];
            for (var prop in argument) {
                if ($$.isOwnProperty(argument, prop) && argument[prop] !== undefined) {
                    child[prop] = argument[prop];
                }
            }
        }
        return child;
    };

    /**
     * ?
     */
    $$.fn.forEach = EMPTY_ARRAY.forEach;

    /**
     * ?
     */
    $$.fn.indexOf = EMPTY_ARRAY.indexOf;

    /**
     * ?
     */
    $$.fn.map = function(fn){
        return $$.map(this, function(el, i){ return fn.call(el, i, el) });
    };

    /**
     * ?
     */
     /*
    $$.fn.slice = function(){
        return $$(slice.apply(this, arguments));
    };
    */

    /**
     * ?
     */
    $$.fn.instance = function(property) {
        return this.map(function() {
            return this[property];
        });
    };

    /**
     * ?
     */
    $$.fn.filter = function(selector) {
        return $$([].filter.call(this, function(element) {
            return element.parentNode && $$.query(element.parentNode, selector).indexOf(element) >= 0;
        }));
    };

    function _compact(array) {
        return array.filter(function(item) {
            return item !== undefined && item !== null
        });
    }

    function _flatten(array) {
        return array.length > 0 ? [].concat.apply([], array) : array
    }

})(Quo);