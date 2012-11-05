describe "Ajax", ->
  # User = undefined
  service_url = undefined

  beforeEach ->
    service_url = "http://quonasrv.appspot.com/api/"

  it "can configure ajax settings", ->
    $$.ajaxSettings =
      async: false
      success: {}
      error: {}
      timeout: 0
    expect($$.ajaxSettings.async).toBeFalsy()

  it "can call ajax", ->
    spyOn $$, "ajax"
    $$.ajax url: "#{service_url}user/login"
    expect($$.ajax.mostRecentCall.args[0]["url"]).toEqual "#{service_url}user/login"

  it "should execute the callback function on success", ->
    spyOn($$, "ajax").andCallFake (options) -> options.success()
    _callback = jasmine.createSpy()

    $$.ajax
      url: "#{service_url}"
      success: _callback

    expect(_callback).toHaveBeenCalled();


  # it "should make a real AJAX request", ->
  #   expect(false).toBeTruthy()

  # it "can call ajax", ->
  #   expect(false).toBeTruthy()


  # it "can call ajax (sync mode)", ->
  #   expect(false).toBeTruthy()


  # it "can call get", ->
  #   expect(false).toBeTruthy()


  # it "can call post", ->
  #   spyOn($$, "ajax").andCallFake (options) -> options.success()
  #   _callback = jasmine.createSpy()

  #   $$.ajax
  #     url: "#{service_url}user/login"
  #     type: "POST"
  #     data:
  #       app_key:"agpzfnF1b25hc3J2chkLEgtBcHBsaWNhdGlvbiIIZGlhYmV0ZXMM"
  #       mail:"demo@tapquo.com"
  #       password:"tapquo"
  #     success: _callback
  #     error: (error) -> console.error arguments

  #   expect(_callback).toHaveBeenCalled();

    # waitsFor( -> _callback.callCount > 0 )
    # runs( -> expect(callback).toHaveBeenCalled() );

  # it "can call put", ->
  #   expect(false).toBeTruthy()


  # it "can call delete", ->
  #   expect(false).toBeTruthy()


  # it "can call json", ->
  #   expect(false).toBeTruthy()


  # it "can load XML", ->
  #   $$.ajaxSettings.dataType = 'xml'


  it "can serialize parameters", ->
    parameters =
      format: 'json'
      key: '1980'
      page: 0
      ordered: true
    serializedParameters = "format=json&key=1980&page=0&ordered=true"

    expect($$.serializeParameters parameters).toBe serializedParameters


