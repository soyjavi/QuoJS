"use strict"

$$ ->
  $$("[data-device] > *").on "touchstart", (event) ->
    $$(event.target)
      .addClass "touch"
      .children("abbr").html ""

  $$("[data-device] > *").swiping (event) ->
    $$ event.target
      .attr "style", "left: #{event.touch.delta.x}px; top: #{event.touch.delta.y}px;"
      .children("abbr").html "swipping"

  $$("[data-device] > *").rotating (event) ->
    console.log event
    # $$ event.target
    #   .attr "style", "left: #{event.touch.delta.x}px; top: #{event.touch.delta.y}px;"

  $$("[data-device] > *").on "touchend", (event) -> refresh event

  # $$("[data-device] > *").on "touchcancel", (event) -> refresh event

  refresh = (event) ->
    $$(event.target)
      .removeClass "touch"
      .attr "style", "left: 0px; top: 0px;"
      .children("abbr").html ""
