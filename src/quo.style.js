/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($){

    /**
     * ?
     */
    $.fn.addClass = function(name) {
        return this.each(function() {
            if (!_existsClass(name, this.className)) {
                this.className += ' ' + name;
                this.className = this.className.trim();
            }
        });
    };

    /**
     * ?
     */
    $.fn.removeClass = function(name) {
        return this.each(function() {
            if (_existsClass(name, this.className)) {
                this.className = this.className.replace(name, ' ').replace(/\s+/gi, ' ').trim();
            }
        });
    };

    /**
     * ?
     */
    $.fn.toggleClass = function(name) {
        return this.each(function() {
            if (_existsClass(name, this.className)) {
                this.className = this.className.replace(name, ' ');
            } else {
                this.className += ' ' + name;
                this.className = this.className.trim();
            }
        });
    };

    /**
     * ?
     */
    $.fn.hasClass = function(name) {
        return _existsClass(name, this[0].className);
    }

    /**
     * ?
     */
    $.fn.style = function(property, value) {
        return (!value) ?
            this[0].style[property] || _computedStyle(this[0], property)
            :
            this.each(function() {
                this.style[property] = value;
            });
    };

    function _existsClass(name, className) {
        var classes = className.split(/\s+/g);
        return (classes.indexOf(name) >= 0);
    }

    function _computedStyle(element, property) {
        return document.defaultView.getComputedStyle(element, '')[property];
    }

})(Quo);