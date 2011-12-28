//     Zepto.js
//     (c) 2010, 2011 Thomas Fuchs
//     Zepto.js may be freely distributed under the MIT license.

(function($$){

    var TYPE_SELECTORS = [
        { method: 'getElementByClassName', expression: /^\.([\w-]+)$/ },
        { method: 'getElementsByTagName', expression: /^[\w-]+$/ }
        /*,
        { method: 'getElementById', expression: /^#([\w-]+)$/ }
        */
    ];

    var PARENT_NODE = 'parentNode';
    var QUERY_ALL = 'querySelectorAll';

    /**
     * Determine the internal JavaScript [[Class]] of an object.
     *
     * @param {object} obj to get the real type of itself.
     * @return {string} with the internal JavaScript [[Class]] of itself.
     */
    $$.query = queryDOM = function(domain, selector) {
        var method = _selectMethod(selector);

        var dom_elements = document[method].call(document, selector);
        dom_elements = Array.prototype.slice.call(dom_elements);

        return dom_elements;
    }

    $$.fn.parent = function(selector) {
        var pluck = this.pluck(PARENT_NODE);

        return _filtered(pluck, selector);
    }

    $$.fn.siblings = function(selector) {
        var siblings_elements = this.map(function(index, element) {
            return Array.prototype.slice.call(element.parentNode.children).filter(function(child) {
                return child !== element
            });
        });

        return _filtered(siblings_elements, selector);
    }

    $$.fn.children = function(selector) {
        var children_elements = this.map(function() {
            return Array.prototype.slice.call(this.children);
        });

        return _filtered(children_elements, selector);
    }

    $$.fn.get = function(index) {
        return index === undefined ? this : this[index]
    }

    $$.fn.first = function() {
        return $$(this[0]);
    }

    $$.fn.last = function() {
        var last_element_index = this.length - 1;
        return $$(this[last_element_index]);
    }

    var _selectMethod = function(selector) {
        var method;

        for (type in TYPE_SELECTORS) {
            var type_selector = TYPE_SELECTORS[type];
            if (type_selector.expression.test(selector)) {
                method = type_selector.method;
                break;
            }
        }

        return (method) ? method : QUERY_ALL;
    }

    var _filtered = function(nodes, selector) {
        //TODO: Refactor
        console.error(selector);
        return (selector === undefined) ? $$(nodes) : $$(nodes).filter(selector);
    }

})(Quo);
