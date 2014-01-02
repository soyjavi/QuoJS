###
Basic Quo Module

@namespace Quo
@class Ajax

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  DEFAULT =
    TYPE: "GET"
    MIME: "json"

  MIME_TYPES =
    script: "text/javascript, application/javascript"
    json  : "application/json"
    xml   : "application/xml, text/xml"
    html  : "text/html"
    text  : "text/plain"

  JSONP_ID = 0
  $$.ajaxSettings =
    type        : DEFAULT.TYPE
    async       : true
    success     : {}
    error       : {}
    context     : null
    dataType    : DEFAULT.MIME
    headers     : {}
    xhr         : -> new window.XMLHttpRequest()
    crossDomain : false
    timeout     : 0

  ###
  Perform an asynchronous HTTP (Ajax) request.
  @method ajax
  @param  {object} A set of key/value pairs that configure the Ajax request
  ###
  $$.ajax = (options) ->
    settings = $$.mix($$.ajaxSettings, options)

    if settings.type is DEFAULT.TYPE
      settings.url += $$.serialize(settings.data, "?")
    else
      settings.data = $$.serialize(settings.data)

    return _jsonp(settings) if _isJsonP(settings.url)

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
    xhr


  ###
  Load data from the server using a HTTP GET request.
  @method get
  @param  {string} A string containing the URL to which the request is sent.
  @param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
  @param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
  @param  {string} [OPTIONAL] The type of data expected from the server
  ###
  $$.get = (url, data, success, dataType) ->
    $$.ajax
      url     : url
      data    : data
      success : success
      dataType: dataType


  ###
  Load data from the server using a HTTP POST request.
  @method post
  @param  {string} A string containing the URL to which the request is sent.
  @param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
  @param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
  @param  {string} [OPTIONAL] The type of data expected from the server
  ###
  $$.post = (url, data, success, dataType) ->
    _xhrForm("POST", url, data, success, dataType)


  ###
  Load data from the server using a HTTP PPUTOST request.
  @method put
  @param  {string} A string containing the URL to which the request is sent.
  @param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
  @param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
  @param  {string} [OPTIONAL] The type of data expected from the server
  ###
  $$.put = (url, data, success, dataType) ->
    _xhrForm("PUT", url, data, success, dataType)


  ###
  Load data from the server using a HTTP DELETE request.
  @method delete
  @param  {string} A string containing the URL to which the request is sent.
  @param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
  @param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
  @param  {string} [OPTIONAL] The type of data expected from the server
  ###
  $$.delete = (url, data, success, dataType) ->
    _xhrForm("DELETE", url, data, success, dataType)


  ###
  Load JSON-encoded data from the server using a GET HTTP request.
  @method json
  @param  {string} A string containing the URL to which the request is sent.
  @param  {string} [OPTIONAL] A plain object or string that is sent to the server with the request.
  @param  {string} [OPTIONAL] A callback function that is executed if the request succeeds.
  ###
  $$.json = (url, data, success) ->
    $$.ajax
      url: url
      data: data
      success: success


  ###
  Encode a set of form elements as a string for submission.
  @method serialize
  @param  {object}
  ###
  $$.serialize = (parameters, character="") ->
    serialize = character
    for parameter of parameters
      if parameters.hasOwnProperty(parameter)
        serialize += "&" if serialize isnt character
        serialize += "#{encodeURIComponent parameter}=#{encodeURIComponent parameters[parameter]}"
    (if (serialize is character) then "" else serialize)

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _jsonp = (settings) ->
    if settings.async
      callbackName = "jsonp" + (++JSONP_ID)
      script = document.createElement("script")
      xhr = abort: ->
        $$(script).remove()
        window[callbackName] = {} if callbackName of window

      abortTimeout = undefined
      window[callbackName] = (response) ->
        clearTimeout abortTimeout
        $$(script).remove()
        delete window[callbackName]

        _xhrSuccess response, settings

      script.src = settings.url.replace(RegExp("=\\?"), "=" + callbackName)
      $$("head").append script
      if settings.timeout > 0
        abortTimeout = setTimeout((-> _xhrTimeout xhr, settings), settings.timeout)
      xhr
    else
      console.error "QuoJS.ajax: Unable to make jsonp synchronous call."


  _xhrStatus = (xhr, settings) ->
    if (xhr.status >= 200 and xhr.status < 300) or xhr.status is 0
      if settings.async
        _xhrSuccess xhr, settings
        return
    else
      _xhrError "QuoJS.ajax: Unsuccesful request", xhr, settings
      return

  _xhrSuccess = (xhr, settings) ->
    settings.success.call settings.context, xhr
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
      type        : method
      url         : url
      data        : data
      success     : success
      dataType    : dataType
      contentType : "application/x-www-form-urlencoded"

  _isJsonP = (url) ->
    RegExp("=\\?").test url
