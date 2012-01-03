//     Quo.js
//     (c) 2011, 2012 Javier Jiménez Villar (@soyjavi)
//     Quo.js may be freely distributed under the MIT license.

(function($$) {

    $$.fn.attr = function(name, value) {
        if (toType(name) === 'string' && value === undefined) {
            return this[0].getAttribute(name);
        } else {
            return this.each(function() {
                this.setAttribute(name, value);
            });
        }
    }

    $$.fn.data = function(name, value) {
        return this.attr('data-' + name, value);
    }

    $$.fn.val = function(value) {
        if (value) {
            return this.each(function() {
                this.value = value;
            });
        } else {
            return (this.length > 0 ? this[0].value : null)
        }
    }

    $$.fn.height = function() {

    }

    $$.fn.width = function() {

    }

    $$.fn.offset = function() {
        var bounding = this[0].getBoundingClientRect();

        return {
            left: bounding.left + window.pageXOffset,
            top: bounding.top + window.pageYOffset,
            width: bounding.width,
            height: bounding.height
        };
    }

    $$.fn.remove = function() {
        return this.each(function() {
            if (this.parentNode != null) {
                this.parentNode.removeChild(this);
            }
        });
    }

})(Quo);
