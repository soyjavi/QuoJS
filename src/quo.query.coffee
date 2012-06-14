###
  QuoJS 2.0
  (c) 2011, 2012 Javi Jiménez Villar (@soyjavi)
  http://quojs.tapquo.com
###

(($$) ->

    PARENT_NODE = "parentNode"

    $$.query = (domain, selector) ->
        dom_elements = document.querySelectorAll(selector)
        dom_elements = Array::slice.call(dom_elements)
        dom_elements

    $$.fn.find = (selector) ->
        result = undefined
        if @length is 1
            result = Quo.query(@[0], selector)
        else
            result = @map(-> Quo.query @, selector )
        $$ result

    $$.fn.parent = (selector) ->
        ancestors = (if (selector) then _findAncestors(@) else @instance(PARENT_NODE))
        _filtered ancestors, selector

    $$.fn.siblings = (selector) ->
        siblings_elements = @map((index, element) ->
            Array::slice.call(element.parentNode.children).filter (child) ->
                child isnt element
        )
        _filtered siblings_elements, selector

    $$.fn.children = (selector) ->
        children_elements = @map(->
            Array::slice.call @children
        )
        _filtered children_elements, selector

    $$.fn.get = (index) ->
        (if index is `undefined` then @ else @[index])

    $$.fn.first = -> $$ @[0]

    $$.fn.last = ->
        last_element_index = @length - 1
        $$ @[last_element_index]

    $$.fn.closest = (selector, context) ->
        node = @[0]
        candidates = $$(selector)
        node = null  unless candidates.length
        while node and candidates.indexOf(node) < 0
            node = node isnt context and node isnt document and node.parentNode
        $$ node

    $$.fn.each = (callback) ->
        @forEach (element, index) -> callback.call element, index, element
        @

    _findAncestors = (nodes) ->
        ancestors = []
        while nodes.length > 0
            nodes = $$.map(nodes, (node) ->
                if (node = node.parentNode) and node isnt document and ancestors.indexOf(node) < 0
                    ancestors.push node
                    node
            )
        ancestors

    _filtered = (nodes, selector) ->
        (if (selector is `undefined`) then $$(nodes) else $$(nodes).filter(selector))

    return
) Quo