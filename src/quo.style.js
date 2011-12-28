//     Zepto.js
//     (c) 2010, 2011 Thomas Fuchs
//     Zepto.js may be freely distributed under the MIT license.

(function($){

    $.fn.addClass = function(name) {
        return this.each(function() {
            if (!_existsClass(name, this.className)) {
                this.className += ' ' + name;
            }
        });
    }

    $.fn.removeClass = function(name) {
        var remove_class = _generateRemoveClass(name);

        return this.each(function() {
            if (_existsClass(name, this.className)) {
                this.className = this.className.replace(remove_class, ' ');
            }
        });
    }

    $.fn.toggleClass = function(name) {
        var remove_class = _generateRemoveClass(name);

        return this.each(function() {
            if (_existsClass(name, this.className)) {
                this.className = this.className.replace(remove_class, '');
            } else {
                this.className += ' ' + name;
            }
        });
    }

    $.fn.hasClass = function(name) {
        return _existsClass(name, this[0].className);
    }

    $.fn.style = function(property, value) {
        return (!value) ?
            this[0].style[property]
            :
            this.each(function() {
                this.style[property] = value;
            });
    }

    function _existsClass(name, className) {
        var classes = className.split(/\s+/g);
        return (classes.indexOf(name) >= 0) ? true : false;
    }

    function _generateRemoveClass(name) {
        return new RegExp("(^|\\s+)" + name + "(\\s+|$)");
    }

})(Quo);
