do ($$ = Quo) ->

    _current = null
    IS_WEBKIT = /WebKit\/([\d.]+)/
    SUPPORTED_OS =
        Android: /(Android)\s+([\d.]+)/
        ipad: /(iPad).*OS\s([\d_]+)/
        iphone: /(iPhone\sOS)\s([\d_]+)/
        Blackberry: /(BlackBerry|BB10|Playbook).*Version\/([\d.]+)/
        FirefoxOS: /(Mozilla).*Mobile[^\/]*\/([\d\.]*)/
        webOS: /(webOS|hpwOS)[\s\/]([\d.]+)/

    $$.isMobile = ->
        _current = _current or _detectEnvironment()
        #@todo: nowadays FirefoxOS Simulator detects MouseEvents
        _current.isMobile and _current.os.name isnt "firefoxOS"

    $$.environment = ->
        _current = _current or _detectEnvironment()
        _current

    $$.isOnline = ->
        navigator.onLine

    _detectEnvironment = ->
        user_agent = navigator.userAgent
        environment = {}
        environment.browser = _detectBrowser(user_agent)
        environment.os = _detectOS(user_agent)
        environment.isMobile = !!environment.os
        environment.screen = _detectScreen()
        environment

    _detectBrowser = (user_agent) ->
        is_webkit = user_agent.match(IS_WEBKIT)
        if is_webkit then is_webkit[0] else user_agent

    _detectOS = (user_agent) ->
        detected_os = null
        for os of SUPPORTED_OS
            supported = user_agent.match(SUPPORTED_OS[os])
            if supported
                detected_os =
                    name: (if (os is "iphone" or os is "ipad") then "ios" else os)
                    version: supported[2].replace("_", ".")
                break
        detected_os

    _detectScreen = ->
        width: window.innerWidth
        height: window.innerHeight
