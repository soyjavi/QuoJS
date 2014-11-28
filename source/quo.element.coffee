###
ELEMENT Quo Module

@namespace Quo
@class Element

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


do ($$ = Quo) ->

  ###
  Get/Set attribute to a given instance element
  @method attr
  @param  {string} Name of attribute
  @param  {string} [OPTIONAL] Value of attribute
  ###
  $$.fn.attr = (name, value) ->
    if @length > 0 and $$.toType(name) is "string"
      if value?
        @each -> @setAttribute name, value
      else
        @[0].getAttribute name


  ###
  Remove attribute to a given instance element
  @method removeAttr
  @param  {string} Name of attribute
  ###
  $$.fn.removeAttr = (name) ->
    if @length > 0 and $$.toType(name) is "string"
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


  ###
  Remove data attribute to a given instance element
  @method val
  @param  {string} Name of data attribute
  ###
  $$.fn.val = (value) ->
    if value?
      @each -> @value = value.toString()
    else
      if @length > 0 then @[0].value else null


  ###
  Shows a given instance element
  @method show
  ###
  $$.fn.show = ->
    @style "display", "block"


  ###
  Hides a given instance element
  @method hide
  ###
  $$.fn.hide = ->
    @style "display", "none"

  ###
  Trigger that event on an element
  @method focus
  ###
  $$.fn.focus = ->
    do @[0].focus

  ###
  Trigger that event on an element
  @method blur
  ###
  $$.fn.blur = ->
    do @[0].blur

  ###
  Get a offset of a given instance element
  @method offset
  ###
  $$.fn.offset = ->
    if @length > 0
      bounding = @[0].getBoundingClientRect()
      offset =
        left  : bounding.left + window.pageXOffset
        top   : bounding.top + window.pageYOffset
        width : bounding.width
        height: bounding.height
    offset
