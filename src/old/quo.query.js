/*
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$){

    var PARENT_NODE = 'parentNode';

    /**
     * ?
     */
    $$.query = function(domain, selector) {
        var dom_elements = document.querySelectorAll(selector);
        dom_elements = Array.prototype.slice.call(dom_elements);

        return dom_elements;
    };

    /**
     * ?
     */
    $$.fn.parent = function(selector) {
        var ancestors = (selector) ? _findAncestors(this) : this.instance(PARENT_NODE);
        return _filtered(ancestors, selector);
    };

    /**
     * ?
     */
    $$.fn.siblings = function(selector) {
        var siblings_elements = this.map(function(index, element) {
            return Array.prototype.slice.call(element.parentNode.children).filter(function(child) {
                return child !== element
            });
        });

        return _filtered(siblings_elements, selector);
    };

    /**
     * ?
     */
    $$.fn.children = function(selector) {
        var children_elements = this.map(function() {
            return Array.prototype.slice.call(this.children);
        });

        return _filtered(children_elements, selector);
    };

    /**
     * ?
     */
    $$.fn.get = function(index) {
        return index === undefined ? this : this[index]
    };

    /**
     * ?
     */
    $$.fn.first = function() {
        return $$(this[0]);
    };

    /**
     * ?
     */
    $$.fn.last = function() {
        var last_element_index = this.length - 1;
        return $$(this[last_element_index]);
    };

    /**
     * ?
     */
    $$.fn.closest = function(selector, context) {
        var node = this[0];
        var candidates = $$(selector);

        if (!candidates.length) node = null;
        while (node && candidates.indexOf(node) < 0) {
            node = node !== context && node !== document && node.parentNode;
        }

        return $$(node);
    };

    /**
     * ?
     */
    $$.fn.each = function(callback) {
        this.forEach( function(el, idx) {
            callback.call(el, idx, el)
        });
        return this;
    };

    var _findAncestors = function(nodes) {
        var ancestors = []
        while (nodes.length > 0) {
            nodes = $$.map(nodes, function(node) {
                if ((node = node.parentNode) && node !== document && ancestors.indexOf(node) < 0) {
                    ancestors.push(node);
                    return node;
                }
            });
        }

        return ancestors;
    }

    var _filtered = function(nodes, selector) {
        return (selector === undefined) ? $$(nodes) : $$(nodes).filter(selector);
    }

})(Quo);