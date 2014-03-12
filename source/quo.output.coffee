###
Basic Quo Module

@namespace Quo
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

do ($$ = Quo) ->

  ###
  Get/Set text to a given instance element
  @method text
  @param  {string} [OPTIONAL] Value of text
  ###
  $$.fn.text = (value) ->
    if value?
      @each -> @textContent = value
    else
      if @length > 0 then @[0].textContent else ""


  ###
  Get/Set html to a given instance element
  @method html
  @param  {variable} [OPTIONAL] Value of html
  ###
  $$.fn.html = (value) ->
    if value?
      type = $$.toType(value)
      @each ->
        if type is "string"
          @innerHTML = value
        else if type is "array"
          value.forEach (slice) => $$(@).html(slice)
        else
          @innerHTML += $$(value).html()
    else
      if @length > 0 then @[0].innerHTML else ""


  ###
  Remove the set of matched elements to a given instance element
  @method remove
  ###
  $$.fn.remove = ->
    @each -> @parentNode.removeChild this if @parentNode?


  ###
  Remove all child nodes of the set of matched elements to a given instance element
  @method remove
  ###
  $$.fn.empty = ->
    @each -> @innerHTML = null


  ###
  Append a html to a given instance element
  @method append
  @param  {html} Value of html
  ###
  $$.fn.append = (value) ->
    type = $$.toType(value)
    @each ->
      if type is "string"
        @insertAdjacentHTML "beforeend", value
      else if type is "array"
        value.forEach (slice) => $$(@).append(slice)
      else
        @appendChild value


  ###
  Prepend a html to a given instance element
  @method prepend
  @param  {html} Value of html
  ###
  $$.fn.prepend = (value) ->
    type = $$.toType(value)
    @each ->
      if type is "string"
        @insertAdjacentHTML "afterbegin", value
      else if type is "array"
        value.each (index, value) => @insertBefore value, @firstChild
      else
        @insertBefore value, @firstChild


  ###
  Replace each element in the set of matched elements with the provided new
  content and return the set of elements that was removed.
  @method replaceWith
  @param  {html} The content to insert (HTML string, DOMelement, array of DOMelements)
  ###
  $$.fn.replaceWith = (value) ->
    type = $$.toType(value)
    @each ->
      if @parentNode
        if type is "string"
          @insertAdjacentHTML "beforeBegin", value
        else if type is "array"
          value.each (index, value) => @parentNode.insertBefore value, @
        else
          @parentNode.insertBefore value, @
    @remove()
