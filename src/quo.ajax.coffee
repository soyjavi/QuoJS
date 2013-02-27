do ($$ = Quo) ->

    DEFAULT =
        TYPE: "GET"
        MIME: "json"

    MIME_TYPES =
        script: "text/javascript, application/javascript"
        json: "application/json"
        xml: "application/xml, text/xml"
        html: "text/html"
        text: "text/plain"

    JSONP_ID = 0
    $$.ajaxSettings =
        type: DEFAULT.TYPE
        async: true
        success: {}
        error: {}
        context: null
        dataType: DEFAULT.MIME
        headers: {}
        xhr: -> new window.XMLHttpRequest()
        crossDomain: false
        timeout: 0

    $$.ajax = (options) ->
        settings = $$.mix($$.ajaxSettings, options)

        if settings.type is DEFAULT.TYPE
            settings.url += $$.serializeParameters(settings.data, "?")
        else
            settings.data = $$.serializeParameters(settings.data)

        return $$.jsonp(settings) if _isJsonP(settings.url)

        xhr = settings.xhr()
        xhr.onreadystatechange = ->
            if xhr.readyState is 4
                clearTimeout abortTimeout
                _xhrStatus xhr, settings

        xhr.open settings.type, settings.url, settings.async
        _xhrHeaders xhr, settings

        if settings.timeout > 0
            abortTimeout = setTimeout((-> _xhrTimeout xhr, settings ), settings.timeout)

        try
            xhr.send settings.data
        catch error
            xhr = error
            _xhrError "Resource not found", xhr, settings

        (if (settings.async) then xhr else _parseResponse(xhr, settings))

    $$.jsonp = (settings) ->
        if settings.async
            callbackName = "jsonp" + (++JSONP_ID)
            script = document.createElement("script")
            xhr = abort: ->
                $$(script).remove()
                window[callbackName] = {}    if callbackName of window

            abortTimeout = undefined
            window[callbackName] = (response) ->
                clearTimeout abortTimeout
                $$(script).remove()
                delete window[callbackName]

                _xhrSuccess response, xhr, settings

            script.src = settings.url.replace(RegExp("=\\?"), "=" + callbackName)
            $$("head").append script
            if settings.timeout > 0
                abortTimeout = setTimeout((-> _xhrTimeout xhr, settings), settings.timeout)
            xhr
        else
            console.error "QuoJS.ajax: Unable to make jsonp synchronous call."

    $$.get = (url, data, success, dataType) ->
        $$.ajax
            url: url
            data: data
            success: success
            dataType: dataType

    $$.post = (url, data, success, dataType) ->
        _xhrForm("POST", url, data, success, dataType)

    $$.put = (url, data, success, dataType) ->
        _xhrForm("PUT", url, data, success, dataType)

    $$.delete = (url, data, success, dataType) ->
        _xhrForm("DELETE", url, data, success, dataType)

    $$.json = (url, data, success) ->
        $$.ajax
            url: url
            data: data
            success: success
            dataType: DEFAULT.MIME

    $$.serializeParameters = (parameters, character="") ->
        serialize = character
        for parameter of parameters
            if parameters.hasOwnProperty(parameter)
                serialize += "&" if serialize isnt character
                serialize += "#{encodeURIComponent parameter}=#{encodeURIComponent parameters[parameter]}"
        (if (serialize is character) then "" else serialize)

    _xhrStatus = (xhr, settings) ->
        if (xhr.status >= 200 and xhr.status < 300) or xhr.status is 0
            if settings.async
                _xhrSuccess _parseResponse(xhr, settings), xhr, settings
                return
        else
            _xhrError "QuoJS.ajax: Unsuccesful request", xhr, settings
            return

    _xhrSuccess = (response, xhr, settings) ->
        settings.success.call settings.context, response, xhr
        return

    _xhrError = (type, xhr, settings) ->
        settings.error.call settings.context, type, xhr, settings
        return

    _xhrHeaders = (xhr, settings) ->
        settings.headers["Content-Type"] = settings.contentType if settings.contentType
        settings.headers["Accept"] = MIME_TYPES[settings.dataType] if settings.dataType
        for header of settings.headers
            xhr.setRequestHeader header, settings.headers[header]
        return

    _xhrTimeout = (xhr, settings) ->
        xhr.onreadystatechange = {}
        xhr.abort()
        _xhrError "QuoJS.ajax: Timeout exceeded", xhr, settings
        return

    _xhrForm = (method, url, data, success, dataType) ->
        $$.ajax
            type: method
            url: url
            data: data
            success: success
            dataType: dataType
            contentType: "application/x-www-form-urlencoded"

    _parseResponse = (xhr, settings) ->
        response = xhr.responseText
        if response
            if settings.dataType is DEFAULT.MIME
                try
                    response = JSON.parse(response)
                catch error
                    response = error
                    _xhrError "QuoJS.ajax: Parse Error", xhr, settings
            else response = xhr.responseXML    if settings.dataType is "xml"
        response

    _isJsonP = (url) ->
        RegExp("=\\?").test url
