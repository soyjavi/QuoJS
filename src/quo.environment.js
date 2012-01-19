/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var IS_WEBKIT = /WebKit\/([\d.]+)/;
    var SUPPORTED_OS = {
        android: /(Android)\s+([\d.]+)/,
        ipad: /(iPad).*OS\s([\d_]+)/,
        iphone: /(iPhone\sOS)\s([\d_]+)/,
        blackberry: /(BlackBerry).*Version\/([\d.]+)/,
        webos: /(webOS|hpwOS)[\s\/]([\d.]+)/
    };
    var CURRENT_ENVIRONMENT = null;

    /**
     * ?
     */
    $$.isMobile = function() {
        CURRENT_ENVIRONMENT = CURRENT_ENVIRONMENT || _detectEnvironment();

        return CURRENT_ENVIRONMENT.isMobile;
    };

    /**
     * ?
     */
    $$.environment = function() {
        CURRENT_ENVIRONMENT = CURRENT_ENVIRONMENT || _detectEnvironment();

        return CURRENT_ENVIRONMENT;
    };

    /**
     * ?
     */
    $$.isOnline = function() {
        return (navigator.onLine);
    };

    var _detectEnvironment = function() {
        var user_agent = navigator.userAgent;
        var environment = {};

        environment.browser = _detectBrowser(user_agent);
        environment.os = _detectOS(user_agent);
        environment.isMobile = (environment.os) ? true : false;

        return environment;
    }

    var _detectBrowser = function(user_agent) {
        var is_webkit = user_agent.match(IS_WEBKIT);

        return (is_webkit) ? is_webkit[0]: user_agent;
    }

    var _detectOS = function(user_agent) {
        var detected_os;

        for (os in SUPPORTED_OS) {
            var supported = user_agent.match(SUPPORTED_OS[os]);

            if (supported) {
                detected_os = {
                    name: (os === 'iphone' || os === 'ipad') ? 'ios' : os,
                    version: supported[2].replace('_', '.')
                }
                break;
            }
        }

        return detected_os;
    }

})(Quo);