/*
  QuoJS 1.1
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($){

    var VENDORS = ['webkit','moz','ms','o',''];
    var CSS_PROPERTIES = {
        "userSelect": "none",
        "touchCallout": "none",
        "userDrag": "none",
        "tapHighlightColor": "rgba(0,0,0,0)"
    };

    /**
     * ?
     */
    $.fn.vendor = function() {
        _vendor();
    };

    function _vendor() {
        var properties = '';
        for(var i = 0; i < VENDORS.length; i++) {
            for(var property in CSS_PROPERTIES) {
                properties = property;
                if(VENDORS[i]) {
                    properties = VENDORS[i] + properties.substring(0, 1).toUpperCase() + properties.substring(1);
                }
                this.style(properties) = CSS_PROPERTIES[property];
            }
        }
    }

})(Quo);