/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var OBJ_PROTO   = Object.prototype;
    var EMPTY_ARRAY = [];

    /**
     * ?
     */
    $$.each = function(elements, callback) {
        var i, key;
        if (_likeArray(elements))
          for(i = 0; i < elements.length; i++) {
            if(callback.call(elements[i], i, elements[i]) === false) return elements;
          }
        else
          for(key in elements) {
            if(callback.call(elements[key], key, elements[key]) === false) return elements;
          }
        return elements;
    }

    /**
     * ?
     */
     $$.mix = function() {
        var child = child || {};  //child doesn't exist? Could you check it?
        for (var arg = 0, len = arguments.length; arg < len; arg++) {
            var argument = arguments[arg];
            for (var prop in argument) {
                if ($$.isOwnProperty(argument, prop)) {
                    child[prop] = argument[prop];
                }
            }
        }
        return child;
    };

    /**
     * Determine the internal JavaScript [[Class]] of an object.
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.toType = function(obj) {
        return OBJ_PROTO.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
    }

    /**
     * ?
     */
    $$.isOwnProperty = function(object, property) {
        return OBJ_PROTO.hasOwnProperty.call(object, property);
    };

    /**
     * Casting for selector
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.getDomainSelector = function(selector) {
        var domain = null;
        var elementTypes = [1, 9, 11];

        var type = $$.toType(selector);
        if (type === 'string') {
            domain = queryDOM(document, selector);
        } else if (type === 'array') {
            domain = _compact(selector);
        } else if (elementTypes.indexOf(selector.nodeType) >= 0 || selector === window) {
            domain = [selector];
            selector = null;
        } else {
            console.error('ERROR: The selector is invalid');
        }

        return domain;
    }

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
    $$.fn.pluck = function(property) {
        return this.map(function() {
            return this[property];
        });
    }

    var _compact = function(array) {
        return array.filter(function(item) {
            return item !== undefined && item !== null
        });
    }

    function _likeArray(obj) {
        return typeof obj.length == 'number'
    }

    function _flatten(array) {
        return array.length > 0 ? [].concat.apply([], array) : array
    }

})(Quo);