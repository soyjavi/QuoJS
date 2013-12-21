describe "Environment", ->

  it "know if device it's mobile or not", ->
    expect($$.isMobile()).not.toBeTruthy()


  it "get environment attributes", ->
    environment = $$.environment()
    expect(environment.browser?).toBeTruthy()
    expect(environment.os?).not.toEqual null
    expect(environment.screen?).toBeTruthy()
    expect(environment.isMobile?).toBeTruthy()
