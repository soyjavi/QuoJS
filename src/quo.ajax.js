/*
  QuoJS 1.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
*/

(function($$) {

    var DEFAULT = { TYPE: 'GET',  MIME: 'json' };
    var MIME_TYPES = {
        script: 'text/javascript, application/javascript',
        json:   'application/json',
        xml:    'application/xml, text/xml',
        html:   'text/html',
        text:   'text/plain'
    };
    var JSONP_ID = 0;

    /**
     * ?
     */
    $$.ajaxSettings = {
        type: DEFAULT.TYPE,
        async: true,
        success: {},
        error: {},
        context: null,
        dataType: DEFAULT.MIME,
        headers: {},
        xhr: function () {
            return new window.XMLHttpRequest();
        },
        crossDomain: false,
        timeout: 0
    };

    /**
     * ?
     */
    $$.ajax = function(options) {
        var settings = $$.mix($$.ajaxSettings, options);

        if (_isJsonP(settings.url)) return $$.jsonp(settings);

        var xhr = settings.xhr();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                clearTimeout(abortTimeout);
                _xhrStatus(xhr, settings);
            }
        }

        xhr.open(settings.type, settings.url, settings.async);

        _xhrHeaders(xhr, settings);

        if (settings.timeout > 0) {
            var abortTimeout = setTimeout(function() {
                _xhrTimeout(xhr, settings);
            }, settings.timeout);
        }

        xhr.send(settings.data);

        return (settings.async) ? xhr : _parseResponse(xhr, settings);
    };

    /**
     * ?
     */
    $$.jsonp = function(settings) {
        if (settings.async) {
            var callbackName = 'jsonp' + (++JSONP_ID);
            var script = document.createElement('script');
            var xhr = {
                abort: function() {
                    $$(script).remove();
                    if (callbackName in window) window[callbackName] = {};
                }
            };
            var abortTimeout;

            window[callbackName] = function(response) {
                clearTimeout(abortTimeout);
                $$(script).remove();
                delete window[callbackName];
                _xhrSuccess(response, xhr, settings);
            };

            script.src = settings.url.replace(/=\?/, '=' + callbackName);
            $$('head').append(script);

            if (settings.timeout > 0) {
                abortTimeout = setTimeout(function() {
                    _xhrTimeout(xhr, settings);
                }, settings.timeout);
            }

            return xhr;

        } else {
            console.error('ERROR: Unable to make jsonp synchronous call.')
        }
    };

    /**
     * ?
     */
    $$.get = function(url, data, success, dataType) {
        url += $$.serializeParameters(data);

        return $$.ajax({
            url: url,
            success: success,
            dataType: dataType
        });
    };

    /**
     * ?
     */
    $$.post = function(url, data, success, dataType) {
        return $$.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: success,
            dataType: dataType,
            contentType: 'application/x-www-form-urlencoded'
        });
    };

    /**
     * ?
     */
    $$.json = function(url, data, success) {
        url += $$.serializeParameters(data);

        return $$.ajax({
            url: url,
            success: success,
            dataType: DEFAULT.MIME
        });
    };

    /**
     * ?
     */
    $$.serializeParameters = function(parameters) {
        var serialize = '?';
        for (var parameter in parameters) {
            if (parameters.hasOwnProperty(parameter)) {
                if (serialize !== '?') serialize += '&';
                serialize += parameter + '=' + parameters[parameter];
            }
        }

        return (serialize === '?') ? '' : serialize;
    };

    function _xhrStatus(xhr, settings) {
        if (xhr.status === 200 || xhr.status === 0) {
            if (settings.async) {
                var response = _parseResponse(xhr, settings);
                _xhrSuccess(response, xhr, settings);
            }
        } else {
            _xhrError('QuoJS » $$.ajax', xhr, settings);
        }
    }

    function _xhrSuccess(response, xhr, settings) {
        settings.success.call(settings.context, response, xhr);
    }

    function _xhrError(type, xhr, settings) {
        settings.error.call(settings.context, type, xhr, settings);
    }

    function _xhrHeaders(xhr, settings) {
        if (settings.contentType) settings.headers['Content-Type'] = settings.contentType;
        if (settings.dataType) settings.headers['Accept'] = MIME_TYPES[settings.dataType];

        for (header in settings.headers) {
            xhr.setRequestHeader(header, settings.headers[header]);
        }
    }

    function _xhrTimeout(xhr, settings) {
        xhr.onreadystatechange = {};
        xhr.abort();
        _xhrError('QuoJS » $$.ajax : timeout exceeded', xhr, settings);
    }

    function _parseResponse(xhr, settings) {
        var response = xhr.responseText;

        if (response) {
            if (settings.dataType === DEFAULT.MIME) {
                try {
                    response = JSON.parse(response);
                }
                catch (error) {
                    response = error;
                    _xhrError('Parse Error', xhr, settings);
                }
            } else if (settings.dataType === 'xml') {
                response = xhr.responseXML;
            }
        }

        return response;
    }

    var _isJsonP = function(url) {
        return (/=\?/.test(url));
    }

})(Quo);