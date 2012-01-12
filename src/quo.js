/*!
 * QuoJS 1.0 ~ Copyright (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
 * http://quojs.tapquo.com
 * Released under MIT license, https://raw.github.com/soyjavi/QuoJS/master/LICENSE.txt
 */

var Quo = (function() {

    var EMPTY_ARRAY = [];

    function Q(dom, selector) {
        dom = dom || EMPTY_ARRAY;
        dom.__proto__ = Q.prototype;
        dom.selector = selector || '';

        return dom;
    };

    /**
     * ?
     */
    function $$(selector) {
        if (!selector) {
          return Q();
        } else {
            var domain_selector = $$.getDomainSelector(selector);
            return Q(domain_selector, selector);
        }
    };

    /**
     * ?
     */
    $$.extend = function(target) {
        Array.prototype.slice.call(arguments, 1).forEach(function(source) {
          for (key in source) target[key] = source[key];
        })
        return target;
    };

    Q.prototype = $$.fn = {};

    return $$;
})();

window.Quo = Quo;
'$$' in window || (window.$$ = Quo);