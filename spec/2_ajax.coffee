describe "Ajax", ->

  url = "http://tapquo.com"

  it "can configure ajax settings", ->
    $$.ajaxSettings =
      async   : false
      timeout : 1000
    expect($$.ajaxSettings.async).toBeFalsy()
    expect($$.ajaxSettings.timeout).toEqual 1000


  it "can make a ajax request", ->
    spyOn $$, "ajax"
    $$.ajax
      url: url
    expect($$.ajax.mostRecentCall.args[0]["url"]).toEqual url


  it "should execute the success callback function", ->
    spyOn($$, "ajax").andCallFake (options) -> options.success()
    _success = jasmine.createSpy()
    _error = jasmine.createSpy()

    $$.ajax
      url     : "http:/asdad"
      success : _success
      error   : _error
    expect(_success).toHaveBeenCalled()
    expect(_error).not.toHaveBeenCalled()


  it "should execute the error callback function", ->
    spyOn($$, "ajax").andCallFake (options) -> options.error()
    _error = jasmine.createSpy()

    $$.ajax
      url   : url
      error : _error
    expect(_error).toHaveBeenCalled()


  it "can serialize parameters", ->
    parameters =
      format  : 'json'
      key     : '1980'
      page    : 0
      ordered : true
    serializedParameters = "format=json&key=1980&page=0&ordered=true"

    expect($$.serialize parameters).toEqual serializedParameters
