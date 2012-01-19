/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    /**
     * ?
     */
    $$.fn.text = function(value) {
        return (!value) ?
            this[0].textContent
            :
            this.each(function() {
                this.textContent = value;
            });
    };

    /**
     * ?
     */
    $$.fn.html = function(value) {
        return ($$.toType('value') === 'string') ?
            this.each(function() {
                this.innerHTML = value;
            })
            :
            this[0].innerHTML;
    };

    /**
     * ?
     */
    $$.fn.append = function(value) {
        return this.each(function() {
            if ($$.toType(value) === 'string') {
                var div = document.createElement();
                div.innerHTML = value;
                this.appendChild(div.firstChild);
            } else {
                this.parentNode.insertBefore(value);
            }
        });
    };

    /**
     * ?
     */
    $$.fn.prepend = function(value) {
        return this.each(function() {
            if ($$.toType(value) === 'string') {
                this.innerHTML = value + this.innerHTML;
            } else {
                var parent = this.parentNode;
                parent.insertBefore(value, parent.firstChild);
            }
        });
    };

    /**
     * ?
     */
    $$.fn.empty = function() {
        return this.each(function() {
            this.innerHTML = null;
        });
    };

})(Quo);