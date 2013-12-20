###
Basic Quo Module

@namespace Quo
@class css

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  ###
  Get/Set attribute to a given instance element
  @method attr
  @param  {string} Name of attribute
  @param  {string} [OPTIONAL] Value of atribbute
  ###
  $$.fn.attr = (name, value) ->
    if @length > 0 and $$.toType(name) is "string"
      if value
        @each -> @setAttribute name, value
      else
        @[0].getAttribute name


  ###
  Remove attribute to a given instance element
  @method removeAttr
  @param  {string} Name of attribute
  ###
  $$.fn.removeAttr = (name) ->
    @each -> @removeAttribute name


  ###
  Get/Set data attribute to a given instance element
  @method data
  @param  {string} Name of data attribute
  @param  {string} [OPTIONAL] Value of data atribbute
  ###
  $$.fn.data = (name, value) ->
    @attr "data-#{name}", value


  ###
  Remove data attribute to a given instance element
  @method removeAttr
  @param  {string} Name of data attribute
  ###
  $$.fn.removeData = (name) ->
    @removeAttr "data-#{name}"
