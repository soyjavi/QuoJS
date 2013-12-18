describe "Style", ->

  el = undefined

  beforeEach ->
    document.body.innerHTML = """<section class="quo"></section>"""
    el = $$ "section"


  it "add class to a given element", ->
    el.addClass "new"
    expect(el.hasClass("new")).toBeTruthy()


  it "remove class to a given element", ->
    el.removeClass "quo"
    expect(el.hasClass("quo")).not.toBeTruthy()


  it "toggle class to a given element", ->
    expect(el.hasClass("quo")).toBeTruthy()
    el.toggleClass "quo"
    expect(el.hasClass("quo")).not.toBeTruthy()


  it "test if class exists in a given element", ->
    expect(el.hasClass("quo")).toBeTruthy()


  it "returns a list of class styles", ->
    classList = '0': 'quo', length: 1
    expect(el.listClass()["0"]).toEqual classList["0"]
