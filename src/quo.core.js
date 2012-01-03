//     Quo.js
//     (c) 2011, 2012 Javier Jiménez Villar (@soyjavi)
//     Quo.js may be freely distributed under the MIT license.

(function($$) {

    var OBJ_PROTO   = Object.prototype;

    /**
     * Determine the internal JavaScript [[Class]] of an object.
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.toType = toType = function(obj) {
        return OBJ_PROTO.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
    }

    /**
     * ?
     */
     $$.mix = mix =  function() {
        var child = child || {};
        for (var arg = 0, len = arguments.length; arg < len; arg++) {
            var argument = arguments[arg];
            for (var prop in argument) {
                if (isOwnProperty(argument, prop)) {
                    child[prop] = argument[prop];
                }
            }
        }
        return child;
    };

    /**
     * ?
     */
    $$.isOwnProperty = isOwnProperty = function(object, property) {
        return OBJ_PROTO.hasOwnProperty.call(object, property);
    };


    /**
     * Realiza un casting del selector para saber si QuoJS puede trabajar o no
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.getDomainSelector = getDomainSelector = function(selector) {
        var domain = null;

        var elementTypes = [1, 9, 11];

        var type = toType(selector);
        //if (type === 'string' || type === 'htmldocument') {
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

})(Quo);
