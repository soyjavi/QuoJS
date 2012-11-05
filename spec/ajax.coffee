describe "Ajax", ->
  # User = undefined

  beforeEach ->
    $$.ajaxSettings =
      async: true
      success: {}
      error: {}
      timeout: 0

  # it "ajax with parameters in line", ->
  #   $$.ajax
  #       url: "http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=3&minx=-180&miny=-90&maxx=180&maxy=90&size=medium&mapfilter=true",
  #       timeout: 1000
  #       success: (response) ->
  #         console.error response


