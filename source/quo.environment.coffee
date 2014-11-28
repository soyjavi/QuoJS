###
ENVIRONMENT Quo Module

@namespace Quo
@class Environment

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  _current = null
  IS_WEBKIT = /WebKit\/([\d.]+)/
  SUPPORTED_OS =
      Android   : /(Android)\s+([\d.]+)/
      ipad      : /(iPad).*OS\s([\d_]+)/
      iphone    : /(iPhone\sOS)\s([\d_]+)/
      Blackberry: /(BlackBerry|BB10|Playbook).*Version\/([\d.]+)/
      FirefoxOS : /(Mozilla).*Mobile[^\/]*\/([\d\.]*)/
      webOS     : /(webOS|hpwOS)[\s\/]([\d.]+)/


  ###
  Remove attribute to a given instance element
  @method isMobile
  @return {boolean} True if it's mobile, False if not.
  ###
  $$.isMobile = ->
    @environment()
    _current.isMobile


  ###
  Remove attribute to a given instance element
  @method environment
  @return {object} Environment attributes
  ###
  $$.environment = ->
    unless _current
      user_agent = navigator.userAgent
      os = _detectOS(user_agent)
      _current =
        browser : _detectBrowser(user_agent)
        isMobile: !!os
        screen  : _detectScreen()
        os      : os
    _current

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _detectBrowser = (user_agent) ->
    webkit = user_agent.match(IS_WEBKIT)
    if webkit then webkit[0] else user_agent

  _detectOS = (user_agent) ->
    for os of SUPPORTED_OS
      supported = user_agent.match SUPPORTED_OS[os]
      if supported
        detected_os =
          name    : if os in ["iphone", "ipad", "ipod"] then "ios" else os
          version : supported[2].replace("_", ".")
        break
    detected_os

  _detectScreen = ->
    width: window.innerWidth
    height: window.innerHeight
