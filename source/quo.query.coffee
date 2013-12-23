###
Basic Quo Module

@namespace Quo
@class Query

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

do ($$ = Quo) ->

  PARENT_NODE    = "parentNode"

  ###
  Get the descendants of each element in the current instance
  @method find
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $$.fn.find = (selector) ->
    if @length is 1
      result = Quo.query @[0], selector
    else
      result = @map -> Quo.query(@, selector)
    $$ result


  ###
  Get the parent of each element in the current instance
  @method parent
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $$.fn.parent = (selector) ->
    ancestors = if selector then _findAncestors(@) else @instance(PARENT_NODE)
    console.log "ancestors"
    _filtered ancestors, selector


  ###
  Get the children of each element in the current instance
  @method children
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $$.fn.children = (selector) ->
    elements = @map -> Array::slice.call @children
    _filtered elements, selector

  ###
  Retrieve the DOM elements matched by the QuoJS object.
  @method get
  @param  {number} [OPTIONAL] A zero-based integer indicating which element to retrieve
  ###
  $$.fn.get = (index) ->
    @[index] or null


  ###
  Reduce the set of matched elements to the first in the set.
  @method first
  ###
  $$.fn.first = ->
    $$ @[0]


  ###
  Reduce the set of matched elements to the final one in the set.
  @method last
  ###
  $$.fn.last = ->
    $$ @[@length - 1]


  $$.fn.instance = (property) ->
    @map -> @[property]

  $$.fn.map = (callback) ->
    $$.map @, (el, i) -> callback.call el, i, el

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _findAncestors = (nodes) ->
    ancestors = []
    while nodes.length > 0
      nodes = $$.map(nodes, (node) ->
        node = node.parentNode
        if node isnt document and ancestors.indexOf(node) < 0
          ancestors.push node
          node
      )
    ancestors

  _filtered = (nodes, selector) ->
    if selector? then $$(nodes).filter(selector) else $$(nodes)
