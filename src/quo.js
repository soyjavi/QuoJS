//     QuoJS
//     (c) 2011, 2012 Javier Jiménez Villar
//     QuoJS may be freely distributed under the MIT license.

var Quo = (function() {
    var undefined, key, $$, classList, emptyArray = [], slice = emptyArray.slice, document = window.document;

    function likeArray(obj) {
        return typeof obj.length == 'number'
    }

    function flatten(array) {
        return array.length > 0 ? [].concat.apply([], array) : array
    }

    /* ---------------------------------------------------------- */
    /* ---------------------------------------------------------- */

    function Q(dom, selector) {
        dom = dom || emptyArray;
        dom.__proto__ = Q.prototype;
        dom.selector = selector || '';

        return dom;
    }

    function $$(selector, context) {
        if (!selector) {
          return Q();
        } else {
            var domain_selector = getDomainSelector(selector);
            return Q(domain_selector, selector);
        }
    }

    $$.extend = function(target) {
        slice.call(arguments, 1).forEach(function(source) {
          for (key in source) target[key] = source[key];
        })
        return target;
    }

    $$.map = function(elements, callback) {
        var value, values = [], i, key;

        if ( likeArray(elements) )
          for (i = 0; i < elements.length; i++) {
            value = callback(elements[i], i);
            if (value != null) values.push(value);
          }
        else
          for (key in elements) {
            value = callback(elements[key], key);
            if (value != null) values.push(value);
          }
        return flatten(values);
    }

    $$.each = function(elements, callback) {
        var i, key;
        if (likeArray(elements))
          for(i = 0; i < elements.length; i++) {
            if(callback.call(elements[i], i, elements[i]) === false) return elements;
          }
        else
          for(key in elements) {
            if(callback.call(elements[key], key, elements[key]) === false) return elements;
          }
        return elements;
    }

    $$.fn = {
        forEach: emptyArray.forEach,

        map: function(fn) {
            return $$.map(this, function(el, i){ return fn.call(el, i, el) });
        },

        each: function(callback) {
            this.forEach( function(el, idx) {
                callback.call(el, idx, el)
            });
            return this;
        }
    };

    Q.prototype = $$.fn;

    return $$;
})();

window.Quo = Quo;
'$$' in window || (window.$$ = Quo);