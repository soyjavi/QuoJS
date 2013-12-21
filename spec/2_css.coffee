describe "CSS", ->

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


  it "set a stylesheet property in a given element", ->
    color = "blue"
    el.style "background-color", color
    expect(el.style("background-color")).toEqual color
    font = "10px"
    el.css "font-size", font
    expect(el.style("font-size")).toEqual font


  it "set a stylesheet vendor-prefix property in a given element", ->
    value = "black 1em 1em"
    el.vendor "box-shadow", value
    expect(el.style("-webkit-box-shadow")).toEqual value

